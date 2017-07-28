Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B16C7784E4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 15:23:06 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6SFN4lB008854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 28 Jul 2017 16:23:06 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1db76W-0006By-Sv; Fri, 28 Jul 2017 16:23:04 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Jul 2017 16:23:03 +0100
Message-Id: <1501255383-23763-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 28 Jul 2017 16:23:06 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] main: Always return 0 for bitbake --kill-server
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
X-List-Received-Date: Fri, 28 Jul 2017 15:23:08 -0000

If the server isn't running return 0 as to do otherwise complicates
scripts which do cleanup of bitbake servers which would potentially
be memory resident.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 5ca3485..431f6f4 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -277,7 +277,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
         parser.add_option("-m", "--kill-server", action="store_true",
                           dest="kill_server", default=False,
-                          help="Terminate the bitbake server.")
+                          help="Terminate any running bitbake server.")
 
         parser.add_option("", "--observe-only", action="store_true",
                           dest="observe_only", default=False,
@@ -370,8 +370,10 @@ def bitbake_main(configParams, configuration):
     server_connection, ui_module = setup_bitbake(configParams, configuration)
     # No server connection
     if server_connection is None:
-        if configParams.status_only or configParams.kill_server:
+        if configParams.status_only:
             return 1
+        if configParams.kill_server:
+            return 0
 
     if not configParams.server_only:
         if configParams.status_only:
-- 
2.7.4


