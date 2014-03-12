Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id B50F56F65B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 18:47:43 +0000 (UTC)
Received: by mail-wi0-f180.google.com with SMTP id hm4so87218wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 11:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=JTQ3nkoW1qTglMCTOj4pjpUnfA8VOzLV6cVtKJzpw9Y=;
	b=W6onkyeJBqCzwaQuGnziLD6/pJWXXtKOcIAli26ZK6rQCKmSC7LiQxrwaZU3LKG3zt
	A2PLP+cTp/xGU6AU9LuU/QmHiEVTZ+OgdIMIzYPgKrfcmvEscO/fzzrIot29MQnqI9Fh
	69jo0q7DWDeeaNOvI61OxNwAd7aacsKC0EJ4MPh0MDpDRM+zKnWmI8U3mVHpbgklT3ez
	lqVaVAzpxy0V9m3ZvqoTZcS12rx2o8b+WAlrHbK+dyhZyvZuz+HPtm3xXn4qJxBYPv+o
	TEtGeEQnKOFYSOa9IzOayEsnQyTLNJ37H1hUKABbQgKlC0y0p/1QA5WobgM7kKSMbXYH
	Iomg==
X-Gm-Message-State: ALoCoQlyGPqxXNRqi4dVqAq2ju0ZMmu81a6ZT8G0Q3mDA52G7AMGliWqdjThiCaO8ajnMaKL7rFR
X-Received: by 10.194.58.79 with SMTP id o15mr2773228wjq.62.1394650063885;
	Wed, 12 Mar 2014 11:47:43 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id pm2sm18346429wic.0.2014.03.12.11.47.42
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 12 Mar 2014 11:47:42 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B20D35605D1; Wed, 12 Mar 2014 18:47:43 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Mar 2014 18:47:41 +0000
Message-Id: <378945bc25ff358ec32ed3e07f8a2aa80f306803.1394649860.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f1ccf1eb81e7ba89b9e540a19c839a3dfdef234b.1394649860.git.alexandru.damian@intel.com>
References: <y>
	<f1ccf1eb81e7ba89b9e540a19c839a3dfdef234b.1394649860.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394649860.git.alexandru.damian@intel.com>
References: <cover.1394649860.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Ravi Chintakunta <ravi.chintakunta@timesys.com>
Subject: [PATCH 3/4] toaster: Add counters to filters
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
X-List-Received-Date: Wed, 12 Mar 2014 18:47:46 -0000

From: Ravi Chintakunta <ravi.chintakunta@timesys.com>

Added count to filters in Build, Tasks and Config variables.

[YOCTO #5821]

Signed-off-by: Ravi Chintakunta <ravi.chintakunta@timesys.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../toastergui/templates/filtersnippet.html        | 17 +++--
 lib/toaster/toastergui/views.py                    | 81 ++++++++++++----------
 2 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/lib/toaster/toastergui/templates/filtersnippet.html b/lib/toaster/toastergui/templates/filtersnippet.html
index 2a23c27..e0e1181 100644
--- a/lib/toaster/toastergui/templates/filtersnippet.html
+++ b/lib/toaster/toastergui/templates/filtersnippet.html
@@ -4,16 +4,25 @@
         <input type="hidden" name="search" value="{{request.GET.search}}"/>
         <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
-            <h3>Filter {%if filter_search_display%}{{filter_search_display|title}}{%else%}{{objectname|title}}{%endif%} by '{{tc.name}}'</h3>
+            {% if search_term %}
+                 <h3>Filter {{total_count}} {%if filter_search_display%}{{filter_search_display|title}}{%else%}{{objectname|title}}{%endif%} matching '{{search_term}}' by '{{tc.name}}'</h3>
+            {% else %}
+                <h3>Filter {%if filter_search_display%}{{filter_search_display|title}}{%else%}{{objectname|title}}{%endif%} by '{{tc.name}}'</h3>
+            {% endif %}
         </div>
         <div class="modal-body">
             <p>{{f.label}}</p>
             <label class="radio">
-                <input type="radio" name="filter" {%if request.GET.filter%}{{f.options|check_filter_status:request.GET.filter}} {%else%} checked {%endif%} value="">  All {%if filter_search_display%}{{filter_search_display|title}}{%else%}{{objectname|title}}{%endif%}
+                <input type="radio" name="filter" {%if request.GET.filter%}{{f.options|check_filter_status:request.GET.filter}} {%else%} checked {%endif%} value="">  All {%if filter_search_display%}{{filter_search_display|title}}{%else%}{{objectname|title}}{%endif%} ({{total_count}})
             </label>
             {% for option in f.options %}
-                <label class="radio">
-                    <input type="radio" name="filter" {%if request.GET.filter == option.1 %}checked{%endif%}  value="{{option.1}}"> {{option.0}}
+                {% if option.2 %}
+                    <label class="radio">
+                        <input type="radio" name="filter" {%if request.GET.filter == option.1 %}checked{%endif%}  value="{{option.1}}"> {{option.0}} ({{option.2}})
+                {% else %}
+                    <label class="radio muted">
+                        <input type="radio" name="filter" disabled {%if request.GET.filter == option.1 %}checked{%endif%}  value="{{option.1}}"> {{option.0}} ({{option.2}})
+                {% endif %}
                 </label>
             {% endfor %}
         </div>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index f8c8ccd..a499c30 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -207,8 +207,9 @@ def builds(request):
     # boilerplate code that takes a request for an object type and returns a queryset
     # for that object type. copypasta for all needed table searches
     (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
-    queryset = Build.objects.exclude(outcome = Build.IN_PROGRESS)
-    queryset = _get_queryset(Build, queryset, filter_string, search_term, ordering_string)
+    queryset_all = Build.objects.exclude(outcome = Build.IN_PROGRESS)
+    queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string)
+    queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string)
 
     # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
     build_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
