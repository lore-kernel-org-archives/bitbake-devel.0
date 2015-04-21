Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E34EC65CF5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Apr 2015 15:48:54 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 21 Apr 2015 08:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,616,1422950400"; d="scan'208";a="698631808"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2015 08:48:55 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 7E9E06A4090;
	Tue, 21 Apr 2015 08:48:29 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Apr 2015 18:48:49 +0300
Message-Id: <1429631329-15522-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429266695.6976.194.camel@linuxfoundation.org>
References: <1429266695.6976.194.camel@linuxfoundation.org>
Subject: [PATCH] bitbake: reset build mtime cache before the build
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
X-List-Received-Date: Tue, 21 Apr 2015 15:48:55 -0000

Introduced build mtime cache structure. Reset it before the build
to prevent bitbake from crashing when build/tmp/stamps hierarchy
is removed.

[YOCTO: #7562]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/build.py  | 17 ++++++++++++++++-
 bitbake/lib/bb/cooker.py |  3 ++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 65cc851..0f6aa1a 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -31,6 +31,7 @@ import logging
 import shlex
 import glob
 import time
+import stat
 import bb
 import bb.msg
 import bb.process
@@ -42,6 +43,20 @@ logger = logging.getLogger('BitBake.Build')
 
 NULL = open(os.devnull, 'r+')
 
+__mtime_cache = {}
+
+def cached_mtime_noerror(f):
+    if f not in __mtime_cache:
+        try:
+            __mtime_cache[f] = os.stat(f)[stat.ST_MTIME]
+        except OSError:
+            return 0
+    return __mtime_cache[f]
+
+def reset_cache():
+    global __mtime_cache
+    __mtime_cache = {}
+
 # When we execute a Python function, we'd like certain things
 # in all namespaces, hence we add them to __builtins__.
 # If we do not do this and use the exec globals, they will
@@ -535,7 +550,7 @@ def stamp_internal(taskname, d, file_name, baseonly=False):
     stamp = bb.parse.siggen.stampfile(stamp, file_name, taskname, extrainfo)
 
     stampdir = os.path.dirname(stamp)
-    if bb.parse.cached_mtime_noerror(stampdir) == 0:
+    if cached_mtime_noerror(stampdir) == 0:
         bb.utils.mkdirhier(stampdir)
 
     return stamp
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9c101f2..ddf5fed 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -35,7 +35,7 @@ from contextlib import closing
 from functools import wraps
 from collections import defaultdict
 import bb, bb.exceptions, bb.command
-from bb import utils, data, parse, event, cache, providers, taskdata, runqueue
+from bb import utils, data, parse, event, cache, providers, taskdata, runqueue, build
 import Queue
 import signal
 import prserv.serv
@@ -1343,6 +1343,7 @@ class BBCooker:
                 return True
             return retval
 
+        build.reset_cache()
         self.buildSetVars()
 
         taskdata, runlist, fulltargetlist = self.buildTaskData(targets, task, self.configuration.abort)
-- 
2.1.4


