Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B29176DD17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 21:21:34 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rAPLLYMD015163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 13:21:34 -0800 (PST)
Received: from ord-jrw.corp.ad.wrs.com (172.25.32.36) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.2.347.0; Mon, 25 Nov 2013 13:21:34 -0800
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 15:21:27 -0600
Message-ID: <1385414489-2901-4-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
References: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/5] bitbake, xmlrpc.py: Implement memory resident auto port configuration/restart
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
X-List-Received-Date: Mon, 25 Nov 2013 21:21:35 -0000
Content-Type: text/plain

This patch adds the ability to dynamically select a port for the
bitbake memory resident server when the BBSERVER port is set to -1.
This allows for running multiple instances of the bitbake memory
resident server on the same system in different build directories.

The client portion of the bitbake instance can also request that the
server automatically start when using the auto port feature.  This is
to deal with a bitbake instance that eventually times out and exits or
that has died for some unknown reason.

The new functionality allows for lazy startup of the server after
sourcing the init script for the memory resident functionality.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 bin/bitbake             |   10 ++++++++++
 lib/bb/server/xmlrpc.py |   33 +++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 21fe3ab..5857b92 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -304,6 +304,7 @@ def main():
         # we start a stub server that is actually a XMLRPClient that connects to a real server
         server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
         server.saveConnectionDetails(configParams.remote_server)
+        server.saveConnectionConfigParams(configParams)
 
     if not configParams.server_only:
         # Collect the feature set for the UI
@@ -314,11 +315,20 @@ def main():
                 server_connection = server.establishConnection(featureset)
             except:
                 sys.exit(1)
+            if not server_connection:
+                sys.exit(1)
             server_connection.terminate()
             sys.exit(0)
 
         # Setup a connection to the server (cooker)
         server_connection = server.establishConnection(featureset)
+        if not server_connection:
+            if configParams.kill_server:
+                bb.fatal("Server already killed")
+            configParams.bind = configParams.remote_server
+            start_server(servermodule, configParams, configuration)
+            bb.event.ui_queue = []
+            server_connection = server.establishConnection(featureset)
 
         # Restore the environment in case the UI needs it
         for k in cleanedvars:
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 54b0f88..46d074a 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -341,13 +341,38 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
     def saveConnectionDetails(self, remote):
         self.remote = remote
 
+    def saveConnectionConfigParams(self, configParams):
+        self.configParams = configParams
+
     def establishConnection(self, featureset):
         # The format of "remote" must be "server:port"
         try:
             [host, port] = self.remote.split(":")
             port = int(port)
-        except:
-            return None
+        except Exception as e:
+            bb.fatal("Failed to read remote definition (%s)" % str(e))
+
+        # use automatic port if port set to -1, meaning read it from
+        # the bitbake.lock file
+        if port == -1:
+            lock_location = "%s/bitbake.lock" % self.configParams.environment.get('BUILDDIR')
+            lock = bb.utils.lockfile(lock_location, False, False)
+            if lock:
+                # This means there is no server running which we can
+                # connect to on the local system.
+                bb.utils.unlockfile(lock)
+                return None
+
+            try:
+                lf = open(lock_location, 'r')
+                remotedef = lf.readline()
+                [host, port] = remotedef.split(":")
+                port = int(port)
+                lf.close()
+                self.remote = remotedef
+            except Exception as e:
+                bb.fatal("Failed to read bitbake.lock (%s)" % str(e))
+
         # We need our IP for the server connection. We get the IP
         # by trying to connect with the server
         try:
@@ -355,8 +380,8 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
             s.connect((host, port))
             ip = s.getsockname()[0]
             s.close()
-        except:
-            return None
+        except Exception as e:
+            bb.fatal("Could not create socket for %s:%s (%s)" % (host, port, str(e)))
         try:
             self.serverImpl = XMLRPCProxyServer(host, port)
             self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, featureset)
-- 
1.7.9.5


