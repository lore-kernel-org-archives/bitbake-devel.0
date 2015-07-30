Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 763CE764AB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:56 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 30 Jul 2015 09:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="533149130"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2015 09:25:39 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 9E7AB6A4005;
	Thu, 30 Jul 2015 09:24:53 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:15 +0300
Message-Id: <d089bafcb39fe5812d3017ee08d5313cea598b6c.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
References: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 07/11] toaster: tts: delete pyc files before the tests start
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:56 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

There may be leftover *.pyc files from previous code runs in the
current checkout directory, so we delete everything before
starting the tests, to make sure that we actually testing the
current checkout.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/contrib/tts/runner.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/toaster/contrib/tts/runner.py b/lib/toaster/contrib/tts/runner.py
index 3fd1b66..6fc3e77 100755
--- a/lib/toaster/contrib/tts/runner.py
+++ b/lib/toaster/contrib/tts/runner.py
@@ -200,6 +200,10 @@ def main():
             testdir = set_up_test_branch(settings, args[0]) # we expect a branch name as first argument
 
         config.TESTDIR = testdir    # we let tests know where to run
+
+        # ensure that the test dir only contains no *.pyc leftovers
+        run_shell_cmd("find '%s' -type f -name *.pyc -exec rm {} \;" % testdir)
+
         no_failures = execute_tests(testdir, options.singletest)
 
     except ShellCmdException as exc:
-- 
2.1.4


