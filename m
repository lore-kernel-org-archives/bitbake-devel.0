Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id DC82D65E21
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:45 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id cc10so8854960wib.14
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=d8NtFhkwZkwbyyDUOmhQxEr/HaFYjap2Nb5f7vlItPY=;
	b=HM7FWgmEQ+YAGwpyOQMsTF+XEgtCzlSLyYxtNLGsU01SG7aIRJJKvvCnKopO0x4MO5
	O6/zhevBQW6A1poDcxq+z4gKBWWt9QLTATj9E/ZrDXzGkDNLKpA8rM80KIANDP2uwxvY
	bsArpBuB0GtTO3UrGq6bNqBbEJEYj8/lyv8y9+JgwE4CMD/6HzLTqffVOKCZZsNehU71
	rGC8sqDWV2rlHzMipEPvbaX86GnWyVZv9LpqcTfB40faiAwgzV96PY1JVGeqTXppquUs
	V2Jxu8ooHfr7hPlZN1fxnBFmh+LzDgx+I/YJ6qNGsBPV/eXlppxZPIidvBGlchPa6R+J
	PCLg==
X-Gm-Message-State: ALoCoQlDFMTE39jh9pr73whxT3K6joMJf2Y1580IC2ZlEowzM6G0ppZlar2u+C+J/66zOKtX8Q8l
X-Received: by 10.194.57.239 with SMTP id l15mr9624004wjq.40.1397049466355;
	Wed, 09 Apr 2014 06:17:46 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	bx16sm10061325wib.13.2014.04.09.06.17.43 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:44 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 7CFA0560343; Wed,  9 Apr 2014 14:17:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:38 +0100
Message-Id: <63f47afa9faf429c2c0c6ab9bc9cf6a67538d5ef.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
References: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1397049329.git.alexandru.damian@intel.com>
References: <cover.1397049329.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 7/9] toaster: hide tasks without order or outcome
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:46 -0000

From: David Reyna <David.Reyna@windriver.com>

Hide the incomplete tasks, those without order numbers and/or outcomes.

[YOCTO #6060]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/views.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 78726a8..f5fa72e 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -496,7 +496,8 @@ def task( request, build_id, task_id ):
         context[ 'showing_matches' ] = True
         context[ 'matching_tasks' ] = Task.objects.filter( 
             sstate_checksum=task.sstate_checksum ).filter( 
-            build__completed_on__lt=task.build.completed_on ).order_by('-build__completed_on')
+            build__completed_on__lt=task.build.completed_on).exclude(
+            order__isnull=True).exclude(outcome=Task.OUTCOME_NA).order_by('-build__completed_on')
 
     return render( request, template, context )
 
@@ -509,7 +510,7 @@ def recipe(request, build_id, recipe_id):
     object = Recipe.objects.filter(pk=recipe_id)[0]
     layer_version = Layer_Version.objects.filter(pk=object.layer_version_id)[0]
     layer  = Layer.objects.filter(pk=layer_version.layer_id)[0]
-    tasks  = Task.objects.filter(recipe_id = recipe_id).filter(build_id = build_id).exclude(task_name__endswith='_setscene')
+    tasks  = Task.objects.filter(recipe_id = recipe_id, build_id = build_id).exclude(order__isnull=True).exclude(task_name__endswith='_setscene').exclude(outcome=Task.OUTCOME_NA)
     packages = Package.objects.filter(recipe_id = recipe_id).filter(build_id = build_id).filter(size__gte=0)
 
     context = {
@@ -762,14 +763,16 @@ def dirinfo(request, build_id, target_id, file_path=None):
 def _find_task_dep(task):
     tp = []
     for p in Task_Dependency.objects.filter(task=task):
-        tp.append(p.depends_on);
+        if (p.depends_on.order > 0) and (p.depends_on.outcome != Task.OUTCOME_NA):
+            tp.append(p.depends_on);
     return tp
 
 
 def _find_task_revdep(task):
     tp = []
     for p in Task_Dependency.objects.filter(depends_on=task):
-        tp.append(p.task);
+        if (p.task.order > 0) and (p.task.outcome != Task.OUTCOME_NA):
+            tp.append(p.task);
     return tp
 
 def _find_task_provider(task):
@@ -836,7 +839,7 @@ def tasks_common(request, build_id, variant, task_anchor):
 	        mandatory_parameters['anchor']=task_anchor
         return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Task)
-    queryset_all = Task.objects.filter(build=build_id, order__gt=0)
+    queryset_all = Task.objects.filter(build=build_id).exclude(order__isnull=True).exclude(outcome=Task.OUTCOME_NA)
     queryset_with_search = _get_queryset(Task, queryset_all, None , search_term, ordering_string, 'order')
     queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string, 'order')
 
-- 
1.9.1


