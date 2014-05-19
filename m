Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (unknown [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 0CDA166003
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 13:36:55 +0000 (UTC)
Received: by mail-wg0-f43.google.com with SMTP id l18so7755439wgh.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 May 2014 06:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IlflnXsTnDdOb+eVpKXP7BitD3ZCpb+OxydGS9OcjfU=;
	b=fKtW6m5IdkmWrLXKhRCkEHQpvf6orZWDdcTHx6qmF4Zg0ZI7Rkbgb5rVDrpLCz9o8P
	Z9imSRryHRW1CYJ3/jhWKYyxMAU+q+6bUNdoZn6zog0/vh4n50gprTXRJi+wv+91e0GJ
	HIquQ2uLjRDclAwvL/6IJyFJ75VLNYys3IQGX3dHJYWdKP/e+Op5uh7xhigJOsC3oTbn
	6bzFOKAPCIFsFGn+m/y0QPibQEGqaBLWDRzrjwpW8wLvJrepbQVE+cucFtCQRzW0w7ju
	UJZICkPZbIzzJm6JxiautgpTrxaYzbPkps1F3r2Wa8TuKDx/87KT/P/XIBGboh/sUinR
	M8YQ==
X-Gm-Message-State: ALoCoQm+xSG3wgUnU69fNk2CJZdwSQFILXp8sE0RivYvcBk2H+/4Op/BsPeBzCIA5XYF/wrIJt1w
X-Received: by 10.180.186.8 with SMTP id fg8mr13016905wic.39.1400506615913;
	Mon, 19 May 2014 06:36:55 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id j3sm14180031wjw.38.2014.05.19.06.36.54
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 19 May 2014 06:36:55 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id BB03B5603B0; Mon, 19 May 2014 14:36:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 May 2014 14:36:52 +0100
Message-Id: <69b012dcfa40fc9f8ccf34ec1dc5422755c2e4b7.1400506418.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1400506418.git.alexandru.damian@intel.com>
References: <cover.1400506418.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/2] bitbake: move configuration reading code
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

The configuration reading code should live in the
main bitbake entry point, and the server modules should
be supplied with correct configuration instead of attempting
to parse from configuration files.

This patch moves the endpoint address reading from XMLRPC
to the bitbake main script.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake             | 23 ++++++++++++++++++++++-
 lib/bb/server/xmlrpc.py | 24 ------------------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 86d32cf..fcfe043 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -200,6 +200,28 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
             options.servertype = "xmlrpc"
             options.remote_server = os.environ["BBSERVER"]
 
+        # if BBSERVER says to autodetect, let's do that
+        if options.remote_server:
+            [host, port] = options.remote_server.split(":", 2)
+            port = int(port)
+            # use automatic port if port set to -1, means read it from
+            # the bitbake.lock file; this is a bit tricky, but we always expect
+            # to be in the base of the build directory if we need to have a
+            # chance to start the server later, anyway
+            if port == -1:
+                lock_location = "./bitbake.lock"
+                # we try to read the address at all times; if the server is not started,
+                # we'll try to start it after the first connect fails, below
+                try:
+                    lf = open(lock_location, 'r')
+                    remotedef = lf.readline()
+                    [host, port] = remotedef.split(":")
+                    port = int(port)
+                    lf.close()
+                    options.remote_server = remotedef
+                except Exception as e:
+                    sys.exit("Failed to read bitbake.lock (%s), invalid port" % str(e))
+
         return options, targets[1:]
 
 
@@ -309,7 +331,6 @@ def main():
         # we start a stub server that is actually a XMLRPClient that connects to a real server
         server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
         server.saveConnectionDetails(configParams.remote_server)
-        server.saveConnectionConfigParams(configParams)
 
     if not configParams.server_only:
         if configParams.status_only:
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 5dcaa6c..6fc5543 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -340,9 +340,6 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
     def saveConnectionDetails(self, remote):
         self.remote = remote
 
-    def saveConnectionConfigParams(self, configParams):
-        self.configParams = configParams
-
     def establishConnection(self, featureset):
         # The format of "remote" must be "server:port"
         try:
@@ -351,27 +348,6 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
         except Exception as e:
             bb.fatal("Failed to read remote definition (%s)" % str(e))
 
-        # use automatic port if port set to -1, meaning read it from
-        # the bitbake.lock file
-        if port == -1:
-            lock_location = "%s/bitbake.lock" % self.configParams.environment.get('BUILDDIR')
-            lock = bb.utils.lockfile(lock_location, False, False)
-            if lock:
-                # This means there is no server running which we can
-                # connect to on the local system.
-                bb.utils.unlockfile(lock)
-                return None
-
-            try:
-                lf = open(lock_location, 'r')
-                remotedef = lf.readline()
-                [host, port] = remotedef.split(":")
-                port = int(port)
-                lf.close()
-                self.remote = remotedef
-            except Exception as e:
-                bb.fatal("Failed to read bitbake.lock (%s)" % str(e))
-
         # We need our IP for the server connection. We get the IP
         # by trying to connect with the server
         try:
-- 
1.9.1


