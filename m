Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id B5D6F6FA5E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 13:51:59 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id r20so1652519wiv.10
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=3wwtvzxvSEMXaZTqtDJb0dcJzyetuPFk3JE9icj3Wow=;
	b=WPDJeip1n3dCt1hQLMFHDJexytSKnX2kKyRC3o8VFKw1WIRgvlx/45JGtmxReizere
	a7uUf95ZPTFH4BUUfwevrGOmPg4v2Ex9U7Jt2bE6f1hibdDwWRz2aSJgksVKH9Zl+u3h
	FeBlZck9hgATesRFMDrvCcNSVs8PidTBXTfVkMBvGHOg6FJBiL6ezrjQ7k6xCBpeuG4o
	ziienbvHdMmF61hDgjRw3swVdF33tvBQJwU+oy59xvlskJx1dZ6TQoY1bmZBNAmczAfM
	8GBYjuIRgMN61dCZ8Skm59Bn6TZyedNslTxS1KRUquZJ4F0v8AW8/8Oq2gW6yMCnHvKd
	nFLg==
X-Gm-Message-State: ALoCoQn06jHo5XGqyTERmyZf3F6XCuiHchqysdRLWiVV9J0f3ewHv9iqjtvwPb+tZGn5jknIdQjb
X-Received: by 10.180.74.6 with SMTP id p6mr6824170wiv.17.1402581120135;
	Thu, 12 Jun 2014 06:52:00 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id a6sm4207007wic.13.2014.06.12.06.51.58
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Jun 2014 06:51:58 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id A9A52561141; Thu, 12 Jun 2014 14:52:03 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Thu, 12 Jun 2014 14:52:00 +0100
Message-Id: <db5390940c0afbcdc9fbcf1225761968ae51d4a7.1402580802.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
References: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1402580802.git.alexandru.damian@intel.com>
References: <cover.1402580802.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/6] xmlrpc: add support for token reusing
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
X-List-Received-Date: Thu, 12 Jun 2014 13:52:00 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add support to specify a connection token in the command line
and in the environment variable BBTOKEN.

When a client registers to a bitbake server, that client
will have exclusive access to the server. The client is identified
by a server-supplied token. If a client terminates, we cannot
reconnect to the server as the token is lost.

This patch adds the capability to specify the connection token
in the command line for xmlrpc clients. This allows us
to have bitbake work as an already-authenticated
client with the server and resume sending commands to a server.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake             |  8 +++++++-
 lib/bb/server/xmlrpc.py | 19 ++++++++++++-------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index f120bac..b3acbe1 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -169,6 +169,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-t", "--servertype", help = "Choose which server to use, process or xmlrpc.",
                    action = "store", dest = "servertype")
 
+        parser.add_option("", "--token", help = "Specify the connection token to be used when connecting to a remote server.",
+                   action = "store", dest = "xmlrpctoken")
+
         parser.add_option("", "--revisions-changed", help = "Set the exit code depending on whether upstream floating revisions have changed or not.",
                    action = "store_true", dest = "revisions_changed", default = False)
 
@@ -200,6 +203,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
             options.servertype = "xmlrpc"
             options.remote_server = os.environ["BBSERVER"]
 
+        if "BBTOKEN" in os.environ:
+            options.xmlrpctoken = os.environ["BBTOKEN"]
+
         # if BBSERVER says to autodetect, let's do that
         if options.remote_server:
             [host, port] = options.remote_server.split(":", 2)
@@ -332,7 +338,7 @@ def main():
         bb.event.ui_queue = []
     else:
         # we start a stub server that is actually a XMLRPClient that connects to a real server
-        server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
+        server = servermodule.BitBakeXMLRPCClient(configParams.observe_only, configParams.xmlrpctoken)
         server.saveConnectionDetails(configParams.remote_server)
 
 
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index d6f4338..4205a4c 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -281,13 +281,16 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
         self.observer_only = observer_only
         self.featureset = featureset
 
-    def connect(self):
-        if not self.observer_only:
-            token = self.connection.addClient()
-        else:
-            token = "observer"
+    def connect(self, token = None):
+        if token is None:
+            if self.observer_only:
+                token = "observer"
+            else:
+                token = self.connection.addClient()
+
         if token is None:
             return None
+
         self.transport.set_connection_token(token)
 
         self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo)
@@ -336,7 +339,9 @@ class BitBakeServer(BitBakeBaseServer):
 
 class BitBakeXMLRPCClient(BitBakeBaseServer):
 
-    def __init__(self, observer_only = False):
+    def __init__(self, observer_only = False, token = None):
+        self.token = token
+
         self.observer_only = observer_only
         # if we need extra caches, just tell the server to load them all
         pass
@@ -366,7 +371,7 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
         try:
             self.serverImpl = XMLRPCProxyServer(host, port)
             self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, featureset)
-            return self.connection.connect()
+            return self.connection.connect(self.token)
         except Exception as e:
             bb.warn("Could not connect to server at %s:%s (%s)" % (host, port, str(e)))
             raise e
-- 
1.9.1


