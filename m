Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id B3F9975692
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:15:03 +0000 (UTC)
Received: by wgbgq6 with SMTP id gq6so37776187wgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ulZ97S9crdZ4hD5ddIqBcVEE3dA8vE3pelEP+u+t28k=;
	b=VjY+jMzy3vtZutiesPFMaXmbvS6JOnVca7Ij736m+V5l1Fo+ZTnbd+xXmRBwJDuPXg
	pl21u6jU6CTaxNvez0xSq05Ol1BtLqDsz+pxtGbyrlKJyWI7dM7Z0wTBF4GNdBut7Qb4
	C9y+geuJW2MDkZXhm3Yfg1SB4qodO4enSQAz5DK/WCIOlzBK3KTs+K+HE1dAQmQ1ruw6
	gM5xAnTpSjaiTi6f8GBrcfdsnM7Tqc9Me2kzhcUd5hXq44B9W27sdXLRmil3AsWFKIss
	l268dDI8pJN4deMCTNcgXFAN5PQtQ+IgM8iAFeEZjQ+Zbtksh9cfsGOI64AGvTk2QOYm
	dVjw==
X-Gm-Message-State: ALoCoQkags3qEd4DHVofyeragdWjQh4tALEYDYgPC/pi2EgYOwuJwmt6ww0Y1huh2cyZIneQUOs3
X-Received: by 10.194.120.230 with SMTP id lf6mr5840684wjb.41.1432822504262;
	Thu, 28 May 2015 07:15:04 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id di9sm8755602wib.16.2015.05.28.07.15.02
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:15:03 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BAE9A5601CB; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:13:58 +0100
Message-Id: <0bb6f3aac383eac3a67b99e467b5e98abd070b24.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 04/22] toaster logger: assign projects to all builds
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
X-List-Received-Date: Thu, 28 May 2015 14:15:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Bitbake logger now sets a default project if the TOASTER_BRBE
or TOASTER_PROJECT Bitbake variables are not set.

This a necessary step in getting all builds under a project,
as to unify the MANAGED and interactive modes.

Other small fixes are included, related to the size of the
fields in the database.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       |  37 ++-
 ...ect__chg_field_project_bitbake_version__chg_.py | 368 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  15 +-
 lib/toaster/orm/views.py                           |   2 +-
 4 files changed, 405 insertions(+), 17 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 6812a52..3ea842c 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -31,6 +31,9 @@ from toaster.orm.models import Variable, VariableHistory
 from toaster.orm.models import Package, Package_File, Target_Installed_Package, Target_File
 from toaster.orm.models import Task_Dependency, Package_Dependency
 from toaster.orm.models import Recipe_Dependency
+
+from toaster.orm.models import Project
+
 from bb.msg import BBLogFormatter as format
 from django.db import models
 from pprint import pformat
@@ -103,7 +106,7 @@ class ORMWrapper(object):
 
         return vars(self)[dictname][key]
 
-    def create_build_object(self, build_info, brbe):
+    def create_build_object(self, build_info, brbe, project_id):
         assert 'machine' in build_info
         assert 'distro' in build_info
         assert 'distro_version' in build_info
@@ -112,7 +115,26 @@ class ORMWrapper(object):
         assert 'build_name' in build_info
         assert 'bitbake_version' in build_info
 
+        prj = None
+        buildrequest = None
+        if brbe is not None:            # this build was triggered by a request from a user
+            logger.debug(1, "buildinfohelper: brbe is %s" % brbe)
+            from bldcontrol.models import BuildEnvironment, BuildRequest
+            br, be = brbe.split(":")
+            buildrequest = BuildRequest.objects.get(pk = br)
+            prj = buildrequest.project
+
+        elif project_id is not None:    # this build was triggered by an external system for a specific project
+            logger.debug(1, "buildinfohelper: project is %s" % prj)
+            prj = Project.objects.get(pk = project_id)
+
+        else:                           # this build was triggered by a legacy system, or command line interactive mode
+            prj, created = Project.objects.get_or_create(pk=0, name="Default Project")
+            logger.debug(1, "buildinfohelper: project is not specified, defaulting to %s" % prj)
+
+
         build = Build.objects.create(
+                                    project = prj,
                                     machine=build_info['machine'],
                                     distro=build_info['distro'],
                                     distro_version=build_info['distro_version'],
@@ -123,17 +145,11 @@ class ORMWrapper(object):
                                     bitbake_version=build_info['bitbake_version'])
 
         logger.debug(1, "buildinfohelper: build is created %s" % build)
