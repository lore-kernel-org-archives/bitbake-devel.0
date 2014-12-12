Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 890F572366
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:25 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id bs8so2235267wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=lTs8ZgOPeKfsMKfmlZeLwYA4aM9HA4vw7dUB8S84N7I=;
	b=aw7/AaiqIRZeE1hSBUbqbJJ1gaScLUw2MmXaUA/u9Lofml6/YKFKMYTTDe1i75yTrr
	hPR0BkGJhbxCfgz9UEGA6f0+cAWngwqPllMnmEt18ytj2KAz92QRe/WZI0oVyASxFr6j
	stBL9L+LzPmjtS036T/L/PPhWwteKRMLHzEeWvyNPUpx/nImu4vPYueEY3rtm985GyVt
	RzJNe2aMcCCwyWdbQMJKXUKIS9HxNynS/wphauBMGEPcYk9wHI7C0/LltGnRFSHUzO04
	veIxG6S74JXTZ3wGwk3rpRsBVWaR4seOVFfgvxzEWc5ZIU4SJbhFg4jClAy2e4yFx4FA
	anBQ==
X-Gm-Message-State: ALoCoQmlzYzJUnLjJoU5yW5H1GaiAjxPpm+/jNgqaiHkXhXiPs3mG8flJWbPZEBNtXDjUsfspdBU
X-Received: by 10.194.2.34 with SMTP id 2mr11688552wjr.58.1418384725573;
	Fri, 12 Dec 2014 03:45:25 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id h13sm1645237wiw.4.2014.12.12.03.45.21
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:22 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 42B805603EF; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:09 +0000
Message-Id: <9bdd0a687ba74577f2c0f0b6c696433ea662d38f.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 10/18] toasterui: refactor project layer finding logic
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:25 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a basic refactoring of the code computing
the layer equivalence classes for a project, in order to
bring common bits of logic in a single place.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py       | 21 +++++++++++++++++-
 lib/toaster/toastergui/views.py | 49 +++++++++++++++--------------------------
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index f5c600b..46b704c 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -20,7 +20,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.db import models
-from django.db.models import F
+from django.db.models import F, Q
 from django.utils import timezone
 
 
@@ -98,6 +98,25 @@ class Project(models.Model):
     def __unicode__(self):
         return "%s (%s, %s)" % (self.name, self.release, self.bitbake_version)
 
+    # returns a queryset of compatible layers for a project
+    def compatible_layerversions(self, release = None, layer_name = None):
+        if release == None:
+            release = self.release
+        # layers on the same branch or layers specifically set for this project
+        queryset = Layer_Version.objects.filter((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = self))
+        if layer_name is not None:
+            # we select only a layer name
+            queryset = queryset.filter(layer__name = layer_name)
+
+        # order by layer version priority
+        queryset = queryset.filter(layer_source__releaselayersourcepriority__release = release).order_by("-layer_source__releaselayersourcepriority__priority")
+
+        return queryset
+
+    # returns a set of layer-equivalent set of layers already in project
+    def projectlayer_equivalent_set(self):
+        return [j for i in [x.layercommit.get_equivalents_wpriority(self) for x in self.projectlayer_set.all()] for j in i]
+
     def schedule_build(self):
         from bldcontrol.models import BuildRequest, BRTarget, BRLayer, BRVariable, BRBitbake
         br = BuildRequest.objects.create(project = self)
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 736de78..434e118 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1957,20 +1957,6 @@ if toastermain.settings.MANAGED:
 
         raise Exception("Invalid HTTP method for this page")
 
-    # returns a queryset of compatible layers for a project
-    def _compatible_layerversions_for_project(prj, release = None, layer_name = None):
-        if release == None:
-            release = prj.release
-        # layers on the same branch or layers specifically set for this project
-        return Layer_Version.objects.filter((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = prj))
-
-
-    # returns the equivalence group for all the layers currently set in the project
-    def _project_equivalent_layerversions(prj):
-        return reduce(lambda x, y: list(x) + list(y),
-                    # take all equivalent layers for each entry
-                    map(lambda x: x.layercommit.get_equivalents_wpriority(prj), prj.projectlayer_set.all()) , [])
-
     # returns a list for most recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
     def _project_recent_build_list(prj):
         return map(lambda x: {
@@ -2137,7 +2123,7 @@ if toastermain.settings.MANAGED:
                 for i in prj.projectlayer_set.all():
                     # find and add a similarly-named layer on the new branch
                     try:
-                        lv = _compatible_layerversions_for_project(prj).filter(layer__name = i.layer.name).get_equivalents_wpriority(prj)[0]
+                        lv = prj.compatible_layerversions(layer_name = i.layercommit.layer.name)[0]
                         ProjectLayer.objects.get_or_create(project = prj, layercommit = lv)
                     except IndexError:
                         pass
@@ -2185,24 +2171,25 @@ if toastermain.settings.MANAGED:
 
             # returns layers for current project release that are not in the project set, matching the name
             if request.GET['type'] == "layers":
-                queryset_all = _compatible_layerversions_for_project(prj).filter(layer__name__icontains=request.GET.get('value',''))
+                # all layers for the current project
+                queryset_all = prj.compatible_layerversions().filter(layer__name__icontains=request.GET.get('value',''))
 
-                queryset_all = queryset_all.exclude(pk__in = [x.id for x in _project_equivalent_layerversions(prj)])
+                # but not layers with equivalent layers already in project
+                queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])[:8]
 
-                queryset_all = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all[:8]])
+                # and show only the selected layers for this project
+                final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all])
 
-                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict, queryset_all) }), content_type = "application/json")
+                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict, final_list) }), content_type = "application/json")
 
 
             # returns layer dependencies for a layer, excluding current project layers
             if request.GET['type'] == "layerdeps":
-                queryset_all = LayerVersionDependency.objects.filter(layer_version_id = request.GET['value'])
-                queryset_all = queryset_all.exclude(depends_on__in = _project_equivalent_layerversions(prj))
-                queryset_all.order_by("-up_id");
+                queryset = prj.compatible_layerversions().exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()]).filter(
+                    layer__name__in = [ x.depends_on.layer.name for x in LayerVersionDependency.objects.filter(layer_version_id = request.GET['value'])])
+
+                return HttpResponse(jsonfilter( { "error":"ok", "list" : map( _lv_to_dict, queryset) }), content_type = "application/json")
 
-                return HttpResponse(jsonfilter( { "error":"ok",
-                    "list" : map( _lv_to_dict,  map(lambda x: x.depends_on.get_equivalents_wpriority(prj)[0], queryset_all))
-                    }), content_type = "application/json")
 
 
             # returns layer versions that would be deleted on the new release__pk
@@ -2212,7 +2199,7 @@ if toastermain.settings.MANAGED:
 
                 retval = []
                 for i in prj.projectlayer_set.all():
-                    lv = _compatible_layerversions_for_project(prj, release = Release.objects.get(pk=request.GET['value']))
+                    lv = prj.compatible_layerversions(release = Release.objects.get(pk=request.GET['value'])).filter(layer__name = i.layercommit.layer.name)
                     # there is no layer_version with the new release id, and the same name
                     if lv.count() < 1:
                         retval.append(i)
@@ -2225,7 +2212,7 @@ if toastermain.settings.MANAGED:
             # returns targets provided by current project layers
             if request.GET['type'] == "targets":
                 queryset_all = Recipe.objects.all()
-                queryset_all = queryset_all.filter(layer_version__in = reduce(lambda x, y: list(x) + list(y), map(lambda x: x.layercommit.get_equivalents_wpriority(prj), prj.projectlayer_set.all()), []))
+                queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set())
                 return HttpResponse(jsonfilter({ "error":"ok",
                     "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
                         queryset_all.filter(name__icontains=request.GET.get('value',''))[:8]),
@@ -2235,7 +2222,8 @@ if toastermain.settings.MANAGED:
             if request.GET['type'] == "machines":
                 queryset_all = Machine.objects.all()
                 if 'project_id' in request.session:
-                    queryset_all = queryset_all.filter(layer_version__layer__in = map(lambda x: x.layercommit.layer, ProjectLayer.objects.filter(project_id=request.session['project_id'])))
+                    queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set())
+
                 return HttpResponse(jsonfilter({ "error":"ok",
                     "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
                         queryset_all.filter(name__icontains=request.GET.get('value',''))[:8]),
@@ -2283,14 +2271,13 @@ if toastermain.settings.MANAGED:
 
         prj = Project.objects.get(pk = request.session['project_id'])
 
-        queryset_all = _compatible_layerversions_for_project(prj)
+        queryset_all = prj.compatible_layerversions()
 
         queryset_all = _get_queryset(Layer_Version, queryset_all, filter_string, search_term, ordering_string, '-layer__name')
 
-        objects_all= list(set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all[:pagesize]]))
 
         # retrieve the objects that will be displayed in the table; layers a paginator and gets a page range to display
-        layer_info = _build_page_range(Paginator(objects_all, request.GET.get('count', 10)),request.GET.get('page', 1))
+        layer_info = _build_page_range(Paginator(queryset_all, request.GET.get('count', 10)),request.GET.get('page', 1))
 
 
         context = {
-- 
1.9.1


