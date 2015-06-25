Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 8934075AC3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:27 +0000 (UTC)
Received: by wiwl6 with SMTP id l6so13736122wiw.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=DGspX20N9I6dmcsJJrR1sntRfrOig4B0J6bkeb+ZBio=;
	b=AIwXQO/qS2G/Uh7tPx5+3oMKEIRLon2TejMOZ+sjKTvhYP7VLWrx54CSHmtn0nkDbb
	AtTI42FdJ/hv0n45wyaWPgkL33krplNoGRjwevtDX3id3sgGGQVYpERHA0cxQseWmprY
	TWQEfaRZ2VjEyd8sbNvMjVdCP177XoEm90ZNJ/c59V7hlaFeozilsj2uNPpbHjDLZhKp
	VsDuGxfVB2CHSnZFsX/zJcOssj8bMJZBNOVmsBKjMFN82aBOmGfZfzWlEHVGNYeqgyQn
	E0f85mQMamk4N3nkQCaXnSxxgasPDCy23OIOyo0RcfWEr6nLcHl3GW9YjCdCB1z4ZgbF
	XJdA==
X-Gm-Message-State: ALoCoQkDUBkAKcr41x8Fd87XCDTn4GFSKo/zpyAVtcWsBOjRDo88ILIXRAzUmJUDM7uNIfSwuLs6
X-Received: by 10.180.87.199 with SMTP id ba7mr4515028wib.81.1435228468618;
	Thu, 25 Jun 2015 03:34:28 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	hn7sm45027046wjc.16.2015.06.25.03.34.27
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:27 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CCDED562486; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:46 +0100
Message-Id: <57f790b0c56297af8c83d5def8461bd5d61fe4af.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 09/23] toaster: fixes after replacing BuildRequest with Build
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:28 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a set of fixes that repair the interface after
we switched from displaying BuildRequest data to Build data
in the formerly "managed" mode.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/toasterui.py                             |  24 +-
 lib/toaster/bldcontrol/localhostbecontroller.py    |   2 +-
 .../bldcontrol/management/commands/runbuilds.py    |   7 +-
 lib/toaster/bldcontrol/models.py                   |   3 +
 ...ect__chg_field_project_bitbake_version__chg_.py |   5 +-
 ...k__add_field_layer_version_local_path__del_f.py | 343 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |   8 +-
 lib/toaster/toastergui/static/js/projectapp.js     |   4 +-
 lib/toaster/toastergui/templates/project.html      |   4 +-
 lib/toaster/toastergui/views.py                    |   6 +-
 10 files changed, 378 insertions(+), 28 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0022_auto__add_field_target_task__add_field_layer_version_local_path__del_f.py

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 3054048..9c59fd0 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -43,7 +43,7 @@ import xmlrpclib
 
 featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES, bb.cooker.CookerFeatures.SEND_DEPENDS_TREE, bb.cooker.CookerFeatures.BASEDATASTORE_TRACKING, bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
 
-logger = logging.getLogger("BitBake")
+logger = logging.getLogger("ToasterLogger")
 interactive = sys.stdout.isatty()
 
 
@@ -66,7 +66,6 @@ def _log_settings_from_server(server):
 
 
 def main(server, eventHandler, params ):
-
     helper = uihelper.BBUIHelper()
 
     console = logging.StreamHandler(sys.stdout)
@@ -235,12 +234,18 @@ def main(server, eventHandler, params ):
             if isinstance(event, (bb.event.TreeDataPreparationStarted, bb.event.TreeDataPreparationCompleted)):
                 continue
 
-            if isinstance(event, (bb.event.BuildCompleted)):
+            if isinstance(event, (bb.event.BuildCompleted, bb.command.CommandFailed)):
+
+                if (isinstance(event, bb.command.CommandFailed)):
+                    errors += 1
+                    errorcode = 1
+                    logger.error("Command execution failed: %s", event.error)
+
                 # update the build info helper on BuildCompleted, not on CommandXXX
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 buildinfohelper.close(errorcode)
                 # mark the log output; controllers may kill the toasterUI after seeing this log
-                logger.info("ToasterUI build done")
+                logger.info("ToasterUI build done 1, brbe: %s" % buildinfohelper.brbe )
 
                 # we start a new build info
                 if buildinfohelper.brbe is not None:
@@ -254,22 +259,13 @@ def main(server, eventHandler, params ):
                     taskfailures = []
                     buildinfohelper = BuildInfoHelper(server, build_history_enabled)
 
+                logger.info("ToasterUI build done 2")
                 continue
 
             if isinstance(event, (bb.command.CommandCompleted,
                                   bb.command.CommandFailed,
                                   bb.command.CommandExit)):
                 errorcode = 0