-        if brbe is not None:
-            logger.debug(1, "buildinfohelper: brbe is %s" % brbe)
-            from bldcontrol.models import BuildEnvironment, BuildRequest
-            br, be = brbe.split(":")
 
-            buildrequest = BuildRequest.objects.get(pk = br)
+        if buildrequest is not None:
             buildrequest.build = build
             buildrequest.save()
 
-            build.project_id = buildrequest.project_id
-            build.save()
         return build
 
     def create_target_objects(self, target_info):
@@ -638,6 +654,7 @@ class BuildInfoHelper(object):
         self.has_build_history = has_build_history
         self.tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
         self.brbe    = self.server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
+        self.project = self.server.runCommand(["getVariable", "TOASTER_PROJECT"])[0]
         logger.debug(1, "buildinfohelper: Build info helper inited %s" % vars(self))
 
 
@@ -804,7 +821,7 @@ class BuildInfoHelper(object):
         assert '_pkgs' in vars(event)
         build_information = self._get_build_information()
 
-        build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe)
+        build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe, self.project)
 
         self.internal_state['build'] = build_obj
 
@@ -1233,7 +1250,7 @@ class BuildInfoHelper(object):
                 logger.debug(1, "buildinfohelper: Saving stored event %s " % tempevent)
                 self.store_log_event(tempevent)
             else:
-                logger.error("buildinfohelper: Events not saved: %s" % self.internal_state['backlog'])
+                logger.info("buildinfohelper: All events saved")
                 del self.internal_state['backlog']
 
         log_information = {}
diff --git a/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py b/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
new file mode 100644
index 0000000..b82cc8d
--- /dev/null
+++ b/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
@@ -0,0 +1,368 @@
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
+        # Changing field 'Build.project'
+        db.alter_column(u'orm_build', 'project_id', self.gf('django.db.models.fields.related.ForeignKey')(default=0, to=orm['orm.Project']))
+
+        # Changing field 'Project.bitbake_version'
+        db.alter_column(u'orm_project', 'bitbake_version_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.BitbakeVersion'], null=True))
+
+        # Changing field 'Project.release'
+        db.alter_column(u'orm_project', 'release_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Release'], null=True))
+
+        # Changing field 'Task.cpu_usage'
+        db.alter_column(u'orm_task', 'cpu_usage', self.gf('django.db.models.fields.DecimalField')(null=True, max_digits=8, decimal_places=2))
+
+        # Changing field 'Task.elapsed_time'
+        db.alter_column(u'orm_task', 'elapsed_time', self.gf('django.db.models.fields.DecimalField')(null=True, max_digits=8, decimal_places=2))
+
+    def backwards(self, orm):
+
+        # Changing field 'Build.project'
+        db.alter_column(u'orm_build', 'project_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Project'], null=True))
+
+        # User chose to not deal with backwards NULL issues for 'Project.bitbake_version'
+        raise RuntimeError("Cannot reverse this migration. 'Project.bitbake_version' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration
+        # Changing field 'Project.bitbake_version'
+        db.alter_column(u'orm_project', 'bitbake_version_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.BitbakeVersion']))
+
+        # User chose to not deal with backwards NULL issues for 'Project.release'
+        raise RuntimeError("Cannot reverse this migration. 'Project.release' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration
+        # Changing field 'Project.release'
+        db.alter_column(u'orm_project', 'release_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Release']))
+
+        # Changing field 'Task.cpu_usage'
+        db.alter_column(u'orm_task', 'cpu_usage', self.gf('django.db.models.fields.DecimalField')(null=True, max_digits=6, decimal_places=2))
+
+        # Changing field 'Task.elapsed_time'
+        db.alter_column(u'orm_task', 'elapsed_time', self.gf('django.db.models.fields.DecimalField')(null=True, max_digits=6, decimal_places=2))
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
index 29ede65..0f72576 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -81,15 +81,18 @@ class ProjectManager(models.Manager):
     def create(self, *args, **kwargs):
         raise Exception("Invalid call to Project.objects.create. Use Project.objects.create_project() to create a project")
 
