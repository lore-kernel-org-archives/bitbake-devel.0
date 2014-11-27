Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 0854B72397
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:11 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id r20so8960880wiv.14
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=dp5MHu9KA9kJMcuDJvC1cI9fOyBMzp2xZk6XPHOogN8=;
	b=I1+vggieecfMk4Y93gLglaFg9HHKz8xQQQtxdsrBg19xDhcyQX75rOeqM0F3XpQbwu
	pMuJGsWi7NiCTOIxGYvxN5J3iN1SstqVs+s+VHaTfAay7VR11Zj/mGt7uv1ymwFCzzuh
	hcGqN57jzX/oHGys8tWxB6FV+xX7/t7h3qq8cTgvbdd54clb2UNPD7ugpUjSd1fItd2m
	3Zukmbb5rNwdtTv/gNzpqGzOOIYZeRQ2YbypuzUB/fTU2Jtsg1LZASZL0WqI9X1lK8ei
	pmkxm4HJ3A7hlLvkUrbDpoPWKwz/wFGAwMmpG1UBiEAbFMlp3sZ72rh6Z7VAPtkS2zNA
	wMXQ==
X-Gm-Message-State: ALoCoQkg6FMW11m7DezdKlZzUlg9/4Fy5Yvg4UqjCK490ETS3IkFE4hDzuQbETyGlKoit4bLu40U
X-Received: by 10.180.11.140 with SMTP id q12mr53429609wib.45.1417108091739;
	Thu, 27 Nov 2014 09:08:11 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	l10sm26049355wif.20.2014.11.27.09.08.09 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 05561564120; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:07:57 +0000
Message-Id: <e02ec052a62cbc476bdac65cb7cea1167ce04781.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 06/14] toasterui: fix layer identification for managed builds
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

If we have a managed build, we match the layers used for build
with the layers configured for project, as we know where the layers
are coming from

[YOCTO #6962]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index a3401ce..e428e4c 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -117,15 +117,14 @@ class ORMWrapper(object):
 
         if brbe is not None:
             from bldcontrol.models import BuildEnvironment, BuildRequest
-            try:
-                br, be = brbe.split(":")
-                buildrequest = BuildRequest.objects.get(pk = br)
-                buildrequest.build = build
-                buildrequest.save()
-                build.project_id = buildrequest.project_id
-                build.save()
-            except BuildRequest.DoesNotExist:
-                pass
+            br, be = brbe.split(":")
+
+            buildrequest = BuildRequest.objects.get(pk = br)
+            buildrequest.build = build
+            buildrequest.save()
+
+            build.project_id = buildrequest.project_id
+            build.save()
         return build
 
     def create_target_objects(self, target_info):
@@ -250,17 +249,30 @@ class ORMWrapper(object):
 
         return layer_version_object
 
-    def get_update_layer_object(self, layer_information):
+    def get_update_layer_object(self, layer_information, brbe):
         assert 'name' in layer_information
         assert 'local_path' in layer_information
         assert 'layer_index_url' in layer_information
 
-        layer_object, created = Layer.objects.get_or_create(
+        if brbe is None:
+            layer_object, created = Layer.objects.get_or_create(
                                 name=layer_information['name'],
                                 local_path=layer_information['local_path'],
                                 layer_index_url=layer_information['layer_index_url'])
+            return layer_object
+        else:
+            # we are under managed mode; we must match the layer used in the Project Layer
+            from bldcontrol.models import BuildEnvironment, BuildRequest
+            br, be = brbe.split(":")
+
+            buildrequest = BuildRequest.objects.get(pk = br)
+
+            # we might have a race condition here, as the project layers may change between the build trigger and the actual build execution
+            # but we can only match on the layer name, so the worst thing can happen is a mis-identification of the layer, not a total failure
+            layer_object = buildrequest.project.projectlayer_set.get(layercommit__layer__name=layer_information['name']).layercommit.layer
+
+            return layer_object
 
-        return layer_object
 
     def save_target_file_information(self, build_obj, target_obj, filedata):
         assert isinstance(build_obj, Build)
@@ -689,7 +701,7 @@ class BuildInfoHelper(object):
         layerinfos = event._localdata
         self.internal_state['lvs'] = {}
         for layer in layerinfos:
-            self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer])] = layerinfos[layer]['version']
+            self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)] = layerinfos[layer]['version']
 
 
     def store_started_build(self, event):
-- 
1.9.1


