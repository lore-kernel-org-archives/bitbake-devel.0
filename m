Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 5A870758E8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:39 +0000 (UTC)
Received: by wicgi11 with SMTP id gi11so71411521wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=LFQ+iLtv4bPlOpcliiLAGGOsUwxsy3FSB+5MI40o8TU=;
	b=AgY2E+FZJUqyDcrqJ+FMzC9B+GvFy55ep/eEpg9+zs2M272GHz+HPYFqgJxia6D/NF
	4tP0EKIWCZQrDh5Mkx7+bXZbMzCAVlRQsLlifQvkwgBReN/IS3CzZYdewHUwhWfBmxq1
	lhhjCYyA7Vd7SlcpGouL4lS5MkCyMgd7pU50tp2ynlYO8IK/QKk1XGdLZYj3D/wYZsBo
	bcJUaqHCcV/ShK0+FgGkfDABXWTguM9aRnIdT/q4GrXGAgUEkZa0wdP/Egd1CdOe/iK2
	5WMNIbDWHiUsNrFShFHp3Op4nSz6Zu+kGkMv5PhGkH5cf/neLuvsgjXjxl4BJfwH4rB7
	z0Eg==
X-Gm-Message-State: ALoCoQksrzofW5bUY7ndMYH01C4+JyrqJ93E5eRP6YauXNWTCq3vQkPnzzh+e/n6SvHim5cazjYd
X-Received: by 10.194.185.236 with SMTP id ff12mr79894824wjc.134.1435228480669;
	Thu, 25 Jun 2015 03:34:40 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ha4sm6936883wib.0.2015.06.25.03.34.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:39 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D3D01560ED2; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:49 +0100
Message-Id: <44f37394ed3e4ca02f940be172fe4395b0ee0f7d.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 12/23] toaster: refactor build model
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:42 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We remove the "timespent", "errors_no" and "warnings_no" fields
in favor of computing the needed values at runtime. This prevents
inconsistencies in the UI.

Also removeing all references to BuildRequests from the interface -
all build details now display in the build dashboard.

Minor fixes related to data logging.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       |  70 ++--
 lib/bb/ui/toasterui.py                             |   3 +
 lib/toaster/bldcontrol/localhostbecontroller.py    |   2 +-
 .../bldcontrol/management/commands/runbuilds.py    |  10 +-
 ...ings_no__del_field_build_errors_no__del_fiel.py | 353 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  19 +-
 .../toastergui/templates/builddashboard.html       |  23 +-
 lib/toaster/toastergui/templates/builds.html       |  22 +-
 .../toastergui/templates/configuration.html        |   6 -
 .../toastergui/templates/filtersnippet.html        |   2 +
 lib/toaster/toastergui/templates/landing.html      |  37 +--
 lib/toaster/toastergui/templates/mrb_section.html  |  29 +-
 .../toastergui/templates/package_detail_base.html  |   7 -
 .../toastergui/templates/projectbuilds.html        |  29 +-
 lib/toaster/toastergui/templates/projects.html     |   9 +-
 lib/toaster/toastergui/templates/recipe.html       |   9 +-
 lib/toaster/toastergui/templates/recipes.html      |   7 +-
 lib/toaster/toastergui/templates/runagain.html     |   7 -
 lib/toaster/toastergui/templates/target.html       |   5 -
 lib/toaster/toastergui/templates/task.html         |  36 +--
 lib/toaster/toastergui/templates/tasks.html        |   7 +-
 lib/toaster/toastergui/urls.py                     |   3 -
 lib/toaster/toastergui/views.py                    |  17 +-
 23 files changed, 503 insertions(+), 209 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0023_auto__del_field_build_warnings_no__del_field_build_errors_no__del_fiel.py
 delete mode 100644 lib/toaster/toastergui/templates/runagain.html

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 8b63f70..63976b5 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -16,7 +16,6 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-import datetime
 import sys
 import bb
 import re
@@ -24,6 +23,7 @@ import ast
 
 os.environ["DJANGO_SETTINGS_MODULE"] = "toaster.toastermain.settings"
 
+from django.utils import timezone
 import toaster.toastermain.settings as toaster_django_settings
 from toaster.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage, HelpText
 from toaster.orm.models import Target_Image_File, BuildArtifact
@@ -41,7 +41,7 @@ import logging
 
 from django.db import transaction, connection
 
-logger = logging.getLogger("BitBake")
+logger = logging.getLogger("ToasterLogger")
 
 
 class NotExisting(Exception):
@@ -135,16 +135,18 @@ class ORMWrapper(object):
 
         if buildrequest is not None:
             build = buildrequest.build
-            build.machine=build_info['machine'],
-            build.distro=build_info['distro'],
-            build.distro_version=build_info['distro_version'],
-            build.completed_on=build_info['started_on'],
-            build.cooker_log_path=build_info['cooker_log_path'],
-            build.build_name=build_info['build_name'],
+            logger.info("Updating existing build, with %s" % build_info)
+            build.machine=build_info['machine']
+            build.distro=build_info['distro']
+            build.distro_version=build_info['distro_version']
+            started_on=build_info['started_on']
+            completed_on=build_info['started_on']
+            build.cooker_log_path=build_info['cooker_log_path']
+            build.build_name=build_info['build_name']
             build.bitbake_version=build_info['bitbake_version']
             build.save()
 
