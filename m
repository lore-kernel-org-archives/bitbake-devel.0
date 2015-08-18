Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id C139576A15
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:11 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so113359927wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=xz0eUMdDXHyNKatDwwvn++6VSewlRt3HF7TEH4ZoQVA=;
	b=Aa8jTIOwZBdztRLRRsBaGnREfcPw6uZzh+Qm6nqnHYatVPKQUM1F09ncgpIqTmcZr8
	BPL9VepORDxexrkHru2tLfq8ME/x9k+zQ9E3lA+WVPb/GIYP4mNdEe0nPzvPRyMrU/Gg
	tvUI5F42k0ZWtyr1O3hJ4aKYLcKQ3UGvi8yAhg7Y75dT3eLSBnKmfVCe2SIuZsAQFN5Z
	4x9+kNKW2oyflruL6Tx4wsuD+aJHSxceILeJWtoD4Ha9zvRkSWbU3Uk/1VNwKuccl4EL
	E9T00uvrd8g0cWDVTTD4KOunI7v68tIpmo0hZ7l/cxcUfSBLz8kJkc3gb3rVkFxK5l6k
	PRSw==
X-Gm-Message-State: ALoCoQmBnPkZ00PvF+PyObSVYCD+0Trb6PBCjDIYsgWGPK7Uy06qCy3pBwW8Ak29pUYiXHZyxJ6w
X-Received: by 10.180.72.35 with SMTP id a3mr43669577wiv.21.1439915351098;
	Tue, 18 Aug 2015 09:29:11 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:10 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:53 +0100
Message-Id: <c4c7fba1e0ce342682582d1c795427d77d6affd9.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 07/14] bitbake: toastergui: rename variables in views.py
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Renaming various variables in the views.py file to make
the code more readable, and prevent overshadowing of global
variables with local variables that have a different name.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 116 ++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 53 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index ddc7703..e9c246f 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -284,30 +284,30 @@ def _get_toggle_order_icon(request, orderkey):
         return None
 
 # we check that the input comes in a valid form that we can recognize
-def _validate_input(input, model):
+def _validate_input(field_input, model):
 
     invalid = None
 
-    if input:
-        input_list = input.split(FIELD_SEPARATOR)
+    if field_input:
+        field_input_list = field_input.split(FIELD_SEPARATOR)
 
         # Check we have only one colon
-        if len(input_list) != 2:
-            invalid = "We have an invalid number of separators: " + input + " -> " + str(input_list)
+        if len(field_input_list) != 2:
+            invalid = "We have an invalid number of separators: " + field_input + " -> " + str(field_input_list)
             return None, invalid
 
         # Check we have an equal number of terms both sides of the colon
-        if len(input_list[0].split(AND_VALUE_SEPARATOR)) != len(input_list[1].split(AND_VALUE_SEPARATOR)):
+        if len(field_input_list[0].split(AND_VALUE_SEPARATOR)) != len(field_input_list[1].split(AND_VALUE_SEPARATOR)):
             invalid = "Not all arg names got values"
-            return None, invalid + str(input_list)
+            return None, invalid + str(field_input_list)
 
         # Check we are looking for a valid field
         valid_fields = model._meta.get_all_field_names()
-        for field in input_list[0].split(AND_VALUE_SEPARATOR):
-            if not reduce(lambda x, y: x or y, map(lambda x: field.startswith(x), [ x for x in valid_fields ])):
+        for field in field_input_list[0].split(AND_VALUE_SEPARATOR):
+            if not reduce(lambda x, y: x or y, [ field.startswith(x) for x in valid_fields ]):
                 return None, (field, [ x for x in valid_fields ])
 
-    return input, invalid
+    return field_input, invalid
 
 # uses search_allowed_fields in orm/models.py to create a search query
 # for these fields with the supplied input text
@@ -542,23 +542,23 @@ def generateCoveredList2( revlist = None ):
 
 def task( request, build_id, task_id ):
     template = "task.html"