@@ -235,6 +236,8 @@ def builds(request):
             # TODO: common objects for all table views, adapt as needed
                 'objects' : build_info,
                 'objectname' : "builds",
+                'search_term' : search_term,
+                'total_count' : queryset_with_search.count(),
             # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
                 'tablecols' : [
                 {'name': 'Outcome ',                                                # column with a single filter
@@ -248,8 +251,8 @@ def builds(request):
                  'filter' : {'class' : 'outcome',
                              'label': 'Show:',
                              'options' : [
-                                         ('Successful builds', 'outcome:' + str(Build.SUCCEEDED)),  # this is the field search expression
-                                         ('Failed builds', 'outcome:'+ str(Build.FAILED)),
+                                         ('Successful builds', 'outcome:' + str(Build.SUCCEEDED), queryset_with_search.filter(outcome=str(Build.SUCCEEDED)).count()),  # this is the field search expression
+                                         ('Failed builds', 'outcome:'+ str(Build.FAILED), queryset_with_search.filter(outcome=str(Build.FAILED)).count()),
                                          ]
                             }
                 },
@@ -271,9 +274,9 @@ def builds(request):
                  'filter' : {'class' : 'started_on',
                              'label': 'Show:',
                              'options' : [
-                                         ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d")),
-                                         ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d")),
-                                         ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d")),
+                                         ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=timezone.now().strftime("%Y-%m-%d")).count()),
+                                         ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d")).count()),
+                                         ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d")).count()),
                                          ]
                             }
                 },
@@ -284,9 +287,9 @@ def builds(request):
                  'filter' : {'class' : 'completed_on', 
                              'label': 'Show:', 
                              'options' : [
-                                         ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d")),
-                                         ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d")),
-                                         ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d")),
+                                         ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=timezone.now().strftime("%Y-%m-%d")).count()),
+                                         ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d")).count()),
+                                         ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d")).count()),
                                          ]
                             }
                 },
@@ -295,8 +298,8 @@ def builds(request):
                  'filter' : {'class' : 'failed_tasks',
                              'label': 'Show:',
                              'options' : [
-                                         ('Builds with failed tasks', 'task_build__outcome:4'),
-                                         ('Builds without failed tasks', 'task_build__outcome:NOT4'),
+                                         ('Builds with failed tasks', 'task_build__outcome:4', queryset_with_search.filter(task_build__outcome=4).count()),
+                                         ('Builds without failed tasks', 'task_build__outcome:NOT4', queryset_with_search.filter(~Q(task_build__outcome=4)).count()),
                                          ]
                             }
                 },
