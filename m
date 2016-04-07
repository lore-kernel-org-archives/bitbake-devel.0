Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 318BD73167
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Apr 2016 06:55:44 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 06 Apr 2016 23:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,448,1455004800"; d="scan'208";a="779829077"
Received: from bitbang.jf.intel.com ([10.7.199.152])
	by orsmga003.jf.intel.com with ESMTP; 06 Apr 2016 23:55:45 -0700
From: Randy Witt <randy.e.witt@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 23:55:40 -0700
Message-Id: <1460012140-18926-2-git-send-email-randy.e.witt@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1460012140-18926-1-git-send-email-randy.e.witt@linux.intel.com>
References: <1460012140-18926-1-git-send-email-randy.e.witt@linux.intel.com>
Subject: [PATCH 2/2] tests/utils.py: test origvalue in a callback matches what is expected
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
X-List-Received-Date: Thu, 07 Apr 2016 06:55:45 -0000

There were any tests that checked to make verify the value of origvalue in
the callback routines used by edit_metadata(). This patch adds one for a
simple multiline variable.

Signed-off-by: Randy Witt <randy.e.witt@linux.intel.com>
---
 lib/bb/tests/utils.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 6ded4df..2f4ccf3 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -23,6 +23,7 @@ import unittest
 import bb
 import os
 import tempfile
+import re
 
 class VerCmpString(unittest.TestCase):
 
@@ -377,6 +378,27 @@ do_functionname() {
         self.assertTrue(updated, 'List should be updated but isn\'t')
         self.assertEqual(newlines, newfile5.splitlines(True))
 
+    # Make sure the orig value matches what we expect it to be
+    def test_edit_metadata_origvalue(self):
+        origfile = """
+MULTILINE = "  stuff \\
+    morestuff"
+"""
+        expected_value = "stuff morestuff"
+        global value_in_callback
+        value_in_callback = ""
+
+        def handle_var(varname, origvalue, op, newlines):
+            global value_in_callback
+            value_in_callback = origvalue
+            return (origvalue, op, -1, False)
+
+        bb.utils.edit_metadata(origfile.splitlines(True),
+                               ['MULTILINE'],
+                               handle_var)
+
+        testvalue = re.sub('\s+', ' ', value_in_callback.strip())
+        self.assertEqual(expected_value, testvalue)
 
 class EditBbLayersConf(unittest.TestCase):
 
-- 
2.5.5


