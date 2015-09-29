Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 4E2C877054
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:04 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so194495019pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=xcWJI7IG/RITBex1EhlOWf+rEta/QyjwcOlNKVdlLXg=;
	b=TFStNKvJZveRnYZtj7NDUXMtqVMP2HDa2DrkHP1CA55TQlj1YWMI8kk1YklBgmh2Zi
	skQinCzt5Wls/QlSisFwcoOM0nmGx+m2g8aTZ5d7p32JVwZYrM81oVC1YnCQCKOLPo/X
	vyMfzaTY3fhweyZSfvc3S23LU5LKd4VrFpWNUdnTejLSfDUugdIsRLsCmi8rbCfGU71m
	3M8xdUBV48wNS0ckqpCsQC2a/xZCG2cPZ04eMjYHt+uyKNgzABvWX8Kv9TgMP4ETwLJb
	eopFWmBaCNpVlOtD1xc3LtyHYAnRYRqL/gQ6KfebNFdNlZX5iB4TzNhY1bnP2z1ucBsm
	7QmQ==
X-Received: by 10.68.185.132 with SMTP id fc4mr30322693pbc.96.1443501845097;
	Mon, 28 Sep 2015 21:44:05 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:04 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:22 -0700
Message-Id: <465f651211102c78916d7c138597493244876f77.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 12/22] toaster: Add new ReST API for Image Customisation feature
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:05 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Implemented xhr_customrecipe API. To create a custom recipe from a
base recipe.
Implemented xhr_customrecipe_packages API to add/remove packages
to/from custom recipe.

co-authored see Signed-off-by

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/urls.py  |  10 ++-
 lib/toaster/toastergui/views.py | 152 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 55f325d..b47a161 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -152,6 +152,14 @@ urlpatterns = patterns('toastergui.views',
         # JS Unit tests
         url(r'^js-unit-tests/$', 'jsunittests', name='js-unit-tests'),
 
-        # default redirection
+        # image customisation functionality
+        url(r'^xhr_customrecipe/(?P<recipe_id>\d+)/packages/(?P<package_id>\d+|)$',
+            'xhr_customrecipe_packages', name='xhr_customrecipe_packages'),
+        url(r'^xhr_customrecipe/(?P<recipe_id>\d+)$', 'xhr_customrecipe_id',
+            name='xhr_customrecipe_id'),
+        url(r'^xhr_customrecipe/', 'xhr_customrecipe',
+            name='xhr_customrecipe'),
+
+          # default redirection
         url(r'^$', RedirectView.as_view( url= 'landing')),
 )
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 5ea6122..392e56d 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -26,12 +26,12 @@
 import operator,re
 
 from django.db.models import F, Q, Sum, Count, Max
-from django.db import IntegrityError
+from django.db import IntegrityError, Error
 from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
 from orm.models import Target_Installed_Package, Target_File, Target_Image_File, BuildArtifact
-from orm.models import BitbakeVersion
+from orm.models import BitbakeVersion, CustomImageRecipe
 from bldcontrol import bbcontroller
 from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse, resolve
@@ -2596,7 +2596,155 @@ if True:
 
         return HttpResponse(jsonfilter({"error": "ok",}), content_type = "application/json")
 
