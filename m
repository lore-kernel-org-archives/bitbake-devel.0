Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A3B7D6F12D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2014 18:50:27 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Feb 2014 10:50:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,536,1389772800"; d="scan'208";a="487258417"
Received: from mmckenna-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.143])
	by fmsmga002.fm.intel.com with ESMTP; 24 Feb 2014 10:50:18 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Feb 2014 18:50:03 +0000
Message-Id: <d78973c4f2cde514a9b246992c9ac42960b6759e.1393267755.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <cover.1393267755.git.paul.eggleton@linux.intel.com>
References: <cover.1393267755.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1393267755.git.paul.eggleton@linux.intel.com>
References: <cover.1393267755.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] bitbake-selftest: enable specifying tests to run on command line
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

If you are just trying to fix one test at a time, it can be useful to be
able to specify an individual test(s) rather than running them all:

 bitbake-selftest bb.tests.codeparser bb.tests.cow

You can even specify the test class or function to run, e.g.:

 bitbake-selftest bb.tests.fetch.URITest
 bitbake-selftest bb.tests.fetch.FetcherNetworkTest.test_fetch

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-selftest | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 48a58fe..8c55f7b 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -25,13 +25,24 @@ try:
 except RuntimeError as exc:
     sys.exit(str(exc))
 
-tests = ["bb.tests.codeparser", 
-         "bb.tests.cow",
-         "bb.tests.data",
-         "bb.tests.fetch",
-         "bb.tests.utils"]
+def usage():
+    print('usage: %s [testname1 [testname2]...]')
+
+if len(sys.argv) > 1:
+    if '--help' in sys.argv[1:]:
+        usage()
+        sys.exit(0)
+
+    tests = sys.argv[1:]
+else:
+    tests = ["bb.tests.codeparser",
+             "bb.tests.cow",
+             "bb.tests.data",
+             "bb.tests.fetch",
+             "bb.tests.utils"]
 
 for t in tests:
+    t = '.'.join(t.split('.')[:3])
     __import__(t)
 
 unittest.main(argv=["bitbake-selftest"] + tests)
-- 
1.8.5.3


