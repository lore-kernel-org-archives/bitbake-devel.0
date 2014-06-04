Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id CFB196FA56
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Jun 2014 14:47:03 +0000 (UTC)
Received: by mail-wg0-f47.google.com with SMTP id x12so8633509wgg.30
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Jun 2014 07:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QV7v5jF2ki+K+VxSC83q3hul6+GVNq/HTN/ZztwZx7I=;
	b=MsAdn95Zf0VGTDETPkbzk8uCuQJ568pyIyPOQHRG9fSbBfKfdQt3RYpI+WhcJyxOtJ
	QdN+BVEzh+JqdH343+g9LEj9eifTkSQz2c1TUo8z/4kR8LYyGYa9VauqfU41+FZ7nq6W
	w0f6nAPA8Wmw4DyDdmQLmkXOLnCOUZE8qC7YS7py8jtkmQBFOUfi4bxpsKpWcCO/yeqB
	hQ3APsxCzlUKF5qA0hCj7Tn0wowAiYKx/dKDaRXF6cSg75bWZLEcE8etNaT0IzD55U9F
	NpHpq6CZUW7Cz07HosFvV2a+biyvU/KF3B2a4y3nAeMaVnmhgyOmhIVQWWMcNIGs5k+e
	tFww==
X-Gm-Message-State: ALoCoQlb3f3g2SeiJTrNGwjy5hyy8BAfPsp6gMuCAlsWiFMGCX2KwuhNTSDU3VPFvlkITumIUPwn
X-Received: by 10.180.89.241 with SMTP id br17mr6212613wib.0.1401893222867;
	Wed, 04 Jun 2014 07:47:02 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id d6sm10059065wiz.4.2014.06.04.07.47.01
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 04 Jun 2014 07:47:01 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 9363F56070F; Wed,  4 Jun 2014 15:47:03 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Jun 2014 15:47:02 +0100
Message-Id: <1401893222-23438-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <553c5d33afe658883ceab81d0fe8b0318300dbe7.1401808899.git.alexandru.damian@intel.com>
References: <553c5d33afe658883ceab81d0fe8b0318300dbe7.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/9 v2] xmlrpc: client - remove fatal errors
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
X-List-Received-Date: Wed, 04 Jun 2014 14:47:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

When we use the XMLRPC client API to connect to a bitbake server,
we want to receive errors from the API instead of having the
API exiting without warning.

Thus the "bb.fatal" calls have been replaced with "bb.warn" calls,
and we re-raise the original exception for handling by the
original caller.

The bitbake starting script has been modified to properly test
for failures in calling the client API and handle them.

Additional error handling added in the client, as to prevent
fatal crashes.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake             | 23 +++++++++++++----------
 lib/bb/server/xmlrpc.py | 21 ++++++++++++++-------
 lib/bb/ui/uievent.py    |  3 ++-
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index fcfe043..ab881c5 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -332,26 +332,29 @@ def main():
         server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
         server.saveConnectionDetails(configParams.remote_server)
 
+    def _getServerConnection(server, featureset):
+        try:
+            server_connection = server.establishConnection(featureset)
+        except Exception as e:
+            bb.fatal("Could not connect to server %s: %s" % (configParams.remote_server, str(e)))
+        return server_connection
+
     if not configParams.server_only:
         if configParams.status_only:
-            try:
-                server_connection = server.establishConnection(featureset)
-            except:
-                sys.exit(1)
-            if not server_connection:
-                sys.exit(1)
+            server_connection = _getServerConnection(server, featureset)
             server_connection.terminate()
             sys.exit(0)
 
         # Setup a connection to the server (cooker)
-        server_connection = server.establishConnection(featureset)
-        if not server_connection:
+        try:
+            server_connection = server.establishConnection(featureset)
+        except:
             if configParams.kill_server:
-                bb.fatal("Server already killed")
+                bb.fatal("Server already offline")
             configParams.bind = configParams.remote_server
             start_server(servermodule, configParams, configuration, featureset)
             bb.event.ui_queue = []
-            server_connection = server.establishConnection(featureset)
+            server_connection = _getServerConnection(server, featureset)
 
         # Restore the environment in case the UI needs it
         for k in cleanedvars:
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 6fc5543..d6f4338 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -80,7 +80,7 @@ class BBTransport(xmlrpclib.Transport):
 
 def _create_server(host, port, timeout = 60):
     t = BBTransport(timeout)
-    s = xmlrpclib.Server("http://%s:%d/" % (host, port), transport=t, allow_none=True)
+    s = xmlrpclib.ServerProxy("http://%s:%d/" % (host, port), transport=t, allow_none=True)
     return s, t
 
 class BitBakeServerCommands():
@@ -253,9 +253,13 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
             socktimeout = self.socket.gettimeout() or nextsleep
             socktimeout = min(socktimeout, nextsleep)
             # Mirror what BaseServer handle_request would do
-            fd_sets = select.select(fds, [], [], socktimeout)
-            if fd_sets[0] and self in fd_sets[0]:
-                self._handle_request_noblock()
+            try:
+                fd_sets = select.select(fds, [], [], socktimeout)
+                if fd_sets[0] and self in fd_sets[0]:
+                    self._handle_request_noblock()
+            except IOError:
+                # we ignore interrupted calls
+                pass
 
         # Tell idle functions we're exiting
         for function, data in self._idlefuns.items():
@@ -346,7 +350,8 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
             [host, port] = self.remote.split(":")
             port = int(port)
         except Exception as e:
-            bb.fatal("Failed to read remote definition (%s)" % str(e))
+            bb.warn("Failed to read remote definition (%s)" % str(e))
+            raise e
 
         # We need our IP for the server connection. We get the IP
         # by trying to connect with the server
@@ -356,13 +361,15 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
             ip = s.getsockname()[0]
             s.close()
         except Exception as e:
-            bb.fatal("Could not create socket for %s:%s (%s)" % (host, port, str(e)))
+            bb.warn("Could not create socket for %s:%s (%s)" % (host, port, str(e)))
+            raise e
         try:
             self.serverImpl = XMLRPCProxyServer(host, port)
             self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, featureset)
             return self.connection.connect()
         except Exception as e:
-            bb.fatal("Could not connect to server at %s:%s (%s)" % (host, port, str(e)))
+            bb.warn("Could not connect to server at %s:%s (%s)" % (host, port, str(e)))
+            raise e
 
     def endSession(self):
         self.connection.removeClient()
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index 98658f6..eb760c0 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -47,7 +47,8 @@ class BBUIEventQueue:
         self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port)
 
         if (self.EventHandle == None):
-            bb.fatal("Could not register UI event handler")
+            bb.warn("Could not register UI event handler %s:%d" % (self.host, self.port))
+            raise Exception("Could not register UI event handler")
 
         self.server = server
 
-- 
1.9.1


