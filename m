Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 421806013D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 10:59:00 +0000 (UTC)
Received: by wgbhc8 with SMTP id hc8so24011711wgb.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 03:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=eUNmQUwpSpIH1BayY7Dggf3cXNxUdAUiUXfAfgFHONI=;
	b=SxARB2HCBpTmxxTUnZa++I1Icop+na3JTG5wSuG3cFphwLKjf4DlM2SnxATZSOiQns
	8z7+zlDRN6f/B5kRtmFmV6kCrSnuyCQ5JoczfgobxMjPhgDaSoWYDNaIeJ1Tc1nhYGOQ
	pAzPNPqSOko0QQLPgkmm60OCUTrvPHQJtJpIrS3obLroLB9lEgFwiq5uWMUFMsxRj5nz
	hHzhErLAUJlTqng4/pLNdhlS1R/tq83tcYQXYX2RQCpAp690zx/5JiZdhxj5Dhy5Wx6P
	8+e1P3IydnstRKQ5j1Y4xy1FQToWtkh29g/VmDo4tHk0FG5GPrruMKvc1mqUqsJ1e8VW
	Jf4g==
X-Gm-Message-State: ALoCoQkab/hnwtDoBbQpo23A4QDgqrUoZY51euTlsPVq352ELBR5cz1Albw3xsnRMAIkYZmCpZ1Z
X-Received: by 10.180.88.72 with SMTP id be8mr18640802wib.42.1431341941670;
	Mon, 11 May 2015 03:59:01 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id b1sm22258869wjs.17.2015.05.11.03.59.00
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 03:59:00 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E298056038E; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:33 +0100
Message-Id: <21b2236f1dcd209403b16ab547177db0eff65498.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Subject: [PATCH 02/11] toastergui: decrease load time for configuration page
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
X-List-Received-Date: Mon, 11 May 2015 10:59:01 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Used __in field lookup for QuerySet to get build variables faster.

[YOCTO #6691]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/views.py | 46 ++++++++---------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 7e90926..e296cf6 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1266,43 +1266,15 @@ def recipes(request, build_id):
 def configuration(request, build_id):
     template = 'configuration.html'
 
-    variables = Variable.objects.filter(build=build_id)
-
-    def _get_variable_or_empty(variable_name):
-        from django.core.exceptions import ObjectDoesNotExist
-        try:
-            return variables.get(variable_name=variable_name).variable_value
-        except ObjectDoesNotExist:
-            return ''
-
-    BB_VERSION=_get_variable_or_empty(variable_name='BB_VERSION')
-    BUILD_SYS=_get_variable_or_empty(variable_name='BUILD_SYS')
-    NATIVELSBSTRING=_get_variable_or_empty(variable_name='NATIVELSBSTRING')
-    TARGET_SYS=_get_variable_or_empty(variable_name='TARGET_SYS')
-    MACHINE=_get_variable_or_empty(variable_name='MACHINE')
-    DISTRO=_get_variable_or_empty(variable_name='DISTRO')
-    DISTRO_VERSION=_get_variable_or_empty(variable_name='DISTRO_VERSION')
-    TUNE_FEATURES=_get_variable_or_empty(variable_name='TUNE_FEATURES')
-    TARGET_FPU=_get_variable_or_empty(variable_name='TARGET_FPU')
-
-    targets = Target.objects.filter(build=build_id)
-
-    context = {
-                'objectname': 'configuration',
-                'object_search_display':'variables',
-                'filter_search_display':'variables',
-                'build': Build.objects.get(pk=build_id),
-                'BB_VERSION':BB_VERSION,
-                'BUILD_SYS':BUILD_SYS,
-                'NATIVELSBSTRING':NATIVELSBSTRING,
-                'TARGET_SYS':TARGET_SYS,
-                'MACHINE':MACHINE,
-                'DISTRO':DISTRO,
-                'DISTRO_VERSION':DISTRO_VERSION,
-                'TUNE_FEATURES':TUNE_FEATURES,
-                'TARGET_FPU':TARGET_FPU,
-                'targets':targets,
-        }
+    var_names = ('BB_VERSION', 'BUILD_SYS', 'NATIVELSBSTRING', 'TARGET_SYS',
+                 'MACHINE', 'DISTRO', 'DISTRO_VERSION', 'TUNE_FEATURES', 'TARGET_FPU')
+    context = dict(Variable.objects.filter(build=build_id, variable_name__in=var_names)\
+                                           .values_list('variable_name', 'variable_value'))
+    context.update({'objectname': 'configuration',
+                    'object_search_display':'variables',
+                    'filter_search_display':'variables',
+                    'build': Build.objects.get(pk=build_id),
+                    'targets': Target.objects.filter(build=build_id)})
     return render(request, template, context)
 
 
-- 
1.9.1