@@ -307,8 +310,8 @@ def builds(request):
                  'filter' : {'class' : 'errors_no', 
                              'label': 'Show:', 
                              'options' : [
-                                         ('Builds with errors', 'errors_no__gte:1'),
-                                         ('Builds without errors', 'errors_no:0'),
+                                         ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
+                                         ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
                                          ]
                             }
                 },
@@ -319,8 +322,8 @@ def builds(request):
                  'filter' : {'class' : 'warnings_no', 
                              'label': 'Show:', 
                              'options' : [
-                                         ('Builds with warnings','warnings_no__gte:1'),
-                                         ('Builds without warnings','warnings_no:0'),
+                                         ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
+                                         ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
                                          ]
                             }
                 },
@@ -492,8 +495,9 @@ def tasks_common(request, build_id, variant):
     if retval:
         return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Task)
-    queryset = Task.objects.filter(build=build_id, order__gt=0)
-    queryset = _get_queryset(Task, queryset, filter_string, search_term, ordering_string)
+    queryset_all = Task.objects.filter(build=build_id, order__gt=0)
+    queryset_with_search = _get_queryset(Task, queryset_all, None , search_term, ordering_string)
+    queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string)
 
     tasks = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
 
@@ -537,8 +541,8 @@ def tasks_common(request, build_id, variant):
                    'class' : 'executed',
                    'label': 'Show:',
                    'options' : [
-                               ('Executed Tasks', 'task_executed:1'),
-                               ('Not Executed Tasks', 'task_executed:0'),
+                               ('Executed Tasks', 'task_executed:1', queryset_with_search.filter(task_executed=1).count()),
+                               ('Not Executed Tasks', 'task_executed:0', queryset_with_search.filter(task_executed=0).count()),
                                ]
                    }
 
@@ -553,12 +557,12 @@ def tasks_common(request, build_id, variant):
                    'class' : 'outcome',
                    'label': 'Show:',
                    'options' : [
-                               ('Succeeded Tasks', 'outcome:%d'%Task.OUTCOME_SUCCESS),
-                               ('Failed Tasks', 'outcome:%d'%Task.OUTCOME_FAILED),
-                               ('Cached Tasks', 'outcome:%d'%Task.OUTCOME_CACHED),
-                               ('Prebuilt Tasks', 'outcome:%d'%Task.OUTCOME_PREBUILT),
-                               ('Covered Tasks', 'outcome:%d'%Task.OUTCOME_COVERED),
-                               ('Empty Tasks', 'outcome:%d'%Task.OUTCOME_EMPTY),
+                               ('Succeeded Tasks', 'outcome:%d'%Task.OUTCOME_SUCCESS, queryset_with_search.filter(outcome=Task.OUTCOME_SUCCESS).count() ),
+                               ('Failed Tasks', 'outcome:%d'%Task.OUTCOME_FAILED, queryset_with_search.filter(outcome=Task.OUTCOME_FAILED).count()),
+                               ('Cached Tasks', 'outcome:%d'%Task.OUTCOME_CACHED, queryset_with_search.filter(outcome=Task.OUTCOME_CACHED).count()),
+                               ('Prebuilt Tasks', 'outcome:%d'%Task.OUTCOME_PREBUILT, queryset_with_search.filter(outcome=Task.OUTCOME_PREBUILT).count()),
+                               ('Covered Tasks', 'outcome:%d'%Task.OUTCOME_COVERED, queryset_with_search.filter(outcome=Task.OUTCOME_COVERED).count()),
+                               ('Empty Tasks', 'outcome:%d'%Task.OUTCOME_EMPTY, queryset_with_search.filter(outcome=Task.OUTCOME_NA).count()),
                                ]
                    }
 
