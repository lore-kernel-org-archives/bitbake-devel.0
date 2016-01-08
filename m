Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 5FD8A731EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 11:17:30 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 08 Jan 2016 03:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,538,1444719600"; d="scan'208";a="722947335"
Received: from deryaeke-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.84])
	by orsmga003.jf.intel.com with ESMTP; 08 Jan 2016 03:17:30 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jan 2016 11:17:19 +0000
Message-Id: <9f84dc48e02b4f84ea1dff1d6a7093c17b164bc5.1452251694.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
References: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
In-Reply-To: <cover.1452251694.git.elliot.smith@intel.com>
References: <cover.1452251694.git.elliot.smith@intel.com>
Subject: [PATCH 5/8] buildinfohelper: add provides info to the db
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
X-List-Received-Date: Fri, 08 Jan 2016 11:17:30 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added new entries to Provides model and link them to
Recipe_Dependency using 'via' field.

This data will be used by Toaster UI to show 'Provides:'
information for the recipes.

[YOCTO #6169]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index cba0165..0cb6f68 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -41,7 +41,7 @@ from orm.models import Target_Image_File, BuildArtifact
 from orm.models import Variable, VariableHistory
 from orm.models import Package, Package_File, Target_Installed_Package, Target_File
 from orm.models import Task_Dependency, Package_Dependency
-from orm.models import Recipe_Dependency
+from orm.models import Recipe_Dependency, Provides
 
 from orm.models import Project
 from bldcontrol.models import BuildEnvironment, BuildRequest
@@ -1268,15 +1268,20 @@ class BuildInfoHelper(object):
            for dep in event._depgraph['depends'][recipe]:
                 if dep in assume_provided:
                     continue
+                via = None
                 if dep in event._depgraph['providermap']:
-                    dep = event._depgraph['providermap'][dep][0]
-                if dep in self.internal_state['recipes']:
+                    deprecipe = event._depgraph['providermap'][dep][0]
+                    dependency = self.internal_state['recipes'][deprecipe]
+                    via = Provides.objects.get_or_create(name=dep,
+                                                         recipe=dependency)[0]
+                elif dep in self.internal_state['recipes']:
                     dependency = self.internal_state['recipes'][dep]
                 else:
                     errormsg += "  stpd: KeyError saving recipe dependency for %s, %s \n" % (recipe, dep)
                     continue
                 recipe_dep = Recipe_Dependency(recipe=target,
                                                depends_on=dependency,
+                                               via=via,
                                                dep_type=Recipe_Dependency.TYPE_DEPENDS)
                 recipedeps_objects.append(recipe_dep)
 
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


