Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 25E5D6CB46
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948517"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id CB238561AB4; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:02 +0100
Message-Id: <62447475bb54806d118d911606a87027c1da5e7b.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 33/94] bitbake: dsi: save detailed recipe information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:20 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Code to save the recipe information coming in the dependency
tree. Also marks recipes that generate images.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index b0b56aa..92f1621 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -411,22 +411,24 @@ class BuildInfoHelper(object):
             recipe_info['name'] = pn
             recipe_info['version'] = event._depgraph['pn'][pn]['version']
             recipe_info['layer_version'] = layer_version_obj
-
-            # TODO: dump all this info in the deptree event
-            recipe_info['summary'] = 'Not Available'
-            recipe_info['description'] = 'Not Available'
-            recipe_info['section'] = 'Not Available'
-            recipe_info['license'] = 'Not Available'
+            recipe_info['summary'] = event._depgraph['pn'][pn]['summary']
+            recipe_info['license'] = event._depgraph['pn'][pn]['license']
+            recipe_info['description'] = event._depgraph['pn'][pn]['summary']
+            recipe_info['section'] = event._depgraph['pn'][pn]['section']
             recipe_info['licensing_info'] = 'Not Available'
-            recipe_info['homepage'] = 'Not Available'
-            recipe_info['bugtracker'] = 'Not Available'
+            recipe_info['homepage'] = event._depgraph['pn'][pn]['homepage']
+            recipe_info['bugtracker'] = event._depgraph['pn'][pn]['bugtracker']
             recipe_info['author'] = 'Not Available'
             recipe_info['file_path'] = file_name
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_info)
+            recipe.is_image = True in map(lambda x: x.endswith('image.bbclass'), event._depgraph['pn'][pn]['inherits'])
             self.internal_state['recipes'][pn] = recipe
 
+        # save all task information
         def _save_a_task(taskdesc):
-            pn, taskname = re.split(r'\.', taskdesc);
+            spec = re.split(r'\.', taskdesc);
+            pn = ".".join(spec[0:-1])
+            taskname = spec[-1]
             e = event
             e.taskname = pn
             recipe = self.internal_state['recipes'][pn]
-- 
1.8.1.2


