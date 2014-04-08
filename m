Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 463FA65DD8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 17:30:52 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2014 08:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,818,1389772800"; d="scan'208";a="489326629"
Received: from paulonei-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.244])
	by orsmga001.jf.intel.com with ESMTP; 08 Apr 2014 08:50:11 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Apr 2014 16:49:55 +0100
Message-Id: <009039f87754a13ada8654fd3aa406fe250849af.1396972155.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396972155.git.paul.eggleton@linux.intel.com>
References: <cover.1396972155.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1396972155.git.paul.eggleton@linux.intel.com>
References: <cover.1396972155.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] bitbake-selftest: add tests for local fetching
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
X-List-Received-Date: Tue, 08 Apr 2014 17:30:52 -0000

Add some explicit tests for unpacking local files to the appropriate
location. Some of these tests are actually testing for broken behaviour;
these have been called out in the comments, and associated bugs have
been filed.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tests/fetch.py | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4be5a07..7df7a0e 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -390,6 +390,61 @@ class MirrorUriTest(FetcherTest):
         uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///someotherpath/downloads/bitbake-1.0.tar.gz'])
 
+
+class FetcherLocalTest(FetcherTest):
+    def setUp(self):
+        def touch(fn):
+            with file(fn, 'a'):
+                os.utime(fn, None)
+
+        super(FetcherLocalTest, self).setUp()
+        self.localsrcdir = os.path.join(self.tempdir, 'localsrc')
+        os.makedirs(self.localsrcdir)
+        touch(os.path.join(self.localsrcdir, 'a'))
+        touch(os.path.join(self.localsrcdir, 'b'))
+        os.makedirs(os.path.join(self.localsrcdir, 'dir'))
+        touch(os.path.join(self.localsrcdir, 'dir', 'c'))
+        touch(os.path.join(self.localsrcdir, 'dir', 'd'))
+        os.makedirs(os.path.join(self.localsrcdir, 'dir', 'subdir'))
+        touch(os.path.join(self.localsrcdir, 'dir', 'subdir', 'e'))
+        self.d.setVar("FILESPATH", self.localsrcdir)
+
+    def fetchUnpack(self, uris):
+        fetcher = bb.fetch.Fetch(uris, self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        flst = []
+        for root, dirs, files in os.walk(self.unpackdir):
+            for f in files:
+                flst.append(os.path.relpath(os.path.join(root, f), self.unpackdir))
+        flst.sort()
+        return flst
+
+    def test_local(self):
+        tree = self.fetchUnpack(['file://a', 'file://dir/c'])
+        self.assertEqual(tree, ['a', 'dir/c'])
+
+    def test_local_wildcard(self):
+        tree = self.fetchUnpack(['file://a', 'file://dir/*'])
+        # FIXME: this is broken - it should return ['a', 'dir/c', 'dir/d', 'dir/subdir/e']
+        # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=6128
+        self.assertEqual(tree, ['a', 'b', 'dir/c', 'dir/d', 'dir/subdir/e'])
+
+    def test_local_dir(self):
+        tree = self.fetchUnpack(['file://a', 'file://dir'])
+        self.assertEqual(tree, ['a', 'dir/c', 'dir/d', 'dir/subdir/e'])
+
+    def test_local_subdir(self):
+        tree = self.fetchUnpack(['file://dir/subdir'])
+        # FIXME: this is broken - it should return ['dir/subdir/e']
+        # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=6129
+        self.assertEqual(tree, ['subdir/e'])
+
+    def test_local_subdir_file(self):
+        tree = self.fetchUnpack(['file://dir/subdir/e'])
+        self.assertEqual(tree, ['dir/subdir/e'])
+
+
 class FetcherNetworkTest(FetcherTest):
 
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-- 
1.9.0


