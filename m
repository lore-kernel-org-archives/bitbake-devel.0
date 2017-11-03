Return-Path: <ross.burton@intel.com>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
	[209.85.128.193])
	by mail.openembedded.org (Postfix) with ESMTP id 6D92D78330
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Nov 2017 11:52:51 +0000 (UTC)
Received: by mail-wr0-f193.google.com with SMTP id p96so2277489wrb.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Nov 2017 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=8wodzG6Vp0SUWWqljgoll4KPz+xMDOxkj/npmYUegi0=;
	b=jtYGqqZRh25uv3e8F2CHISKf1c58kqso2VgaoNIbJdTVpfDQ9Zb8GheWRx86loRqPQ
	PWoHoyrdWy1V3dBSAgvhOCwme9WmrWHBEdT23WZvLU9C3P7GK9061GPSKw9oT5aQ7zWI
	vwJj0QMHT8H8ofLyyw9mMoAdUFT8La2346KTNz0Aj4LRGndkgxXFzaFdUUpFK9ZCV21T
	hvjg/AwzVFOy8EFAGzAmEQZR6Mv4XG+5oWGuc9Qk/m3sT8wl/6uesE1tbTnABqsj++PB
	+/8yCX1emm+R14UDIdk9T1d5lTuplJhh7+jK8j6dGX2+i73pp91R3n4apnD1o2gEX7O0
	fpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=8wodzG6Vp0SUWWqljgoll4KPz+xMDOxkj/npmYUegi0=;
	b=VlppxdE4bXn2vk4plIB1Q7EFkGuLqvxlFHpfNOMHN/H1M+ddN6uRbdXct+8FnttSjV
	SxLcziFB2aBgnfyEw553bAF6bq5FyteW8qpaARyUtti11hUDjv0BvP2KCUxMtoWNxabh
	b38G7oY2VTFv2oQqNWKq1ltkvR4FgozhOtuoyBUNAcHtFA6pn0F5VkBqkZ4mJGWo616Y
	Max1RKTDKLfzi7p1HymGo1u1w+kP1YFpUgnLHqwL02BwXJzCjlVK2YA9optUT2u6VwLP
	R6Hm4CvYx2oqTTj8Gn1rPnIbibFLidnPLdQoecLJrr6cB9uw7iqhpAUsXC0FnPVsr25Z
	j+IQ==
X-Gm-Message-State: AMCzsaVxTYvDYv4/Zn/kGIr2wX/oSqh3ZgOZ3SH6GYw1oMW653atHJm2
	qncMHevPF2LuFF7Z8urhLCySJ/xb
X-Google-Smtp-Source: ABhQp+Sr6bf3oQGdnPt1h//o64iYdeHiLhDv4ZZM5+eGTNpUdwuGpZSGT18B3eUw1DSpEqgdh+H0aw==
X-Received: by 10.223.139.221 with SMTP id w29mr5402586wra.243.1509709971479; 
	Fri, 03 Nov 2017 04:52:51 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id w4sm5558009wrc.17.2017.11.03.04.52.49
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 Nov 2017 04:52:50 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Nov 2017 11:52:43 +0000
Message-Id: <20171103115244.19504-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH 1/2] tests/fetch: skip network tests the idiomatic way
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
X-List-Received-Date: Fri, 03 Nov 2017 11:52:51 -0000

Instead of not even having the test functions if network tests are disabled, use
a custom decorator to mark the network tests and skip them.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/fetch.py | 434 +++++++++++++++++++++---------------------
 1 file changed, 222 insertions(+), 212 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 209b13f6953..154bf1779be 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -28,6 +28,11 @@ from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
 import bb
 
