Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>)
	id 1QQ498-00075Q-AE; Fri, 27 May 2011 23:00:39 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 27 May 2011 13:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,282,1304319600"; d="scan'208,223";a="6013044"
Received: from vorpal.jf.intel.com (HELO [10.7.199.68]) ([10.7.199.68])
	by orsmga001.jf.intel.com with ESMTP; 27 May 2011 13:57:32 -0700
From: Joshua Lock <josh@linux.intel.com>
To: openembedded-core@lists.openembedded.org
Date: Fri, 27 May 2011 14:01:03 -0700
In-Reply-To: <1306526949.1747.8.camel@vorpal>
References: <cover.1306477652.git.lianhao.lu@intel.com>
	<1306515635.27470.284.camel@rex>
	<7DC6724C-BF20-4EA1-A87D-32FBEEECDA3B@dominion.thruhere.net>
	<1306526949.1747.8.camel@vorpal>
X-Mailer: Evolution 3.0.1 (3.0.1-1.fc15) 
Message-ID: <1306530063.1747.13.camel@vorpal>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 00/11] Add PR service and integrate PKGV/PKGR from OE
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 27 May 2011 21:00:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 4c0915842cd578e67fc9cc85d24538e419a47af8 Mon Sep 17 00:00:00 2001
From: Joshua Lock <josh@linux.intel.com>
Date: Fri, 27 May 2011 13:03:55 -0700
Subject: [PATCH 1/2] server: add updated/fixed xmlrpc server from Poky

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/server/xmlrpc.py |  273
+++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 273 insertions(+), 0 deletions(-)
 create mode 100644 lib/bb/server/xmlrpc.py

diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
new file mode 100644
index 0000000..c43c6cd
--- /dev/null
+++ b/lib/bb/server/xmlrpc.py
@@ -0,0 +1,273 @@
+#
+# BitBake XMLRPC Server
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
+# You should have received a copy of the GNU General Public License
along
+# with this program; if not, write to the Free Software Foundation,
Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+"""
+    This module implements an xmlrpc server for BitBake.
+
+    Use this by deriving a class from BitBakeXMLRPCServer and then
adding
+    methods which you want to "export" via XMLRPC. If the methods have
the
+    prefix xmlrpc_, then registering those function will happen
automatically,
+    if not, you need to call register_function.
+
+    Use register_idle_function() to add a function which the xmlrpc
server
+    calls from within server_forever when no requests are pending. Make
sure
+    that those functions are non-blocking or else you will introduce
latency
+    in the server's main loop.
+"""
+
+import bb
+import xmlrpclib, sys
+from bb import daemonize
+from bb.ui import uievent
+
+DEBUG = False
+
+from SimpleXMLRPCServer import SimpleXMLRPCServer,
SimpleXMLRPCRequestHandler
+import inspect, select
+
+if sys.hexversion < 0x020600F0:
+    print("Sorry, python 2.6 or later is required for bitbake's XMLRPC
mode")
+    sys.exit(1)
+
+##
+# The xmlrpclib.Transport class has undergone various changes in Python
2.7
+# which break BitBake's XMLRPC implementation.
+# To work around this we subclass Transport and have a copy/paste of
method
+# implementations from Python 2.6.6's xmlrpclib.
+#
+# Upstream Python bug is #8194 (http://bugs.python.org/issue8194)
+# This bug is relevant for Python 2.7.0 and 2.7.1 but was fixed for
+# Python > 2.7.2
+##
+
+class BBTransport(xmlrpclib.Transport):
+    def request(self, host, handler, request_body, verbose=0):
+        h = self.make_connection(host)
+        if verbose:
+            h.set_debuglevel(1)
+
+        self.send_request(h, handler, request_body)
+        self.send_host(h, host)
+        self.send_user_agent(h)
+        self.send_content(h, request_body)
+
+        errcode, errmsg, headers = h.getreply()
+
+        if errcode != 200:
+            raise ProtocolError(
+                host + handler,
+                errcode, errmsg,
+                headers
+                )
+
+        self.verbose = verbose
+
+        try:
+            sock = h._conn.sock
+        except AttributeError:
+            sock = None
+
+        return self._parse_response(h.getfile(), sock)
+
+    def make_connection(self, host):
+        import httplib
+        host, extra_headers, x509 = self.get_host_info(host)
+        return httplib.HTTP(host)
+
+    def _parse_response(self, file, sock):
+        p, u = self.getparser()
+
+        while 1:
+            if sock:
+                response = sock.recv(1024)
+            else:
+                response = file.read(1024)
+            if not response:
+                break
+            if self.verbose:
+                print "body:", repr(response)
+            p.feed(response)
+
+        file.close()
+        p.close()
+
+        return u.close()
+
+def _create_server(host, port):
+    # Python 2.7.0 and 2.7.1 have a buggy Transport implementation
+    # For those versions of Python, and only those versions, use our
+    # own copy/paste BBTransport class.
+    if (2, 7, 0) <= sys.version_info < (2, 7, 2):
+        t = BBTransport()
+        s = xmlrpclib.Server("http://%s:%d/" % (host, port),
transport=t, allow_none=True)
+    else:
+        s = xmlrpclib.Server("http://%s:%d/" % (host, port),
allow_none=True)
+
+    return s
+
+class BitBakeServerCommands():
+    def __init__(self, server, cooker):
+        self.cooker = cooker
+        self.server = server
+
+    def registerEventHandler(self, host, port):
+        """
+        Register a remote UI Event Handler
+        """
+        s = _create_server(host, port)
+
+        return bb.event.register_UIHhandler(s)
+
+    def unregisterEventHandler(self, handlerNum):
+        """
+        Unregister a remote UI Event Handler
+        """
+        return bb.event.unregister_UIHhandler(handlerNum)
+
+    def runCommand(self, command):
+        """
+        Run a cooker command on the server
+        """
+        return self.cooker.command.runCommand(command)
+
+    def terminateServer(self):
+        """
+        Trigger the server to quit
+        """
+        self.server.quit = True
+        print("Server (cooker) exiting")
+        return
+
+    def ping(self):
+        """
+        Dummy method which can be used to check the server is still
alive
+        """
+        return True
+
+class BitBakeServer(SimpleXMLRPCServer):
+    # remove this when you're done with debugging
+    # allow_reuse_address = True
+
+    def __init__(self, cooker, interface = ("localhost", 0)):
+        """
+        Constructor
+        """
+        SimpleXMLRPCServer.__init__(self, interface,
+
requestHandler=SimpleXMLRPCRequestHandler,
+                                    logRequests=False, allow_none=True)
+        self._idlefuns = {}
+        self.host, self.port = self.socket.getsockname()
+        #self.register_introspection_functions()
+        commands = BitBakeServerCommands(self, cooker)
+        self.autoregister_all_functions(commands, "")
+        self.cooker = cooker
+
+    def autoregister_all_functions(self, context, prefix):
+        """
+        Convenience method for registering all functions in the scope
+        of this class that start with a common prefix
+        """
+        methodlist = inspect.getmembers(context, inspect.ismethod)
+        for name, method in methodlist:
+            if name.startswith(prefix):
+                self.register_function(method, name[len(prefix):])
+
+    def register_idle_function(self, function, data):
+        """Register a function to be called while the server is idle"""
+        assert hasattr(function, '__call__')
+        self._idlefuns[function] = data
+
+    def serve_forever(self):
+        bb.cooker.server_main(self.cooker, self._serve_forever)
+
+    def _serve_forever(self):
+        """
+        Serve Requests. Overloaded to honor a quit command
+        """
+        self.quit = False
+        self.timeout = 0 # Run Idle calls for our first callback
+        while not self.quit:
+            #print "Idle queue length %s" % len(self._idlefuns)
+            self.handle_request()
+            #print "Idle timeout, running idle functions"
+            nextsleep = None
+            for function, data in self._idlefuns.items():
+                try:
+                    retval = function(self, data, False)
+                    if retval is False:
+                        del self._idlefuns[function]
+                    elif retval is True:
+                        nextsleep = 0
+                    elif nextsleep is 0:
+                        continue
+                    elif nextsleep is None:
+                        nextsleep = retval
+                    elif retval < nextsleep:
+                        nextsleep = retval
+                except SystemExit:
+                    raise
+                except:
+                    import traceback
+                    traceback.print_exc()
+                    pass
+            if nextsleep is None and len(self._idlefuns) > 0:
+                nextsleep = 0
+            self.timeout = nextsleep
+        # Tell idle functions we're exiting
+        for function, data in self._idlefuns.items():
+            try:
+                retval = function(self, data, True)
+            except:
+                pass
+
+        self.server_close()
+        return
+
+class BitbakeServerInfo():
+    def __init__(self, server):
+        self.host = server.host
+        self.port = server.port
+
+class BitBakeServerFork():
+    def __init__(self, cooker, server, serverinfo, logfile):
+        daemonize.createDaemon(server.serve_forever, logfile)
+
+class BitbakeUILauch():
+    def launch(self, serverinfo, uifunc, *args):
+        return uifunc(*args)
+
+class BitBakeServerConnection():
+    def __init__(self, serverinfo):
+        self.connection = _create_server(serverinfo.host,
serverinfo.port)
+        self.events = uievent.BBUIEventQueue(self.connection)
+        for event in bb.event.ui_queue:
+            self.events.queue_event(event)
+
+    def terminate(self):
+        # Don't wait for server indefinitely
+        import socket
+        socket.setdefaulttimeout(2)
+        try:
+            self.events.system_quit()
+        except:
+            pass
+        try:
+            self.connection.terminateServer()
+        except:
+            pass
-- 
1.7.5.1




