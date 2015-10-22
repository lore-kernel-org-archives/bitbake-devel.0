Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id CED1077035
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Oct 2015 10:22:50 +0000 (UTC)
Received: by wicll6 with SMTP id ll6so112097515wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Oct 2015 03:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=CmJGH2gNcx/A1/PJtjZGM74RknzeSE6JNSVvVxwgXEU=;
	b=QLYCFUuJXEhy1ZBf4iES8njKzaI16EELMntDtD+cA41V9OrJI3icaWaFKWS5rMkwRZ
	/jUxScJcJkPAyNStSRmGmQEhNOeOrrG4g6jS41YmNX2UTQCy42PsRZgpOu1nTHtvomTd
	mltkxsUuUzDM+AQXVuz4JdapewsVcOjKvEHY9NPeM/O0SW+NWAyh6hBJe9X/5RZANOR1
	yY0WzeJ4djww5kO0zPjkkRhZK0ZEZTY0Duh72tb6HZkzdH53n1Zd1UhkQ+vGJeLqfgsw
	aVAIoa75bMyi0p9V6aT4Vwvq8LATnL9Hq2dQ0Qq3YN8uKqLANbDUcxGwB9nWqvFNqVg8
	op1A==
X-Gm-Message-State: ALoCoQmq8e4HPLEagpUuqZX8AxTFLRPyJIJHKjKBMyyBhoJlV1ZGgTg4nkl4C1eyi+idesO6cyig
X-Received: by 10.180.182.84 with SMTP id ec20mr17071804wic.42.1445509369622; 
	Thu, 22 Oct 2015 03:22:49 -0700 (PDT)
Received: from dorado.Home (0543d9db.skybroadband.com. [5.67.217.219])
	by smtp.gmail.com with ESMTPSA id h7sm15959554wjz.7.2015.10.22.03.22.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 22 Oct 2015 03:22:48 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Oct 2015 11:22:28 +0100
Message-Id: <1445509348-5186-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC7C58C5F15EA@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC7C58C5F15EA@xmail3.se.axis.com>
Subject: [PATCH v2] toaster: orm Fix restrictive LogMessage message length
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
X-List-Received-Date: Thu, 22 Oct 2015 10:22:51 -0000

Log messages can be quite long so use a TextField rather than a char
field with max length of 240. mySQL is especially picky about field
lengths and will cause an exception if the log is too long.

[YOCTO #8475]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 .../0028_auto__chg_field_logmessage_message.py     | 345 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |   2 +-
 2 files changed, 346 insertions(+), 1 deletion(-)
 create mode 100644 lib/toaster/orm/migrations/0028_auto__chg_field_logmessage_message.py

diff --git a/lib/toaster/orm/migrations/0028_auto__chg_field_logmessage_message.py b/lib/toaster/orm/migrations/0028_auto__chg_field_logmessage_message.py
new file mode 100644
index 0000000..a2f8661
--- /dev/null
+++ b/lib/toaster/orm/migrations/0028_auto__chg_field_logmessage_message.py
@@ -0,0 +1,345 @@
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
+        # Changing field 'LogMessage.message'
+        db.alter_column(u'orm_logmessage', 'message', self.gf('django.db.models.fields.TextField')(null=True))
+
+    def backwards(self, orm):
+
+        # Changing field 'LogMessage.message'
+        db.alter_column(u'orm_logmessage', 'message', self.gf('django.db.models.fields.CharField')(default='', max_length=240))
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
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'machine': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'outcome': ('django.db.models.fields.IntegerField', [], {'default': '2'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'started_on': ('django.db.models.fields.DateTimeField', [], {})
+        },
+        u'orm.buildartifact': {
+            'Meta': {'object_name': 'BuildArtifact'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']"}),
+            'file_name': ('django.db.models.fields.FilePathField', [], {'max_length': '100'}),
+            'file_size': ('django.db.models.fields.IntegerField', [], {}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
+        },
+        u'orm.customimagerecipe': {
+            'Meta': {'unique_together': "(('name', 'project'),)", 'object_name': 'CustomImageRecipe'},
+            'base_recipe': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Recipe']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'packages': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['orm.Package']", 'symmetrical': 'False'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"})
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
+            'local_path': ('django.db.models.fields.FilePathField', [], {'default': "'/'", 'max_length': '1024'}),
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
+            'message': ('django.db.models.fields.TextField', [], {'null': 'True', 'blank': 'True'}),
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
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']", 'null': 'True'}),
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
+            'is_default': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
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
+            'Meta': {'unique_together': "(('layer_version', 'file_path', 'pathflags'),)", 'object_name': 'Recipe'},
+            'bugtracker': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'file_path': ('django.db.models.fields.FilePathField', [], {'max_length': '255'}),
+            'homepage': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'is_image': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
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
+            'target': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'task': ('django.db.models.fields.CharField', [], {'max_length': '100', 'null': 'True'})
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
\ No newline at end of file
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index a784b1b..3832905 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1296,7 +1296,7 @@ class LogMessage(models.Model):
     build = models.ForeignKey(Build)
     task  = models.ForeignKey(Task, blank = True, null=True)
     level = models.IntegerField(choices=LOG_LEVEL, default=INFO)
-    message = models.CharField(max_length=240)
+    message = models.TextField(blank=True, null=True)
     pathname = models.FilePathField(max_length=255, blank=True)
     lineno = models.IntegerField(null=True)
 
-- 
2.1.4


