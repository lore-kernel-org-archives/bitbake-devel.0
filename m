Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8065B780F3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jul 2017 21:37:08 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6ILb6wP012348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 18 Jul 2017 22:37:07 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dXaB0-0006TL-Lb; Tue, 18 Jul 2017 22:37:06 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jul 2017 22:36:59 +0100
Message-Id: <1500413820-24816-5-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 18 Jul 2017 22:37:07 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 24 Jul 2017 13:48:57 +0000
Subject: [PATCH 5/6] server: Rework the server API so process and xmlrpc servers coexist
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Jul 2017 21:37:10 -0000

This changes the way bitbake server works quite radically. Now, the
server is always a process based server with the option of starting
an XMLRPC listener on a specific inferface/port.

Behind the scenes this is done with a "bitbake.sock" file alongside
the bitbake.lock file. If we can obtain the lock, we know we need
to start a server. The server always listens on the socket and UIs
can then connect to this. UIs connect by sending a set of three file
descriptors over the domain socket, one for sending commands, one for
receiving command results and the other for receiving events.

These changes meant we can throw away all the horrid server abstraction
code, the plugable transport option to bitbake and the code becomes
much more readable and debuggable. It also likely removes a ton of
ways you could hang the UI/cooker in weird ways due to all the race
conditions that existed with previous processes.

Changes:

 * The foreground option for bitbake-server was dropped. Just tail
   the log if you really want this, the codepaths were complicated enough
   without adding one for this.
 * BBSERVER="autodetect" was dropped. The server will autostart and
   autoconnect in process mode. You have to specify an xmlrpc server
   address since that can't be autodetected. I can't see a use case
   for autodetect now.
 * The transport/servetype option to bitbake was dropped.
 * A BB_SERVER_TIMEOUT variable is added which allows the server
   to stay resident for a period of time after the last client
   disconnects before unloading. This is used if the -T/--idle-timeout
   option is not passed to bitbake.

This change is invasive and may well introduce new issues however I
believe the codebase is in a much better position for further
development and debugging.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py              |  58 +----
 lib/bb/cookerdata.py          |   5 +-
 lib/bb/main.py                | 224 +++++-----------
 lib/bb/server/__init__.py     |   6 -
 lib/bb/server/process.py      | 592 +++++++++++++++++++++++++++---------------
 lib/bb/server/process.py.orig | 323 +++++++++++++++++++++++
 lib/bb/server/xmlrpc.py       | 492 -----------------------------------
 lib/bb/server/xmlrpcclient.py | 154 +++++++++++
 lib/bb/server/xmlrpcserver.py | 158 +++++++++++
 lib/bb/tinfoil.py             |   2 +-
 lib/prserv/serv.py            |   4 +-
 11 files changed, 1102 insertions(+), 916 deletions(-)
 create mode 100644 lib/bb/server/process.py.orig
 delete mode 100644 lib/bb/server/xmlrpc.py
 create mode 100644 lib/bb/server/xmlrpcclient.py
 create mode 100644 lib/bb/server/xmlrpcserver.py

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index dc8f54c..313090b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -215,19 +215,6 @@ class BBCooker:
 
         self.configuration.server_register_idlecallback(_process_inotify_updates, [self.confignotifier, self.notifier])
 
-        # Take a lock so only one copy of bitbake can run against a given build
-        # directory at a time
-        if not self.lockBitbake():
-            bb.fatal("Only one copy of bitbake should be run against a build directory")
-        try:
-            self.lock.seek(0)
-            self.lock.truncate()
-            if len(configuration.interface) >= 2:
-                self.lock.write("%s:%s\n" % (configuration.interface[0], configuration.interface[1]));
-            self.lock.flush()
-        except:
-            pass
-
         # TOSTOP must not be set or our children will hang when they output
         try:
             fd = sys.stdout.fileno()
@@ -1557,33 +1544,6 @@ class BBCooker:
     def post_serve(self):
         prserv.serv.auto_shutdown(self.data)
         bb.event.fire(CookerExit(), self.data)
-        lockfile = self.lock.name
-        self.lock.close()
-        self.lock = None
-
-        while not self.lock:
-            with bb.utils.timeout(3):
-                self.lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=True)
-                if not self.lock:
-                    # Some systems may not have lsof available
-                    procs = None
-                    try:
-                        procs = subprocess.check_output(["lsof", '-w', lockfile], stderr=subprocess.STDOUT)
-                    except OSError as e:
-                        if e.errno != errno.ENOENT:
-                            raise
-                    if procs is None:
-                        # Fall back to fuser if lsof is unavailable
-                        try:
-                            procs = subprocess.check_output(["fuser", '-v', lockfile], stderr=subprocess.STDOUT)
-                        except OSError as e:
-                            if e.errno != errno.ENOENT:
-                                raise
-
-                    msg = "Delaying shutdown due to active processes which appear to be holding bitbake.lock"
-                    if procs:
-                        msg += ":\n%s" % str(procs)
-                    print(msg)
 
 
     def shutdown(self, force = False):
@@ -1605,23 +1565,7 @@ class BBCooker:
 
     def clientComplete(self):
         """Called when the client is done using the server"""
-        if self.configuration.server_only:
-            self.finishcommand()
-        else:
-            self.shutdown(True)
-
-    def lockBitbake(self):
-        if not hasattr(self, 'lock'):
-            self.lock = None
-            if self.data:
-                lockfile = self.data.expand("${TOPDIR}/bitbake.lock")
-                if lockfile:
-                    self.lock = bb.utils.lockfile(lockfile, False, False)
-        return self.lock
-
-    def unlockBitbake(self):
-        if hasattr(self, 'lock') and self.lock:
-            bb.utils.unlockfile(self.lock)
+        self.finishcommand()
 
 def server_main(cooker, func, *args):
     cooker.pre_serve()
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index aa0a641..9d1d3d2 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -76,7 +76,7 @@ class ConfigParameters(object):
         for o in ["abort", "tryaltconfigs", "force", "invalidate_stamp", 
                   "verbose", "debug", "dry_run", "dump_signatures", 
                   "debug_domains", "extra_assume_provided", "profile",
-                  "prefile", "postfile", "tracking"]:
+                  "prefile", "postfile", "tracking", "server_timeout"]:
             options[o] = getattr(self.options, o)
 
         ret, error = server.runCommand(["updateConfig", options, environment, sys.argv])
@@ -144,7 +144,8 @@ class CookerConfiguration(object):
         self.dump_signatures = []
         self.dry_run = False
         self.tracking = False
-        self.interface = []
+        self.xmlrpcinterface = []
+        self.server_timeout = None
         self.writeeventlog = False
         self.server_only = False
         self.limited_deps = False
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 29e3911..8033519 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -28,6 +28,8 @@ import logging
 import optparse
 import warnings
 import fcntl
+import time
+import traceback
 
 import bb
 from bb import event
@@ -37,6 +39,9 @@ from bb import ui
 from bb import server
 from bb import cookerdata
 
+import bb.server.process
+import bb.server.xmlrpcclient
+
 logger = logging.getLogger("BitBake")
 
 class BBMainException(Exception):
@@ -58,9 +63,6 @@ class BitbakeHelpFormatter(optparse.IndentedHelpFormatter):
         if option.dest == 'ui':
             valid_uis = list_extension_modules(bb.ui, 'main')
             option.help = option.help.replace('@CHOICES@', present_options(valid_uis))
-        elif option.dest == 'servertype':
-            valid_server_types = list_extension_modules(bb.server, 'BitBakeServer')
-            option.help = option.help.replace('@CHOICES@', present_options(valid_server_types))
 
         return optparse.IndentedHelpFormatter.format_option(self, option)
 
@@ -238,11 +240,6 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           default=os.environ.get('BITBAKE_UI', 'knotty'),
                           help="The user interface to use (@CHOICES@ - default %default).")
 
-        # @CHOICES@ is substituted out by BitbakeHelpFormatter above
-        parser.add_option("-t", "--servertype", action="store", dest="servertype",
-                          default=["process", "xmlrpc"]["BBSERVER" in os.environ],
-                          help="Choose which server type to use (@CHOICES@ - default %default).")
-
         parser.add_option("", "--token", action="store", dest="xmlrpctoken",
                           default=os.environ.get("BBTOKEN"),
                           help="Specify the connection token to be used when connecting "
@@ -258,14 +255,11 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="Run bitbake without a UI, only starting a server "
                                "(cooker) process.")
 
-        parser.add_option("", "--foreground", action="store_true",
-                          help="Run bitbake server in foreground.")
-
         parser.add_option("-B", "--bind", action="store", dest="bind", default=False,
-                          help="The name/address for the bitbake server to bind to.")
+                          help="The name/address for the bitbake xmlrpc server to bind to.")
 
