Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 346B37649D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:34 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 30 Jul 2015 09:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="773367926"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2015 09:25:34 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id DD4836A4005;
	Thu, 30 Jul 2015 09:24:48 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:12 +0300
Message-Id: <e619c35313ef9101091bd7ac3ed629dd0479933b.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
References: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 04/11] toaster: tts: improve debugging information
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:34 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add debug information, and exception handling as to make
it easy to figure out what is going on when tests fail on
automatic start.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/contrib/tts/runner.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/contrib/tts/runner.py b/lib/toaster/contrib/tts/runner.py
index 809fb35..dac632c 100755
--- a/lib/toaster/contrib/tts/runner.py
+++ b/lib/toaster/contrib/tts/runner.py
@@ -62,7 +62,10 @@ def set_up_test_branch(settings, branch_name):
     # creates the host dir
     if os.path.exists(testdir):
         raise Exception("Test dir '%s'is already there, aborting" % testdir)
-    os.mkdir(testdir)
+
+    # may raise OSError, is to be handled by the caller
+    os.makedirs(testdir)
+
 
     # copies over the .git from the localclone
     run_shell_cmd("cp -a '%s'/.git '%s'" % (settings['localclone'], testdir))
@@ -171,12 +174,20 @@ def read_settings():
 def clean_up(testdir):
     run_shell_cmd("rm -rf -- '%s'" % testdir)
 
+def dump_info(settings, options, args):
+    """ detailed information about current run configuration, for debugging purposes.
+    """
+    config.logger.debug("Settings:\n%s\nOptions:\n%s\nArguments:\n%s\n", settings, options, args)
+
 def main():
     (options, args) = validate_args()
 
     settings = read_settings()
     need_cleanup = False
 
+    # dump debug info
+    dump_info(settings, options, args)
+
     testdir = None
     no_failures = 1
     try:
-- 
2.1.4


