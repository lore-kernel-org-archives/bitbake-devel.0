Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id B67A575692
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:14:51 +0000 (UTC)
Received: by wgez8 with SMTP id z8so37745577wge.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ZqucW1+iADLFDGvSp/u4WzuYoMBMWV7Gkqk+XrbxmpA=;
	b=T+sC/LyBYCo+YWt8EgajG6zO4s2gungh8fK1UhK7rP22cpeb5gLSPy7/c1vPCT8vYR
	x9ecWMBD9zYEDBCPPX4jOPNS5rbzUtWnkWqF57pCIRd5JbOkH6ky+U0UUgY5S4XyI1/W
	RQZHmUX3y8++2XW+X0frUMqFGLX4dto1CwaVpkzexnfsDJQ/7XOEjwdZHIrvGXF90DIk
	0ivoNZfPqKTkKSQj+upzDxERuyplComrFQlXcT+RlpsW2SXhFJH+qm0NAAmOWjPVwR4o
	FAy5/H7YWE7ZQR61zboQZRx5e8vB9ME64ZSBfHLzkr39R0eHyvWBz0nY8TzpPMKpOVRT
	t0fA==
X-Gm-Message-State: ALoCoQkqyPa04FvyqIwmoBVaxNiQxZZ+8PQt9EDPAf8TYILjhRP6qYLAAjDcdHpoOLCAILryXk0k
X-Received: by 10.180.73.236 with SMTP id o12mr61853067wiv.56.1432822492359;
	Thu, 28 May 2015 07:14:52 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id o6sm8742786wiz.24.2015.05.28.07.14.50
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:14:51 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B7F1656120B; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:13:57 +0100
Message-Id: <f1d8ef8cdeefeaab68b799f06e04b5e30ebcd1bc.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 03/22] toaster logger: refactor recipe and layer file paths
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
X-List-Received-Date: Thu, 28 May 2015 14:14:54 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This refactoring brings the "local_path" of the
layer from the Layer object to the Layer_Version object, which
is more appropriate as different checkouts of the same
Layer may live in different directories.

This enables us to store Recipe file paths relative to a Layer_Version
at all times, aleviating the need to store full file paths in the
database. We also turn the prefix of the path (e.g. virtual:native
path name space) into a pathflag field.

In turn, this solves the problem of mis-identification of tasks based
on the recipe file paths, since we can also match the namespace of the
file paths on the recipe files.

[YOCTO #7594]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       |  47 ++-
 .../tts/toasteruitest/toaster_automation_test.py   |  14 +-
 ...ion_local_path__add_field_recipe_pathflags__.py | 361 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  23 +-
 lib/toaster/toastergui/templates/bpackage.html     |   4 +-
 .../toastergui/templates/configuration.html        |   2 +-
 .../toastergui/templates/package_detail_base.html  |   2 +-
 lib/toaster/toastergui/templates/recipe.html       |   4 +-
 lib/toaster/toastergui/templates/recipes.html      |   4 +-
 lib/toaster/toastergui/templates/target.html       |   2 +-
 lib/toaster/toastergui/views.py                    |  22 +-
 11 files changed, 427 insertions(+), 58 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0020_auto__add_field_layer_version_local_path__add_field_recipe_pathflags__.py

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 647d663..6812a52 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -221,12 +221,12 @@ class ORMWrapper(object):
     def get_update_recipe_object(self, recipe_information, must_exist = False):
         assert 'layer_version' in recipe_information
         assert 'file_path' in recipe_information
+        assert 'pathflags' in recipe_information
 
-        if recipe_information['file_path'].startswith(recipe_information['layer_version'].layer.local_path):
-            recipe_information['file_path'] = recipe_information['file_path'][len(recipe_information['layer_version'].layer.local_path):].lstrip("/")
+        assert not recipe_information['file_path'].startswith("/")      # we should have layer-relative paths at all times
 
         recipe_object, created = self._cached_get_or_create(Recipe, layer_version=recipe_information['layer_version'],
-                                     file_path=recipe_information['file_path'])
+                                     file_path=recipe_information['file_path'], pathflags = recipe_information['pathflags'])
         if created and must_exist:
             raise NotExisting("Recipe object created when expected to exist", recipe_information)
 
@@ -247,13 +247,15 @@ class ORMWrapper(object):
         assert 'branch' in layer_version_information
         assert 'commit' in layer_version_information
         assert 'priority' in layer_version_information
+        assert 'local_path' in layer_version_information
 
         layer_version_object, created = Layer_Version.objects.get_or_create(
                                     build = build_obj,
                                     layer = layer_obj,
                                     branch = layer_version_information['branch'],
                                     commit = layer_version_information['commit'],
-                                    priority = layer_version_information['priority']
+                                    priority = layer_version_information['priority'],
+                                    local_path = layer_version_information['local_path'],
                                     )
 
         self.layer_version_objects.append(layer_version_object)
