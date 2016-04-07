Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 30A2B6FF9B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Apr 2016 06:55:42 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 06 Apr 2016 23:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,448,1455004800"; d="scan'208";a="779829070"
Received: from bitbang.jf.intel.com ([10.7.199.152])
	by orsmga003.jf.intel.com with ESMTP; 06 Apr 2016 23:55:42 -0700
From: Randy Witt <randy.e.witt@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 23:55:39 -0700
Message-Id: <1460012140-18926-1-git-send-email-randy.e.witt@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 1/2] lib/bb/utils.py: Fix a bug in edit_metadata() that could corrupt vars
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

edit_metadata() would corrupt a variable that was multiline, but
had the ending quotes on the same line as the last value. For example:

    TEST_VAR = " foo \
    bar"

would become " foo ba" because the code would always delete the last
character on the line and then do it again if the line ended in the
quote. This however doesn't show up if you have:

    TEST_VAR = " foo \
    bar \
    "

which is how all the test cases were written.

This patch fixes that bug and adds a fixes a test that matched the bugs
behavior rather than the expected behavior.

Signed-off-by: Randy Witt <randy.e.witt@linux.intel.com>
---
 lib/bb/tests/utils.py | 2 +-
 lib/bb/utils.py       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index a035ccf..6ded4df 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -176,7 +176,7 @@ do_functionname() {
         # Test file doesn't get modified with some the same values
         self._testeditfile({'THIS': ('that', None, 0, True),
                         'OTHER': ('anothervalue', None, 0, True),
-                        'MULTILINE3': ('               c1               c2               c3', None, 4, False)}, self._origfile)
+                        'MULTILINE3': ('               c1               c2               c3 ', None, 4, False)}, self._origfile)
 
     def test_edit_metadata_file_1(self):
 
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e9ad68f..8d7df13 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1158,7 +1158,7 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
                 if in_var.endswith('()'):
                     if full_value.count('{') - full_value.count('}') >= 0:
                         continue
-                full_value = full_value[:-1]
+                    full_value = full_value[:-1]
                 if handle_var_end():
                     updated = True
                     checkspc = True
-- 
2.5.5


