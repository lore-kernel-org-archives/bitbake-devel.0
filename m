Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 9A5BF6E268
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 19 Apr 2015 22:03:51 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 19 Apr 2015 15:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,605,1422950400"; d="scan'208";a="558501222"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 19 Apr 2015 15:03:54 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 176926A408F;
	Sun, 19 Apr 2015 15:03:26 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Apr 2015 01:03:42 +0300
Message-Id: <1429481022-10006-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429266695.6976.194.camel@linuxfoundation.org>
References: <1429266695.6976.194.camel@linuxfoundation.org>
Subject: [PATCH] bitbake: reset mtime cache before the build
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
X-List-Received-Date: Sun, 19 Apr 2015 22:03:51 -0000

Mtime cache is desinged with assumption that files are not
removed. Unfortunately it's not always the case for memory-resident
bitbake as build/tmp can be removed to perform build from scratch.
In this case bitbake crashes when trying to create timestamps if
tmp/stamps/ hierarchy doesn't exist.

Resetting mtime cache should solve this issue.

[YOCTO: #7562]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py         | 1 +
 bitbake/lib/bb/parse/__init__.py | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9c101f2..383bd12 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1343,6 +1343,7 @@ class BBCooker:
                 return True
             return retval
 
+        parse.reset_cache()
         self.buildSetVars()
 
         taskdata, runlist, fulltargetlist = self.buildTaskData(targets, task, self.configuration.abort)
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 25effc2..c0867d4 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -78,6 +78,10 @@ def update_cache(f):
         logger.debug(1, "Updating mtime cache for %s" % f)
         update_mtime(f)
 
+def reset_cache():
+    global __mtime_cache
+    __mtime_cache = {}
+
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
-- 
2.1.4