-            build.target_set.delete()
+            Target.objects.filter(build = build).delete()
 
         else:
             build = Build.objects.create(
@@ -188,10 +190,7 @@ class ORMWrapper(object):
         if errors or taskfailures:
             outcome = Build.FAILED
 
-        build.completed_on = datetime.datetime.now()
-        build.timespent = int((build.completed_on - build.started_on).total_seconds())
-        build.errors_no = errors
-        build.warnings_no = warnings
+        build.completed_on = timezone.now()
         build.outcome = outcome
         build.save()
 
@@ -687,8 +686,8 @@ class BuildInfoHelper(object):
         build_info['machine'] = self.server.runCommand(["getVariable", "MACHINE"])[0]
         build_info['distro'] = self.server.runCommand(["getVariable", "DISTRO"])[0]
         build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
-        build_info['started_on'] = datetime.datetime.now()
-        build_info['completed_on'] = datetime.datetime.now()
+        build_info['started_on'] = timezone.now()
+        build_info['completed_on'] = timezone.now()
         build_info['cooker_log_path'] = self.server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
         build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
         build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
@@ -857,6 +856,30 @@ class BuildInfoHelper(object):
 
         # Save build configuration
         data = self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0]
+
+        # convert the paths from absolute to relative to either the build directory or layer checkouts
+        path_prefixes = []
+
+        br_id, be_id = self.brbe.split(":")
+        from bldcontrol.models import BuildEnvironment, BuildRequest
+        be = BuildEnvironment.objects.get(pk = be_id)
+        path_prefixes.append(be.builddir)
+
+        for layer in sorted(self.orm_wrapper.layer_version_objects, key = lambda x:len(x.local_path), reverse=True):
+            path_prefixes.append(layer.local_path)
+
+        # we strip the prefixes
+        for k in data:
+            if not bool(data[k]['func']):
+                for vh in data[k]['history']:
+                    if not 'documentation.conf' in vh['file']:
+                        abs_file_name = vh['file']
+                        for pp in path_prefixes:
+                            if abs_file_name.startswith(pp + "/"):
+                                vh['file']=abs_file_name[len(pp + "/"):]
+                                break
+
+        # save the variables
         self.orm_wrapper.save_build_variables(build_obj, data)
 
         return self.brbe
@@ -1031,7 +1054,7 @@ class BuildInfoHelper(object):
             mevent.taskhash = taskhash
             task_information = self._get_task_information(mevent,recipe)
 
-            task_information['start_time'] = datetime.datetime.now()
+            task_information['start_time'] = timezone.now()
             task_information['outcome'] = Task.OUTCOME_NA
             task_information['sstate_checksum'] = taskhash
             task_information['sstate_result'] = Task.SSTATE_MISS
@@ -1206,6 +1229,7 @@ class BuildInfoHelper(object):
                             )
 
     def _store_build_done(self, errorcode):
+        logger.info("Build exited with errorcode %d", errorcode)
         br_id, be_id = self.brbe.split(":")
         from bldcontrol.models import BuildEnvironment, BuildRequest
         be = BuildEnvironment.objects.get(pk = be_id)
@@ -1225,7 +1249,7 @@ class BuildInfoHelper(object):
         mockevent.levelno = format.ERROR
         mockevent.msg = text
         mockevent.pathname = '-- None'
-        mockevent.lineno = -1
+        mockevent.lineno = LogMessage.ERROR
         self.store_log_event(mockevent)
 
     def store_log_exception(self, text, backtrace = ""):
@@ -1249,13 +1273,12 @@ class BuildInfoHelper(object):
                 if not 'backlog' in self.internal_state:
                     self.internal_state['backlog'] = []
                 self.internal_state['backlog'].append(event)
-            else:   # we're under Toaster control, post the errors to the build request
+                return
+            else:   # we're under Toaster control, the build is already created
                 from bldcontrol.models import BuildRequest, BRError
                 br, be = self.brbe.split(":")
                 buildrequest = BuildRequest.objects.get(pk = br)
-                brerror = BRError.objects.create(req = buildrequest, errtype="build", errmsg = event.msg)
-
-            return
+                self.internal_state['build'] = buildrequest.build
 
         if 'build' in self.internal_state and 'backlog' in self.internal_state:
             # if we have a backlog of events, do our best to save them here
@@ -1273,14 +1296,15 @@ class BuildInfoHelper(object):
             log_information['level'] = LogMessage.ERROR
         elif event.levelno == format.WARNING:
             log_information['level'] = LogMessage.WARNING
-        elif event.levelno == -1:   # toaster self-logging
-            log_information['level'] = -1
+        elif event.levelno == -2:   # toaster self-logging
+            log_information['level'] = -2
         else:
             log_information['level'] = LogMessage.INFO
 
         log_information['message'] = event.msg
         log_information['pathname'] = event.pathname
         log_information['lineno'] = event.lineno
+        logger.info("Logging error 2: %s" % log_information)
         self.orm_wrapper.create_logmessage(log_information)
 
     def close(self, errorcode):
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 9c59fd0..28fdd82 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -140,6 +140,9 @@ def main(server, eventHandler, params ):
                 continue
 
             if isinstance(event, logging.LogRecord):
+                if event.levelno == -1:
+                    event.levelno = format.ERROR
+
                 buildinfohelper.store_log_event(event)
                 if event.levelno >= format.ERROR:
                     errors = errors + 1
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index ad0a561..3e16837 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -113,7 +113,7 @@ class LocalhostBEController(BuildEnvironmentController):
         # get the file length; we need to detect the _last_ start of the toaster UI, not the first
         toaster_ui_log_filelength = 0
         if os.path.exists(toaster_ui_log_filepath):