-                if (isinstance(event, bb.command.CommandFailed)):
-                    event.levelno = format.ERROR
-                    event.msg = "Command Failed " + event.error
-                    event.pathname = ""
-                    event.lineno = 0
-                    buildinfohelper.store_log_event(event)
-                    errors += 1
-                    errorcode = 1
-                    logger.error("Command execution failed: %s", event.error)
-
 
                 continue
 
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index d0f8632..ad0a561 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -322,7 +322,7 @@ class LocalhostBEController(BuildEnvironmentController):
     def triggerBuild(self, bitbake, layers, variables, targets):
         # set up the buid environment with the needed layers
         self.setLayers(bitbake, layers)
-        self.writeConfFile("conf/toaster-pre.conf", )
+        self.writeConfFile("conf/toaster-pre.conf", variables)
         self.writeConfFile("conf/toaster.conf", raw = "INHERIT+=\"toaster buildhistory\"")
 
         # get the bb server running with the build req id and build env id
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index da7d4af..bcf3b04 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -6,7 +6,7 @@ from bldcontrol.models import BuildRequest, BuildEnvironment, BRError, BRVariabl
 import os
 import logging
 
-logger = logging.getLogger("toaster")
+logger = logging.getLogger("ToasterScheduler")
 
 class Command(NoArgsCommand):
     args    = ""
@@ -35,7 +35,7 @@ class Command(NoArgsCommand):
                 # select the build environment and the request to build
                 br = self._selectBuildRequest()
             except IndexError as e:
-                # logger.debug("runbuilds: No build request")
+                #logger.debug("runbuilds: No build request")
                 return
             try:
                 bec = self._selectBuildEnvironment()
@@ -113,10 +113,11 @@ class Command(NoArgsCommand):
 
         # update all Builds that failed to start
 
-        for br in BuildRequest.objects.filter(state = BuildRequest.REQ_FAILED):
+        for br in BuildRequest.objects.filter(state = BuildRequest.REQ_FAILED, build__outcome = Build.IN_PROGRESS):
             br.build.outcome = Build.FAILED
             # transpose the launch errors in ToasterExceptions
             for brerror in br.brerror_set.all():
+                logger.debug("Saving error %s" % brerror)
                 LogMessage.objects.create(build = br.build, level = LogMessage.EXCEPTION, message = brerror.errmsg)
             br.build.save()
 
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index b789446..6f40866 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -159,3 +159,6 @@ class BRError(models.Model):
     errtype     = models.CharField(max_length=100)
     errmsg      = models.TextField()
     traceback   = models.TextField()
+
+    def __str__(self):
+        return "%s (%s)" % (self.errmsg, self.req)
diff --git a/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py b/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
index b82cc8d..924a5c4 100644
--- a/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
+++ b/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
@@ -105,7 +105,6 @@ class Migration(SchemaMigration):
             u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
             'layer_index_url': ('django.db.models.fields.URLField', [], {'max_length': '200'}),
             'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
-            'local_path': ('django.db.models.fields.FilePathField', [], {'default': 'None', 'max_length': '255', 'null': 'True'}),
             'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
             'summary': ('django.db.models.fields.TextField', [], {'default': 'None', 'null': 'True'}),
             'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
@@ -124,6 +123,7 @@ class Migration(SchemaMigration):
             u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
             'layer': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'layer_version_layer'", 'to': u"orm['orm.Layer']"}),
             'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'local_path': ('django.db.models.fields.FilePathField', [], {'default': "'/'", 'max_length': '1024'}),
             'priority': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
             'project': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.Project']", 'null': 'True'}),
             'up_branch': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.Branch']", 'null': 'True'}),
