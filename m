Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 1648776FF2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 16:55:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 18 Aug 2016 09:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,540,1464678000"; d="scan'208";a="1016782684"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga001.jf.intel.com with ESMTP; 18 Aug 2016 09:55:56 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2016 19:55:51 +0300
Message-Id: <1471539354-32382-2-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 1/4] bitbake-selftest: utilize unittest.main better
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
X-List-Received-Date: Thu, 18 Aug 2016 16:55:58 -0000

This simplifies the script, and, gives new features. It is now possible
to run single test functions, for example. This is nice when writing new
test cases.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 bin/bitbake-selftest | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 1e6f35e..1e615cc 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -25,31 +25,17 @@ try:
 except RuntimeError as exc:
     sys.exit(str(exc))
 
-def usage():
-    print('usage: [BB_SKIP_NETTESTS=yes] %s [-v] [testname1 [testname2]...]' % os.path.basename(sys.argv[0]))
-
-verbosity = 1
-
-tests = sys.argv[1:]
-if '-v' in sys.argv:
-    tests.remove('-v')
-    verbosity = 2
-
-if tests:
-    if '--help' in sys.argv[1:]:
-        usage()
-        sys.exit(0)
-else:
-    tests = ["bb.tests.codeparser",
-             "bb.tests.cow",
-             "bb.tests.data",
-             "bb.tests.fetch",
-             "bb.tests.parse",
-             "bb.tests.utils"]
+tests = ["bb.tests.codeparser",
+         "bb.tests.cow",
+         "bb.tests.data",
+         "bb.tests.fetch",
+         "bb.tests.parse",
+         "bb.tests.utils"]
 
 for t in tests:
     t = '.'.join(t.split('.')[:3])
     __import__(t)
 
-unittest.main(argv=["bitbake-selftest"] + tests, verbosity=verbosity)
 
+if __name__ == '__main__':
+        unittest.main(defaultTest=tests)
-- 
2.6.6


