Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
	[209.85.220.51])
	by mail.openembedded.org (Postfix) with ESMTP id 8982577077
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:11 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so194497918pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=d+7UWekmY4xLadHy8zvHHTSJgTH6yMsVzsGTMwvK5bM=;
	b=tbM1QLl06daXmzzP5AYgCQ+7yCvmMXmSPzZoVBi0jPZZf6PZQBGj3zFvIol8G3cNfJ
	/4f0W7PTAJQ+KB5qcRvsJ+d9Ab/hnt3rkSnjziW5Qtz5+ZaQFFiNptk9yLGXot3CJTf2
	nTn6vgi3utPEm3GHIrKqngQWROHa6IYjDtZBgIutY5HvXDwWwFV7eUHEp9XsP3qon0VY
	mmkl998jvOlvEffHOZzOaCw2AnOmZB0JmAXLv0RizLmcVClh5Q0XzpNxuLcMVmQU0OYz
	SDGBeOQ2kDv7+q2FUDDcDQhxWaaUucxiYbHrjFm8v4EijHwG+KGNK8Cza+9R7lNw650N
	rgMg==
X-Received: by 10.66.193.230 with SMTP id hr6mr30795539pac.39.1443501851935;
	Mon, 28 Sep 2015 21:44:11 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:11 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:30 -0700
Message-Id: <d8044d7477ac1279f22c911a20790544607d4cb8.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 20/22] toaster: buildinfohelper Create a copy of the built layer and recipe
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

Create a copy of the built layer and the recipes associated with it.
This is so that the user can view the historical information about a
build. i.e. a snapshot of the layer version and artifacts produced at
that build.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 54 +++++++++++++++++++++++++++++++++-----------
 lib/toaster/orm/models.py    |  2 +-
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index d0efaa9..e036ef6 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -66,6 +66,7 @@ class ORMWrapper(object):
 
     def __init__(self):
         self.layer_version_objects = []
+        self.layer_version_built = []
         self.task_objects = {}
         self.recipe_objects = {}
 
@@ -254,32 +255,59 @@ class ORMWrapper(object):
 
         assert not recipe_information['file_path'].startswith("/")      # we should have layer-relative paths at all times
 
-        recipe_object, created = self._cached_get_or_create(Recipe, layer_version=recipe_information['layer_version'],
+
+        def update_recipe_obj(recipe_object):
+            object_changed = False
+            for v in vars(recipe_object):
+                if v in recipe_information.keys():
+                    object_changed = True
+                    vars(recipe_object)[v] = recipe_information[v]
+
+            if object_changed:
+                recipe_object.save()
+
+        recipe, created = self._cached_get_or_create(Recipe, layer_version=recipe_information['layer_version'],
                                      file_path=recipe_information['file_path'], pathflags = recipe_information['pathflags'])
-        if created and must_exist:
-            raise NotExisting("Recipe object created when expected to exist", recipe_information)
 
-        object_changed = False
-        for v in vars(recipe_object):
-            if v in recipe_information.keys():
-                object_changed = True
-                vars(recipe_object)[v] = recipe_information[v]
+        update_recipe_obj(recipe)
 
-        if object_changed:
-            recipe_object.save()
+        # Create a copy of the recipe for historical puposes and update it
+        for built_layer in self.layer_version_built:
+            if built_layer.layer == recipe_information['layer_version'].layer:
+                built_recipe, c = self._cached_get_or_create(Recipe,
+                        layer_version=built_layer,
+                        file_path=recipe_information['file_path'],
+                        pathflags = recipe_information['pathflags'])
+                update_recipe_obj(built_recipe)
+                break
 
-        return recipe_object
+
+
+        if created and must_exist:
+            raise NotExisting("Recipe object created when expected to exist", recipe_information)
+
+        return recipe
 
     def get_update_layer_version_object(self, build_obj, layer_obj, layer_version_information):
         if isinstance(layer_obj, Layer_Version):
             # We already found our layer version for this build so just
             # update it with the new build information
             logger.debug("We found our layer from toaster")
-            layer_obj.build = build_obj
             layer_obj.local_path = layer_version_information['local_path']
-            layer_obj.commit = layer_version_information['commit']
             layer_obj.save()
             self.layer_version_objects.append(layer_obj)
+
+            # create a new copy of this layer version as a snapshot for
+            # historical purposes
+            layer_copy, c = Layer_Version.objects.get_or_create(build=build_obj,
+                            layer=layer_obj.layer,
+                            commit=layer_version_information['commit'],
+                            local_path = layer_version_information['local_path'],
+                            )
+            logger.warning("created new historical layer version %d", layer_copy.pk)
+
+            self.layer_version_built.append(layer_copy)
+
             return layer_obj
 
         assert isinstance(build_obj, Build)
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index e0b31a9..9a052bf 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -194,7 +194,7 @@ class Project(models.Model):
         if release == None:
             release = self.release
         # layers on the same branch or layers specifically set for this project
-        queryset = Layer_Version.objects.filter((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = self) | Q(build__project = self))
+        queryset = Layer_Version.objects.filter(((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = self)) & Q(build__isnull=True))
 
         if layer_name is not None:
             # we select only a layer name
-- 
1.9.1


