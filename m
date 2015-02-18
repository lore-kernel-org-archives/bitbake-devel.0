Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id C409672DE2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:07 +0000 (UTC)
Received: by mail-wg0-f48.google.com with SMTP id l18so3048347wgh.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=lDamKXV4qZ1HCCk7WghCHEmgm2MulOaJBnkuKeU531w=;
	b=j17AZernE1npMZfMALe4fNUA4awie20+vF8QLE/xl4A8hskUVaqdRvQQSPlvOBQORz
	NLwUJR90HVS4jmL4ySpRvAhYPvb3/7MAyFqhhGwLlHJNXBNJdD41y1X0V/1olcFP5lKY
	/BnU7J6mhmUN3YrdOVRh8+RaXugHJhHrNEuawsNT5RPtdbR9xc3XDgQDWLz7s8souUkH
	07H6e8sSBa92m8CCh1jh8Uh3acPoAYzmX/GDsq6FXsdpy5auFTapcg+WrLK8EL86jfc3
	B3/KmwYJbAej64jUHhr/wAbogOWkLwSKVbnYUmyVBqnDPmbyEYnWDCJtXyjxcazUEH/x
	HSEw==
X-Gm-Message-State: ALoCoQkhU8bJ7SE4PozZF46ivtF98FAHNwxAsldcxuqAMjpfFZ2WKcGOx+AknJmxtNt3wJq9bbB3
X-Received: by 10.194.177.195 with SMTP id cs3mr1176161wjc.141.1424286668291; 
	Wed, 18 Feb 2015 11:11:08 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	lg18sm6253104wic.23.2015.02.18.11.11.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 359D4560444; Wed, 18 Feb 2015 19:11:06 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:10:55 +0000
Message-Id: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Subject: [PATCH 01/10] toaster: bitbake cooker log saving and downloading
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
X-List-Received-Date: Wed, 18 Feb 2015 19:11:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings in cooker log saving and proper download links.

* toasterui will now write the cooker log file if running in managed
mode
* the BuildRequest has a new state, REQ_ARCHIVE, indicating that the
build is completed, and the artifacts are ready to be grabbed
* the runbuild test execution commands will gather needed artifacts,
and save them to a storage directory selected during Toaster setup.
* the build dashboard, project builds and all builds pages have
permanent links for the cooker log

