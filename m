Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 2C55D77077
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:13 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so194368996pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=xRD/O+6uwcom1rqI5hR858fz2dB9KTjJmsbbPhXv3kE=;
	b=Tpt3f5JNhmtUYAUJoymv368pIUMnQRkUZSSJIadqwvv6Z6Sgju/m0Kf3Asih8yA8l+
	uU248M8IoIM2qqGX5hKBZbazm4vQR6i/1kt1s59dpiotXKOSUuu9ae3Ah5/LBgtnshDo
	cJo0Dff4DYq15QvCJzG75CVZYTIQPlJtexuZexdOf1kAitcvqq0dRjZp4OI111uyG2/k
	Ti5rQE6CNWink2rgcqLbbb0b0Bkzic4oEfqiVKLRmltlVXP6IzAmZOHi2g3IyVt01Q5N
	D1J+6nx5MXMf8nTTFii5VPtZuWU9h10EJalNPQhlsKY842VPbYOm3/j1PjO76erYoISU
	+JWg==
X-Received: by 10.68.184.162 with SMTP id ev2mr30516690pbc.109.1443501853670; 
	Mon, 28 Sep 2015 21:44:13 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:13 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:32 -0700
Message-Id: <f8bd18184a84e6de1976ecb4d0d929c55bc19a66.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 22/22] toaster: orm remove the complicated querying on the ORM
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:13 -0000

From: Michael Wood <michael.g.wood@intel.com>

We no longer need to compute each layer_version and all the recipes
which belong to this.

[YOCTO #8147]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py            | 49 ++++++++++++++++++++++--------------
 lib/toaster/toastergui/typeaheads.py |  5 ++--
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 9a052bf..5aed158 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -191,6 +191,7 @@ class Project(models.Model):
 
     # returns a queryset of compatible layers for a project
     def compatible_layerversions(self, release = None, layer_name = None):
+        logger.warning("This function is deprecated")
         if release == None:
             release = self.release
         # layers on the same branch or layers specifically set for this project
@@ -205,45 +206,55 @@ class Project(models.Model):
 
         return queryset
 
-    def projectlayer_equivalent_set(self):
-        return self.compatible_layerversions().filter(layer__name__in = [x.layercommit.layer.name for x in self.projectlayer_set.all()]).select_related("up_branch")
+    def get_all_compatible_layer_versions(self):
+        """ Returns Queryset of all Layer_Versions which are compatible with
+        this project"""
+        queryset = Layer_Version.objects.filter(
+            (Q(up_branch__name=self.release.branch_name) & Q(build=None))
+            | Q(project=self))
+
+        return queryset
+
+    def get_project_layer_versions(self, pk=False):
+        """ Returns the Layer_Versions currently added to this project """
+        layer_versions = self.projectlayer_set.all().values('layercommit')
+
+        if pk is False:
+            return layer_versions
+        else:
+            return layer_versions.values_list('pk', flat=True)
+
 
     def get_available_machines(self):
         """ Returns QuerySet of all Machines which are provided by the
         Layers currently added to the Project """
-        queryset = Machine.objects.filter(layer_version__in=self.projectlayer_equivalent_set)
+        queryset = Machine.objects.filter(
+            layer_version__in=self.get_project_layer_versions(self))
+
         return queryset
 
     def get_all_compatible_machines(self):
         """ Returns QuerySet of all the compatible machines available to the
         project including ones from Layers not currently added """
-        compatible_layers = self.compatible_layerversions()
+        queryset = Machine.objects.filter(
+            layer_version__in=self.get_all_compatible_layer_versions())
 
-        queryset = Machine.objects.filter(layer_version__in=compatible_layers)
         return queryset
 
     def get_available_recipes(self):
-        """ Returns QuerySet of all Recipes which are provided by the Layers
-        currently added to the Project """
-        project_layers = self.projectlayer_equivalent_set()
-        queryset = Recipe.objects.filter(layer_version__in = project_layers)
-
-        # Copied from get_all_compatible_recipes
-        search_maxids = map(lambda i: i[0], list(queryset.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')))
-        queryset = queryset.filter(id__in=search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch', 'layer_source')
-        # End copy
+        """ Returns QuerySet of all the recipes that are provided by layers
+        added to this project """
+        queryset = Recipe.objects.filter(
+            layer_version__in=self.get_project_layer_versions())
 
         return queryset
 
     def get_all_compatible_recipes(self):
         """ Returns QuerySet of all the compatible Recipes available to the
         project including ones from Layers not currently added """
-        compatible_layerversions = self.compatible_layerversions()
-        queryset = Recipe.objects.filter(layer_version__in = compatible_layerversions)
-
-        search_maxids = map(lambda i: i[0], list(queryset.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')))
+        queryset = Recipe.objects.filter(
+            layer_version__in=self.get_all_compatible_layer_versions())
 
-        queryset = queryset.filter(id__in=search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch', 'layer_source')
         return queryset
 
 
diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index d5bec58..9db3182 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -27,7 +27,7 @@ class LayersTypeAhead(ToasterTypeAhead):
       super(LayersTypeAhead, self).__init__()
 
     def apply_search(self, search_term, prj, request):
-        layers = prj.compatible_layerversions()
+        layers = prj.get_all_compatible_layer_versions()
         layers = layers.order_by('layer__name')
 
         # Unlike the other typeaheads we also don't want to show suggestions
@@ -35,7 +35,8 @@ class LayersTypeAhead(ToasterTypeAhead):
         # layerdeps to a new layer.
         if ("include_added" in request.GET and
                 request.GET['include_added'] != "true"):
-            layers = layers.exclude(pk__in=prj.projectlayer_equivalent_set)
+            layers = layers.exclude(
+                pk__in=prj.get_project_layer_versions(pk=True))
 
         primary_results = layers.filter(layer__name__istartswith=search_term)
         secondary_results = layers.filter(layer__name__icontains=search_term).exclude(pk__in=primary_results)
-- 
1.9.1