-            with open(toaster_ui_log_filepath, "r") as f:
+            with open(toaster_ui_log_filepath, "w") as f:
                 f.seek(0, 2)    # jump to the end
                 toaster_ui_log_filelength = f.tell()
 
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index bcf3b04..33cc94e 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -107,20 +107,24 @@ class Command(NoArgsCommand):
     def cleanup(self):
         from django.utils import timezone
         from datetime import timedelta
-        # DISABLED environments locked for more than 30 seconds - they should be unlocked
-        #BuildEnvironment.objects.filter(lock=BuildEnvironment.LOCK_LOCK).filter(updated__lt = timezone.now() - timedelta(seconds = 30)).update(lock = BuildEnvironment.LOCK_FREE)
+        # environments locked for more than 30 seconds - they should be unlocked
+        BuildEnvironment.objects.filter(buildrequest__state__in=[BuildRequest.REQ_FAILED, BuildRequest.REQ_COMPLETED]).filter(lock=BuildEnvironment.LOCK_LOCK).filter(updated__lt = timezone.now() - timedelta(seconds = 30)).update(lock = BuildEnvironment.LOCK_FREE)
 
 
         # update all Builds that failed to start
 
         for br in BuildRequest.objects.filter(state = BuildRequest.REQ_FAILED, build__outcome = Build.IN_PROGRESS):
-            br.build.outcome = Build.FAILED
             # transpose the launch errors in ToasterExceptions
+            br.build.outcome = Build.FAILED
             for brerror in br.brerror_set.all():
                 logger.debug("Saving error %s" % brerror)
                 LogMessage.objects.create(build = br.build, level = LogMessage.EXCEPTION, message = brerror.errmsg)
             br.build.save()
 
+            # we don't have a true build object here; hence, toasterui didn't have a change to release the BE lock
+            br.environment.lock = BuildEnvironment.LOCK_FREE
+            br.environment.save()
+
 
 
         # update all BuildRequests without a build created
diff --git a/lib/toaster/orm/migrations/0023_auto__del_field_build_warnings_no__del_field_build_errors_no__del_fiel.py b/lib/toaster/orm/migrations/0023_auto__del_field_build_warnings_no__del_field_build_errors_no__del_fiel.py
new file mode 100644
index 0000000..b5b200cd
--- /dev/null
+++ b/lib/toaster/orm/migrations/0023_auto__del_field_build_warnings_no__del_field_build_errors_no__del_fiel.py
@@ -0,0 +1,353 @@
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
+        # Deleting field 'Build.warnings_no'
+        db.delete_column(u'orm_build', 'warnings_no')
+
+        # Deleting field 'Build.errors_no'
+        db.delete_column(u'orm_build', 'errors_no')
+
+        # Deleting field 'Build.timespent'
+        db.delete_column(u'orm_build', 'timespent')
+
+
+    def backwards(self, orm):
+        # Adding field 'Build.warnings_no'
+        db.add_column(u'orm_build', 'warnings_no',
+                      self.gf('django.db.models.fields.IntegerField')(default=0),
+                      keep_default=False)
+
+        # Adding field 'Build.errors_no'
+        db.add_column(u'orm_build', 'errors_no',
+                      self.gf('django.db.models.fields.IntegerField')(default=0),
+                      keep_default=False)
+
+        # Adding field 'Build.timespent'
+        db.add_column(u'orm_build', 'timespent',
+                      self.gf('django.db.models.fields.IntegerField')(default=0),
+                      keep_default=False)
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
\ No newline at end of file
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index e93629b..077c94d 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -147,7 +147,7 @@ class Project(models.Model):
         if (-1 == build_id):
             return( 0 )
         try:
-            return Build.objects.filter(id = build_id)[ 0 ].errors_no
+            return Build.objects.filter(id = build_id)[ 0 ].errors.count()
         except (Build.DoesNotExist,IndexError):
             return( "not_found" )
 
@@ -156,7 +156,7 @@ class Project(models.Model):
         if (-1 == build_id):
             return( 0 )
         try:
-            return Build.objects.filter(id = build_id)[ 0 ].warnings_no
+            return Build.objects.filter(id = build_id)[ 0 ].warnings.count()
         except (Build.DoesNotExist,IndexError):
             return( "not_found" )
 
@@ -248,10 +248,7 @@ class Build(models.Model):
     distro_version = models.CharField(max_length=100)
     started_on = models.DateTimeField()
     completed_on = models.DateTimeField()
-    timespent = models.IntegerField(default=0)
     outcome = models.IntegerField(choices=BUILD_OUTCOME, default=IN_PROGRESS)
-    errors_no = models.IntegerField(default=0)
-    warnings_no = models.IntegerField(default=0)
     cooker_log_path = models.CharField(max_length=500)
     build_name = models.CharField(max_length=100)
     bitbake_version = models.CharField(max_length=50)
@@ -281,6 +278,17 @@ class Build(models.Model):
     def toaster_exceptions(self):
         return self.logmessage_set.filter(level=LogMessage.EXCEPTION)
 
