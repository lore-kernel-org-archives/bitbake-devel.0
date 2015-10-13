Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id EC38077043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Oct 2015 08:58:53 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 13 Oct 2015 01:58:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,677,1437462000"; d="scan'208";a="825677169"
Received: from mjbowe-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.22])
	by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2015 01:58:51 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Oct 2015 09:58:49 +0100
Message-Id: <1444726729-27872-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Fix missing tooltips from layers on project configuration page
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
X-List-Received-Date: Tue, 13 Oct 2015 08:58:58 -0000

From: Michael Wood <michael.g.wood@intel.com>

Re-enable the layer tooltips on the project configuration page.
This adds the required fields to the API used for the layer dependencies
to be able to show the metadata needed.

Also fixes link hrefs which were missing in the add layers confirmation
dialog (bug 8251).

[YOCTO #8295]
[YOCTO #8251]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/projectpage.js |  5 +----
 bitbake/lib/toaster/toastergui/views.py                 | 16 ++++++++++------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/projectpage.js b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
index d367047..30989a0 100644
--- a/bitbake/lib/toaster/toastergui/static/js/projectpage.js
+++ b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
@@ -146,10 +146,7 @@ function projectPageInit(ctx) {
 
       link.attr("href", layerObj.layerdetailurl);
       link.text(layerObj.name);
-      /* YOCTO #8024
-        link.tooltip({title: layerObj.giturl + " | "+ layerObj.branch.name, placement: "right"});
-        branch name not accessible sometimes it is revision instead
-      */
+      link.tooltip({title: layerObj.vcs_url + " | "+ layerObj.vcs_reference, placement: "right"});
 
       var trashItem = projectLayer.children("span");
       trashItem.click(function (e) {
diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index 468cce3..c4264a1 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -2768,12 +2768,16 @@ if True:
         project = Project.objects.get(pk=pid)
         layer_version = Layer_Version.objects.get(pk=layerid)
 
-        context = { 'project' : project,
-                   'layerversion' : layer_version,
-                   'layerdeps' : {"list": [{"id": dep.id, "name": dep.layer.name} \
-                                              for dep in layer_version.get_alldeps(project.id)]},
-                   'projectlayers': map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=project))
-                  }
+        context = {'project' : project,
+            'layerversion' : layer_version,
+            'layerdeps' : {"list": [{"id": dep.id,
+                "name": dep.layer.name,
+                "layerdetailurl": reverse('layerdetails', args=(pid, dep.pk)),
+                "vcs_url": dep.layer.vcs_url,
+                "vcs_reference": dep.get_vcs_reference()} \
+                for dep in layer_version.get_alldeps(project.id)]},
+            'projectlayers': map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=project))
+        }
 
         return context
 
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