@@ -262,13 +264,11 @@ class ORMWrapper(object):
 
     def get_update_layer_object(self, layer_information, brbe):
         assert 'name' in layer_information
-        assert 'local_path' in layer_information
         assert 'layer_index_url' in layer_information
 
         if brbe is None:
             layer_object, created = Layer.objects.get_or_create(
                                 name=layer_information['name'],
-                                local_path=layer_information['local_path'],
                                 layer_index_url=layer_information['layer_index_url'])
             return layer_object
         else:
@@ -297,7 +297,6 @@ class ORMWrapper(object):
                     for pl in buildrequest.project.projectlayer_set.filter(layercommit__layer__name = brl.name):
                         if pl.layercommit.layer.vcs_url == brl.giturl :
                             layer = pl.layercommit.layer
-                            layer.local_path = layer_information['local_path']
                             layer.save()
                             return layer
 
@@ -687,12 +686,12 @@ class BuildInfoHelper(object):
         if self.brbe is None:
             def _slkey_interactive(layer_version):
                 assert isinstance(layer_version, Layer_Version)
-                return len(layer_version.layer.local_path)
+                return len(layer_version.local_path)
 
             # Heuristics: we always match recipe to the deepest layer path in the discovered layers
             for lvo in sorted(self.orm_wrapper.layer_version_objects, reverse=True, key=_slkey_interactive):
                 # we can match to the recipe file path
-                if path.startswith(lvo.layer.local_path):
+                if path.startswith(lvo.local_path):
                     return lvo
 
         else:
@@ -721,7 +720,7 @@ class BuildInfoHelper(object):
         logger.warn("Could not match layer version for recipe path %s : %s" % (path, self.orm_wrapper.layer_version_objects))
 
         #mockup the new layer
-        unknown_layer, created = Layer.objects.get_or_create(name="__FIXME__unidentified_layer", local_path="/", layer_index_url="")
+        unknown_layer, created = Layer.objects.get_or_create(name="__FIXME__unidentified_layer", layer_index_url="")
         unknown_layer_version_obj, created = Layer_Version.objects.get_or_create(layer = unknown_layer, build = self.internal_state['build'])
 
         # append it so we don't run into this error again and again
@@ -731,11 +730,20 @@ class BuildInfoHelper(object):
 
     def _get_recipe_information_from_taskfile(self, taskfile):
         localfilepath = taskfile.split(":")[-1]
+        filepath_flags = ":".join(sorted(taskfile.split(":")[:-1]))
         layer_version_obj = self._get_layer_version_for_path(localfilepath)
 
+
+
         recipe_info = {}
         recipe_info['layer_version'] = layer_version_obj
-        recipe_info['file_path'] = taskfile
+        recipe_info['file_path'] = localfilepath
+        recipe_info['pathflags'] = filepath_flags
+
+        if recipe_info['file_path'].startswith(recipe_info['layer_version'].local_path):
+            recipe_info['file_path'] = recipe_info['file_path'][len(recipe_info['layer_version'].local_path):].lstrip("/")
+        else:
+            raise RuntimeError("Recipe file path %s is not under layer version at %s" % (recipe_info['file_path'], recipe_info['layer_version'].local_path))
 
         return recipe_info
 
@@ -787,6 +795,7 @@ class BuildInfoHelper(object):
         for layer in layerinfos:
             try:
                 self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)] = layerinfos[layer]['version']
+                self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)]['local_path'] = layerinfos[layer]['local_path']
             except NotExisting as nee:
                 logger.warn("buildinfohelper: cannot identify layer exception:%s " % nee)
 
@@ -899,8 +908,8 @@ class BuildInfoHelper(object):
 
             recipe_information = self._get_recipe_information_from_taskfile(taskfile)
             try:
-                if recipe_information['file_path'].startswith(recipe_information['layer_version'].layer.local_path):
-                    recipe_information['file_path'] = recipe_information['file_path'][len(recipe_information['layer_version'].layer.local_path):].lstrip("/")
+                if recipe_information['file_path'].startswith(recipe_information['layer_version'].local_path):
+                    recipe_information['file_path'] = recipe_information['file_path'][len(recipe_information['layer_version'].local_path):].lstrip("/")
 
                 recipe_object = Recipe.objects.get(layer_version = recipe_information['layer_version'],
                             file_path__endswith = recipe_information['file_path'],
@@ -1051,8 +1060,9 @@ class BuildInfoHelper(object):
         self.internal_state['recipes'] = {}
         for pn in event._depgraph['pn']:
 
-            file_name = event._depgraph['pn'][pn]['filename']
-            layer_version_obj = self._get_layer_version_for_path(file_name.split(":")[-1])
+            file_name = event._depgraph['pn'][pn]['filename'].split(":")[-1]
+            pathflags = ":".join(sorted(event._depgraph['pn'][pn]['filename'].split(":")[:-1]))
+            layer_version_obj = self._get_layer_version_for_path(file_name)
 
             assert layer_version_obj is not None
 
@@ -1082,6 +1092,13 @@ class BuildInfoHelper(object):
                 recipe_info['bugtracker'] = event._depgraph['pn'][pn]['bugtracker']
 
             recipe_info['file_path'] = file_name
+            recipe_info['pathflags'] = pathflags
+
+            if recipe_info['file_path'].startswith(recipe_info['layer_version'].local_path):
+                recipe_info['file_path'] = recipe_info['file_path'][len(recipe_info['layer_version'].local_path):].lstrip("/")
+            else:
+                raise RuntimeError("Recipe file path %s is not under layer version at %s" % (recipe_info['file_path'], recipe_info['layer_version'].local_path))
+
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_info)
             recipe.is_image = False
             if 'inherits' in event._depgraph['pn'][pn].keys():
