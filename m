Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 99D457017C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 15:42:54 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 18 Jan 2016 07:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,312,1449561600"; 
	d="scan'208,217";a="863123649"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 18 Jan 2016 07:42:55 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 26F622C8001
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 08:30:50 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jan 2016 15:45:10 +0200
Message-Id: <45beac1c11ca00ecce038a68c6a3e05932d052d2.1453124453.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1453124453.git.ed.bartosh@linux.intel.com>
References: <cover.1453124453.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1453124453.git.ed.bartosh@linux.intel.com>
References: <cover.1453124453.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 3/3] toaster: toastergui: make artifact download more robust
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
X-List-Received-Date: Mon, 18 Jan 2016 15:42:54 -0000

From: Elliot Smith <elliot.smith@intel.com>

When an artifact download is requested, Toaster goes through a
convoluted series of conditions to decide which file to push
to the response. In the case of build artifact downloads for
command line builds, this caused an ugly exception, as command
line builds don't have a build request.

To simplify and catch more corner cases, remove the code which
fetches files via the build environment (we only support the local
build environment anyway). Then push all requests along a single
path, catching any missing file errors, missing object errors
or poorly-formed URLs in a single except clause which always returns
a valid response.

Also modify the text on the "unavailable artifact" page so it
says that the artifact doesn't exist, rather than it "no longer"
exists (exceptions may occur because an invalid artifact was
requested, rather than an artifact which was removed).

