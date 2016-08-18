Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3FA697700A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 16:55:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 18 Aug 2016 09:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,540,1464678000"; d="scan'208";a="1016782727"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga001.jf.intel.com with ESMTP; 18 Aug 2016 09:55:58 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2016 19:55:53 +0300
Message-Id: <1471539354-32382-4-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 3/4] bitbake-selftest: introduce BB_TMPDIR_NOCLEAN
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
X-List-Received-Date: Thu, 18 Aug 2016 16:55:59 -0000

Set this env variable to 'yes' to preserve temporary directories used by
the fetcher tests. Useful for debugging tests.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 bin/bitbake-selftest  | 1 +
 lib/bb/tests/fetch.py | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 25905d7..1e00e33 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -41,6 +41,7 @@ ENV_HELP = """\
 Environment variables:
   BB_SKIP_NETTESTS      set to 'yes' in order to skip tests using network
                         connection
+  BB_TMPDIR_NOCLEAN     set to 'yes' to preserve test tmp directories
 """
 
 class main(unittest.main):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 272078f..e8c416a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -360,7 +360,10 @@ class FetcherTest(unittest.TestCase):
 
     def tearDown(self):
         os.chdir(self.origdir)
-        bb.utils.prunedir(self.tempdir)
+        if os.environ.get("BB_TMPDIR_NOCLEAN") == "yes":
+            print("Not cleaning up %s. Please remove manually." % self.tempdir)
+        else:
+            bb.utils.prunedir(self.tempdir)
 
 class MirrorUriTest(FetcherTest):
 
-- 
2.6.6


