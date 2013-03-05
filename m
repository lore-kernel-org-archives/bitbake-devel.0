Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuBU-0003eO-2k
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:53:44 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2013 07:34:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343550"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:05 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:21 +0200
Message-Id: <1362497791-30020-2-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 01/11] added extra variables to cache_extra.py
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
X-List-Received-Date: Tue, 05 Mar 2013 15:53:46 -0000

- in order to have the information needed in the property
  windows, cache_extra.py was extended with variables.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/cache_extra.py |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/lib/bb/cache_extra.py b/bitbake/lib/bb/cache_extra.py
index 40ba304..bf02bb7 100644
--- a/bitbake/lib/bb/cache_extra.py
+++ b/bitbake/lib/bb/cache_extra.py
@@ -41,6 +41,9 @@ class HobRecipeInfo(RecipeInfoCommon):
         self.license = self.getvar('LICENSE', metadata)
         self.section = self.getvar('SECTION', metadata)
         self.description = self.getvar('DESCRIPTION', metadata)
+        self.homepage = self.getvar('HOMEPAGE', metadata)
+        self.bugtracker = self.getvar('BUGTRACKER', metadata)
+        self.prevision = self.getvar('PR', metadata)
 
     @classmethod
     def init_cacheData(cls, cachedata):
@@ -49,9 +52,15 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.license = {}
         cachedata.section = {}
         cachedata.description = {}
+        cachedata.homepage = {}
+        cachedata.bugtracker = {}
+        cachedata.prevision = {}
 
     def add_cacheData(self, cachedata, fn):
         cachedata.summary[fn] = self.summary
         cachedata.license[fn] = self.license
         cachedata.section[fn] = self.section
         cachedata.description[fn] = self.description
+        cachedata.homepage[fn] = self.homepage
+        cachedata.bugtracker[fn] = self.bugtracker
+        cachedata.prevision[fn] = self.prevision
-- 
1.7.9.5



