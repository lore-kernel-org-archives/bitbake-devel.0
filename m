Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id B0DD577037
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 00:24:28 +0000 (UTC)
Received: by pacwi10 with SMTP id wi10so27087297pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Sep 2015 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=XxV9ZFo2EcWGQvbMpmV4xBXkjuoKKh045mAC4h3qM7g=;
	b=pyABkMS52kLIyZDPFLXbKR3ldy2JRSTIXousPUBWtqaAAUxuLirQbdWQau7x31wtkk
	e2MIpgG1L9gm00q318MoFg717i3/wcu1msQOtzbE0uIR/sep1gKDfvDXBB8bdES6YHfk
	UlYmu0zJExH3a0ww/utlLmPNeHRIsjHuCjmZ/mv3TFKd1c2yP+t53Tm2sS8tsTxh2qrm
	0mjvbV8EIIDcLwk3kjST89P89AnTwtgF0n7lwVooEHGL1cFQTdQO8gyoIdxvLbhpgHx6
	XKO7TO+uJqtbMB5YuN/jPx41pGckbh0pwRCS5nOw6TNOzAtb5szmbFusc8z/B7DrC4RT
	giXg==
X-Received: by 10.68.109.97 with SMTP id hr1mr60415569pbb.110.1441239868692;
	Wed, 02 Sep 2015 17:24:28 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw3sm22972308pbc.30.2015.09.02.17.24.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Sep 2015 17:24:28 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 17:25:08 -0700
Message-Id: <58a3a5476b6522c8e87484843fd81e391fd3a50a.1441239229.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
References: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
In-Reply-To: <cover.1441239229.git.avery.brian@gmail.com>
References: <cover.1441239229.git.avery.brian@gmail.com>
Subject: [PATCH 2/6] toaster: Improve how default project is identified and fetched
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
X-List-Received-Date: Thu, 03 Sep 2015 00:24:28 -0000

From: Elliot Smith <elliot.smith@intel.com>

Command line builds are associated with a "default project"
(as we currently require a build to have a project). This
acts as a container for builds initiated outside Toaster.
Currently, this project is marked as the default by its ID
being 0. However, this doesn't work with MySQL, as MySQL
won't allow 0 in a foreign key which references an
autoincrement field.

Instead, use an is_default field to track the default Project
for builds initiated outside Toaster.

Add a method to fetch this default project, rather than fetching
a project with a magic ID.

Add this default project in a migration, rather than as a side
effect of a get_or_create() style method.

Also ensure that builds always have a project explicitly assigned
to avoid any magic with a build's project foreign key defaulting to
0 (as it no longer does).

