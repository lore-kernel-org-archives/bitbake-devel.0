Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E49BF73D29
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Aug 2015 06:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t736bfMj028491 for <bitbake-devel@lists.openembedded.org>;
	Mon, 3 Aug 2015 07:37:41 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 78hsnd2IMaYL for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Aug 2015 07:37:41 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t736bPfR028474
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 3 Aug 2015 07:37:38 +0100
Message-ID: <1438583844.4796.36.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 03 Aug 2015 07:37:24 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] bitbake: cooker: Resolve file monitoring race issues when using memres bitbake
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
X-List-Received-Date: Mon, 03 Aug 2015 06:37:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you load memory resident bitbake, then change bblayers.conf or other
configuration files, then execute your first command, bitbake will not
notice the changes. This is because it adds the file watches during
inital parsing, which happens at the time the first command is run.

To fix this, we move the addition of the file watches to earlier in
the process, so bitbake then does track them correctly. This also
avoids some issues Paul was seeing with tinfoil2.

(Bitbake rev: b9375c73e736003e66575969c9ea244403e47aeb)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 52b81be..0f99342 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -349,6 +349,10 @@ class BBCooker:
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
 
+        self.data.renameVar("__depends", "__base_depends")
+        self.add_filewatch(self.data.getVar("__base_depends", False), self.configwatcher)
+
+
     def enableDataTracking(self):
         self.configuration.tracking = True
         if hasattr(self, "data"):
@@ -1464,9 +1468,6 @@ class BBCooker:
             self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
             (filelist, masked) = self.collection.collect_bbfiles(self.data, self.expanded_data)
 
-            self.data.renameVar("__depends", "__base_depends")
-            self.add_filewatch(self.data.getVar("__base_depends", False), self.configwatcher)
-
             self.parser = CookerParser(self, filelist, masked)
             self.parsecache_valid = True
 



