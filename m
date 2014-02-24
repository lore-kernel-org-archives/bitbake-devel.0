Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 882506F12A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2014 18:50:27 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Feb 2014 10:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,536,1389772800"; d="scan'208";a="487258435"
Received: from mmckenna-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.143])
	by fmsmga002.fm.intel.com with ESMTP; 24 Feb 2014 10:50:20 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Feb 2014 18:50:05 +0000
Message-Id: <31788164c1466d385b7d76a03228662df32a70d2.1393267755.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <cover.1393267755.git.paul.eggleton@linux.intel.com>
References: <cover.1393267755.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1393267755.git.paul.eggleton@linux.intel.com>
References: <cover.1393267755.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] tests: add test for gitsm fetcher
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
X-List-Received-Date: Mon, 24 Feb 2014 18:50:28 -0000

Use a newly created "git-submodule-test" repo on git.yoctoproject.org
which currently contains one submodule (the bitbake repository).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tests/fetch.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index deb1d37..156da83 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -417,6 +417,13 @@ class FetcherNetworkTest(FetcherTest):
             self.d.setVar("PREMIRRORS", "%s git://%s;protocol=file \n" % (dummyurl, self.sourcedir))
             self.gitfetcher(dummyurl, dummyurl)
 
+        def test_git_submodule(self):
+            fetcher = bb.fetch.Fetch(["gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"], self.d)
+            fetcher.download()
+            # Previous cwd has been deleted
+            os.chdir(os.path.dirname(self.unpackdir))
+            fetcher.unpack(self.unpackdir)
+
 class URLHandle(unittest.TestCase):
 
     datatable = {
-- 
1.8.5.3


