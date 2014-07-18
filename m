Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id C8BDC7061F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 12:15:03 +0000 (UTC)
Received: by mail-wi0-f179.google.com with SMTP id f8so742586wiw.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 05:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Fp7lKACQt4a4DeRAmkSVTBikEnWDq7VoHnjWLnyhAks=;
	b=Gviyl4Ea8mGFw/vwiVAmyQqdix49WkpBXBvtEHFgUng/qVEk4ZFjnvMZGd9bMQwqnD
	iOWsgHv1R/BJKYuvU7aWDWEHWrqhKLUaiKQY2OKMddEcl1h7y3p5kKYpEao1JKxoKO7q
	UM3w/YrqHJG3O2daz648AlTejoXrCRFGRBciyuOszlKlhslZMwzY10CylpXwd1gfP+l7
	rzs8Nw4g9lMAMzCxZP9qUTFV5bqyC+uTh8nOE59XZVpqoCqB7oGtJMV1D6748IlyaWo1
	oFkOTakkLS3omjS71zj/QIfHY0A9utkqtV6PaHv+nZKvEnyhjUfTN1j8n4vhZnhTvXLj
	8/0g==
X-Gm-Message-State: ALoCoQme1KrAiYxe6T9ZcadUeM2s+CLZsliWyaxrl4SeJmL3jGpNNFlRj/yyMU4HUzMwGG0Wr0HL
X-Received: by 10.180.12.33 with SMTP id v1mr32288059wib.0.1405685703580;
	Fri, 18 Jul 2014 05:15:03 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	a13sm13831478wjs.12.2014.07.18.05.15.01 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 18 Jul 2014 05:15:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D35455602DF; Fri, 18 Jul 2014 13:15:02 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 18 Jul 2014 13:14:58 +0100
Message-Id: <9b1ef563bc3cc2b671c78dc9e54cb17f11c43cf7.1405685308.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
References: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1405685308.git.alexandru.damian@intel.com>
References: <cover.1405685308.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/8] toaster: add project main edit page
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
X-List-Received-Date: Fri, 18 Jul 2014 12:15:04 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is the first commit on the project main edit page.

At this point we have:
* the default settings for a newly created project
* the ability to add targets
* the ability to trigger a build command, and have
the build executed

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                        |   4 +-
 ...layer_optional__add_field_projecttarget_task.py | 252 +++++++++++++++
 lib/toaster/orm/models.py                          |   8 +-
 lib/toaster/toastergui/static/css/default.css      |  42 ++-
 lib/toaster/toastergui/templates/base.html         |   4 +
 lib/toaster/toastergui/templates/project.html      | 356 +++++++++++++++++++++
 lib/toaster/toastergui/urls.py                     |   3 +
 lib/toaster/toastergui/views.py                    | 105 +++++-
 8 files changed, 750 insertions(+), 24 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0012_auto__add_field_projectlayer_optional__add_field_projecttarget_task.py

diff --git a/bin/toaster b/bin/toaster
index 78fbfa5..93d75b0 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -128,8 +128,8 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
     # Start just the web server, point the web browser to the interface, and start any Django services.
 
     if [ -n "$BUILDDIR" ]; then
-        echo "Error: build/ directory detected. Standalone Toaster will not start in a build environment." 1>&2;
-        return 1;
+        echo -e "Error: build/ directory detected. Toaster will not start in managed mode if a build environment is detected.\nUse a clean terminal to start Toaster." 1>&2;
+        exit 1;
     fi
 
     # Define a fake builddir where only the pid files are actually created. No real builds will take place here.
