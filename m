Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 30DA1609A7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 May 2014 13:24:39 +0000 (UTC)
Received: by mail-wg0-f46.google.com with SMTP id n12so2516038wgh.29
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 May 2014 06:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=C7Jzf8xuC+bzZcu7iN0cyGcdjPkMm6xhj+x1rtlN22U=;
	b=ix/8B+Nq9ob0C0ykBUyAKHKkYOhV+LHsDg4uTDZLt6aEtMBtcRnpoTRMql8l437ovF
	KMhYnvt4R4Adx1RNOTMLqdrPvIzkI1iWzo6ek6YKOqhnCOY8qK0vuk1pqLYRuXD9RW5A
	a8TdESMOYMHX7f/Rv5AAFmcIU1NRckbNkAR1lkHUS5cz7L4DRmGKvGI5a9p6bwDqJLCE
	msvzKYYnvGJv2C3N0oXjA3xyZ/AbKDkPEQqFRxLOoLm/GvO897wFqkJdEkdFkLSxUlcs
	Fw1gGg3+TplYxKW4qAQuZDtJlZfJ3ndGWfGRskCDiaBQTKVEejZ9sfGeIR9hS1IoVMyu
	gZtQ==
X-Gm-Message-State: ALoCoQkWSz+nRggzzoE/qKRv3XFpXuxcJpYK0XS+yAHRYyW/PCDnPhwHXL2tn8QxsgE3yryfDuwN
X-Received: by 10.194.62.210 with SMTP id a18mr3305237wjs.4.1399555480515;
	Thu, 08 May 2014 06:24:40 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id be3sm1332339wjc.5.2014.05.08.06.24.37
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 May 2014 06:24:37 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id F4146560864; Thu,  8 May 2014 21:24:36 +0800 (HKT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 May 2014 14:24:35 +0100
Message-Id: <114325b67668843ce6d3c164967bc64424c41534.1399555312.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7fc64b40c28e09f8fe549d8d2972d5066bc1d125.1399555312.git.alexandru.damian@intel.com>
References: <7fc64b40c28e09f8fe549d8d2972d5066bc1d125.1399555312.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1399555312.git.alexandru.damian@intel.com>
References: <cover.1399555312.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/5] toaster: modify SQL data type constraints
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
X-List-Received-Date: Thu, 08 May 2014 13:24:42 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch modifies the data type constraints for the SQL
fields.

The original constraints have been based on guess worked, and
they weren't strictly enforced for sqlite. On MySQL, the
constraints are strictly enforced, and need to match the real
data that we have.

After measuring data on sample builds, the new constraints
have been validated to work with MySQL, and this patch updates
the database schema with the new field types / constraints.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 ...story_operation__chg_field_recipe_descriptio.py | 225 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |   8 +-
 2 files changed, 229 insertions(+), 4 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0008_auto__chg_field_variablehistory_operation__chg_field_recipe_descriptio.py

