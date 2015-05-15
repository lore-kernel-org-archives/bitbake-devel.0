Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E6D1C7419F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 17:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4FH1db4025011 for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 18:01:39 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XaZywGQSfTBA for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 18:01:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4FH1Rtx024982
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 May 2015 18:01:38 +0100
Message-ID: <1431709287.18723.24.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 15 May 2015 18:01:27 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] tests/fetch: Add mirror of mirror tests
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
X-List-Received-Date: Fri, 15 May 2015 17:01:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add some tests of mirrors or mirrors to the fetcher unittests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index d3f7b6a..11b8a8c 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -391,6 +391,18 @@ class MirrorUriTest(FetcherTest):
         uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///someotherpath/downloads/bitbake-1.0.tar.gz'])
 
+    def test_mirror_of_mirror(self):
+        # Test if mirror of a mirror works
+        mirrorvar = self.mirrorvar + " http://.*/.* http://otherdownloads.yoctoproject.org/downloads/ \n"
+        mirrorvar = mirrorvar + " http://otherdownloads.yoctoproject.org/.* http://downloads2.yoctoproject.org/downloads/ \n"
+        fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
+        mirrors = bb.fetch2.mirror_from_string(mirrorvar)
+        uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
+        self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.tar.gz', 
+                                'file:///someotherpath/downloads/bitbake-1.0.tar.gz', 
+                                'http://otherdownloads.yoctoproject.org/downloads/bitbake-1.0.tar.gz',
+                                'http://downloads2.yoctoproject.org/downloads/bitbake-1.0.tar.gz'])
+
 
 class FetcherLocalTest(FetcherTest):
     def setUp(self):
@@ -476,6 +488,19 @@ class FetcherNetworkTest(FetcherTest):
             fetcher.download()
             self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
+        def test_fetch_mirror_of_mirror(self):
+            self.d.setVar("MIRRORS", "http://.*/.* http://invalid2.yoctoproject.org/ \n http://invalid2.yoctoproject.org/.* http://downloads.yoctoproject.org/releases/bitbake")
+            fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
+            fetcher.download()
+            self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
+
+        def test_fetch_file_mirror_of_mirror(self):
+            self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ \n file:///some1where/.* file://some2where/ \n file://some2where/.* http://downloads.yoctoproject.org/releases/bitbake")
+            fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
+            os.mkdir(self.dldir + "/some2where")
+            fetcher.download()
+            self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
+
         def test_fetch_premirror(self):
             self.d.setVar("PREMIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
             fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)



