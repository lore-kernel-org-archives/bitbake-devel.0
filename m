Return-Path: <laurentiu.palcu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 89E186D491
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Feb 2014 11:33:08 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 03 Feb 2014 03:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,771,1384329600"; d="scan'208";a="475076901"
Received: from lpalcu-mobl.ger.corp.intel.com (HELO lpalcu-linux.rb.intel.com)
	([10.237.105.45])
	by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2014 03:33:08 -0800
From: Laurentiu Palcu <laurentiu.palcu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Feb 2014 13:33:07 +0200
Message-Id: <1391427187-14499-1-git-send-email-laurentiu.palcu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: build.py: create separate function for shell trap creation code
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
X-List-Received-Date: Mon, 03 Feb 2014 11:33:08 -0000

Currently, the shell trap code was created in exec_func_shell(). Split
the function so that we can create the code separately.

Also, some whitespaces were automatically deleted by my editor. Since
this is not necessarily a bad thing, leave these changes too.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
---
This change is needed by the rootfs refactoring patchset that went to oe-core.

laurentiu


 bitbake/lib/bb/build.py |   37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 3aa6375..692b91e 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -254,19 +254,8 @@ def exec_func_python(func, d, runfile, cwd=None):
             except OSError:
                 pass
 
-def exec_func_shell(func, d, runfile, cwd=None):
-    """Execute a shell function from the metadata
-
-    Note on directory behavior.  The 'dirs' varflag should contain a list
-    of the directories you need created prior to execution.  The last
-    item in the list is where we will chdir/cd to.
-    """
-
-    # Don't let the emitted shell script override PWD
-    d.delVarFlag('PWD', 'export')
-
-    with open(runfile, 'w') as script:
-        script.write('''#!/bin/sh\n
+def shell_trap_code():
+    return '''#!/bin/sh\n
 # Emit a useful diagnostic if something fails:
 bb_exit_handler() {
     ret=$?
@@ -282,7 +271,21 @@ bb_exit_handler() {
 }
 trap 'bb_exit_handler' 0
 set -e
-''')
+'''
+
+def exec_func_shell(func, d, runfile, cwd=None):
+    """Execute a shell function from the metadata
+
+    Note on directory behavior.  The 'dirs' varflag should contain a list
+    of the directories you need created prior to execution.  The last
+    item in the list is where we will chdir/cd to.
+    """
+
+    # Don't let the emitted shell script override PWD
+    d.delVarFlag('PWD', 'export')
+
+    with open(runfile, 'w') as script:
+        script.write(shell_trap_code())
 
         bb.data.emit_func(func, script, d)
 
@@ -473,12 +476,12 @@ def _exec_task(fn, task, d, quieterr):
     return 0
 
 def exec_task(fn, task, d, profile = False):
-    try: 
+    try:
         quieterr = False
         if d.getVarFlag(task, "quieterrors") is not None:
             quieterr = True
 
-        if profile: 
+        if profile:
             profname = "profile-%s.log" % (d.getVar("PN", True) + "-" + task)
             try:
                 import cProfile as profile
@@ -576,7 +579,7 @@ def make_stamp(task, d, file_name = None):
             if name.endswith('.taint'):
                 continue
             os.unlink(name)
-    
+
     stamp = stamp_internal(task, d, file_name)
     # Remove the file and recreate to force timestamp
     # change on broken NFS filesystems
-- 
1.7.9.5


