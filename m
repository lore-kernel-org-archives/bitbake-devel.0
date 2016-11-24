Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 1752871B3F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:31 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id f82so57230670wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Ujh76F9JQ14VhY3CtwtPBM8OHYA1953/HKcTSLMjouI=;
	b=zvocY6DnbOKw3koBShGDvmnHfAdc8aZycG22EPiUfLMslWhv+iGdo52D36SdA3828l
	zfR9Nm6eNaUXtfXSjkecqew1bYQIRjzct9ozvfOnkaoImExgTMjdzAzv+U960fQrnkP0
	g2VvM1BxlFb+uWQRqtC9kcdzKPzpgicjsTBoF2+lAd/aIa0fT6rE/uqQq3/T7I5Nd/la
	//NBnivSCXVswlZDgMG3vyeH+771JGRL5lzO1mtpOYOFgRNXSreKdQujlZky5wmUZfTE
	cZf40GA9LvoH07gW2MHOI2LohwiN6uw7hfDWYv+SSSRDT8waIT7CFK6v/bR85xesG9Yh
	JH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Ujh76F9JQ14VhY3CtwtPBM8OHYA1953/HKcTSLMjouI=;
	b=cCXJwGXOd5opML+KVF+ndzoBGJ8uz66sFiRc/gjTGwKI9in+Hp0jEEj8aHtf9xB8KY
	XHxoOSHuo6IFW3ftPZn8mDlzCQCtLSwqlop8KSaS+RoOcjYEGD8Ae6umtyzOtCKC3H3h
	49m1EkLfcyAd8GXyvRYIyG2YIy0vaASMXHU3SZ8FdYjjklzmX46eNvII+mku2k+Db04b
	XC9a9Me4lSAaEz9108YsA1jTOyUzqj1A8SBrAu9Th6KHJzsVQY7popzWAgZofKCalgnv
	zjhmA4I85DL+tHc+rCChHzRCewD4M8j14MRMFldRe/7t6vvOsKUfEfOaUwHTto6pFncA
	DMPA==
X-Gm-Message-State: AKaTC02t9fIuyY6KWfQmj06jtmrDEe2OPE5lz9Z/YgsW5T1mp0mkpQCGU32L+/Z32FkKozmI
X-Received: by 10.28.32.150 with SMTP id g144mr1989606wmg.46.1479986432245;
	Thu, 24 Nov 2016 03:20:32 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:31 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:20:02 +0000
Message-Id: <1479986406-4657-12-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 11/15] toaster: orm models Handle CustomImageRecipe BRLayer here
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:31 -0000

The schedule_build function on the project object is where the BRLayers
are created for the build. Instead of creating the BRLayer for the
CustomImageRecipe in the localhostbbcontroller create it here so that
all that mechanism is in one place.

Also fix a number of pyflake errors.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 58 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 394c886..8816fe0 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -337,20 +337,45 @@ class Project(models.Model):
 
         return queryset
 
-
     def schedule_build(self):
-        from bldcontrol.models import BuildRequest, BRTarget, BRLayer, BRVariable, BRBitbake
-        br = BuildRequest.objects.create(project = self)
+
+        from bldcontrol.models import BuildRequest, BRTarget, BRLayer
+        from bldcontrol.models import BRBitbake, BRVariable
+
         try:
+            now = timezone.now()
+            build = Build.objects.create(project=self,
+                                         completed_on=now,
+                                         started_on=now)
+
+            br = BuildRequest.objects.create(project=self,
+                                             state=BuildRequest.REQ_QUEUED,
+                                             build=build)
+            BRBitbake.objects.create(req=br,
+                                     giturl=self.bitbake_version.giturl,
+                                     commit=self.bitbake_version.branch,
+                                     dirpath=self.bitbake_version.dirpath)
 
-            BRBitbake.objects.create(req = br,
-                giturl = self.bitbake_version.giturl,
-                commit = self.bitbake_version.branch,
-                dirpath = self.bitbake_version.dirpath)
+            for t in self.projecttarget_set.all():
+                BRTarget.objects.create(req=br, target=t.target, task=t.task)
+                Target.objects.create(build=br.build, target=t.target,
+                                      task=t.task)
+                # If we're about to build a custom image recipe make sure
+                # that layer is currently in the project before we create the
+                # BRLayer objects
+                customrecipe = CustomImageRecipe.objects.filter(
+                    name=t.target,
+                    project=self).first()
+                if customrecipe:
+                    ProjectLayer.objects.get_or_create(
+                        project=self,
+                        layercommit=customrecipe.layer_version,
+                        optional=False)
 
             for l in self.projectlayer_set.all().order_by("pk"):
                 commit = l.layercommit.get_vcs_reference()
-                print("ii Building layer ", l.layercommit.layer.name, " at vcs point ", commit)
+                logger.debug("Adding layer to build %s" %
+                             l.layercommit.layer.name)
                 BRLayer.objects.create(
                     req=br,
                     name=l.layercommit.layer.name,
@@ -361,25 +386,16 @@ class Project(models.Model):
                     local_source_dir=l.layercommit.layer.local_source_dir
                 )
 
-            br.state = BuildRequest.REQ_QUEUED
-            now = timezone.now()
-            br.build = Build.objects.create(project = self,
-                                completed_on=now,
-                                started_on=now,
-                                )
-            for t in self.projecttarget_set.all():
-                BRTarget.objects.create(req = br, target = t.target, task = t.task)
-                Target.objects.create(build = br.build, target = t.target, task = t.task)
-
             for v in self.projectvariable_set.all():
-                BRVariable.objects.create(req = br, name = v.name, value = v.value)
-
+                BRVariable.objects.create(req=br, name=v.name, value=v.value)
 
             try:
-                br.build.machine = self.projectvariable_set.get(name = 'MACHINE').value
+                br.build.machine = self.projectvariable_set.get(
+                    name='MACHINE').value
                 br.build.save()
             except ProjectVariable.DoesNotExist:
                 pass
+
             br.save()
             signal_runbuilds()
 
-- 
2.7.4