-    tasks = Task.objects.filter( pk=task_id )
-    if tasks.count( ) == 0:
+    tasks_list = Task.objects.filter( pk=task_id )
+    if tasks_list.count( ) == 0:
         return redirect( builds )
-    task = tasks[ 0 ];
+    task_object = tasks_list[ 0 ];
     dependencies = sorted(
-        _find_task_dep( task ),
+        _find_task_dep( task_object ),
         key=lambda t:'%s_%s %s'%(t.recipe.name, t.recipe.version, t.task_name))
     reverse_dependencies = sorted(
-        _find_task_revdep( task ),
+        _find_task_revdep( task_object ),
         key=lambda t:'%s_%s %s'%( t.recipe.name, t.recipe.version, t.task_name ))
     coveredBy = '';
-    if ( task.outcome == Task.OUTCOME_COVERED ):
+    if ( task_object.outcome == Task.OUTCOME_COVERED ):
 #        _list = generateCoveredList( task )
-        coveredBy = sorted(generateCoveredList2( _find_task_revdep( task ) ), key = lambda x: x.recipe.name)
+        coveredBy = sorted(generateCoveredList2( _find_task_revdep( task_object ) ), key = lambda x: x.recipe.name)
     log_head = ''
     log_body = ''
-    if task.outcome == task.OUTCOME_FAILED:
+    if task_object.outcome == task_object.OUTCOME_FAILED:
         pass
 
     uri_list= [ ]
@@ -570,12 +570,13 @@ def task( request, build_id, task_id ):
     if (v.count() > 0):
         for mirror in v[0].variable_value.split('\\n'):
             s=re.sub('.* ','',mirror.strip(' \t\n\r'))
