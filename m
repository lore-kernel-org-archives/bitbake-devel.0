Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 0A4ED605FE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 13:58:08 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id p65so29808991wmp.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 05:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=tM5lbrTvA53qicLkJxVunmHRbm1ip+JA/LKGCAKc6aA=;
	b=Hr1M9HjHPV2wVphw7IZ12VQ5V/ansOTL7w7PanN34NBWs0brUGbYjocJI6oC31Nb2Y
	vk4I8oE01uUHJrreQULD1mG9M5fJ3iV1mnu2iNz7GineQ1vZkS53fZuyiMLJPDGrI+vj
	W2lj4NEBHSZQZUj9lMCIFU+7NGUuW9cl6/8mD0KJph7YJi+Jqzz5EunG8R+TLYzKKCjV
	qo6kMgXa28gVamhs1m7yzGCvwic3AweGLHe5e5XcaU+bsJkaOqTWiQX2uQlsNGclMEEI
	6CTXho6Nnhr1PrK90rYGHH4DxWpjN5tunNlQWHoB5C5T4aIxotn8U9MdbWI1b6DfDRey
	Klpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=tM5lbrTvA53qicLkJxVunmHRbm1ip+JA/LKGCAKc6aA=;
	b=Pwl1dax6qhM+DkbtCI5xWMvADUi+tagmBa8yPgfbcLmYPUf5eSqpDs+qhV6H+EZXNG
	prn27IrJKAxL6Nkt44GoV++AoWAf1qaBE+KwTF9f7SSEZqH7IarSH2Jw6mqJcX3lZlWG
	4i6Et4q1cG1/wrXdGpceNOmTuzA4Rdt1luXeQsfng3fcLE/itzdb1IXHq5XJh5Z1E48U
	CoWKcYzG1oOJ5hbEwFqQGKy1+EEfXqkOL6GtLjaO1siinpODctS88u90IkRFG76dfAUe
	dEJ0/jV76+Eg8bPUPvm9pFim8OUKy7DeBdqAimJa1OByAeNlOMjtNJt0zvMXZBGsG8fe
	UOLw==
X-Gm-Message-State: AD7BkJJKkq9z0+l8eB78nDvfTlXIWjeyZYm8PIV1/R++n3CdnkASoh9DQrJIZEiS8WEuy+EP
X-Received: by 10.28.172.132 with SMTP id v126mr4210731wme.28.1457618288441;
	Thu, 10 Mar 2016 05:58:08 -0800 (PST)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	c128sm3677424wma.11.2016.03.10.05.58.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 10 Mar 2016 05:58:07 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Mar 2016 13:57:55 +0000
Message-Id: <1457618275-7801-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1457618275-7801-1-git-send-email-michael.g.wood@intel.com>
References: <1457618275-7801-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH] toaster: create Build object earlier in bitbake processing
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
X-List-Received-Date: Thu, 10 Mar 2016 13:58:09 -0000

From: Elliot Smith <elliot.smith@intel.com>

If a build fails because of a bitbake error occurring before the
BuildStarted event fires, we do not generate a Build object
for command-line builds. This means that failed command-line builds
don't appear in Toaster at all.

To resolve, split build creation into two steps:

1. Just before buildTargets() is invoked on the XMLRPC server: create
the base Build object. Note that as soon as a Toaster-triggered
build starts, targets are added to it; but this event is the earliest
point when task and targets are available for command-line builds.
(This requires a new TargetsAcquired event to be fired by the XMLRPC
server when the buildTargets() command is called.)

2. BuildStarted event: add any layer information to either type of build
(command-line or Toaster-triggered).

Note that the build_name property cannot be set until BuildStarted,
as it is not available until then, which could cause problems
for creating Build objects earlier; however, this property is
redundant, as it's never used anywhere in Toaster, so it has been
removed (along with any functions which refer to it).

