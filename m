Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 7751E7714E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 17:29:07 +0000 (UTC)
Received: by pacez2 with SMTP id ez2so10251070pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Sdi3qCexyMf3aL1ep0P0JGyONanSb5zDlsQQMHxx4RY=;
	b=D1iyiGxxqXGCwNhoPf28UbVUU0jaoEMw6pcp5IFHj9Hb2gk5RCt2dErAKwmE5cnZ/d
	U6uyDzKNHXcBvaCHIJNYI84emZMS/LOuGdcnfV8LkiWIQL700Hc5LjHhyL76WCl2FDCo
	9Dq/XMBp4wRAKoQSeU7A4GlLCmoh/ZpcmdUJQgQC5bNLS4x1tVz62NdIyqYACqtbEftw
	atYVwaZm+Anvv7s/FT0rJTrqr9Z4Oa6KKj2VcF40497V+l0mmnAmQNrrr78buP/4iNIx
	Wy2PyC+8h9M/FHqvFw+NGcwzCVnjv9qPNfQ7ww13KmWBoGgRirG+B4oj0psoW3He6FKp
	gtcw==
X-Received: by 10.68.239.33 with SMTP id vp1mr17952180pbc.167.1445016546669;
	Fri, 16 Oct 2015 10:29:06 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	l16sm22296460pbq.22.2015.10.16.10.29.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Oct 2015 10:29:05 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Oct 2015 10:31:12 -0700
Message-Id: <049d42197c7096e2e8389cc136777770cda0e792.1445016378.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1445016378.git.avery.brian@gmail.com>
References: <cover.1445016378.git.avery.brian@gmail.com>
Subject: [PATCH 1/1] toaster: add get_or_create_targets API
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
X-List-Received-Date: Fri, 16 Oct 2015 17:29:07 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Target objects are created before the build if build is
started from UI in build mode. However, in analysis mode Target
objects don't exist and need to be created using information
from bitbake events.

Added new API call get_or_create_targets to retrive existing
target objects or create them if they don't exist yet.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 286fb6a..2fc1a43 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -162,8 +162,6 @@ class ORMWrapper(object):
             build.bitbake_version=build_info['bitbake_version']
             build.save()
 
-            Target.objects.filter(build = build).delete()
-
         else:
             build = Build.objects.create(
                                     project = prj,
@@ -184,18 +182,26 @@ class ORMWrapper(object):
 
         return build
 
-    def create_target_objects(self, target_info):
-        assert 'build' in target_info
-        assert 'targets' in target_info
-
-        targets = []
-        for tgt_name in target_info['targets']:
-            tgt_object = Target.objects.create( build = target_info['build'],
-                                    target = tgt_name,
-                                    is_image = False,
-                                    )
-            targets.append(tgt_object)
-        return targets
+    @staticmethod
+    def get_or_create_targets(target_info):
+        result = []
+        for target in target_info['targets']:
+            task = ''
+            if ':' in target:
+                target, task = target.split(':', 1)
+            if task.startswith('do_'):
+                task = task[3:]
+            if task == 'build':
+                task = ''
+            obj, created = Target.objects.get_or_create(build=target_info['build'],
+                                                        target=target)
+            if created:
+                obj.is_image = False
+                if task:
+                    obj.task = task
+                obj.save()
+            result.append(obj)
+        return result
 
     def update_build_object(self, build, errors, warnings, taskfailures):
         assert isinstance(build,Build)
@@ -950,7 +956,7 @@ class BuildInfoHelper(object):
         target_information['targets'] = event._pkgs
         target_information['build'] = build_obj
 
-        self.internal_state['targets'] = self.orm_wrapper.create_target_objects(target_information)
+        self.internal_state['targets'] = self.orm_wrapper.get_or_create_targets(target_information)
 
         # Save build configuration
         data = self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0]
-- 
1.9.1