-            if len(s): uri_list.append(s)
+            if len(s):
+                uri_list.append(s)
 
     context = {
             'build'           : Build.objects.filter( pk = build_id )[ 0 ],
-            'object'          : task,
-            'task'            : task,
+            'object'          : task_object,
+            'task'            : task_object,
             'covered_by'      : coveredBy,
             'deps'            : dependencies,
             'rdeps'           : reverse_dependencies,
@@ -587,8 +588,8 @@ def task( request, build_id, task_id ):
     if request.GET.get( 'show_matches', "" ):
         context[ 'showing_matches' ] = True
         context[ 'matching_tasks' ] = Task.objects.filter(
-            sstate_checksum=task.sstate_checksum ).filter(
-            build__completed_on__lt=task.build.completed_on).exclude(
+            sstate_checksum=task_object.sstate_checksum ).filter(
+            build__completed_on__lt=task_object.build.completed_on).exclude(
             order__isnull=True).exclude(outcome=Task.OUTCOME_NA).order_by('-build__completed_on')
 
     return render( request, template, context )
@@ -598,10 +599,10 @@ def recipe(request, build_id, recipe_id, active_tab="1"):
     if Recipe.objects.filter(pk=recipe_id).count() == 0 :
         return redirect(builds)
 
-    object = Recipe.objects.get(pk=recipe_id)
-    layer_version = Layer_Version.objects.get(pk=object.layer_version_id)
+    recipe_object = Recipe.objects.get(pk=recipe_id)
+    layer_version = Layer_Version.objects.get(pk=recipe_object.layer_version_id)
     layer  = Layer.objects.get(pk=layer_version.layer_id)
-    tasks  = Task.objects.filter(recipe_id = recipe_id, build_id = build_id).exclude(order__isnull=True).exclude(task_name__endswith='_setscene').exclude(outcome=Task.OUTCOME_NA)
+    tasks_list  = Task.objects.filter(recipe_id = recipe_id, build_id = build_id).exclude(order__isnull=True).exclude(task_name__endswith='_setscene').exclude(outcome=Task.OUTCOME_NA)
     package_count = Package.objects.filter(recipe_id = recipe_id).filter(build_id = build_id).filter(size__gte=0).count()
 
     if active_tab != '1' and active_tab != '3' and active_tab != '4' :
@@ -611,10 +612,10 @@ def recipe(request, build_id, recipe_id, active_tab="1"):
 
     context = {
             'build'   : Build.objects.get(pk=build_id),
-            'object'  : object,
+            'object'  : recipe_object,
             'layer_version' : layer_version,
             'layer'   : layer,
-            'tasks'   : tasks,
+            'tasks'   : tasks_list,
             'package_count' : package_count,
             'tab_states' : tab_states,
     }
@@ -632,7 +633,7 @@ def recipe_packages(request, build_id, recipe_id):
         return _redirect_parameters( 'recipe_packages', request.GET, mandatory_parameters, build_id = build_id, recipe_id = recipe_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Package)
 
-    recipe = Recipe.objects.get(pk=recipe_id)
+    recipe_object = Recipe.objects.get(pk=recipe_id)
     queryset = Package.objects.filter(recipe_id = recipe_id).filter(build_id = build_id).filter(size__gte=0)
     package_count = queryset.count()
     queryset = _get_queryset(Package, queryset, filter_string, search_term, ordering_string, 'name')
@@ -641,7 +642,7 @@ def recipe_packages(request, build_id, recipe_id):
 
     context = {
             'build'   : Build.objects.get(pk=build_id),
-            'recipe'  : recipe,
+            'recipe'  : recipe_object,
             'objects'  : packages,
             'object_count' : package_count,
             'tablecols':[
@@ -952,13 +953,13 @@ def dirinfo(request, build_id, target_id, file_path=None):
               }
     return render(request, template, context)
 
-def _find_task_dep(task):
-    return map(lambda x: x.depends_on, Task_Dependency.objects.filter(task=task).filter(depends_on__order__gt = 0).exclude(depends_on__outcome = Task.OUTCOME_NA).select_related("depends_on"))
+def _find_task_dep(task_object):
+    return map(lambda x: x.depends_on, Task_Dependency.objects.filter(task=task_object).filter(depends_on__order__gt = 0).exclude(depends_on__outcome = Task.OUTCOME_NA).select_related("depends_on"))
 
 
-def _find_task_revdep(task):
+def _find_task_revdep(task_object):
     tp = []
-    tp = map(lambda t: t.task, Task_Dependency.objects.filter(depends_on=task).filter(task__order__gt=0).exclude(task__outcome = Task.OUTCOME_NA).select_related("task", "task__recipe", "task__build"))
+    tp = map(lambda t: t.task, Task_Dependency.objects.filter(depends_on=task_object).filter(task__order__gt=0).exclude(task__outcome = Task.OUTCOME_NA).select_related("task", "task__recipe", "task__build"))
     return tp
 
 def _find_task_revdep_list(tasklist):
@@ -966,8 +967,8 @@ def _find_task_revdep_list(tasklist):
     tp = map(lambda t: t.task, Task_Dependency.objects.filter(depends_on__in=tasklist).filter(task__order__gt=0).exclude(task__outcome = Task.OUTCOME_NA).select_related("task", "task__recipe", "task__build"))
     return tp
 
-def _find_task_provider(task):
-    task_revdeps = _find_task_revdep(task)
+def _find_task_provider(task_object):
+    task_revdeps = _find_task_revdep(task_object)
     for tr in task_revdeps:
         if tr.outcome != Task.OUTCOME_COVERED:
             return tr
@@ -1055,15 +1056,15 @@ def tasks_common(request, build_id, variant, task_anchor):
         i=0
         a=int(anchor)
         count_per_page=int(pagesize)
-        for task in queryset.iterator():
-            if a == task.order:
+        for task_object in queryset.iterator():
+            if a == task_object.order:
                 new_page= (i / count_per_page ) + 1
                 request.GET.__setitem__('page', new_page)
                 mandatory_parameters['page']=new_page
                 return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
             i += 1
 
-    tasks = _build_page_range(Paginator(queryset, pagesize),request.GET.get('page', 1))
+    task_objects = _build_page_range(Paginator(queryset, pagesize),request.GET.get('page', 1))
 
     # define (and modify by variants) the 'tablecols' members
     tc_order={
@@ -1073,7 +1074,10 @@ def tasks_common(request, build_id, variant, task_anchor):
         'orderkey' : 'order',
         'orderfield':_get_toggle_order(request, "order"),
         'ordericon':_get_toggle_order_icon(request, "order")}
-    if 'tasks' == variant: tc_order['hidden']='0'; del tc_order['clclass']
+    if 'tasks' == variant:
+        tc_order['hidden']='0'
+        del tc_order['clclass']
+
     tc_recipe={
         'name':'Recipe',
         'qhelp':'The name of the recipe to which each task applies',
@@ -1131,14 +1135,7 @@ def tasks_common(request, build_id, variant, task_anchor):
                    }
 
     }
-    tc_log={
-        'name':'Log',
-        'qhelp':'Path to the task log file',
-        'orderfield': _get_toggle_order(request, "logfile"),
-        'ordericon':_get_toggle_order_icon(request, "logfile"),
-        'orderkey' : 'logfile',
-        'clclass': 'task_log', 'hidden' : 1,
-    }
+
     tc_cache={
         'name':'Cache attempt',
         'qhelp':'This column tells you if a task tried to restore output from the <code>sstate-cache</code> directory or mirrors, and reports the result: Succeeded, Failed or File not in cache',
@@ -1167,7 +1164,11 @@ def tasks_common(request, build_id, variant, task_anchor):
         'orderkey' : 'elapsed_time',
         'clclass': 'time_taken', 'hidden' : 1,
     }
-    if   'buildtime' == variant: tc_time['hidden']='0'; del tc_time['clclass']; tc_cache['hidden']='1';
+    if 'buildtime' == variant:
+        tc_time['hidden']='0'
+        del tc_time['clclass']
+        tc_cache['hidden']='1'
+
     tc_cpu={
         'name':'CPU usage',
         'qhelp':'The percentage of task CPU utilization',
@@ -1176,7 +1177,12 @@ def tasks_common(request, build_id, variant, task_anchor):
         'orderkey' : 'cpu_usage',
         'clclass': 'cpu_used', 'hidden' : 1,
     }
-    if   'cpuusage' == variant: tc_cpu['hidden']='0'; del tc_cpu['clclass']; tc_cache['hidden']='1';
+
+    if  'cpuusage' == variant:
+        tc_cpu['hidden']='0'
+        del tc_cpu['clclass']
+        tc_cache['hidden']='1'
+
     tc_diskio={
         'name':'Disk I/O (ms)',
         'qhelp':'Number of miliseconds the task spent doing disk input and output',
@@ -1185,7 +1191,10 @@ def tasks_common(request, build_id, variant, task_anchor):
         'orderkey' : 'disk_io',
         'clclass': 'disk_io', 'hidden' : 1,
     }
-    if   'diskio' == variant: tc_diskio['hidden']='0'; del tc_diskio['clclass']; tc_cache['hidden']='1';
+    if 'diskio' == variant:
+        tc_diskio['hidden']='0'
+        del tc_diskio['clclass']
+        tc_cache['hidden']='1'
 
     build = Build.objects.get(pk=build_id)
 
@@ -1194,7 +1203,7 @@ def tasks_common(request, build_id, variant, task_anchor):
                 'filter_search_display': filter_search_display,
                 'title': title_variant,
                 'build': build,
-                'objects': tasks,
+                'objects': task_objects,
                 'default_orderby' : orderby,
                 'search_term': search_term,
                 'total_count': queryset_with_search.count(),
@@ -1246,7 +1255,8 @@ def recipes(request, build_id):
     recipes = _build_page_range(Paginator(queryset, pagesize),request.GET.get('page', 1))
 
     # prefetch the forward and reverse recipe dependencies
-    deps = { }; revs = { }
+    deps = { }
+    revs = { }
     queryset_dependency=Recipe_Dependency.objects.filter(recipe__layer_version__build_id = build_id).select_related("depends_on", "recipe")
     for recipe in recipes:
         deplist = [ ]
-- 
2.1.4


