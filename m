Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 3B06D70489
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 16:55:30 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id k14so5115724wgh.24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 09:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=UydSSRpddsgamCJgsLsUwboem8vMLa83wseHgne0Enw=;
	b=AjD0tpuQxOZxQTT02WJuAGQo1N30s84WHg6I8FaWiZhTqgkkzjXqCzyjIfE+H9NRYT
	KZgXaRKaOV1kcWC+G4l9DcubLyQXfk2ZitkVyDKepxY9fGH0B/n059jigIUITWFGMLHX
	EPlssELe+v7Rh1ym3IXJc/h//CuOtzIlDDnJPkQhiubar46Km2qNLeff7nyEUr3CfDkG
	wIcrH/zFzKcsI6ekDHvCVZSAlabDHStifv/LG6Cu/GI7MEz4N/uxxf/aCHmtZFhXM+x8
	B+nZAecdVlHc681q8Kl1y9OoXTe7utFJyQ0E2N1VcXLvV579M3HW2C32iaGAogAGtLVZ
	Hr9A==
X-Gm-Message-State: ALoCoQmkepF/EvifFNmgPl7K3G/r0W4lYUIEXQ0oJIqcBWA5BWlGwAi5J2GfgggCuR0AHcoI1QeZ
X-Received: by 10.181.11.232 with SMTP id el8mr13107196wid.57.1404924932122;
	Wed, 09 Jul 2014 09:55:32 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	dj2sm21343951wib.11.2014.07.09.09.55.29 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Jul 2014 09:55:30 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 9D1675600B5; Wed,  9 Jul 2014 17:55:26 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Jul 2014 17:55:25 +0100
Message-Id: <af1d3373706d365f9138caec110fcb20a5966b7b.1404924714.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404924713.git.alexandru.damian@intel.com>
References: <cover.1404924713.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 9/9] toasterui: fix build - project identification
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
X-List-Received-Date: Wed, 09 Jul 2014 16:55:31 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patches fixes the build - project identification when
running under managed mode. The build is assigned to the
project from which it was triggered, and to the
build request, as to simplify relationships queries
 in the database.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 17 +++++++++++++++--
 lib/bb/ui/toasterui.py       |  7 +++----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 77be7c7..29cfc81 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -46,7 +46,7 @@ class ORMWrapper(object):
         pass
 
 
-    def create_build_object(self, build_info):
+    def create_build_object(self, build_info, brbe):
         assert 'machine' in build_info
         assert 'distro' in build_info
         assert 'distro_version' in build_info
@@ -65,6 +65,13 @@ class ORMWrapper(object):
                                     build_name=build_info['build_name'],
                                     bitbake_version=build_info['bitbake_version'])
 
+        if brbe is not None:
+            from bldcontrol.models import BuildEnvironment, BuildRequest
+            br, be = brbe.split(":")
+            buildrequest = BuildRequest.objects.get(pk = br)
+            build.project = buildrequest.project
+            build.save()
+
         return build
 
     def create_target_objects(self, target_info):
@@ -600,7 +607,10 @@ class BuildInfoHelper(object):
         assert '_pkgs' in vars(event)
         build_information = self._get_build_information()
 
-        build_obj = self.orm_wrapper.create_build_object(build_information)
+        brbe = self.server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
+
+        build_obj = self.orm_wrapper.create_build_object(build_information, brbe)
+
         self.internal_state['build'] = build_obj
 
         # save layer version information for this build
@@ -619,6 +629,9 @@ class BuildInfoHelper(object):
         # Save build configuration
         self.orm_wrapper.save_build_variables(build_obj, self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0])
 
+        return brbe
+
+
     def update_target_image_file(self, event):
         image_fstypes = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
         for t in self.internal_state['targets']:
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 5f87a9d..2f628e9 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -94,7 +94,7 @@ def main(server, eventHandler, params ):
     first = True
 
     buildinfohelper = BuildInfoHelper(server, build_history_enabled)
-
+    brbe = None
 
     while True:
         try:
@@ -111,7 +111,7 @@ def main(server, eventHandler, params ):
             helper.eventHandler(event)
 
             if isinstance(event, bb.event.BuildStarted):
-                buildinfohelper.store_started_build(event)
+                brbe = buildinfohelper.store_started_build(event)
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
@@ -231,10 +231,9 @@ def main(server, eventHandler, params ):
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
 
 
-                brbe = server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
-                br_id, be_id = brbe.split(":")
                 # we start a new build info
                 if brbe is not None:
+                    br_id, be_id = brbe.split(":")
                     buildinfohelper.store_build_done(br_id, be_id)
 
                     print "we are under BuildEnvironment management - after the build, we exit"
-- 
1.9.1