+def skipIfNoNetwork():
+    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
+        return unittest.skip("Network tests being skipped")
+    return lambda f: f
+
 class URITest(unittest.TestCase):
     test_uris = {
         "http://www.google.com/index.html" : {
@@ -518,141 +523,153 @@ class FetcherLocalTest(FetcherTest):
             self.fetchUnpack(['file://a;subdir=/bin/sh'])
 
 class FetcherNetworkTest(FetcherTest):
+    @skipIfNoNetwork()
+    def test_fetch(self):
+        fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.1.tar.gz"), 57892)
+        self.d.setVar("BB_NO_NETWORK", "1")
+        fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.0/")), 9)
+        self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.1/")), 9)
 
-    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-        print("Unset BB_SKIP_NETTESTS to run network tests")
-    else:
-        def test_fetch(self):
-            fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
-            fetcher.download()
-            self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
-            self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.1.tar.gz"), 57892)
-            self.d.setVar("BB_NO_NETWORK", "1")
-            fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
-            fetcher.download()
-            fetcher.unpack(self.unpackdir)
-            self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.0/")), 9)
-            self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.1/")), 9)
-
-        def test_fetch_mirror(self):
-            self.d.setVar("MIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
-            fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
-            fetcher.download()
-            self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
-
-        def test_fetch_mirror_of_mirror(self):
-            self.d.setVar("MIRRORS", "http://.*/.* http://invalid2.yoctoproject.org/ \n http://invalid2.yoctoproject.org/.* http://downloads.yoctoproject.org/releases/bitbake")
-            fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
-            fetcher.download()
-            self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
-
-        def test_fetch_file_mirror_of_mirror(self):
-            self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ \n file:///some1where/.* file://some2where/ \n file://some2where/.* http://downloads.yoctoproject.org/releases/bitbake")
-            fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
-            os.mkdir(self.dldir + "/some2where")
-            fetcher.download()
-            self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
-
-        def test_fetch_premirror(self):
-            self.d.setVar("PREMIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
-            fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
-            fetcher.download()
-            self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
-
-        def gitfetcher(self, url1, url2):
-            def checkrevision(self, fetcher):
-                fetcher.unpack(self.unpackdir)
-                revision = bb.process.run("git rev-parse HEAD", shell=True, cwd=self.unpackdir + "/git")[0].strip()
-                self.assertEqual(revision, "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
-
-            self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "1")
-            self.d.setVar("SRCREV", "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
-            fetcher = bb.fetch.Fetch([url1], self.d)
-            fetcher.download()
-            checkrevision(self, fetcher)
-            # Wipe out the dldir clone and the unpacked source, turn off the network and check mirror tarball works
-            bb.utils.prunedir(self.dldir + "/git2/")
-            bb.utils.prunedir(self.unpackdir)
-            self.d.setVar("BB_NO_NETWORK", "1")
-            fetcher = bb.fetch.Fetch([url2], self.d)
-            fetcher.download()
-            checkrevision(self, fetcher)
-
-        def test_gitfetch(self):
-            url1 = url2 = "git://git.openembedded.org/bitbake"
-            self.gitfetcher(url1, url2)
-
-        def test_gitfetch_goodsrcrev(self):
-            # SRCREV is set but matches rev= parameter
-            url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5"
-            self.gitfetcher(url1, url2)
-
-        def test_gitfetch_badsrcrev(self):
-            # SRCREV is set but does not match rev= parameter
-            url1 = url2 = "git://git.openembedded.org/bitbake;rev=dead05b0b4ba0959fe0624d2a4885d7b70426da5"
-            self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
-
-        def test_gitfetch_tagandrev(self):
-            # SRCREV is set but does not match rev= parameter
-            url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;tag=270a05b0b4ba0959fe0624d2a4885d7b70426da5"
-            self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
-
-        def test_gitfetch_localusehead(self):
-            # Create dummy local Git repo
-            src_dir = tempfile.mkdtemp(dir=self.tempdir,
-                                       prefix='gitfetch_localusehead_')
-            src_dir = os.path.abspath(src_dir)
-            bb.process.run("git init", cwd=src_dir)
-            bb.process.run("git commit --allow-empty -m'Dummy commit'",
-                           cwd=src_dir)
-            # Use other branch than master
-            bb.process.run("git checkout -b my-devel", cwd=src_dir)
-            bb.process.run("git commit --allow-empty -m'Dummy commit 2'",
-                           cwd=src_dir)
-            stdout = bb.process.run("git rev-parse HEAD", cwd=src_dir)
-            orig_rev = stdout[0].strip()
-
-            # Fetch and check revision
-            self.d.setVar("SRCREV", "AUTOINC")
-            url = "git://" + src_dir + ";protocol=file;usehead=1"
-            fetcher = bb.fetch.Fetch([url], self.d)
-            fetcher.download()
-            fetcher.unpack(self.unpackdir)
-            stdout = bb.process.run("git rev-parse HEAD",
-                                    cwd=os.path.join(self.unpackdir, 'git'))
-            unpack_rev = stdout[0].strip()
-            self.assertEqual(orig_rev, unpack_rev)
-
-        def test_gitfetch_remoteusehead(self):
-            url = "git://git.openembedded.org/bitbake;usehead=1"
-            self.assertRaises(bb.fetch.ParameterError, self.gitfetcher, url, url)
-
-        def test_gitfetch_premirror(self):
-            url1 = "git://git.openembedded.org/bitbake"
-            url2 = "git://someserver.org/bitbake"
-            self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
-            self.gitfetcher(url1, url2)
-
-        def test_gitfetch_premirror2(self):
-            url1 = url2 = "git://someserver.org/bitbake"
-            self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
-            self.gitfetcher(url1, url2)
-
-        def test_gitfetch_premirror3(self):
-            realurl = "git://git.openembedded.org/bitbake"
-            dummyurl = "git://someserver.org/bitbake"
-            self.sourcedir = self.unpackdir.replace("unpacked", "sourcemirror.git")
-            os.chdir(self.tempdir)
-            bb.process.run("git clone %s %s 2> /dev/null" % (realurl, self.sourcedir), shell=True)
-            self.d.setVar("PREMIRRORS", "%s git://%s;protocol=file \n" % (dummyurl, self.sourcedir))
-            self.gitfetcher(dummyurl, dummyurl)
-
-        def test_git_submodule(self):
-            fetcher = bb.fetch.Fetch(["gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"], self.d)
-            fetcher.download()
-            # Previous cwd has been deleted
-            os.chdir(os.path.dirname(self.unpackdir))
+    @skipIfNoNetwork()
+    def test_fetch_mirror(self):
+        self.d.setVar("MIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
+
+    @skipIfNoNetwork()
+    def test_fetch_mirror_of_mirror(self):
+        self.d.setVar("MIRRORS", "http://.*/.* http://invalid2.yoctoproject.org/ \n http://invalid2.yoctoproject.org/.* http://downloads.yoctoproject.org/releases/bitbake")
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
+
+    @skipIfNoNetwork()
+    def test_fetch_file_mirror_of_mirror(self):
+        self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ \n file:///some1where/.* file://some2where/ \n file://some2where/.* http://downloads.yoctoproject.org/releases/bitbake")
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
+        os.mkdir(self.dldir + "/some2where")
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
+
+    @skipIfNoNetwork()
+    def test_fetch_premirror(self):
+        self.d.setVar("PREMIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
+
+    @skipIfNoNetwork()
+    def gitfetcher(self, url1, url2):
+        def checkrevision(self, fetcher):
             fetcher.unpack(self.unpackdir)
+            revision = bb.process.run("git rev-parse HEAD", shell=True, cwd=self.unpackdir + "/git")[0].strip()
+            self.assertEqual(revision, "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
+
+        self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "1")
+        self.d.setVar("SRCREV", "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
+        fetcher = bb.fetch.Fetch([url1], self.d)
+        fetcher.download()
+        checkrevision(self, fetcher)
+        # Wipe out the dldir clone and the unpacked source, turn off the network and check mirror tarball works
+        bb.utils.prunedir(self.dldir + "/git2/")
+        bb.utils.prunedir(self.unpackdir)
+        self.d.setVar("BB_NO_NETWORK", "1")
+        fetcher = bb.fetch.Fetch([url2], self.d)
+        fetcher.download()
+        checkrevision(self, fetcher)
+
+    @skipIfNoNetwork()
+    def test_gitfetch(self):
+        url1 = url2 = "git://git.openembedded.org/bitbake"
+        self.gitfetcher(url1, url2)
+
+    @skipIfNoNetwork()
+    def test_gitfetch_goodsrcrev(self):
+        # SRCREV is set but matches rev= parameter
+        url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5"
+        self.gitfetcher(url1, url2)
+
+    @skipIfNoNetwork()
+    def test_gitfetch_badsrcrev(self):
+        # SRCREV is set but does not match rev= parameter
+        url1 = url2 = "git://git.openembedded.org/bitbake;rev=dead05b0b4ba0959fe0624d2a4885d7b70426da5"
+        self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
+
+    @skipIfNoNetwork()
+    def test_gitfetch_tagandrev(self):
+        # SRCREV is set but does not match rev= parameter
+        url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;tag=270a05b0b4ba0959fe0624d2a4885d7b70426da5"
+        self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
+
+    @skipIfNoNetwork()
+    def test_gitfetch_localusehead(self):
+        # Create dummy local Git repo
+        src_dir = tempfile.mkdtemp(dir=self.tempdir,
+                                   prefix='gitfetch_localusehead_')
+        src_dir = os.path.abspath(src_dir)
+        bb.process.run("git init", cwd=src_dir)
+        bb.process.run("git commit --allow-empty -m'Dummy commit'",
+                       cwd=src_dir)
+        # Use other branch than master
+        bb.process.run("git checkout -b my-devel", cwd=src_dir)
+        bb.process.run("git commit --allow-empty -m'Dummy commit 2'",
+                       cwd=src_dir)
+        stdout = bb.process.run("git rev-parse HEAD", cwd=src_dir)
+        orig_rev = stdout[0].strip()
+
+        # Fetch and check revision
+        self.d.setVar("SRCREV", "AUTOINC")
+        url = "git://" + src_dir + ";protocol=file;usehead=1"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        stdout = bb.process.run("git rev-parse HEAD",
+                                cwd=os.path.join(self.unpackdir, 'git'))
+        unpack_rev = stdout[0].strip()
+        self.assertEqual(orig_rev, unpack_rev)
+
+    @skipIfNoNetwork()
+    def test_gitfetch_remoteusehead(self):
+        url = "git://git.openembedded.org/bitbake;usehead=1"
+        self.assertRaises(bb.fetch.ParameterError, self.gitfetcher, url, url)
+
+    @skipIfNoNetwork()
+    def test_gitfetch_premirror(self):
+        url1 = "git://git.openembedded.org/bitbake"
+        url2 = "git://someserver.org/bitbake"
+        self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
+        self.gitfetcher(url1, url2)
+
+    @skipIfNoNetwork()
+    def test_gitfetch_premirror2(self):
+        url1 = url2 = "git://someserver.org/bitbake"
+        self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
+        self.gitfetcher(url1, url2)
+
+    @skipIfNoNetwork()
+    def test_gitfetch_premirror3(self):
+        realurl = "git://git.openembedded.org/bitbake"
+        dummyurl = "git://someserver.org/bitbake"
+        self.sourcedir = self.unpackdir.replace("unpacked", "sourcemirror.git")
+        os.chdir(self.tempdir)
+        bb.process.run("git clone %s %s 2> /dev/null" % (realurl, self.sourcedir), shell=True)
+        self.d.setVar("PREMIRRORS", "%s git://%s;protocol=file \n" % (dummyurl, self.sourcedir))
+        self.gitfetcher(dummyurl, dummyurl)
+
+    @skipIfNoNetwork()
+    def test_git_submodule(self):
+        fetcher = bb.fetch.Fetch(["gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
 
 
 class TrustedNetworksTest(FetcherTest):
@@ -782,32 +799,32 @@ class FetchLatestVersionTest(FetcherTest):
         ("db", "http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz", "http://www.oracle.com/technetwork/products/berkeleydb/downloads/index-082944.html", "http://download.oracle.com/otn/berkeley-db/(?P<name>db-)(?P<pver>((\d+[\.\-_]*)+))\.tar\.gz")
             : "6.1.19",
     }
-    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-        print("Unset BB_SKIP_NETTESTS to run network tests")
-    else:
-        def test_git_latest_versionstring(self):
-            for k, v in self.test_git_uris.items():
-                self.d.setVar("PN", k[0])
-                self.d.setVar("SRCREV", k[2])
-                self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
-                ud = bb.fetch2.FetchData(k[1], self.d)
-                pupver= ud.method.latest_versionstring(ud, self.d)
-                verstring = pupver[0]
-                self.assertTrue(verstring, msg="Could not find upstream version")
-                r = bb.utils.vercmp_string(v, verstring)
-                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
-
-        def test_wget_latest_versionstring(self):
-            for k, v in self.test_wget_uris.items():
-                self.d.setVar("PN", k[0])
-                self.d.setVar("UPSTREAM_CHECK_URI", k[2])
-                self.d.setVar("UPSTREAM_CHECK_REGEX", k[3])
-                ud = bb.fetch2.FetchData(k[1], self.d)
-                pupver = ud.method.latest_versionstring(ud, self.d)
-                verstring = pupver[0]
-                self.assertTrue(verstring, msg="Could not find upstream version")
-                r = bb.utils.vercmp_string(v, verstring)
-                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
+
+    @skipIfNoNetwork()
+    def test_git_latest_versionstring(self):
+        for k, v in self.test_git_uris.items():
+            self.d.setVar("PN", k[0])
+            self.d.setVar("SRCREV", k[2])
+            self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
+            ud = bb.fetch2.FetchData(k[1], self.d)
+            pupver= ud.method.latest_versionstring(ud, self.d)
+            verstring = pupver[0]
+            self.assertTrue(verstring, msg="Could not find upstream version")
+            r = bb.utils.vercmp_string(v, verstring)
+            self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
+
+    @skipIfNoNetwork()
+    def test_wget_latest_versionstring(self):
+        for k, v in self.test_wget_uris.items():
+            self.d.setVar("PN", k[0])
+            self.d.setVar("UPSTREAM_CHECK_URI", k[2])
+            self.d.setVar("UPSTREAM_CHECK_REGEX", k[3])
+            ud = bb.fetch2.FetchData(k[1], self.d)
+            pupver = ud.method.latest_versionstring(ud, self.d)
+            verstring = pupver[0]
+            self.assertTrue(verstring, msg="Could not find upstream version")
+            r = bb.utils.vercmp_string(v, verstring)
+            self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
 
 class FetchCheckStatusTest(FetcherTest):
@@ -827,33 +844,30 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
 
-    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-        print("Unset BB_SKIP_NETTESTS to run network tests")
-    else:
-
-        def test_wget_checkstatus(self):
-            fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d)
-            for u in self.test_wget_uris:
-                ud = fetch.ud[u]
-                m = ud.method
-                ret = m.checkstatus(fetch, ud, self.d)
-                self.assertTrue(ret, msg="URI %s, can't check status" % (u))
+    @skipIfNoNetwork()
+    def test_wget_checkstatus(self):
+        fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d)
+        for u in self.test_wget_uris:
+            ud = fetch.ud[u]
+            m = ud.method
+            ret = m.checkstatus(fetch, ud, self.d)
+            self.assertTrue(ret, msg="URI %s, can't check status" % (u))
 
+    @skipIfNoNetwork()
+    def test_wget_checkstatus_connection_cache(self):
+        from bb.fetch2 import FetchConnectionCache
 
-        def test_wget_checkstatus_connection_cache(self):
-            from bb.fetch2 import FetchConnectionCache
+        connection_cache = FetchConnectionCache()
+        fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d,
+                    connection_cache = connection_cache)
 
-            connection_cache = FetchConnectionCache()
-            fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d,
-                        connection_cache = connection_cache)
+        for u in self.test_wget_uris:
+            ud = fetch.ud[u]
+            m = ud.method
+            ret = m.checkstatus(fetch, ud, self.d)
+            self.assertTrue(ret, msg="URI %s, can't check status" % (u))
 
-            for u in self.test_wget_uris:
-                ud = fetch.ud[u]
-                m = ud.method
-                ret = m.checkstatus(fetch, ud, self.d)
-                self.assertTrue(ret, msg="URI %s, can't check status" % (u))
-
-            connection_cache.close_connections()
+        connection_cache.close_connections()
 
 
 class GitMakeShallowTest(FetcherTest):
@@ -972,15 +986,13 @@ class GitMakeShallowTest(FetcherTest):
         self.make_shallow()
         self.assertRevCount(1)
 
-    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-        print("Unset BB_SKIP_NETTESTS to run network tests")
-    else:
-        def test_make_shallow_bitbake(self):
-            self.git('remote add origin https://github.com/openembedded/bitbake')
-            self.git('fetch --tags origin')
-            orig_revs = len(self.git('rev-list --all').splitlines())
-            self.make_shallow(['refs/tags/1.10.0'])
-            self.assertRevCount(orig_revs - 1746, ['--all'])
+    @skipIfNoNetwork()
+    def test_make_shallow_bitbake(self):
+        self.git('remote add origin https://github.com/openembedded/bitbake')
+        self.git('fetch --tags origin')
+        orig_revs = len(self.git('rev-list --all').splitlines())
+        self.make_shallow(['refs/tags/1.10.0'])
+        self.assertRevCount(orig_revs - 1746, ['--all'])
 
 class GitShallowTest(FetcherTest):
     def setUp(self):
@@ -1436,24 +1448,22 @@ class GitShallowTest(FetcherTest):
         with self.assertRaises(bb.fetch2.FetchError):
             self.fetch()
 
-    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-        print("Unset BB_SKIP_NETTESTS to run network tests")
-    else:
-        def test_bitbake(self):
-            self.git('remote add --mirror=fetch origin git://github.com/openembedded/bitbake', cwd=self.srcdir)
-            self.git('config core.bare true', cwd=self.srcdir)
-            self.git('fetch', cwd=self.srcdir)
-
-            self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
-            # Note that the 1.10.0 tag is annotated, so this also tests
-            # reference of an annotated vs unannotated tag
-            self.d.setVar('BB_GIT_SHALLOW_REVS', '1.10.0')
-
-            self.fetch_shallow()
-
-            # Confirm that the history of 1.10.0 was removed
-            orig_revs = len(self.git('rev-list master', cwd=self.srcdir).splitlines())
-            revs = len(self.git('rev-list master').splitlines())
-            self.assertNotEqual(orig_revs, revs)
-            self.assertRefs(['master', 'origin/master'])
-            self.assertRevCount(orig_revs - 1758)
+    @skipIfNoNetwork()
+    def test_bitbake(self):
+        self.git('remote add --mirror=fetch origin git://github.com/openembedded/bitbake', cwd=self.srcdir)
+        self.git('config core.bare true', cwd=self.srcdir)
+        self.git('fetch', cwd=self.srcdir)
+
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        # Note that the 1.10.0 tag is annotated, so this also tests
+        # reference of an annotated vs unannotated tag
+        self.d.setVar('BB_GIT_SHALLOW_REVS', '1.10.0')
+
+        self.fetch_shallow()
+
+        # Confirm that the history of 1.10.0 was removed
+        orig_revs = len(self.git('rev-list master', cwd=self.srcdir).splitlines())
+        revs = len(self.git('rev-list master').splitlines())
+        self.assertNotEqual(orig_revs, revs)
+        self.assertRefs(['master', 'origin/master'])
+        self.assertRevCount(orig_revs - 1758)
-- 
2.11.0