diff --git a/lib/toaster/orm/migrations/0008_auto__chg_field_variablehistory_operation__chg_field_recipe_descriptio.py b/lib/toaster/orm/migrations/0008_auto__chg_field_variablehistory_operation__chg_field_recipe_descriptio.py
new file mode 100644
index 0000000..f52fc2f
--- /dev/null
+++ b/lib/toaster/orm/migrations/0008_auto__chg_field_variablehistory_operation__chg_field_recipe_descriptio.py
@@ -0,0 +1,225 @@
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
+
+        # Changing field 'VariableHistory.operation'
+        db.alter_column(u'orm_variablehistory', 'operation', self.gf('django.db.models.fields.CharField')(max_length=64))
+
+        # Changing field 'Recipe.description'
+        db.alter_column(u'orm_recipe', 'description', self.gf('django.db.models.fields.TextField')())
+
+        # Changing field 'Target_Image_File.file_name'
+        db.alter_column(u'orm_target_image_file', 'file_name', self.gf('django.db.models.fields.FilePathField')(max_length=254))
+
+        # Changing field 'Package.description'
+        db.alter_column(u'orm_package', 'description', self.gf('django.db.models.fields.TextField')())
+
+    def backwards(self, orm):
+
+        # Changing field 'VariableHistory.operation'
+        db.alter_column(u'orm_variablehistory', 'operation', self.gf('django.db.models.fields.CharField')(max_length=16))
+
+        # Changing field 'Recipe.description'
+        db.alter_column(u'orm_recipe', 'description', self.gf('django.db.models.fields.CharField')(max_length=100))
+
+        # Changing field 'Target_Image_File.file_name'
+        db.alter_column(u'orm_target_image_file', 'file_name', self.gf('django.db.models.fields.FilePathField')(max_length=100))
+
+        # Changing field 'Package.description'
+        db.alter_column(u'orm_package', 'description', self.gf('django.db.models.fields.CharField')(max_length=200))
+
+    models = {
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
+            'started_on': ('django.db.models.fields.DateTimeField', [], {}),
+            'timespent': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'warnings_no': ('django.db.models.fields.IntegerField', [], {'default': '0'})
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
+            'Meta': {'object_name': 'Layer'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_index_url': ('django.db.models.fields.URLField', [], {'max_length': '200'}),
+            'local_path': ('django.db.models.fields.FilePathField', [], {'max_length': '255'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
+        },
+        u'orm.layer_version': {
+            'Meta': {'object_name': 'Layer_Version'},
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'layer_version_build'", 'to': u"orm['orm.Build']"}),
+            'commit': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'layer_version_layer'", 'to': u"orm['orm.Layer']"}),
+            'priority': ('django.db.models.fields.IntegerField', [], {})
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
+            'summary': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
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
+        u'orm.recipe': {
+            'Meta': {'object_name': 'Recipe'},
+            'bugtracker': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'file_path': ('django.db.models.fields.FilePathField', [], {'max_length': '255'}),
+            'homepage': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'recipe_layer_version'", 'to': u"orm['orm.Layer_Version']"}),
+            'license': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'section': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'summary': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'version': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'})
+        },
+        u'orm.recipe_dependency': {
+            'Meta': {'object_name': 'Recipe_Dependency'},
+            'dep_type': ('django.db.models.fields.IntegerField', [], {}),
+            'depends_on': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'r_dependencies_depends'", 'to': u"orm['orm.Recipe']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'recipe': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'r_dependencies_recipe'", 'to': u"orm['orm.Recipe']"})
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
+            'cpu_usage': ('django.db.models.fields.DecimalField', [], {'null': 'True', 'max_digits': '6', 'decimal_places': '2'}),
+            'disk_io': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'elapsed_time': ('django.db.models.fields.DecimalField', [], {'null': 'True', 'max_digits': '6', 'decimal_places': '2'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'line_number': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'logfile': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'}),
+            'message': ('django.db.models.fields.CharField', [], {'max_length': '240'}),
+            'order': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'outcome': ('django.db.models.fields.IntegerField', [], {'default': '-1'}),
+            'path_to_sstate_obj': ('django.db.models.fields.FilePathField', [], {'max_length': '500', 'blank': 'True'}),
+            'recipe': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'build_recipe'", 'to': u"orm['orm.Recipe']"}),
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
\ No newline at end of file
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 22c66a9..8aa7126 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -72,7 +72,7 @@ class Target(models.Model):
 
 class Target_Image_File(models.Model):
     target = models.ForeignKey(Target)
-    file_name = models.FilePathField(max_length=100)
+    file_name = models.FilePathField(max_length=254)
     file_size = models.IntegerField()
 
 class Target_File(models.Model):
@@ -230,7 +230,7 @@ class Package(models.Model):
     version = models.CharField(max_length=100, blank=True)
     revision = models.CharField(max_length=32, blank=True)
     summary = models.CharField(max_length=200, blank=True)
-    description = models.CharField(max_length=200, blank=True)
+    description = models.TextField(blank=True)
     size = models.IntegerField(default=0)
     installed_size = models.IntegerField(default=0)
     section = models.CharField(max_length=80, blank=True)
@@ -298,7 +298,7 @@ class Recipe(models.Model):
     version = models.CharField(max_length=100, blank=True)
     layer_version = models.ForeignKey('Layer_Version', related_name='recipe_layer_version')
     summary = models.CharField(max_length=100, blank=True)
-    description = models.CharField(max_length=100, blank=True)
+    description = models.TextField(blank=True)
     section = models.CharField(max_length=100, blank=True)
     license = models.CharField(max_length=200, blank=True)
     homepage = models.URLField(blank=True)
@@ -353,7 +353,7 @@ class VariableHistory(models.Model):
     value   = models.TextField(blank=True)
     file_name = models.FilePathField(max_length=255)
     line_number = models.IntegerField(null=True)
-    operation = models.CharField(max_length=16)
+    operation = models.CharField(max_length=64)
 
 class HelpText(models.Model):
     VARIABLE = 0
-- 
1.9.1