[YOCTO #7932]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py                       |   3 +-
 .../0025_auto__add_field_project_is_default.py     | 346 +++++++++++++++++++
 .../orm/migrations/0026_set_default_project.py     | 374 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  18 +-
 4 files changed, 735 insertions(+), 6 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0025_auto__add_field_project_is_default.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0026_set_default_project.py

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 09e8853..2d1ed51 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -145,13 +145,14 @@ class ORMWrapper(object):
             prj = Project.objects.get(pk = project_id)
 
         else:                           # this build was triggered by a legacy system, or command line interactive mode
-            prj, _ = Project.objects.get_or_create(pk=0, name="Default Project")
+            prj = Project.objects.get_default_project()
             logger.debug(1, "buildinfohelper: project is not specified, defaulting to %s" % prj)
 
 
         if buildrequest is not None:
             build = buildrequest.build
             logger.info("Updating existing build, with %s", build_info)
+            build.project = prj
             build.machine=build_info['machine']
             build.distro=build_info['distro']
             build.distro_version=build_info['distro_version']
diff --git a/lib/toaster/orm/migrations/0025_auto__add_field_project_is_default.py b/lib/toaster/orm/migrations/0025_auto__add_field_project_is_default.py
new file mode 100644
index 0000000..e76990d
--- /dev/null
+++ b/lib/toaster/orm/migrations/0025_auto__add_field_project_is_default.py
@@ -0,0 +1,346 @@
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
+        # work-around for http://south.aeracode.org/ticket/578:
+        # SQLite boolean fields aren't set to the correct default value
+        # (needs to be 0 or 1, rather than True or False)
+        default = False
+        if db.backend_name == 'sqlite3':
+           default = 0
+
+        # Adding field 'Project.is_default'
+        db.add_column(u'orm_project', 'is_default',
+                      self.gf('django.db.models.fields.BooleanField')(default=default),
+                      keep_default=False)
+
+
+    def backwards(self, orm):
+        # Deleting field 'Project.is_default'
+        db.delete_column(u'orm_project', 'is_default')
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
diff --git a/lib/toaster/orm/migrations/0026_set_default_project.py b/lib/toaster/orm/migrations/0026_set_default_project.py
new file mode 100644
index 0000000..6240abd
--- /dev/null
+++ b/lib/toaster/orm/migrations/0026_set_default_project.py
@@ -0,0 +1,374 @@
+# -*- coding: utf-8 -*-
+from south.utils import datetime_utils as datetime
+from south.db import db
+from south.v2 import SchemaMigration
+from django.db import models
+
+# data-only migration to set the is_default field correctly
+# across all projects, so it has the correct value on a single
+# record only; this will add or amend default project (marked with
+# is_default = True)
+class Migration(SchemaMigration):
+
+    no_dry_run = True
+
+    # work-around for http://south.aeracode.org/ticket/578:
+    # SQLite boolean fields aren't set to the correct default value
+    # when added to existing records (value needs to be 0 or 1, rather
+    # than True or False), so manually update that field for all
+    # existing records
+    def _sqlite_update_all_projects_is_default(self, orm):
+        if db.backend_name == 'sqlite3':
+            for project in orm.Project.objects.all():
+                project.is_default = 0
+                project.save()
+
+    def forwards(self, orm):
+        # fix is_default field
+        self._sqlite_update_all_projects_is_default(orm)
+
+        # now create or modify the default project
+        project = None
+
+        # check for existing default project with ID 0 which has
+        # already been added in code
+        projects = orm.Project.objects.filter(pk = 0)
+
+        if len(projects) == 1:
+            project = projects[0]
+        else:
+            # create default project
+            options = {
+                "name": "Command line builds",
+                "short_description": "Project for builds started outside Toaster"
+            }
+            project = orm.Project.objects.create(**options)
+
+        project.is_default = True
+        project.save()
+
+    def backwards(self, orm):
+        # don't do anything when reversing this migration, as we can safely
+        # keep any generated default project which has builds attached;
+        # it's just that the old code won't use that project as the
+        # container for any new builds, as it doesn't have an ID of 0
+        pass
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
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 58f76a8..e4d2e87 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -94,11 +94,15 @@ class ProjectManager(models.Manager):
     def create(self, *args, **kwargs):
         raise Exception("Invalid call to Project.objects.create. Use Project.objects.create_project() to create a project")
 
-    def get_or_create(self, **kwargs):
-        # allow project creation for default data
-        if 'pk' in kwargs and kwargs['pk'] == 0:
-            return super(ProjectManager, self).get_or_create(**kwargs)
-        raise Exception("Invalid call to Project.objects.get_or_create. Use Project.objects.create_project() to create a project")
+    # return single object with is_default = True
+    def get_default_project(self):
+        projects = super(ProjectManager, self).filter(is_default = True)
+        if len(projects) > 1:
+            raise Exception("Inconsistent project data: multiple " +
+                            "default projects (i.e. with is_default=True)")
+        elif len(projects) < 1:
+            raise Exception("Inconsistent project data: no default project found")
+        return projects[0]
 
 class Project(models.Model):
     search_allowed_fields = ['name', 'short_description', 'release__name', 'release__branch_name']
@@ -115,6 +119,10 @@ class Project(models.Model):
     user_id     = models.IntegerField(null = True)
     objects     = ProjectManager()
 
+    # set to True for the project which is the default container
+    # for builds initiated by the command line etc.
+    is_default  = models.BooleanField(default = False)
+
     def __unicode__(self):
         return "%s (Release %s, BBV %s)" % (self.name, self.release, self.bitbake_version)
 
-- 
1.9.1


