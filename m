Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id DC19C6B835
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:16 +0000 (UTC)
Received: by mail-wi0-f174.google.com with SMTP id r20so6812131wiv.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IlflnXsTnDdOb+eVpKXP7BitD3ZCpb+OxydGS9OcjfU=;
	b=Z1dQGNGaOBn+Id3wnZGNL66JFThNeA9aQ8FQ/rKICchbY9vIauFTQ8z0GRxJebE/L7
	7rrsxHMd7B3Q4K3LeEWwxB02GSavO6YrI7oCmwvW+JUHljx22phnmd64mjXqXlbcfHiU
	LIMMlhymyXt7gMS+PFwJw2uRtKkbokw1/gVVPtWi3+3L/ZmIc6e6PsIvAGOmKyc/FHtp
	tNrvzymnBg84cJloGKm5RppRy9/jI9ctzMYnZIMAQxLBEPpYgpsqZgD/UrCAMfxfxHxo
	Qoxkzk5tTQ14qNfCuE4gDTym3VQ9VDj72Qmya8ofCOZI87KpltGp0+3yS0yOmCUg/AMp
	AQ1Q==
X-Gm-Message-State: ALoCoQn1Qc3sryag3P9n3bhrfYy98KCelaaS+Xl/dmrL1GRgXW0CPhH0iNzTaBi3Q7h+qTWINNRC
X-Received: by 10.180.72.15 with SMTP id z15mr34089791wiu.46.1401809177180;
	Tue, 03 Jun 2014 08:26:17 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id em5sm3730792wic.23.2014.06.03.08.26.16
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id C7BB2560496; Tue,  3 Jun 2014 16:26:18 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:10 +0100
Message-Id: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1401808899.git.alexandru.damian@intel.com>
References: <cover.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/9] bitbake: move configuration reading code
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


