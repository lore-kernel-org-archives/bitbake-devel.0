Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 711576FFD3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Oct 2016 06:48:47 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga102.jf.intel.com with ESMTP; 06 Oct 2016 23:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,308,1473145200"; d="scan'208";a="17192245"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga005.jf.intel.com with ESMTP; 06 Oct 2016 23:48:49 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 6D6796A4080;
	Thu,  6 Oct 2016 23:48:19 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Oct 2016 09:23:20 +0300
Message-Id: <1475821400-11880-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Subject: [PATCH] toaster: fix cloning of git+ssh repositories
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
X-List-Received-Date: Fri, 07 Oct 2016 06:48:49 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replaced '+' -> '_' to avoid having '+' in folder name.

Thanks Stephan Dünner for this fix.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index a64e89b..e5f7c98 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -75,7 +75,7 @@ class LocalhostBEController(BuildEnvironmentController):
     def getGitCloneDirectory(self, url, branch):
         """Construct unique clone directory name out of url and branch."""
         if branch != "HEAD":
-            return "_toaster_clones/_%s_%s" % (re.sub('[:/@%]', '_', url), branch)
+            return "_toaster_clones/_%s_%s" % (re.sub('[:/@+%]', '_', url), branch)
 
         # word of attention; this is a localhost-specific issue; only on the localhost we expect to have "HEAD" releases
         # which _ALWAYS_ means the current poky checkout
-- 
2.1.4


