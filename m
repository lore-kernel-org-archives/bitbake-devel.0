Return-Path: <benjamin.esquivel@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 98D8B77002
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 15:14:51 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 03 Sep 2015 08:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,462,1437462000"; d="scan'208";a="554601240"
Received: from yctb04.ostc.intel.com (HELO yctb04.otcr.jf.intel.com)
	([10.23.219.53])
	by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2015 08:14:51 -0700
From: Benjamin Esquivel <benjamin.esquivel@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Sep 2015 07:10:45 +0000
Message-Id: <1441264245-25624-1-git-send-email-benjamin.esquivel@linux.intel.com>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1441128323.3828.8.camel@intel.com>
References: <1441128323.3828.8.camel@intel.com>
Subject: [PATCH] bitbake: fixing a potential error in movefile
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
X-List-Received-Date: Thu, 03 Sep 2015 15:14:53 -0000

bitbake utils' movefile is now prone to malform the destination
file with duplicated file name strings. Fixing it to force a file
name append iff the dest argument is a dir not a file name

Signed-off-by: Benjamin Esquivel <benjamin.esquivel@linux.intel.com>
---
 bitbake/lib/bb/utils.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 5eec787..b62985d 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -741,9 +741,12 @@ def movefile(src, dest, newmtime = None, sstat = None):
     renamefailed = 1
     if sstat[stat.ST_DEV] == dstat[stat.ST_DEV]:
         try:
-            # os.rename needs to know the destination path with file name
-            destfile = os.path.join(dest, os.path.basename(src))
-            os.rename(src, destfile) 
+            # os.rename needs to know the dest path ending with file name
+            # so append the file name to a path only if it's a dir specified
+            srcfname = os.path.basename(src)
+            destpath = os.path.join(dest, srcfname) if os.path.isdir(dest) \
+                        else dest
+            os.rename(src, destpath)
             renamefailed = 0
         except Exception as e:
             if e[0] != errno.EXDEV:
-- 
2.3.0


