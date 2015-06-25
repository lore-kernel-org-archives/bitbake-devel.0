Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 9EC7C605D2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:15 +0000 (UTC)
Received: by wicnd19 with SMTP id nd19so13659499wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding;
	bh=ERHnZ87iBGisAoc13IKJs5BAqFS3TQmckEKl42yOtlk=;
	b=kuGbUAprOK3Z8cYZc8TFGuTURprcACVOfYzqHCUpZ+odb7xAG0FNaKBmMr3bmOFgWp
	yrVW3FafB4bakAdQtmOFwClmM8DbaCJrQwfeyJNuEiDuXjxd0UG9bc8VTtnRAumVXvrh
	EN4nuGA9CIGetUt2Hho8KhKGiMkKtb1CuJZ4yE0VbRrNVuDnkoQ0ZR5xC/nlHWiHzML7
	CEXa+oCHsDcrwfs2KbSaCcMI+KHeTyqDwldmfFdv8zqfm5UnAEBBEU7t7HZbZBHH5ZH+
	QMbivijqg+qONJCrTcgLNIfK/IC9nDgEZT5TpcG65qcMx3Uii7vSZOBWc+i9x0Usm2QJ
	gqzA==
X-Gm-Message-State: ALoCoQmU49hJL0xtlKXNm9IpCZe8l+/fU+8bmNVm0B42vW8ZD6IzfFhGhM9QQ3U6VNe3FWkqDf/M
X-Received: by 10.194.77.179 with SMTP id t19mr77279094wjw.30.1435228455889;
	Thu, 25 Jun 2015 03:34:15 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id z9sm6934225wiv.9.2015.06.25.03.34.14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:15 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C31D4561FDC; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:43 +0100
Message-Id: <ead45a600813a1d8594e604875803ded781f83d8.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
MIME-Version: 1.0
Subject: [PATCH 06/23] toaster: remove BuildRequest references
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:15 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In the toastergui application we should not display
implementation details about how the builds are run.
This patch removes the references to BuildRequest on the
majority of the views (except Builds page itself, as
that is more complicated).

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../toastergui/templates/basebuildpage.html        |  1 +
 lib/toaster/toastergui/templates/configvars.html   |  4 +-
 lib/toaster/toastergui/views.py                    | 66 +++++++++-------------
 3 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index b7a4dd2..105ad85 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -24,6 +24,7 @@
             $('#breadcrumb > li').append("<span class=\"divider\">→</span>");
             $('#breadcrumb > li:last').addClass("active");
             $('#breadcrumb > li:last > span').remove();
+	    console.log("done");
         });
         </script>
     </div>
diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index cbe3c68..8957673 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -56,7 +56,7 @@
         <td class="file"><a data-toggle="modal" href="#variable-{{variable.pk}}">
             {% if variable.vhistory.all %}
                 {% for path in variable.vhistory.all|filter_setin_files:file_filter %}
-                    {{path|cut_path_prefix:dirstostrip}}<br/>
+                    {{path}}<br/>
                 {% endfor %}
             {% endif %}
         </a></td>
@@ -117,7 +117,7 @@
                 <tbody>
                     {% for vh in variable.vhistory.all %}
                     <tr>
-                        <td>{{forloop.counter}}</td><td>{{vh.file_name|cut_path_prefix:dirstostrip}}</td><td>{{vh.operation}}</td><td>{{vh.line_number}}</td>
+                        <td>{{forloop.counter}}</td><td>{{vh.file_name}}</td><td>{{vh.operation}}</td><td>{{vh.line_number}}</td>
                     </tr>
                     {%endfor%}
                 </tbody>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index bfae304..060d680 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -27,7 +27,6 @@ from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
 from orm.models import Target_Installed_Package, Target_File, Target_Image_File, BuildArtifact
-from bldcontrol.models import BuildEnvironment, BuildRequest
 from bldcontrol import bbcontroller
 from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse
@@ -41,36 +40,33 @@ from django.utils import formats
 from toastergui.templatetags.projecttags import json as jsonfilter
 import json
 from os.path import dirname
+import itertools
 
 # all new sessions should come through the landing page;
 # determine in which mode we are running in, and redirect appropriately
 def landing(request):
-    if toastermain.settings.MANAGED:
-        from bldcontrol.models import BuildRequest
-        if BuildRequest.objects.count() == 0 and Project.objects.count() > 0:
-            return redirect(reverse('all-projects'), permanent = False)
+    if Build.objects.count() == 0 and Project.objects.count() > 0:
+        return redirect(reverse('all-projects'), permanent = False)
 
-        if BuildRequest.objects.all().count() > 0:
-            return redirect(reverse('all-builds'), permanent = False)
-    else:
-        if Build.objects.all().count() > 0:
-            return redirect(reverse('all-builds'), permanent = False)
+    if Build.objects.all().count() > 0:
+        return redirect(reverse('all-builds'), permanent = False)
 
-    context = {}
-    if toastermain.settings.MANAGED:
-        context['lvs_nos'] = Layer_Version.objects.all().count()
+    context = {'lvs_nos' : Layer_Version.objects.all().count()}
 
     return render(request, 'landing.html', context)
 
 # returns a list for most recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
 def _project_recent_build_list(prj):
