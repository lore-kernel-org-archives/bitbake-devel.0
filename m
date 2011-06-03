Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <liping.ke@intel.com>) id 1QSJ6K-0000r5-Lj
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Jun 2011 03:23:00 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 02 Jun 2011 18:18:43 -0700
X-ExtLoop1: 1
Received: from lke-nhm.sh.intel.com (HELO localhost) ([10.239.36.48])
	by orsmga002.jf.intel.com with ESMTP; 02 Jun 2011 18:18:42 -0700
From: Ke Liping <liping.ke@intel.com>
To: poky@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jun 2011 09:06:02 +0800
Message-Id: <99a376062f675e291a6c04bfde1dbfd614bf78b2.1307062861.git.liping.ke@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1307062861.git.liping.ke@intel.com>
References: <cover.1307062861.git.liping.ke@intel.com>
In-Reply-To: <cover.1307062861.git.liping.ke@intel.com>
References: <cover.1307062861.git.liping.ke@intel.com>
Subject: [PATCH 2/4][Image Creator]Introduce extra cache class for image creator
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
X-List-Received-Date: Fri, 03 Jun 2011 01:23:00 -0000

From: Liping Ke <liping.ke@intel.com>

Extra RecipeInfo will be all defined in this file. Currently,
Only Hob (Image Creator) Requests some extra fields. So
HobRecipeInfo is defined. It's named HobRecipeInfo because it
is introduced by 'hob'. Users could also introduce other
RecipeInfo or simply use those already defined RecipeInfo.
In the following patch, this newly defined new extra RecipeInfo
will be dynamically loaded and used for loading/saving the extra
cache fields.

Signed-off-by: Liping Ke <liping.ke@intel.com>
---
 bitbake/lib/bb/cache_extra.py |   54 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 bitbake/lib/bb/cache_extra.py

diff --git a/bitbake/lib/bb/cache_extra.py b/bitbake/lib/bb/cache_extra.py
new file mode 100644
index 0000000..4c8841f
--- /dev/null
+++ b/bitbake/lib/bb/cache_extra.py
@@ -0,0 +1,54 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Extra RecipeInfo will be all defined in this file. Currently,
+# Only Hob (Image Creator) Requests some extra fields. So
+# HobRecipeInfo is defined. It's named HobRecipeInfo because it
+# is introduced by 'hob'. Users could also introduce other
+# RecipeInfo or simply use those already defined RecipeInfo.
+# In the following patch, this newly defined new extra RecipeInfo
+# will be dynamically loaded and used for loading/saving the extra
+# cache fields  
+
+# Copyright (C) 2011, Intel Corporation. All rights reserved.
+
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from bb.cache import RecipeInfoCommon
+
+class HobRecipeInfo(RecipeInfoCommon):
+    __slots__ = ()
+
+    classname = "HobRecipeInfo"
+    # please override this member with the correct data cache file
+    # such as (bb_cache.dat, bb_extracache_hob.dat) 
+    cachefile = "bb_extracache_" + classname +".dat"        
+
+    def __init__(self, filename, metadata):
+
+        self.summary = self.getvar('SUMMARY', metadata)
+        self.license = self.getvar('LICENSE', metadata)
+        self.section = self.getvar('SECTION', metadata)
+
+    @classmethod
+    def init_cacheData(cls, cachedata):
+        # CacheData in Hob RecipeInfo Class
+        cachedata.summary = {}
+        cachedata.license = {}
+        cachedata.section = {}
+
+    def add_cacheData(self, cachedata, fn):
+        cachedata.summary[fn] = self.summary
+        cachedata.license[fn] = self.license
+        cachedata.section[fn] = self.section
-- 
1.7.0.4