+    @property
+    def errors(self):
+        return (self.logmessage_set.filter(level=LogMessage.ERROR)|self.logmessage_set.filter(level=LogMessage.EXCEPTION))
+
+    @property
+    def warnings(self):
+        return self.logmessage_set.filter(level=LogMessage.WARNING)
+
+    @property
+    def timespent_seconds(self):
+        return (self.completed_on - self.started_on).total_seconds()
 
     def get_current_status(self):
         from bldcontrol.models import BuildRequest
@@ -298,7 +306,6 @@ class BuildArtifact(models.Model):
     file_name = models.FilePathField()
     file_size = models.IntegerField()
 
-
     def get_local_file_name(self):
         try:
             deploydir = Variable.objects.get(build = self.build, variable_name="DEPLOY_DIR").variable_value
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 47b8d7a..bab8e38 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -23,22 +23,23 @@
               </strong> on
             {{build.completed_on|date:"d/m/y H:i"}}
 </span>
-{% if  build.warnings_no or build.errors_no %}
+{% if  build.warnings.count or build.errors.count %}
 &nbsp;with
 {% endif %}
 {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
-{% if  build.errors_no %}
-     <span > <i class="icon-minus-sign red"></i><strong><a href="#errors" class="error show-errors"> {{build.errors_no}} error{{build.errors_no|pluralize}}</a></strong></span>
+{% if  build.errors.count %}
+     <span > <i class="icon-minus-sign red"></i><strong><a href="#errors" class="error show-errors"> {{build.errors.count}} error{{build.errors.count|pluralize}}</a></strong></span>
 {% endif %}
-{% if  build.warnings_no %}
-{% if  build.errors_no %}
+{% if  build.warnings.count %}
+{% if  build.errors.count %}
     and
 {% endif %}
-    <span > <i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning show-warnings"> {{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a></strong></span>
+    <span > <i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning show-warnings"> {{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a></strong></span>
 {% endif %}
-            <span class="pull-right">Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
+            <span class="pull-right">Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent_seconds|sectohms }}</a>
             <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%else%}btn-danger{%endif%} pull-right log" href="{% url 'build_artifact' build.id "cookerlog" build.id %}">Download build log</a>
             </span>
+
 {%endif%}
     </div>
     {% if build.toaster_exceptions.count > 0 %}
@@ -52,14 +53,14 @@
   </div>
 </div>
 
-{% if build.errors_no %}
+{% if build.errors.count %}
 <div class="accordion span10 pull-right" id="errors">
   <div class="accordion-group">
     <div class="accordion-heading">
             <a class="accordion-toggle error toggle-errors">
          <h2 id="error-toggle">
            <i class="icon-minus-sign"></i>
-           {{build.errors_no}} error{{build.errors_no|pluralize}}
+           {{build.errors.count}} error{{build.errors.count|pluralize}}
          </h2>
       </a>
     </div>
@@ -241,14 +242,14 @@
     </div>
 </div>
 
-{% if build.warnings_no %}
+{% if build.warnings.count %}
 <div class="accordion span10 pull-right" id="warnings">
   <div class="accordion-group">
     <div class="accordion-heading">
       <a class="accordion-toggle warning toggle-warnings">
         <h2 id="warning-toggle">
           <i class="icon-warning-sign"></i>
-          {{build.warnings_no}} warning{{build.warnings_no|pluralize}}
+          {{build.warnings.count}} warning{{build.warnings.count|pluralize}}
         </h2>
       </a>
     </div>
diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
index e9211af..00d1d4e 100644
--- a/lib/toaster/toastergui/templates/builds.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -46,7 +46,11 @@
     <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+            <input id="search" name="search" class="input-xxlarge" type="text" value="
+            {% if request.GET.search %}
+                {{request.GET.search}}
+        {% endif %}"/>
+            {% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
             <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all builds</button>
         </form>
@@ -60,8 +64,8 @@
         {% for build in objects %}
         <tr class="data">
             <td class="outcome">
-	    <a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a> &nbsp;
-	    </td>
+        <a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a> &nbsp;
+        </td>
             <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
             <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
             <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
@@ -77,19 +81,19 @@
                         <a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}} task{{exectask.count|pluralize}}</a>
                     {%endif%}
             </td>
-            <td class="errors_no">
-                {% if  build.errors_no %}
-                    <a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
+            <td class="errors.count">
+                {% if  build.errors.count %}
+                    <a class="errors.count error" href="{% url "builddashboard" build.id %}#errors">{{build.errors.count}} error{{build.errors.count|pluralize}}</a>
                 {%endif%}
             </td>
-            <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
-            <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
+            <td class="warnings.count">{% if  build.warnings.count %}<a class="warnings.count warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a>{%endif%}</td>
+            <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent_seconds|sectohms}}</a></td>
             <td class="output">
               {% if build.outcome == build.SUCCEEDED %}
               <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
               {% endif %}
             </td>
-	    <td>
+        <td>
                 <a href="{% url 'project' build.project.id %}">{{build.project.name}}</a>
             </td>
         </tr>
diff --git a/lib/toaster/toastergui/templates/configuration.html b/lib/toaster/toastergui/templates/configuration.html
index 2aa1ae1..3e48991 100644
--- a/lib/toaster/toastergui/templates/configuration.html
+++ b/lib/toaster/toastergui/templates/configuration.html
@@ -50,9 +50,6 @@
           <th>Layer</th>
           <th>Layer branch</th>
           <th>Layer commit</th>
