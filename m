Return-Path: <brian.avery@intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id AA6317016E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2016 02:36:28 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga105.fm.intel.com with ESMTP; 18 Sep 2016 19:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,360,1470726000"; d="scan'208";a="1053032744"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 18 Sep 2016 19:36:29 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 18 Sep 2016 19:37:53 -0700
Message-Id: <4cbe01c9363f21743be40e0050bf9ca5b34c3afc.1474252537.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1474252537.git.brian.avery@intel.com>
References: <cover.1474252537.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 1/1] toaster: Add tests to detect if we have missing db migrations
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
X-List-Received-Date: Mon, 19 Sep 2016 02:36:30 -0000

From: Michael Wood <michael.g.wood@intel.com>

Based on the same test as found in patchwork by Damien Lespiau
https://github.com/dlespiau/patchwork/blob/master/patchwork/tests/test_db.py

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/tests/db/__init__.py |  0
 lib/toaster/tests/db/test_db.py  | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 bitbake/lib/toaster/tests/db/__init__.py
 create mode 100644 bitbake/lib/toaster/tests/db/test_db.py

diff --git a/lib/toaster/tests/db/__init__.py b/lib/toaster/tests/db/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/tests/db/test_db.py b/lib/toaster/tests/db/test_db.py
new file mode 100644
index 0000000..a0f5f6e
--- /dev/null
+++ b/lib/toaster/tests/db/test_db.py
@@ -0,0 +1,55 @@
+# The MIT License (MIT)
+#
+# Copyright (c) 2016 Damien Lespiau
+#
+# Permission is hereby granted, free of charge, to any person obtaining a copy
+# of this software and associated documentation files (the "Software"), to deal
+# in the Software without restriction, including without limitation the rights
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# copies of the Software, and to permit persons to whom the Software is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+# SOFTWARE.
+
+import sys
+
+try:
+    from StringIO import StringIO
+except ImportError:
+    from io import StringIO
+
+from contextlib import contextmanager
+
+from django.core import management
+from django.test import TestCase
+
+
+@contextmanager
+def capture(command, *args, **kwargs):
+    out, sys.stdout = sys.stdout, StringIO()
+    command(*args, **kwargs)
+    sys.stdout.seek(0)
+    yield sys.stdout.read()
+    sys.stdout = out
+
+
+def makemigrations():
+    management.call_command('makemigrations')
+
+
+class MigrationTest(TestCase):
+
+    def testPendingMigration(self):
+        """Make sure there's no pending migration."""
+
+        with capture(makemigrations) as output:
+            self.assertEqual(output, "No changes detected\n")
-- 
1.9.1


