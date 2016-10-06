Return-Path: <brian.avery@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 0122371A9B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Oct 2016 00:07:25 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 05 Oct 2016 17:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,451,1473145200"; d="scan'208";a="1040898347"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2016 17:07:27 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Oct 2016 17:08:49 -0700
Message-Id: <9be76de394b4a43c7dc6326545b33e2ee25b50e2.1475712223.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1475712223.git.brian.avery@intel.com>
References: <cover.1475712223.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 1/6] toaster: api / project Cancel any in progress builds before project delete
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
X-List-Received-Date: Thu, 06 Oct 2016 00:07:26 -0000

From: Michael Wood <michael.g.wood@intel.com>

Before we finally delete any project make sure we send the cancel command to
any in-progress builds. This ensures that an inaccessible build doesn't block
up the system and that we don't get errors after deletion.

[YOCTO #10289]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/toastergui/api.py                 | 55 +++++++++++++++++----------
 lib/toaster/toastergui/templates/project.html | 12 +++---
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 3a05d66..b01d4ba 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -49,6 +49,28 @@ class XhrBuildRequest(View):
     def get(self, request, *args, **kwargs):
         return HttpResponse()
 
+    @staticmethod
+    def cancel_build(br):
+        """Cancel a build request"""
+        try:
+            bbctrl = bbcontroller.BitbakeController(br.environment)
+            bbctrl.forceShutDown()
+        except:
+            # We catch a bunch of exceptions here because
+            # this is where the server has not had time to start up
+            # and the build request or build is in transit between
+            # processes.
+            # We can safely just set the build as cancelled
+            # already as it never got started
+            build = br.build
+            build.outcome = Build.CANCELLED
+            build.save()
+
+        # We now hand over to the buildinfohelper to update the
+        # build state once we've finished cancelling
+        br.state = BuildRequest.REQ_CANCELLING
+        br.save()
+
     def post(self, request, *args, **kwargs):
         """
           Build control
@@ -74,26 +96,7 @@ class XhrBuildRequest(View):
             for i in request.POST['buildCancel'].strip().split(" "):
                 try:
                     br = BuildRequest.objects.get(project=project, pk=i)
-
-                    try:
-                        bbctrl = bbcontroller.BitbakeController(br.environment)
-                        bbctrl.forceShutDown()
-                    except:
-                        # We catch a bunch of exceptions here because
-                        # this is where the server has not had time to start up
-                        # and the build request or build is in transit between
-                        # processes.
-                        # We can safely just set the build as cancelled
-                        # already as it never got started
-                        build = br.build
-                        build.outcome = Build.CANCELLED
-                        build.save()
-
-                    # We now hand over to the buildinfohelper to update the
-                    # build state once we've finished cancelling
-                    br.state = BuildRequest.REQ_CANCELLING
-                    br.save()
-
+                    self.cancel_build(br)
                 except BuildRequest.DoesNotExist:
                     return error_response('No such build request id %s' % i)
 
@@ -823,11 +826,21 @@ class XhrProject(View):
         return HttpResponse()
 
     def delete(self, request, *args, **kwargs):
+        """Delete a project. Cancels any builds in progress"""
         try:
-            Project.objects.get(pk=kwargs['project_id']).delete()
+            project = Project.objects.get(pk=kwargs['project_id'])
+            # Cancel any builds in progress
+            for br in BuildRequest.objects.filter(
+                    project=project,
+                    state=BuildRequest.REQ_INPROGRESS):
+                XhrBuildRequest.cancel_build(br)
+
+            project.delete()
+
         except Project.DoesNotExist:
             return error_response("Project %s does not exist" %
                                   kwargs['project_id'])
+
         return JsonResponse({
             "error": "ok",
             "gotoUrl": reverse("all-projects", args=[])
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 7644dad..5abe241 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -31,12 +31,14 @@
         <h4>Are you sure you want to delete this project?</h4>
       </div>
       <div class="modal-body">
-        <p>Deleting the <strong class="project-name"></strong> project will remove forever:</p>
+        <p>Deleting the <strong class="project-name"></strong> project
+        will:</p>
         <ul>
-          <li>Its configuration information</li>
-          <li>Its imported layers</li>
-          <li>Its custom images</li>
-          <li>All its build information</li>
+          <li>Cancel its builds currently in progress</li>
+          <li>Remove its configuration information</li>
+          <li>Remove its imported layers</li>
+          <li>Remove its custom images</li>
+          <li>Remove all its build information</li>
         </ul>
       </div>
       <div class="modal-footer">
-- 
1.9.1