-          {% if not MANAGED or not build.project %}
-              <th>Layer directory</th>
-          {% endif %}
         </tr>
       </thead>
       <tbody>{% for lv in build.layer_version_build.all|dictsort:"layer.name" %}
@@ -63,9 +60,6 @@
                 <li>{{lv.commit}}</li> </ul>">
                     {{lv.commit|truncatechars:13}}
                 </a></td>
-          {% if not MANAGED or not build.project %}
-            <td>{{lv.local_path}}</td>
-          {% endif %}
         </tr>{% endfor %}
       </tbody>
     </table>
diff --git a/lib/toaster/toastergui/templates/filtersnippet.html b/lib/toaster/toastergui/templates/filtersnippet.html
index 56e2b21..1101aa8 100644
--- a/lib/toaster/toastergui/templates/filtersnippet.html
+++ b/lib/toaster/toastergui/templates/filtersnippet.html
@@ -40,8 +40,10 @@
                 {% endif %}
             {% endfor %}
         <!-- daterange persistence -->
+        {% if last_date_from and last_date_to %}
         <input type="hidden" id="last_date_from_{{key}}" name="last_date_from" value="{{last_date_from}}"/>
         <input type="hidden" id="last_date_to_{{key}}" name="last_date_to"   value="{{last_date_to}}"/>
+        {% endif %}
         </div>
         <div class="modal-footer">
             <button type="submit" class="btn btn-primary" data-key="{{key}}">Apply</button>
diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
index 4af849c..15cac47 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -9,7 +9,7 @@
   <div class="container-fluid">
    <div class="row-fluid">
     <!-- Empty - no data in database -->
-    <div class="hero-unit span12 {%if MANAGED%}well-transparent{%endif%}">
+    <div class="hero-unit span12 well-transparent">
      <div class="row-fluid">
       <div class="span6">
        <h1>
@@ -17,7 +17,6 @@
        </h1>
        <p>A web interface to <a href="http://www.openembedded.org">OpenEmbedded</a> and <a href="http://www.yoctoproject.org/tools-resources/projects/bitbake">BitBake</a>, the <a href="http://www.yoctoproject.org">Yocto Project</a> build system.</p>
 
-	{% if MANAGED %}
 
 		{% if lvs_nos %}
 		    <p class="hero-actions">
@@ -37,7 +36,7 @@
 			        </li>
 			    </ul>
 		    </div>
-        {% endif %}
+	        {% endif %}
 
         <ul class="unstyled">
             <li>
@@ -48,18 +47,6 @@
             </li>
         </ul>
 
-        {% else %}
-
-        <p class="hero-actions">
-            <a class="btn btn-primary btn-large" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
-                Show me the manual
-            </a>
-            <a class="btn btn-large" href="https://wiki.yoctoproject.org/wiki/Contribute_to_Toaster">
-                I want to contribute
-	        </a>
-	    </p>
-
-	    {% endif %}
       </div>
       <div class="span6">
         {% if MANAGED %}
@@ -70,26 +57,6 @@
       </div>
      </div>
     </div>
-
-   {% if not MANAGED %}
-    <!-- Empty - no data in database -->
-    <div class="page-header top-air">
-     <h1>
-      All builds
-     </h1>
-    </div>
-    <div class="alert alert-info lead">
-     Toaster has not recorded any builds yet. Go build something with
-     <a href="http://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html#test-run">
-      Knotty
-     </a>
-     or
-     <a href="https://www.yoctoproject.org/documentation/hob-manual">
-      Hob
-     </a>
-    </div>
-   {% endif %}
-
    </div>
 
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 7e84e41..d37b694 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -43,19 +43,35 @@
             </div>
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
             <div class="span2 lead">
-      {% if  build.errors_no %}
-                <i class="icon-minus-sign red"></i> <a href="{%url 'builddashboard' build.pk%}#errors" class="error">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
+      {% if  build.errors.count %}
+                <i class="icon-minus-sign red"></i> <a href="{%url 'builddashboard' build.pk%}#errors" class="error">{{build.errors.count}} error{{build.errors.count|pluralize}}</a>
       {% endif %}
             </div>
             <div class="span2 lead">
-      {% if  build.warnings_no %}
-                <i class="icon-warning-sign yellow"></i> <a href="{%url 'builddashboard' build.pk%}#warnings" class="warning">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>
+      {% if  build.warnings.count %}
+                <i class="icon-warning-sign yellow"></i> <a href="{%url 'builddashboard' build.pk%}#warnings" class="warning">{{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a>
       {% endif %}
             </div>
             <div class="lead ">
-              <span class="lead{%if not MANAGED or not build.project%} pull-right{%endif%}">
-                Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
+              <span class="lead">
+                Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent_seconds|sectohms }}</a>
               </span>
+              <button class="btn
+                  {% if build.outcome == build.SUCCEEDED %}
+                      btn-success
+                  {% elif build.outcome == build.FAILED %}
+                      btn-danger
+                  {% else %}
+                      btn-info
+                  {%endif%}
+                  pull-right"
+                  onclick='scheduleBuild({% url 'projectbuilds' build.project.id as bpi %}{{bpi|json}},
+                    {{build.project.name|json}},
+                    {% url 'project' build.project.id as bpurl %}{{bpurl|json}},
+                    {{build.target_set.all|get_tasks|json}})'>
+
+                    Run again
+              </button>
             </div>
     {%endif%}
     {%if build.outcome == build.IN_PROGRESS %}
