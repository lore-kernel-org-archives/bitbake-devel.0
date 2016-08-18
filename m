Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 3D8727707F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 16:12:04 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP; 18 Aug 2016 09:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,540,1464678000"; d="scan'208";a="750509581"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 18 Aug 2016 09:12:04 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2016 19:12:02 +0300
Message-Id: <1471536722-27044-3-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1471536722-27044-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1471536722-27044-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 2/2] tests: add unit tests for the usehead url parameter
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
X-List-Received-Date: Thu, 18 Aug 2016 16:12:04 -0000

[YOCTO #9351]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/tests/fetch.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 272078f..86b5a14 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -585,6 +585,36 @@ class FetcherNetworkTest(FetcherTest):
             url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;tag=270a05b0b4ba0959fe0624d2a4885d7b70426da5"
             self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
 
+        def test_gitfetch_localusehead(self):
+            # Create dummy local Git repo
+            src_dir = tempfile.mkdtemp(dir=self.tempdir,
+                                       prefix='gitfetch_localusehead_')
+            src_dir = os.path.abspath(src_dir)
+            bb.process.run("git init", cwd=src_dir)
+            bb.process.run("git commit --allow-empty -m'Dummy commit'",
+                           cwd=src_dir)
+            # Use other branch than master
+            bb.process.run("git checkout -b my-devel", cwd=src_dir)
+            bb.process.run("git commit --allow-empty -m'Dummy commit 2'",
+                           cwd=src_dir)
+            stdout = bb.process.run("git rev-parse HEAD", cwd=src_dir)
+            orig_rev = stdout[0].strip()
+
+            # Fetch and check revision
+            self.d.setVar("SRCREV", "AUTOINC")
+            url = "git://" + src_dir + ";protocol=file;usehead=1"
+            fetcher = bb.fetch.Fetch([url], self.d)
+            fetcher.download()
+            fetcher.unpack(self.unpackdir)
+            stdout = bb.process.run("git rev-parse HEAD",
+                                    cwd=os.path.join(self.unpackdir, 'git'))
+            unpack_rev = stdout[0].strip()
+            self.assertEqual(orig_rev, unpack_rev)
+
+        def test_gitfetch_remoteusehead(self):
+            url = "git://git.openembedded.org/bitbake;usehead=1"
+            self.assertRaises(bb.fetch.ParameterError, self.gitfetcher, url, url)
+
         def test_gitfetch_premirror(self):
             url1 = "git://git.openembedded.org/bitbake"
             url2 = "git://someserver.org/bitbake"
-- 
2.6.6