diff --git a/lib/toaster/orm/migrations/0012_auto__add_field_projectlayer_optional__add_field_projecttarget_task.py b/lib/toaster/orm/migrations/0012_auto__add_field_projectlayer_optional__add_field_projecttarget_task.py
new file mode 100644
index 0000000..9e483f5
--- /dev/null
+++ b/lib/toaster/orm/migrations/0012_auto__add_field_projectlayer_optional__add_field_projecttarget_task.py
@@ -0,0 +1,252 @@
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
+        # Adding field 'ProjectLayer.optional'
+        db.add_column(u'orm_projectlayer', 'optional',
+                      self.gf('django.db.models.fields.BooleanField')(default=True),
+                      keep_default=False)
+
+        # Adding field 'ProjectTarget.task'
+        db.add_column(u'orm_projecttarget', 'task',
+                      self.gf('django.db.models.fields.CharField')(max_length=100, null=True),
+                      keep_default=False)
+
+
+    def backwards(self, orm):
+        # Deleting field 'ProjectLayer.optional'
+        db.delete_column(u'orm_projectlayer', 'optional')
+
+        # Deleting field 'ProjectTarget.task'
+        db.delete_column(u'orm_projecttarget', 'task')
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
+            'dirpath': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'giturl': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
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
index 9b7387a..f19a437 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -37,13 +37,15 @@ class ProjectManager(models.Manager):
             name = "meta",
             giturl = "git://git.yoctoproject.org/poky",
             commit = branch,
-            dirpath = "meta")
+            dirpath = "meta",
+            optional = False)
 
         ProjectLayer.objects.create(project = prj,
             name = "meta-yocto",
             giturl = "git://git.yoctoproject.org/poky",
             commit = branch,
-            dirpath = "meta-yocto")
+            dirpath = "meta-yocto",
+            optional = False)
 
         return prj
 
@@ -116,6 +118,7 @@ class Build(models.Model):
 class ProjectTarget(models.Model):
     project = models.ForeignKey(Project)
     target = models.CharField(max_length=100)
+    task = models.CharField(max_length=100, null=True)
 
 @python_2_unicode_compatible
 class Target(models.Model):
@@ -392,6 +395,7 @@ class ProjectLayer(models.Model):
     giturl = models.CharField(max_length = 254)
     commit = models.CharField(max_length = 254)
     dirpath = models.CharField(max_length = 254)
+    optional = models.BooleanField(default = True)
 
 class Layer(models.Model):
     name = models.CharField(max_length=100)
diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 2c283fe..778d8b8 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -116,17 +116,31 @@ select { width: auto; }
 /* make tables Chrome-happy (me, not so much) */
 #otable { table-layout: fixed; word-wrap: break-word; }
 
