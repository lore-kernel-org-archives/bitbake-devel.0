Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id AA46776E04
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 17:04:14 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so48155192pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xPbYgdOySafmHB4GTuBxNbbS4PHBwl3Y4vQAmPsx//Q=;
	b=u6rpoYZd/CqOsIVWDePZ8+yTsVT3d6hn0qTv4GMpE8jJhhCB+cAUFAfILZgzrV0Pfy
	2WQcCwQj02aLWNeTZXUg6m67wz8MRYuWqPTVD1zikml7j0UB4tFlqxDMXlmCUvMSTALr
	k6SU+plYDzWjjJbZqG6NijElfhJVmivVX8lS7bCtpXd/q2ec37lG1Nby5wbfbPfju8r/
	BiQZqv5I0I2n9c9FevUGfCnCYKUH6bjEM0aVO8a3Ozh9PF6jRO6T949+rcqT/WMa5zQI
	Vm18QVzkuRhmnGOnxa81NT05e1MD8nutB/765F1TeL/qsb4NIZ0tM777rSX5z0r6r1WX
	yNXg==
X-Received: by 10.68.248.102 with SMTP id yl6mr86524585pbc.66.1441904654752;
	Thu, 10 Sep 2015 10:04:14 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	by1sm13099494pab.6.2015.09.10.10.04.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 10 Sep 2015 10:04:14 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Sep 2015 10:05:15 -0700
Message-Id: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1441904599.git.avery.brian@gmail.com>
References: <cover.1441904599.git.avery.brian@gmail.com>
Subject: [PATCH 1/5] toaster: hide irrelevant builds in the project builds view
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
X-List-Received-Date: Thu, 10 Sep 2015 17:04:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the project builds view so it doesn't show
"in progress" builds or builds for other projects.

Note that this also modifies the "all builds" view to use
the same queryset filtering as the project builds. This is
to avoid excluding "in progress" builds more than once, which
is what was happening before.

The patch also has a minor change to ensure that when
displaying the project builds page, only builds for that
project are in the results.

The queryset filtering is now split over several lines so
you can see what's going on.

[YOCTO #8236]
[YOCTO #8187]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 54 ++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4e8f69e..c9831b1 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1896,7 +1896,7 @@ if True:
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
 
-        queryset = Build.objects.exclude(outcome = Build.IN_PROGRESS)
+        queryset = Build.objects.all()
 
         try:
             context, pagesize, orderby = _build_list_helper(request, queryset)
@@ -1913,7 +1913,6 @@ if True:
 
     # helper function, to be used on "all builds" and "project builds" pages
     def _build_list_helper(request, queryset_all):
-
         default_orderby = 'completed_on:-'
         (pagesize, orderby) = _get_parameters_values(request, 10, default_orderby)
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
@@ -1924,11 +1923,42 @@ if True:
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
+
         # post-process any date range filters
-        filter_string,daterange_selected = _modify_date_range_filter(filter_string)
-        queryset_all = queryset_all.select_related("project").annotate(errors_no = Count('logmessage', only=Q(logmessage__level=LogMessage.ERROR)|Q(logmessage__level=LogMessage.EXCEPTION))).annotate(warnings_no = Count('logmessage', only=Q(logmessage__level=LogMessage.WARNING))).extra(select={'timespent':'completed_on - started_on'})
-        queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string, '-completed_on')
-        queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
+        filter_string, daterange_selected = _modify_date_range_filter(filter_string)
+
+        # don't show "in progress" builds in "all builds" or "project builds"
+        queryset_all = queryset_all.exclude(outcome = Build.IN_PROGRESS)
+
+        # append project info
+        queryset_all = queryset_all.select_related("project")
+
+        # annotate with number of ERROR and EXCEPTION log messages
+        queryset_all = queryset_all.annotate(
+            errors_no = Count(
+                'logmessage',
+                only=Q(logmessage__level=LogMessage.ERROR) |
+                     Q(logmessage__level=LogMessage.EXCEPTION)
+            )
+        )
+
+        # annotate with number of warnings
+        q_warnings = Q(logmessage__level=LogMessage.WARNING)
+        queryset_all = queryset_all.annotate(
+            warnings_no = Count('logmessage', only=q_warnings)
+        )
+
+        # add timespent field
+        timespent = 'completed_on - started_on'
+        queryset_all = queryset_all.extra(select={'timespent': timespent})
+
+        queryset_with_search = _get_queryset(Build, queryset_all,
+                                             None, search_term,
+                                             ordering_string, '-completed_on')
+
+        queryset = _get_queryset(Build, queryset_all,
+                                 filter_string, search_term,
+                                 ordering_string, '-completed_on')
 
         # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
         build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
@@ -2651,7 +2681,7 @@ if True:
             if 'buildDelete' in request.POST:
                 for i in request.POST['buildDelete'].strip().split(" "):
                     try:
-                        br = BuildRequest.objects.select_for_update().get(project = prj, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
+                        BuildRequest.objects.select_for_update().get(project = prj, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
                     except BuildRequest.DoesNotExist:
                         pass
 
@@ -2664,12 +2694,12 @@ if True:
                     else:
                         target = t
                         task = ""
-                    ProjectTarget.objects.create(project = prj, target = target, task = task)
-
-                br = prj.schedule_build()
-
+                    ProjectTarget.objects.create(project = prj,
+                                                 target = target,
+                                                 task = task)
+                prj.schedule_build()
 
-        queryset = Build.objects.filter(outcome__lte = Build.IN_PROGRESS)
+        queryset = Build.objects.filter(project_id = pid)
 
         try:
             context, pagesize, orderby = _build_list_helper(request, queryset)
-- 
1.9.1


