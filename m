Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 2BD1A60125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 10:20:31 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 07 Oct 2015 03:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,648,1437462000"; d="scan'208";a="659489537"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 07 Oct 2015 03:20:31 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 18E386A4083
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 03:19:33 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 13:20:14 +0300
Message-Id: <e8ec343ddc6f66086080398f325e058d656b9516.1444213003.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1444213003.git.ed.bartosh@linux.intel.com>
References: <cover.1444213003.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444213003.git.ed.bartosh@linux.intel.com>
References: <cover.1444213003.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/2] toaster: Manually retrieve log file location from filesystem
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
X-List-Received-Date: Wed, 07 Oct 2015 10:20:31 -0000

From: Elliot Smith <elliot.smith@intel.com>

The log file location reported by the BB_CONSOLELOG variable
does not point to the log location for the current build at
the time when the BuildStarted event is fired. It
actually points to the location where the next build will
log to. This means that the log file paths associated with
a build in the cooker_log_path field are incorrect, with
the result that the "Download build log" button doesn't work.

Instead, when a build starts, get the latest-dated log file
and associate it with the build.

An issue explaining why this is a problem, plus steps to
demonstrate it:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=8411

This patch is a temporary workaround for issue 8411,
as discussed in
https://bugzilla.yoctoproject.org/show_bug.cgi?id=8373#c2
It fixes 8373 for now, but should be properly fixed if
bitbake can provide the correct log location at the point
when BuildStarted is fired.

[YOCTO #8373]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/ui/toasterui.py | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index dbe0d09..e3d3b8f 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -33,6 +33,7 @@ from bb.ui.buildinfohelper import BuildInfoHelper
 import bb.msg
 import logging
 import os
+import glob
 
 # pylint: disable=invalid-name
 # module properties for UI modules are read by bitbake and the contract should not be broken
@@ -61,6 +62,33 @@ def _log_settings_from_server(server):
         raise BaseException(error)
     return includelogs, loglines, consolelogfile
 
+# TODO this is a work-around for the bug mentioned in
+# https://bugzilla.yoctoproject.org/show_bug.cgi?id=8373#c2
+# - the log file location reported by BB_CONSOLELOG at the point
+# when the BuildStarted event occurs does not correspond to the
+# actual log file location;
+# as a work-around, we get the latest-dated log file in the same
+# directory as is in the path stored in BB_CONSOLELOG
+#
+# consolelogfile: log file location reported by BB_CONSOLELOG
+# at the point when a build starts, which isn't the actual log location;
+# the assumption is that the real log file will be in the same
+# directory as the reported log file
+#
+# returns the latest-dated *.log file in the same directory
+# as consolelogfile; if there are no *.log files, this returns
+# consolelogfile
+def _get_real_log_file(consolelogfile):
+    log_file_dir = os.path.dirname(consolelogfile)
+    log_file_pattern = os.path.join(log_file_dir, "*.log")
+    log_files = glob.glob(log_file_pattern)
+    log_files = filter(os.path.isfile, log_files)
+    log_files.sort(key=os.path.getmtime)
+
+    if len(log_files) > 0:
+        return log_files[-1]
+    else:
+        return consolelogfile
 
 def main(server, eventHandler, params ):
     helper = uihelper.BBUIHelper()
@@ -126,7 +154,8 @@ def main(server, eventHandler, params ):
             # the code will look into the protected variables of the event; no easy way around this
 
             if isinstance(event, bb.event.BuildStarted):
-                buildinfohelper.store_started_build(event, consolelogfile)
+                real_consolelogfile = _get_real_log_file(consolelogfile)
+                buildinfohelper.store_started_build(event, real_consolelogfile)
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
-- 
2.1.4


