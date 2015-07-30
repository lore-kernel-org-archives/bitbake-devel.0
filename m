Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 2E1D3764C8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:59 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 30 Jul 2015 09:25:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="773368038"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2015 09:25:45 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id D80B16A4005;
	Thu, 30 Jul 2015 09:24:59 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:19 +0300
Message-Id: <07f5e9f8da6ec05c32b6aabb13d0aa0d13ca972d.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
References: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 11/11] toaster: toastergui: run pylint on the toaster files
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:59 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch enables pylint running on the toaster files, showing
only the errors. This enables spotting common mistakes in the
toaster python files.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/contrib/tts/tests.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/toaster/contrib/tts/tests.py b/lib/toaster/contrib/tts/tests.py
index 3a4eed1..c510ebb 100644
--- a/lib/toaster/contrib/tts/tests.py
+++ b/lib/toaster/contrib/tts/tests.py
@@ -38,6 +38,12 @@ class Test00PyCompilable(unittest.TestCase):
         except ShellCmdException as exc:
             self.fail("Error compiling python files: %s" % (exc))
 
+    def test_pylint_file(self):
+        try:
+            run_shell_cmd(r"find . -iname \"*\.py\" -type f -print0 | PYTHONPATH=${PYTHONPATH}:. xargs -r -0 -n1 pylint --load-plugins pylint_django -E --reports=n 2>&1", cwd=config.TESTDIR + "/bitbake/lib/toaster")
+        except ShellCmdException as exc:
+            self.fail("Pylint fails: %s\n" % exc)
+
 class Test01PySystemStart(unittest.TestCase):
     ''' Attempts to start Toaster, verify that it is succesfull, and stop it '''
     def setUp(self):
-- 
2.1.4


