Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 1C842758D3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:18 +0000 (UTC)
Received: by wgv5 with SMTP id 5so37495224wgv.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=OUn0tEMRUeiBXaLor7fA7I4l/jmPtCL+SljgiBupT9w=;
	b=SPqbGog3MpxO97hkuQFRMnP5wcLgXbdms5HAHmZ0/7WSCNYBZefLfHW+xlz9bsXbK4
	RrLecyHugElNIV6j5tsI9dN8qwWvE6/pSsqqdFumOFLPbVwgCDoHyOs50b+XHwBHMInn
	I0NxDDKUMEgkpvDHooPs20AbD21ddUa9HxmmfM+5OyD/l+/Tc7etKEuqeYAFJTzgMQYx
	h/23lSHD6EveFFAI+VkIoM/vQlu8z0XQ5BzJ5qw0InrtvvLSoh8/k/L7X4DNySWjqra4
	7MiqU0yAeVfl4ONwB+sN+Y5XUnBi7YZHJCka3cEJz1OV8aRe7GgsqMG9inoH3H+hk6Ih
	vDfw==
X-Gm-Message-State: ALoCoQmIywN1QJ3GBtAmB40CCw2TSTAmbuvD41tQJYiLdXqqYm9/h7bwN7ndhiylAlv77iVP3UOd
X-Received: by 10.180.7.169 with SMTP id k9mr9260692wia.84.1433947159440;
	Wed, 10 Jun 2015 07:39:19 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id lu5sm14837604wjb.9.2015.06.10.07.39.18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:18 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0D9BF5610D4; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:52 +0100
Message-Id: <4528490cf663790a455815dc48fbf3dda264098c.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 04/19] toastergui: use defaults on xhr_datatypeahead parameters
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:19 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch prevents crashes when xhr_datatypeahead is called
without proper parameters.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index f2626f8..678e356 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2379,7 +2379,7 @@ if toastermain.settings.MANAGED:
 
 
             # returns layers for current project release that are not in the project set, matching the name
-            if request.GET['type'] == "layers":
+            if request.GET.get('type', None) == "layers":
                 # all layers for the current project
                 queryset_all = prj.compatible_layerversions().filter(layer__name__icontains=request.GET.get('search',''))
 
@@ -2394,9 +2394,9 @@ if toastermain.settings.MANAGED:
 
 
             # returns layer dependencies for a layer, excluding current project layers
-            if request.GET['type'] == "layerdeps":
+            if request.GET.get('type', None) == "layerdeps":
                 queryset = prj.compatible_layerversions().exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()]).filter(
-                    layer__name__in = [ x.depends_on.layer.name for x in LayerVersionDependency.objects.filter(layer_version_id = request.GET['search'])])
+                    layer__name__in = [ x.depends_on.layer.name for x in LayerVersionDependency.objects.filter(layer_version_id = request.GET.get('search', None))])
 
                 final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset])
 
@@ -2405,11 +2405,11 @@ if toastermain.settings.MANAGED:
 
 
             # returns layer versions that would be deleted on the new release__pk
-            if request.GET['type'] == "versionlayers":
+            if request.GET.get('type', None) == "versionlayers":
 
                 retval = []
                 for i in prj.projectlayer_set.all():
-                    lv = prj.compatible_layerversions(release = Release.objects.get(pk=request.GET['search'])).filter(layer__name = i.layercommit.layer.name)
+                    lv = prj.compatible_layerversions(release = Release.objects.get(pk=request.GET.get('search', None))).filter(layer__name = i.layercommit.layer.name)
                     # there is no layer_version with the new release id, and the same name
                     if lv.count() < 1:
                         retval.append(i)
@@ -2420,12 +2420,12 @@ if toastermain.settings.MANAGED:
 
 
             # returns layer versions that provide the named targets
-            if request.GET['type'] == "layers4target":
+            if request.GET.get('type', None) == "layers4target":
                 # we return data only if the recipe can't be provided by the current project layer set
-                if reduce(lambda x, y: x + y, [x.recipe_layer_version.filter(name=request.GET['search']).count() for x in prj.projectlayer_equivalent_set()], 0):
+                if reduce(lambda x, y: x + y, [x.recipe_layer_version.filter(name=request.GET.get('search', None)).count() for x in prj.projectlayer_equivalent_set()], 0):
                     final_list = []
                 else:
-                    queryset_all = prj.compatible_layerversions().filter(recipe_layer_version__name = request.GET['search'])
+                    queryset_all = prj.compatible_layerversions().filter(recipe_layer_version__name = request.GET.get('search', None))
 
                     # exclude layers in the project
                     queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])
@@ -2436,7 +2436,7 @@ if toastermain.settings.MANAGED:
                 return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict, final_list) }), content_type = "application/json")
 
             # returns targets provided by current project layers
-            if request.GET['type'] == "targets":
+            if request.GET.get('type', None) == "targets":
                 search_token = request.GET.get('search','')
                 queryset_all = Recipe.objects.filter(layer_version__layer__name__in = [x.layercommit.layer.name for x in prj.projectlayer_set.all().select_related("layercommit__layer")]).filter(Q(name__icontains=search_token) | Q(layer_version__layer__name__icontains=search_token))
 
@@ -2463,7 +2463,7 @@ if toastermain.settings.MANAGED:
                     }), content_type = "application/json")
 
             # returns machines provided by the current project layers
-            if request.GET['type'] == "machines":
+            if request.GET.get('type', None) == "machines":
                 queryset_all = Machine.objects.all()
                 if 'project_id' in request.session:
                     queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set()).order_by("name")
-- 
1.9.1


