Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
	[74.125.82.172])
	by mail.openembedded.org (Postfix) with ESMTP id 87EC060670
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 21:42:14 +0000 (UTC)
Received: by wevm14 with SMTP id m14so15050997wev.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 13:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=TIVGWVvCvl44NcIFaVIUe7Evb/RZzJCCBvZ/kUiUJY4=;
	b=MbKiBalGsO/RUUvmIGcVfe0exY9OT+8lKMJmie5DurPgmvN8QNl+Xyt3RiVai/Qw93
	tDLnYkUqkU6V90PkXDg0tagcsYf2VHDndKl7EV25MDOYyfA3Ojj9skchLUrNgtZTiGop
	EwssrzWiCb1t2rLpi2YuGDGOJ04noZbhGA+QP/cZIW8C9ywp3MhGzzhnwbBwg6KwYy4v
	7CupiRZM8mLiv7pH915swkMFseiiG49LMbMJWKFVo5KAsH8r1VUL8v/e8e2UKNm41Ap2
	o8WeXGT5yGciyKw799qjPPNFUHneItXR9J14+V8C49To7tiT9/qgn4rwZ/aLO7cB9Dz2
	qLQA==
X-Gm-Message-State: ALoCoQkkSlrmdlVqlLqHFdxrsDhA6B+7fpYpQSf21B+4uXhOMpfNfEJR3ecZeV3Z9dpgvvQQfTsB
X-Received: by 10.194.60.77 with SMTP id f13mr21131291wjr.105.1424986935328;
	Thu, 26 Feb 2015 13:42:15 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id gi3sm33184wic.15.2015.02.26.13.42.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 13:42:13 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C071C561427; Thu, 26 Feb 2015 21:42:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 21:41:56 +0000
Message-Id: <4d0b260fe9c1a0e2ba292a4e78235836ed5d62c5.1424986746.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
References: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424986746.git.alexandru.damian@intel.com>
References: <cover.1424986746.git.alexandru.damian@intel.com>
Subject: [PATCH 3/8] toasterui: fix sstate task identification
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
X-List-Received-Date: Thu, 26 Feb 2015 21:42:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes a problem where set sstate scene tasks
were not identified, causing cache attempt not being recorded.

[YOCTO #7223]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py |  4 ++--
 lib/toaster/orm/models.py    | 13 ++++---------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 967e4bd..c0f42d2 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -190,8 +190,8 @@ class ORMWrapper(object):
                     vars(task_object)[v] = task_information[v]
                     object_changed = True
 
-        # update setscene-related information if the task was just created
-        if created and task_object.outcome == Task.OUTCOME_COVERED and 1 == Task.objects.related_setscene(task_object).count():
+        # update setscene-related information if the task has a setscene
+        if task_object.outcome == Task.OUTCOME_COVERED and 1 == task_object.get_related_setscene().count():
             task_object.outcome = Task.OUTCOME_CACHED
             object_changed = True
 
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index d2b579f..03efac4 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -281,10 +281,6 @@ class Target_File(models.Model):
     sym_target = models.ForeignKey('Target_File', related_name="symlink_set", null=True)
 
 
-class TaskManager(models.Manager):
-    def related_setscene(self, task_object):
-        return Task.objects.filter(task_executed=True, build = task_object.build, recipe = task_object.recipe, task_name=task_object.task_name+"_setscene")
-
 class Task(models.Model):
 
     SSTATE_NA = 0
@@ -339,10 +335,8 @@ class Task(models.Model):
 
     search_allowed_fields = [ "recipe__name", "recipe__version", "task_name", "logfile" ]
 
-    objects = TaskManager()
-
     def get_related_setscene(self):
-        return Task.objects.related_setscene(self)
+        return Task.objects.filter(task_executed=True, build = self.build, recipe = self.recipe, task_name=self.task_name+"_setscene")
 
     def get_outcome_text(self):
         return Task.TASK_OUTCOME[self.outcome + 1][1]
@@ -377,7 +371,7 @@ class Task(models.Model):
     outcome = models.IntegerField(choices=TASK_OUTCOME, default=OUTCOME_NA)
     sstate_checksum = models.CharField(max_length=100, blank=True)
     path_to_sstate_obj = models.FilePathField(max_length=500, blank=True)
-    recipe = models.ForeignKey('Recipe', related_name='build_recipe')
+    recipe = models.ForeignKey('Recipe', related_name='tasks')
     task_name = models.CharField(max_length=100)
     source_url = models.FilePathField(max_length=255, blank=True)
     work_directory = models.FilePathField(max_length=255, blank=True)
@@ -394,7 +388,8 @@ class Task(models.Model):
     sstate_text  = property(get_sstate_text)
 
     def __unicode__(self):
-        return "%d %s:%s" % (self.id, self.recipe.name, self.task_name)
+        return "%d(%d) %s:%s" % (self.pk, self.build.pk, self.recipe.name, self.task_name)
+
     class Meta:
         ordering = ('order', 'recipe' ,)
         unique_together = ('build', 'recipe', 'task_name', )
-- 
1.9.1