-    return map(lambda x: {
+    data = []
+    # take the most recent 3 completed builds, plus any builds in progress
+    for x in itertools.chain(prj.build_set.filter(outcome__lt=Build.IN_PROGRESS).order_by("-pk")[:3], prj.build_set.filter(outcome=Build.IN_PROGRESS).order_by("-pk")):
+        d = {
             "id":  x.pk,
-            "targets" : map(lambda y: {"target": y.target, "task": y.task }, x.brtarget_set.all()),
-            "status": x.get_state_display(),
-            "errors": map(lambda y: {"type": y.errtype, "msg": y.errmsg, "tb": y.traceback}, x.brerror_set.all()),
-            "updated": x.updated.strftime('%s')+"000",
-            "command_time": (x.updated - x.created).total_seconds(),
+            "targets" : map(lambda y: {"target": y.target, "task": None }, x.target_set.all()), # TODO: create the task entry in the Target table
+            "status": x.get_outcome_display(),
+            "errors": map(lambda y: {"type": y.lineno, "msg": y.message, "tb": y.pathname}, x.logmessage_set.filter(level__gte=LogMessage.WARNING)),
+            "updated": x.completed_on.strftime('%s')+"000",
+            "command_time": (x.completed_on - x.started_on).total_seconds(),
             "br_page_url": reverse('buildrequestdetails', args=(x.project.id, x.pk) ),
             "build" : map( lambda y: {"id": y.pk,
                         "status": y.get_outcome_display(),
@@ -82,9 +78,11 @@ def _project_recent_build_list(prj):
                         "warnings": y.warnings_no,
                         "completeper": y.completeper() if y.outcome == Build.IN_PROGRESS else "0",
                         "eta": y.eta().strftime('%s')+"000" if y.outcome == Build.IN_PROGRESS else "0",
-                        }, Build.objects.filter(buildrequest = x)),
-        }, list(prj.buildrequest_set.filter(Q(state__lt=BuildRequest.REQ_COMPLETED) or Q(state=BuildRequest.REQ_DELETED)).order_by("-pk")) +
-            list(prj.buildrequest_set.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3]))
+                        }, [x]),
+            }
+        data.append(d)
+
+    return data
 
 
 
@@ -1372,15 +1370,6 @@ def configvars(request, build_id):
         file_filter += '/bitbake.conf'
     build_dir=re.sub("/tmp/log/.*","",Build.objects.get(pk=build_id).cooker_log_path)
 
-    clones = []
-    for breq in BuildRequest.objects.filter(build_id=build_id):
-        bc = bbcontroller.getBuildEnvironmentController(pk = breq.environment.id)
-        for brl in breq.brlayer_set.all():
-            localdirname = bc.getGitCloneDirectory(brl.giturl, brl.commit)
-            if not localdirname.startswith("/"):
-                localdirname = os.path.join(bc.be.sourcedir, localdirname)
-            clones.append(localdirname)
-
     context = {
                 'objectname': 'configvars',
                 'object_search_display':'BitBake variables',
@@ -1391,7 +1380,6 @@ def configvars(request, build_id):
                 'total_count':queryset_with_search.count(),
                 'default_orderby' : 'variable_name:+',
                 'search_term':search_term,
-                'dirstostrip': clones + [dirname(build_dir), dirname(dirname(build_dir))],
             # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
                 'tablecols' : [
                 {'name': 'Variable',
@@ -1872,7 +1860,7 @@ if True:
 
 
     # shows the "all builds" page for managed mode; it displays build requests (at least started!) instead of actual builds
-    @_template_renderer("managed_builds.html")
+    @_template_renderer("builds.html")
     def builds(request):
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
@@ -2184,10 +2172,7 @@ if True:
     # Shows the edit project page
     @_template_renderer('project.html')
     def project(request, pid):
-        try:
-            prj = Project.objects.get(id = pid)
-        except Project.DoesNotExist:
-            return HttpResponseNotFound("<h1>Project id " + pid + " is unavailable</h1>")
+        prj = Project.objects.get(id = pid)
 
         try:
             puser = User.objects.get(id = prj.user_id)
@@ -2249,8 +2234,8 @@ if True:
         context = {
             "project" : prj,
             "lvs_nos" : Layer_Version.objects.all().count(),
-            "completedbuilds": BuildRequest.objects.filter(project_id = pid).exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED),
-            "prj" : {"name": prj.name, "release": { "id": prj.release.pk, "name": prj.release.name, "desc": prj.release.description}},
+            "completedbuilds": Build.objects.filter(project_id = pid).filter(outcome__lte = Build.IN_PROGRESS),
+            "prj" : {"name": prj.name, },
             #"buildrequests" : prj.buildrequest_set.filter(state=BuildRequest.REQ_QUEUED),
             "builds" : _project_recent_build_list(prj),
             "layers" :  map(lambda x: {
@@ -2270,6 +2255,9 @@ if True:
             "project_html": 1,
         }
 
+        if prj.release is not None:
+            context["prj"]["release"] = { "id": prj.release.pk, "name": prj.release.name, "desc": prj.release.description}
+
         try:
             context["machine"] = {"name": prj.projectvariable_set.get(name="MACHINE").value}
         except ProjectVariable.DoesNotExist:
-- 
1.9.1


