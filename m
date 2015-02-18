Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id CAA8C735C4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:06 +0000 (UTC)
Received: by mail-wi0-f182.google.com with SMTP id l15so4406051wiw.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=qUMIAyvvqv/NttRbKv2Epibe/3uXZF+XgCsYxJcPpV4=;
	b=OQOzJQAUudO4lsLQXZF1MBYAzeqVgQ37J5J3Qpzlb2AF7X9BDdFh9X24ATmAM5577b
	eWB/9bBeZJjYKtQxQxnrgVkmEc+vHMzUhKn5XQYo8hheIIKlRATLwP/WZhaXHO9QYHB1
	/J3zDRogG9MYSPqZ2I9CJ2uQUxuNzvvyIgNUT2SUQd1wwwPeE3q1oTdhoFTWBdbY4X7G
	Cq4jL+ondCL2umk+bdD/+KQKJ2FDEQHco1ndRRUcZ86NWfyQ47Pn0nB4a65ltEbUUhft
	eWJXogHVJ7t0BRFdiQXQm+OkB7vLeYEzRlxyRXp0OSGOBT8VELd8k8IDCGcqg2/APowE
	ehdQ==
X-Gm-Message-State: ALoCoQnk8qbdKe49kWbq6X1QkYfCB3Pdgr7bCL8BNYhHOOJxV0QqETJQ+dKQd1YVpjU+5R1e6z0/
X-Received: by 10.180.228.72 with SMTP id sg8mr7773008wic.48.1424286667027;
	Wed, 18 Feb 2015 11:11:07 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	nb14sm1095393wic.18.2015.02.18.11.11.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:05 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 469B3561F4A; Wed, 18 Feb 2015 19:11:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:10:58 +0000
Message-Id: <eefdae12120f879b555ba0a353277a18675eecbc.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
References: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Subject: [PATCH 04/10] toasterui: UI query performance improvements
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
X-List-Received-Date: Wed, 18 Feb 2015 19:11:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We reduce the number of queries by using "select_related"
to bring in more data in a single query. Improvements in
project page refresh, recipes table and tasks table.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py       | 11 +++++++----
 lib/toaster/toastergui/views.py | 15 +++++++++------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0f85c8f..54cd535 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -362,11 +362,14 @@ class Task(models.Model):
         return "Not Executed"
 
     def get_description(self):
-        helptext = HelpText.objects.filter(key=self.task_name, area=HelpText.VARIABLE, build=self.build)
+        if '_helptext' in vars(self) and self._helptext != None:
+            return self._helptext
         try:
-            return helptext[0].text
-        except IndexError:
-            return ''
+            self._helptext = HelpText.objects.get(key=self.task_name, area=HelpText.VARIABLE, build=self.build).text
+        except HelpText.DoesNotExit:
+            self._helptext = None
+
+        return self._helptext
 
     build = models.ForeignKey(Build, related_name='task_build')
     order = models.IntegerField(null=True)
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index eb323ec..a2e9206 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -75,8 +75,9 @@ def _project_recent_build_list(prj):
                         'build_time_page_url': reverse('buildtime', args=(y.pk,)),
                         "errors": y.errors_no,
                         "warnings": y.warnings_no,
-                        "completeper": y.completeper(),
-                        "eta": y.eta().strftime('%s')+"000"}, Build.objects.filter(buildrequest = x)),
+                        "completeper": y.completeper() if y.outcome == Build.IN_PROGRESS else "0",
+                        "eta": y.eta().strftime('%s')+"000" if y.outcome == Build.IN_PROGRESS else "0",
+                        }, Build.objects.filter(buildrequest = x)),
         }, list(prj.buildrequest_set.filter(Q(state__lt=BuildRequest.REQ_COMPLETED) or Q(state=BuildRequest.REQ_DELETED)).order_by("-pk")) +
             list(prj.buildrequest_set.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3]))
 
@@ -828,6 +829,8 @@ def tasks_common(request, build_id, variant, task_anchor):
     else:
         queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string, 'order')
 
+    queryset = queryset.select_related("recipe", "build")
+
     # compute the anchor's page
     if anchor:
         request.GET = request.GET.copy()
@@ -1023,14 +1026,14 @@ def recipes(request, build_id):
     if retval:
         return _redirect_parameters( 'recipes', request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Recipe)
-    queryset = Recipe.objects.filter(layer_version__id__in=Layer_Version.objects.filter(build=build_id))
+    queryset = Recipe.objects.filter(layer_version__id__in=Layer_Version.objects.filter(build=build_id)).select_related("layer_version", "layer_version__layer")
     queryset = _get_queryset(Recipe, queryset, filter_string, search_term, ordering_string, 'name')
 
     recipes = _build_page_range(Paginator(queryset, pagesize),request.GET.get('page', 1))
 
     # prefetch the forward and reverse recipe dependencies
     deps = { }; revs = { }
-    queryset_dependency=Recipe_Dependency.objects.filter(recipe__layer_version__build_id = build_id)
+    queryset_dependency=Recipe_Dependency.objects.filter(recipe__layer_version__build_id = build_id).select_related("depends_on", "recipe")
     for recipe in recipes:
         deplist = [ ]
         for recipe_dep in [x for x in queryset_dependency if x.recipe_id == recipe.id]:
@@ -1804,7 +1807,7 @@ if toastermain.settings.MANAGED:
         (filter_string, search_term, ordering_string) = _search_tuple(request, BuildRequest)
         # we don't display in-progress or deleted builds
         queryset_all = buildrequests.exclude(state = BuildRequest.REQ_DELETED)
-        queryset_all = queryset_all.annotate(Count('brerror'))
+        queryset_all = queryset_all.select_related("build", "build__project").annotate(Count('brerror'))
         queryset_with_search = _get_queryset(BuildRequest, queryset_all, filter_string, search_term, ordering_string, '-updated')
 
 
@@ -2179,7 +2182,7 @@ if toastermain.settings.MANAGED:
             # return all project settings
             return HttpResponse(jsonfilter( {
                 "error": "ok",
-                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(x.layercommit.layer.pk,)), "branch" : { "name" : x.layercommit.up_branch.name, "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().order_by("id")),
+                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(x.layercommit.layer.pk,)), "branch" : { "name" : x.layercommit.up_branch.name, "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().select_related("layer").order_by("id")),
                 "builds" : _project_recent_build_list(prj),
                 "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
                 "machine": {"name": prj.projectvariable_set.get(name="MACHINE").value},
-- 
1.9.1


