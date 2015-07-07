Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C5FE175D07
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 15:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t67FSRQg012406 for <bitbake-devel@lists.openembedded.org>;
	Tue, 7 Jul 2015 16:28:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sZplFg5_6jXc for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 16:28:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t67FSBA1012382
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 7 Jul 2015 16:28:22 +0100
Message-ID: <1436282891.27597.187.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 07 Jul 2015 16:28:11 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Improve DATE/TIME handling
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
X-List-Received-Date: Tue, 07 Jul 2015 15:28:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, once set, DATE and TIME in the metadata remain unchanged.
This is suboptimal for cases where cooker is reused. This ties setting
the variables into the BuildStarted event which seems like a more
appropriate time to do so.

It also changes BUILDNAME to be based off DATE/TIME by default if not
already set so that the data is more consistent. We therefore need to
expand the value rather than the previous default of not doing so.

This change does mean the date/time values are in sync across all
variables too.

It does mean bitbake now has special knowledge of DATE/TIME but that
would seen unavoidable (other than doing this in event handlers which
has its own set of downsides).

[YOCTO #5187]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index f31bca6..72ae8b0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1174,9 +1174,12 @@ class BBCooker:
         """
         Setup any variables needed before starting a build
         """
+        t = time.gmtime() 
         if not self.data.getVar("BUILDNAME", False):
-            self.data.setVar("BUILDNAME", time.strftime('%Y%m%d%H%M'))
-        self.data.setVar("BUILDSTART", time.strftime('%m/%d/%Y %H:%M:%S', time.gmtime()))
+            self.data.setVar("BUILDNAME", "${DATE}${TIME}")
+        self.data.setVar("BUILDSTART", time.strftime('%m/%d/%Y %H:%M:%S', t))
+        self.data.setVar("DATE", time.strftime('%Y%m%d', t))
+        self.data.setVar("TIME", time.strftime('%H%M%S', t))
 
     def matchFiles(self, bf):
         """
@@ -1275,7 +1278,7 @@ class BBCooker:
         taskdata = bb.taskdata.TaskData(self.configuration.abort)
         taskdata.add_provider(self.data, self.recipecache, item)
 
-        buildname = self.data.getVar("BUILDNAME", False)
+        buildname = self.data.getVar("BUILDNAME", True)
         bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
 
         # Execute the runqueue



