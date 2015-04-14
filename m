Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 78A806ABF7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Apr 2015 16:42:57 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 14 Apr 2015 09:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,576,1422950400"; d="scan'208";a="480808558"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2015 09:42:59 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 7B0C16A408D;
	Tue, 14 Apr 2015 09:42:34 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Apr 2015 19:42:50 +0300
Message-Id: <1429029770-15462-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: invalidate mtime cache if file doesn't exist
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
X-List-Received-Date: Tue, 14 Apr 2015 16:42:59 -0000

Mtime cache is desinged with assumption that files are not
removed. Unfortunately it's not always the case for memory-resident
bitbake as build/tmp can be removed to perform build from scratch.
In this case bitbake crashes when trying to create timestamps if
tmp/stamps/ hierarchy doesn't exist.

Simple check of file existance should solve this issue.

[YOCTO: #7562]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/parse/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 25effc2..e880732 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -62,6 +62,8 @@ def cached_mtime(f):
     return __mtime_cache[f]
 
 def cached_mtime_noerror(f):
+    if not os.path.exists(f):
+        return 0
     if f not in __mtime_cache:
         try:
             __mtime_cache[f] = os.stat(f)[stat.ST_MTIME]
-- 
2.1.4


