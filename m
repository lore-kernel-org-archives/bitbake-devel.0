Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <scott.a.garman@intel.com>) id 1QUjp5-0003oi-OL
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Jun 2011 20:19:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 09 Jun 2011 11:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,342,1304319600"; d="scan'208";a="11473242"
Received: from sgarman-ws.jf.intel.com ([10.7.199.157])
	by orsmga002.jf.intel.com with ESMTP; 09 Jun 2011 11:14:50 -0700
From: Scott Garman <scott.a.garman@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Jun 2011 11:13:06 -0700
Message-Id: <1307643186-28341-1-git-send-email-scott.a.garman@intel.com>
X-Mailer: git-send-email 1.7.4.4
Subject: [PATCH 1/1] cache.py: fix bitbake -s command
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 09 Jun 2011 18:19:16 -0000

This uses the correct index of self.pn when setting up cachedata's
pkg_pn, fixing the output of bitbake -s.

This fixes bug [YOCTO #1149].

Signed-off-by: Scott Garman <scott.a.garman@intel.com>
---
 lib/bb/cache.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index a0df93e..d4a16ad 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -179,7 +179,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
     def add_cacheData(self, cachedata, fn):
         cachedata.task_deps[fn] = self.task_deps
         cachedata.pkg_fn[fn] = self.pn
-        cachedata.pkg_pn[self].append(fn)
+        cachedata.pkg_pn[self.pn].append(fn)
         cachedata.pkg_pepvpr[fn] = (self.pe, self.pv, self.pr)
         cachedata.pkg_dp[fn] = self.defaultpref
         cachedata.stamp[fn] = self.stamp
-- 
1.7.4.4