[YOCTO #7220]
[YOCTO #7206]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       |   3 +-
 lib/bb/ui/toasterui.py                             |  29 ++++-
 .../management/commands/checksettings.py           |  17 +++
 .../bldcontrol/management/commands/runbuilds.py    |  29 ++++-
 .../bldcontrol/migrations/0008_brarchive.py        | 138 +++++++++++++++++++++
 lib/toaster/bldcontrol/models.py                   |   2 +
 lib/toaster/toastergui/templates/build.html        |   9 +-
 .../toastergui/templates/builddashboard.html       |  11 +-
 .../toastergui/templates/managed_builds.html       |   9 +-
 .../toastergui/templates/projectbuilds.html        |  14 ++-
 .../toastergui/templates/unavailable_artifact.html |  17 +++
 lib/toaster/toastergui/views.py                    |  94 +++++++++++---
 lib/toaster/toastermain/urls.py                    |   6 +-
 13 files changed, 335 insertions(+), 43 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/migrations/0008_brarchive.py
 create mode 100644 lib/toaster/toastergui/templates/unavailable_artifact.html

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 491fd15..1096ccf 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1114,7 +1114,8 @@ class BuildInfoHelper(object):
         be.save()
         br = BuildRequest.objects.get(pk = br_id)
         if errorcode == 0:
-            br.state = BuildRequest.REQ_COMPLETED
+            # request archival of the project artifacts
+            br.state = BuildRequest.REQ_ARCHIVE
         else:
             br.state = BuildRequest.REQ_FAILED
         br.save()
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index a85ad5a..df9f362 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -58,7 +58,12 @@ def _log_settings_from_server(server):
     if error:
         logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
         raise BaseException(error)
-    return includelogs, loglines
+    consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
+    if error:
+        logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
+        raise BaseException(error)
+    return includelogs, loglines, consolelogfile
+
 
 def main(server, eventHandler, params ):
 
@@ -71,7 +76,7 @@ def main(server, eventHandler, params ):
     console.setFormatter(format)
     logger.addHandler(console)
 
-    includelogs, loglines = _log_settings_from_server(server)
+    includelogs, loglines, consolelogfile = _log_settings_from_server(server)
 
     # verify and warn
     build_history_enabled = True
@@ -96,6 +101,16 @@ def main(server, eventHandler, params ):
 
     buildinfohelper = BuildInfoHelper(server, build_history_enabled)
 
+    if buildinfohelper.brbe is not None and consolelogfile:
+        # if we are under managed mode we have no other UI and we need to write our own file
+        bb.utils.mkdirhier(os.path.dirname(consolelogfile))
+        conlogformat = bb.msg.BBLogFormatter(format_str)
+        consolelog = logging.FileHandler(consolelogfile)
+        bb.msg.addDefaultlogFilter(consolelog)
+        consolelog.setFormatter(conlogformat)
+        logger.addHandler(consolelog)
+
+
     while True:
         try:
             event = eventHandler.waitEvent(0.25)
@@ -115,8 +130,12 @@ def main(server, eventHandler, params ):
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
+                logger.warn("Logfile for task %s" % event.logfile)
                 continue
 
+            if isinstance(event, bb.build.TaskBase):
+                logger.info(event._message)
+
             if isinstance(event, bb.event.LogExecTTY):
                 logger.warn(event.msg)
                 continue
@@ -162,7 +181,12 @@ def main(server, eventHandler, params ):
             if isinstance(event, bb.event.CacheLoadCompleted):
                 continue
             if isinstance(event, bb.event.MultipleProviders):
+                logger.info("multiple providers are available for %s%s (%s)", event._is_runtime and "runtime " or "",
+                            event._item,
+                            ", ".join(event._candidates))
+                logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
                 continue
+
             if isinstance(event, bb.event.NoProvider):
                 return_value = 1
                 errors = errors + 1
@@ -229,6 +253,7 @@ def main(server, eventHandler, params ):
                     buildinfohelper.store_log_event(event)
                     errors += 1
                     errorcode = 1
+                    logger.error("Command execution failed: %s", event.error)
 
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 buildinfohelper.close(errorcode)
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 5d80bc7..1ff5c92 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -62,6 +62,23 @@ class Command(NoArgsCommand):
 
 
     def handle(self, **options):
+        # verify that we have a settings for downloading artifacts
+        while ToasterSetting.objects.filter(name="ARTIFACTS_STORAGE_DIR").count() == 0:
+            guessedpath = os.getcwd() + "/toaster_build_artifacts/"
+            print("Toaster needs to know in which directory it can download build log files and other artifacts.\n Toaster suggests \"%s\"." % guessedpath)
+            artifacts_storage_dir = raw_input(" Press Enter to select \"%s\" or type the full path to a different directory: " % guessedpath)
+            if len(artifacts_storage_dir) == 0:
+                artifacts_storage_dir = guessedpath
+            if len(artifacts_storage_dir) > 0 and artifacts_storage_dir.startswith("/"):
+                try:
+                    os.makedirs(artifacts_storage_dir)
+                except OSError as ose:
+                    if "File exists" in str(ose):
+                        pass
+                    else:
+                        raise ose
+                ToasterSetting.objects.create(name="ARTIFACTS_STORAGE_DIR", value=artifacts_storage_dir)
+
         self.guesspath = DN(DN(DN(DN(DN(DN(DN(__file__)))))))
         # refuse to start if we have no build environments
         while BuildEnvironment.objects.count() == 0:
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 3de582c..808318f 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -1,6 +1,6 @@
 from django.core.management.base import NoArgsCommand, CommandError
 from django.db import transaction
-from orm.models import Build
+from orm.models import Build, ToasterSetting
 from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException, BuildSetupException
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError, BRVariable
 import os
@@ -93,7 +93,33 @@ class Command(NoArgsCommand):
             bec.be.lock = BuildEnvironment.LOCK_FREE
             bec.be.save()
 
+    def archive(self):
+        ''' archives data from the builds '''
+        artifact_storage_dir = ToasterSetting.objects.get(name="ARTIFACTS_STORAGE_DIR").value
+        for br in BuildRequest.objects.filter(state = BuildRequest.REQ_ARCHIVE):
+            # save cooker log
+            if br.build == None:
+                br.state = BuildRequest.REQ_FAILED
+                br.save()
+                continue
+            build_artifact_storage_dir = os.path.join(artifact_storage_dir, "%d" % br.build.pk)
+            try:
+                os.makedirs(build_artifact_storage_dir)
+            except OSError as ose:
+                if "File exists" in str(ose):
+                    pass
+                else:
+                    raise ose
+
+            file_name = os.path.join(build_artifact_storage_dir, "cooker_log.txt")
+            try:
+                with open(file_name, "w") as f:
+                    f.write(br.environment.get_artifact(br.build.cooker_log_path).read())
+            except IOError:
+                os.unlink(file_name)
 
+            br.state = BuildRequest.REQ_COMPLETED
+            br.save()
 
     def cleanup(self):
         from django.utils import timezone
@@ -104,4 +130,5 @@ class Command(NoArgsCommand):
 
     def handle_noargs(self, **options):
         self.cleanup()
+        self.archive()
         self.schedule()
diff --git a/lib/toaster/bldcontrol/migrations/0008_brarchive.py b/lib/toaster/bldcontrol/migrations/0008_brarchive.py
new file mode 100644
index 0000000..f546960
--- /dev/null
+++ b/lib/toaster/bldcontrol/migrations/0008_brarchive.py
@@ -0,0 +1,138 @@
+# -*- coding: utf-8 -*-
+from south.utils import datetime_utils as datetime
+from south.db import db
+from south.v2 import DataMigration
+from django.db import models
+
+class Migration(DataMigration):
+    # ids that cannot be imported from BuildRequest
+
+    def forwards(self, orm):
+        REQ_COMPLETED = 3
+        REQ_ARCHIVE = 6
+        "Write your forwards methods here."
+        # Note: Don't use "from appname.models import ModelName".
+        # Use orm.ModelName to refer to models in this application,
+        # and orm['appname.ModelName'] for models in other applications.
+        orm.BuildRequest.objects.filter(state=REQ_COMPLETED).update(state=REQ_ARCHIVE)
+
+    def backwards(self, orm):
+        REQ_COMPLETED = 3
+        REQ_ARCHIVE = 6
+        "Write your backwards methods here."
+        orm.BuildRequest.objects.filter(state=REQ_ARCHIVE).update(state=REQ_COMPLETED)
+
+    models = {
+        u'bldcontrol.brbitbake': {
+            'Meta': {'object_name': 'BRBitbake'},
+            'commit': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'giturl': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']", 'unique': 'True'})
+        },
+        u'bldcontrol.brerror': {
+            'Meta': {'object_name': 'BRError'},
+            'errmsg': ('django.db.models.fields.TextField', [], {}),
+            'errtype': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']"}),
+            'traceback': ('django.db.models.fields.TextField', [], {})
+        },
+        u'bldcontrol.brlayer': {
+            'Meta': {'object_name': 'BRLayer'},
+            'commit': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'giturl': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']"})
+        },
+        u'bldcontrol.brtarget': {
+            'Meta': {'object_name': 'BRTarget'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']"}),
+            'target': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'task': ('django.db.models.fields.CharField', [], {'max_length': '100', 'null': 'True'})
+        },
+        u'bldcontrol.brvariable': {
+            'Meta': {'object_name': 'BRVariable'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']"}),
+            'value': ('django.db.models.fields.TextField', [], {'blank': 'True'})
+        },
+        u'bldcontrol.buildenvironment': {
+            'Meta': {'object_name': 'BuildEnvironment'},
+            'address': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'bbaddress': ('django.db.models.fields.CharField', [], {'max_length': '254', 'blank': 'True'}),
+            'bbport': ('django.db.models.fields.IntegerField', [], {'default': '-1'}),
+            'bbstate': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'bbtoken': ('django.db.models.fields.CharField', [], {'max_length': '126', 'blank': 'True'}),
+            'betype': ('django.db.models.fields.IntegerField', [], {}),
+            'builddir': ('django.db.models.fields.CharField', [], {'max_length': '512', 'blank': 'True'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'lock': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'sourcedir': ('django.db.models.fields.CharField', [], {'max_length': '512', 'blank': 'True'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'})
+        },
+        u'bldcontrol.buildrequest': {
+            'Meta': {'object_name': 'BuildRequest'},
+            'build': ('django.db.models.fields.related.OneToOneField', [], {'to': u"orm['orm.Build']", 'unique': 'True', 'null': 'True'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            'environment': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildEnvironment']", 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'state': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'})
+        },
+        u'orm.bitbakeversion': {
+            'Meta': {'object_name': 'BitbakeVersion'},
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '32'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'giturl': ('django.db.models.fields.URLField', [], {'max_length': '200'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '32'})
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
+        u'orm.release': {
+            'Meta': {'object_name': 'Release'},
+            'bitbake_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.BitbakeVersion']"}),
+            'branch_name': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '50'}),
+            'description': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'helptext': ('django.db.models.fields.TextField', [], {'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '32'})
+        }
+    }
+
+    complete_apps = ['bldcontrol']
+    symmetrical = True
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index dc4afca..25d94cd 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -94,6 +94,7 @@ class BuildRequest(models.Model):
     REQ_COMPLETED = 3
     REQ_FAILED = 4
     REQ_DELETED = 5
+    REQ_ARCHIVE = 6
 
     REQUEST_STATE = (
         (REQ_CREATED, "created"),
@@ -102,6 +103,7 @@ class BuildRequest(models.Model):
         (REQ_COMPLETED, "completed"),
         (REQ_FAILED, "failed"),
         (REQ_DELETED, "deleted"),
+        (REQ_ARCHIVE, "archive"),
     )
 
     search_allowed_fields = ("brtarget__target",)
diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index e71e38f..684ec65 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -40,7 +40,9 @@
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
         {% for build in objects %}
         <tr class="data">
-            <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
+            <td class="outcome">
+	    <a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a> &nbsp;
+	    </td>
             <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
             <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
             <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
@@ -61,11 +63,6 @@
             <td class="errors_no">
                 {% if  build.errors_no %}
                     <a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
-                    {% if MANAGED and build.project %}
-                        <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
-                            <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
-                        </a>
-                    {% endif %}
                 {%endif%}
             </td>
             <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 2458cdb..c0898e2 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -36,7 +36,11 @@
 {% endif %}
     <span > <i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning show-warnings"> {{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a></strong></span>
 {% endif %}
-            <span class="pull-right">Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a></span>
+            <span class="pull-right">Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a> &nbsp;
+      {% if MANAGED and build.project %}
+            <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%else%}btn-danger{%endif%} pull-right" href="{% url 'build_artifact' build.id "cookerlog" build.id %}">Download build log</a>
+      {% endif %}
+            </span>
 {%endif%}
     </div>
     {% if build.toaster_exceptions.count > 0 %}
@@ -54,10 +58,7 @@
 <div class="accordion span10 pull-right" id="errors">
   <div class="accordion-group">
     <div class="accordion-heading">
-      {% if MANAGED and build.project %}
-          <a class="btn btn-large pull-right" href="{% url 'build_artifact' build.id "cookerlog" build.id %}" style="margin:15px;">Download build log</a>
-      {% endif %}
-      <a class="accordion-toggle error toggle-errors">
+            <a class="accordion-toggle error toggle-errors">
          <h2 id="error-toggle">
            <i class="icon-minus-sign"></i>
            {{build.errors_no}} error{{build.errors_no|pluralize}}
diff --git a/lib/toaster/toastergui/templates/managed_builds.html b/lib/toaster/toastergui/templates/managed_builds.html
index 121ad07..a4db55b 100644
--- a/lib/toaster/toastergui/templates/managed_builds.html
+++ b/lib/toaster/toastergui/templates/managed_builds.html
@@ -46,7 +46,14 @@
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
         {% for buildrequest in objects %}{% if buildrequest.build %}  {% with build=buildrequest.build %} {# if we have a build, just display it #}
         <tr class="data">
-            <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
+            <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a>
+	            {% if build.project %}
+                        &nbsp; <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
+                            <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
+                        </a>
+                    {% endif %}
+
+            </td>
             <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
             <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
             <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index 02d1663..afcf519 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -49,7 +49,14 @@
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
         {% for br in objects %}{% if br.build %}  {% with build=br.build %} {# if we have a build, just display it #}
         <tr class="data">
-            <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
+            <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a>
+                   {% if build.project %}
+                        &nbsp; <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
+                            <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
+                        </a>
+                    {% endif %}
+            </td>
+
             <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
             <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
             <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
@@ -70,11 +77,6 @@
             <td class="errors_no">
                 {% if  build.errors_no %}
                     <a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
-                    {% if MANAGED and build.project %}
-                        <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
-                            <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
-                        </a>
-                    {% endif %}
                 {%endif%}
             </td>
             <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
diff --git a/lib/toaster/toastergui/templates/unavailable_artifact.html b/lib/toaster/toastergui/templates/unavailable_artifact.html
new file mode 100644
index 0000000..c93d425
--- /dev/null
+++ b/lib/toaster/toastergui/templates/unavailable_artifact.html
@@ -0,0 +1,17 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+{% load static %}
+
+{% block pagecontent %}
+<div class="section">
+</div>
+<div class="row-fluid">
+
+    <div class="alert alert-info">
+    <p class="lead"> The artifact you are seeking to download is not available. We are sorry. You can <a href="javascript:window.history.back()">go back</a>
+    </p>
+    </div>
+</div>
+{% endblock %}
+
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index b5ff9b1..eb323ec 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2914,9 +2914,6 @@ if toastermain.settings.MANAGED:
         if artifact_type == "imagefile":
             file_name = Target_Image_File.objects.get(target__build = b, pk = artifact_id).file_name
 
-        elif artifact_type == "cookerlog":
-            file_name = b.cooker_log_path
-
         elif artifact_type == "buildartifact":
             file_name = BuildArtifact.objects.get(build = b, pk = artifact_id).file_name
 
@@ -2935,26 +2932,87 @@ if toastermain.settings.MANAGED:
 
 
     def build_artifact(request, build_id, artifact_type, artifact_id):
-        b = Build.objects.get(pk=build_id)
-        if b.buildrequest is None or b.buildrequest.environment is None:
-            raise Exception("Artifact not available for download (missing build request or build environment)")
+        if artifact_type in ["cookerlog"]:
+            # these artifacts are saved after building, so they are on the server itself
+            def _mimetype_for_artifact(path):
+                try:
+                    import magic
+
+                    # fair warning: this is a mess; there are multiple competing and incompatible
+                    # magic modules floating around, so we try some of the most common combinations
+
+                    try:    # we try ubuntu's python-magic 5.4
+                        m = magic.open(magic.MAGIC_MIME_TYPE)
+                        m.load()
+                        return m.file(path)
+                    except AttributeError:
+                        pass
+
+                    try:    # we try python-magic 0.4.6
+                        m = magic.Magic(magic.MAGIC_MIME)
+                        return m.from_file(path)
+                    except AttributeError:
+                        pass
+
+                    try:    # we try pip filemagic 1.6
+                        m = magic.Magic(flags=magic.MAGIC_MIME_TYPE)
+                        return m.id_filename(path)
+                    except AttributeError:
+                        pass
+
+                    return "binary/octet-stream"
+                except ImportError:
+                    return "binary/octet-stream"
+            try:
+                # match code with runbuilds.Command.archive()
+                build_artifact_storage_dir = os.path.join(ToasterSetting.objects.get(name="ARTIFACTS_STORAGE_DIR").value, "%d" % int(build_id))
+                file_name = os.path.join(build_artifact_storage_dir, "cooker_log.txt")
+
+                fsock = open(file_name, "r")
+                content_type=_mimetype_for_artifact(file_name)
 
-        file_name = _file_name_for_artifact(b, artifact_type, artifact_id)
-        fsock = None
-        content_type='application/force-download'
+                response = HttpResponse(fsock, content_type = content_type)
+
+                response['Content-Disposition'] = 'attachment; filename=' + os.path.basename(file_name)
+                return response
+            except IOError:
+                context = {
+                    'build' : Build.objects.get(pk = build_id),
+                }
+                return render(request, "unavailable_artifact.html", context)
 
-        if file_name is None:
-            raise Exception("Could not handle artifact %s id %s" % (artifact_type, artifact_id))
         else:
-            content_type = b.buildrequest.environment.get_artifact_type(file_name)
-            fsock = b.buildrequest.environment.get_artifact(file_name)
-            file_name = os.path.basename(file_name) # we assume that the build environment system has the same path conventions as host
+            # retrieve the artifact directly from the build environment
+            return _get_be_artifact(request, build_id, artifact_type, artifact_id)
 
-        response = HttpResponse(fsock, content_type = content_type)
 
-        # returns a file from the environment
-        response['Content-Disposition'] = 'attachment; filename=' + file_name
-        return response
+    def _get_be_artifact(request, build_id, artifact_type, artifact_id):
+        try:
+            b = Build.objects.get(pk=build_id)
+            if b.buildrequest is None or b.buildrequest.environment is None:
+                raise Exception("Artifact not available for download (missing build request or build environment)")
+
+            file_name = _file_name_for_artifact(b, artifact_type, artifact_id)
+            fsock = None
+            content_type='application/force-download'
+
+            if file_name is None:
+                raise Exception("Could not handle artifact %s id %s" % (artifact_type, artifact_id))
+            else:
+                content_type = b.buildrequest.environment.get_artifact_type(file_name)
+                fsock = b.buildrequest.environment.get_artifact(file_name)
+                file_name = os.path.basename(file_name) # we assume that the build environment system has the same path conventions as host
+
+            response = HttpResponse(fsock, content_type = content_type)
+
+            # returns a file from the environment
+            response['Content-Disposition'] = 'attachment; filename=' + file_name
+            return response
+        except IOError:
+            context = {
+                'build' : Build.objects.get(pk = build_id),
+            }
+            return render(request, "unavailable_artifact.html", context)
 
 
 
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index f66f11d..395c4e8 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -50,12 +50,12 @@ import toastermain.settings
 
 if toastermain.settings.FRESH_ENABLED:
     urlpatterns.insert(1, url(r'', include('fresh.urls')))
-    logger.info("Enabled django-fresh extension")
+    #logger.info("Enabled django-fresh extension")
 
 if toastermain.settings.DEBUG_PANEL_ENABLED:
     import debug_toolbar
     urlpatterns.insert(1, url(r'', include(debug_toolbar.urls)))
-    logger.info("Enabled django_toolbar extension")
+    #logger.info("Enabled django_toolbar extension")
 
 
 if toastermain.settings.MANAGED:
@@ -86,4 +86,4 @@ for t in os.walk(os.path.dirname(currentdir)):
             logger.warn("Module \'%s\' has a regexp conflict, was not added to the urlpatterns" % modulename)
 
 from pprint import pformat
-logger.debug("urlpatterns list %s", pformat(urlpatterns))
+#logger.debug("urlpatterns list %s", pformat(urlpatterns))
-- 
1.9.1