-        parser.add_option("-T", "--idle-timeout", type=int,
-                          default=int(os.environ.get("BBTIMEOUT", "0")),
+        parser.add_option("-T", "--idle-timeout", type=float, dest="server_timeout",
+                          default=float(os.environ.get("BB_SERVER_TIMEOUT", 0)) or None,
                           help="Set timeout to unload bitbake server due to inactivity")
 
         parser.add_option("", "--no-setscene", action="store_true",
@@ -283,7 +277,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
         parser.add_option("-m", "--kill-server", action="store_true",
                           dest="kill_server", default=False,
-                          help="Terminate the remote server.")
+                          help="Terminate the bitbake server.")
 
         parser.add_option("", "--observe-only", action="store_true",
                           dest="observe_only", default=False,
@@ -322,70 +316,20 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
             eventlog = "bitbake_eventlog_%s.json" % datetime.now().strftime("%Y%m%d%H%M%S")
             options.writeeventlog = eventlog
 
-        # if BBSERVER says to autodetect, let's do that
-        if options.remote_server:
-            port = -1
-            if options.remote_server != 'autostart':
-                host, port = options.remote_server.split(":", 2)
+        if options.bind:
+            try:
+                #Checking that the port is a number and is a ':' delimited value
+                (host, port) = options.bind.split(':')
                 port = int(port)
-            # use automatic port if port set to -1, means read it from
-            # the bitbake.lock file; this is a bit tricky, but we always expect
-            # to be in the base of the build directory if we need to have a
-            # chance to start the server later, anyway
-            if port == -1:
-                lock_location = "./bitbake.lock"
-                # we try to read the address at all times; if the server is not started,
-                # we'll try to start it after the first connect fails, below
-                try:
-                    lf = open(lock_location, 'r')
-                    remotedef = lf.readline()
-                    [host, port] = remotedef.split(":")
-                    port = int(port)
-                    lf.close()
-                    options.remote_server = remotedef
-                except Exception as e:
-                    if options.remote_server != 'autostart':
-                        raise BBMainException("Failed to read bitbake.lock (%s), invalid port" % str(e))
+            except (ValueError,IndexError):
+                raise BBMainException("FATAL: Malformed host:port bind parameter")
+            options.xmlrpcinterface = (host, port)
+        else:
+            options.xmlrpcinterface = (None, 0)
 
         return options, targets[1:]
 
 
-def start_server(servermodule, configParams, configuration, features):
-    server = servermodule.BitBakeServer()
-    single_use = not configParams.server_only and os.getenv('BBSERVER') != 'autostart'
-    if configParams.bind:
-        (host, port) = configParams.bind.split(':')
-        server.initServer((host, int(port)), single_use=single_use,
-                          idle_timeout=configParams.idle_timeout)
-        configuration.interface = [server.serverImpl.host, server.serverImpl.port]
-    else:
-        server.initServer(single_use=single_use)
-        configuration.interface = []
-
-    try:
-        configuration.setServerRegIdleCallback(server.getServerIdleCB())
-
-        cooker = bb.cooker.BBCooker(configuration, features)
-
-        server.addcooker(cooker)
-        server.saveConnectionDetails()
-    except Exception as e:
-        while hasattr(server, "event_queue"):
-            import queue
-            try:
-                event = server.event_queue.get(block=False)
-            except (queue.Empty, IOError):
-                break
-            if isinstance(event, logging.LogRecord):
-                logger.handle(event)
-        raise
-    if not configParams.foreground:
-        server.detach()
-        cooker.shutdown()
-    cooker.lock.close()
-    return server
-
-
 def bitbake_main(configParams, configuration):
 
     # Python multiprocessing requires /dev/shm on Linux
@@ -406,45 +350,15 @@ def bitbake_main(configParams, configuration):
 
     configuration.setConfigParameters(configParams)
 
-    if configParams.server_only:
-        if configParams.servertype != "xmlrpc":
-            raise BBMainException("FATAL: If '--server-only' is defined, we must set the "
-                                  "servertype as 'xmlrpc'.\n")
-        if not configParams.bind:
-            raise BBMainException("FATAL: The '--server-only' option requires a name/address "
-                                  "to bind to with the -B option.\n")
-        else:
-            try:
-                #Checking that the port is a number
-                int(configParams.bind.split(":")[1])
-            except (ValueError,IndexError):
-                raise BBMainException(
-                        "FATAL: Malformed host:port bind parameter")
-        if configParams.remote_server:
+    if configParams.server_only and configParams.remote_server:
             raise BBMainException("FATAL: The '--server-only' option conflicts with %s.\n" %
                                   ("the BBSERVER environment variable" if "BBSERVER" in os.environ \
                                    else "the '--remote-server' option"))
 
-    elif configParams.foreground:
-        raise BBMainException("FATAL: The '--foreground' option can only be used "
-                              "with --server-only.\n")
-
-    if configParams.bind and configParams.servertype != "xmlrpc":
-        raise BBMainException("FATAL: If '-B' or '--bind' is defined, we must "
-                              "set the servertype as 'xmlrpc'.\n")
-
-    if configParams.remote_server and configParams.servertype != "xmlrpc":
-        raise BBMainException("FATAL: If '--remote-server' is defined, we must "
-                              "set the servertype as 'xmlrpc'.\n")
-
     if configParams.observe_only and (not configParams.remote_server or configParams.bind):
         raise BBMainException("FATAL: '--observe-only' can only be used by UI clients "
                               "connecting to a server.\n")
 
-    if configParams.kill_server and not configParams.remote_server:
-        raise BBMainException("FATAL: '--kill-server' can only be used to "
-                              "terminate a remote server")
-
     if "BBDEBUG" in os.environ:
         level = int(os.environ["BBDEBUG"])
         if level > configuration.debug:
@@ -453,7 +367,7 @@ def bitbake_main(configParams, configuration):
     bb.msg.init_msgconfig(configParams.verbose, configuration.debug,
                           configuration.debug_domains)
 
-    server, server_connection, ui_module = setup_bitbake(configParams, configuration)
+    server_connection, ui_module = setup_bitbake(configParams, configuration)
     if server_connection is None and configParams.kill_server:
         return 0
 
@@ -463,16 +377,15 @@ def bitbake_main(configParams, configuration):
             return 0
 
         try:
+            for event in bb.event.ui_queue:
+                server_connection.events.queue_event(event)
+            bb.event.ui_queue = []
+
             return ui_module.main(server_connection.connection, server_connection.events,
                                   configParams)
         finally:
-            bb.event.ui_queue = []
             server_connection.terminate()
     else:
-        print("Bitbake server address: %s, server port: %s" % (server.serverImpl.host,
-                                                               server.serverImpl.port))
-        if configParams.foreground:
-            server.serverImpl.serve_forever()
         return 0
 
     return 1
@@ -495,58 +408,63 @@ def setup_bitbake(configParams, configuration, extrafeatures=None, setup_logging
         # Collect the feature set for the UI
         featureset = getattr(ui_module, "featureSet", [])
 
-    if configParams.server_only:
-        for param in ('prefile', 'postfile'):
-            value = getattr(configParams, param)
-            if value:
-                setattr(configuration, "%s_server" % param, value)
-                param = "%s_server" % param
-
     if extrafeatures:
         for feature in extrafeatures:
             if not feature in featureset:
                 featureset.append(feature)
 
-    servermodule = import_extension_module(bb.server,
-                                            configParams.servertype,
-                                            'BitBakeServer')
+    server_connection = None
+
     if configParams.remote_server:
-        if os.getenv('BBSERVER') == 'autostart':
-            if configParams.remote_server == 'autostart' or \
-               not servermodule.check_connection(configParams.remote_server, timeout=2):
-                configParams.bind = 'localhost:0'
-                srv = start_server(servermodule, configParams, configuration, featureset)
-                configParams.remote_server = '%s:%d' % tuple(configuration.interface)
-                bb.event.ui_queue = []
-        # we start a stub server that is actually a XMLRPClient that connects to a real server
-        from bb.server.xmlrpc import BitBakeXMLRPCClient
-        server = servermodule.BitBakeXMLRPCClient(configParams.observe_only,
-                                                  configParams.xmlrpctoken)
-        server.saveConnectionDetails(configParams.remote_server)
+        # Connect to a remote XMLRPC server
+        server_connection = bb.server.xmlrpcclient.connectXMLRPC(configParams.remote_server, featureset,
+                                                                 configParams.observe_only, configParams.xmlrpctoken)
     else:
-        # we start a server with a given configuration
-        server = start_server(servermodule, configParams, configuration, featureset)
+        retries = 8
+        while retries:
+            try:
+                topdir, lock = lockBitbake()
+                sockname = topdir + "/bitbake.sock"
+                if lock:
+                    # we start a server with a given configuration
+                    print("Starting bitbake server...")
+                    server = bb.server.process.BitBakeServer(lock, sockname, configuration, featureset)
+                else:
+                    print("Reconnecting to bitbake server...")
+                    if not os.path.exists(sockname):
+                        print("Previous bitbake instance shutting down?, waiting to retry...")
+                        time.sleep(5)
+                        raise bb.server.process.ProcessTimeout
+                if not configParams.server_only:
+                    server_connection = bb.server.process.connectProcessServer(sockname, featureset)
+                if server_connection:
+                    break
+            except Exception as e:
+                if not retries:
+                    raise
+                retries -= 1
+                print("Retrying server connection... (%s)" % traceback.format_exc())
+            if not retries:
+                raise bb.server.process.ProcessTimeout("Unable to connect to bitbake server, or start one")
+
+
+    if configParams.kill_server:
+        server_connection.connection.terminateServer()
+        server_connection.terminate()
         bb.event.ui_queue = []
+        print("Terminated bitbake server.")
+        return None, None
 
-    if configParams.server_only:
-        server_connection = None
-    else:
-        try:
-            server_connection = server.establishConnection(featureset)
-        except Exception as e:
-            bb.fatal("Could not connect to server %s: %s" % (configParams.remote_server, str(e)))
-
-        if configParams.kill_server:
-            server_connection.connection.terminateServer()
-            bb.event.ui_queue = []
-            return None, None, None
+    # Restore the environment in case the UI needs it
+    for k in cleanedvars:
+        os.environ[k] = cleanedvars[k]
 
-        server_connection.setupEventQueue()
+    logger.removeHandler(handler)
 
-        # Restore the environment in case the UI needs it
-        for k in cleanedvars:
-            os.environ[k] = cleanedvars[k]
+    return server_connection, ui_module
 
-        logger.removeHandler(handler)
+def lockBitbake():
+    topdir = bb.cookerdata.findTopdir()
+    lockfile = topdir + "/bitbake.lock"
+    return topdir, bb.utils.lockfile(lockfile, False, False)
 
-    return server, server_connection, ui_module
diff --git a/lib/bb/server/__init__.py b/lib/bb/server/__init__.py
index 345691e..5a3fba9 100644
--- a/lib/bb/server/__init__.py
+++ b/lib/bb/server/__init__.py
@@ -18,10 +18,4 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-""" Base code for Bitbake server process
-
-Have a common base for that all Bitbake server classes ensures a consistent
-approach to the interface, and minimize risks associated with code duplication.
-
-"""
 
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 48da7fe..a1d9adc 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -22,128 +22,201 @@
 
 import bb
 import bb.event
-import itertools
 import logging
 import multiprocessing
+import threading
+import array
 import os
-import signal
 import sys
 import time
 import select
-from queue import Empty
-from multiprocessing import Event, Process, util, Queue, Pipe, queues, Manager
+import socket
+import subprocess
+import errno
+import bb.server.xmlrpcserver
+from bb import daemonize
+from multiprocessing import queues
 
 logger = logging.getLogger('BitBake')
 
-class ServerCommunicator():
-    def __init__(self, connection, event_handle, server):
-        self.connection = connection
-        self.event_handle = event_handle
-        self.server = server
-
-    def runCommand(self, command):
-        # @todo try/except
-        self.connection.send(command)
-
-        if not self.server.is_alive():
-            raise SystemExit
-
-        while True:
-            # don't let the user ctrl-c while we're waiting for a response
-            try:
-                for idx in range(0,4): # 0, 1, 2, 3
-                    if self.connection.poll(5):
-                        return self.connection.recv()
-                    else:
-                        bb.warn("Timeout while attempting to communicate with bitbake server")
-                bb.fatal("Gave up; Too many tries: timeout while attempting to communicate with bitbake server")
-            except KeyboardInterrupt:
-                pass
-
-    def getEventHandle(self):
-        handle, error = self.runCommand(["getUIHandlerNum"])
-        if error:
-            logger.error("Unable to get UI Handler Number: %s" % error)
-            raise BaseException(error)
+class ProcessTimeout(SystemExit):
+    pass
 
-        return handle
-
-class EventAdapter():
-    """
-    Adapter to wrap our event queue since the caller (bb.event) expects to
-    call a send() method, but our actual queue only has put()
-    """
-    def __init__(self, queue):
-        self.queue = queue
-
-    def send(self, event):
-        try:
-            self.queue.put(event)
-        except Exception as err:
-            print("EventAdapter puked: %s" % str(err))
-
-
-class ProcessServer(Process):
+class ProcessServer(multiprocessing.Process):
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
 
-    def __init__(self, command_channel, event_queue, featurelist):
-        self._idlefuns = {}
-        Process.__init__(self)
-        self.command_channel = command_channel
-        self.event_queue = event_queue
-        self.event = EventAdapter(event_queue)
-        self.featurelist = featurelist
+    def __init__(self, lock, sock, sockname):
+        multiprocessing.Process.__init__(self)
+        self.command_channel = False
+        self.command_channel_reply = False
         self.quit = False
         self.heartbeat_seconds = 1 # default, BB_HEARTBEAT_EVENT will be checked once we have a datastore.
         self.next_heartbeat = time.time()
 
-        self.quitin, self.quitout = Pipe()
-        self.event_handle = multiprocessing.Value("i")
+        self.event_handle = None
+        self.haveui = False
+        self.lastui = False
+        self.xmlrpc = False
+
+        self._idlefuns = {}
+
+        self.bitbake_lock = lock
+        self.sock = sock
+        self.sockname = sockname
+
+    def register_idle_function(self, function, data):
+        """Register a function to be called while the server is idle"""
+        assert hasattr(function, '__call__')
+        self._idlefuns[function] = data
 
     def run(self):
-        for event in bb.event.ui_queue:
-            self.event_queue.put(event)
-        self.event_handle.value = bb.event.register_UIHhandler(self, True)
+
+        if self.xmlrpcinterface[0]:
+            self.xmlrpc = bb.server.xmlrpcserver.BitBakeXMLRPCServer(self.xmlrpcinterface, self.cooker, self)
+
+            print("Bitbake XMLRPC server address: %s, server port: %s" % (self.xmlrpc.host, self.xmlrpc.port))
 
         heartbeat_event = self.cooker.data.getVar('BB_HEARTBEAT_EVENT')
         if heartbeat_event:
             try:
                 self.heartbeat_seconds = float(heartbeat_event)
             except:
-                # Throwing an exception here causes bitbake to hang.
-                # Just warn about the invalid setting and continue
                 bb.warn('Ignoring invalid BB_HEARTBEAT_EVENT=%s, must be a float specifying seconds.' % heartbeat_event)
+
+        self.timeout = self.server_timeout or self.cooker.data.getVar('BB_SERVER_TIMEOUT')
+        try:
+            if self.timeout:
+                self.timeout = float(self.timeout)
+        except:
+            bb.warn('Ignoring invalid BB_SERVER_TIMEOUT=%s, must be a float specifying seconds.' % self.timeout)
+
+
+        try:
+            self.bitbake_lock.seek(0)
+            self.bitbake_lock.truncate()
+            if self.xmlrpcinterface[0]:
+                self.bitbake_lock.write("%s %s:%s\n" % (os.getpid(), configuration.interface[0], configuration.interface[1]))
+            else:
+                self.bitbake_lock.write("%s\n" % (os.getpid()))
+            self.bitbake_lock.flush()
+        except:
+            pass
+
         bb.cooker.server_main(self.cooker, self.main)
 
     def main(self):
-        # Ignore SIGINT within the server, as all SIGINT handling is done by
-        # the UI and communicated to us
-        self.quitin.close()
-        signal.signal(signal.SIGINT, signal.SIG_IGN)
         bb.utils.set_process_name("Cooker")
+
+        ready = []
+
+        self.controllersock = False
+        fds = [self.sock]
+        if self.xmlrpc:
+            fds.append(self.xmlrpc)
         while not self.quit:
-            try:
-                if self.command_channel.poll():
-                    command = self.command_channel.recv()
-                    self.runCommand(command)
-                if self.quitout.poll():
-                    self.quitout.recv()
+            if self.command_channel in ready:
+                command = self.command_channel.get()
+                if command[0] == "terminateServer":
                     self.quit = True
-                    try:
-                        self.runCommand(["stateForceShutdown"])
-                    except:
-                        pass
-
-                self.idle_commands(.1, [self.command_channel, self.quitout])
-            except Exception:
-                logger.exception('Running command %s', command)
+                    continue
+                try:
+                    print("Running command %s" % command)
+                    self.command_channel_reply.send(self.cooker.command.runCommand(command))
+                except Exception as e:
+                   logger.exception('Exception in server main event loop running command %s (%s)' % (command, str(e)))
+
+            if self.xmlrpc in ready:
+                self.xmlrpc.handle_requests()
+            if self.sock in ready:
+                print("Accepting %s" % (str(ready)))
+                self.controllersock, address = self.sock.accept()
+                fds.append(self.controllersock)
+            if self.controllersock in ready:
+                try:
+                    print("Connecting Client")
+                    ui_fds = recvfds(self.controllersock, 3)
+
+                    # Where to write events to
+                    writer = ConnectionWriter(ui_fds[0])
+                    self.event_handle = bb.event.register_UIHhandler(writer, True)
+                    self.event_writer = writer
+
+                    # Where to read commands from
+                    reader = ConnectionReader(ui_fds[1])
+                    fds.append(reader)
+                    self.command_channel = reader
+
+                    # Where to send command return values to
+                    writer = ConnectionWriter(ui_fds[2])
+                    self.command_channel_reply = writer
+
+                    self.haveui = True
+
+                except EOFError:
+                    print("Disconnecting Client")
+                    fds.remove(self.controllersock)
+                    fds.remove(self.command_channel)
+                    bb.event.unregister_UIHhandler(self.event_handle, True)
+                    self.command_channel_reply.writer.close()
+                    self.event_writer.writer.close()
+                    del self.event_writer
+                    self.controllersock.close()
+                    self.haveui = False
+                    self.lastui = time.time()
+                    self.cooker.clientComplete()
+                    if self.timeout is None:
+                        print("No timeout, exiting.")
+                        self.quit = True
+            if not self.haveui and self.lastui and self.timeout and (self.lastui + self.timeout) < time.time():
+                print("Server timeout, exiting.")
+                self.quit = True
 
-        self.event_queue.close()
-        bb.event.unregister_UIHhandler(self.event_handle.value, True)
-        self.command_channel.close()
-        self.cooker.shutdown(True)
-        self.quitout.close()
+            ready = self.idle_commands(.1, fds)
+
+        print("Exiting")
+        try: 
+            self.cooker.shutdown(True)
+        except:
+            pass
+
+        # Remove the socket file so we don't get any more connections to avoid races
+        os.unlink(self.sockname)
+        self.sock.close()
+
+        # Finally release the lockfile but warn about other processes holding it open
+        lock = self.bitbake_lock
+        lockfile = lock.name
+        lock.close()
+        lock = None
+
+        while not lock:
+            with bb.utils.timeout(3):
+                lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=True)
+                if not lock:
+                    # Some systems may not have lsof available
+                    procs = None
+                    try:
+                        procs = subprocess.check_output(["lsof", '-w', lockfile], stderr=subprocess.STDOUT)
+                    except OSError as e:
+                        if e.errno != errno.ENOENT:
+                            raise
+                    if procs is None:
+                        # Fall back to fuser if lsof is unavailable
+                        try:
+                            procs = subprocess.check_output(["fuser", '-v', lockfile], stderr=subprocess.STDOUT)
+                        except OSError as e:
+                            if e.errno != errno.ENOENT:
+                                raise
+
+                    msg = "Delaying shutdown due to active processes which appear to be holding bitbake.lock"
+                    if procs:
+                        msg += ":\n%s" % str(procs)
+                    print(msg)
+                    return
+        # We hold the lock so we can remove the file (hide stale pid data)
+        bb.utils.remove(lockfile)
+        bb.utils.unlockfile(lock)
 
     def idle_commands(self, delay, fds=None):
         nextsleep = delay
@@ -189,140 +262,253 @@ class ProcessServer(Process):
             nextsleep = self.next_heartbeat - now
 
         if nextsleep is not None:
+            if self.xmlrpc:
+                nextsleep = self.xmlrpc.get_timeout(nextsleep)
             try:
-                select.select(fds,[],[],nextsleep)
+                return select.select(fds,[],[],nextsleep)[0]
             except InterruptedError:
-                # ignore EINTR error, nextsleep only used for wait
-                # certain time
-                pass
+                # Ignore EINTR
+                return []
+        else:
+            return []
+
+
+class ServerCommunicator():
+    def __init__(self, connection, recv):
+        self.connection = connection
+        self.recv = recv
 
     def runCommand(self, command):
-        """
-        Run a cooker command on the server
-        """
-        self.command_channel.send(self.cooker.command.runCommand(command))
 
-    def stop(self):
-        self.quitin.send("quit")
-        self.quitin.close()
+        self.connection.send(command)
+        while True:
+            # don't let the user ctrl-c while we're waiting for a response
+            try:
+                for idx in range(0,4): # 0, 1, 2, 3
+                    if self.recv.poll(1):
+                        return self.recv.get()
+                    else:
+                        bb.warn("Timeout while attempting to communicate with bitbake server")
+                raise ProcessTimeout("Gave up; Too many tries: timeout while attempting to communicate with bitbake server")
+            except KeyboardInterrupt:
+                pass
+
+    def updateFeatureSet(self, featureset):
+        _, error = self.runCommand(["setFeatures", featureset])
+        if error:
+            logger.error("Unable to set the cooker to the correct featureset: %s" % error)
+            raise BaseException(error)
+
+    def getEventHandle(self):
+        handle, error = self.runCommand(["getUIHandlerNum"])
+        if error:
+            logger.error("Unable to get UI Handler Number: %s" % error)
+            raise BaseException(error)
 
-    def addcooker(self, cooker):
-        self.cooker = cooker
+        return handle
 
-    def register_idle_function(self, function, data):
-        """Register a function to be called while the server is idle"""
-        assert hasattr(function, '__call__')
-        self._idlefuns[function] = data
+    def terminateServer(self):
+        self.connection.send(['terminateServer'])
+        return
 
 class BitBakeProcessServerConnection(object):
-    def __init__(self, serverImpl, ui_channel, event_queue):
-        self.procserver = serverImpl
-        self.ui_channel = ui_channel
-        self.event_queue = event_queue
-        self.connection = ServerCommunicator(self.ui_channel, self.procserver.event_handle, self.procserver)
-        self.events = self.event_queue
-        self.terminated = False
-
-    def sigterm_terminate(self):
-        bb.error("UI received SIGTERM")
-        self.terminate()
+    def __init__(self, ui_channel, recv, eq):
+        self.connection = ServerCommunicator(ui_channel, recv)
+        self.events = eq
 
     def terminate(self):
-        if self.terminated:
-            return
-        self.terminated = True
-        def flushevents():
-            while True:
-                try:
-                    event = self.event_queue.get(block=False)
-                except (Empty, IOError):
-                    break
-                if isinstance(event, logging.LogRecord):
-                    logger.handle(event)
-
-        self.procserver.stop()
-
-        while self.procserver.is_alive():
-            flushevents()
-            self.procserver.join(0.1)
-
-        self.ui_channel.close()
-        self.event_queue.close()
-        self.event_queue.setexit()
-        # XXX: Call explicity close in _writer to avoid
-        # fd leakage because isn't called on Queue.close()
-        self.event_queue._writer.close()
-
-    def setupEventQueue(self):
-        pass
-
-# Wrap Queue to provide API which isn't server implementation specific
-class ProcessEventQueue(multiprocessing.queues.Queue):
-    def __init__(self, maxsize):
-        multiprocessing.queues.Queue.__init__(self, maxsize, ctx=multiprocessing.get_context())
-        self.exit = False
-        bb.utils.set_process_name("ProcessEQueue")
-
-    def setexit(self):
-        self.exit = True
-
-    def waitEvent(self, timeout):
-        if self.exit:
-            return self.getEvent()
+        self.socket_connection.close()
+        return
+
+class BitBakeServer(object):
+    def __init__(self, lock, sockname, configuration, featureset):
+
+        self.configuration = configuration
+        self.featureset = featureset
+        self.sockname = sockname
+        self.bitbake_lock = lock
+
+        # Create server control socket
+        if os.path.exists(sockname):
+            os.unlink(sockname)
+
+        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+        # AF_UNIX has path length issues so chdir here to workaround
+        cwd = os.getcwd()
         try:
-            if not self.server.is_alive():
-                return self.getEvent()
-            if timeout == 0:
-                return self.get(False)
-            return self.get(True, timeout)
-        except Empty:
-            return None
+            os.chdir(os.path.dirname(sockname))
+            self.sock.bind(os.path.basename(sockname))
+        finally:
+            os.chdir(cwd)
+        self.sock.listen(1)
+
+        os.set_inheritable(self.sock.fileno(), True)
+        bb.daemonize.createDaemon(self._startServer, "bitbake-cookerdaemon.log")
+        self.sock.close()
+        self.bitbake_lock.close()
+
+    def _startServer(self):
+        server = ProcessServer(self.bitbake_lock, self.sock, self.sockname)
+        self.configuration.setServerRegIdleCallback(server.register_idle_function)
+
+        # Copy prefile and postfile to _server variants
+        for param in ('prefile', 'postfile'):
+            value = getattr(self.configuration, param)
+            if value:
+                setattr(self.configuration, "%s_server" % param, value)
+
+        self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
+        server.cooker = self.cooker
+        server.server_timeout = self.configuration.server_timeout
+        server.xmlrpcinterface = self.configuration.xmlrpcinterface
+        print("Started bitbake server pid %d" % os.getpid())
+        server.start()
+
+def connectProcessServer(sockname, featureset):
+    # Connect to socket
+    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+    # AF_UNIX has path length issues so chdir here to workaround
+    cwd = os.getcwd()
+
+    try:
+        os.chdir(os.path.dirname(sockname))
+        sock.connect(os.path.basename(sockname))
+    finally:
+        os.chdir(cwd)
+
+    try:
+        # Send an fd for the remote to write events to
+        readfd, writefd = os.pipe()
+        eq = BBUIEventQueue(readfd)
+        # Send an fd for the remote to recieve commands from
+        readfd1, writefd1 = os.pipe()
+        command_chan = ConnectionWriter(writefd1)
+        # Send an fd for the remote to write commands results to
+        readfd2, writefd2 = os.pipe()
+        command_chan_recv = ConnectionReader(readfd2)
+
+        sendfds(sock, [writefd, readfd1, writefd2])
+
+        server_connection = BitBakeProcessServerConnection(command_chan, command_chan_recv, eq)
+
+        server_connection.connection.updateFeatureSet(featureset)
+
+        # Save sock so it doesn't get gc'd for the life of our connection
+        server_connection.socket_connection = sock
+    except:
+        sock.close()
+        raise
+
+    return server_connection
+
+def sendfds(sock, fds):
+        '''Send an array of fds over an AF_UNIX socket.'''
+        fds = array.array('i', fds)
+        msg = bytes([len(fds) % 256])
+        sock.sendmsg([msg], [(socket.SOL_SOCKET, socket.SCM_RIGHTS, fds)])
+
+def recvfds(sock, size):
+        '''Receive an array of fds over an AF_UNIX socket.'''
+        a = array.array('i')
+        bytes_size = a.itemsize * size
+        msg, ancdata, flags, addr = sock.recvmsg(1, socket.CMSG_LEN(bytes_size))
+        if not msg and not ancdata:
+            raise EOFError
+        try:
+            if len(ancdata) != 1:
+                raise RuntimeError('received %d items of ancdata' %
+                                   len(ancdata))
+            cmsg_level, cmsg_type, cmsg_data = ancdata[0]
+            if (cmsg_level == socket.SOL_SOCKET and
+                cmsg_type == socket.SCM_RIGHTS):
+                if len(cmsg_data) % a.itemsize != 0:
+                    raise ValueError
+                a.frombytes(cmsg_data)
+                assert len(a) % 256 == msg[0]
+                return list(a)
+        except (ValueError, IndexError):
+            pass
+        raise RuntimeError('Invalid data received')
+
+class BBUIEventQueue:
+    def __init__(self, readfd):
+
+        self.eventQueue = []
+        self.eventQueueLock = threading.Lock()
+        self.eventQueueNotify = threading.Event()
+
+        self.reader = ConnectionReader(readfd)
+
+        self.t = threading.Thread()
+        self.t.setDaemon(True)
+        self.t.run = self.startCallbackHandler
+        self.t.start()
 
     def getEvent(self):
-        try:
-            if not self.server.is_alive():
-                self.setexit()
-            return self.get(False)
-        except Empty:
-            if self.exit:
-                sys.exit(1)
+        self.eventQueueLock.acquire()
+
+        if len(self.eventQueue) == 0:
+            self.eventQueueLock.release()
             return None
 
-class BitBakeServer(object):
-    def initServer(self, single_use=True):
-        # establish communication channels.  We use bidirectional pipes for
-        # ui <--> server command/response pairs
-        # and a queue for server -> ui event notifications
-        #
-        self.ui_channel, self.server_channel = Pipe()
-        self.event_queue = ProcessEventQueue(0)
-        self.serverImpl = ProcessServer(self.server_channel, self.event_queue, None)
-        self.event_queue.server = self.serverImpl
-
-    def detach(self):
-        self.serverImpl.start()
-        return
+        item = self.eventQueue.pop(0)
 
-    def establishConnection(self, featureset):
+        if len(self.eventQueue) == 0:
+            self.eventQueueNotify.clear()
 
-        self.connection = BitBakeProcessServerConnection(self.serverImpl, self.ui_channel, self.event_queue)
+        self.eventQueueLock.release()
+        return item
 
-        _, error = self.connection.connection.runCommand(["setFeatures", featureset])
-        if error:
-            logger.error("Unable to set the cooker to the correct featureset: %s" % error)
-            raise BaseException(error)
-        signal.signal(signal.SIGTERM, lambda i, s: self.connection.sigterm_terminate())
-        return self.connection
+    def waitEvent(self, delay):
+        self.eventQueueNotify.wait(delay)
+        return self.getEvent()
 
-    def addcooker(self, cooker):
-        self.cooker = cooker
-        self.serverImpl.addcooker(cooker)
+    def queue_event(self, event):
+        self.eventQueueLock.acquire()
+        self.eventQueue.append(event)
+        self.eventQueueNotify.set()
+        self.eventQueueLock.release()
 
-    def getServerIdleCB(self):
-        return self.serverImpl.register_idle_function
+    def send_event(self, event):
+        self.queue_event(pickle.loads(event))
 
-    def saveConnectionDetails(self):
-        return
+    def startCallbackHandler(self):
+        bb.utils.set_process_name("UIEventQueue")
+        while True:
+            self.reader.wait()
+            event = self.reader.get()
+            self.queue_event(event)
+
+class ConnectionReader(object):
+
+    def __init__(self, fd):
+        self.reader = multiprocessing.connection.Connection(fd, writable=False)
+        self.rlock = multiprocessing.Lock()
+
+    def wait(self, timeout=None):
+        return multiprocessing.connection.wait([self.reader], timeout)
+
+    def poll(self, timeout=None):
+        return self.reader.poll(timeout)
+
+    def get(self):
+        with self.rlock:
+            res = self.reader.recv_bytes()
+        return multiprocessing.reduction.ForkingPickler.loads(res)
+
+    def fileno(self):
+        return self.reader.fileno()
+
+class ConnectionWriter(object):
+
+    def __init__(self, fd):
+        self.writer = multiprocessing.connection.Connection(fd, readable=False)
+        self.wlock = multiprocessing.Lock()
+        # Why bb.event needs this I have no idea
+        self.event = self
+
+    def send(self, obj):
+        obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
+        with self.wlock:
+            self.writer.send_bytes(obj)
 
-    def endSession(self):
-        self.connection.terminate()
diff --git a/lib/bb/server/process.py.orig b/lib/bb/server/process.py.orig
new file mode 100644
index 0000000..ef84757d
--- /dev/null
+++ b/lib/bb/server/process.py.orig
@@ -0,0 +1,323 @@
+#
+# BitBake Process based server.
+#
+# Copyright (C) 2010 Bob Foerster <robert@erafx.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+"""
+    This module implements a multiprocessing.Process based server for bitbake.
+"""
+
+import bb
+import bb.event
+import itertools
+import logging
+import multiprocessing
+import os
+import signal
+import sys
+import time
+import select
+from queue import Empty
+from multiprocessing import Event, Process, util, Queue, Pipe, queues, Manager
+
+logger = logging.getLogger('BitBake')
+
+class ServerCommunicator():
+    def __init__(self, connection, event_handle, server):
+        self.connection = connection
+        self.event_handle = event_handle
+        self.server = server
+
+    def runCommand(self, command):
+        # @todo try/except
+        self.connection.send(command)
+
+        if not self.server.is_alive():
+            raise SystemExit
+
+        while True:
+            # don't let the user ctrl-c while we're waiting for a response
+            try:
+                for idx in range(0,4): # 0, 1, 2, 3
+                    if self.connection.poll(5):
+                        return self.connection.recv()
+                    else:
+                        bb.warn("Timeout while attempting to communicate with bitbake server")
+                bb.fatal("Gave up; Too many tries: timeout while attempting to communicate with bitbake server")
+            except KeyboardInterrupt:
+                pass
+
+    def getEventHandle(self):
+        handle, error = self.runCommand(["getUIHandlerNum"])
+        if error:
+            logger.error("Unable to get UI Handler Number: %s" % error)
+            raise BaseException(error)
+
+        return handle
+
+class EventAdapter():
+    """
+    Adapter to wrap our event queue since the caller (bb.event) expects to
+    call a send() method, but our actual queue only has put()
+    """
+    def __init__(self, queue):
+        self.queue = queue
+
+    def send(self, event):
+        try:
+            self.queue.put(event)
+        except Exception as err:
+            print("EventAdapter puked: %s" % str(err))
+
+
+class ProcessServer(Process):
+    profile_filename = "profile.log"
+    profile_processed_filename = "profile.log.processed"
+
+    def __init__(self, command_channel, event_queue, featurelist):
+        self._idlefuns = {}
+        Process.__init__(self)
+        self.command_channel = command_channel
+        self.event_queue = event_queue
+        self.event = EventAdapter(event_queue)
+        self.featurelist = featurelist
+        self.quit = False
+        self.heartbeat_seconds = 1 # default, BB_HEARTBEAT_EVENT will be checked once we have a datastore.
+        self.next_heartbeat = time.time()
+
+        self.quitin, self.quitout = Pipe()
+        self.event_handle = multiprocessing.Value("i")
+
+    def run(self):
+        for event in bb.event.ui_queue:
+            self.event_queue.put(event)
+        self.event_handle.value = bb.event.register_UIHhandler(self, True)
+
+        heartbeat_event = self.cooker.data.getVar('BB_HEARTBEAT_EVENT')
+        if heartbeat_event:
+            try:
+                self.heartbeat_seconds = float(heartbeat_event)
+            except:
+                # Throwing an exception here causes bitbake to hang.
+                # Just warn about the invalid setting and continue
+                bb.warn('Ignoring invalid BB_HEARTBEAT_EVENT=%s, must be a float specifying seconds.' % heartbeat_event)
+        bb.cooker.server_main(self.cooker, self.main)
+
+    def main(self):
+        # Ignore SIGINT within the server, as all SIGINT handling is done by
+        # the UI and communicated to us
+        self.quitin.close()
+        signal.signal(signal.SIGINT, signal.SIG_IGN)
+        bb.utils.set_process_name("Cooker")
+        while not self.quit:
+            try:
+                if self.command_channel.poll():
+                    command = self.command_channel.recv()
+                    self.runCommand(command)
+                if self.quitout.poll():
+                    self.quitout.recv()
+                    self.quit = True
+                    try:
+                        self.runCommand(["stateForceShutdown"])
+                    except:
+                        pass
+
+                self.idle_commands(.1, [self.command_channel, self.quitout])
+            except Exception:
+                logger.exception('Running command %s', command)
+
+        self.event_queue.close()
+        bb.event.unregister_UIHhandler(self.event_handle.value, True)
+        self.command_channel.close()
+        self.cooker.shutdown(True)
+        self.quitout.close()
+
+    def idle_commands(self, delay, fds=None):
+        nextsleep = delay
+        if not fds:
+            fds = []
+
+        for function, data in list(self._idlefuns.items()):
+            try:
+                retval = function(self, data, False)
+                if retval is False:
+                    del self._idlefuns[function]
+                    nextsleep = None
+                elif retval is True:
+                    nextsleep = None
+                elif isinstance(retval, float) and nextsleep:
+                    if (retval < nextsleep):
+                        nextsleep = retval
+                elif nextsleep is None:
+                    continue
+                else:
+                    fds = fds + retval
+            except SystemExit:
+                raise
+            except Exception as exc:
+                if not isinstance(exc, bb.BBHandledException):
+                    logger.exception('Running idle function')
+                del self._idlefuns[function]
+                self.quit = True
+
+        # Create new heartbeat event?
+        now = time.time()
+        if now >= self.next_heartbeat:
+            # We might have missed heartbeats. Just trigger once in
+            # that case and continue after the usual delay.
+            self.next_heartbeat += self.heartbeat_seconds
+            if self.next_heartbeat <= now:
+                self.next_heartbeat = now + self.heartbeat_seconds
+            heartbeat = bb.event.HeartbeatEvent(now)
+            bb.event.fire(heartbeat, self.cooker.data)
+        if nextsleep and now + nextsleep > self.next_heartbeat:
+            # Shorten timeout so that we we wake up in time for
+            # the heartbeat.
+            nextsleep = self.next_heartbeat - now
+
+        if nextsleep is not None:
+            select.select(fds,[],[],nextsleep)
+
+    def runCommand(self, command):
+        """
+        Run a cooker command on the server
+        """
+        self.command_channel.send(self.cooker.command.runCommand(command))
+
+    def stop(self):
+        self.quitin.send("quit")
+        self.quitin.close()
+
+    def addcooker(self, cooker):
+        self.cooker = cooker
+
+    def register_idle_function(self, function, data):
+        """Register a function to be called while the server is idle"""
+        assert hasattr(function, '__call__')
+        self._idlefuns[function] = data
+
+class BitBakeProcessServerConnection(object):
+    def __init__(self, serverImpl, ui_channel, event_queue):
+        self.procserver = serverImpl
+        self.ui_channel = ui_channel
+        self.event_queue = event_queue
+        self.connection = ServerCommunicator(self.ui_channel, self.procserver.event_handle, self.procserver)
+        self.events = self.event_queue
+        self.terminated = False
+
+    def sigterm_terminate(self):
+        bb.error("UI received SIGTERM")
+        self.terminate()
+
+    def terminate(self):
+        if self.terminated:
+            return
+        self.terminated = True
+        def flushevents():
+            while True:
+                try:
+                    event = self.event_queue.get(block=False)
+                except (Empty, IOError):
+                    break
+                if isinstance(event, logging.LogRecord):
+                    logger.handle(event)
+
+        self.procserver.stop()
+
+        while self.procserver.is_alive():
+            flushevents()
+            self.procserver.join(0.1)
+
+        self.ui_channel.close()
+        self.event_queue.close()
+        self.event_queue.setexit()
+        # XXX: Call explicity close in _writer to avoid
+        # fd leakage because isn't called on Queue.close()
+        self.event_queue._writer.close()
+
+    def setupEventQueue(self):
+        pass
+
+# Wrap Queue to provide API which isn't server implementation specific
+class ProcessEventQueue(multiprocessing.queues.Queue):
+    def __init__(self, maxsize):
+        multiprocessing.queues.Queue.__init__(self, maxsize, ctx=multiprocessing.get_context())
+        self.exit = False
+        bb.utils.set_process_name("ProcessEQueue")
+
+    def setexit(self):
+        self.exit = True
+
+    def waitEvent(self, timeout):
+        if self.exit:
+            return self.getEvent()
+        try:
+            if not self.server.is_alive():
+                return self.getEvent()
+            if timeout == 0:
+                return self.get(False)
+            return self.get(True, timeout)
+        except Empty:
+            return None
+
+    def getEvent(self):
+        try:
+            if not self.server.is_alive():
+                self.setexit()
+            return self.get(False)
+        except Empty:
+            if self.exit:
+                sys.exit(1)
+            return None
+
+class BitBakeServer(object):
+    def initServer(self, single_use=True):
+        # establish communication channels.  We use bidirectional pipes for
+        # ui <--> server command/response pairs
+        # and a queue for server -> ui event notifications
+        #
+        self.ui_channel, self.server_channel = Pipe()
+        self.event_queue = ProcessEventQueue(0)
+        self.serverImpl = ProcessServer(self.server_channel, self.event_queue, None)
+        self.event_queue.server = self.serverImpl
+
+    def detach(self):
+        self.serverImpl.start()
+        return
+
+    def establishConnection(self, featureset):
+
+        self.connection = BitBakeProcessServerConnection(self.serverImpl, self.ui_channel, self.event_queue)
+
+        _, error = self.connection.connection.runCommand(["setFeatures", featureset])
+        if error:
+            logger.error("Unable to set the cooker to the correct featureset: %s" % error)
+            raise BaseException(error)
+        signal.signal(signal.SIGTERM, lambda i, s: self.connection.sigterm_terminate())
+        return self.connection
+
+    def addcooker(self, cooker):
+        self.cooker = cooker
+        self.serverImpl.addcooker(cooker)
+
+    def getServerIdleCB(self):
+        return self.serverImpl.register_idle_function
+
+    def saveConnectionDetails(self):
+        return
+
+    def endSession(self):
+        self.connection.terminate()
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
deleted file mode 100644
index 6874765..0000000
--- a/lib/bb/server/xmlrpc.py
+++ /dev/null
@@ -1,492 +0,0 @@
-#
-# BitBake XMLRPC Server
-#
-# Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
-# Copyright (C) 2006 - 2008  Richard Purdie
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-"""
-    This module implements an xmlrpc server for BitBake.
-
-    Use this by deriving a class from BitBakeXMLRPCServer and then adding
-    methods which you want to "export" via XMLRPC. If the methods have the
-    prefix xmlrpc_, then registering those function will happen automatically,
-    if not, you need to call register_function.
-
-    Use register_idle_function() to add a function which the xmlrpc server
-    calls from within server_forever when no requests are pending. Make sure
-    that those functions are non-blocking or else you will introduce latency
-    in the server's main loop.
-"""
-
-import os
-import sys
-
-import hashlib
-import time
-import socket
-import signal
-import threading
-import pickle
-import inspect
-import select
-import http.client
-import xmlrpc.client
-from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
-
-import bb
-from bb import daemonize
-from bb.ui import uievent
-
-DEBUG = False
-
-class BBTransport(xmlrpc.client.Transport):
-    def __init__(self, timeout):
-        self.timeout = timeout
-        self.connection_token = None
-        xmlrpc.client.Transport.__init__(self)
-
-    # Modified from default to pass timeout to HTTPConnection
-    def make_connection(self, host):
-        #return an existing connection if possible.  This allows
-        #HTTP/1.1 keep-alive.
-        if self._connection and host == self._connection[0]:
-            return self._connection[1]
-
-        # create a HTTP connection object from a host descriptor
-        chost, self._extra_headers, x509 = self.get_host_info(host)
-        #store the host argument along with the connection object
-        self._connection = host, http.client.HTTPConnection(chost, timeout=self.timeout)
-        return self._connection[1]
-
-    def set_connection_token(self, token):
-        self.connection_token = token
-
-    def send_content(self, h, body):
-        if self.connection_token:
-            h.putheader("Bitbake-token", self.connection_token)
-        xmlrpc.client.Transport.send_content(self, h, body)
-
-def _create_server(host, port, timeout = 60):
-    t = BBTransport(timeout)
-    s = xmlrpc.client.ServerProxy("http://%s:%d/" % (host, port), transport=t, allow_none=True, use_builtin_types=True)
-    return s, t
-
-def check_connection(remote, timeout):
-    try:
-        host, port = remote.split(":")
-        port = int(port)
-    except Exception as e:
-        bb.warn("Failed to read remote definition (%s)" % str(e))
-        raise e
-
-    server, _transport = _create_server(host, port, timeout)
-    try:
-        ret, err =  server.runCommand(['getVariable', 'TOPDIR'])
-        if err or not ret:
-            return False
-    except ConnectionError:
-        return False
-    return True
-
-class BitBakeServerCommands():
-
-    def __init__(self, server):
-        self.server = server
-        self.has_client = False
-
-    def registerEventHandler(self, host, port):
-        """
-        Register a remote UI Event Handler
-        """
-        s, t = _create_server(host, port)
-
-        # we don't allow connections if the cooker is running
-        if (self.cooker.state in [bb.cooker.state.parsing, bb.cooker.state.running]):
-            return None, "Cooker is busy: %s" % bb.cooker.state.get_name(self.cooker.state)
-
-        self.event_handle = bb.event.register_UIHhandler(s, True)
-        return self.event_handle, 'OK'
-
-    def unregisterEventHandler(self, handlerNum):
-        """
-        Unregister a remote UI Event Handler
-        """
-        return bb.event.unregister_UIHhandler(handlerNum, True)
-
-    def runCommand(self, command):
-        """
-        Run a cooker command on the server
-        """
-        return self.cooker.command.runCommand(command, self.server.readonly)
-
-    def getEventHandle(self):
-        return self.event_handle
-
-    def terminateServer(self):
-        """
-        Trigger the server to quit
-        """
-        self.server.quit = True
-        print("Server (cooker) exiting")
-        return
-
-    def addClient(self):
-        if self.has_client:
-            return None
-        token = hashlib.md5(str(time.time()).encode("utf-8")).hexdigest()
-        self.server.set_connection_token(token)
-        self.has_client = True
-        return token
-
-    def removeClient(self):
-        if self.has_client:
-            self.server.set_connection_token(None)
-            self.has_client = False
-            if self.server.single_use:
-                self.server.quit = True
-
-# This request handler checks if the request has a "Bitbake-token" header
-# field (this comes from the client side) and compares it with its internal
-# "Bitbake-token" field (this comes from the server). If the two are not
-# equal, it is assumed that a client is trying to connect to the server
-# while another client is connected to the server. In this case, a 503 error
-# ("service unavailable") is returned to the client.
-class BitBakeXMLRPCRequestHandler(SimpleXMLRPCRequestHandler):
-    def __init__(self, request, client_address, server):
-        self.server = server
-        SimpleXMLRPCRequestHandler.__init__(self, request, client_address, server)
-
-    def do_POST(self):
-        try:
-            remote_token = self.headers["Bitbake-token"]
-        except:
-            remote_token = None
-        if remote_token != self.server.connection_token and remote_token != "observer":
-            self.report_503()
-        else:
-            if remote_token == "observer":
-                self.server.readonly = True
-            else:
-                self.server.readonly = False
-            SimpleXMLRPCRequestHandler.do_POST(self)
-
-    def report_503(self):
-        self.send_response(503)
-        response = 'No more client allowed'
-        self.send_header("Content-type", "text/plain")
-        self.send_header("Content-length", str(len(response)))
-        self.end_headers()
-        self.wfile.write(bytes(response, 'utf-8'))
-
-
-class XMLRPCProxyServer(object):
-    """ not a real working server, but a stub for a proxy server connection
-
-    """
-    def __init__(self, host, port, use_builtin_types=True):
-        self.host = host
-        self.port = port
-        self._idlefuns = {}
-
-    def addcooker(self, cooker):
-        self.cooker = cooker
-
-    def register_idle_function(self, function, data):
-        """Register a function to be called while the server is idle"""
-        assert hasattr(function, '__call__')
-        self._idlefuns[function] = data
-
-
-class XMLRPCServer(SimpleXMLRPCServer):
-    # remove this when you're done with debugging
-    # allow_reuse_address = True
-
-    def __init__(self, interface, single_use=False, idle_timeout=0):
-        """
-        Constructor
-        """
-        self._idlefuns = {}
-        self.single_use = single_use
-        # Use auto port configuration
-        if (interface[1] == -1):
-            interface = (interface[0], 0)
-        SimpleXMLRPCServer.__init__(self, interface,
-                                    requestHandler=BitBakeXMLRPCRequestHandler,
-                                    logRequests=False, allow_none=True)
-        self.host, self.port = self.socket.getsockname()
-        self.connection_token = None
-        #self.register_introspection_functions()
-        self.commands = BitBakeServerCommands(self)
-        self.autoregister_all_functions(self.commands, "")
-        self.interface = interface
-        self.time = time.time()
-        self.idle_timeout = idle_timeout
-        if idle_timeout:
-            self.register_idle_function(self.handle_idle_timeout, self)
-        self.heartbeat_seconds = 1 # default, BB_HEARTBEAT_EVENT will be checked once we have a datastore.
-        self.next_heartbeat = time.time()
-
-    def addcooker(self, cooker):
-        self.cooker = cooker
-        self.commands.cooker = cooker
-
-    def autoregister_all_functions(self, context, prefix):
-        """
-        Convenience method for registering all functions in the scope
-        of this class that start with a common prefix
-        """
-        methodlist = inspect.getmembers(context, inspect.ismethod)
-        for name, method in methodlist:
-            if name.startswith(prefix):
-                self.register_function(method, name[len(prefix):])
-
-    def handle_idle_timeout(self, server, data, abort):
-        if not abort:
-            if time.time() - server.time > server.idle_timeout:
-                server.quit = True
-                print("Server idle timeout expired")
-        return []
-
-    def serve_forever(self):
-        heartbeat_event = self.cooker.data.getVar('BB_HEARTBEAT_EVENT')
-        if heartbeat_event:
-            try:
-                self.heartbeat_seconds = float(heartbeat_event)
-            except:
-                # Throwing an exception here causes bitbake to hang.
-                # Just warn about the invalid setting and continue
-                bb.warn('Ignoring invalid BB_HEARTBEAT_EVENT=%s, must be a float specifying seconds.' % heartbeat_event)
-
-        # Start the actual XMLRPC server
-        bb.cooker.server_main(self.cooker, self._serve_forever)
-
-    def _serve_forever(self):
-        """
-        Serve Requests. Overloaded to honor a quit command
-        """
-        self.quit = False
-        while not self.quit:
-            fds = [self]
-            nextsleep = 0.1
-            for function, data in list(self._idlefuns.items()):
-                retval = None
-                try:
-                    retval = function(self, data, False)
-                    if retval is False:
-                        del self._idlefuns[function]
-                    elif retval is True:
-                        nextsleep = 0
-                    elif isinstance(retval, float):
-                        if (retval < nextsleep):
-                            nextsleep = retval
-                    else:
-                        fds = fds + retval
-                except SystemExit:
-                    raise
-                except:
-                    import traceback
-                    traceback.print_exc()
-                    if retval == None:
-                        # the function execute failed; delete it
-                        del self._idlefuns[function]
-                    pass
-
-            socktimeout = self.socket.gettimeout() or nextsleep
-            socktimeout = min(socktimeout, nextsleep)
-            # Mirror what BaseServer handle_request would do
-            try:
-                fd_sets = select.select(fds, [], [], socktimeout)
-                if fd_sets[0] and self in fd_sets[0]:
-                    if self.idle_timeout:
-                        self.time = time.time()
-                    self._handle_request_noblock()
-            except IOError:
-                # we ignore interrupted calls
-                pass
-
-            # Create new heartbeat event?
-            now = time.time()
-            if now >= self.next_heartbeat:
-                # We might have missed heartbeats. Just trigger once in
-                # that case and continue after the usual delay.
-                self.next_heartbeat += self.heartbeat_seconds
-                if self.next_heartbeat <= now:
-                    self.next_heartbeat = now + self.heartbeat_seconds
-                heartbeat = bb.event.HeartbeatEvent(now)
-                bb.event.fire(heartbeat, self.cooker.data)
-            if nextsleep and now + nextsleep > self.next_heartbeat:
-                # Shorten timeout so that we we wake up in time for
-                # the heartbeat.
-                nextsleep = self.next_heartbeat - now
-
-        # Tell idle functions we're exiting
-        for function, data in list(self._idlefuns.items()):
-            try:
-                retval = function(self, data, True)
-            except:
-                pass
-        self.server_close()
-        return
-
-    def set_connection_token(self, token):
-        self.connection_token = token
-
-    def register_idle_function(self, function, data):
-        """Register a function to be called while the server is idle"""
-        assert hasattr(function, '__call__')
-        self._idlefuns[function] = data
-
-
-class BitBakeXMLRPCServerConnection(object):
-    def __init__(self, serverImpl, clientinfo=("localhost", 0), observer_only = False, featureset = None):
-        self.connection, self.transport = _create_server(serverImpl.host, serverImpl.port)
-        self.clientinfo = clientinfo
-        self.serverImpl = serverImpl
-        self.observer_only = observer_only
-        if featureset:
-            self.featureset = featureset
-        else:
-            self.featureset = []
-
-    def connect(self, token = None):
-        if token is None:
-            if self.observer_only:
-                token = "observer"
-            else:
-                token = self.connection.addClient()
-
-        if token is None:
-            return None
-
-        self.transport.set_connection_token(token)
-        return self
-
-    def setupEventQueue(self):
-        self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo)
-        for event in bb.event.ui_queue:
-            self.events.queue_event(event)
-
-        _, error = self.connection.runCommand(["setFeatures", self.featureset])
-        if error:
-            # disconnect the client, we can't make the setFeature work
-            self.connection.removeClient()
-            # no need to log it here, the error shall be sent to the client
-            raise BaseException(error)
-
-    def removeClient(self):
-        if not self.observer_only:
-            self.connection.removeClient()
-
-    def terminate(self):
-        # Don't wait for server indefinitely
-        import socket
-        socket.setdefaulttimeout(2)
-        try:
-            self.events.system_quit()
-        except:
-            pass
-        try:
-            self.connection.removeClient()
-        except:
-            pass
-
-class BitBakeServer(object):
-    def initServer(self, interface = ("localhost", 0),
-                   single_use = False, idle_timeout=0):
-        self.interface = interface
-        self.serverImpl = XMLRPCServer(interface, single_use, idle_timeout)
-
-    def detach(self):
-        daemonize.createDaemon(self.serverImpl.serve_forever, "bitbake-cookerdaemon.log")
-        del self.cooker
-
-    def establishConnection(self, featureset):
-        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, self.interface, False, featureset)
-        return self.connection.connect()
-
-    def set_connection_token(self, token):
-        self.connection.transport.set_connection_token(token)
-
-    def addcooker(self, cooker):
-        self.cooker = cooker
-        self.serverImpl.addcooker(cooker)
-
-    def getServerIdleCB(self):
-        return self.serverImpl.register_idle_function
-
-    def saveConnectionDetails(self):
-        return
-
-    def endSession(self):
-        self.connection.terminate()
-
-class BitBakeXMLRPCClient(object):
-
-    def __init__(self, observer_only = False, token = None):
-        self.token = token
-
-        self.observer_only = observer_only
-        # if we need extra caches, just tell the server to load them all
-        pass
-
-    def saveConnectionDetails(self, remote):
-        self.remote = remote
-
-    def establishConnection(self, featureset):
-        # The format of "remote" must be "server:port"
-        try:
-            [host, port] = self.remote.split(":")
-            port = int(port)
-        except Exception as e:
-            bb.warn("Failed to read remote definition (%s)" % str(e))
-            raise e
-
-        # We need our IP for the server connection. We get the IP
-        # by trying to connect with the server
-        try:
-            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
-            s.connect((host, port))
-            ip = s.getsockname()[0]
-            s.close()
-        except Exception as e:
-            bb.warn("Could not create socket for %s:%s (%s)" % (host, port, str(e)))
-            raise e
-        try:
-            self.serverImpl = XMLRPCProxyServer(host, port, use_builtin_types=True)
-            self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, featureset)
-            return self.connection.connect(self.token)
-        except Exception as e:
-            bb.warn("Could not connect to server at %s:%s (%s)" % (host, port, str(e)))
-            raise e
-
-    def endSession(self):
-        self.connection.removeClient()
-
-    def initServer(self):
-        self.serverImpl = None
-        self.connection = None
-        return
-
-    def addcooker(self, cooker):
-        self.cooker = cooker
-        self.serverImpl.addcooker(cooker)
-
-    def getServerIdleCB(self):
-        return self.serverImpl.register_idle_function
-
-    def detach(self):
-        return
-
diff --git a/lib/bb/server/xmlrpcclient.py b/lib/bb/server/xmlrpcclient.py
new file mode 100644
index 0000000..4661a9e
--- /dev/null
+++ b/lib/bb/server/xmlrpcclient.py
@@ -0,0 +1,154 @@
+#
+# BitBake XMLRPC Client Interface
+#
+# Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
+# Copyright (C) 2006 - 2008  Richard Purdie
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import os
+import sys
+
+import socket
+import http.client
+import xmlrpc.client
+
+import bb
+from bb.ui import uievent
+
+class BBTransport(xmlrpc.client.Transport):
+    def __init__(self, timeout):
+        self.timeout = timeout
+        self.connection_token = None
+        xmlrpc.client.Transport.__init__(self)
+
+    # Modified from default to pass timeout to HTTPConnection
+    def make_connection(self, host):
+        #return an existing connection if possible.  This allows
+        #HTTP/1.1 keep-alive.
+        if self._connection and host == self._connection[0]:
+            return self._connection[1]
+
+        # create a HTTP connection object from a host descriptor
+        chost, self._extra_headers, x509 = self.get_host_info(host)
+        #store the host argument along with the connection object
+        self._connection = host, http.client.HTTPConnection(chost, timeout=self.timeout)
+        return self._connection[1]
+
+    def set_connection_token(self, token):
+        self.connection_token = token
+
+    def send_content(self, h, body):
+        if self.connection_token:
+            h.putheader("Bitbake-token", self.connection_token)
+        xmlrpc.client.Transport.send_content(self, h, body)
+
+def _create_server(host, port, timeout = 60):
+    t = BBTransport(timeout)
+    s = xmlrpc.client.ServerProxy("http://%s:%d/" % (host, port), transport=t, allow_none=True, use_builtin_types=True)
+    return s, t
+
+def check_connection(remote, timeout):
+    try:
+        host, port = remote.split(":")
+        port = int(port)
+    except Exception as e:
+        bb.warn("Failed to read remote definition (%s)" % str(e))
+        raise e
+
+    server, _transport = _create_server(host, port, timeout)
+    try:
+        ret, err =  server.runCommand(['getVariable', 'TOPDIR'])
+        if err or not ret:
+            return False
+    except ConnectionError:
+        return False
+    return True
+
+class BitBakeXMLRPCServerConnection(object):
+    def __init__(self, host, port, clientinfo=("localhost", 0), observer_only = False, featureset = None):
+        self.connection, self.transport = _create_server(host, port)
+        self.clientinfo = clientinfo
+        self.observer_only = observer_only
+        if featureset:
+            self.featureset = featureset
+        else:
+            self.featureset = []
+
+        self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo)
+
+        _, error = self.connection.runCommand(["setFeatures", self.featureset])
+        if error:
+            # disconnect the client, we can't make the setFeature work
+            self.connection.removeClient()
+            # no need to log it here, the error shall be sent to the client
+            raise BaseException(error)
+
+    def connect(self, token = None):
+        if token is None:
+            if self.observer_only:
+                token = "observer"
+            else:
+                token = self.connection.addClient()
+
+        if token is None:
+            return None
+
+        self.transport.set_connection_token(token)
+        return self
+
+    def removeClient(self):
+        if not self.observer_only:
+            self.connection.removeClient()
+
+    def terminate(self):
+        # Don't wait for server indefinitely
+        socket.setdefaulttimeout(2)
+        try:
+            self.events.system_quit()
+        except:
+            pass
+        try:
+            self.connection.removeClient()
+        except:
+            pass
+
+def connectXMLRPC(remote, featureset, observer_only = False, token = None):
+    # The format of "remote" must be "server:port"
+    try:
+        [host, port] = remote.split(":")
+        port = int(port)
+    except Exception as e:
+        bb.warn("Failed to parse remote definition %s (%s)" % (remote, str(e)))
+        raise e
+
+    # We need our IP for the server connection. We get the IP
+    # by trying to connect with the server
+    try:
+        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+        s.connect((host, port))
+        ip = s.getsockname()[0]
+        s.close()
+    except Exception as e:
+        bb.warn("Could not create socket for %s:%s (%s)" % (host, port, str(e)))
+        raise e
+    try:
+        connection = BitBakeXMLRPCServerConnection(host, port, (ip, 0), observer_only, featureset)
+        return connection.connect(token)
+    except Exception as e:
+        bb.warn("Could not connect to server at %s:%s (%s)" % (host, port, str(e)))
+        raise e
+
+
+
diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
new file mode 100644
index 0000000..875b128
--- /dev/null
+++ b/lib/bb/server/xmlrpcserver.py
@@ -0,0 +1,158 @@
+#
+# BitBake XMLRPC Server Interface
+#
+# Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
+# Copyright (C) 2006 - 2008  Richard Purdie
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import os
+import sys
+
+import hashlib
+import time
+import inspect
+from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
+
+import bb
+
+# This request handler checks if the request has a "Bitbake-token" header
+# field (this comes from the client side) and compares it with its internal
+# "Bitbake-token" field (this comes from the server). If the two are not
+# equal, it is assumed that a client is trying to connect to the server
+# while another client is connected to the server. In this case, a 503 error
+# ("service unavailable") is returned to the client.
+class BitBakeXMLRPCRequestHandler(SimpleXMLRPCRequestHandler):
+    def __init__(self, request, client_address, server):
+        self.server = server
+        SimpleXMLRPCRequestHandler.__init__(self, request, client_address, server)
+
+    def do_POST(self):
+        try:
+            remote_token = self.headers["Bitbake-token"]
+        except:
+            remote_token = None
+        if 0 and remote_token != self.server.connection_token and remote_token != "observer":
+            self.report_503()
+        else:
+            if remote_token == "observer":
+                self.server.readonly = True
+            else:
+                self.server.readonly = False
+            SimpleXMLRPCRequestHandler.do_POST(self)
+
+    def report_503(self):
+        self.send_response(503)
+        response = 'No more client allowed'
+        self.send_header("Content-type", "text/plain")
+        self.send_header("Content-length", str(len(response)))
+        self.end_headers()
+        self.wfile.write(bytes(response, 'utf-8'))
+
+class BitBakeXMLRPCServer(SimpleXMLRPCServer):
+    # remove this when you're done with debugging
+    # allow_reuse_address = True
+
+    def __init__(self, interface, cooker, parent):
+        # Use auto port configuration
+        if (interface[1] == -1):
+            interface = (interface[0], 0)
+        SimpleXMLRPCServer.__init__(self, interface,
+                                    requestHandler=BitBakeXMLRPCRequestHandler,
+                                    logRequests=False, allow_none=True)
+        self.host, self.port = self.socket.getsockname()
+        self.interface = interface
+
+        self.connection_token = None
+        self.commands = BitBakeXMLRPCServerCommands(self)
+        self.register_functions(self.commands, "")
+
+        self.cooker = cooker
+        self.parent = parent
+
+
+    def register_functions(self, context, prefix):
+        """
+        Convenience method for registering all functions in the scope
+        of this class that start with a common prefix
+        """
+        methodlist = inspect.getmembers(context, inspect.ismethod)
+        for name, method in methodlist:
+            if name.startswith(prefix):
+                self.register_function(method, name[len(prefix):])
+
+    def get_timeout(self, delay):
+        socktimeout = self.socket.gettimeout() or delay
+        return min(socktimeout, delay)
+
+    def handle_requests(self):
+        self._handle_request_noblock()
+
+class BitBakeXMLRPCServerCommands():
+
+    def __init__(self, server):
+        self.server = server
+        self.has_client = False
+
+    def registerEventHandler(self, host, port):
+        """
+        Register a remote UI Event Handler
+        """
+        s, t = bb.server.xmlrpcclient._create_server(host, port)
+
+        # we don't allow connections if the cooker is running
+        if (self.server.cooker.state in [bb.cooker.state.parsing, bb.cooker.state.running]):
+            return None, "Cooker is busy: %s" % bb.cooker.state.get_name(self.server.cooker.state)
+
+        self.event_handle = bb.event.register_UIHhandler(s, True)
+        return self.event_handle, 'OK'
+
+    def unregisterEventHandler(self, handlerNum):
+        """
+        Unregister a remote UI Event Handler
+        """
+        ret = bb.event.unregister_UIHhandler(handlerNum, True)
+        self.event_handle = None
+        return ret
+
+    def runCommand(self, command):
+        """
+        Run a cooker command on the server
+        """
+        return self.server.cooker.command.runCommand(command, self.server.readonly)
+
+    def getEventHandle(self):
+        return self.event_handle
+
+    def terminateServer(self):
+        """
+        Trigger the server to quit
+        """
+        self.server.parent.quit = True
+        print("XMLRPC Server triggering exit")
+        return
+
+    def addClient(self):
+        if self.server.parent.haveui:
+            return None
+        token = hashlib.md5(str(time.time()).encode("utf-8")).hexdigest()
+        self.server.connection_token = token
+        self.server.parent.haveui = True
+        return token
+
+    def removeClient(self):
+        if self.server.parent.haveui:
+            self.server.connection_token = None
+            self.server.parent.haveui = False
+
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index fb0da62..303ce02 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -243,7 +243,7 @@ class Tinfoil:
         cookerconfig = CookerConfiguration()
         cookerconfig.setConfigParameters(config_params)
 
-        server, self.server_connection, ui_module = setup_bitbake(config_params,
+        self.server_connection, ui_module = setup_bitbake(config_params,
                             cookerconfig,
                             extrafeatures,
                             setup_logging=False)
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index a7efa58..5f061c2 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -6,7 +6,7 @@ import queue
 import socket
 import io
 import sqlite3
-import bb.server.xmlrpc
+import bb.server.xmlrpcclient
 import prserv
 import prserv.db
 import errno
@@ -300,7 +300,7 @@ class PRServerConnection(object):
             host, port = singleton.getinfo()
         self.host = host
         self.port = port
-        self.connection, self.transport = bb.server.xmlrpc._create_server(self.host, self.port)
+        self.connection, self.transport = bb.server.xmlrpcclient._create_server(self.host, self.port)
 
     def terminate(self):
         try:
-- 
2.7.4


