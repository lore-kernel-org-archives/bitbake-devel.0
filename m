Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id BE25F771E7
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:37 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id f198so81810239wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=F7FqO+r12TUDbSJP7oWaphE++NhFnj39TLUT0jziJKo=;
	b=rvMgfDvCga7BAXzA5qMVijCKQI0rqRkXRv+H2VK+mLNbcPZnLg6zgQVzRSrvOpLNJj
	DfrFn3tnD5mZLZJT2Cgs4+9kSRvW3JEtXE5yPLC3zO9GLv6uig9eyfxekaLxSedwaWUj
	HKfsEWPmhPqbukOD1KClWlo4rR1j3PNysSQPJwkKkPrpMToXxzxQSb0RB83kyoG8LBw6
	/7Wlfhxw9hhgfiQrU7gXIO0oxnhTj1zcvb3pw5ayAtyr44Mjd52t9muIorLeQGvobLd7
	zmrzVGK01VGyUbfRuw4ltVv7DggA7y6j1JlOCyVpmMkleT18dMfo1Pcdb66y2ou/t0SU
	XVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=F7FqO+r12TUDbSJP7oWaphE++NhFnj39TLUT0jziJKo=;
	b=hoMptD8rZ9pgFPilizafvERIrIYv9/d2C3PTt3Y1fPDRaI6HzBs48DeD982agg16YB
	+lpe1m8OgkfiYcfYbk7Pq+KLieTyPnFYJgSpOezlMUuU6Mujys7YLASHojO46YiMfO2g
	W3rphpegDDV8Y5WYy/ikJ3++Ev/95WuUwBIdNg7+o2d4IYxe+4Au7iBounC7y4s90weo
	DdjggVlvqCB4gKKfSsaldBd6nsifLQ6NGKvJtzDgFQ9zuvzEHRvisj3UQ+kR3iJqwAaB
	u58ZFaFJx+Uv+l+tHGAe24pBNVinxwhgLMUMUwBPM3jY6Dn6xqRZLoOtn4tbqRbJbUJI
	SEsA==
X-Gm-Message-State: AD7BkJLxDWt6LEk4bI3mUfUEJtD3XN0DqQvYgImJwukkWi8JcZnU2rAxmaio5vgni67oTeB8
X-Received: by 10.194.174.197 with SMTP id bu5mr12940582wjc.23.1459961257938; 
	Wed, 06 Apr 2016 09:47:37 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:37 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:43 +0100
Message-Id: <fec8cab1a55c9b5b0bb3e81499b7ad7cb3e41742.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 33/38] toaster: update view to support DL_DIR and SSTATE_DIR
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:38 -0000

From: Sujith H <sujith.h@gmail.com>

Update toaster's views.py to support DL_DIR and SSTATE_DIR for
page projectconf.html. Removed DL_DIR and SSTATE_DIR from
blacklist. Initial value of DL_DIR and SSTATE_DIR comes from
BuildEnvironment.

[YOCTO #8422]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index f1a643e..30295a7 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -45,6 +45,7 @@ from django.utils import formats
 from toastergui.templatetags.projecttags import json as jsonfilter
 from decimal import Decimal
 import json
+import os
 from os.path import dirname
 from functools import wraps
 import itertools
@@ -1875,6 +1876,7 @@ def managedcontextprocessor(request):
 import toastermain.settings
 
 from orm.models import Project, ProjectLayer, ProjectTarget, ProjectVariable
+from bldcontrol.models import  BuildEnvironment
 
 # we have a set of functions if we're in managed mode, or
 # a default "page not available" simple functions for interactive mode
@@ -2187,6 +2189,10 @@ if True:
             except ProjectVariable.DoesNotExist:
                 pass
             try:
+                return_data['dl_dir'] = ProjectVariable.objects.get(project = prj, name = "DL_DIR").value,
+            except ProjectVariable.DoesNotExist:
+                pass
+            try:
                 return_data['fstypes'] = ProjectVariable.objects.get(project = prj, name = "IMAGE_FSTYPES").value,
             except ProjectVariable.DoesNotExist:
                 pass
@@ -2198,6 +2204,10 @@ if True:
                 return_data['package_classes'] = ProjectVariable.objects.get(project = prj, name = "PACKAGE_CLASSES").value,
             except ProjectVariable.DoesNotExist:
                 pass
+            try:
+                return_data['sstate_dir'] = ProjectVariable.objects.get(project = prj, name = "SSTATE_DIR").value,
+            except ProjectVariable.DoesNotExist:
+                pass
 
             return HttpResponse(json.dumps( return_data ), content_type = "application/json")
 
@@ -2805,9 +2815,9 @@ if True:
         }
 
         vars_blacklist  = {
-            'DL_DR','PARALLEL_MAKE','BB_NUMBER_THREADS','SSTATE_DIR',
+            'PARALLEL_MAKE','BB_NUMBER_THREADS',
             'BB_DISKMON_DIRS','BB_NUMBER_THREADS','CVS_PROXY_HOST','CVS_PROXY_PORT',
-            'DL_DIR','PARALLEL_MAKE','SSTATE_DIR','SSTATE_DIR','SSTATE_MIRRORS','TMPDIR',
+            'PARALLEL_MAKE','SSTATE_MIRRORS','TMPDIR',
             'all_proxy','ftp_proxy','http_proxy ','https_proxy'
             }
 
@@ -2845,6 +2855,19 @@ if True:
         except ProjectVariable.DoesNotExist:
             pass
         try:
+            if ProjectVariable.objects.get(project = prj, name = "DL_DIR").value == "${TOPDIR}/../downloads":
+                be = BuildEnvironment.objects.get(pk = str(1))
+                dl_dir = os.path.join(dirname(be.builddir), "downloads")
+                context['dl_dir'] =  dl_dir
+                pv, created = ProjectVariable.objects.get_or_create(project = prj, name = "DL_DIR")
+                pv.value = dl_dir
+                pv.save()
+            else:
+                context['dl_dir'] = ProjectVariable.objects.get(project = prj, name = "DL_DIR").value
+            context['dl_dir_defined'] = "1"
+        except ProjectVariable.DoesNotExist,BuildEnvironment.DoesNotExist:
+            pass
+        try:
             context['fstypes'] =  ProjectVariable.objects.get(project = prj, name = "IMAGE_FSTYPES").value
             context['fstypes_defined'] = "1"
         except ProjectVariable.DoesNotExist:
@@ -2859,6 +2882,19 @@ if True:
             context['package_classes_defined'] = "1"
         except ProjectVariable.DoesNotExist:
             pass
+        try:
+            if ProjectVariable.objects.get(project = prj, name = "SSTATE_DIR").value == "${TOPDIR}/../sstate-cache":
+                be = BuildEnvironment.objects.get(pk = str(1))
+                sstate_dir = os.path.join(dirname(be.builddir), "sstate-cache")
+                context['sstate_dir'] = sstate_dir
+                pv, created = ProjectVariable.objects.get_or_create(project = prj, name = "SSTATE_DIR")
+                pv.value = sstate_dir
+                pv.save()
+            else:
+                context['sstate_dir'] = ProjectVariable.objects.get(project = prj, name = "SSTATE_DIR").value
+            context['sstate_dir_defined'] = "1"
+        except ProjectVariable.DoesNotExist, BuildEnvironment.DoesNotExist:
+            pass
 
         return context
 
-- 
2.1.4