@@ -77,6 +93,7 @@
 function scheduleBuild(url, projectName, projectUrl, buildlist) {
   console.log("scheduleBuild");
   libtoaster.startABuild(url, null, buildlist.join(" "), function(){
+    console.log("reloading page");
     window.location.reload();
   }, null);
 }
diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index e2ec75d..a24bc8e 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -136,13 +136,6 @@
 
             <dd class="iscommit">{{package.recipe.layer_version.commit}}</dd>
 
-          {% if not MANAGED or not build.project %}
-            <dt>
-                Layer directory
-                <i class="icon-question-sign get-help" title="Path to the layer providing the recipe that builds this package"></i>
-            </dt>
-            <dd><code>{{package.recipe.layer_version.local_path}}</code></dd>
-          {% endif %}
         </dl>
     </div> <!-- row4 well -->
     {% endblock twocolumns %}
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index 896c3b5..ac87d8c 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -79,25 +79,20 @@
                 {% query build.task_build outcome=4 order__gt=0 as exectask%}
                     {% if exectask.count == 1 %}
                         <a href="{% url "task" build.id exectask.0.id %}">{{exectask.0.recipe.name}}.{{exectask.0.task_name}}</a>
-                      {% if MANAGED and build.project %}
                         <a href="{% url 'build_artifact' build.id "tasklogfile" exectask.0.id %}">
                             <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
                         </a>
-                      {% endif %}
                     {% elif exectask.count > 1%}
                         <a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}} task{{exectask.count|pluralize}}</a>
                     {%endif%}
             </td>
-            <td class="errors_no">
-                {% if  build.errors_no %}
-                    <a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
+            <td class="errors.count">
+                {% if  build.errors.count %}
+                    <a class="errors.count error" href="{% url "builddashboard" build.id %}#errors">{{build.errors.count}} error{{build.errors.count|pluralize}}</a>
                 {%endif%}
             </td>
-            <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
-            <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
-            {% if not MANAGED or not build.project %}
-                <td class="log">{{build.cooker_log_path}}</td>
-            {% endif %}
+            <td class="warnings.count">{% if  build.warnings.count %}<a class="warnings.count warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a>{%endif%}</td>
+            <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent_seconds|sectohms}}</a></td>
             <td class="output">
               {% if build.outcome == build.SUCCEEDED %}
               <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
@@ -113,23 +108,23 @@
         <tr class="data">
             <td class="outcome">{% if br.state == br.REQ_FAILED %}<i class="icon-minus-sign error"></i>{%else%}FIXME_build_request_state{%endif%}</td>
             <td class="target">
-                <a href="{% url "buildrequestdetails" br.project.id br.id %}"><span data-toggle="tooltip" {%if br.brtarget_set.all.count > 1%}title="Targets: {%for target in br.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{br.brtarget_set.all.0.target}} {%if br.brtarget_set.all.count > 1%}(+ {{br.brtarget_set.all.count|add:"-1"}}){%endif%} </span></a>
+                <a href="{% url "builddashboard" br.id %}"><span data-toggle="tooltip" {%if br.brtarget_set.all.count > 1%}title="Targets: {%for target in br.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{br.brtarget_set.all.0.target}} {%if br.brtarget_set.all.count > 1%}(+ {{br.brtarget_set.all.count|add:"-1"}}){%endif%} </span></a>
             </td>
             <td class="machine">
-                <a href="{% url "buildrequestdetails" br.project.id br.id %}">{{br.machine}}</a>
+                <a href="{% url "builddashboard" br.id %}">{{br.machine}}</a>
             </td>
             <td class="started_on">
-                <a href="{% url "buildrequestdetails" br.project.id br.id %}">{{br.created|date:"d/m/y H:i"}}</a>
+                <a href="{% url "builddashboard" br.id %}">{{br.created|date:"d/m/y H:i"}}</a>
             </td>
             <td class="completed_on">
-                <a href="{% url "buildrequestdetails" br.project.id br.id %}">{{br.updated|date:"d/m/y H:i"}}</a>
+                <a href="{% url "builddashboard" br.id %}">{{br.updated|date:"d/m/y H:i"}}</a>
             </td>
             <td class="failed_tasks error">
             </td>
-            <td class="errors_no">
-        <a class="errors_no error" href="{% url "buildrequestdetails" br.project.id br.id %}#errors">{{br.brerror_set.all.count}} error{{br.brerror_set.all.count|pluralize}}</a>
+            <td class="errors.count">
+        <a class="errors.count error" href="{% url "builddashboard" br.id %}#errors">{{br.brerror_set.all.count}} error{{br.brerror_set.all.count|pluralize}}</a>
             </td>
-            <td class="warnings_no">
+            <td class="warnings.count">
             </td>
             <td class="time">
                 {{br.timespent.total_seconds|sectohms}}
diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
index 9c4346c..e651953 100644
--- a/lib/toaster/toastergui/templates/projects.html
+++ b/lib/toaster/toastergui/templates/projects.html
@@ -26,7 +26,10 @@
     <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+            <input id="search" name="search" class="input-xxlarge" type="text" value="
+                {% if request.GET.search %}
+                    {{request.GET.search}}
+                {% endif %}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
             <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all projects</button>
         </form>
