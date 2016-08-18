Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 522DD77045
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 16:12:03 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP; 18 Aug 2016 09:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,540,1464678000"; d="scan'208";a="750509566"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 18 Aug 2016 09:12:03 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2016 19:12:01 +0300
Message-Id: <1471536722-27044-2-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1471536722-27044-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1471536722-27044-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 1/2] git: Allow local repos to use HEAD
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
X-List-Received-Date: Thu, 18 Aug 2016 16:12:03 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Introduce a new 'usehead' url parameter for git repositories. Specifying
usehead=1 causes bitbake to use whatever commit the repository HEAD is
pointing to. Usage of usehead=1 is only allowed for local git
repositories, i.e. it must always be accompanied with protocol=file url
parameter.

[YOCTO #9351]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/fetch2/git.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4e2dcec..fd8f3fd 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -49,6 +49,10 @@ Supported SRC_URI options are:
    referring to commit which is valid in tag instead of branch.
    The default is "0", set nobranch=1 if needed.
 
+- usehead
+   For local git:// urls to use the current branch HEAD as the revsion for use with
+   AUTOREV. Implies nobranch.
+
 """
 
 #Copyright (C) 2005 Richard Purdie
@@ -153,6 +157,13 @@ class Git(FetchMethod):
 
         ud.nobranch = ud.parm.get("nobranch","0") == "1"
 
+        # usehead implies nobranch
+        ud.usehead = ud.parm.get("usehead","0") == "1"
+        if ud.usehead:
+            if ud.proto != "file":
+                 raise bb.fetch2.ParameterError("The usehead option is only for use with local ('protocol=file') git repositories", ud.url)
+            ud.nobranch = 1
+
         # bareclone implies nocheckout
         ud.bareclone = ud.parm.get("bareclone","0") == "1"
         if ud.bareclone:
@@ -168,6 +179,9 @@ class Git(FetchMethod):
             ud.branches[name] = branch
             ud.unresolvedrev[name] = branch
 
+        if ud.usehead:
+            ud.unresolvedrev['default'] = 'HEAD'
+
         ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git -c core.fsyncobjectfiles=0"
 
         ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0") or ud.rebaseable
@@ -387,7 +401,7 @@ class Git(FetchMethod):
         """
         output = self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other form
-        if ud.unresolvedrev[name][:5] == "refs/":
+        if ud.unresolvedrev[name][:5] == "refs/" or ud.usehead:
             head = ud.unresolvedrev[name]
             tag = ud.unresolvedrev[name]
         else:
-- 
2.6.6


