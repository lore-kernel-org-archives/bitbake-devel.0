Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UL8NA-0004iI-C0
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Mar 2013 09:39:48 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 28 Mar 2013 01:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,924,1355126400"; d="scan'208";a="313050599"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.146])
	by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2013 01:22:32 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Mar 2013 10:23:17 +0200
Message-Id: <1364459002-4165-2-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 1/6] cache_extra.py : added package information
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
X-List-Received-Date: Thu, 28 Mar 2013 08:39:48 -0000

Added a new variable to cache_extra so that
the files brought in by a package can be
displayed in hob.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/cache_extra.py |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/cache_extra.py b/bitbake/lib/bb/cache_extra.py
index bf02bb7..9e38a43 100644
--- a/bitbake/lib/bb/cache_extra.py
+++ b/bitbake/lib/bb/cache_extra.py
@@ -44,6 +44,7 @@ class HobRecipeInfo(RecipeInfoCommon):
         self.homepage = self.getvar('HOMEPAGE', metadata)
         self.bugtracker = self.getvar('BUGTRACKER', metadata)
         self.prevision = self.getvar('PR', metadata)
+        self.files_info = self.getvar('FILES_INFO', metadata)
 
     @classmethod
     def init_cacheData(cls, cachedata):
@@ -55,6 +56,7 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.homepage = {}
         cachedata.bugtracker = {}
         cachedata.prevision = {}
+        cachedata.files_info = {}
 
     def add_cacheData(self, cachedata, fn):
         cachedata.summary[fn] = self.summary
@@ -64,3 +66,4 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.homepage[fn] = self.homepage
         cachedata.bugtracker[fn] = self.bugtracker
         cachedata.prevision[fn] = self.prevision
+        cachedata.files_info[fn] = self.files_info
-- 
1.7.9.5



