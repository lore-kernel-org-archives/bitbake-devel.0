Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 107C275710
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:16:49 +0000 (UTC)
Received: by wgbgq6 with SMTP id gq6so37824235wgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=+lKn66rdFB6hlCd7HVNoc/ff/dr7qGJ0pFlo5p5Bvp8=;
	b=QJNe0NTdUDvsMDqg7+4XQ5hcqWVH8Jh3OHKXKTm1FU9R6CuTCj4xlsbG6yRygsl5Ih
	0yrjjMpudB9XSBPYyMEKTCnnglB9FM1tGgErX4pjgBtAmzqGUhDRbBDRIEc1984PGn+l
	9Ni7qME5zDK4qscFMOTExhgfWv/o3birg89H/3UutuXl9O+q/Mdi1gHVMD0a6JHBoZB6
	ItnV1yuJANIV6QKXw5mZAnLTL67T+hSRWupwAp2dT90eemcGUSUy+r37a+dJYWaF6t+P
	V7kSPY9fGCqvP7ggzjrvKY6aY6nPxPXLYeJ7ZQIGHoSCh3PjlmTidf3F8LPfrWzwlK7H
	OBtg==
X-Gm-Message-State: ALoCoQm+f7GVTRd1ucbGTHMSEMCmYUSj8QRiO0GYPLydkYhCisUIsv6fs/tFQnT4oX3rIx8GpNtE
X-Received: by 10.180.218.195 with SMTP id pi3mr16705355wic.71.1432822610672; 
	Thu, 28 May 2015 07:16:50 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id be3sm4193779wib.21.2015.05.28.07.16.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:16:49 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CBA10561301; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:07 +0100
Message-Id: <eaad87348fd23a6faaf1a201fae3481a8274f787.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 13/22] toaster: refactor checksettings command
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
X-List-Received-Date: Thu, 28 May 2015 14:16:50 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch refactors the checksetting command to prevent
early return from the handle function.

It also adds a check that marks IN PROGRESS builds at startup time
as FAILED. Minor changes to BuildRequest and Build classes
ensure useful string representation for the objects.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../management/commands/checksettings.py           | 26 ++++++++++++++++++++--
 lib/toaster/bldcontrol/models.py                   |  3 +++
 lib/toaster/orm/models.py                          |  3 +++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 1ff5c92..3c52446 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -2,7 +2,7 @@ from django.core.management.base import NoArgsCommand, CommandError
 from django.db import transaction
 from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError
-from orm.models import ToasterSetting
+from orm.models import ToasterSetting, Build
 import os
 
 def DN(path):
@@ -61,7 +61,7 @@ class Command(NoArgsCommand):
         return DN(self._find_first_path_for_file(DN(self.guesspath), "bblayers.conf", 4))
 
 
-    def handle(self, **options):
+    def _verify_artifact_storage_dir(self):
         # verify that we have a settings for downloading artifacts
         while ToasterSetting.objects.filter(name="ARTIFACTS_STORAGE_DIR").count() == 0:
             guessedpath = os.getcwd() + "/toaster_build_artifacts/"
@@ -78,7 +78,10 @@ class Command(NoArgsCommand):
                     else:
                         raise ose
                 ToasterSetting.objects.create(name="ARTIFACTS_STORAGE_DIR", value=artifacts_storage_dir)
+        return 0
+
 
+    def _verify_build_environment(self):
         self.guesspath = DN(DN(DN(DN(DN(DN(DN(__file__)))))))
         # refuse to start if we have no build environments
         while BuildEnvironment.objects.count() == 0:
@@ -197,12 +200,16 @@ class Command(NoArgsCommand):
 
             while (_verify_be()):
                 pass
+        return 0
 
+    def _verify_default_settings(self):
         # verify that default settings are there
         if ToasterSetting.objects.filter(name = 'DEFAULT_RELEASE').count() != 1:
             ToasterSetting.objects.filter(name = 'DEFAULT_RELEASE').delete()
             ToasterSetting.objects.get_or_create(name = 'DEFAULT_RELEASE', value = '')
+        return 0
 
+    def _verify_builds_in_progress(self):
         # we are just starting up. we must not have any builds in progress, or build environments taken
         for b in BuildRequest.objects.filter(state = BuildRequest.REQ_INPROGRESS):
             BRError.objects.create(req = b, errtype = "toaster", errmsg = "Toaster found this build IN PROGRESS while Toaster started up. This is an inconsistent state, and the build was marked as failed")
@@ -211,4 +218,19 @@ class Command(NoArgsCommand):
 
         BuildEnvironment.objects.update(lock = BuildEnvironment.LOCK_FREE)
 
+        # also mark "In Progress builds as failures"
+        from django.utils import timezone
+        Build.objects.filter(outcome = Build.IN_PROGRESS).update(outcome = Build.FAILED, completed_on = timezone.now())
+
         return 0
+
+
+
+    def handle(self, **options):
+        retval = 0
+        retval += self._verify_artifact_storage_dir()
+        retval += self._verify_build_environment()
+        retval += self._verify_default_settings()
+        retval += self._verify_builds_in_progress()
+
+        return retval
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 02cfaf7..b789446 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -125,6 +125,9 @@ class BuildRequest(models.Model):
     def get_machine(self):
         return self.brvariable_set.get(name="MACHINE").value
 
+    def __str__(self):
+        return "%s %s" % (self.project, self.get_state_display())
+
 # These tables specify the settings for running an actual build.
 # They MUST be kept in sync with the tables in orm.models.Project*
 
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index fb62a55..8a9a21e 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -267,6 +267,9 @@ class Build(models.Model):
     def toaster_exceptions(self):
         return self.logmessage_set.filter(level=LogMessage.EXCEPTION)
 
+    def __str__(self):
+        return "%d %s %s" % (self.id, self.project, ",".join([t.target for t in self.target_set.all()]))
+
 
 # an Artifact is anything that results from a Build, and may be of interest to the user, and is not stored elsewhere
 class BuildArtifact(models.Model):
-- 
1.9.1


