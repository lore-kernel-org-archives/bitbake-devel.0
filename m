Return-Path: <Qi.Chen@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id BF38C60797
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jan 2016 08:32:05 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u068W6bN023377
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jan 2016 00:32:06 -0800
Received: from pek-qchen1-d1.corp.ad.wrs.com (128.224.162.246) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.248.2; Wed, 6 Jan 2016 00:32:05 -0800
From: Chen Qi <Qi.Chen@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Jan 2016 16:32:07 +0800
Message-ID: <1452069127-13245-1-git-send-email-Qi.Chen@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] bitbake: clean up stamp-base related codes
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
X-List-Received-Date: Wed, 06 Jan 2016 08:32:06 -0000
Content-Type: text/plain

The 'stamp-base' related codes are no longer useful, clean them up.

[YOCTO #8468]

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/build.py | 4 ++--
 bitbake/lib/bb/cache.py | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 22428a6..b84338b 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -582,10 +582,10 @@ def stamp_internal(taskname, d, file_name, baseonly=False):
         taskflagname = taskname.replace("_setscene", "")
 
     if file_name:
-        stamp = d.stamp_base[file_name].get(taskflagname) or d.stamp[file_name]
+        stamp = d.stamp[file_name]
         extrainfo = d.stamp_extrainfo[file_name].get(taskflagname) or ""
     else:
-        stamp = d.getVarFlag(taskflagname, 'stamp-base', True) or d.getVar('STAMP', True)
+        stamp = d.getVar('STAMP', True)
         file_name = d.getVar('BB_FILENAME', True)
         extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info', True) or ""
 
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 521f758..0ec4057 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -129,7 +129,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.not_world = self.getvar('EXCLUDE_FROM_WORLD', metadata)
         self.stamp = self.getvar('STAMP', metadata)
         self.stampclean = self.getvar('STAMPCLEAN', metadata)        
-        self.stamp_base = self.flaglist('stamp-base', self.tasks, metadata)
         self.stamp_base_clean = self.flaglist('stamp-base-clean', self.tasks, metadata)
         self.stamp_extrainfo = self.flaglist('stamp-extra-info', self.tasks, metadata)
         self.file_checksums = self.flaglist('file-checksums', self.tasks, metadata, True)
@@ -158,7 +157,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         cachedata.stamp = {}
         cachedata.stampclean = {}
-        cachedata.stamp_base = {}
         cachedata.stamp_base_clean = {}
         cachedata.stamp_extrainfo = {}
         cachedata.file_checksums = {}
@@ -192,7 +190,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.pkg_dp[fn] = self.defaultpref
         cachedata.stamp[fn] = self.stamp
         cachedata.stampclean[fn] = self.stampclean
-        cachedata.stamp_base[fn] = self.stamp_base
         cachedata.stamp_base_clean[fn] = self.stamp_base_clean
         cachedata.stamp_extrainfo[fn] = self.stamp_extrainfo
         cachedata.file_checksums[fn] = self.file_checksums
-- 
1.9.1


