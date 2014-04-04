Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 741476EE4D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:11:01 +0000 (UTC)
Received: by mail-wg0-f50.google.com with SMTP id x13so3603995wgg.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=w/zvLHa0zYn+9H28BM5rteB+SroNc60lb4IEgGJQ4W8=;
	b=mBD5R7U1m8utPKmmtoz/f/kDwHoJcDR2ZmbTKAskrcN8NOeRHgdB2wlNeMUVFy8SUf
	b6vL2jBNNuEEsmrMyFEVAvqYrbwt9Sf7w/p5ktfv8Wa/dBbihouVJ+3UmNGURGipnrRM
	TOqXdMORvAMiHnbbVKtRuJNPLbtZd0psWP5hqHPjy7SGfPhDrgDuJ9t9bDuUzfFszIk1
	sEVoDHT5SCNbqjmMeOf//5kgEDlFHSUb3ekGRdHhdQ1tHo3HqX9rOzw9VjxpTTF1aTCO
	6G0Y86IEgtHoQAHskGJlnLDrYbhvB6qW8YpwFGT49mpy31GAxWFSZwKhtsIRzyMG1poq
	MgLg==
X-Gm-Message-State: ALoCoQlst6tuuIntkEeg20osImID1ywcMqNS3yOUwuCR5KgRE3P6aR/UPFL/kZmmPax5GHkw3Slp
X-Received: by 10.180.211.208 with SMTP id ne16mr4877727wic.21.1396620662029; 
	Fri, 04 Apr 2014 07:11:02 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id cu6sm2946808wjb.8.2014.04.04.07.10.59
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:11:01 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 995B2560F88; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:53 +0100
Message-Id: <21e31a9751934c23c19ec919116455369137c93a.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Cc: Farrell Wymore <farrell.wymore@windriver.com>
Subject: [PATCH 14/14] toaster: added covered task list
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
X-List-Received-Date: Fri, 04 Apr 2014 14:11:02 -0000

From: Farrell Wymore <farrell.wymore@windriver.com>

if a task has a 'covered' indication, the list of tasks that
covered the task are computed and displayed. amended to add tooltip.

[YOCTO #5925]

Signed-off-by: Farrell Wymore <farrell.wymore@windriver.com>
---
 lib/toaster/toastergui/templates/task.html | 11 ++++-
 lib/toaster/toastergui/views.py            | 64 ++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index c1504b6..66a6695 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -109,7 +109,16 @@
             </dt>
             <dd>
                 <ul>
-                    <li><p class="alert-info">TODO:Covering tasks will be displayed here</p></li>
+                  {% for t in covered_by %}
+                    <li>
+                      <a href="{%url 'task' t.build.pk t.pk%}"
+                         class="task-info"
+                        title="{{t.get_executed_display}} | {{t.get_outcome_display}}">
+                        {{t.recipe.name}}_{{t.recipe.version}}
+                        {{t.task_name}}
+                      </a>
+                    </li>
+                  {% endfor %}
                 </ul>
             </dd>
         </dl>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 2da81c1..910b3b9 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -448,38 +448,58 @@ def builddashboard( request, build_id ):
     return render( request, template, context )
 
 
-def task(request, build_id, task_id):
-    template = "task.html"
-    if Task.objects.filter(pk=task_id).count() == 0 :
-        return redirect(builds)
-    task = Task.objects.filter(pk=task_id)[0]
-
-    dependencies = sorted(_find_task_dep(task), key=lambda t:'%s_%s %s'%(t.recipe.name, t.recipe.version, t.task_name))
-    reverse_dependencies = sorted(_find_task_revdep(task), key=lambda t:'%s_%s %s'%(t.recipe.name, t.recipe.version, t.task_name))
+def generateCoveredList( task ):
+    revList = _find_task_revdep( task );
+    list = { };
+    for t in revList:
+        if ( t.outcome == Task.OUTCOME_COVERED ):
+            list.update( generateCoveredList( t ));
+        else:
+            list[ t.task_name ] = t;
+    return( list );
 
+def task( request, build_id, task_id ):
+    template = "task.html"
+    tasks = Task.objects.filter( pk=task_id )
+    if tasks.count( ) == 0:
+        return redirect( builds )
+    task = tasks[ 0 ];
+    dependencies = sorted(
+        _find_task_dep( task ),
+        key=lambda t:'%s_%s %s'%(t.recipe.name, t.recipe.version, t.task_name))
+    reverse_dependencies = sorted(
+        _find_task_revdep( task ),
+        key=lambda t:'%s_%s %s'%( t.recipe.name, t.recipe.version, t.task_name ))
+    coveredBy = '';
+    if ( task.outcome == Task.OUTCOME_COVERED ):
+        dict = generateCoveredList( task )
+        coveredBy = [ ]
+        for name, t in dict.items( ):
+            coveredBy.append( t )
     log_head = ''
     log_body = ''
     if task.outcome == task.OUTCOME_FAILED:
         pass
-# FIXME: the log should be read from the orm_logmessage table.
-# This will be fixed when the backend is done.
 
     context = {
-            'build' : Build.objects.filter(pk=build_id)[0],
-            'object': task,
-            'task':task,
-            'deps': dependencies,
-            'rdeps': reverse_dependencies,
-            'log_head':log_head,
-            'log_body':log_body,
-            'showing_matches':False,
+            'build'           : Build.objects.filter( pk = build_id )[ 0 ],
+            'object'          : task,
+            'task'            : task,
+            'covered_by'      : coveredBy,
+            'deps'            : dependencies,
+            'rdeps'           : reverse_dependencies,
+            'log_head'        : log_head,
+            'log_body'        : log_body,
+            'showing_matches' : False,
     }
+    if request.GET.get( 'show_matches', "" ):
+        context[ 'showing_matches' ] = True
+        context[ 'matching_tasks' ] = Task.objects.filter( 
+            sstate_checksum=task.sstate_checksum ).filter( 
+            build__completed_on__lt=task.build.completed_on ).order_by('-build__completed_on')
 
-    if request.GET.get('show_matches', ""):
-        context['showing_matches'] = True
-        context['matching_tasks'] = Task.objects.filter(sstate_checksum=task.sstate_checksum).filter(build__completed_on__lt=task.build.completed_on).order_by('-build__completed_on')
+    return render( request, template, context )
 
-    return render(request, template, context)
 
 def recipe(request, build_id, recipe_id):
     template = "recipe.html"
-- 
1.9.1


