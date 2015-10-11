Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6227777044
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 15:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9BF2VpY024526; Sun, 11 Oct 2015 16:02:31 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OkfmFAd9lS4Y; Sun, 11 Oct 2015 16:02:31 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9BF2CdS024494
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 11 Oct 2015 16:02:26 +0100
Message-ID: <1444555346.14364.24.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, "Smith, Elliot"
	<elliot.smith@intel.com>
Date: Sun, 11 Oct 2015 10:22:26 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.12.11-0ubuntu3 
Subject: [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets
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
X-List-Received-Date: Sun, 11 Oct 2015 15:02:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The console log data is written to is created at console initialisation
time and does not change over reset events. This ensures the
BB_CONSOLELOG value is correct over such resets by preserving it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/cooker.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9c9d761..ba0a8fe 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -244,6 +244,11 @@ class BBCooker:
         self.state = state.initial
         self.caches_array = []
 
+        # Need to preserve BB_CONSOLELOG over resets
+        consolelog = None
+        if hasattr(self, "data"):
+            consolelog = self.data.getVar("BB_CONSOLELOG", True)
+
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.enableDataTracking()
 
@@ -270,6 +275,8 @@ class BBCooker:
         self.data = self.databuilder.data
         self.data_hash = self.databuilder.data_hash
 
+        if consolelog:
+            self.data.setVar("BB_CONSOLELOG", consolelog)
 
         # we log all events to a file if so directed
         if self.configuration.writeeventlog:



