Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 5641173A82
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:51 +0000 (UTC)
Received: by wiwl15 with SMTP id l15so46504448wiw.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HVzlag55jgdBTLAxRDv8qxXOMMWFHQZV9eQhY0wu0hY=;
	b=dVYHtb8G2lsAIXju+TiJTXgs1o3B4eG4OQZOeiw8ZKgUJIcHHsB047FLjoHkGWSeAT
	3Jp4ocyKbzkuACOvGBZfDviNwtyQxwBaQqulQX317An4NsI+F9fAHyRzAZz0bRl6expy
	Z8f8rPWkxaSGK0JgO5va53O/kdrn0UNHuHWwEyzq0Bv/q470gQfVmgEza671M2KCh/nd
	Jq/XlwLBfW4FMhqPFLOtvohKzZvHrbNSwBJGfHu5bzyM5wJaYMKfho0B043NYmgFpBbC
	rMs+xZQyF36EROeenc7Qc7AimUBHquZmmhga/fsG/tDPRACpgfzLR9oI2++ctE7KLg7P
	dBZw==
X-Gm-Message-State: ALoCoQl+VHABfcQ2dPsuPluebyxAGuJDuKbXgWG7dQGR0DkOJ1/N/+1uy0/LXVnsjvND9hWsdWxR
X-Received: by 10.180.187.200 with SMTP id fu8mr63062074wic.2.1426157212993;
	Thu, 12 Mar 2015 03:46:52 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gd6sm10490624wib.17.2015.03.12.03.46.50
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 6DDC85620D9; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:42 +0000
Message-Id: <d82032cfeb1bc0571bb4174734e666e74e3b5145.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 09/17] toastergui: tables display optimizations
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:53 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings in a new set of optimizations in the tables pages,
with the focus of reducing the number of SQL queries performed per
row.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py                     | 40 +++++++++++++++------------
 lib/toaster/toastergui/templates/targets.html |  2 +-
 lib/toaster/toastergui/views.py               | 14 +++++++---
 3 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index b941d4a..2132f87 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -182,7 +182,7 @@ class Project(models.Model):
 
     # returns a set of layer-equivalent set of layers already in project
     def projectlayer_equivalent_set(self):
-        return [j for i in [x.layercommit.get_equivalents_wpriority(self) for x in self.projectlayer_set.all()] for j in i]
+        return [j for i in [x.layercommit.get_equivalents_wpriority(self) for x in self.projectlayer_set.all().select_related("up_branch")] for j in i]
 
     def schedule_build(self):
         from bldcontrol.models import BuildRequest, BRTarget, BRLayer, BRVariable, BRBitbake
@@ -545,11 +545,6 @@ class Recipe(models.Model):
     bugtracker = models.URLField(blank=True)
     file_path = models.FilePathField(max_length=255)
 
-    def get_vcs_link_url(self):
-        if self.layer_version.layer.vcs_web_file_base_url is None:
-            return ""
-        return self.layer_version.layer.vcs_web_file_base_url.replace('%path%', self.file_path).replace('%branch%', self.layer_version.up_branch.name)
-
     def get_layersource_view_url(self):
         if self.layer_source is None:
             return ""
@@ -708,8 +703,6 @@ class LayerIndexLayerSource(LayerSource):
         self.sourcetype = LayerSource.TYPE_LAYERINDEX
 
     def get_object_view(self, branch, objectype, upid):
-        if self != branch.layer_source:
-            raise Exception("Invalid branch specification")
         return self.apiurl + "../branch/" + branch.name + "/" + objectype + "/?q=" + str(upid)
 
     def update(self):
@@ -1044,14 +1037,6 @@ class Layer_Version(models.Model):
 
     def get_equivalents_wpriority(self, project):
         """ Returns an ordered layerversion list that satisfies a LayerVersionDependency using the layer name and the current Project Releases' LayerSource priority """
-        def _get_ls_priority(ls):
-            try:
-                # if there is no layer source, we have minus infinite priority, as we don't want this layer selected
-                if ls == None:
-                    return -10000
-                return ls.releaselayersourcepriority_set.get(release=project.release).priority
-            except ReleaseLayerSourcePriority.DoesNotExist:
-                raise
 
         # layers created for this project, or coming from a build inthe project
         query = Q(project = project) | Q(build__project = project)
@@ -1062,8 +1047,27 @@ class Layer_Version(models.Model):
             # or we have a layer in the project that's similar to mine (See the layer.name constraint below)
             query |= Q(projectlayer__project=project)
 
-        return sorted(
-                Layer_Version.objects.filter(layer__name = self.layer.name).filter(query).select_related('layer_source', 'layer').order_by("-id"),
+        candidate_layer_versions = list(Layer_Version.objects.filter(layer__name = self.layer.name).filter(query).select_related('layer_source', 'layer', 'up_branch').order_by("-id"))
+
+        # optimization - if we have only one, we don't need no stinking sort
+        if len(candidate_layer_versions) == 1:
+            return candidate_layer_versions
+
+#        raise Exception(candidate_layer_versions)
+
+        release_priorities = map(lambda x: (x.layer_source_id, x.priority), project.release.releaselayersourcepriority_set.all().order_by("-priority"))
+
+
+        def _get_ls_priority(ls):
+            # if there is no layer source, we have minus infinite priority, as we don't want this layer selected
+            if ls == None:
+                return -10000
+            try:
+                return release_priorities[ls.id]
+            except IndexError:
+                raise Exception("Unknown %d %s" % (ls.id, release_priorities))
+
+        return sorted( candidate_layer_versions ,
                 key = lambda x: _get_ls_priority(x.layer_source),
                 reverse = True)
 
diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index 690c6a5..f918d6c 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -60,7 +60,7 @@
         <td class="description">{% if o.description %}{{o.description}}{% else %}{{o.summary}}{%endif%}</td>
         <td class="recipe-file">
                 <code>{{o.file_path}}</code>
-                <a href="{{o.get_vcs_link_url}}{{o.file_path}}" target="_blank"><i class="icon-share get-info"></i></a>
+                <a href="{{o.vcs_link_url}}" target="_blank"><i class="icon-share get-info"></i></a>
         </td>
         <td class="target-section">{{o.section}}</td>
         <td class="license">{{o.license}}</td>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 90d47c6..541b16a 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -515,17 +515,19 @@ def target_common( request, build_id, target_id, variant ):
     packages_sum =  queryset.aggregate( Sum( 'installed_size' ))
     queryset = _get_queryset(
             Package, queryset, filter_string, search_term, ordering_string, 'name' )
+    queryset = queryset.select_related("recipe", "recipe__layer_version", "recipe__layer_version__layer")
     packages = _build_page_range( Paginator(queryset, pagesize), request.GET.get( 'page', 1 ))
 
 
+
     build = Build.objects.get( pk = build_id )
 
     # bring in package dependencies
     for p in packages.object_list:
         p.runtime_dependencies = p.package_dependencies_source.filter(
-            target_id = target_id, dep_type=Package_Dependency.TYPE_TRDEPENDS )
+            target_id = target_id, dep_type=Package_Dependency.TYPE_TRDEPENDS ).select_related("depends_on")
         p.reverse_runtime_dependencies = p.package_dependencies_target.filter(
-            target_id = target_id, dep_type=Package_Dependency.TYPE_TRDEPENDS )
+            target_id = target_id, dep_type=Package_Dependency.TYPE_TRDEPENDS ).select_related("package")
     tc_package = {
         'name'       : 'Package',
         'qhelp'      : 'Packaged output resulting from building a recipe included in this image',
@@ -2755,7 +2757,7 @@ if toastermain.settings.MANAGED:
         # get unique values for 'name', and select the maximum ID for each entry (the max id is the newest one)
         queryset_with_search_maxids = queryset_with_search.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')
 
-        queryset_with_search = queryset_with_search.filter(id__in=queryset_with_search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch')
+        queryset_with_search = queryset_with_search.filter(id__in=queryset_with_search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch', 'layer_source')
 
 
         # retrieve the objects that will be displayed in the table; targets a paginator and gets a page range to display
@@ -2763,7 +2765,11 @@ if toastermain.settings.MANAGED:
 
         for e in target_info.object_list:
             e.preffered_layerversion = e.layer_version.get_equivalents_wpriority(prj)[0]
-
+            e.vcs_link_url = Layer.objects.filter(name = e.preffered_layerversion.layer.name).exclude(vcs_web_file_base_url__isnull=True)[0].vcs_web_file_base_url
+            if e.vcs_link_url != None:
+                fp = e.preffered_layerversion.dirpath + "/" + e.file_path
+                e.vcs_link_url = e.vcs_link_url.replace('%path%', fp)
+                e.vcs_link_url = e.vcs_link_url.replace('%branch%', e.preffered_layerversion.up_branch.name)
 
         context = {
             'projectlayerset' : jsonfilter(map(lambda x: x.layercommit.id, prj.projectlayer_set.all().select_related("layercommit"))),
-- 
1.9.1