@@ -58,8 +61,8 @@
       <td><a href="{% url 'projectbuilds' o.id %}">{{o.get_number_of_builds}}</a></td>
       <td class="loutcome"><a href="{% url "builddashboard" o.get_last_build_id %}">{%if o.get_last_outcome == build_SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif o.get_last_outcome == build_FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
       <td class="ltarget"><a href="{% url "builddashboard" o.get_last_build_id %}">{{o.get_last_target}} </a></td>
-      <td class="lerrors">{% if o.get_last_errors %}<a class="errors_no error" href="{% url "builddashboard" o.get_last_build_id %}#errors">{{o.get_last_errors}} error{{o.get_last_errors|pluralize}}</a>{%endif%}</td>
-      <td class="lwarnings">{% if o.get_last_warnings %}<a class="warnings_no warning" href="{% url "builddashboard" o.get_last_build_id %}#warnings">{{o.get_last_warnings}} warning{{o.get_last_warnings|pluralize}}</a>{%endif%}</td>
+      <td class="lerrors">{% if o.get_last_errors %}<a class="errors.count error" href="{% url "builddashboard" o.get_last_build_id %}#errors">{{o.get_last_errors}} error{{o.get_last_errors|pluralize}}</a>{%endif%}</td>
+      <td class="lwarnings">{% if o.get_last_warnings %}<a class="warnings.count warning" href="{% url "builddashboard" o.get_last_build_id %}#warnings">{{o.get_last_warnings}} warning{{o.get_last_warnings|pluralize}}</a>{%endif%}</td>
       <td class="limagefiles">
         {% if o.get_last_outcome == build_SUCCEEDED %}
         <a href="{%url "builddashboard" o.get_last_build_id %}#images">{{fstypes|get_dict_value:o.id}}</a>
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index dd8753d..b5e4192 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -53,13 +53,6 @@
                 </dt>
                 <dd>{{layer.name}}</dd>
 
-          {% if not MANAGED or not build.project %}
-                <dt>
-                    <i class="icon-question-sign get-help" title="Path to the layer providing the recipe"></i>
-                    Layer directory
-                </dt>
-                <dd><code>{{object.layer_version.local_path}}</code></dd>
-          {% endif %}
                 <dt>
                     <i class="icon-question-sign get-help" title="Path to the recipe .bb file"></i>
                     Recipe file
@@ -126,7 +119,7 @@
 
                     <td>
                         <a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.get_outcome_display}} </a>
-                        {% if MANAGED and build.project and task.outcome = task.OUTCOME_FAILED %}
+                        {% if task.outcome = task.OUTCOME_FAILED %}
                             <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
                                 <i class="icon-download-alt" title="Download task log file"></i>
                             </a>
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index 8d4494e..5cdac43 100644
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -28,7 +28,7 @@
   <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{%if request.GET.search%}{{request.GET.search}}{%endif%}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
             <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all recipes</button>
         </form>
@@ -102,11 +102,6 @@
                 {{recipe.layer_version.commit|truncatechars:13}}
             </a>
         </td>
-
-        {% if not MANAGED or not build.project %}
-            <!-- Layer directory -->
-            <td class="layer_version__local_path">{{recipe.layer_version.local_path}}</td>
-        {% endif %}
     </tr>
 
     {% endfor %}
diff --git a/lib/toaster/toastergui/templates/runagain.html b/lib/toaster/toastergui/templates/runagain.html
deleted file mode 100644
index b4ba5fb..0000000
--- a/lib/toaster/toastergui/templates/runagain.html
+++ /dev/null
@@ -1,7 +0,0 @@
-{% load projecttags %}
-onclick='scheduleBuild(
-    {% url 'projectbuilds' buildrequest.project.id as bpi %}{{bpi|json}},
-    {{buildrequest.project.name|json}},
-    {% url 'project' buildrequest.project.id as bpurl %}{{bpurl|json}},
-    {{buildrequest.brtarget_set.all|get_tasks|json}})
-'>Run again
diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index e7febaf..fa59f4e 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -152,11 +152,6 @@
                 {{package.recipe.layer_version.commit|truncatechars:13}}
             </a>
         </td>
