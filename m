Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 78D7272491
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:10 +0000 (UTC)
Received: by wgez8 with SMTP id z8so37459536wge.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=eP0cToFtKSO/caRWfCT7c3H49IKsD89FRAgGaRyuKQA=;
	b=bI48miCz+4T0gEOAzrn9DBdIO6SI6YdQKrTRTQamS7mDMPS7oS+/g+mbo/ogz972pc
	/bUKCslinQcUs4Ijs4YoSKztXxDlJDMNzkYTqO0cjNutWBSI2IxdNJOYJqL30MTJWU2p
	knJvQ7vlJ2GAOag+9hSHUGnN4lyvMpkuO2rZIVLqtjBYSPVTXaHsyqhGCQ0Ng4iuVhzy
	LMvtKc8PIQIYTinZFcQKQGAhghjf0qZqyHgxBvxGcrS6mQ2cm2ZrM76RHCoMhrhK0U1e
	8s5cT1dsYMBKnaC/ki6MMnVXvVTd4dSvZT4OZ+Z+Rey0I66djQSK0BzruB1metAYZU44
	m2oQ==
X-Gm-Message-State: ALoCoQkvNvrPTkpq07BnbFncATcxSkNl/sOGLCRBJZTUKSeWryMee8RLt+1x7Whd1+kbBoos3Xn1
X-Received: by 10.194.78.134 with SMTP id b6mr6857452wjx.13.1433947151373;
	Wed, 10 Jun 2015 07:39:11 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	wi1sm14880135wjb.41.2015.06.10.07.39.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:10 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 08CB8561068; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:50 +0100
Message-Id: <7a6eb36b82c5f2e342777e479d9c401ded42453d.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 02/19] convert all project-based view to JSON APIs
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch converts all-project views that are REST-style URLs
to support JSON encoding if the "format=json" parameter is supplied.

The formatting code is enhanced to prevent following Django foreign
keys, to convert enum-values from int to string, and support for
timedelta.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 164 ++++++++++++++++++++++++----------------
 1 file changed, 99 insertions(+), 65 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index d4a9b4c..f2626f8 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -87,6 +87,55 @@ def _project_recent_build_list(prj):
             list(prj.buildrequest_set.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3]))
 
 
+def _template_renderer(template):
+    def func_wrapper(view):
+        def returned_wrapper(request, *args, **kwargs):
+            try:
+                context = view(request, *args, **kwargs)
+            except RedirectException as e:
+                return e.get_redirect_response()
+
+            if request.GET.get('format', None) == 'json':
+                # objects is a special keyword - it's a Page, but we need the actual objects here
+                # in XHR, the objects come in the "list" property
+                if "objects" in context:
+                    context["list"] = context["objects"].object_list
+                    del context["objects"]
+
+                # we're about to return; to keep up with the XHR API, we set the error to OK
+                context["error"] = "ok"
+                def _objtojson(obj):
+                    from django.db.models.query import QuerySet
+                    from django.db.models import Model, IntegerField
+                    if isinstance(obj, datetime):
+                        return obj.isoformat()
+                    elif isinstance(obj, timedelta):
+                        return obj.total_seconds()
+                    elif isinstance(obj, QuerySet) or isinstance(obj, set):
+                        return list(obj)
+                    elif hasattr( obj, '__dict__'):
+                        d = obj.__dict__
+                        nd = dict(d)
+                        for di in d:
+                            if di.startswith("_"):
+                                del nd[di]
+                            elif isinstance(d[di], Model):
+                                nd[di] = d[di].pk
+                            elif isinstance(d[di], int) and hasattr(obj, "get_%s_display" % di):
+                                nd[di] = getattr(obj, "get_%s_display" % di)()
+                        return nd
+                    else:
+                        raise TypeError("Unserializable object %s of type %s" % ( obj, type(obj)))
+
+                return HttpResponse(jsonfilter(context, default=_objtojson ),
+                            content_type = "application/json; charset=utf-8")
+            else:
+                return render(request, template, context)
+        return returned_wrapper
+    return func_wrapper
+
+
+
 def _build_page_range(paginator, index = 1):
     try:
         page = paginator.page(index)
@@ -129,7 +178,7 @@ def _redirect_parameters(view, g, mandatory_parameters, *args, **kwargs):
         if not i in params:
             params[i] = urllib.unquote(str(mandatory_parameters[i]))
 
-    return redirect(url + "?%s" % urllib.urlencode(params), permanent = False, *args, **kwargs)
+    return redirect(url + "?%s" % urllib.urlencode(params), permanent = False, **kwargs)
 
 class RedirectException(Exception):
     def __init__(self, view, g, mandatory_parameters, *args, **kwargs):
@@ -141,7 +190,7 @@ class RedirectException(Exception):
         self.okwargs = kwargs
 
     def get_redirect_response(self):
-        return _redirect_parameters(self.view, self.g, self.mandatory_parameters, self.oargs, self.okwargs)
+        return _redirect_parameters(self.view, self.g, self.mandatory_parameters, self.oargs, **self.okwargs)
 
 FIELD_SEPARATOR = ":"
 AND_VALUE_SEPARATOR = "!"
@@ -1839,8 +1888,8 @@ if toastermain.settings.MANAGED:
 
 
     # shows the "all builds" page for managed mode; it displays build requests (at least started!) instead of actual builds
+    @_template_renderer("managed_builds.html")
     def builds(request):
-        template = 'managed_builds.html'
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
@@ -1850,12 +1899,10 @@ if toastermain.settings.MANAGED:
         try:
             context, pagesize, orderby = _build_list_helper(request, buildrequests, True)
         except InvalidRequestException as e:
