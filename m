Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 922CB79152
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Aug 2018 14:52:17 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w7TEqIg6029558
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Aug 2018 07:52:18 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Wed, 29 Aug 2018 07:52:17 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 29 Aug 2018 10:52:17 -0400
Message-ID: <20180829145217.88222-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH] cooker.py: Fix incorrect bb files matched warning
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
X-List-Received-Date: Wed, 29 Aug 2018 14:52:17 -0000
Content-Type: text/plain

In the case of a sublayer of an existing layer, where the sublayer and
main layer share a path, the system may not match the paths properly resulting
in:

    No bb files matched BBFILE_PATTERN_sublayer '^/path/main/sublayer'

because it has already matched the main layer.

Fix this issue by sorting the collection items based on the pattern, using
longest to shortest.  Obviously regex wildcards could still be an issue
but these are typically not used, so this simply fix should work in the
existing cases.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 bin/bitbake-selftest   |  1 +
 lib/bb/cooker.py       |  5 ++-
 lib/bb/tests/cooker.py | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/tests/cooker.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 7564de3..cfa7ac5 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -27,6 +27,7 @@ except RuntimeError as exc:
     sys.exit(str(exc))
 
 tests = ["bb.tests.codeparser",
+         "bb.tests.cooker",
          "bb.tests.cow",
          "bb.tests.data",
          "bb.tests.event",
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 946ba9c..d7e90f2 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1661,7 +1661,10 @@ class CookerExit(bb.event.Event):
 class CookerCollectFiles(object):
     def __init__(self, priorities):
         self.bbappends = []
-        self.bbfile_config_priorities = priorities
+        # Priorities is a list of tupples, with the second element as the pattern.
+        # We need to sort the list with the longest pattern first, and so on to
+        # the shortest.  This allows nested layers to be properly evaluated.
+        self.bbfile_config_priorities = sorted(priorities, key=lambda tup: tup[1], reverse=True)
 
     def calc_bbfile_priority( self, filename, matched = None ):
         for _, _, regex, pri in self.bbfile_config_priorities:
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
new file mode 100644
index 0000000..2b44236
--- /dev/null
+++ b/lib/bb/tests/cooker.py
@@ -0,0 +1,83 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Tests for cooker.py
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+import unittest
+import tempfile
+import os
+import bb, bb.cooker
+import re
+import logging
+
+# Cooker tests
+class CookerTest(unittest.TestCase):
+    def setUp(self):
+        # At least one variable needs to be set
+        self.d = bb.data.init()
+        topdir = os.path.join(os.path.dirname(os.path.realpath(__file__)), "testdata/cooker")
+        self.d.setVar('TOPDIR', topdir)
+
+    def test_CookerCollectFiles_sublayers(self):
+        '''Test that a sublayer of an existing layer does not trigger
+           No bb files matched ...'''
+
+        def append_collection(topdir, path, d):
+            collection = path.split('/')[-1]
+            pattern = "^" + topdir + "/" + path + "/"
+            regex = re.compile(pattern)
+            priority = 5
+
+            d.setVar('BBFILE_COLLECTIONS', (d.getVar('BBFILE_COLLECTIONS') or "") + " " + collection)
+            d.setVar('BBFILE_PATTERN_%s' % (collection), pattern)
+            d.setVar('BBFILE_PRIORITY_%s' % (collection), priority)
+
+            return (collection, pattern, regex, priority)
+
+        topdir = self.d.getVar("TOPDIR")
+
+        # Priorities: list of (collection, pattern, regex, priority)
+        bbfile_config_priorities = []
+        # Order is important for this test, shortest to longest is typical failure case
+        bbfile_config_priorities.append( append_collection(topdir, 'first', self.d) )
+        bbfile_config_priorities.append( append_collection(topdir, 'second', self.d) )
+        bbfile_config_priorities.append( append_collection(topdir, 'second/third', self.d) )
+
+        pkgfns = [ topdir + '/first/recipes/sample1_1.0.bb',
+                   topdir + '/second/recipes/sample2_1.0.bb',
+                   topdir + '/second/third/recipes/sample3_1.0.bb' ]
+
+        class LogHandler(logging.Handler):
+            def __init__(self):
+                logging.Handler.__init__(self)
+                self.logdata = []
+
+            def emit(self, record):
+                self.logdata.append(record.getMessage())
+
+        # Move cooker to use my special logging
+        logger = bb.cooker.logger
+        log_handler = LogHandler()
+        logger.addHandler(log_handler)
+        collection = bb.cooker.CookerCollectFiles(bbfile_config_priorities)
+        collection.collection_priorities(pkgfns, self.d)
+        logger.removeHandler(log_handler)
+
+        # Should be empty (no generated messages)
+        expected = []
+
+        self.assertEqual(log_handler.logdata, expected)
-- 
1.8.3.1