[YOCTO #7603]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 .../toastergui/templates/unavailable_artifact.html | 13 ++-
 lib/toaster/toastergui/views.py                    | 97 +++++++++-------------
 2 files changed, 47 insertions(+), 63 deletions(-)

diff --git a/lib/toaster/toastergui/templates/unavailable_artifact.html b/lib/toaster/toastergui/templates/unavailable_artifact.html
index 0301a6c..2d3d02c 100644
--- a/lib/toaster/toastergui/templates/unavailable_artifact.html
+++ b/lib/toaster/toastergui/templates/unavailable_artifact.html
@@ -3,15 +3,14 @@
 {% load humanize %}
 {% load static %}
 
-{% block title %} Build artifact no longer exists - Toaster {% endblock %}
+{% block title %} Build artifact does not exist - Toaster {% endblock %}
 
 {% block pagecontent %}
-
-<div class="row-fluid air">
-    <div class="alert alert-info span8 lead">
-        <p"> The build artifact you are trying to download no longer exists.</p>
-        <p><a href="javascript:window.history.back()">Back to previous page</a></p>
+    <div class="row-fluid air">
+        <div class="alert alert-info span8 lead">
+            <p>The build artifact you are trying to download does not exist.</p>
+            <p><a href="javascript:window.history.back()">Back to previous page</a></p>
+        </div>
     </div>
-</div>
 {% endblock %}
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 59e16b2..995937a 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -35,7 +35,7 @@ from orm.models import BitbakeVersion, CustomImageRecipe
 from bldcontrol import bbcontroller
 from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse, resolve
-from django.core.exceptions import MultipleObjectsReturned
+from django.core.exceptions import MultipleObjectsReturned, ObjectDoesNotExist
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseBadRequest, HttpResponseNotFound
 from django.utils import timezone
@@ -2575,78 +2575,63 @@ if True:
 
         return context
 
-    def _file_name_for_artifact(b, artifact_type, artifact_id):
+    def _file_names_for_artifact(build, artifact_type, artifact_id):
+        """
+        Return a tuple (file path, file name for the download response) for an
+        artifact of type artifact_type with ID artifact_id for build; if
+        artifact type is not supported, returns (None, None)
+        """
         file_name = None
-        # Target_Image_File file_name
-        if artifact_type == "imagefile":
-            file_name = Target_Image_File.objects.get(target__build = b, pk = artifact_id).file_name
+        response_file_name = None
+
+        if artifact_type == "cookerlog":
+            file_name = build.cooker_log_path
+            response_file_name = "cooker.log"
+
+        elif artifact_type == "imagefile":
+            file_name = Target_Image_File.objects.get(target__build = build, pk = artifact_id).file_name
 
         elif artifact_type == "buildartifact":
-            file_name = BuildArtifact.objects.get(build = b, pk = artifact_id).file_name
+            file_name = BuildArtifact.objects.get(build = build, pk = artifact_id).file_name
 
-        elif artifact_type ==  "licensemanifest":
-            file_name = Target.objects.get(build = b, pk = artifact_id).license_manifest_path
+        elif artifact_type == "licensemanifest":
+            file_name = Target.objects.get(build = build, pk = artifact_id).license_manifest_path
 
         elif artifact_type == "tasklogfile":
-            file_name = Task.objects.get(build = b, pk = artifact_id).logfile
+            file_name = Task.objects.get(build = build, pk = artifact_id).logfile
 
         elif artifact_type == "logmessagefile":
-            file_name = LogMessage.objects.get(build = b, pk = artifact_id).pathname
-        else:
-            raise Exception("FIXME: artifact type %s not implemented" % (artifact_type))
+            file_name = LogMessage.objects.get(build = build, pk = artifact_id).pathname
 
-        return file_name
+        if file_name and not response_file_name:
+            response_file_name = os.path.basename(file_name)
 
+        return (file_name, response_file_name)
 
     def build_artifact(request, build_id, artifact_type, artifact_id):
-        if artifact_type in ["cookerlog"]:
-            try:
-                build = Build.objects.get(pk = build_id)
-                file_name = build.cooker_log_path
+        """
+        View which returns a build artifact file as a response
+        """
+        file_name = None
+        response_file_name = None
+
+        try:
+            build = Build.objects.get(pk = build_id)
+            file_name, response_file_name = _file_names_for_artifact(
+                build, artifact_type, artifact_id
+            )
+
+            if file_name and response_file_name:
                 fsock = open(file_name, "r")
                 content_type = MimeTypeFinder.get_mimetype(file_name)
 
                 response = HttpResponse(fsock, content_type = content_type)
 
-                disposition = 'attachment; filename=cooker.log'
-                response['Content-Disposition'] = disposition
+                disposition = "attachment; filename=" + response_file_name
+                response["Content-Disposition"] = disposition
 
                 return response
-            except IOError:
-                context = {
-                    'build' : Build.objects.get(pk = build_id),
-                }
-                return render(request, "unavailable_artifact.html", context)
-
-        else:
-            # retrieve the artifact directly from the build environment
-            return _get_be_artifact(request, build_id, artifact_type, artifact_id)
-
-
-    def _get_be_artifact(request, build_id, artifact_type, artifact_id):
-        try:
-            b = Build.objects.get(pk=build_id)
-            if b.buildrequest is None or b.buildrequest.environment is None:
-                raise Exception("Artifact not available for download (missing build request or build environment)")
-
-            file_name = _file_name_for_artifact(b, artifact_type, artifact_id)
-            fsock = None
-            content_type='application/force-download'
-
-            if file_name is None:
-                raise Exception("Could not handle artifact %s id %s" % (artifact_type, artifact_id))
             else:
-                content_type = MimeTypeFinder.get_mimetype(file_name)
-                fsock = b.buildrequest.environment.get_artifact(file_name)
-                file_name = os.path.basename(file_name) # we assume that the build environment system has the same path conventions as host
-
-            response = HttpResponse(fsock, content_type = content_type)
-
-            # returns a file from the environment
-            response['Content-Disposition'] = 'attachment; filename=' + file_name
-            return response
-        except IOError:
-            context = {
-                'build' : Build.objects.get(pk = build_id),
-            }
-            return render(request, "unavailable_artifact.html", context)
+                return render(request, "unavailable_artifact.html")
+        except ObjectDoesNotExist, IOError:
+            return render(request, "unavailable_artifact.html")
-- 
2.1.4