-    def get_or_create(self, *args, **kwargs):
+    def get_or_create(self, **kwargs):
+        # allow project creation for default data
+        if 'pk' in kwargs and kwargs['pk'] == 0:
+            return super(ProjectManager, self).get_or_create(**kwargs)
         raise Exception("Invalid call to Project.objects.get_or_create. Use Project.objects.create_project() to create a project")
 
 class Project(models.Model):
     search_allowed_fields = ['name', 'short_description', 'release__name', 'release__branch_name']
     name = models.CharField(max_length=100)
     short_description = models.CharField(max_length=50, blank=True)
-    bitbake_version = models.ForeignKey('BitbakeVersion')
-    release     = models.ForeignKey("Release")
+    bitbake_version = models.ForeignKey('BitbakeVersion', null=True)
+    release     = models.ForeignKey("Release", null=True)
     created     = models.DateTimeField(auto_now_add = True)
     updated     = models.DateTimeField(auto_now = True)
     # This is a horrible hack; since Toaster has no "User" model available when
@@ -223,7 +226,7 @@ class Build(models.Model):
 
     search_allowed_fields = ['machine', 'cooker_log_path', "target__target", "target__target_image_file__file_name"]
 
-    project = models.ForeignKey(Project, null = True)
+    project = models.ForeignKey(Project)            # must have a project
     machine = models.CharField(max_length=100)
     distro = models.CharField(max_length=100)
     distro_version = models.CharField(max_length=100)
@@ -435,8 +438,8 @@ class Task(models.Model):
     script_type = models.IntegerField(choices=TASK_CODING, default=CODING_NA)
     line_number = models.IntegerField(default=0)
     disk_io = models.IntegerField(null=True)
-    cpu_usage = models.DecimalField(max_digits=6, decimal_places=2, null=True)
-    elapsed_time = models.DecimalField(max_digits=6, decimal_places=2, null=True)
+    cpu_usage = models.DecimalField(max_digits=8, decimal_places=2, null=True)
+    elapsed_time = models.DecimalField(max_digits=8, decimal_places=2, null=True)
     sstate_result = models.IntegerField(choices=SSTATE_RESULT, default=SSTATE_NA)
     message = models.CharField(max_length=240)
     logfile = models.FilePathField(max_length=255, blank=True)
diff --git a/lib/toaster/orm/views.py b/lib/toaster/orm/views.py
index 61d14f9..f32fa4d 100644
--- a/lib/toaster/orm/views.py
+++ b/lib/toaster/orm/views.py
@@ -37,7 +37,7 @@ from django.views.decorators.csrf import csrf_exempt
 def eventfile(request):
     """ Receives a file by POST, and runs toaster-eventreply on this file """
     if request.method != "POST":
-        return HttpResponseBadRequest("This API only accepts POST requests. Post a file with:\n\ncurl -F eventlog=@bitbake_eventlog.json http[s]://[server-address]/orm/eventfile\n", content_type="text/plain;utf8")
+        return HttpResponseBadRequest("This API only accepts POST requests. Post a file with:\n\ncurl -F eventlog=@bitbake_eventlog.json %s\n" % request.build_absolute_uri(reverse('eventfile')), content_type="text/plain;utf8")
 
     # write temporary file
     (handle, abstemppath) = tempfile.mkstemp(dir="/tmp/")
-- 
1.9.1


