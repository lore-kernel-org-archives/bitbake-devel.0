Return-Path: <mariano.lopez@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 4071777150
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Aug 2016 21:57:23 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 05 Aug 2016 14:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,475,1464678000"; d="scan'208";a="151384086"
Received: from yctb01.ostc.intel.com (HELO yctb01.otcr.intel.com)
	([10.54.69.55])
	by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2016 14:57:23 -0700
From: mariano.lopez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Fri,  5 Aug 2016 13:54:44 +0000
Message-Id: <95a804b83e274eaaab5175b8540eba4ea599730d.1470405217.git.mariano.lopez@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1470405217.git.mariano.lopez@linux.intel.com>
References: <cover.1470405217.git.mariano.lopez@linux.intel.com>
Subject: [PATCH 1/1] Fix use of tar's --exclude option for tar >= 1.29
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
X-List-Received-Date: Fri, 05 Aug 2016 21:57:23 -0000

From: Mariano Lopez <mariano.lopez@linux.intel.com>

Starting from tar 1.29 the --exclude option won't work
anymore if is not used before the path. There are some
fetch modules that copy the ptest using tar and --exclude
option. This fixes these for bitbake.

[YOCTO #9763]

Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
---
 bitbake/lib/bb/fetch2/bzr.py  | 2 +-
 bitbake/lib/bb/fetch2/cvs.py  | 2 +-
 bitbake/lib/bb/fetch2/repo.py | 2 +-
 bitbake/lib/bb/fetch2/svn.py  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/bzr.py b/bitbake/lib/bb/fetch2/bzr.py
index 03e9ac4..ce11ee7 100644
--- a/bitbake/lib/bb/fetch2/bzr.py
+++ b/bitbake/lib/bb/fetch2/bzr.py
@@ -106,7 +106,7 @@ class Bzr(FetchMethod):
         if scmdata == "keep":
             tar_flags = ""
         else:
-            tar_flags = "--exclude '.bzr' --exclude '.bzrtags'"
+            tar_flags = "--exclude='.bzr' --exclude='.bzrtags'"
 
         # tar them up to a defined filename
         runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.basename(ud.pkgdir)), d, cleanup = [ud.localpath])
diff --git a/bitbake/lib/bb/fetch2/cvs.py b/bitbake/lib/bb/fetch2/cvs.py
index d27d96f..43a234f 100644
--- a/bitbake/lib/bb/fetch2/cvs.py
+++ b/bitbake/lib/bb/fetch2/cvs.py
@@ -147,7 +147,7 @@ class Cvs(FetchMethod):
         if scmdata == "keep":
             tar_flags = ""
         else:
-            tar_flags = "--exclude 'CVS'"
+            tar_flags = "--exclude='CVS'"
 
         # tar them up to a defined filename
         if 'fullpath' in ud.parm:
diff --git a/bitbake/lib/bb/fetch2/repo.py b/bitbake/lib/bb/fetch2/repo.py
index 21678eb..fd64b7e 100644
--- a/bitbake/lib/bb/fetch2/repo.py
+++ b/bitbake/lib/bb/fetch2/repo.py
@@ -83,7 +83,7 @@ class Repo(FetchMethod):
         if scmdata == "keep":
             tar_flags = ""
         else:
-            tar_flags = "--exclude '.repo' --exclude '.git'"
+            tar_flags = "--exclude='.repo' --exclude='.git'"
 
         # Create a cache
         runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.join(".", "*") ), d)
diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 8a29193..968ca79 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -150,7 +150,7 @@ class Svn(FetchMethod):
         if scmdata == "keep":
             tar_flags = ""
         else:
-            tar_flags = "--exclude '.svn'"
+            tar_flags = "--exclude='.svn'"
 
         os.chdir(ud.pkgdir)
         # tar them up to a defined filename
-- 
2.6.6


