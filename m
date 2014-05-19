Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (unknown [209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 8C331660EF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 13:36:55 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id bs8so4147825wib.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 06:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=wZGqfsoJAw0ZEDhQV4z4UKak/J7hw8gd3T3y6uu38Ek=;
	b=OAg1lPcWFF+5IlhevWpAX9kXr3MsLOPAO7jXnskadXyrttMnSp6eRwz8UnRgH5hhr4
	5dIgSeELc+wS8aqjbH7Y2+CKpexkiopmlQPOXfQfsfgT5NqS/7q9r/gS4kUlKYn4l/Cy
	PHdJzwLadGI7IVt6cT6a5tifb4EoFHHlQUEhWN/KjYiELRd/vyPM94ajQ0CgtyKUlU4v
	kZZcPcUrmj0VRmpf+0zuFqnkrGyeqY683Hl3MIV67Bbx1FLKVKS0nvh038/I0dasociL
	RE/thHpeh21USSciTc0703hUbsG3Txsq6vL6sFsVxuG01I3v2vIXo3GMSFfSmHG6mmOc
	yXLQ==
X-Gm-Message-State: ALoCoQkmd8Z7sK8CwV8UmzuYr1BMdC6R7y0Qu7263HxfbKINodZB662JqNpwh/15vAeSLrTm5Q3i
X-Received: by 10.194.187.240 with SMTP id fv16mr2123083wjc.81.1400506616358; 
	Mon, 19 May 2014 06:36:56 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	t18sm15117742wiv.16.2014.05.19.06.36.54 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 19 May 2014 06:36:55 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id BCBF4560414; Mon, 19 May 2014 14:36:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 May 2014 14:36:53 +0100
Message-Id: <5ccf35ec29c77252d506b29e39b2c5d3fb162eee.1400506418.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <69b012dcfa40fc9f8ccf34ec1dc5422755c2e4b7.1400506418.git.alexandru.damian@intel.com>
References: <69b012dcfa40fc9f8ccf34ec1dc5422755c2e4b7.1400506418.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1400506418.git.alexandru.damian@intel.com>
References: <cover.1400506418.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/2] xmlrpc: client - remove fatal errors
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
X-List-Received-Date: Mon, 19 May 2014 13:36:58 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

When we use the XMLRPC client API to connect to a bitbake server,
we want to receive errors from the API instead of having the
API exiting without warning.

Thus the "bb.fatal" calls have been replaced with "bb.warn" calls,
and we re-raise the original exception for handling by the
original caller.

The bitbake starting script has been modified to properly test
for failures in calling the client API and handle them.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake             | 23 +++++++++++++----------
 lib/bb/server/xmlrpc.py |  9 ++++++---
 2 files changed, 19 insertions(+), 13 deletions(-)

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
index 6fc5543..379544a 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -346,7 +346,8 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
             [host, port] = self.remote.split(":")
             port = int(port)
         except Exception as e:
-            bb.fatal("Failed to read remote definition (%s)" % str(e))
+            bb.warn("Failed to read remote definition (%s)" % str(e))
+            raise e
 
         # We need our IP for the server connection. We get the IP
         # by trying to connect with the server
@@ -356,13 +357,15 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
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
-- 
1.9.1


