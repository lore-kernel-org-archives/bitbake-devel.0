Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 770966D3DE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 21:21:33 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rAPLLWUp015146
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 13:21:33 -0800 (PST)
Received: from ord-jrw.corp.ad.wrs.com (172.25.32.36) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.2.347.0; Mon, 25 Nov 2013 13:21:32 -0800
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 15:21:25 -0600
Message-ID: <1385414489-2901-2-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
References: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/5] bitbake: Add --status-only option
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

The --status-only option is purely to check the health of the server.
The idea is to use it from the oe environment script so as to know if
the server needs to be started or not.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 bin/bitbake |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake b/bin/bitbake
index 50971a8..cca2b8d 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -190,6 +190,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("", "--observe-only", help = "Connect to a server as an observing-only client.",
                    action = "store_true", dest = "observe_only", default = False)
 
+        parser.add_option("", "--status-only", help = "Check the status of the remote bitbake server.",
+                   action = "store_true", dest = "status_only", default = False)
+
         options, targets = parser.parse_args(sys.argv)
 
         # some environmental variables set also configuration options
@@ -284,7 +287,9 @@ def main():
 
     # Ensure logging messages get sent to the UI as events
     handler = bb.event.LogHandler()
-    logger.addHandler(handler)
+    if not configParams.status_only:
+        # In status only mode there are no logs and no UI
+        logger.addHandler(handler)
 
     # Clear away any spurious environment variables while we stoke up the cooker
     cleanedvars = bb.utils.clean_environment()
@@ -302,6 +307,14 @@ def main():
         # Collect the feature set for the UI
         featureset = getattr(ui_module, "featureSet", [])
 
+        if configParams.status_only:
+            try:
+                server_connection = server.establishConnection(featureset)
+            except:
+                sys.exit(1)
+            server_connection.terminate()
+            sys.exit(0)
+
         # Setup a connection to the server (cooker)
         server_connection = server.establishConnection(featureset)
 
-- 
1.7.9.5


