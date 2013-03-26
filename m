Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UKPdQ-0007lv-SF
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Mar 2013 09:53:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 7FE832614AB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Mar 2013 09:36:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id A9gYGBSXHMQb for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Mar 2013 09:36:35 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by ra.se.axis.com (Postfix) with ESMTP id 79F0A261472
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Mar 2013 09:28:16 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 782DA34158
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Mar 2013 09:28:16 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Tue, 26 Mar 2013
	09:28:16 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 332C09C078; 
	Tue, 26 Mar 2013 09:28:38 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 26 Mar 2013 09:28:38 +0100
Message-ID: <1364286518-24516-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH v2] bb.tests.fetch: Opt-out for unittests that require network
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
X-List-Received-Date: Tue, 26 Mar 2013 08:53:38 -0000
Content-Type: text/plain

With this change, you can opt-out to skip unit tests that require an
internet connection. To opt-out, you'll set the environment variable
BB_SKIP_NETTESTS to 'yes'.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/tests/fetch.py |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 778d94f..ba5a34f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -308,6 +308,8 @@ class FetcherTest(unittest.TestCase):
     def tearDown(self):
         bb.utils.prunedir(self.tempdir)
 
+    @unittest.skipIf(os.environ.get("BB_SKIP_NETTESTS") == "yes",
+                     "Unset BB_SKIP_NETTESTS to yes to run network tests")
     def test_fetch(self):
         fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
         fetcher.download()
@@ -320,12 +322,16 @@ class FetcherTest(unittest.TestCase):
         self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.0/")), 9)
         self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.1/")), 9)
 
+    @unittest.skipIf(os.environ.get("BB_SKIP_NETTESTS") == "yes",
+                     "Unset BB_SKIP_NETTESTS to yes to run network tests")
     def test_fetch_mirror(self):
         self.d.setVar("MIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
+    @unittest.skipIf(os.environ.get("BB_SKIP_NETTESTS") == "yes",
+                     "Unset BB_SKIP_NETTESTS to yes to run network tests")
     def test_fetch_premirror(self):
         self.d.setVar("PREMIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
@@ -351,21 +357,29 @@ class FetcherTest(unittest.TestCase):
         fetcher.download()
         checkrevision(self, fetcher)
 
+    @unittest.skipIf(os.environ.get("BB_SKIP_NETTESTS") == "yes",
+                     "Unset BB_SKIP_NETTESTS to yes to run network tests")
     def test_gitfetch(self):
         url1 = url2 = "git://git.openembedded.org/bitbake"
         self.gitfetcher(url1, url2)
 
+    @unittest.skipIf(os.environ.get("BB_SKIP_NETTESTS") == "yes",
+                     "Unset BB_SKIP_NETTESTS to yes to run network tests")
     def test_gitfetch_premirror(self):
         url1 = "git://git.openembedded.org/bitbake"
         url2 = "git://someserver.org/bitbake"
         self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
         self.gitfetcher(url1, url2)
 
+    @unittest.skipIf(os.environ.get("BB_SKIP_NETTESTS") == "yes",
+                     "Unset BB_SKIP_NETTESTS to yes to run network tests")
     def test_gitfetch_premirror2(self):
         url1 = url2 = "git://someserver.org/bitbake"
         self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
         self.gitfetcher(url1, url2)
 
+    @unittest.skipIf(os.environ.get("BB_SKIP_NETTESTS") == "yes",
+                     "Unset BB_SKIP_NETTESTS to yes to run network tests")
     def test_gitfetch_premirror3(self):
         realurl = "git://git.openembedded.org/bitbake"
         dummyurl = "git://someserver.org/bitbake"
-- 
1.7.10.4



