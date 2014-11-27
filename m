Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 8B6E67239E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:10 +0000 (UTC)
Received: by mail-wi0-f174.google.com with SMTP id h11so16402336wiw.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=0PtKuaNAIMXQw2MZp7Y7aLHehJKAkUuiKpXTm5UZXes=;
	b=EjGA8a7ADSToIarPdhnWXd4DMwiy/iX6n/3bUGx+kpSGteYKSEXLWT7hJzdeHENIk7
	u0vdjs1//13p2KsKB8r3PTQ9MxsNadzCO7llQDeli3wbVV1aiLm4zfJlJSi5Uslh3nvO
	ixVHeuD2Yn7k09Zl5GQ8fh+SNgrG7dwCJ47I6NUKkPiNCImp5Mnv3VLz1xPIaF9FAjKL
	K5zPGluodJ5oNGCYMc1Z+vUgRgPGuahfetngw/VOyFEFUjqvXZ8JoUCoQMhuHMoMnIEa
	nKJhyUb7uCJV+bGnSfLt28XZz7n2VZelTmP2iZtd1tttDtI/c/u6Vsz9DYOXEJBI38JU
	tTew==
X-Gm-Message-State: ALoCoQltchxph+fao75h8xY1/q8hnfw3Jy8mFVrL3rufrALVgLPE8+LwotFMD/aEaEleYAWLlgq/
X-Received: by 10.180.210.226 with SMTP id mx2mr52183048wic.42.1417108090825; 
	Thu, 27 Nov 2014 09:08:10 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gs9sm11492329wjc.47.2014.11.27.09.08.07 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id F31D8563E83; Thu, 27 Nov 2014 17:08:06 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:07:54 +0000
Message-Id: <e1f7ec868b0702dfd27d5708581c134aaa6f4ae8.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 03/14] toastergui: update layer search criteria
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In order to accomodate the designs around imported layer,
we add a "project" field for in the layer versions.

The field must be set if and only if the layer is manually
imported in the project. This will prevent information leakage
between different projects.

The views have been updated to perform relevant layer queries
in a single location.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../0018_auto__add_field_layer_version_project.py  | 331 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |   4 +-
 lib/toaster/toastergui/views.py                    |  59 ++--
 3 files changed, 371 insertions(+), 23 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0018_auto__add_field_layer_version_project.py

diff --git a/lib/toaster/orm/migrations/0018_auto__add_field_layer_version_project.py b/lib/toaster/orm/migrations/0018_auto__add_field_layer_version_project.py
new file mode 100644
index 0000000..7284bb8
--- /dev/null
+++ b/lib/toaster/orm/migrations/0018_auto__add_field_layer_version_project.py
@@ -0,0 +1,331 @@
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
+        # Adding field 'Layer_Version.project'
+        db.add_column(u'orm_layer_version', 'project',
+                      self.gf('django.db.models.fields.related.ForeignKey')(default=None, to=orm['orm.Project'], null=True),
+                      keep_default=False)
+
+
+    def backwards(self, orm):
+        # Deleting field 'Layer_Version.project'
+        db.delete_column(u'orm_layer_version', 'project_id')
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
+            'bitbake_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.BitbakeVersion']"}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'release': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Release']"}),
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
+            'Meta': {'unique_together': "(('layer_version', 'file_path'),)", 'object_name': 'Recipe'},
+            'bugtracker': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'file_path': ('django.db.models.fields.FilePathField', [], {'max_length': '255'}),
+            'homepage': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'recipe_layer_version'", 'to': u"orm['orm.Layer_Version']"}),
+            'license': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
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
index 99cc695..364b215 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -843,6 +843,8 @@ class Layer_Version(models.Model):
     dirpath = models.CharField(max_length=255, null = True, default = None)          # LayerBranch.vcs_subdir
     priority = models.IntegerField(default = 0)         # if -1, this is a default layer
 
+    project = models.ForeignKey('Project', null = True, default = None)   # Set if this layer is project-specific; always set for imported layers, and project-set branches
+
     # code lifted, with adaptations, from the layerindex-web application https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/
     def _handle_url_path(self, base_url, path):
         import re
@@ -902,7 +904,7 @@ class Layer_Version(models.Model):
         return sorted(
                 Layer_Version.objects.filter( layer__name = self.layer.name, up_branch__name = self.up_branch.name ),
                 key = lambda x: _get_ls_priority(x.layer_source),
-                reverse = False)
+                reverse = True)
 
 
     def __unicode__(self):
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a0dcf87..11c373a 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1935,7 +1935,21 @@ if toastermain.settings.MANAGED:
 
         raise Exception("Invalid HTTP method for this page")
 
+    # returns a queryset of compatible layers for a project
+    def _compatible_layerversions_for_project(prj, release = None, layer_name = None):
+        if release == None:
+            release = prj.release
+        # layers on the same branch or layers specifically set for this project
+        return Layer_Version.objects.filter((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = prj))
 
