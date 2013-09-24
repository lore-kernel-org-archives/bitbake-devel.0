Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 5C2436CB52
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:21 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948567"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:14 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 6BDAC562D3E; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:59 +0100
Message-Id: <87270f3bac70a03ae9760920f7e59f2e403faf8b.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 90/94] bitbake: webhob: store and display layer priorities
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:25 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Recording layer version priorities based on the information
sent with the dependency tree. The layer versions are already
created, just need to update the layer priority info.

Modifying the Simple interface to display the layer priorities.

[YOCTO #5218]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py               | 7 +++++++
 bitbake/lib/webhob/bldviewer/templates/layer.html  | 2 +-
 bitbake/lib/webhob/bldviewer/templates/recipe.html | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 7f0086e..c8820a5 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -547,6 +547,13 @@ class BuildInfoHelper(object):
 
 
     def store_dependency_information(self, event):
+        # save layer version priorities
+        for lv in event._depgraph['layer-priorities']:
+            (name, path, regexp, priority) = lv
+            layer_version_obj = self._get_layer_version_for_path(path[1:]) # paths start with a ^
+            assert layer_version_obj is not None
+            layer_version_obj.priority = priority
+            layer_version_obj.save()
 
         # save build time package information
         self.internal_state['bldpkgs'] = {}
diff --git a/bitbake/lib/webhob/bldviewer/templates/layer.html b/bitbake/lib/webhob/bldviewer/templates/layer.html
index 508f254..374a0f9 100644
--- a/bitbake/lib/webhob/bldviewer/templates/layer.html
+++ b/bitbake/lib/webhob/bldviewer/templates/layer.html
@@ -23,7 +23,7 @@
             <td><table>
             {% for lv in layer.versions %}
                 <tr><td>
-        <a href="/simple/layerversions/{{lv.id}}/recipes">{{lv.branch}}:{{lv.commit}} ({{lv.count}} recipes)</a>
+        <a href="/simple/layerversions/{{lv.id}}/recipes">({{lv.priority}}){{lv.branch}}:{{lv.commit}} ({{lv.count}} recipes)</a>
                 </td></tr>
             {% endfor %}
             </table></td>
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
index e81883f..ec8a46d 100644
--- a/bitbake/lib/webhob/bldviewer/templates/recipe.html
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -2,7 +2,7 @@
 
 {% block pagename %}
 <ul class="nav nav-tabs" style="display: inline-block">
-  <li><a>Layer  {{layer_version.layer.name}}&nbsp;:&nbsp;{{layer_version.branch}}&nbsp;:&nbsp;{{layer_version.commit}}</a></li>
+  <li><a>Layer  {{layer_version.layer.name}}&nbsp;:&nbsp;{{layer_version.branch}}&nbsp;:&nbsp;{{layer_version.commit}}&nbsp;:&nbsp;{{layer_version.priority}}</a></li>
 </ul>
     <h1>Toaster - Recipes for a Layer</h1>
 {% endblock %}
-- 
1.8.1.2


