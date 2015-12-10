Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id A1B7A6FFDD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:08 +0000 (UTC)
Received: by pacwq6 with SMTP id wq6so40245970pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=odEfrQt7lqy8/SJVkENRRYsK5JJW3hJRfWomUQcemjo=;
	b=uD4CCMP0tbuJDjR+JO4Kg35hXleHJjIWHvv7Fgc+Ho4M0GF1IA57n3zDxa4pzKAzRr
	G5oJnlm1pJYEz6+sEEw21exrjllG44Ohu29Y+vjvc2KF0cM7KbFzCG9+73oCAx/0wwlA
	BCpmSY1OSUrApXMVU1qYPqoyuU4EffaPs6C0BhoOUH7UP/NA05yKXbMcb6gbXqZOFQeM
	0xRa1LqAaVZGrMKAAkpXEsj8UYQMgMJ0jN9AKf18j7Xje7nIxhf1dYAUP5pxVY91QORi
	Z+F+ZoNAikICRkQWUFavuKj5tbqLyj7rU7f4uRL0w/rPEpR8P8R2tMYdBAuj5Wgk5Nut
	qjiw==
X-Received: by 10.66.149.229 with SMTP id ud5mr13030059pab.83.1449719589305;
	Wed, 09 Dec 2015 19:53:09 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:08 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:36 -0800
Message-Id: <f59a2df9376318a5a748a9fd95da1175f272cd2b.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 11/18] toaster: Remove compatible_layerversions() method
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:08 -0000

From: Elliot Smith <elliot.smith@intel.com>

Remove compatible_layerversions() and replace calls to it with
calls to get_all_compatible_layer_versions().

The sorting done in compatible_layerversions() is not relevant,
and the code can be simplified by using get_all_compatible_layer_versions().

[YOCTO #8364]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py       | 21 +++------------------
 lib/toaster/toastergui/views.py | 22 ++++++++++++++--------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index b25910a..f07feda 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -195,23 +195,6 @@ class Project(models.Model):
         except (Variable.DoesNotExist,IndexError):
             return( "not_found" )
 
-    # returns a queryset of compatible layers for a project
-    def compatible_layerversions(self, release = None, layer_name = None):
-        logger.warning("This function is deprecated")
-        if release == None:
-            release = self.release
-        # layers on the same branch or layers specifically set for this project
-        queryset = Layer_Version.objects.filter(((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = self)) & Q(build__isnull=True))
-
-        if layer_name is not None:
-            # we select only a layer name
-            queryset = queryset.filter(layer__name = layer_name)
-
-        # order by layer version priority
-        queryset = queryset.filter(Q(layer_source=None) | Q(layer_source__releaselayersourcepriority__release = release)).select_related('layer_source', 'layer', 'up_branch', "layer_source__releaselayersourcepriority__priority").order_by("-layer_source__releaselayersourcepriority__priority")
-
-        return queryset
-
     def get_all_compatible_layer_versions(self):
         """ Returns Queryset of all Layer_Versions which are compatible with
         this project"""
@@ -1184,7 +1167,9 @@ class Layer_Version(models.Model):
         return self._handle_url_path(self.layer.vcs_web_tree_base_url, '')
 
     def get_equivalents_wpriority(self, project):
-        return project.compatible_layerversions(layer_name = self.layer.name)
+        layer_versions = project.get_all_compatible_layer_versions()
+        filtered = layer_versions.filter(layer__name = self.layer.name)
+        return filtered.order_by("-layer_source__releaselayersourcepriority__priority")
 
     def get_vcs_reference(self):
         if self.branch is not None and len(self.branch) > 0:
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 16f27b8..bd334b9 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2264,16 +2264,17 @@ if True:
                 prj.bitbake_version = prj.release.bitbake_version
                 prj.save()
                 # we need to change the layers
-                for i in prj.projectlayer_set.all():
+                for project in prj.projectlayer_set.all():
                     # find and add a similarly-named layer on the new branch
                     try:
-                        lv = prj.compatible_layerversions(layer_name = i.layercommit.layer.name)[0]
-                        ProjectLayer.objects.get_or_create(project = prj, layercommit = lv)
+                        layer_versions = prj.get_all_compatible_layer_versions()
+                        layer_versions = layer_versions.filter(layer__name = project.layercommit.layer.name)
+                        ProjectLayer.objects.get_or_create(project = prj, layercommit = layer_versions.first())
                     except IndexError:
                         pass
                     finally:
                         # get rid of the old entry
-                        i.delete()
+                        project.delete()
 
             if 'machineName' in request.POST:
                 machinevar = prj.projectvariable_set.get(name="MACHINE")
@@ -2383,12 +2384,17 @@ if True:
 
             retval = []
 
-            for i in prj.projectlayer_set.all():
-                lv = prj.compatible_layerversions(release = Release.objects.get(pk=new_release_id)).filter(layer__name = i.layercommit.layer.name)
+            for project in prj.projectlayer_set.all():
+                release = Release.objects.get(pk = new_release_id)
+
+                layer_versions = prj.get_all_compatible_layer_versions()
+                layer_versions = layer_versions.filter(release = release)
+                layer_versions = layer_versions.filter(layer__name = project.layercommit.layer.name)
+
                 # there is no layer_version with the new release id,
                 # and the same name
-                if lv.count() < 1:
-                    retval.append(i)
+                if layer_versions.count() < 1:
+                    retval.append(project)
 
             return response({"error":"ok",
                              "rows" : map( _lv_to_dict(prj),
-- 
1.9.1