-
-
-
-
-
-
-
-
-
-
-
-
-
-
+/* Configuration styles */
+.icon-trash { color: #B94A48; font-size: 16px; padding-left: 2px; }
+.icon-trash:hover { color: #943A38; text-decoration: none; cursor: pointer; }
+.icon-pencil, .icon-download-alt { font-size: 16px; color: #0088CC; padding-left: 2px; }
+.icon-pencil:hover, .icon-download-alt:hover { color: #005580; text-decoration: none; cursor: pointer; }
+.configuration-list li { line-height: 35px; font-size: 21px; font-weight: 200; }
+.configuration-list { font-size: 16px; margin-bottom: 1.5em; }
+.configuration-list i { font-size: 16px; }
+/*.configuration-layers { height: 135px; overflow: scroll; }*/
+.counter { font-weight: normal; }
+.well-alert { background-color: #FCF8E3; border: 1px solid #FBEED5; border-radius: 4px; }
+.well-alert > .lead { color: #C09853; padding-bottom: .75em; }
+.configuration-alert { margin-bottom: 0px; padding: 8px 14px; }
+.configuration-alert p { margin-bottom: 0px; }
+fieldset { padding-left: 19px; }
+.project-form { margin-top: 10px; }
+.add-layers .btn-block + .btn-block { margin-top: 0px; }
+input.huge { font-size: 17.5px; padding: 11px 19px; }
+.build-form { margin-bottom: 0px; padding-left: 20px; }
+a code { color: #0088CC; }
+a code:hover { color: #005580; }
+.localconf { font-size: 17.5px; margin-top: 40px; }
+.localconf code { font-size: 17.5px; }
+#add-layer-dependencies {  margin-top: 5px; }
+.artifact { width: 9em; }
+.control-group { margin-bottom: 0px; }
+#project-details form { margin: 0px; }
+dd form { margin: 10px 0 0 0; }
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 1407d64..9ef249a 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -65,6 +65,10 @@ function reload_params(params) {
 							  <i class="icon-caret-down"></i>
 						  </button>
 						  <ul class="dropdown-menu">
+{% for prj in projects %}
+								<li><a href="{% url 'project' prj.id %}">{{prj.name}}</a></li>
+{% endfor %}
+							  <li><hr/></li>
 							  <li><a href="#">Clone project</a></li>
 							  <li><a href="#">Export project</a></li>
 							  <li><a href="#">Import project</a></li>
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 71adb54..c859f6b 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -3,4 +3,360 @@
 {% load humanize %}
 {% block pagecontent %}
 
+<script>
+
+var buildrequests = [];
+
+function targetInPage(targetname) {
+    return targetname in $("ul#target-list > li > a").map(function (i, x) {return x.text});
+}
+
+function setEventHandlers() {
+    $("i#del-target-icon").unbind().click(function (evt) {
+        console.log("del target", evt.target.attributes["x-data"].value);
+        postEditAjaxRequest({"targetDel": evt.target.attributes["x-data"].value});
+    });
+    $("button#add-target-button").unbind().click( function (evt) {
+        if ( $("input#target")[0].value.length == 0) {
+            alert("cannot add empty target");
+            return;
+        }
+        postEditAjaxRequest({"targetAdd" : $("input#target")[0].value});
+    });
+}
+
+function onEditPageUpdate(data) {
+    // update targets
+    var i; var orightml = "";
+
+    $("span#target-count").html(data.targets.length);
+    for (i = 0; i < data.targets.length; i++) {
+        if (! targetInPage(data.targets[i].target)) {
+            orightml += '<li><a href="#">'+data.targets[i].target;
+            if (data.targets[i].task != "" && data.targets[i].task !== null) {
+                orightml += " ("+data.targets[i].task+")";
+            }
+            orightml += '</a><i title="" data-original-title="" class="icon-trash" id="del-target-icon" x-data="'+data.targets[i].pk+'"></i></li>';
+        }
+    }
+
+    $("ul#target-list").html(orightml);
+
+    // update recent builds
+
+    setEventHandlers();
+}
+
+function onEditAjaxSuccess(data, textstatus) {
+    console.log("XHR returned:", data, "(" + textstatus + ")");
+    if (data.error != "ok") {
+        alert("error on request:\n" + data.error);
+        return;
+    }
+    onEditPageUpdate(data);
+}
+
+function onEditAjaxError(jqXHR, textstatus, error) {
+    alert("XHR errored:\n" + error + "\n(" + textstatus + ")");
+}
+
+function postEditAjaxRequest(reqdata) {
+    var ajax = $.ajax({
+            type:"POST",
+            data: $.param(reqdata),
+            url:"{% url 'xhr_projectedit' project.id%}",
+            headers: { 'X-CSRFToken': $.cookie("csrftoken")},
+            success: onEditAjaxSuccess,
+            error: onEditAjaxError,
+        })
+}
+
+$(document).ready(function () {
+    setEventHandlers();
+});
+
+</script>
+
+
+            <div class="page-header">
+                <h1>
+                    {{project.name}}
+                    {% if project.build_set.all.count == 0 %}
+                    <small>No builds yet</small>
+                    {% else %}
+                    <small><a href="#">{{project.build_set.all.count}} builds</a></small>
+                    {% endif %}
+                </h1>
+            </div>
+
+
+            <div class="well">
+                <!--div class="control-group error"-->
+                    <button id="build-all-button" class="btn btn-primary btn-large">Build all added targets</button>
+                    <div class="input-append build-form controls">
+                        <input class="huge input-xxlarge" placeholder="Or enter the target you want to build" autocomplete="off" data-minlength="1" data-autocomplete="off" data-provide="typeahead" data-source="" type="text">
+                        <button id="build-button" class="btn btn-large" disabled="">Build</button>
+                    </div>
+                    <script>
+/* Provide XHR calls for the "build" buttons.*/
+$("button#build-all-button").click( function (evt) {
+    var ajax = $.ajax({
+            type:"POST",
+            url:"{% url 'xhr_projectbuild' project.id %}",
+            headers: { 'X-CSRFToken': $.cookie("csrftoken")},
+            success: function (data, textstatus) {
+                if (data.error != "ok") {
+                    alert("XHR fail: " + data.error );
+                }
+            },
+            error: function (jqXHR, textstatus, error) { alert("XHR errored:" + error + "(" + textstatus + ")"); },
+        })
+});
+
+                    </script>
+                    <!--span class="help-inline">This target is not provided <br />by any of your added layers
+                        <i class="icon-question-sign get-help get-help-red" title="Review your list of added layers to make sure one of them provides core-image-xyz. Clicking on a layer name will give you all the information Toaster has about the layer"></i>
+                    </span>
+                </div-->
+            </div>
+
+            <div id="meta-tizen-alert" class="alert alert-info lead air" style="display:none;">
+                 <button type="button" class="close" data-dismiss="alert">?</button>
+                You have added <strong>6</strong> layers: <a href="#">meta-tizen</a> and its dependencies (<a href="#">meta-efl</a>, <a href="#">meta-intel</a>, <a href="#">meta-multimedia</a>, <a href="#">meta-oe</a> and <a href="#">meta-ruby</a>).
+            </div>
+
+
+
+
+
+        {% if builds|length > 0 or buildrequests|length > 0 %}
+            <h2 class="air">Recent Builds</h2>
+
+    <div id="scheduled-builds">
+          {% for br in buildrequests %}
+<div class="alert {% if br.0.state == br.0.REQ_FAILED%}alert-error{%else%}alert-info{%endif%}" id="build-request">
+        <div class="row-fluid">
+            <div class="lead span4">
+                <span>
+                {{br.0.brtarget_set.all.0.target}} {%if br.brtarget_set.all.count > 1%}(+ {{br.brtarget_set.all.count|add:"-1"}}){%endif%} {{br.1.machine.value}} (Created {{br.0.created}})
+                </span>
+            </div>
+            <div class="span2">
+	 {{br.0.get_state_display}}
+            </div>
+	    <div class="span8">
+{% if br.state == br.REQ_FAILED%}
+	{% for bre in br.0.brerror_set.all %} {{bre.errmsg}} ({{bre.errtype}}) <br/><hr/><code>{{bre.traceback}}</code>{%endfor%}
+{%endif%}
+            </div>
+
+        </div>
+</div>
+
+          {% endfor %}
+
+    </div>
+
+
+
+<!-- Lifted from build.html -->
+          {% for build in builds %}
+<div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}">
+        <div class="row-fluid">
+            <div class="lead span5">
+                {%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}
+    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+                <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
+    {% endif %}
+                <span data-toggle="tooltip" {%if build.target_set.all.count > 1%}title="Targets: {%for target in build.target_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|naturaltime}})</span>
+    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+                </a>
+    {% endif %}
+            </div>
+    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+            <div class="span2 lead">
+    {% if  build.errors_no %}
+                <i class="icon-minus-sign red"></i> <a href="{%url 'builddashboard' build.pk%}#errors" class="error">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
+    {% endif %}
+            </div>
+            <div class="span2 lead">
+    {% if  build.warnings_no %}
+                <i class="icon-warning-sign yellow"></i> <a href="{%url 'builddashboard' build.pk%}#warnings" class="warning">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>
+    {% endif %}
+            </div >
+            <div class="lead pull-right">
+                Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
+            </div>
+    {%endif%}{%if build.outcome == build.IN_PROGRESS %}
+            <div class="span4">
+                <div class="progress" style="margin-top:5px;" data-toggle="tooltip" title="{{build.completeper}}% of tasks complete">
+                    <div style="width: {{build.completeper}}%;" class="bar"></div>
+                </div>
+            </div>
+            <div class="lead pull-right">ETA: in {{build.eta|naturaltime}}</div>
+    {%endif%}
+        </div>
+    </div>
+          {% endfor %}
+<!-- end of lift-->
+        {%endif%}
+
+            <h2 class="air">Project configuration</h2>
+
+            <div class="row-fluid">
+
+                <div id="layer-container" class="well well-transparent span4">
+                    <h3>
+                        Add layers
+                        <i data-original-title="OpenEmbedded organises metadata into modules called 'layers'. Layers allow you to isolate different types of customizations from each other. <a href='http://www.yoctoproject.org/docs/1.6.1/dev-manual/dev-manual.html#understanding-and-creating-layers' target='_blank'>More on layers</a>" class="icon-question-sign get-help heading-help" title=""></i>
+                    </h3>
+                    <form style="margin-top:20px;">
+                        <div class="input-append">
+                            <input class="input-xlarge" id="layer" autocomplete="off" placeholder="Type a layer name" data-provide="typeahead" data-source="" data-minlength="1" data-autocomplete="off" type="text">
+                            <button id="add-layer" class="btn" disabled="">Add</button>
+                        </div>
+                        <div id="import-alert" class="alert alert-info" style="display:none;">
+                            Toaster does not know about this layer. Please <a href="#">import it</a>
+                        </div>
+                        <div id="dependency-alert" class="alert alert-info" style="display:none;">
+                            <p><strong>meta-tizen</strong> depends on the layers below. Check the ones you want to add: </p>
+                            <ul class="unstyled">
+                                <li>
+                                    <label class="checkbox">
+                                        <input checked="checked" type="checkbox">
+                                        meta-efl
+                                    </label>
+                                </li>
+                                <li>
+                                    <label class="checkbox">
+                                        <input checked="checked" type="checkbox">
+                                        meta-intel
+                                    </label>
+                                </li>
+                                <li>
+                                    <label class="checkbox">
+                                        <input checked="checked" type="checkbox">
+                                        meta-multimedia
+                                    </label>
+                                </li>
+                                <li>
+                                    <label class="checkbox">
+                                        <input checked="checked" type="checkbox">
+                                        meta-oe
+                                    </label>
+                                </li>
+                                <li>
+                                    <label class="checkbox">
+                                        <input checked="checked" type="checkbox">
+                                        meta-ruby
+                                    </label>
+                                </li>
+                            </ul>
+                            <button id="add-layer-dependencies" class="btn btn-info add-layer">Add layers</button>
+                        </div>
+
+                        <p><a href="#">Import your layer</a> | <a href="#">View all layers</a></p>
+                    </form>
+
+                    <h4 class="air">
+                        Added layers
+                        <span class="muted counter">{{project.projectlayer_set.count}}</span>
+                        <i data-original-title="Your added layers will be listed in this same order in your <code>bblayers.conf</code> file" class="icon-question-sign get-help heading-help" title=""></i>
+                    </h4>
+                    <ul class="unstyled configuration-list">
+            {% for pl in project.projectlayer_set.all %}
+                        <li>
+                            <a href="#">{{pl.name}} (<span class="layer-version">{{pl.giturl}}</span>)</a>
+                {% if pl.optional %}
+                            <i title="" data-original-title="" class="icon-trash" id="del-layer-icon" x-data="{{pl.pk}}"></i>
+                {% endif %}
+                        </li>
+            {% endfor %}
+                    </ul>
+                </div>
+
+                <div id="target-container" class="well well-transparent span4">
+                    <h3>
+                        Add targets
+                        <i data-original-title="A target is what you want to build, usually an image recipe that produces a root file system" class="icon-question-sign get-help heading-help" title=""></i>
+                    </h3>
+                    <form style="margin-top:20px;">
+                        <div class="input-append">
+                            <input id="target" class="input-xlarge" autocomplete="off" placeholder="Type a target name" data-provide="typeahead" data-source="" data-minlength="1" data-autocomplete="off" type="text">
+                            <button id="add-target-button" class="btn" type="button">Add</button>
+                        </div>
+
+                        <p><a href="#" class="link">View all targets</a></p>
+                    </form>
+                    <h4 class="air">
+                        Added targets
+                        <span id="target-count" class="muted counter">{{project.projecttarget_set.count}}</span>
+                    </h4>
+                    <ul class="unstyled configuration-list" id="target-list">
+        {% for target in project.projecttarget_set.all %}
+            {% if target %}
+                        <li>
+                            <a href="#">{{target.target}}{% if target.task%} (target.task){%endif%}</a>
+			    {% if target.notprovided %}
+                            <i title="" data-original-title="" id="msg1" class="icon-exclamation-sign get-help-yellow" data-title="<strong>Target may not be provided</strong>" data-content="From the layer information it currently has, Toaster thinks this target is not provided by any of your added layers. If a target is not provided by one of your added layers, the build will fail.<h5>What Toaster suggests</h5><p>The <a href='#'>meta-abc</a> and <a href='#'>meta-efg</a> layers provide core-image-notprovided. You could add one of them to your project.</p><button class='btn btn-block'>Add meta-abc</button><button class='btn btn-block'>Add meta-efg</button><button id='dismiss1' class='btn btn-block btn-info'>Stop showing this message</button>"></i>
+		            {% elif target.notknown %}
+                            <i title="" data-original-title="" id="msg2" class="icon-exclamation-sign get-help-yellow" data-title="<strong>Target may not be provided</strong>" data-content="From the layer information it currently has, Toaster thinks this target is not provided by any of your added layers. If a target is not provided by one of your added layers, the build will fail.<h5>What Toaster suggests</h5><p>Review your added layers to make sure one of them provides core-image-unknown. Clicking on a layer name will give you all the information Toaster has about the layer. </p> <button class='btn btn-block btn-info'>Stop showing this message</button>"></i>
+                            {% endif %}
+                            <i title="" data-original-title="" class="icon-trash" id="del-target-icon" x-data="{{target.pk}}"></i>
+                        </li>
+            {% endif %}
+        {% endfor %}
+
+
+                    </ul>
+                </div>
+
+                <div class="well well-transparent span4">
+                    <h3>
+                        Set machine
+                        <i data-original-title="The machine is the hardware for which you want to build. You can only set one machine per project" class="icon-question-sign get-help heading-help" title=""></i>
+                    </h3>
+                    <p class="lead">
+                        {{machine}}
+                        <i title="" data-original-title="" class="icon-pencil"></i>
+                    </p>
+                    <h3>
+                        Set distro
+                        <i data-original-title="When you build an image using the Yocto Project and do not alter the distro, you are creating a Poky distribution" class="icon-question-sign get-help heading-help" title=""></i>
+                    </h3>
+                    <p class="lead">
+                        {{distro}}
+                        <i title="" data-original-title="" class="icon-pencil"></i>
+                    </p>
+                    <p class="localconf">
+                        <a href="#" class="link">Edit the <code>local.conf</code> file</a>
+                        <i data-original-title="The <code>local.conf</code> file is where other project configuration options are set. Pretty much any configuration option can be set in this file. Each option, like everything else in the build system, is a variable - value pair" class="icon-question-sign get-help heading-help" title=""></i>
+                    </p>
+                </div>
+            </div>
+
+            <h2>Project details</h2>
+
+            <div class="well well-transparent">
+                <h3>Project name</h3>
+                <p class="lead">
+                    {{project.name}}
+                    <i title="" data-original-title="" class="icon-pencil"></i>
+                </p>
+                <h3>Project owner</h3>
+                <p class="lead">
+                    {{puser.username}}
+                    <i title="" data-original-title="" class="icon-pencil"></i>
+                </p>
+                <h3>Owner's email</h3>
+                <p class="lead">
+            {{puser.email}}
+                    <i title="" data-original-title="" class="icon-pencil"></i>
+                </p>
+                <h3>Yocto Project version</h3>
+                <p class="lead">
+                    {{project.branch}} - {{project.short_description}}
+                    <i title="" data-original-title="" class="icon-pencil"></i>
+                </p>
+            </div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 0d7a4c3..7c4f894 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -69,6 +69,9 @@ urlpatterns = patterns('toastergui.views',
         # project URLs
         url(r'^newproject/$', 'newproject', name='newproject'),
         url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
+        url(r'^xhr_projectbuild/(?P<pid>\d+)/$', 'xhr_projectbuild', name='xhr_projectbuild'),
+        url(r'^xhr_projectedit/(?P<pid>\d+)/$', 'xhr_projectedit', name='xhr_projectedit'),
+
 
         # default redirection
         url(r'^$', RedirectView.as_view( url= 'builds/')),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index f9e8e51..bd65c08 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -30,7 +30,7 @@ from orm.models import Target_Installed_Package, Target_File, Target_Image_File
 from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
-from django.http import HttpResponseBadRequest
+from django.http import HttpResponseBadRequest, HttpResponseNotFound
 from django.utils import timezone
 from datetime import timedelta
 from django.utils import formats
@@ -1761,8 +1761,6 @@ def image_information_dir(request, build_id, target_id, packagefile_id):
 
 
 import toastermain.settings
-def managedcontextprocessor(request):
-    return { "MANAGED" : toastermain.settings.MANAGED }
 
 
 # we have a set of functions if we're in managed mode, or
@@ -1773,7 +1771,8 @@ if toastermain.settings.MANAGED:
     from django.contrib.auth import authenticate, login
     from django.contrib.auth.decorators import login_required
 
-    from orm.models import Project
+    from orm.models import Project, ProjectLayer, ProjectTarget, ProjectVariable
+    from bldcontrol.models import BuildRequest
 
     import traceback
 
@@ -1831,19 +1830,113 @@ if toastermain.settings.MANAGED:
                 else:
                     context['alert'] = str(e)
                 return render(request, template, context)
+
         raise Exception("Invalid HTTP method for this page")
 
     # Shows the edit project page
     def project(request, pid):
         template = "project.html"
-        context = {}
+        try:
+            prj = Project.objects.get(id = pid)
+        except Project.DoesNotExist:
+            return HttpResponseNotFound("<h1>Project id " + pid + " is unavailable</h1>")
+
+        try:
+            puser = User.objects.get(id = prj.user_id)
+        except User.DoesNotExist:
+            puser = None
+
+        context = {
+            "project" : prj,
+            #"buildrequests" : prj.buildrequest_set.filter(state=BuildRequest.REQ_QUEUED),
+            "buildrequests" : map(lambda x: (x, {"machine" : x.brvariable_set.filter(name="MACHINE")[0]}), prj.buildrequest_set.order_by("-pk")),
+            "builds" : prj.build_set.all(),
+            "puser": puser,
+        }
+        try:
+            context["machine"] = prj.projectvariable_set.get(name="MACHINE").value
+        except ProjectVariable.DoesNotExist:
+            context["machine"] = "-- not set yet"
+
+        try:
+            context["distro"] = prj.projectvariable_set.get(name="DISTRO").value
+        except ProjectVariable.DoesNotExist:
+            context["distro"] = "-- not set yet"
+
+
         return render(request, template, context)
 
+    import json
+
+    def xhr_projectbuild(request, pid):
+        try:
+            if request.method != "POST":
+                raise BadParameterException("invalid method")
+            prj = Project.objects.get(id = pid)
+
+            if prj.projecttarget_set.count() == 0:
+                raise BadParameterException("no targets selected")
+
+            br = prj.schedule_build()
+            return HttpResponse(json.dumps({"error":"ok",
+                "brtarget" : map(lambda x: x.target, br.brtarget_set.all()),
+                "machine" : br.brvariable_set.get(name="MACHINE").value,
+
+            }), content_type = "application/json")
+        except Exception as e:
+            return HttpResponse(json.dumps({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
+
+    def xhr_projectedit(request, pid):
+        try:
+            prj = Project.objects.get(id = pid)
+            # add targets
+            if 'targetAdd' in request.POST:
+                for t in request.POST['targetAdd'].strip().split(" "):
+                    if ":" in t:
+                        target, task = t.split(":")
+                    else:
+                        target = t
+                        task = ""
+
+                    pt, created = ProjectTarget.objects.get_or_create(project = prj, target = target, task = task)
+            # remove targets
+            if 'targetDel' in request.POST:
+                for t in request.POST['targetDel'].strip().split(" "):
+                    pt = ProjectTarget.objects.get(pk = int(t)).delete()
+
+            # add layers
+
+            # remove layers
+
+            # return all project settings
+            return HttpResponse(json.dumps( {
+                "error": "ok",
+                "layers": map(lambda x: (x.name, x.giturl), prj.projectlayer_set.all()),
+                "targets" : map(lambda x: {"target" : x.target, "task" : x.task, "pk": x.pk}, prj.projecttarget_set.all()),
+                "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
+                }), content_type = "application/json")
+
+        except Exception as e:
+            return HttpResponse(json.dumps({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
+
 
 else:
     # these are pages that are NOT available in interactive mode
+    def managedcontextprocessor(request):
+        return {
+            "projects": [],
+            "MANAGED" : toastermain.settings.MANAGED
+        }
+
     def newproject(request):
         raise Exception("page not available in interactive mode")
 
-    def project(request):
+    def project(request, pid):
+        raise Exception("page not available in interactive mode")
+
+    def xhr_projectbuild(request, pid):
         raise Exception("page not available in interactive mode")
+
+    def xhr_projectedit(request, pid):
+        raise Exception("page not available in interactive mode")
+
-- 
1.9.1


