Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 7E18260807
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:27 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga104.jf.intel.com with ESMTP; 26 Sep 2016 04:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="173219818"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2016 04:00:29 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 841136A4006
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 04:00:02 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:33 +0300
Message-Id: <968882a3f328320f5d654fbd089f878466387742.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 06/10] toaster: Add backend API for deleting a build
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:27 -0000

From: Michael Wood <michael.g.wood@intel.com>

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/api.py  | 30 ++++++++++++++++++++++++++++++
 lib/toaster/toastergui/urls.py |  4 ++++
 2 files changed, 34 insertions(+)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 856918b..149abf7 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -832,3 +832,33 @@ class XhrProject(View):
             "error": "ok",
             "gotoUrl": reverse("all-projects", args=[])
         })
+
+
+class XhrBuild(View):
+    """ Delete a build object
+
+    Entry point: /xhr_build/<build_id>
+    """
+    def delete(self, request, *args, **kwargs):
+        """
+          Delete build data
+
+          Args:
+              build_id = build_id
+
+          Returns:
+              {"error": "ok"}
+            or
+              {"error": <error message>}
+        """
+        try:
+            build = Build.objects.get(pk=kwargs['build_id'])
+            project = build.project
+            build.delete()
+        except Build.DoesNotExist:
+            return error_response("Build %s does not exist" %
+                                  kwargs['build_id'])
+        return JsonResponse({
+            "error": "ok",
+            "gotoUrl": reverse("projectbuilds", args=(project.pk,))
+        })
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 0002a5a..ece9ac1 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -225,6 +225,10 @@ urlpatterns = patterns('toastergui.views',
             api.XhrProject.as_view(),
             name='xhr_project'),
 
+        url(r'xhr_build/(?P<build_id>\d+)$',
+            api.XhrBuild.as_view(),
+            name='xhr_build'),
+
         url(r'^mostrecentbuilds$', widgets.MostRecentBuildsView.as_view(),
             name='most_recent_builds'),
 
-- 
2.6.6


