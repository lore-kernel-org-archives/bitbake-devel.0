Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 98D317047C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 16:55:31 +0000 (UTC)
Received: by mail-wg0-f49.google.com with SMTP id a1so4373346wgh.20
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 09:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=/m4DO1W9O2V5UdIulZ6h/mqNe3fio0ffODYla8Gasp0=;
	b=ES03U/j2lwWnDKEr34JjPl7w3wIcWYS3ZxFg4DU7+8Xd/tuM23qjJj01GiShb6b6R6
	VJNo9a5Go+28zV9ktc0/wXZ/IM5pp1Wr0XawLy6JSq6kvdUCd8qZ1jc3RhWJzqyun5pX
	sGsaW3IYWwTDZvrK1d0xAzDovJMOjt4NPsQTUhDSkrtlD8vhXMQt4XB0g88jglrfYgGO
	45evdiZQ/h6M3gHkuxQvtPshjGwZYnUHljDfMccyzMxCjK2lye8F+U3hqj3tm/JTMiVI
	7FQ4F2mWDs04jbv6raA4QemEhrFS9PZBGLkhrZ5T8sjRW0xNMquxF03sD8KGMMy7ZAgh
	BI8w==
X-Gm-Message-State: ALoCoQnJCqD33uf4HtdT1Jf1bdIg/IsUYq3o+02J8lMGelEGMRzD2UlUXgY0Gxzwn0m486PeX+8D
X-Received: by 10.194.189.50 with SMTP id gf18mr50331489wjc.13.1404924932511; 
	Wed, 09 Jul 2014 09:55:32 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id n2sm17107146wix.15.2014.07.09.09.55.29
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Jul 2014 09:55:30 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 9B2B65611D7; Wed,  9 Jul 2014 17:55:26 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Jul 2014 17:55:24 +0100
Message-Id: <8855daebe55917c4f5855413d02ae1f3f7f76571.1404924714.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404924713.git.alexandru.damian@intel.com>
References: <cover.1404924713.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 8/9] toaster: new project page implementation
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
X-List-Received-Date: Wed, 09 Jul 2014 16:55:32 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add the logic to create a new project. This page
also serves as user registration and silent login
for users.

Once the project is added, the main project page is displayed.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 ...anch__add_field_project_short_description__a.py | 257 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  38 +++
 lib/toaster/toastergui/templates/newproject.html   |  13 +-
 lib/toaster/toastergui/urls.py                     |   2 +-
 lib/toaster/toastergui/views.py                    |  48 +++-
 5 files changed, 338 insertions(+), 20 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0010_auto__add_field_project_branch__add_field_project_short_description__a.py