-        {% if not MANAGED or not build.project %}
-            <td class="layer_directory">
-                {{ package.recipe.layer_version.local_path }}
-            </td>
-        {% endif %}
     </tr>
     {% endfor %}
 
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 6e06ddf..635098a 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -23,18 +23,7 @@
 {%if task.task_executed %}
     {# executed tasks outcome #}
     {% if task.logfile %}
-      {% if MANAGED and build.project %}
             <a class="btn btn-large" href="{% url 'build_artifact' build.id "tasklogfile" task.pk %}" style="margin:15px;">Download task log</a>
-      {% else %}
-       <dl class="dl-horizontal">
-        <dt>
-            <i class="icon-question-sign get-help" title="Path the task log file"></i> Log file
-        </dt>
-        <dd>
-             <code>{{task.logfile}}</code>
-        </dd>
-       </dl>
-      {% endif %}
     {% endif %}
         {# show stack trace for failed task #}
         {% if task.outcome == task.OUTCOME_FAILED and log_head %}
@@ -130,22 +119,12 @@
             </dd>
         </dl>
     {%elif task.outcome == task.OUTCOME_CACHED%}
-        {% if MANAGED and build.project %}
             {% for t in task.get_related_setscene %}
                 {% if forloop.last %}
                     <a class="btn btn-large" href="{% url 'build_artifact' build.id "tasklogfile" t.pk %}" style="margin:15px;">Download task log</a>
                 {% endif %}
             {% endfor %}
-        {% else %}
-        <dl class="dl-horizontal">
-            <dt>
-                <i class="icon-question-sign get-help" title="Path the task log file"></i> Log file
-            </dt>
-            <dd>
-                <code>{% for t in task.get_related_setscene %} {{t.logfile}} {% endfor %}</code>
-            </dd>
-        </dl>
-        {% endif %}
+
     {%elif task.outcome == task.OUTCOME_EMPTY%}
         <div class="alert alert-info details">
             This task is empty because it has the <code>noexec</code> flag set to <code>1</code>, or the task function is empty
@@ -200,20 +179,7 @@
             <strong>Failed</strong> to restore output from sstate cache. The file was found but could not be unpacked.
         </div>
         <dl class="dl-horizontal">
-          {% if MANAGED and build.project %}
             <a href="{% url 'build_artifact' build.id "tasklogfile" task.pk %}" style="margin:15px;">Download log</a>
-          {% else %}
-            <dt>
-                <i class="icon-question-sign get-help" title="Path to the cache attempt log file"></i>
-                Log file
-            </dt>
-            <dd><code>{{task.logfile}}</code></dd>
-            <dt>
-                <i class="icon-question-sign get-help" title="How long it took the cache attempt to finish in seconds"></i>
-                Time (secs)
-            </dt>
-            <dd>{{task.elapsed_time|format_none_and_zero}}</dd>
-          {% endif %}
         </dl>
         <div class="alert alert-info">
             Running the real task instead.
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index 32c0552..b18b5c7 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -93,7 +93,7 @@
             </td>
             <td class="outcome">
                 <a href="{%url "task" build.pk task.pk%}">{{task.get_outcome_display}} </a>
-                {% if MANAGED and build.project and task.outcome = task.OUTCOME_FAILED %}
+                {% if task.outcome = task.OUTCOME_FAILED %}
                     <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
                         <i class="icon-download-alt" title="Download task log file"></i>
                     </a>
@@ -113,11 +113,6 @@
                 {{task.disk_io|format_none_and_zero}}
             </td>
 
-        {% if not MANAGED or not build.project %}
-            <td class="task_log">
-                {{task.logfile}}
-            </td>
-        {% endif %}
         </tr>
     {% endfor %}
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 681f067..feb1513 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -131,9 +131,6 @@ urlpatterns = patterns('toastergui.views',
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
         url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
 
-        # dashboard for failed build requests
-        url(r'^project/(?P<pid>\d+)/buildrequest/(?P<bid>\d+)$', 'buildrequestdetails', name='buildrequestdetails'),
-
         # default redirection
         url(r'^$', RedirectView.as_view( url= 'landing')),
 )
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 00b1387..8c6f9fa 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -21,7 +21,7 @@
 
 import operator,re
 
-from django.db.models import Q, Sum, Count, Max
+from django.db.models import F, Q, Sum, Count, Max
 from django.db import IntegrityError
 from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
@@ -81,15 +81,15 @@ def _project_recent_build_list(prj):
             "errors": map(lambda y: {"type": y.lineno, "msg": y.message, "tb": y.pathname}, (x.logmessage_set.filter(level__gte=LogMessage.WARNING)|x.logmessage_set.filter(level=LogMessage.EXCEPTION))),
             "updated": x.completed_on.strftime('%s')+"000",
             "command_time": (x.completed_on - x.started_on).total_seconds(),
-            "br_page_url": reverse('buildrequestdetails', args=(x.project.id, x.pk) ),
+            "br_page_url": reverse('builddashboard', args=(x.pk,) ),
             "build" : map( lambda y: {"id": y.pk,
                         "status": y.get_outcome_display(),
                         "completed_on" : y.completed_on.strftime('%s')+"000",
                         "build_time" : (y.completed_on - y.started_on).total_seconds(),
                         "build_page_url" : reverse('builddashboard', args=(y.pk,)),
                         'build_time_page_url': reverse('buildtime', args=(y.pk,)),
-                        "errors": y.errors_no,
-                        "warnings": y.warnings_no,
+                        "errors": y.errors.count(),
+                        "warnings": y.warnings.count(),
                         "completeper": y.completeper() if y.outcome == Build.IN_PROGRESS else "0",
                         "eta": y.eta().strftime('%s')+"000" if y.outcome == Build.IN_PROGRESS else "0",
                         }, [x]),
@@ -1906,7 +1906,7 @@ if True:
         (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
         # post-process any date range filters
         filter_string,daterange_selected = _modify_date_range_filter(filter_string)
-        queryset_all = queryset_all.select_related("project")
+        queryset_all = queryset_all.select_related("project").annotate(errors_no = Count('logmessage', only=Q(logmessage__level=LogMessage.ERROR)|Q(logmessage__level=LogMessage.EXCEPTION))).annotate(warnings_no = Count('logmessage', only=Q(logmessage__level=LogMessage.WARNING))).extra(select={'timespent':'completed_on - started_on'})
         queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string, '-completed_on')
         queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
 
@@ -2841,10 +2841,3 @@ if True:
 
         _set_parameters_values(pagesize, orderby, request)
         return context
-
-    @_template_renderer("buildrequestdetails.html")
-    def buildrequestdetails(request, pid, bid):
-        context = {
-            'buildrequest' : Build.objects.get(pk = bid, project_id = pid).buildrequest
-        }
-        return context
-- 
1.9.1


