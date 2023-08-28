Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422E9C83F13
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 09:22:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.9695.1693214537118827453
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Aug 2023 02:22:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=RaG/JcvO;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7604d1df4d=david.reyna@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37S90JsG016424
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 02:22:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=GSKhTEoQ8z7DfhzdDXXchMw1Zw6+v7RS1/p4pc1t7aQ=; b=
	RaG/JcvOa9ovRXGYsfq3x+NoiQFquEgdEDc47y25VqHiFnqjPIDGKhTJ0YGWPR9c
	2hqw91KG8+57y5T2oO5otGX9wLjUPlFqQ4ieMOUMU6hY8Ds+eWuCKmj/13vUkVHB
	4u1rGbA+/iSBSaCj7Zkb+TpFneNfDrqsSWv7TWLhux8nRwMQJ8iD6qopr6yEDBmN
	hSiW+LKhi0nKXrDP2xwt09WDegnmCxyApIDoJABJIm2ndvG5CabzzEF9QdACNQfA
	dspa9uAPdK3oxdsWtD+6hs+yNvCnAH1B9msRBPlUJnGfwHJLfPx3WgKWLffiwlZU
	UcC7qrFMvNaXzsbYGM5UWg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sqgwfh7jg-1
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
Subject: [PATCH 1/3] toaster: Update to Django 4.2
Date: Mon, 28 Aug 2023 01:45:18 -0700
Message-ID: <214f487f8fa260b0d1bd557f51695751b2c5ecf8.1693212183.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1693212183.git.david.reyna@windriver.com>
References: <cover.1693212183.git.david.reyna@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: L0nXZCqyphEXHgZFvYf2j3liX59OTbIf
X-Proofpoint-ORIG-GUID: L0nXZCqyphEXHgZFvYf2j3liX59OTbIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_06,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=806
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2308280085
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 09:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14986

Update Toaster to support Django 4.2, to match current
hosts and to address CVEs.

[YOCTO #15152]

Signed-off-by: Kieran McNulty <Kieran.McNulty@windriver.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcollector/urls.py                           | 2 +-
 lib/toaster/bldcontrol/models.py                           | 4 ++--
 lib/toaster/toastergui/urls.py                             | 2 +-
 lib/toaster/toastergui/views.py                            | 4 ++--
 lib/toaster/toastergui/widgets.py                          | 5 +++--
 lib/toaster/toastermain/management/commands/checksocket.py | 4 ++--
 lib/toaster/toastermain/urls.py                            | 2 +-
 toaster-requirements.txt                                   | 2 +-
 8 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/bldcollector/urls.py b/lib/toaster/bldcollector/urls.py
index efd67a81a54..3c34070351c 100644
--- a/lib/toaster/bldcollector/urls.py
+++ b/lib/toaster/bldcollector/urls.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.conf.urls import url
+from django.urls import re_path as url
 
 import bldcollector.views
 
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index c2f302da24a..42750e7180a 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -4,7 +4,7 @@
 
 from __future__ import unicode_literals
 from django.db import models
-from django.utils.encoding import force_text
+from django.utils.encoding import force_str
 from orm.models import Project, Build, Layer_Version
 
 import logging
@@ -124,7 +124,7 @@ class BuildRequest(models.Model):
         return self.brvariable_set.get(name="MACHINE").value
 
     def __str__(self):
-        return force_text('%s %s' % (self.project, self.get_state_display()))
+        return force_str('%s %s' % (self.project, self.get_state_display()))
 
 # These tables specify the settings for running an actual build.
 # They MUST be kept in sync with the tables in orm.models.Project*
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index d2df4e60488..bc3b0c79d82 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.conf.urls import url
+from django.urls import re_path as url
 from django.views.generic import RedirectView
 
 from toastergui import tables
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a571b8cc18c..bf92510cdcd 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -670,11 +670,11 @@ def xhr_dirinfo(request, build_id, target_id):
     return HttpResponse(_get_dir_entries(build_id, target_id, top), content_type = "application/json")
 
 from django.utils.functional import Promise
-from django.utils.encoding import force_text
+from django.utils.encoding import force_str
 class LazyEncoder(json.JSONEncoder):
     def default(self, obj):
         if isinstance(obj, Promise):
-            return force_text(obj)
+            return force_str(obj)
         return super(LazyEncoder, self).default(obj)
 
 from toastergui.templatetags.projecttags import filtered_filesizeformat
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index ceff52942ee..53696912a46 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -7,6 +7,7 @@
 #
 
 from django.views.generic import View, TemplateView
+from django.utils.decorators import method_decorator
 from django.views.decorators.cache import cache_control
 from django.shortcuts import HttpResponse
 from django.core.cache import cache
@@ -63,8 +64,8 @@ class ToasterTable(TemplateView):
         self.default_orderby = ""
 
     # prevent HTTP caching of table data
-    @cache_control(must_revalidate=True,
-                   max_age=0, no_store=True, no_cache=True)
+    @method_decorator(cache_control(must_revalidate=True,
+                   max_age=0, no_store=True, no_cache=True))
     def dispatch(self, *args, **kwargs):
         return super(ToasterTable, self).dispatch(*args, **kwargs)
 
diff --git a/lib/toaster/toastermain/management/commands/checksocket.py b/lib/toaster/toastermain/management/commands/checksocket.py
index 811fd5d5161..b2c002da7aa 100644
--- a/lib/toaster/toastermain/management/commands/checksocket.py
+++ b/lib/toaster/toastermain/management/commands/checksocket.py
@@ -13,7 +13,7 @@ import errno
 import socket
 
 from django.core.management.base import BaseCommand, CommandError
-from django.utils.encoding import force_text
+from django.utils.encoding import force_str
 
 DEFAULT_ADDRPORT = "0.0.0.0:8000"
 
@@ -51,7 +51,7 @@ class Command(BaseCommand):
             if hasattr(err, 'errno') and err.errno in errors:
                 errtext = errors[err.errno]
             else:
-                errtext = force_text(err)
+                errtext = force_str(err)
             raise CommandError(errtext)
 
         self.stdout.write("OK")
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 5fb520b384d..03603026688 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.conf.urls import include, url
+from django.urls import re_path as url, include
 from django.views.generic import RedirectView, TemplateView
 from django.views.decorators.cache import never_cache
 import bldcollector.views
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index dedd423556a..c1f433f9ec6 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,3 +1,3 @@
-Django>3.2,<3.3
+Django>4.2,<4.3
 beautifulsoup4>=4.4.0
 pytz
-- 
2.20.1