diff --git a/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py b/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
index c03a937..0cb3934 100755
--- a/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
+++ b/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
@@ -926,7 +926,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("depends_on").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
-        self.driver.find_element_by_id("layer_version__layer__local_path").click()
+        self.driver.find_element_by_id("layer_version__local_path").click()
         self.driver.find_element_by_id("depends_by").click()
         self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
 
@@ -945,7 +945,7 @@ class toaster_cases(toaster_cases_base):
 
         table_head_dict = {'Recipe file':'recipe_file', 'Section':'recipe_section', \
                 'License':'recipe_license', 'Layer':'layer_version__layer__name', \
-                'Layer branch':'layer_version__branch', 'Layer directory':'layer_version__layer__local_path'}
+                'Layer branch':'layer_version__branch', 'Layer directory':'layer_version__local_path'}
         for key in table_head_dict:
             self.find_element_by_link_text_in_table(self.table_name, key).click()
             column_list = self.get_table_column_text("class", table_head_dict[key])
@@ -1066,7 +1066,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("depends_on").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
-        self.driver.find_element_by_id("layer_version__layer__local_path").click()
+        self.driver.find_element_by_id("layer_version__local_path").click()
         self.driver.find_element_by_id("depends_by").click()
         self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
         # check if columns selected above is shown
@@ -1081,7 +1081,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("depends_on").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
-        self.driver.find_element_by_id("layer_version__layer__local_path").click()
+        self.driver.find_element_by_id("layer_version__local_path").click()
         self.driver.find_element_by_id("depends_by").click()
         self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
         # don't exist any more
@@ -1425,7 +1425,7 @@ class toaster_cases(toaster_cases_base):
 # Step 4
         # pulldown menu
         option_ids = ['recipe__layer_version__layer__name', 'recipe__layer_version__branch', \
-                      'recipe__layer_version__layer__commit', 'recipe__layer_version__layer__local_path', \
+                      'recipe__layer_version__layer__commit', 'recipe__layer_version__local_path', \
                       'license', 'recipe__version']
         self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
         for item in option_ids:
@@ -1470,7 +1470,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
-        self.driver.find_element_by_id("layer_version__layer__local_path").click()
+        self.driver.find_element_by_id("layer_version__local_path").click()
         self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
         # otable is the recipes table here
         otable_head_text = self.get_table_head_text('otable')
@@ -1488,7 +1488,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("recipe__layer_version__layer__name").click()
         self.driver.find_element_by_id("recipe__layer_version__branch").click()
         self.driver.find_element_by_id("recipe__layer_version__layer__commit").click()
-        self.driver.find_element_by_id("recipe__layer_version__layer__local_path").click()
+        self.driver.find_element_by_id("recipe__layer_version__local_path").click()
         self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
         otable_head_text = self.get_table_head_text("otable")
         for item in ["Layer", "Layer branch", "Layer commit", "Layer directory"]:
diff --git a/lib/toaster/orm/migrations/0020_auto__add_field_layer_version_local_path__add_field_recipe_pathflags__.py b/lib/toaster/orm/migrations/0020_auto__add_field_layer_version_local_path__add_field_recipe_pathflags__.py
new file mode 100644
index 0000000..0ec5795
--- /dev/null
+++ b/lib/toaster/orm/migrations/0020_auto__add_field_layer_version_local_path__add_field_recipe_pathflags__.py
@@ -0,0 +1,361 @@
+# -*- coding: utf-8 -*-
+from south.utils import datetime_utils as datetime
+from south.db import db
+from south.v2 import SchemaMigration
+from django.db import models
+
+
+class Migration(SchemaMigration):
+
+    def forwards(self, orm):
+        # Removing unique constraint on 'Recipe', fields ['layer_version', 'file_path']
+        db.delete_unique(u'orm_recipe', ['layer_version_id', 'file_path'])
+
+        # Adding field 'Layer_Version.local_path'
+        db.add_column(u'orm_layer_version', 'local_path',
+                      self.gf('django.db.models.fields.FilePathField')(default="/", max_length=1024),
+                      keep_default=False)
+
+        # Adding field 'Recipe.pathflags'
+        db.add_column(u'orm_recipe', 'pathflags',
+                      self.gf('django.db.models.fields.CharField')(default='', max_length=200, blank=True),
+                      keep_default=False)
+
+        # Adding unique constraint on 'Recipe', fields ['layer_version', 'file_path', 'pathflags']
+        db.create_unique(u'orm_recipe', ['layer_version_id', 'file_path', 'pathflags'])
+
+        # Migrate data from Layer.local_path to Layer_Version.local_path
+        if not db.dry_run:
+            for lv in orm.Layer_Version.objects.all():
+                if lv.layer.local_path is not None:
+                    lv.local_path = lv.layer.local_path
+                else:
+                    lv.local_path = "/"
+                lv.save()
+
+        db.delete_column(u'orm_layer', 'local_path')
+
+
+    def backwards(self, orm):
+        raise RuntimeError("Cannot reverse this migration")
+
+
+    models = {
+        u'orm.bitbakeversion': {
+            'Meta': {'object_name': 'BitbakeVersion'},
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '32'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'giturl': ('django.db.models.fields.URLField', [], {'max_length': '200'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '32'})
+        },
+        u'orm.branch': {
+            'Meta': {'unique_together': "(('layer_source', 'name'), ('layer_source', 'up_id'))", 'object_name': 'Branch'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'True', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
+            'short_description': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'})
+        },
+        u'orm.build': {
+            'Meta': {'object_name': 'Build'},
+            'bitbake_version': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
+            'build_name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'completed_on': ('django.db.models.fields.DateTimeField', [], {}),
+            'cooker_log_path': ('django.db.models.fields.CharField', [], {'max_length': '500'}),
+            'distro': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'distro_version': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'errors_no': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'machine': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'outcome': ('django.db.models.fields.IntegerField', [], {'default': '2'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'started_on': ('django.db.models.fields.DateTimeField', [], {}),
+            'timespent': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'warnings_no': ('django.db.models.fields.IntegerField', [], {'default': '0'})
+        },
+        u'orm.buildartifact': {
+            'Meta': {'object_name': 'BuildArtifact'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']"}),
+            'file_name': ('django.db.models.fields.FilePathField', [], {'max_length': '100'}),
+            'file_size': ('django.db.models.fields.IntegerField', [], {}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
+        },
+        u'orm.helptext': {
+            'Meta': {'object_name': 'HelpText'},
+            'area': ('django.db.models.fields.IntegerField', [], {}),
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'helptext_build'", 'to': u"orm['orm.Build']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'key': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'text': ('django.db.models.fields.TextField', [], {})
+        },
+        u'orm.layer': {
+            'Meta': {'unique_together': "(('layer_source', 'up_id'), ('layer_source', 'name'))", 'object_name': 'Layer'},
+            'description': ('django.db.models.fields.TextField', [], {'default': 'None', 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_index_url': ('django.db.models.fields.URLField', [], {'max_length': '200'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'local_path': ('django.db.models.fields.FilePathField', [], {'default': 'None', 'max_length': '255', 'null': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'summary': ('django.db.models.fields.TextField', [], {'default': 'None', 'null': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'}),
+            'vcs_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'}),
+            'vcs_web_file_base_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'}),
+            'vcs_web_tree_base_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'}),
+            'vcs_web_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'})
+        },
+        u'orm.layer_version': {
+            'Meta': {'unique_together': "(('layer_source', 'up_id'),)", 'object_name': 'Layer_Version'},
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '80'}),
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'related_name': "'layer_version_build'", 'null': 'True', 'to': u"orm['orm.Build']"}),
+            'commit': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'default': 'None', 'max_length': '255', 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'layer_version_layer'", 'to': u"orm['orm.Layer']"}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'local_path': ('django.db.models.fields.FilePathField', [], {'default': 'None', 'max_length': '255', 'null': 'True'}),
+            'priority': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.Project']", 'null': 'True'}),
+            'up_branch': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.Branch']", 'null': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'})
+        },
+        u'orm.layersource': {
+            'Meta': {'unique_together': "(('sourcetype', 'apiurl'),)", 'object_name': 'LayerSource'},
+            'apiurl': ('django.db.models.fields.CharField', [], {'default': 'None', 'max_length': '255', 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '63'}),
+            'sourcetype': ('django.db.models.fields.IntegerField', [], {})
+        },
+        u'orm.layerversiondependency': {
+            'Meta': {'unique_together': "(('layer_source', 'up_id'),)", 'object_name': 'LayerVersionDependency'},
+            'depends_on': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'dependees'", 'to': u"orm['orm.Layer_Version']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'dependencies'", 'to': u"orm['orm.Layer_Version']"}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'})
+        },
+        u'orm.logmessage': {
+            'Meta': {'object_name': 'LogMessage'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'level': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'lineno': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'message': ('django.db.models.fields.CharField', [], {'max_length': '240'}),
+            'pathname': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'}),
+            'task': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Task']", 'null': 'True', 'blank': 'True'})
+        },
+        u'orm.machine': {
+            'Meta': {'unique_together': "(('layer_source', 'up_id'),)", 'object_name': 'Machine'},
+            'description': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Layer_Version']"}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'})
+        },
+        u'orm.package': {
+            'Meta': {'object_name': 'Package'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']"}),
+            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'installed_name': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '100'}),
+            'installed_size': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'license': ('django.db.models.fields.CharField', [], {'max_length': '80', 'blank': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'recipe': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Recipe']", 'null': 'True'}),
+            'revision': ('django.db.models.fields.CharField', [], {'max_length': '32', 'blank': 'True'}),
+            'section': ('django.db.models.fields.CharField', [], {'max_length': '80', 'blank': 'True'}),
+            'size': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'summary': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'version': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'})
+        },
+        u'orm.package_dependency': {
+            'Meta': {'object_name': 'Package_Dependency'},
+            'dep_type': ('django.db.models.fields.IntegerField', [], {}),
+            'depends_on': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'package_dependencies_target'", 'to': u"orm['orm.Package']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'package': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'package_dependencies_source'", 'to': u"orm['orm.Package']"}),
+            'target': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Target']", 'null': 'True'})
+        },
+        u'orm.package_file': {
+            'Meta': {'object_name': 'Package_File'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'package': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'buildfilelist_package'", 'to': u"orm['orm.Package']"}),
+            'path': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'}),
+            'size': ('django.db.models.fields.IntegerField', [], {})
+        },
+        u'orm.project': {
+            'Meta': {'object_name': 'Project'},
+            'bitbake_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.BitbakeVersion']", 'null': 'True'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'release': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Release']", 'null': 'True'}),
+            'short_description': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
+            'user_id': ('django.db.models.fields.IntegerField', [], {'null': 'True'})
+        },
+        u'orm.projectlayer': {
+            'Meta': {'unique_together': "(('project', 'layercommit'),)", 'object_name': 'ProjectLayer'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layercommit': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Layer_Version']", 'null': 'True'}),
+            'optional': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"})
+        },
+        u'orm.projecttarget': {
+            'Meta': {'object_name': 'ProjectTarget'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'target': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'task': ('django.db.models.fields.CharField', [], {'max_length': '100', 'null': 'True'})
+        },
+        u'orm.projectvariable': {
+            'Meta': {'object_name': 'ProjectVariable'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'value': ('django.db.models.fields.TextField', [], {'blank': 'True'})
+        },
+        u'orm.recipe': {
+            'Meta': {'unique_together': "(('layer_version', 'file_path', 'pathflags'), ('file_path', 'pathflags'))", 'object_name': 'Recipe'},
+            'bugtracker': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'file_path': ('django.db.models.fields.FilePathField', [], {'max_length': '255'}),
+            'homepage': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'recipe_layer_version'", 'to': u"orm['orm.Layer_Version']"}),
+            'license': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'pathflags': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
+            'section': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'summary': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'}),
+            'version': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'})
+        },
+        u'orm.recipe_dependency': {
+            'Meta': {'object_name': 'Recipe_Dependency'},
+            'dep_type': ('django.db.models.fields.IntegerField', [], {}),
+            'depends_on': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'r_dependencies_depends'", 'to': u"orm['orm.Recipe']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'recipe': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'r_dependencies_recipe'", 'to': u"orm['orm.Recipe']"})
+        },
+        u'orm.release': {
+            'Meta': {'object_name': 'Release'},
+            'bitbake_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.BitbakeVersion']"}),
+            'branch_name': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '50'}),
+            'description': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'helptext': ('django.db.models.fields.TextField', [], {'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '32'})
+        },
+        u'orm.releasedefaultlayer': {
+            'Meta': {'object_name': 'ReleaseDefaultLayer'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_name': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '100'}),
+            'release': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Release']"})
+        },
+        u'orm.releaselayersourcepriority': {
+            'Meta': {'unique_together': "(('release', 'layer_source'),)", 'object_name': 'ReleaseLayerSourcePriority'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.LayerSource']"}),
+            'priority': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'release': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Release']"})
+        },
+        u'orm.target': {
+            'Meta': {'object_name': 'Target'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'image_size': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'is_image': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
+            'license_manifest_path': ('django.db.models.fields.CharField', [], {'max_length': '500', 'null': 'True'}),
+            'target': ('django.db.models.fields.CharField', [], {'max_length': '100'})
+        },
+        u'orm.target_file': {
+            'Meta': {'object_name': 'Target_File'},
+            'directory': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'directory_set'", 'null': 'True', 'to': u"orm['orm.Target_File']"}),
+            'group': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'inodetype': ('django.db.models.fields.IntegerField', [], {}),
+            'owner': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
+            'path': ('django.db.models.fields.FilePathField', [], {'max_length': '100'}),
+            'permission': ('django.db.models.fields.CharField', [], {'max_length': '16'}),
+            'size': ('django.db.models.fields.IntegerField', [], {}),
+            'sym_target': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'symlink_set'", 'null': 'True', 'to': u"orm['orm.Target_File']"}),
+            'target': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Target']"})
+        },
+        u'orm.target_image_file': {
+            'Meta': {'object_name': 'Target_Image_File'},
+            'file_name': ('django.db.models.fields.FilePathField', [], {'max_length': '254'}),
+            'file_size': ('django.db.models.fields.IntegerField', [], {}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'target': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Target']"})
+        },
+        u'orm.target_installed_package': {
+            'Meta': {'object_name': 'Target_Installed_Package'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'package': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'buildtargetlist_package'", 'to': u"orm['orm.Package']"}),
+            'target': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Target']"})
+        },
+        u'orm.task': {
+            'Meta': {'ordering': "('order', 'recipe')", 'unique_together': "(('build', 'recipe', 'task_name'),)", 'object_name': 'Task'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'task_build'", 'to': u"orm['orm.Build']"}),
+            'cpu_usage': ('django.db.models.fields.DecimalField', [], {'null': 'True', 'max_digits': '8', 'decimal_places': '2'}),
+            'disk_io': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'elapsed_time': ('django.db.models.fields.DecimalField', [], {'null': 'True', 'max_digits': '8', 'decimal_places': '2'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'line_number': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'logfile': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'}),
+            'message': ('django.db.models.fields.CharField', [], {'max_length': '240'}),
+            'order': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'outcome': ('django.db.models.fields.IntegerField', [], {'default': '-1'}),
+            'path_to_sstate_obj': ('django.db.models.fields.FilePathField', [], {'max_length': '500', 'blank': 'True'}),
+            'recipe': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'tasks'", 'to': u"orm['orm.Recipe']"}),
+            'script_type': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'source_url': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'}),
+            'sstate_checksum': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'sstate_result': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'task_executed': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
+            'task_name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'work_directory': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'})
+        },
+        u'orm.task_dependency': {
+            'Meta': {'object_name': 'Task_Dependency'},
+            'depends_on': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'task_dependencies_depends'", 'to': u"orm['orm.Task']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'task': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'task_dependencies_task'", 'to': u"orm['orm.Task']"})
+        },
+        u'orm.toastersetting': {
+            'Meta': {'object_name': 'ToasterSetting'},
+            'helptext': ('django.db.models.fields.TextField', [], {}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '63'}),
+            'value': ('django.db.models.fields.CharField', [], {'max_length': '255'})
+        },
+        u'orm.variable': {
+            'Meta': {'object_name': 'Variable'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'variable_build'", 'to': u"orm['orm.Build']"}),
+            'changed': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
+            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'human_readable_name': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'variable_name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'variable_value': ('django.db.models.fields.TextField', [], {'blank': 'True'})
+        },
+        u'orm.variablehistory': {
+            'Meta': {'object_name': 'VariableHistory'},
+            'file_name': ('django.db.models.fields.FilePathField', [], {'max_length': '255'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'line_number': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'operation': ('django.db.models.fields.CharField', [], {'max_length': '64'}),
+            'value': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'variable': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'vhistory'", 'to': u"orm['orm.Variable']"})
+        }
+    }
+
+    complete_apps = ['orm']
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 20b02bb..29ede65 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -457,7 +457,7 @@ class Task_Dependency(models.Model):
     depends_on = models.ForeignKey(Task, related_name='task_dependencies_depends')
 
 class Package(models.Model):
-    search_allowed_fields = ['name', 'version', 'revision', 'recipe__name', 'recipe__version', 'recipe__license', 'recipe__layer_version__layer__name', 'recipe__layer_version__branch', 'recipe__layer_version__commit', 'recipe__layer_version__layer__local_path', 'installed_name']
+    search_allowed_fields = ['name', 'version', 'revision', 'recipe__name', 'recipe__version', 'recipe__license', 'recipe__layer_version__layer__name', 'recipe__layer_version__branch', 'recipe__layer_version__commit', 'recipe__layer_version__local_path', 'installed_name']
     build = models.ForeignKey('Build')
     recipe = models.ForeignKey('Recipe', null=True)
     name = models.CharField(max_length=100)
@@ -528,7 +528,7 @@ class Package_File(models.Model):
     size = models.IntegerField()
 
 class Recipe(models.Model):
-    search_allowed_fields = ['name', 'version', 'file_path', 'section', 'summary', 'description', 'license', 'layer_version__layer__name', 'layer_version__branch', 'layer_version__commit', 'layer_version__layer__local_path', 'layer_version__layer_source__name']
+    search_allowed_fields = ['name', 'version', 'file_path', 'section', 'summary', 'description', 'license', 'layer_version__layer__name', 'layer_version__branch', 'layer_version__commit', 'layer_version__local_path', 'layer_version__layer_source__name']
 
     layer_source = models.ForeignKey('LayerSource', default = None, null = True)  # from where did we get this recipe
     up_id = models.IntegerField(null = True, default = None)                    # id of entry in the source
@@ -544,6 +544,7 @@ class Recipe(models.Model):
     homepage = models.URLField(blank=True)
     bugtracker = models.URLField(blank=True)
     file_path = models.FilePathField(max_length=255)
+    pathflags = models.CharField(max_length=200, blank=True)
 
     def get_layersource_view_url(self):
         if self.layer_source is None:
@@ -555,18 +556,6 @@ class Recipe(models.Model):
     def __unicode__(self):
         return "Recipe " + self.name + ":" + self.version
 
-    def get_local_path(self):
-        if settings.MANAGED and self.layer_version.build is not None and self.layer_version.build.project is not None:
-            # strip any tag prefixes ('virtual:native:')
-            layer_path=self.layer_version.layer.local_path.split(":")[-1]
-            recipe_path=self.file_path.split(":")[-1]
-            if 0 == recipe_path.find(layer_path):
-                return recipe_path[len(layer_path)+1:]
-            else:
-                return recipe_path
-
-        return self.file_path
-
     def get_vcs_recipe_file_link_url(self):
         return self.layer_version.get_vcs_file_link_url(self.file_path)
 
@@ -579,7 +568,8 @@ class Recipe(models.Model):
             return ""
 
     class Meta:
-        unique_together = ("layer_version", "file_path")
+        unique_together = (("layer_version", "file_path", "pathflags"), )
+
 
 class Recipe_DependencyManager(models.Manager):
     use_for_related_fields = True
@@ -976,7 +966,6 @@ class Layer(models.Model):
     up_date = models.DateTimeField(null = True, default = None)
 
     name = models.CharField(max_length=100)
-    local_path = models.FilePathField(max_length=255, null = True, default = None)
     layer_index_url = models.URLField()
     vcs_url = GitURLField(default = None, null = True)
     vcs_web_url = models.URLField(null = True, default = None)
@@ -1009,6 +998,8 @@ class Layer_Version(models.Model):
     dirpath = models.CharField(max_length=255, null = True, default = None)          # LayerBranch.vcs_subdir
     priority = models.IntegerField(default = 0)         # if -1, this is a default layer
 
+    local_path = models.FilePathField(max_length=1024, default = "/")  # where this layer was checked-out
+
     project = models.ForeignKey('Project', null = True, default = None)   # Set if this layer is project-specific; always set for imported layers, and project-set branches
 
     # code lifted, with adaptations, from the layerindex-web application https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/
diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index 6fbdc7b..1c47354 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -89,7 +89,7 @@
             </td>
             <!-- Layer directory -->
             {% if not MANAGED or not build.project %}
-                <td class="recipe__layer_version__layer__local_path">{{package.recipe.layer_version.layer.local_path}}</td>
+                <td class="recipe__layer_version__local_path">{{package.recipe.layer_version.local_path}}</td>
             {% endif %}
         {%else%}
             <td class="recipe__name"></td>
@@ -97,7 +97,7 @@
             <td class="recipe__layer_version__layer__name"></td>
             <td class="recipe__layer_version__branch"></td>
             <td class="recipe__layer_version__layer__commit"></td>
-            <td class="recipe__layer_version__layer__local_path"></td>
+            <td class="recipe__layer_version__local_path"></td>
         {%endif%}
 
     </tr>
diff --git a/lib/toaster/toastergui/templates/configuration.html b/lib/toaster/toastergui/templates/configuration.html
index d3b34a2..2aa1ae1 100644
--- a/lib/toaster/toastergui/templates/configuration.html
+++ b/lib/toaster/toastergui/templates/configuration.html
@@ -64,7 +64,7 @@
                     {{lv.commit|truncatechars:13}}
                 </a></td>
           {% if not MANAGED or not build.project %}
-            <td>{{lv.layer.local_path}}</td>
+            <td>{{lv.local_path}}</td>
           {% endif %}
         </tr>{% endfor %}
       </tbody>
diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index ad75454..e2ec75d 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -141,7 +141,7 @@
                 Layer directory
                 <i class="icon-question-sign get-help" title="Path to the layer providing the recipe that builds this package"></i>
             </dt>
-            <dd><code>{{package.recipe.layer_version.layer.local_path}}</code></dd>
+            <dd><code>{{package.recipe.layer_version.local_path}}</code></dd>
           {% endif %}
         </dl>
     </div> <!-- row4 well -->
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index a0fe6d7..2da41c3 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -58,13 +58,13 @@
                     <i class="icon-question-sign get-help" title="Path to the layer providing the recipe"></i>
                     Layer directory
                 </dt>
-                <dd><code>{{layer.local_path}}</code></dd>
+                <dd><code>{{object.layer_version.local_path}}</code></dd>
           {% endif %}
                 <dt>
                     <i class="icon-question-sign get-help" title="Path to the recipe .bb file"></i>
                     Recipe file
                 </dt>
-                <dd><code>{{object.get_local_path}}</code></dd>
+                <dd><code>{{object.file_path}} {% if object.pathflags %}<i>({{object.pathflags}})</i>{% endif %}</code></dd>
                 {% if layer_version.branch %}
                 <dt>
                     <i class="icon-question-sign get-help" title="The Git branch of the layer providing the recipe"></i>
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index dc2d9e8..8d4494e 100644
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -84,7 +84,7 @@
             {% endwith %}
         </td>
         <!-- Recipe file -->
-        <td class="recipe_file">{{recipe.get_local_path}}</td>
+        <td class="recipe_file">{{recipe.file_path}} {% if recipe.pathflags %}<i>({{recipe.pathflags}})</i>{% endif %}</td>
         <!-- Section -->
         <td class="recipe_section">{{recipe.section}}</td>
         <!-- License -->
@@ -105,7 +105,7 @@
 
         {% if not MANAGED or not build.project %}
             <!-- Layer directory -->
-            <td class="layer_version__layer__local_path">{{recipe.layer_version.layer.local_path}}</td>
+            <td class="layer_version__local_path">{{recipe.layer_version.local_path}}</td>
         {% endif %}
     </tr>
 
diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index 1309b52..e7febaf 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -154,7 +154,7 @@
         </td>
         {% if not MANAGED or not build.project %}
             <td class="layer_directory">
-                {{ package.recipe.layer_version.layer.local_path }}
+                {{ package.recipe.layer_version.local_path }}
             </td>
         {% endif %}
     </tr>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index c16fc22..761bf53 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -725,9 +725,9 @@ eans multiple licenses exist that cover different parts of the source',
         tc_layerDir = {
             'name':'Layer directory',
             'qhelp':'Location in disk of the layer providing the recipe that builds the package',
-            'orderfield' : _get_toggle_order( request, "recipe__layer_version__layer__local_path" ),
-            'ordericon'  : _get_toggle_order_icon( request, "recipe__layer_version__layer__local_path" ),
-            'orderkey'   : "recipe__layer_version__layer__local_path",
+            'orderfield' : _get_toggle_order( request, "recipe__layer_version__local_path" ),
+            'ordericon'  : _get_toggle_order_icon( request, "recipe__layer_version__local_path" ),
+            'orderkey'   : "recipe__layer_version__local_path",
             'clclass'    : 'layer_directory',
             'hidden'     : 1,
         }
@@ -1254,10 +1254,10 @@ def recipes(request, build_id):
             {
                 'name':'Layer directory',
                 'qhelp':'Path to the layer prodiving the recipe',
-                'orderfield': _get_toggle_order(request, "layer_version__layer__local_path"),
-                'ordericon':_get_toggle_order_icon(request, "layer_version__layer__local_path"),
-                'orderkey' : 'layer_version__layer__local_path',
-                'clclass': 'layer_version__layer__local_path', 'hidden': 1,
+                'orderfield': _get_toggle_order(request, "layer_version__local_path"),
+                'ordericon':_get_toggle_order_icon(request, "layer_version__local_path"),
+                'orderkey' : 'layer_version__local_path',
+                'clclass': 'layer_version__local_path', 'hidden': 1,
             })
 
 
@@ -1464,10 +1464,10 @@ def bpackage(request, build_id):
         tc_layerDir = {
                 'name':'Layer directory',
                 'qhelp':'Path to the layer providing the recipe that builds the package',
-                'orderfield': _get_toggle_order(request, "recipe__layer_version__layer__local_path"),
-                'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__layer__local_path"),
-                'orderkey' : 'recipe__layer_version__layer__local_path',
-                'clclass': 'recipe__layer_version__layer__local_path', 'hidden': 1,
+                'orderfield': _get_toggle_order(request, "recipe__layer_version__local_path"),
+                'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__local_path"),
+                'orderkey' : 'recipe__layer_version__local_path',
+                'clclass': 'recipe__layer_version__local_path', 'hidden': 1,
         }
         context['tablecols'].append(tc_layerDir)
 
-- 
1.9.1


