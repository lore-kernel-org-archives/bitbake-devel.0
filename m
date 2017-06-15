Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 80B4478372
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 04:57:16 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v5F4vItb009533
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 21:57:18 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.200.76) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 14 Jun 2017 21:57:17 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Jun 2017 21:48:31 -0700
Message-ID: <5928932b2d58b36c666451ef6a39feb7f9634834.1497501996.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1497501996.git.David.Reyna@windriver.com>
References: <cover.1497501996.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.200.76]
Subject: [PATCH 1/1] toaster: fail on layers with sub-layer
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
X-List-Received-Date: Thu, 15 Jun 2017 04:57:19 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

For layers directories with sub-layers (for example meta-intel),
Toaster breaks when trying to exact match a dependency event for
that sub-layer against the top level layer directory paths.

Given that top the level layer directory paths are unique, adding
a test to see if the dependency path is a subset of a top level
path is also unique.

Also, since a warning was issued the processing should not fail
on the assert but instead should continue and gather the recipes
and tasks.

[YOCTO #11149]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/bb/ui/buildinfohelper.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 46be5a5..3f8d63d 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -981,6 +981,7 @@ class BuildInfoHelper(object):
             pathRE = pathRE[:-1]
 
         p = re.compile(pathRE)
+        path=re.sub(r'[$^]',r'',pathRE)
         # Heuristics: we always match recipe to the deepest layer path in
         # the discovered layers
         for lvo in sorted(self.orm_wrapper.layer_version_objects,
@@ -990,12 +991,16 @@ class BuildInfoHelper(object):
             if lvo.layer.local_source_dir:
                 if p.fullmatch(os.path.abspath(lvo.layer.local_source_dir)):
                     return lvo
+            if 0 == path.find(lvo.local_path):
+                # sub-layer path inside existing layer
+                return lvo
 
         # if we get here, we didn't read layers correctly;
         # dump whatever information we have on the error log
         logger.warning("Could not match layer dependency for path %s : %s",
                        pathRE,
                        self.orm_wrapper.layer_version_objects)
+        return None
 
     def _get_layer_version_for_path(self, path):
         self._ensure_build()
@@ -1396,9 +1401,9 @@ class BuildInfoHelper(object):
             for lv in event._depgraph['layer-priorities']:
                 (_, path, _, priority) = lv
                 layer_version_obj = self._get_layer_version_for_dependency(path)
-                assert layer_version_obj is not None
-                layer_version_obj.priority = priority
-                layer_version_obj.save()
+                if layer_version_obj:
+                    layer_version_obj.priority = priority
+                    layer_version_obj.save()
 
         # save recipe information
         self.internal_state['recipes'] = {}
-- 
1.9.1