@@ -229,7 +229,7 @@ class Migration(SchemaMigration):
             'value': ('django.db.models.fields.TextField', [], {'blank': 'True'})
         },
         u'orm.recipe': {
-            'Meta': {'unique_together': "(('layer_version', 'file_path'),)", 'object_name': 'Recipe'},
+            'Meta': {'unique_together': "(('layer_version', 'file_path', 'pathflags'),)", 'object_name': 'Recipe'},
             'bugtracker': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
             'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
             'file_path': ('django.db.models.fields.FilePathField', [], {'max_length': '255'}),
@@ -239,6 +239,7 @@ class Migration(SchemaMigration):
             'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'recipe_layer_version'", 'to': u"orm['orm.Layer_Version']"}),
             'license': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
             'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'pathflags': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
             'section': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
             'summary': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
             'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
diff --git a/lib/toaster/orm/migrations/0022_auto__add_field_target_task__add_field_layer_version_local_path__del_f.py b/lib/toaster/orm/migrations/0022_auto__add_field_target_task__add_field_layer_version_local_path__del_f.py
new file mode 100644
index 0000000..3dec391
--- /dev/null
+++ b/lib/toaster/orm/migrations/0022_auto__add_field_target_task__add_field_layer_version_local_path__del_f.py
@@ -0,0 +1,343 @@
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
+        # Adding field 'Target.task'
+        db.add_column(u'orm_target', 'task',
+                      self.gf('django.db.models.fields.CharField')(max_length=100, null=True),
+                      keep_default=False)
+
+
+
+
+
+    def backwards(self, orm):
+        # Deleting field 'Target.task'
+        db.delete_column(u'orm_target', 'task')
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
index d97eadb..e93629b 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -283,8 +283,9 @@ class Build(models.Model):
 
 
     def get_current_status(self):
-        if self.outcome == Build.IN_PROGRESS and self.build_name == "":
-            return "Queued"
+        from bldcontrol.models import BuildRequest
+        if self.outcome == Build.IN_PROGRESS and self.buildrequest.state != BuildRequest.REQ_INPROGRESS:
+            return self.buildrequest.get_state_display()
         return self.get_outcome_display()
 
     def __str__(self):
@@ -1168,6 +1169,9 @@ class LogMessage(models.Model):
     pathname = models.FilePathField(max_length=255, blank=True)
     lineno = models.IntegerField(null=True)
 
+    def __str__(self):
+        return "%s %s %s" % (self.get_level_display(), self.message, self.build)
+
 def invalidate_cache(**kwargs):
     from django.core.cache import cache
     try:
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 40e2e1f..ea44bf3 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -132,8 +132,8 @@ projectApp.filter('timediff', function() {
         var seconds = parseInt(input);
         var minutes = Math.floor(seconds / 60);
         seconds = seconds - minutes * 60;
-        var hours = Math.floor(seconds / 3600);
-        seconds = seconds - hours * 3600;
+        var hours = Math.floor(minutes / 60);
+        minutes = minutes - hours * 60;
         return pad(hours) + ":" + pad(minutes) + ":" + pad(seconds);
     };
 });
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 1a8991f..b5d97cb 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -145,7 +145,7 @@ vim: expandtab tabstop=2
 
   <a id="buildslist"></a>
   <h2 class="air" data-ng-if="builds.length">Latest builds</h2>
-  <div class="animate-repeat alert"  data-ng-repeat="b in builds track by b.id" data-ng-class="{'Queued':'alert-info', 'In Progress':'alert-info', 'Succeeded':'alert-success', 'Failed':'alert-error'}[b.status]">
+  <div class="animate-repeat alert"  data-ng-repeat="b in builds track by b.id" data-ng-class="{'queued':'alert-info', 'In Progress':'alert-info', 'Succeeded':'alert-success', 'Failed':'alert-error'}[b.status]">
     <div class="row-fluid">
         <switch data-ng-switch="b.status">
 
@@ -182,7 +182,7 @@ vim: expandtab tabstop=2
             </div>
           </case>
 
-          <case data-ng-switch-when="Queued">
+          <case data-ng-switch-when="queued">
             <div class="lead span5"> <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>   </div>
             <div class="span4 lead" >Build queued
               <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 2336ae3..00b1387 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -64,7 +64,9 @@ def _get_latest_builds(prj=None):
     if prj is not None:
         queryset = queryset.filter(project = prj)
 
-    return itertools.chain(queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-pk")[:3], queryset.filter(outcome=Build.IN_PROGRESS).order_by("-pk"))
+    return itertools.chain(
+        queryset.filter(outcome=Build.IN_PROGRESS).order_by("-pk"),
+        queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-pk")[:3] )
 
 
 # a JSON-able dict of recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
@@ -76,7 +78,7 @@ def _project_recent_build_list(prj):
             "id":  x.pk,
             "targets" : map(lambda y: {"target": y.target, "task": y.task }, x.target_set.all()), # TODO: create the task entry in the Target table
             "status": x.get_current_status(),
-            "errors": map(lambda y: {"type": y.lineno, "msg": y.message, "tb": y.pathname}, x.logmessage_set.filter(level__gte=LogMessage.WARNING)),
+            "errors": map(lambda y: {"type": y.lineno, "msg": y.message, "tb": y.pathname}, (x.logmessage_set.filter(level__gte=LogMessage.WARNING)|x.logmessage_set.filter(level=LogMessage.EXCEPTION))),
             "updated": x.completed_on.strftime('%s')+"000",
             "command_time": (x.completed_on - x.started_on).total_seconds(),
             "br_page_url": reverse('buildrequestdetails', args=(x.project.id, x.pk) ),
-- 
1.9.1


