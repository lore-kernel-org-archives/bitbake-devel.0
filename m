Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9FD2577115
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 16:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FGvNl3010661 for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:57:23 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6vjFTLKTdD5o for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:57:23 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FGvKGE010658
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:57:21 +0100
Message-ID: <1471280240.20391.91.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Aug 2016 17:57:20 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cookerdata: Simplify prefiles/postfiles
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
X-List-Received-Date: Mon, 15 Aug 2016 16:57:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The current codepaths are rather confusing. Stop passing these
as parameters and use the ones from when the object is created.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index dc34efe..71021a3 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -258,7 +258,7 @@ class CookerDataBuilder(object):
 
     def parseBaseConfiguration(self):
         try:
-            self.parseConfigurationFiles(self.prefiles, self.postfiles)
+            self.parseConfigurationFiles()
         except SyntaxError:
             raise bb.BBHandledException
         except bb.data_smart.ExpansionError as e:
@@ -271,8 +271,10 @@ class CookerDataBuilder(object):
     def _findLayerConf(self, data):
         return findConfigFile("bblayers.conf", data)
 
-    def parseConfigurationFiles(self, prefiles, postfiles):
+    def parseConfigurationFiles(self):
         data = self.data
+        prefiles = self.prefiles
+        postfiles = self.postfiles
         bb.parse.init_parser(data)
 
         # Parse files for loading *before* bitbake.conf and any includes
@@ -343,7 +345,7 @@ class CookerDataBuilder(object):
 
         if data.getVar("BB_INVALIDCONF", False) is True:
             data.setVar("BB_INVALIDCONF", False)
-            self.parseConfigurationFiles(self.prefiles, self.postfiles)
+            self.parseConfigurationFiles()
             return
 
         bb.parse.init_parser(data)



