Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 1316965D00
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Mar 2016 15:00:27 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 22 Mar 2016 07:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,377,1455004800"; d="scan'208";a="769112005"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga003.jf.intel.com with ESMTP; 22 Mar 2016 07:59:57 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Mar 2016 16:59:55 +0200
Message-Id: <1458658795-15511-2-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1458658795-15511-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1458658795-15511-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH] Make BB_DONT_CACHE variable external
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
X-List-Received-Date: Tue, 22 Mar 2016 15:00:28 -0000

This makes it possible to prevent a recipe to be cached, and thus,
parsed every time.

Use with care.

[YOCTO #8853]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/cache.py           | 2 +-
 lib/bb/fetch2/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 063ab15..af5b9fb 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -99,7 +99,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.timestamp = bb.parse.cached_mtime(filename)
         self.variants = self.listvar('__VARIANTS', metadata) + ['']
         self.appends = self.listvar('__BBAPPEND', metadata)
-        self.nocache = self.getvar('__BB_DONT_CACHE', metadata)
+        self.nocache = self.getvar('BB_DONT_CACHE', metadata)
 
         self.skipreason = self.getvar('__SKIPPED', metadata)
         if self.skipreason:
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f86014c..5df642e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -713,7 +713,7 @@ def subprocess_setup():
 def get_autorev(d):
     #  only not cache src rev in autorev case
     if d.getVar('BB_SRCREV_POLICY', True) != "cache":
-        d.setVar('__BB_DONT_CACHE', '1')
+        d.setVar('BB_DONT_CACHE', '1')
     return "AUTOINC"
 
 def get_srcrev(d, method_name='sortable_revision'):
-- 
2.6.2


