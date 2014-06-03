Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id EC8BF6B8A5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:17 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id bs8so6278232wib.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=BjN1cgSM9QQ2rkYz9F+5c1GkAsSlLBqFoskv9CBvhYM=;
	b=jHAZA7djvYnVmhIeSFJAlLEa7kGETRTDlSqXs1l25rk4x6QfFFbYpkLmW2nyOehQIz
	vQnz/ZDO176ZTnyaEoe8wcf2rW5ovuldIMY6Y7fWNwr0HhWjG21RcWoCzyuzIzR8fq4w
	MLQbhT1d8r+ipH3ZhcoYyNzJ0T2qT5VuqpXXmGY6HFaUHqXz+0cOuX+0P4S2B426CmyS
	gm5Q+hp/9EI4PHRIuvq7xOGdDJX/lBBqbujm+ud/8AOQE1QOSj8vITtNxrAayq3953Vw
	+eVfQP22v9wfOa2g7thiS39gObIGN3TJx/9dFdy6nvcYCgzsE6Aio8txkHiLTNZZCD9W
	o2LQ==
X-Gm-Message-State: ALoCoQkYBwghj5hakObk67GGCYTdlA9Md95ClqtZponK25eeXjwbCluOaXzGXFl+0dIGxCleWX3A
X-Received: by 10.194.84.101 with SMTP id x5mr61386585wjy.52.1401809178470;
	Tue, 03 Jun 2014 08:26:18 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id l2sm3749362wix.13.2014.06.03.08.26.16
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:17 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id C9B39560511; Tue,  3 Jun 2014 16:26:18 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:11 +0100
Message-Id: <553c5d33afe658883ceab81d0fe8b0318300dbe7.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1401808899.git.alexandru.damian@intel.com>
References: <cover.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/9] xmlrpc: client - remove fatal errors
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
X-List-Received-Date: Tue, 03 Jun 2014 15:26:22 -0000

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
 lib/bb/server/xmlrpc.py | 22 +++++++++++++++-------
 lib/bb/ui/uievent.py    |  3 ++-
 3 files changed, 30 insertions(+), 18 deletions(-)

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
index 6fc5543..6ec3452 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -80,7 +80,7 @@ class BBTransport(xmlrpclib.Transport):
 
 def _create_server(host, port, timeout = 60):
     t = BBTransport(timeout)
-    s = xmlrpclib.Server("http://%s:%d/" % (host, port), transport=t, allow_none=True)
+    s = xmlrpclib.ServerProxy("http://%s:%d/" % (host, port), transport=t, allow_none=True)
     return s, t
 
 class BitBakeServerCommands():
@@ -253,13 +253,18 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
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
             try:
+                print "Running idle funcs", function, data
                 retval = function(self, data, True)
             except:
                 pass
@@ -346,7 +351,8 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
             [host, port] = self.remote.split(":")
             port = int(port)
         except Exception as e:
-            bb.fatal("Failed to read remote definition (%s)" % str(e))
+            bb.warn("Failed to read remote definition (%s)" % str(e))
+            raise e
 
         # We need our IP for the server connection. We get the IP
         # by trying to connect with the server
@@ -356,13 +362,15 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
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