+
+    # returns the equivalence group for all the layers currently set in the project
+    def _project_equivalent_layerversions(prj):
+        return reduce(lambda x, y: list(x) + list(y),
+                    # take all equivalent layers for each entry
+                    map(lambda x: x.layercommit.get_equivalents_wpriority(prj), prj.projectlayer_set.all()) , [])
+
+    # returns a list for most recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
     def _project_recent_build_list(prj):
         return map(lambda x: {
                 "id":  x.pk,
@@ -2101,7 +2115,7 @@ if toastermain.settings.MANAGED:
                 for i in prj.projectlayer_set.all():
                     # find and add a similarly-named layer on the new branch
                     try:
-                        lv = Layer_Version.objects.filter(layer__name = i.layercommit.layer.name, up_branch__name = prj.release.branch_name)[0].get_equivalents_wpriority(prj)[0]
+                        lv = _compatible_layerversions_for_project(prj).filter(layer__name = i.layer.name).get_equivalents_wpriority(prj)[0]
                         ProjectLayer.objects.get_or_create(project = prj, layercommit = lv)
                     except IndexError:
                         pass
@@ -2140,30 +2154,32 @@ if toastermain.settings.MANAGED:
 			else:
 				raise Exception("No valid project selected")
 
-            # returns layers for current project release that are not in the project set
+
+            def _lv_to_dict(x):
+                return {"id": x.pk, "name": x.layer.name, 
+                        "detail": "(" + x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.up_branch.name+")"),
+                        "giturl": x.layer.vcs_url, "layerdetailurl" : reverse('layerdetails', args=(x.pk,))}
+
+
+            # returns layers for current project release that are not in the project set, matching the name
             if request.GET['type'] == "layers":
-                queryset_all = Layer_Version.objects.filter(layer__name__icontains=request.GET.get('value',''))
-                queryset_all = queryset_all.filter(up_branch__name= prj.release.branch_name).exclude(pk__in = [x.id for x in reduce(lambda x, y: list(x) + list(y), map(lambda x: x.layercommit.get_equivalents_wpriority(prj), prj.projectlayer_set.all()))])
+                queryset_all = _compatible_layerversions_for_project(prj).filter(layer__name__icontains=request.GET.get('value',''))
+
+                queryset_all = queryset_all.exclude(pk__in = [x.id for x in _project_equivalent_layerversions(prj)])
 
                 queryset_all = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all[:8]])
 
-                return HttpResponse(jsonfilter( { "error":"ok",
-                    "list" : map( lambda x: {"id": x.pk, "name": "%s" % (x.layer.name, ), "detail": "(" + x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.up_branch.name+")")},
-                            queryset_all)
-                    }), content_type = "application/json")
+                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict, queryset_all) }), content_type = "application/json")
 
 
             # returns layer dependencies for a layer, excluding current project layers
             if request.GET['type'] == "layerdeps":
                 queryset_all = LayerVersionDependency.objects.filter(layer_version_id = request.GET['value'])
-                queryset_all = queryset_all.exclude(depends_on__in = reduce(lambda x, y: list(x) + list(y), map(lambda x: x.layercommit.get_equivalents_wpriority(prj), prj.projectlayer_set.all())))
+                queryset_all = queryset_all.exclude(depends_on__in = _project_equivalent_layerversions(prj))
                 queryset_all.order_by("-up_id");
 
                 return HttpResponse(jsonfilter( { "error":"ok",
-                    "list" : map(
-                        lambda x: {"id": x.pk, "name": x.layer.name, "detail": "(" + x.layer.layer_source.name + (")" if x.up_branch == None else " | "+x.up_branch.name+")"),
-                                   "giturl": x.layer.vcs_url, "layerdetailurl" : reverse('layerdetails', args=(x.pk,))},
-                        map(lambda x: x.depends_on.get_equivalents_wpriority(prj)[0], queryset_all))
+                    "list" : map( _lv_to_dict,  map(lambda x: x.depends_on.get_equivalents_wpriority(prj)[0], queryset_all))
                     }), content_type = "application/json")
 
 
@@ -2174,20 +2190,20 @@ if toastermain.settings.MANAGED:
 
                 retval = []
                 for i in prj.projectlayer_set.all():
-                    lv = Layer_Version.objects.filter(layer__name = i.layercommit.layer.name, up_branch__name = Release.objects.get(pk=request.GET['value']).branch_name)
-                    if lv.count() < 1:     # there is no layer_version with the new release id, and the same name
+                    lv = _compatible_layerversions_for_project(prj, release = Release.objects.get(pk=request.GET['value']))
+                    # there is no layer_version with the new release id, and the same name
+                    if lv.count() < 1:
                         retval.append(i)
 
                 return HttpResponse(jsonfilter( {"error":"ok",
-                    "list": map(
-                        lambda x: {"id": x.layercommit.pk, "name": x.layercommit.layer.name, "detail": "(" + x.layercommit.layer.layer_source.name + (")" if x.layercommit.up_branch == None else " | "+x.layercommit.up_branch.name+")")},
-                        retval) }), content_type = "application/json")
+                    "list" : map( _lv_to_dict,  map(lambda x: x.layercommit, retval ))
+                    }), content_type = "application/json")
 
 
             # returns targets provided by current project layers
             if request.GET['type'] == "targets":
                 queryset_all = Recipe.objects.all()
-                queryset_all = queryset_all.filter(layer_version__in = reduce(lambda x, y: list(x) + list(y), map(lambda x: x.layercommit.get_equivalents_wpriority(prj), ProjectLayer.objects.filter(project = prj))))
+                queryset_all = queryset_all.filter(layer_version__in = reduce(lambda x, y: list(x) + list(y), map(lambda x: x.layercommit.get_equivalents_wpriority(prj), prj.projectlayer_set.all()), []))
                 return HttpResponse(jsonfilter({ "error":"ok",
                     "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
                         queryset_all.filter(name__icontains=request.GET.get('value',''))[:8]),
@@ -2243,10 +2259,9 @@ if toastermain.settings.MANAGED:
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, Layer_Version)
 
-        queryset_all = Layer_Version.objects.all()
-
         prj = Project.objects.get(pk = request.session['project_id'])
-        queryset_all = queryset_all.filter(up_branch__name = prj.release.branch_name)
+
+        queryset_all = _compatible_layerversions_for_project(prj)
 
         queryset_all = _get_queryset(Layer_Version, queryset_all, filter_string, search_term, ordering_string, '-layer__name')
 
-- 
1.9.1


