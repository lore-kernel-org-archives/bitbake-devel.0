Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 81FB06F7B2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 15:49:53 +0000 (UTC)
Received: by mail-wg0-f47.google.com with SMTP id x12so10170119wgg.18
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=prl6+2FYhWeQ40a5/uMwQEIwBBBSJtjG1t+I5n3HLQY=;
	b=NuI814QmCBakS6gRHrKjpSN9n7T8/2nh78DfWJdAiAmWOf+5AnT0nA1CEoDnX62lKD
	VDb7iLctFCxFb1maD/+PVlnSk7TGDuv03NSy2Blc56fKtRcNEydIb4IZVRPqZDrac/SJ
	7ftYblkK6Jy7Yp1GXZY98K9o6qr3HMu7nqqVzlJxV45YThVVL5Uszzut0nRaf3TaKxw2
	/gqULtgJXMEKSlA0ZQyQngxhcTRURomBDKOSbfO/YIiPvvKIAuGTBGp1l0sJYFC5a8ao
	tgYaNerZeeDZUoLxKUwbtmZk1mu9dsgBtfwEzTS4yqQqpMkU+nP9qtiQAT6Zi5e/F+sg
	eYmw==
X-Gm-Message-State: ALoCoQmn2MPHvdXLD1adkE5c5Vl7y/Q32aURApO1VwnauntuUzEcY9cIt9Jvu6pgeAemeNZVYf22
X-Received: by 10.194.61.210 with SMTP id s18mr37808581wjr.10.1394552994719;
	Tue, 11 Mar 2014 08:49:54 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id cm5sm7641841wid.5.2014.03.11.08.49.52
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 11 Mar 2014 08:49:53 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 2FCF95605BD; Tue, 11 Mar 2014 15:49:54 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 15:49:45 +0000
Message-Id: <f8488845ee9670e16a63c331dd2e97fdb314929c.1394552757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1394552757.git.alexandru.damian@intel.com>
References: <cover.1394552757.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/8] toaster: update database schema
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
X-List-Received-Date: Tue, 11 Mar 2014 15:49:56 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a schema update to account for

* relaxing constraints in Target_Image_File table
* modifying permission filed to string value
* adding license_manifest_path field
* adding image_size field

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 ...ge_size__add_field_target_license_manifest_p.py | 235 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  11 +-
 2 files changed, 241 insertions(+), 5 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0006_auto__add_field_target_image_size__add_field_target_license_manifest_p.py

diff --git a/lib/toaster/orm/migrations/0006_auto__add_field_target_image_size__add_field_target_license_manifest_p.py b/lib/toaster/orm/migrations/0006_auto__add_field_target_image_size__add_field_target_license_manifest_p.py
new file mode 100644
index 0000000..8195d09
--- /dev/null
+++ b/lib/toaster/orm/migrations/0006_auto__add_field_target_image_size__add_field_target_license_manifest_p.py
@@ -0,0 +1,235 @@
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
+        # Adding field 'Target.image_size'
+        db.add_column(u'orm_target', 'image_size',
+                      self.gf('django.db.models.fields.IntegerField')(default=0),
+                      keep_default=False)
+
+        # Adding field 'Target.license_manifest_path'
+        db.add_column(u'orm_target', 'license_manifest_path',
+                      self.gf('django.db.models.fields.CharField')(max_length=500, null=True),
+                      keep_default=False)
+
+
+        # Changing field 'Target_File.permission'
+        db.alter_column(u'orm_target_file', 'permission', self.gf('django.db.models.fields.CharField')(max_length=16))
+
+        # Changing field 'Target_File.sym_target'
+        db.alter_column(u'orm_target_file', 'sym_target_id', self.gf('django.db.models.fields.related.ForeignKey')(null=True, to=orm['orm.Target_File']))
+
+        # Changing field 'Target_File.directory'
+        db.alter_column(u'orm_target_file', 'directory_id', self.gf('django.db.models.fields.related.ForeignKey')(null=True, to=orm['orm.Target_File']))
+
+    def backwards(self, orm):
+        # Deleting field 'Target.image_size'
+        db.delete_column(u'orm_target', 'image_size')
+
+        # Deleting field 'Target.license_manifest_path'
+        db.delete_column(u'orm_target', 'license_manifest_path')
+
+
+        # Changing field 'Target_File.permission'
+        db.alter_column(u'orm_target_file', 'permission', self.gf('django.db.models.fields.IntegerField')())
+
+        # User chose to not deal with backwards NULL issues for 'Target_File.sym_target'
+        raise RuntimeError("Cannot reverse this migration. 'Target_File.sym_target' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration
+        # Changing field 'Target_File.sym_target'
+        db.alter_column(u'orm_target_file', 'sym_target_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Target_File']))
+
+        # User chose to not deal with backwards NULL issues for 'Target_File.directory'
+        raise RuntimeError("Cannot reverse this migration. 'Target_File.directory' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration
+        # Changing field 'Target_File.directory'
+        db.alter_column(u'orm_target_file', 'directory_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Target_File']))
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
+            'description': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
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
+            'description': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
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
+            'file_name': ('django.db.models.fields.FilePathField', [], {'max_length': '100'}),
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
+            'operation': ('django.db.models.fields.CharField', [], {'max_length': '16'}),
+            'value': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'variable': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'vhistory'", 'to': u"orm['orm.Variable']"})
+        }
+    }
+
+    complete_apps = ['orm']
\ No newline at end of file
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index ba3ade0..6706da8 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -55,6 +55,8 @@ class Target(models.Model):
     build = models.ForeignKey(Build)
     target = models.CharField(max_length=100)
     is_image = models.BooleanField(default = False)
+    image_size = models.IntegerField(default=0)
+    license_manifest_path = models.CharField(max_length=500, null=True)
 
     def __str__(self):
         return self.target
@@ -72,7 +74,6 @@ class Target_File(models.Model):
     ITYPE_FIFO = 5
     ITYPE_CHARACTER = 6
     ITYPE_BLOCK = 7
-    ITYPE_SYMBLINK = 8
     ITYPES = ( (ITYPE_REGULAR ,'regular'),
         ( ITYPE_DIRECTORY ,'directory'),
         ( ITYPE_SYMLINK ,'symlink'),
@@ -80,17 +81,17 @@ class Target_File(models.Model):
         ( ITYPE_FIFO ,'fifo'),
         ( ITYPE_CHARACTER ,'character'),
         ( ITYPE_BLOCK ,'block'),
-        ( ITYPE_SYMLINK ,'symblink'))
+        )
 
     target = models.ForeignKey(Target)
     path = models.FilePathField()
     size = models.IntegerField()
     inodetype = models.IntegerField(choices = ITYPES)
-    permission = models.IntegerField()
+    permission = models.CharField(max_length=16)
     owner = models.CharField(max_length=128)
     group = models.CharField(max_length=128)
-    directory = models.ForeignKey('Target_File', related_name="directory_set")
-    sym_target = models.ForeignKey('Target_File', related_name="symlink_set", blank=True)
+    directory = models.ForeignKey('Target_File', related_name="directory_set", null=True)
+    sym_target = models.ForeignKey('Target_File', related_name="symlink_set", null=True)
 
 
 class TaskManager(models.Manager):
-- 
1.8.3.2


