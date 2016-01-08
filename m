Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 67E7A75894
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 11:17:27 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 08 Jan 2016 03:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,538,1444719600"; d="scan'208";a="722947312"
Received: from deryaeke-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.84])
	by orsmga003.jf.intel.com with ESMTP; 08 Jan 2016 03:17:27 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jan 2016 11:17:17 +0000
Message-Id: <7bdaee593378b404f4ad0e6002f9c04a19055f47.1452251694.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
References: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
In-Reply-To: <cover.1452251694.git.elliot.smith@intel.com>
References: <cover.1452251694.git.elliot.smith@intel.com>
Subject: [PATCH 3/8] buildinfohelper: use providermap
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
X-List-Received-Date: Fri, 08 Jan 2016 11:17:27 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Used providermap in store_dependency_information function
to find virtual dependencies. This should fix annoying
warnings "stpd: KeyError saving recipe dependency"

[YOCTO #6169]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 279c5c7..cba0165 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1186,6 +1186,7 @@ class BuildInfoHelper(object):
         assert 'layer-priorities' in event._depgraph
         assert 'pn' in event._depgraph
         assert 'tdepends' in event._depgraph
+        assert 'providermap' in event._depgraph
 
         errormsg = ""
 
@@ -1263,15 +1264,22 @@ class BuildInfoHelper(object):
         # buildtime
         recipedeps_objects = []
         for recipe in event._depgraph['depends']:
-            try:
-                target = self.internal_state['recipes'][recipe]
-                for dep in event._depgraph['depends'][recipe]:
+           target = self.internal_state['recipes'][recipe]
+           for dep in event._depgraph['depends'][recipe]:
+                if dep in assume_provided:
+                    continue
+                if dep in event._depgraph['providermap']:
+                    dep = event._depgraph['providermap'][dep][0]
+                if dep in self.internal_state['recipes']:
                     dependency = self.internal_state['recipes'][dep]
-                    recipedeps_objects.append(Recipe_Dependency( recipe = target,
-                            depends_on = dependency, dep_type = Recipe_Dependency.TYPE_DEPENDS))
-            except KeyError as e:
-                if e not in assume_provided and not str(e).startswith("virtual/"):
-                    errormsg += "  stpd: KeyError saving recipe dependency for %s, %s \n" % (recipe, e)
+                else:
+                    errormsg += "  stpd: KeyError saving recipe dependency for %s, %s \n" % (recipe, dep)
+                    continue
+                recipe_dep = Recipe_Dependency(recipe=target,
+                                               depends_on=dependency,
+                                               dep_type=Recipe_Dependency.TYPE_DEPENDS)
+                recipedeps_objects.append(recipe_dep)
+
         Recipe_Dependency.objects.bulk_create(recipedeps_objects)
 
         # save all task information
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


