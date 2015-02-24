Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 4571773643
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:08 +0000 (UTC)
Received: by paceu11 with SMTP id eu11so37444709pac.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=SJWZCNuFmoZy1B6+5Y47tzr7aE/gFUPWVYjGiU+Y0LU=;
	b=MHiWEF/ZP8MysqDBE7ZDaxFt+Q1EzBtZpiPFi/ayohEQ5NoHIey+Xvadz1i+NeTcmC
	f08SFL0x9ObUE1pONNEo8/DAfXdng7xESZyXJ9nBGYaRJztgvoL1i60CbGjydXJYwYV8
	Jy3KgFJ482YoXXEoF6XOrChUmpTB1haMwnQ68DPR512YKljMNpoOzI1AYOjXcJ84Xo0u
	JOZJvCz/m42gZFaPenVD1TzHjfsV/u3JpXPB0iTJVtp+TLQ6IowuPQGRwQO3U3a0gZw4
	M1QI+lgSqdmLt1ba2HwZ1W6QrnMJEJd6BvpbDVRZIr0HiWuw7CVwKfDf36P3kNRGvlN0
	LCCA==
X-Gm-Message-State: ALoCoQka+m4ZtSxpfVio5kX0Of6tYl9SOvV2cWUChzau5M6+CwR64eUt1HAFa0id7z5DLVBS5vNK
X-Received: by 10.66.246.107 with SMTP id xv11mr3880693pac.79.1424798470392;
	Tue, 24 Feb 2015 09:21:10 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fy2sm38738173pbb.30.2015.02.24.09.21.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:09 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 9DC9F5615E3; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:58 +0000
Message-Id: <93c6031be4895fdbc532ff2c13e74926a6bc2dbf.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 10/12] toastergui: performance improvements in task details page
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:09 -0000

From: Alexandru Damian <alexandru.damian@intel.com>

This patch brings better forward and reverse dependency computing in
tasks page (offloading python code to the database), as well as
replacing the recursive depth-first covered-by tree search with
breadth-first search.
---
 lib/toaster/orm/models.py       |  2 ++
 lib/toaster/toastergui/views.py | 40 +++++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 9d4f4c9..15481e5 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -393,6 +393,8 @@ class Task(models.Model):
     outcome_text = property(get_outcome_text)
     sstate_text  = property(get_sstate_text)
 
+    def __unicode__(self):
+        return "%d %s:%s" % (self.id, self.recipe.name, self.task_name)
     class Meta:
         ordering = ('order', 'recipe' ,)
         unique_together = ('build', 'recipe', 'task_name', )
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4960ba0..aabc3d0 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -352,15 +352,17 @@ def builddashboard( request, build_id ):
     return render( request, template, context )
 
 
-def generateCoveredList( task ):
-    revList = _find_task_revdep( task );
-    list = { };
-    for t in revList:
-        if ( t.outcome == Task.OUTCOME_COVERED ):
-            list.update( generateCoveredList( t ));
-        else:
-            list[ t.task_name ] = t;
-    return( list );
+
+def generateCoveredList2( revlist = [] ):
+    covered_list =  [ x for x in revlist if x.outcome == Task.OUTCOME_COVERED ]
+    while len(covered_list):
+        revlist =  [ x for x in revlist if x.outcome != Task.OUTCOME_COVERED ]
+
+        newlist = _find_task_revdep_list(covered_list)
+
+        revlist = list(set(revlist + newlist))
+        covered_list =  [ x for x in revlist if x.outcome == Task.OUTCOME_COVERED ]
+    return revlist
 
 def task( request, build_id, task_id ):
     template = "task.html"
@@ -376,9 +378,10 @@ def task( request, build_id, task_id ):
         key=lambda t:'%s_%s %s'%( t.recipe.name, t.recipe.version, t.task_name ))
     coveredBy = '';
     if ( task.outcome == Task.OUTCOME_COVERED ):
-        dict = generateCoveredList( task )
+#        _list = generateCoveredList( task )
+        _list = generateCoveredList2( _find_task_revdep( task ) )
         coveredBy = [ ]
-        for name, t in dict.items( ):
+        for t in _list:
             coveredBy.append( t )
     log_head = ''
     log_body = ''
@@ -737,18 +740,17 @@ def dirinfo(request, build_id, target_id, file_path=None):
     return render(request, template, context)
 
 def _find_task_dep(task):
-    tp = []
-    for p in Task_Dependency.objects.filter(task=task):
-        if (p.depends_on.order > 0) and (p.depends_on.outcome != Task.OUTCOME_NA):
-            tp.append(p.depends_on);
-    return tp
+    return map(lambda x: x.depends_on, Task_Dependency.objects.filter(task=task).filter(depends_on__order__gt = 0).exclude(depends_on__outcome = Task.OUTCOME_NA).select_related("depends_on"))
 
 
 def _find_task_revdep(task):
     tp = []
-    for p in Task_Dependency.objects.filter(depends_on=task):
-        if (p.task.order > 0) and (p.task.outcome != Task.OUTCOME_NA):
-            tp.append(p.task);
+    tp = map(lambda t: t.task, Task_Dependency.objects.filter(depends_on=task).filter(task__order__gt=0).exclude(task__outcome = Task.OUTCOME_NA).select_related("task", "task__recipe", "task__build"))
+    return tp
+
+def _find_task_revdep_list(tasklist):
+    tp = []
+    tp = map(lambda t: t.task, Task_Dependency.objects.filter(depends_on__in=tasklist).filter(task__order__gt=0).exclude(task__outcome = Task.OUTCOME_NA).select_related("task", "task__recipe", "task__build"))
     return tp
 
 def _find_task_provider(task):
-- 
1.9.1


