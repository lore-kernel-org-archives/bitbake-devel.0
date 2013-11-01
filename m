Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 721BA6D4F0
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 15:58:46 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Nov 2013 08:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="428337437"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.91])
	by orsmga002.jf.intel.com with ESMTP; 01 Nov 2013 08:58:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 15:58:30 +0000
Message-Id: <1072e122ee8938b6d92d7352bf55ff4278ba3158.1383321482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/8] cooker: do not recreate recipecache in buildfile mode
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
X-List-Received-Date: Fri, 01 Nov 2013 15:58:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

When building a single file, the cooker will recreate
the recipecache from scratch.

I suspect this is a remnant of past code, since:
* the current recipecache works fine
* the new recipecache will not have all the fields as
requested by HOB_EXTRA_CACHES setting

This patch disables recreating the recipecache, leading
to shorter times when building single build files
(-b option) and better compatibility with Toaster.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ccc6858..0af4558 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1085,7 +1085,6 @@ class BBCooker:
 
         self.buildSetVars()
 
-        self.recipecache = bb.cache.CacheData(self.caches_array)
         infos = bb.cache.Cache.parse(fn, self.collection.get_file_appends(fn), \
                                      self.data,
                                      self.caches_array)
-- 
1.8.1.2