@@ -580,10 +584,10 @@ def tasks_common(request, build_id, variant):
                    'class' : 'cache_attempt',
                    'label': 'Show:',
                    'options' : [
-                               ('Tasks with cache attempts', 'sstate_result:%d'%Task.SSTATE_NA),
-                               ("Tasks with 'File not in cache' attempts", 'sstate_result:%d'%Task.SSTATE_MISS),
-                               ("Tasks with 'Failed' cache attempts", 'sstate_result:%d'%Task.SSTATE_FAILED),
-                               ("Tasks with 'Succeeded' cache attempts", 'sstate_result:%d'%Task.SSTATE_RESTORED),
+                               ('Tasks with cache attempts', 'sstate_result:%d'%Task.SSTATE_NA, queryset_with_search.filter(sstate_result=Task.SSTATE_NA).count()),
+                               ("Tasks with 'File not in cache' attempts", 'sstate_result:%d'%Task.SSTATE_MISS,  queryset_with_search.filter(sstate_result=Task.SSTATE_MISS).count()),
+                               ("Tasks with 'Failed' cache attempts", 'sstate_result:%d'%Task.SSTATE_FAILED,  queryset_with_search.filter(sstate_result=Task.SSTATE_FAILED).count()),
+                               ("Tasks with 'Succeeded' cache attempts", 'sstate_result:%d'%Task.SSTATE_RESTORED,  queryset_with_search.filter(sstate_result=Task.SSTATE_RESTORED).count()),
                                ]
                    }
 
@@ -621,6 +625,8 @@ def tasks_common(request, build_id, variant):
                 'title': title_variant,
                 'build': Build.objects.filter(pk=build_id)[0],
                 'objects': tasks,
+                'search_term': search_term,
+                'total_count': queryset_with_search.count(),
                 'tablecols':[
                     tc_order,
                     tc_recipe,
@@ -784,6 +790,7 @@ def configvars(request, build_id):
 
     (filter_string, search_term, ordering_string) = _search_tuple(request, Variable)
     queryset = Variable.objects.filter(build=build_id).exclude(variable_name__istartswith='B_').exclude(variable_name__istartswith='do_')
+    queryset_with_search =  _get_queryset(Variable, queryset, None, search_term, ordering_string).distinct().exclude(variable_value='',vhistory__file_name__isnull=True)
     queryset = _get_queryset(Variable, queryset, filter_string, search_term, ordering_string)
     # remove duplicate records from multiple search hits in the VariableHistory table
     queryset = queryset.distinct()
@@ -811,6 +818,8 @@ def configvars(request, build_id):
                 'file_filter': file_filter,
                 'build': Build.objects.filter(pk=build_id)[0],
                 'objects' : variables,
+                'total_count':queryset_with_search.count(),
+                'search_term':search_term,
             # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
                 'tablecols' : [
                 {'name': 'Variable ',
@@ -835,11 +844,11 @@ def configvars(request, build_id):
                     'class' : 'vhistory__file_name',
                     'label': 'Show:',
                     'options' : [
-                               ('Local configuration variables', 'vhistory__file_name__regex:conf/(local|bblayers).conf'),
-                               ('Machine configuration variables', 'vhistory__file_name__contains:conf/machine/'),
-                               ('Distro configuration variables', 'vhistory__file_name__contains:conf/distro/'),
-                               ('Layer configuration variables', 'vhistory__file_name__contains:conf/layer.conf'),
-                               ('bitbake.conf variables', 'vhistory__file_name__contains:/bitbake.conf'),
+                               ('Local configuration variables', 'vhistory__file_name__regex:conf/(local|bblayers).conf', queryset_with_search.filter(vhistory__file_name__contains='conf/local.conf').count()),
+                               ('Machine configuration variables', 'vhistory__file_name__contains:conf/machine/',queryset_with_search.filter(vhistory__file_name__contains='conf/machine').count()),
+                               ('Distro configuration variables', 'vhistory__file_name__contains:conf/distro/',queryset_with_search.filter(vhistory__file_name__contains='conf/distro').count()),
+                               ('Layer configuration variables', 'vhistory__file_name__contains:conf/layer.conf',queryset_with_search.filter(vhistory__file_name__contains='conf/layer.conf').count()),
+                               ('bitbake.conf variables', 'vhistory__file_name__contains:/bitbake.conf',queryset_with_search.filter(vhistory__file_name__contains='/bitbake.conf').count()),
                                ]
                              },
                 },
@@ -851,7 +860,7 @@ def configvars(request, build_id):
                     'class' : 'description',
                     'label': 'Show:',
                     'options' : [
-                               ('Variables with description', 'description__regex:.+'),
+                               ('Variables with description', 'description__regex:.+', queryset_with_search.filter(description__regex='.+').count()),
                                ]
                             },
                 },
-- 
1.8.3.2


