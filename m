Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 7B0BC758E1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:24 +0000 (UTC)
Received: by wicnd19 with SMTP id nd19so159814375wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=5Ut8UrxGQrl/aiQ0aayd7wRognwOcVkN9eLSmZIXsiM=;
	b=c/V5PR4u8X1+RpYix8Uh98j1XSNlb416HFVEiuc0QmfSwkHT0kjufZD6s6WCKbHS8j
	tkbkEzeP2To7d3lP2ya9AR0O3LTCiwWRB2kwN7CtEmnQwXb1rl9x9QoagvsRkC6U7Rbs
	0md1YeDLgkznjMdUIU95o45pZ7Rdn9hkko/VS3GY56J+RyR0YvFV05kVv3ZkVVRkulzs
	J5YpN/XK5MayGVW1NEmhT+FBWaFjAAJdXls+w0YCzfHeA0C1BFf4MnZCFjv+e3Bd1UZE
	1uHEYf2E/bKRJV7YKOW8xItnPXS47UkzlN/a9f0oUfgNeIvVpPUKvjGovtoPxnRX8mqO
	mrdQ==
X-Gm-Message-State: ALoCoQnE7RUxDLg9ZCGq2os7Wn6NXco/3Wk1lUcjXcFk+n9VgSKsmy4wgKFbgRWuVnpbSafM4NL3
X-Received: by 10.194.178.201 with SMTP id da9mr78495021wjc.139.1435228464960; 
	Thu, 25 Jun 2015 03:34:24 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id jy6sm40152729wjc.4.2015.06.25.03.34.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:24 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CAD1D56254D; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:45 +0100
Message-Id: <51a41172d0b390370f9a38696b1ac65666ada4d2.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 08/23] toaster: fill in build data from buildrequest
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:24 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds logic to complete changing the interface
from showing BuildRequests to showing Build data.

The BuildRequest data is now transformed in Build data with
proper Toaster exceptions being recorded instead of listing
problems during startup as build errors.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       | 16 ++++++++++-
 .../bldcontrol/management/commands/runbuilds.py    | 32 +++++++++++++++++++++-
 lib/toaster/orm/models.py                          | 28 +++++++++++++++++--
 lib/toaster/toastergui/templates/project.html      | 15 +++++++---
 lib/toaster/toastergui/views.py                    |  4 +--
 5 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 3ea842c..8b63f70 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -133,7 +133,21 @@ class ORMWrapper(object):
             logger.debug(1, "buildinfohelper: project is not specified, defaulting to %s" % prj)
 
 