-            return _redirect_parameters( builds, request.GET, e.response)
+            raise RedirectException( builds, request.GET, e.response)
 
-        response = render(request, template, context)
         _set_parameters_values(pagesize, orderby, request)
-        return response
-
+        return context
 
 
     # helper function, to be used on "all builds" and "project builds" pages
@@ -2151,8 +2198,8 @@ if toastermain.settings.MANAGED:
 
 
     # Shows the edit project page
+    @_template_renderer('project.html')
     def project(request, pid):
-        template = "project.html"
         try:
             prj = Project.objects.get(id = pid)
         except Project.DoesNotExist:
@@ -2207,10 +2254,7 @@ if toastermain.settings.MANAGED:
         except ProjectVariable.DoesNotExist:
             context["distro"] = "-- not set yet"
 
-        response = render(request, template, context)
-        response['Cache-Control'] = "no-cache, must-revalidate, no-store"
-        response['Pragma'] = "no-cache"
-        return response
+        return context
 
 
     def xhr_projectbuild(request, pid):
@@ -2680,8 +2724,8 @@ if toastermain.settings.MANAGED:
 
         return(vars_managed,sorted(vars_fstypes),vars_blacklist)
 
+    @_template_renderer("projectconf.html")
     def projectconf(request, pid):
-        template = "projectconf.html"
 
         try:
             prj = Project.objects.get(id = pid)
@@ -2730,21 +2774,20 @@ if toastermain.settings.MANAGED:
         except ProjectVariable.DoesNotExist:
             pass
 
-        return render(request, template, context)
+        return context
 
+    @_template_renderer('projectbuilds.html')
     def projectbuilds(request, pid):
-        template = 'projectbuilds.html'
         buildrequests = BuildRequest.objects.filter(project_id = pid).exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
 
         try:
             context, pagesize, orderby = _build_list_helper(request, buildrequests, False)
         except InvalidRequestException as e:
-            return _redirect_parameters(projectbuilds, request.GET, e.response, pid = pid)
+            raise RedirectException('projectbuilds', request.GET, e.response, pid = pid)
 
-        response = render(request, template, context)
         _set_parameters_values(pagesize, orderby, request)
 
-        return response
+        return context
 
 
     def _file_name_for_artifact(b, artifact_type, artifact_id):
@@ -2861,32 +2904,8 @@ if toastermain.settings.MANAGED:
         return build_mru
 
 
-    def template_renderer(template):
-        def func_wrapper(view):
-            def returned_wrapper(request, *args, **kwargs):
-                try:
-                    context = view(request, *args, **kwargs)
-                except RedirectException as e:
-                    return e.get_redirect_response()
-
-                if request.GET.get('format', None) == 'json':
-                    # objects is a special keyword - it's a Page, but we need the actual objects here
-                    # in XHR, the objects come in the "list" property
-                    if "objects" in context:
-                        context["list"] = context["objects"].object_list
-                        del context["objects"]
-
-                    # we're about to return; to keep up with the XHR API, we set the error to OK
-                    context["error"] = "ok"
-
-                    return HttpResponse(jsonfilter(context, default=lambda obj: obj.isoformat() if isinstance(obj, datetime) else obj.__dict__ ),
-                                content_type = "application/json; charset=utf-8")
-                else:
-                    return render(request, template, context)
-            return returned_wrapper
-        return func_wrapper
 
-    @template_renderer("projects.html")
+    @_template_renderer("projects.html")
     def projects(request):
         (pagesize, orderby) = _get_parameters_values(request, 10, 'updated:-')
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
@@ -2995,18 +3014,19 @@ if toastermain.settings.MANAGED:
         _set_parameters_values(pagesize, orderby, request)
         return context
 
+    @_template_renderer("buildrequestdetails.html")
     def buildrequestdetails(request, pid, brid):
-        template = "buildrequestdetails.html"
         context = {
             'buildrequest' : BuildRequest.objects.get(pk = brid, project_id = pid)
         }
-        return render(request, template, context)
+        return context
 
 
 else:
     # shows the "all builds" page for interactive mode; this is the old code, simply moved
+
+    @_template_renderer('build.html')
     def builds(request):
-        template = 'build.html'
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
@@ -3014,7 +3034,7 @@ else:
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            return _redirect_parameters( 'all-builds', request.GET, mandatory_parameters)
+            raise RedirectException( 'all-builds', request.GET, mandatory_parameters)
 
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
@@ -3194,55 +3214,69 @@ else:
 
         # merge daterange values
         context.update(context_date)
-
-        response = render(request, template, context)
         _set_parameters_values(pagesize, orderby, request)
-        return response
+
+        return context
 
 
 
 
+    @_template_renderer('landing_not_managed.html')
     def newproject(request):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def project(request, pid):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def xhr_projectbuild(request, pid):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def xhr_projectinfo(request):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def xhr_projectedit(request, pid):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def xhr_datatypeahead(request):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def xhr_configvaredit(request, pid):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def importlayer(request):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def projectconf(request, pid):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def projectbuilds(request, pid):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def build_artifact(request, build_id, artifact_type, artifact_id):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def projects(request):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def xhr_importlayer(request):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def xhr_updatelayer(request):
-        return render(request, 'landing_not_managed.html')
+        return {}
 
+    @_template_renderer('landing_not_managed.html')
     def buildrequestdetails(request, pid, brid):
-        return render(request, 'landing_not_managed.html')
+        return {}
-- 
1.9.1


