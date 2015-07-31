Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 9768C765CC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:41 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 31 Jul 2015 05:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="775177470"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 31 Jul 2015 05:09:42 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id A02616A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:56 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:10 +0300
Message-Id: <0512b56a2dbd146b217e8d5cb2fbef6ae5d4e813.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 09/22] bitbake: toastergui: http api Add guard against incomplete change requests
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:43 -0000

From: Michael Wood <michael.g.wood@intel.com>

If we get a request to the project change api which either contains the
current configuration (i.e no change) or empty configuration handle this
gracefully.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/views.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9e89714..688a4c2 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2160,12 +2160,12 @@ if True:
         # execute POST requests
         if request.method == "POST":
             # add layers
-            if 'layerAdd' in request.POST:
+            if 'layerAdd' in request.POST and len(request.POST['layerAdd']) > 0:
                 for lc in Layer_Version.objects.filter(pk__in=[i for i in request.POST['layerAdd'].split(",") if len(i) > 0]):
                     ProjectLayer.objects.get_or_create(project = prj, layercommit = lc)
 
             # remove layers
-            if 'layerDel' in request.POST:
+            if 'layerDel' in request.POST and len(request.POST['layerDel']) > 0:
                 for t in request.POST['layerDel'].strip().split(" "):
                     pt = ProjectLayer.objects.filter(project = prj, layercommit_id = int(t)).delete()
 
@@ -2174,6 +2174,10 @@ if True:
                 prj.save();
 
             if 'projectVersion' in request.POST:
+                # If the release is the current project then return now
+                if prj.release.pk == int(request.POST.get('projectVersion',-1)):
+                    return {}
+
                 prj.release = Release.objects.get(pk = request.POST['projectVersion'])
                 # we need to change the bitbake version
                 prj.bitbake_version = prj.release.bitbake_version
@@ -2257,8 +2261,12 @@ if True:
 
             # returns layer versions that would be deleted on the new release__pk
             if request.GET.get('type', None) == "versionlayers":
+                # If we're already on this project do nothing
+                if prj.release.pk == int(request.GET.get('search', -1)):
+                    return HttpResponse(jsonfilter({"error": "ok", "rows": []}), content_type="application/json")
 
                 retval = []
+
                 for i in prj.projectlayer_set.all():
                     lv = prj.compatible_layerversions(release = Release.objects.get(pk=request.GET.get('search', None))).filter(layer__name = i.layercommit.layer.name)
                     # there is no layer_version with the new release id, and the same name
-- 
2.1.4