diff --git a/lib/toaster/orm/migrations/0010_auto__add_field_project_branch__add_field_project_short_description__a.py b/lib/toaster/orm/migrations/0010_auto__add_field_project_branch__add_field_project_short_description__a.py
new file mode 100644
index 0000000..aa1ce1f
--- /dev/null
+++ b/lib/toaster/orm/migrations/0010_auto__add_field_project_branch__add_field_project_short_description__a.py
@@ -0,0 +1,257 @@
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
+        # Adding field 'Project.branch'
+        db.add_column(u'orm_project', 'branch',
+                      self.gf('django.db.models.fields.CharField')(default='master', max_length=50),
+                      keep_default=False)
+
+        # Adding field 'Project.short_description'
+        db.add_column(u'orm_project', 'short_description',
+                      self.gf('django.db.models.fields.CharField')(default='', max_length=50, blank=True),
+                      keep_default=False)
+
+        # Adding field 'Project.user_id'
+        db.add_column(u'orm_project', 'user_id',
+                      self.gf('django.db.models.fields.IntegerField')(null=True),
+                      keep_default=False)
+
+
+    def backwards(self, orm):
+        # Deleting field 'Project.branch'
+        db.delete_column(u'orm_project', 'branch')
+
+        # Deleting field 'Project.short_description'
+        db.delete_column(u'orm_project', 'short_description')
+
+        # Deleting field 'Project.user_id'
+        db.delete_column(u'orm_project', 'user_id')
+
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
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']", 'null': 'True'}),
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
+        u'orm.project': {
+            'Meta': {'object_name': 'Project'},
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'short_description': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
+            'user_id': ('django.db.models.fields.IntegerField', [], {'null': 'True'})
+        },
+        u'orm.projectlayer': {
+            'Meta': {'object_name': 'ProjectLayer'},
+            'commit': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'giturl': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"})
+        },
+        u'orm.projecttarget': {
+            'Meta': {'object_name': 'ProjectTarget'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'target': ('django.db.models.fields.CharField', [], {'max_length': '100'})
+        },
+        u'orm.projectvariable': {
+            'Meta': {'object_name': 'ProjectVariable'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'value': ('django.db.models.fields.TextField', [], {'blank': 'True'})
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
index b67afe1..f406429 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -23,10 +23,48 @@ from django.db import models
 from django.db.models import F
 from django.utils.encoding import python_2_unicode_compatible
 
+class ProjectManager(models.Manager):
+    def create_project(self, name, branch, short_description):
+        prj = self.model(name = name, branch = branch, short_description = short_description)
+        prj.save()
+
+        # create default variables
+        ProjectVariable.objects.create(project = prj, name = "MACHINE", value = "qemux86")
+        ProjectVariable.objects.create(project = prj, name = "DISTRO", value = "poky")
+
+        # create default layers
+        ProjectLayer.objects.create(project = prj,
+            name = "meta",
+            giturl = "git://git.yoctoproject.org/poky",
+            commit = branch,
+            treepath = "meta")
+
+        ProjectLayer.objects.create(project = prj,
+            name = "meta-yocto",
+            giturl = "git://git.yoctoproject.org/poky",
+            commit = branch,
+            treepath = "meta-yocto")
+
+        return prj
+
+    def create(self, *args, **kwargs):
+        raise Exception("Invalid call to Project.objects.create. Use Project.objects.create_project() to create a project")
+
+    def get_or_create(self, *args, **kwargs):
+        raise Exception("Invalid call to Project.objects.get_or_create. Use Project.objects.create_project() to create a project")
+
 class Project(models.Model):
     name = models.CharField(max_length=100)
+    branch = models.CharField(max_length=50)
+    short_description = models.CharField(max_length=50, blank=True)
     created     = models.DateTimeField(auto_now_add = True)
     updated     = models.DateTimeField(auto_now = True)
+    # This is a horrible hack; since Toaster has no "User" model available when
+    # running in interactive mode, we can't reference the field here directly
+    # Instead, we keep a possible null reference to the User id, as not to force
+    # hard links to possibly missing models
+    user_id     = models.IntegerField(null = True)
+    objects     = ProjectManager()
 
 class Build(models.Model):
     SUCCEEDED = 0
diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index ce01800..8f1867a 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -8,9 +8,9 @@
 					<h1>Create a new project</h1>
 				</div>
 				<div class="container-fluid">
-		{% for a in alerts %}
-			<div class="alert alert-error row-fluid" role="alert">{{a}}</div>
-		{% endfor %}
+		{% if alert %}
+			<div class="alert alert-error row-fluid" role="alert">{{alert}}</div>
+		{% endif %}
 				</div>
 					<form method="POST">{% csrf_token %}
 						<fieldset>
@@ -27,10 +27,9 @@
 								Yocto Project version
 								<i class="icon-question-sign get-help" title="This sets the branch for the Yocto Project core layers (meta, meta-yocto and meta-yocto-bsp), and for the layers you use from the OpenEmbedded Metadata Index"></i>
 							</label>
-							<select name="projectversion">
-		<option value="1.7" {%if projectversion == "1.7" %}selected{%endif%}>Yocto Project 1.7 "D?"</option>
-		<option value="1.6" {%if projectversion == "1.6" %}selected{%endif%}>Yocto Project 1.6 "Daisy"</option>
-		<option value="1.5" {%if projectversion == "1.5" %}selected{%endif%}>Yocto Project 1.5 "Dora"</option>
+							<select name="projectversion" id="projectversion">
+		<!-- TODO: XHR data from http://layers.openembedded.org/layerindex/branch/master/layers/ -->
+		<option value="master" {%if projectversion == "master" %}selected{%endif%}>master</option>
 							</select>
 						</fieldset>
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index bba4fda..0d7a4c3 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -68,7 +68,7 @@ urlpatterns = patterns('toastergui.views',
 
         # project URLs
         url(r'^newproject/$', 'newproject', name='newproject'),
-        url(r'^project/$', 'project', name='project'),
+        url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
 
         # default redirection
         url(r'^$', RedirectView.as_view( url= 'builds/')),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a57f001..8fbe8a3 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -22,11 +22,13 @@
 import operator,re
 
 from django.db.models import Q, Sum
+from django.db import IntegrityError
 from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
 from orm.models import Target_Installed_Package, Target_File, Target_Image_File
 from django.views.decorators.cache import cache_control
+from django.core.urlresolvers import reverse
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseBadRequest
 from django.utils import timezone
@@ -68,7 +70,6 @@ def _verify_parameters(g, mandatory_parameters):
 
 def _redirect_parameters(view, g, mandatory_parameters, *args, **kwargs):
     import urllib
-    from django.core.urlresolvers import reverse
     url = reverse(view, kwargs=kwargs)
     params = {}
     for i in g:
@@ -1772,6 +1773,16 @@ if toastermain.settings.MANAGED:
     from django.contrib.auth import authenticate, login
     from django.contrib.auth.decorators import login_required
 
+    import traceback
+
+    class BadParameterException(Exception): pass        # error thrown on invalid POST requests
+
+    # the context processor that supplies data used across all the pages
+    def managedcontextprocessor(request):
+        return {
+            "projects": Project.objects.all(),
+            "MANAGED" : toastermain.settings.MANAGED
+        }
 
     # new project
     def newproject(request):
@@ -1787,28 +1798,41 @@ if toastermain.settings.MANAGED:
             return render(request, template, context)
         elif request.method == "POST":
             mandatory_fields = ['projectname', 'email', 'username', 'projectversion']
-            if reduce( lambda x, y: x and y, map(lambda x: x in request.POST and len(request.POST[x]) > 0, mandatory_fields)):
+            try:
+                # make sure we have values for all mandatory_fields
+                if reduce( lambda x, y: x or y, map(lambda x: len(request.POST.get(x, '')) == 0, mandatory_fields)):
+                # set alert for missing fields
+                    raise BadParameterException("Fields missing: " +
+            ", ".join([x for x in mandatory_fields if len(request.POST.get(x, '')) == 0 ]))
+
                 if not request.user.is_authenticated():
                     user = authenticate(username = request.POST['username'], password = 'nopass')
                     if user is None:
                         user = User.objects.create_user(username = request.POST['username'], email = request.POST['email'], password = "nopass")
-                        raise Exception("User cannot be authed, creating")
-                        user = authenticate(username = request.POST['username'], password = '')
+
+                        user = authenticate(username = user.username, password = 'nopass')
                     login(request, user)
 
-                return redirect(project)
-            else:
-                alerts = []
-                # set alerts for missing fields
-                map(lambda x: alerts.append('Field '+ x + ' not filled in') if not x in request.POST or len(request.POST[x]) == 0 else None, mandatory_fields)
-                # fill in new page with already submitted values
+                #  save the project
+                prj = Project.objects.create_project(name = request.POST['projectname'],
+                    branch = request.POST['projectversion'].split(" ")[0],
+                    short_description=request.POST['projectversion'].split(" ")[1:])
+                prj.user_id = request.user.pk
+                prj.save()
+                return redirect(reverse(project, args = (prj.pk,)))
+
+            except (IntegrityError, BadParameterException) as e:
+                # fill in page with previously submitted values
                 map(lambda x: context.__setitem__(x, request.POST[x]), mandatory_fields)
-                context['alerts'] = alerts
+                if isinstance(e, IntegrityError) and "username" in str(e):
+                    context['alert'] = "Your chosen username is already used"
+                else:
+                    context['alert'] = str(e)
                 return render(request, template, context)
         raise Exception("Invalid HTTP method for this page")
 
     # Shows the edit project page
-    def project(request):
+    def project(request, pid):
         template = "project.html"
         context = {}
         return render(request, template, context)
-- 
1.9.1


