Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id D7F516B728
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:56 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id q5so1352643wiv.16
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AtGNmdNnRC1F/hYAQQUd81Od+LF9aaP8/6GyALYujWA=;
	b=gEnBE4D753arULhYM8Ntv6FY5PRJcugSj3mjYUgmvXZnkRiXhT+Z81KFWLnwWpCxFK
	VKfOq79/hkXK51UboQYNsBJhkGtAJ1SgVQTW+QQV7WBosZcN1/oBRc5jHzpOMAtcr1XW
	EloJeKFKUU8qvXmiSip3CxyasXPEpeis12MXdvksHRpn6RVjqAmUT+22Ba//ZI2XQi5I
	hMRtBTl5x+4u+xOZIT63IGvMoQjZsd5y76NEr+YSOET5SId6k0D6zs6SZA9lnYYZK2I7
	8NOCj/L1ZAZsPC4EQZYprRRwNekWVd+AQXmWGga3A0e/GjMf7vuJEaOmtSQirZ5D4qzN
	1pZw==
X-Gm-Message-State: ALoCoQnpZ1lc/KhgRfolqayFNNXPlcM+vlxRddTdj7YJiQBz3sd6GHamrllXF/Ikiw0uBby4ALkq
X-Received: by 10.194.204.199 with SMTP id la7mr20715199wjc.4.1396620657095;
	Fri, 04 Apr 2014 07:10:57 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	rx9sm12620480wjb.20.2014.04.04.07.10.54 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:55 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 806D8560327; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:40 +0100
Message-Id: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 01/14] toaster: link task order to right tasks page
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
X-List-Received-Date: Fri, 04 Apr 2014 14:10:57 -0000

From: David Reyna <David.Reyna@windriver.com>

When linking from a task order number to the All Tasks
page, automatically display the correct page for that link
anchor.

[YOCTO #5933]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/task.html |  2 +-
 lib/toaster/toastergui/urls.py             |  1 +
 lib/toaster/toastergui/views.py            | 36 +++++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 1a7e9d4..5c32250 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -199,7 +199,7 @@
         <i class="icon-question-sign get-help" title="The running sequence of each task in the build"></i>
         Task order
     </dt>
-    <dd><a href="{%url "tasks" build.pk %}#{{task.order}}">{{task.order}}</a></dd>
+    <dd><a href="{%url "tasks_task" build.pk task.order %}#{{task.order}}">{{task.order}}</a></dd>
     {% if task.task_executed %}
         <dt>
             <i class="icon-question-sign get-help" title="If this task executes a Python or Shell function(s)"></i>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index ac83b38..d7e9457 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -26,6 +26,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^build/(?P<build_id>\d+)$', 'builddashboard', name="builddashboard"),
 
         url(r'^build/(?P<build_id>\d+)/tasks/$', 'tasks', name='tasks'),
+        url(r'^build/(?P<build_id>\d+)/tasks/(?P<task_id>\d+)/$', 'tasks_task', name='tasks_task'),
         url(r'^build/(?P<build_id>\d+)/task/(?P<task_id>\d+)$', 'task', name='task'),
 
         url(r'^build/(?P<build_id>\d+)/recipes/$', 'recipes', name='recipes'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 05e24ea..a92a03f 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -196,7 +196,7 @@ def _get_queryset(model, queryset, filter_string, search_term, ordering_string,
         else:
             queryset = queryset.order_by(column)
 
-    # insure only distinct records (e.g. from multiple search hits) are returned 
+    # insure only distinct records (e.g. from multiple search hits) are returned
     return queryset.distinct()
 
 
@@ -746,7 +746,7 @@ def _find_task_provider(task):
             return trc
     return None
 
-def tasks_common(request, build_id, variant):
+def tasks_common(request, build_id, variant, task_anchor):
 # This class is shared between these pages
 #
 # Column    tasks  buildtime  diskio  cpuusage
@@ -766,6 +766,10 @@ def tasks_common(request, build_id, variant):
 # 'min':on always, 'def':on by default, else hidden
 # '+' default column sort up, '-' default column sort down
 
+    anchor = request.GET.get('anchor', '')
+    if not anchor:
+        anchor=task_anchor
+
     # default ordering depends on variant
     if   'buildtime' == variant:
         title_variant='Time'
@@ -791,12 +795,29 @@ def tasks_common(request, build_id, variant):
     template = 'tasks.html'
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
+        if task_anchor:
+	        mandatory_parameters['anchor']=task_anchor
         return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Task)
     queryset_all = Task.objects.filter(build=build_id, order__gt=0)
     queryset_with_search = _get_queryset(Task, queryset_all, None , search_term, ordering_string, 'order')
     queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string, 'order')
 
+	# compute the anchor's page
+    if anchor:
+	    request.GET = request.GET.copy()
+        del request.GET['anchor']
+        i=0
+        a=int(anchor)
+		count_per_page=int(request.GET.get('count', 100))
+        for task in queryset.iterator():
+            if a == task.order:
+				new_page= (i / count_per_page ) + 1
+				request.GET.__setitem__('page', new_page)
+				mandatory_parameters['page']=new_page
+				return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
+            i += 1
+
     tasks = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
 
     # define (and modify by variants) the 'tablecols' members
@@ -937,16 +958,19 @@ def tasks_common(request, build_id, variant):
     return render(request, template, context)
 
 def tasks(request, build_id):
-    return tasks_common(request, build_id, 'tasks')
+    return tasks_common(request, build_id, 'tasks', '')
+
+def tasks_task(request, build_id, task_id):
+    return tasks_common(request, build_id, 'tasks', task_id)
 
 def buildtime(request, build_id):
-    return tasks_common(request, build_id, 'buildtime')
+    return tasks_common(request, build_id, 'buildtime', '')
 
 def diskio(request, build_id):
-    return tasks_common(request, build_id, 'diskio')
+    return tasks_common(request, build_id, 'diskio', '')
 
 def cpuusage(request, build_id):
-    return tasks_common(request, build_id, 'cpuusage')
+    return tasks_common(request, build_id, 'cpuusage', '')
 
 
 def recipes(request, build_id):
-- 
1.9.1