+    @xhr_response
+    def xhr_customrecipe(request):
+        """
+        Custom image recipe REST API
+
+        Entry point: /xhr_customrecipe/
+        Method: POST
+
+        Args:
+            name: name of custom recipe to create
+            project: target project id of orm.models.Project
+            base: base recipe id of orm.models.Recipe
+
+        Returns:
+            {"error": "ok",
+             "url": <url of the created recipe>}
+            or
+            {"error": <error message>}
+        """
+        # check if request has all required parameters
+        for param in ('name', 'project', 'base'):
+            if param not in request.POST:
+                return {"error": "Missing parameter '%s'" % param}
+
+        # get project and baserecipe objects
+        params = {}
+        for name, model in [("project", Project),
+                            ("base", Recipe)]:
+            value = request.POST[name]
+            try:
+                params[name] = model.objects.get(id=value)
+            except model.DoesNotExist:
+                return {"error": "Invalid %s id %s" % (name, value)}
+
+        # create custom recipe
+        try:
+            recipe = CustomImageRecipe.objects.create(
+                         name=request.POST["name"],
+                         base_recipe=params["base"],
+                         project=params["project"])
+        except Error as err:
+            return {"error": "Can't create custom recipe: %s" % err}
+
+        # Find the package list from the last build of this recipe/target
+        build = Build.objects.filter(target__target=params['base'].name,
+                    project=params['project']).last()
+
+        if build:
+            # Copy in every package
+            # We don't want these packages to be linked to anything because
+            # that underlying data may change e.g. delete a build
+            for package in build.package_set.all():
+                # Create the duplicate
+                package.pk = None
+                package.save()
+                # Disassociate the package from the build
+                package.build = None
+                package.save()
+                recipe.packages.add(package)
+        else:
+            logger.warn("No packages found for this base recipe")
+
+        return {"error": "ok",
+                "url": reverse('customrecipe', args=(params['project'].pk,
+                                                     recipe.id))}
+
+    @xhr_response
+    def xhr_customrecipe_id(request, recipe_id):
+        """
+        Set of ReST API processors working with recipe id.
+
+        Entry point: /xhr_customrecipe/<recipe_id>
+
+        Methods:
+            GET - Get details of custom image recipe
+            DELETE - Delete custom image recipe
+
+        Returns:
+            GET:
+            {"error": "ok",
+             "info": dictionary of field name -> value pairs
+                     of the CustomImageRecipe model}
+            DELETE:
+            {"error": "ok"}
+            or
+            {"error": <error message>}
+        """
+        objects = CustomImageRecipe.objects.filter(id=recipe_id)
+        if not objects:
+            return {"error": "Custom recipe with id=%s "
+                             "not found" % recipe_id}
+        if request.method == 'GET':
+            values = CustomImageRecipe.objects.filter(id=recipe_id).values()
+            if values:
+                return {"error": "ok", "info": values[0]}
+            else:
+                return {"error": "Custom recipe with id=%s "
+                                 "not found" % recipe_id}
+            return {"error": "ok", "info": objects.values()[0]}
+        elif request.method == 'DELETE':
+            objects.delete()
+            return {"error": "ok"}
+        else:
+            return {"error": "Method %s is not supported" % request.method}
+
+    @xhr_response
+    def xhr_customrecipe_packages(request, recipe_id, package_id):
+        """
+        ReST API to add/remove packages to/from custom recipe.
 
+        Entry point: /xhr_customrecipe/<recipe_id>/packages/
+
+        Methods:
+            PUT - Add package to the recipe
+            DELETE - Delete package from the recipe
+
+        Returns:
+            {"error": "ok"}
+            or
+            {"error": <error message>}
+        """
+        try:
+            recipe = CustomImageRecipe.objects.get(id=recipe_id)
+        except CustomImageRecipe.DoesNotExist:
+            return {"error": "Custom recipe with id=%s "
+                             "not found" % recipe_id}
+
+        if request.method == 'GET' and not package_id:
+            return {"error": "ok",
+                    "packages": list(recipe.packages.values_list('id'))}
+
+        try:
+            package = Package.objects.get(id=package_id)
+        except Package.DoesNotExist:
+            return {"error": "Package with id=%s "
+                             "not found" % package_id}
+
+        if request.method == 'PUT':
+            recipe.packages.add(package)
+            return {"error": "ok"}
+        elif request.method == 'DELETE':
+            if package in recipe.packages.all():
+                recipe.packages.remove(package)
+                return {"error": "ok"}
+            else:
+                return {"error": "Package '%s' is not in the recipe '%s'" % \
+                                 (package.name, recipe.name)}
+        else:
+            return {"error": "Method %s is not supported" % request.method}
 
     def importlayer(request, pid):
         template = "importlayer.html"
-- 
1.9.1


