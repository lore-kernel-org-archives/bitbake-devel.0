Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 134C273281
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Aug 2016 14:06:24 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP; 03 Aug 2016 07:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,465,1464678000"; d="scan'208";a="743646137"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2016 07:06:24 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Aug 2016 17:06:23 +0300
Message-Id: <1470233183-5470-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH] fetch2/git: allow using 'HEAD' as a branch name
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
X-List-Received-Date: Wed, 03 Aug 2016 14:06:27 -0000

This change makes it possible to e.g. build a currently checked out
revision of a local Git repository and use AUTOREV. It will be possible
to build HEAD of remote repositories, too, of course, but this is
probably not that practical.

In order to use this one must also use the nobranch parameter, i.e. have
'branch=HEAD;nobranch=1' in the SRC_URI, because 'HEAD' is really not a
Git branch as such. The wording in "branch=HEAD;nobranch=1" is probably a
bit counter-intuitive and illogical but this seems to be the only easy
way to make this work without complicating the fetcher even further.
Another solution would be e.g. to introduce an alternative 'ref'
parameter which could be used in place of 'branch' to give any ref. The
effect would basically be the same (with better wording) with yet a bit
more complex fetcher code.

[YOCTO #9351]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/fetch2/git.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4e2dcec..0c07d64 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -388,12 +388,15 @@ class Git(FetchMethod):
         output = self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other form
         if ud.unresolvedrev[name][:5] == "refs/":
-            head = ud.unresolvedrev[name]
-            tag = ud.unresolvedrev[name]
+            search_list = [ud.unresolvedrev[name],
+                           ud.unresolvedrev[name] + "^{}"]
+        elif ud.unresolvedrev[name] == 'HEAD':
+            search_list = ['HEAD']
         else:
             head = "refs/heads/%s" % ud.unresolvedrev[name]
             tag = "refs/tags/%s" % ud.unresolvedrev[name]
-        for s in [head, tag + "^{}", tag]:
+            search_list = [head, tag + "^{}", tag]
+        for s in search_list:
             for l in output.strip().split('\n'):
                 sha1, ref = l.split()
                 if s == ref:
-- 
2.6.6


