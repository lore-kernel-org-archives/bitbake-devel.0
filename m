Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SStbR-000302-SV for bitbake-devel@lists.openembedded.org;
	Fri, 11 May 2012 19:26:06 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4BHGAYK028398
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2012 18:16:10 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18512-07 for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2012 18:16:05 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4BHG137028392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2012 18:16:02 +0100
Message-ID: <1336756561.2494.240.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 May 2012 18:16:01 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/tests: Add test of the git fetcher
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 11 May 2012 17:26:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 234b251..42af883 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -19,6 +19,7 @@
 
 import unittest
 import tempfile
+import subprocess
 import os
 import bb
 
@@ -33,6 +34,8 @@ class FetcherTest(unittest.TestCase):
         self.d.setVar("DL_DIR", self.dldir)
         self.unpackdir = os.path.join(self.tempdir, "unpacked")
         os.mkdir(self.unpackdir)
+        persistdir = os.path.join(self.tempdir, "persistdata")
+        self.d.setVar("PERSISTENT_DIR", persistdir)
 
     def tearDown(self):
         bb.utils.prunedir(self.tempdir)
@@ -61,6 +64,24 @@ class FetcherTest(unittest.TestCase):
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
+    def test_gitfetch(self):
+        def checkrevision(self, fetcher):
+            fetcher.unpack(self.unpackdir)
+            revision = subprocess.check_output("git rev-parse HEAD", shell=True, cwd=self.unpackdir + "/git").strip()
+            self.assertEqual(revision, "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
+
+        self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "1")
+        self.d.setVar("SRCREV", "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake"], self.d)
+        fetcher.download()
+        checkrevision(self, fetcher)
+        # Wipe out the dldir clone and the unpacked source, turn off the network and check mirror tarball works
+        bb.utils.prunedir(self.dldir + "/git2/")
+        bb.utils.prunedir(self.unpackdir)
+        self.d.setVar("BB_NO_NETWORK", "1")
+        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake"], self.d)
+        fetcher.download()
+        checkrevision(self, fetcher)
 
 class URLHandle(unittest.TestCase):
 




