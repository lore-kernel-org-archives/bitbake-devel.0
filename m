Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqR-0007wt-VU
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:20 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEHSIg008014 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:52 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0m3pocacPpjI for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:52 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEHolR008124
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:51 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLfY-0002TK-RX
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:14:04 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:13:05 +0100
Message-Id: <674bf693e142113ebf4a5dd289d42e02890454a4.1340200208.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 14/14] test/fetch: Add in unit tests for uri_replace() and git premirrors
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
X-List-Received-Date: Wed, 20 Jun 2012 14:27:35 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/tests/fetch.py |   55 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 42af883..d890ec9 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -26,6 +26,32 @@ import bb
 
 class FetcherTest(unittest.TestCase):
 
+    replaceuris = {
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "http://somewhere.org/somedir/") 
+            : "http://somewhere.org/somedir/git2_git.invalid.infradead.org.mtd-utils.git.tar.gz",
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http") 
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http") 
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/\\2;protocol=http") 
+            : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890", "git://someserver.org/bitbake", "git://git.openembedded.org/bitbake")
+            : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890",
+        ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache") 
+            : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
+        ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache/") 
+            : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
+        ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "http://.*/.*", "http://somewhere2.org/somedir3") 
+            : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
+        ("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz") 
+            : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
+        ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2", "http://www.apache.org/dist", "http://archive.apache.org/dist")
+            : "http://archive.apache.org/dist/subversion/subversion-1.7.1.tar.bz2"
+        #Renaming files doesn't work
+        #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
+        #("file://sstate-xyz.tgz", "file://.*/.*", "file:///somewhere/1234/sstate-cache") : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
+    }
+
     def setUp(self):
         self.d = bb.data.init()
         self.tempdir = tempfile.mkdtemp()
@@ -64,7 +90,7 @@ class FetcherTest(unittest.TestCase):
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
-    def test_gitfetch(self):
+    def gitfetcher(self, url1, url2):
         def checkrevision(self, fetcher):
             fetcher.unpack(self.unpackdir)
             revision = subprocess.check_output("git rev-parse HEAD", shell=True, cwd=self.unpackdir + "/git").strip()
@@ -72,17 +98,40 @@ class FetcherTest(unittest.TestCase):
 
         self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "1")
         self.d.setVar("SRCREV", "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake"], self.d)
+        fetcher = bb.fetch.Fetch([url1], self.d)
         fetcher.download()
         checkrevision(self, fetcher)
         # Wipe out the dldir clone and the unpacked source, turn off the network and check mirror tarball works
         bb.utils.prunedir(self.dldir + "/git2/")
         bb.utils.prunedir(self.unpackdir)
         self.d.setVar("BB_NO_NETWORK", "1")
-        fetcher = bb.fetch.Fetch(["git://git.openembedded.org/bitbake"], self.d)
+        fetcher = bb.fetch.Fetch([url2], self.d)
         fetcher.download()
         checkrevision(self, fetcher)
 
+    def test_gitfetch(self):
+        url1 = url2 = "git://git.openembedded.org/bitbake"
+        self.gitfetcher(url1, url2)
+
+    def test_gitfetch_premirror(self):
+        url1 = "git://git.openembedded.org/bitbake"
+        url2 = "git://someserver.org/bitbake"
+        self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
+        self.gitfetcher(url1, url2)
+
+    def test_gitfetch_premirror2(self):
+        url1 = url2 = "git://someserver.org/bitbake"
+        self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
+        self.gitfetcher(url1, url2)
+
+    def test_urireplace(self):
+        for k, v in self.replaceuris.items():
+            ud = bb.fetch.FetchData(k[0], self.d)
+            ud.setup_localpath(self.d)
+            newuris = bb.fetch2.uri_replace(ud, k[1], k[2], self.d)
+            self.assertEqual(newuris, v)
+
+
 class URLHandle(unittest.TestCase):
 
     datatable = {
-- 
1.7.5.4