[YOCTO #8440]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/event.py                                    |  7 +++
 lib/bb/server/xmlrpc.py                            |  3 +
 lib/bb/ui/buildinfohelper.py                       | 73 ++++++++++------------
 lib/bb/ui/toasterui.py                             | 17 ++---
 .../orm/migrations/0006_remove_build_build_name.py | 18 ++++++
 lib/toaster/orm/models.py                          |  1 -
 .../fixtures/toastergui-unittest-data.xml          |  4 --
 7 files changed, 71 insertions(+), 52 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0006_remove_build_build_name.py

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 5ffe89e..e94cdb8 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -444,6 +444,13 @@ class MultipleProviders(Event):
         """
         return self._candidates
 
+class TargetsAcquired(Event):
+    """Target we are aiming at known"""
+    def __init__(self, task, targetsList):
+        Event.__init__(self)
+        self.task = task
+        self.targetsList = targetsList
+
 class ParseStarted(OperationStarted):
     """Recipe parsing for the runqueue has begun"""
     def __init__(self, total):
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 7528138..a79b490 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -112,6 +112,9 @@ class BitBakeServerCommands():
         """
         Run a cooker command on the server
         """
+        if 'buildTargets' in command[0]:
+            bb.event.fire(bb.event.TargetsAcquired(command[2], command[1]), self.server.readonly)
+
         return self.cooker.command.runCommand(command, self.server.readonly)
 
     def getEventHandle(self):
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 7fedb76..7805086 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -134,13 +134,12 @@ class ORMWrapper(object):
     # pylint: disable=bad-continuation
     # we do not follow the python conventions for continuation indentation due to long lines here
 
-    def create_build_object(self, build_info, brbe, project_id):
+    def create_build_object(self, build_info, brbe, project_id = None):
         assert 'machine' in build_info
         assert 'distro' in build_info
         assert 'distro_version' in build_info
         assert 'started_on' in build_info
         assert 'cooker_log_path' in build_info
-        assert 'build_name' in build_info
         assert 'bitbake_version' in build_info
 
         prj = None
@@ -168,7 +167,6 @@ class ORMWrapper(object):
             build.distro=build_info['distro']
             build.distro_version=build_info['distro_version']
             build.cooker_log_path=build_info['cooker_log_path']
-            build.build_name=build_info['build_name']
             build.bitbake_version=build_info['bitbake_version']
             build.save()
 
@@ -181,7 +179,6 @@ class ORMWrapper(object):
                                     started_on=build_info['started_on'],
                                     completed_on=build_info['started_on'],
                                     cooker_log_path=build_info['cooker_log_path'],
-                                    build_name=build_info['build_name'],
                                     bitbake_version=build_info['bitbake_version'])
 
         logger.debug(1, "buildinfohelper: build is created %s" % build)
@@ -875,7 +872,6 @@ class BuildInfoHelper(object):
         build_info['started_on'] = timezone.now()
         build_info['completed_on'] = timezone.now()
         build_info['cooker_log_path'] = build_log_path
-        build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
         build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
         build_info['project'] = self.project = self.server.runCommand(["getVariable", "TOASTER_PROJECT"])[0]
         return build_info
@@ -940,26 +936,6 @@ class BuildInfoHelper(object):
 
         return recipe_info
 
-    def _get_path_information(self, task_object):
-        assert isinstance(task_object, Task)
-        build_stats_format = "{tmpdir}/buildstats/{buildname}/{package}/"
-        build_stats_path = []
-
-        for t in self.internal_state['targets']:
-            buildname = self.internal_state['build'].build_name
-            pe, pv = task_object.recipe.version.split(":",1)
-            if len(pe) > 0:
-                package = task_object.recipe.name + "-" + pe + "_" + pv
-            else:
-                package = task_object.recipe.name + "-" + pv
-
-            build_stats_path.append(build_stats_format.format(tmpdir=self.tmp_dir,
-                                                     buildname=buildname,
-                                                     package=package))
-
-        return build_stats_path
-
-
     ################################
     ## external available methods to store information
     @staticmethod
@@ -983,17 +959,43 @@ class BuildInfoHelper(object):
             except NotExisting as nee:
                 logger.warn("buildinfohelper: cannot identify layer exception:%s ", nee)
 
-
-    def store_started_build(self, event, build_log_path):
-        assert '_pkgs' in vars(event)
+    def store_new_build(self, build_log_path):
+        """
+        create a skeletal build object (or retrieve an existing one) as soon as
+        bitbake starts trying to do the build; we use the buildTargets()
+        command on the XMLRPC server as the indicator of a build start
+        """
         build_information = self._get_build_information(build_log_path)
+        self.internal_state['build'] = self.orm_wrapper.create_build_object(build_information, self.brbe)
 
-        # Update brbe and project as they can be changed for every build
-        self.project = build_information['project']
+    def store_targets(self, event):
+        """
+        store targets for the current build, if that build was started from
+        the command line; targets for non-cli builds are irrelevant, as we
+        create them from the BuildRequest anyway
+
+        event: a TargetsAcquired event with a task property (e.g. "build")
+        and a targetsList property (e.g. ["zlib", "dropbear"])
+        """
+        if self.internal_state['build'].project.is_default:
+            targets = map(lambda target: target + ':' + event.task, event.targetsList)
+
+            target_information = {
+              'targets': targets,
+              'build': self.internal_state['build']
+            }
+
+            self.internal_state['targets'] = self.orm_wrapper.get_or_create_targets(target_information)
 
-        build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe, self.project)
+    def update_build(self, event):
+        """
+        update the current build with layer and config data once it
+        actually starts
+
+        event: a BuildStarted event
+        """
 
-        self.internal_state['build'] = build_obj
+        build_obj = self.internal_state['build']
 
         # save layer version information for this build
         if not 'lvs' in self.internal_state:
@@ -1004,13 +1006,6 @@ class BuildInfoHelper(object):
 
             del self.internal_state['lvs']
 
-        # create target information
-        target_information = {}
-        target_information['targets'] = event._pkgs
-        target_information['build'] = build_obj
-
-        self.internal_state['targets'] = self.orm_wrapper.get_or_create_targets(target_information)
-
         # Save build configuration
         data = self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0]
 
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index eee8d14..ee40110 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -119,6 +119,7 @@ _evt_list = [
     "bb.event.RecipeParsed",
     "bb.event.SanityCheck",
     "bb.event.SanityCheckPassed",
+    "bb.event.TargetsAcquired",
     "bb.event.TreeDataPreparationCompleted",
     "bb.event.TreeDataPreparationStarted",
     "bb.runqueue.runQueueTaskCompleted",
@@ -231,19 +232,19 @@ def main(server, eventHandler, params):
             # pylint: disable=protected-access
             # the code will look into the protected variables of the event; no easy way around this
 
-            # we treat ParseStarted as the first event of toaster-triggered
-            # builds; that way we get the Build Configuration included in the log
-            # and any errors that occur before BuildStarted is fired
-            if isinstance(event, bb.event.ParseStarted):
+            # start of build: this event is fired just before the buildTargets()
+            # command is invoked on the XMLRPC server
+            if isinstance(event, bb.event.TargetsAcquired):
                 if not (build_log and build_log_file_path):
                     build_log, build_log_file_path = _open_build_log(log_dir)
+                buildinfohelper.store_new_build(build_log_file_path)
+                buildinfohelper.store_targets(event)
                 continue
 
+            # when the build proper starts, we extract information about
+            # any layers and config data
             if isinstance(event, bb.event.BuildStarted):
-                if not (build_log and build_log_file_path):
-                    build_log, build_log_file_path = _open_build_log(log_dir)
-
-                buildinfohelper.store_started_build(event, build_log_file_path)
+                buildinfohelper.update_build(event)
                 continue
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
diff --git a/lib/toaster/orm/migrations/0006_remove_build_build_name.py b/lib/toaster/orm/migrations/0006_remove_build_build_name.py
new file mode 100644
index 0000000..6036359
--- /dev/null
+++ b/lib/toaster/orm/migrations/0006_remove_build_build_name.py
@@ -0,0 +1,18 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0005_task_field_separation'),
+    ]
+
+    operations = [
+        migrations.RemoveField(
+            model_name='build',
+            name='build_name',
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index add2ade..3c98c0b 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -375,7 +375,6 @@ class Build(models.Model):
     completed_on = models.DateTimeField()
     outcome = models.IntegerField(choices=BUILD_OUTCOME, default=IN_PROGRESS)
     cooker_log_path = models.CharField(max_length=500)
-    build_name = models.CharField(max_length=100)
     bitbake_version = models.CharField(max_length=50)
 
     @staticmethod
diff --git a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
index 2d83ff8..a554e62 100644
--- a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
+++ b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
@@ -39,7 +39,6 @@
     <field type="DateTimeField" name="completed_on">2016-02-14T18:46:20.114530+00:00</field>
     <field type="IntegerField" name="outcome">0</field>
     <field type="CharField" name="cooker_log_path"></field>
-    <field type="CharField" name="build_name">a</field>
     <field type="CharField" name="bitbake_version"></field>
   </object>
   <object pk="2" model="orm.build">
@@ -51,7 +50,6 @@
     <field type="DateTimeField" name="completed_on">2016-02-13T18:46:20.114530+00:00</field>
     <field type="IntegerField" name="outcome">0</field>
     <field type="CharField" name="cooker_log_path"></field>
-    <field type="CharField" name="build_name">b</field>
     <field type="CharField" name="bitbake_version"></field>
   </object>
   <object pk="3" model="orm.build">
@@ -63,7 +61,6 @@
     <field type="DateTimeField" name="completed_on">2016-02-12T18:46:20.114530+00:00</field>
     <field type="IntegerField" name="outcome">1</field>
     <field type="CharField" name="cooker_log_path"></field>
-    <field type="CharField" name="build_name">c</field>
     <field type="CharField" name="bitbake_version"></field>
   </object>
   <object pk="4" model="orm.build">
@@ -75,7 +72,6 @@
     <field type="DateTimeField" name="completed_on">2016-02-11T18:46:20.114530+00:00</field>
     <field type="IntegerField" name="outcome">0</field>
     <field type="CharField" name="cooker_log_path"></field>
-    <field type="CharField" name="build_name">d</field>
     <field type="CharField" name="bitbake_version"></field>
   </object>
   <object pk="1" model="orm.target">
-- 
2.1.4


