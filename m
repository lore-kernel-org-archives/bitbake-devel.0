Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 00BE675F44
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:08 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so99773859wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=KV+jzGy2SAFiZ9DBsSAXlC7A8oZLkZg1XrGcGClfg+8=;
	b=BUOXsnylcBc5gSxE/ovIo3m6rEvC49r9vaSyO5vbJi0twNp7I1J/Ze7mSUKMEgb9WV
	+y8223iJVk9tY3y7Ja4TP+kDAFqmbsPYLM+91ZkHaGFs8m4TkYqZxorR4m9Oi+wuwBjo
	9yUgPkgBHkgjT2blm17Yt8FS4U3lvA9DLmu1e8ctO/zMaUT1higE/UAarOqPB3H7gyum
	vC3AddUOXX8Xfud28ex61+U+J85JxURKnl1uGNZmwb5dHLdF4t1qsglFZUkFPB9UgERa
	LOP2Ai7daKgIm5fbGF0W6wYQczKZI51qxhDPkQSVJqeZRHN6crR6Qo1PGBBNmR6yQMCf
	s3qg==
X-Gm-Message-State: ALoCoQkLMk4og5a6/sPeCn3mNfAKHyAkfm52R98pESioOwsJmTEoYfgwVtGkmgmLDdu7sr6cjUj5
X-Received: by 10.180.75.48 with SMTP id z16mr45597706wiv.2.1439915348831;
	Tue, 18 Aug 2015 09:29:08 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:08 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:51 +0100
Message-Id: <9031a1335ad49d2b58004e02c7743c9171095c4d.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 05/14] bitbake: toaster: models field initialization
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:09 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

As prompted by pylint, the object fields need to be
initialized properly, so this patch fixes that.

Also adds some casts to int, because, sometimes, the IntegerField
is not returning an int, but a string.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 6b485d2..26abf37 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -472,20 +472,27 @@ class Task(models.Model):
 
     search_allowed_fields = [ "recipe__name", "recipe__version", "task_name", "logfile" ]
 
+    def __init__(self, *args, **kwargs):
+        super(Task, self).__init__(*args, **kwargs)
+        try:
+            self._helptext = HelpText.objects.get(key=self.task_name, area=HelpText.VARIABLE, build=self.build).text
+        except HelpText.DoesNotExist:
+            self._helptext = None
+
     def get_related_setscene(self):
         return Task.objects.filter(task_executed=True, build = self.build, recipe = self.recipe, task_name=self.task_name+"_setscene")
 
     def get_outcome_text(self):
-        return Task.TASK_OUTCOME[self.outcome + 1][1]
+        return Task.TASK_OUTCOME[int(self.outcome) + 1][1]
 
     def get_outcome_help(self):
-        return Task.TASK_OUTCOME_HELP[self.outcome][1]
+        return Task.TASK_OUTCOME_HELP[int(self.outcome)][1]
 
     def get_sstate_text(self):
         if self.sstate_result==Task.SSTATE_NA:
             return ''
         else:
-            return Task.SSTATE_RESULT[self.sstate_result][1]
+            return Task.SSTATE_RESULT[int(self.sstate_result)][1]
 
     def get_executed_display(self):
         if self.task_executed:
@@ -493,13 +500,6 @@ class Task(models.Model):
         return "Not Executed"
 
     def get_description(self):
-        if '_helptext' in vars(self) and self._helptext != None:
-            return self._helptext
-        try:
-            self._helptext = HelpText.objects.get(key=self.task_name, area=HelpText.VARIABLE, build=self.build).text
-        except HelpText.DoesNotExist:
-            self._helptext = None
-
         return self._helptext
 
     build = models.ForeignKey(Build, related_name='task_build')
@@ -721,13 +721,8 @@ class LayerSource(models.Model):
     sourcetype = models.IntegerField(choices=SOURCE_TYPE)
     apiurl = models.CharField(max_length=255, null=True, default=None)
 
-    def update(self):
-        """
-            Updates the local database information from the upstream layer source
-        """
-        raise Exception("Abstract, update() must be implemented by all LayerSource-derived classes (object is %s)" % str(vars(self)))
-
-    def save(self, *args, **kwargs):
+    def __init__(self, *args, **kwargs):
+        super(LayerSource, self).__init__(*args, **kwargs)
         if self.sourcetype == LayerSource.TYPE_LOCAL:
             self.__class__ = LocalLayerSource
         elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
@@ -736,6 +731,15 @@ class LayerSource(models.Model):
             self.__class__ = ImportedLayerSource
         elif self.sourcetype == None:
             raise Exception("Unknown LayerSource-derived class. If you added a new layer source type, fill out all code stubs.")
+
+
+    def update(self):
+        """
+            Updates the local database information from the upstream layer source
+        """
+        raise Exception("Abstract, update() must be implemented by all LayerSource-derived classes (object is %s)" % str(vars(self)))
+
+    def save(self, *args, **kwargs):
         return super(LayerSource, self).save(*args, **kwargs)
 
     def get_object(self):
-- 
2.1.4