-        build = Build.objects.create(
+        if buildrequest is not None:
+            build = buildrequest.build
+            build.machine=build_info['machine'],
+            build.distro=build_info['distro'],
+            build.distro_version=build_info['distro_version'],
+            build.completed_on=build_info['started_on'],
+            build.cooker_log_path=build_info['cooker_log_path'],
+            build.build_name=build_info['build_name'],
+            build.bitbake_version=build_info['bitbake_version']
+            build.save()
+
+            build.target_set.delete()
+
+        else:
+            build = Build.objects.create(
                                     project = prj,
                                     machine=build_info['machine'],
                                     distro=build_info['distro'],
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 920d9ef..da7d4af 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -1,6 +1,6 @@
 from django.core.management.base import NoArgsCommand, CommandError
 from django.db import transaction
-from orm.models import Build, ToasterSetting
+from orm.models import Build, ToasterSetting, LogMessage, Target
 from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException, BuildSetupException
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError, BRVariable
 import os
@@ -109,6 +109,36 @@ class Command(NoArgsCommand):
         from datetime import timedelta
         # DISABLED environments locked for more than 30 seconds - they should be unlocked
         #BuildEnvironment.objects.filter(lock=BuildEnvironment.LOCK_LOCK).filter(updated__lt = timezone.now() - timedelta(seconds = 30)).update(lock = BuildEnvironment.LOCK_FREE)
+
+
+        # update all Builds that failed to start
+
+        for br in BuildRequest.objects.filter(state = BuildRequest.REQ_FAILED):
+            br.build.outcome = Build.FAILED
+            # transpose the launch errors in ToasterExceptions
+            for brerror in br.brerror_set.all():
+                LogMessage.objects.create(build = br.build, level = LogMessage.EXCEPTION, message = brerror.errmsg)
+            br.build.save()
+
+
+
+        # update all BuildRequests without a build created
+        for br in BuildRequest.objects.filter(build = None):
+            br.build = Build.objects.create(project = br.project, completed_on = br.updated, started_on = br.created)
+            br.build.outcome = Build.REQ_FAILED
+            try:
+                br.build.machine = br.brvariable_set.get(name='MACHINE').value
+            except BRVariable.DoesNotExist:
+                pass
+            br.save()
+            # transpose target information
+            for brtarget in br.brtarget_set.all():
+                Target.objects.create(build = br.build, target= brtarget.target)
+            # transpose the launch errors in ToasterExceptions
+            for brerror in br.brerror_set.all():
+                LogMessage.objects.create(build = br.build, level = LogMessage.EXCEPTION, message = brerror.errmsg)
+
+            br.build.save()
         pass
 
 
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 422f2bf..d97eadb 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -201,16 +201,32 @@ class Project(models.Model):
                 commit = l.layercommit.get_vcs_reference()
                 print("ii Building layer ", l.layercommit.layer.name, " at vcs point ", commit)
                 BRLayer.objects.create(req = br, name = l.layercommit.layer.name, giturl = l.layercommit.layer.vcs_url, commit = commit, dirpath = l.layercommit.dirpath)
+
+            br.state = BuildRequest.REQ_QUEUED
+            now = timezone.now()
+            br.build = Build.objects.create(project = self,
+                                completed_on=now,
+                                started_on=now,
+                                )
             for t in self.projecttarget_set.all():
                 BRTarget.objects.create(req = br, target = t.target, task = t.task)
+                Target.objects.create(build = br.build, target = t.target)
+
             for v in self.projectvariable_set.all():
                 BRVariable.objects.create(req = br, name = v.name, value = v.value)
 
-            br.state = BuildRequest.REQ_QUEUED
+
+            try:
+                br.build.machine = self.projectvariable_set.get(name = 'MACHINE').value
+                br.build.save()
+            except ProjectVariable.DoesNotExist:
+                pass
             br.save()
         except Exception as e:
             br.delete()
-            raise e
+            import sys
+            et, ei, tb = sys.exc_info()
+            raise type(e), e, tb
         return br
 
 class Build(models.Model):
@@ -250,7 +266,6 @@ class Build(models.Model):
         return completeper
 
     def eta(self):
-        from django.utils import timezone
         eta = timezone.now()
         completeper = self.completeper()
         if self.completeper() > 0:
@@ -266,6 +281,12 @@ class Build(models.Model):
     def toaster_exceptions(self):
         return self.logmessage_set.filter(level=LogMessage.EXCEPTION)
 
+
+    def get_current_status(self):
+        if self.outcome == Build.IN_PROGRESS and self.build_name == "":
+            return "Queued"
+        return self.get_outcome_display()
+
     def __str__(self):
         return "%d %s %s" % (self.id, self.project, ",".join([t.target for t in self.target_set.all()]))
 
@@ -299,6 +320,7 @@ class Target(models.Model):
     search_allowed_fields = ['target', 'file_name']
     build = models.ForeignKey(Build)
     target = models.CharField(max_length=100)
+    task = models.CharField(max_length=100, null=True)
     is_image = models.BooleanField(default = False)
     image_size = models.IntegerField(default=0)
     license_manifest_path = models.CharField(max_length=500, null=True)
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 0f6a77b..1a8991f 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -114,7 +114,7 @@ vim: expandtab tabstop=2
 
   <script type="text/ng-template" id="target_display">
       <div data-ng-switch on="t.task.length">
-        <div data-ng-switch-when="0">{[t.target]}</div>
+        <div data-ng-switch-when="undefined">{[t.target]}</div>
         <div data-ng-switch-default>{[t.target]}:{[t.task]}</div>
       </div>
   </script>
@@ -145,13 +145,13 @@ vim: expandtab tabstop=2
 
   <a id="buildslist"></a>
   <h2 class="air" data-ng-if="builds.length">Latest builds</h2>
-  <div class="animate-repeat alert"  data-ng-repeat="b in builds track by b.id" data-ng-class="{'In Progress':'alert-info', 'Succeeded':'alert-success', 'Failed':'alert-error'}[b.status]">
+  <div class="animate-repeat alert"  data-ng-repeat="b in builds track by b.id" data-ng-class="{'Queued':'alert-info', 'In Progress':'alert-info', 'Succeeded':'alert-success', 'Failed':'alert-error'}[b.status]">
     <div class="row-fluid">
         <switch data-ng-switch="b.status">
 
           <case data-ng-switch-when="Failed">
             <div class="lead span3">
-              <a data-ng-class="{'succeeded': 'success', 'failed': 'error'}[b.status]" href="{[b.br_page_url]}">
+              <a data-ng-class="{'Succeeded': 'success', 'Failed': 'error'}[b.status]" href="{[b.br_page_url]}">
                 <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>
               </a>
             </div>
@@ -176,12 +176,19 @@ vim: expandtab tabstop=2
               <!-- we don't have warnings in this case -->
             </div>
             <div> <span class="lead">Build time: {[b.command_time|timediff]}</span>
-                <button class="btn pull-right" data-ng-class="{'succeeded':  'btn-success', 'failed': 'btn-danger'}[b.status]"
+                <button class="btn pull-right" data-ng-class="{'Succeeded':  'btn-success', 'Failed': 'btn-danger'}[b.status]"
                     data-ng-click="buildExistingTarget(b.targets)">Run again</button>
 
             </div>
           </case>
 
+          <case data-ng-switch-when="Queued">
+            <div class="lead span5"> <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>   </div>
+            <div class="span4 lead" >Build queued
+              <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
+            </div>
+            <button class="btn pull-right btn-info" data-ng-click="buildCancel(b)">Cancel</button>
+          </case>
 
           <case data-ng-switch-when="In Progress">
             <switch data-ng-switch="b.build.length">
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 0324d17..2336ae3 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -74,8 +74,8 @@ def _project_recent_build_list(prj):
     for x in _get_latest_builds(prj):
         d = {
             "id":  x.pk,
-            "targets" : map(lambda y: {"target": y.target, "task": None }, x.target_set.all()), # TODO: create the task entry in the Target table
-            "status": x.get_outcome_display(),
+            "targets" : map(lambda y: {"target": y.target, "task": y.task }, x.target_set.all()), # TODO: create the task entry in the Target table
+            "status": x.get_current_status(),
             "errors": map(lambda y: {"type": y.lineno, "msg": y.message, "tb": y.pathname}, x.logmessage_set.filter(level__gte=LogMessage.WARNING)),
             "updated": x.completed_on.strftime('%s')+"000",
             "command_time": (x.completed_on - x.started_on).total_seconds(),
-- 
1.9.1


