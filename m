Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3481CC83F11
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 09:22:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.9696.1693214537269648345
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Aug 2023 02:22:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=spB/XlUF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7604d1df4d=david.reyna@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37S90JsH016424
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 02:22:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=I+0trJwtM7gVCGyPEU0U2a6iH4TSkPtUbmNDjEBkme4=; b=
	spB/XlUFrSbcHia5kxxxvIzTVzd8jI1CvXVSFuVUaLi8kJZQi1Nu/VJPI8uq9M9n
	ug0yA8xVCgaKWCS8MtlxFQ3NNuLq20seZAqOTxcGopAUV45rhvNjml0wv23S11fm
	jY/1hmB7hMRU1zw4BbpyCMrSN95tal1xOcsiqpJUpDvmEYd6UGlo5fxsjnk7klDM
	seerTQmcduLU7BUFzBBrluVglGyXRgiv38IXfXmVDjQh0cp3kaXLBpKu/PPZa8MF
	LVwZY3hdHBcEQ0VTW2N+2vgYcBycTibHjEsBerZ1nTeujDmWkjBFlotvXrXuhpLo
	ck0CusMqAl/yuok8xsdVXg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sqgwfh7jg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 02:22:16 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 02:22:15 -0700
Received: from dreyna-honig-T5600.corp.ad.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 02:22:15 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/3] toaster: import only used layers
Date: Mon, 28 Aug 2023 01:45:19 -0700
Message-ID: <d71ae6a9b0f2c92636370500e5b05c08bb95d784.1693212183.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1693212183.git.david.reyna@windriver.com>
References: <cover.1693212183.git.david.reyna@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uyinQHcc-8lnY0cS3jvZGnT0OeIe9wsF
X-Proofpoint-ORIG-GUID: uyinQHcc-8lnY0cS3jvZGnT0OeIe9wsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_06,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2308280085
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 09:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14987

If you import a build directory, Toaster still adds openembedded-core,
meta-poky and meta-yocto-bsp to the newly created project. Toaster
should only be including in the project the layers that it imported.

[YOCTO #13764]

Signed-off-by: Kieran McNulty <Kieran.McNulty@windriver.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py                     | 28 +++++++++----------
 lib/toaster/toastergui/views.py               |  2 +-
 .../management/commands/buildimport.py        |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 2cb7d7e0499..f9fcf9e4fbb 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -107,7 +107,7 @@ class ToasterSetting(models.Model):
 
 
 class ProjectManager(models.Manager):
-    def create_project(self, name, release, existing_project=None):
+    def create_project(self, name, release, existing_project=None, imported=False):
         if existing_project and (release is not None):
             prj = existing_project
             prj.bitbake_version = release.bitbake_version
@@ -134,19 +134,19 @@ class ProjectManager(models.Manager):
 
         if release is None:
             return prj
-
-        for rdl in release.releasedefaultlayer_set.all():
-            lv = Layer_Version.objects.filter(
-                layer__name=rdl.layer_name,
-                release=release).first()
-
-            if lv:
-                ProjectLayer.objects.create(project=prj,
-                                            layercommit=lv,
-                                            optional=False)
-            else:
-                logger.warning("Default project layer %s not found" %
-                               rdl.layer_name)
+        if not imported:
+            for rdl in release.releasedefaultlayer_set.all():
+                lv = Layer_Version.objects.filter(
+                    layer__name=rdl.layer_name,
+                    release=release).first()
+
+                if lv:
+                    ProjectLayer.objects.create(project=prj,
+                                                layercommit=lv,
+                                                optional=False)
+                else:
+                    logger.warning("Default project layer %s not found" %
+                                rdl.layer_name)
 
         return prj
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index bf92510cdcd..552ff1649bf 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1404,7 +1404,7 @@ if True:
                     if not os.path.isdir('%s/conf' % request.POST['importdir']):
                         raise BadParameterException("Bad path or missing 'conf' directory (%s)" % request.POST['importdir'])
                     from django.core import management
-                    management.call_command('buildimport', '--command=import', '--name=%s' % request.POST['projectname'], '--path=%s' % request.POST['importdir'], interactive=False)
+                    management.call_command('buildimport', '--command=import', '--name=%s' % request.POST['projectname'], '--path=%s' % request.POST['importdir'])
                     prj = Project.objects.get(name = request.POST['projectname'])
                     prj.merged_attr = True
                     prj.save()
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index e25b55e5ab9..f7139aa0419 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -545,7 +545,7 @@ class Command(BaseCommand):
             # Find the directory's release, and promote to default_release if local paths
             release = self.find_import_release(layers_list,lv_dict,default_release)
             # create project, SANITY: reuse any project of same name
-            project = Project.objects.create_project(project_name,release,project)
+            project = Project.objects.create_project(project_name,release,project, imported=True)
             # Apply any new layers or variables
             self.apply_conf_variables(project,layers_list,lv_dict,release)
             # WORKAROUND: since we now derive the release, redirect 'newproject_specific' to 'project_specific'
-- 
2.20.1


