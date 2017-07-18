Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EDB60780F3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jul 2017 21:37:07 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6ILb6qj012349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 18 Jul 2017 22:37:07 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dXaB0-0006TP-ML; Tue, 18 Jul 2017 22:37:06 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jul 2017 22:37:00 +0100
Message-Id: <1500413820-24816-6-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 18 Jul 2017 22:37:07 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 6/6] cookerdata/cooker: Restore original datastore upon client disconnect
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
X-List-Received-Date: Tue, 18 Jul 2017 21:37:08 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py     | 2 ++
 lib/bb/cookerdata.py | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 313090b..a3058dd 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1566,6 +1566,8 @@ class BBCooker:
     def clientComplete(self):
         """Called when the client is done using the server"""
         self.finishcommand()
+        self.databuilder.reset()
+        self.data = self.databuilder.data
 
 def server_main(cooker, func, *args):
     cooker.pre_serve()
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 9d1d3d2..e6662d0 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -328,6 +328,13 @@ class CookerDataBuilder(object):
             logger.exception("Error parsing configuration files")
             raise bb.BBHandledException
 
+        # Create a copy so we can reset at a later date when UIs disconnect
+        self.origdata = self.data
+        self.data = bb.data.createCopy(self.origdata)
+
+    def reset(self):
+        self.data = bb.data.createCopy(self.origdata)
+
     def _findLayerConf(self, data):
         return findConfigFile("bblayers.conf", data)
 
-- 
2.7.4


