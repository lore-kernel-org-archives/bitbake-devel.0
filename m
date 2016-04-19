Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 95E6060616
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:28:57 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id v188so169465072wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IVtIN8CT0isQuglDsLQPxD8PdoqZ28QDycZ96JaX3GA=;
	b=FZVGqAszORZfnMg55DQJ+EFqOAG/GvBGqs+EHk4tVgnIy1shrL2JtQh7Vxt/2tL8BK
	LnPups2xNuBLVgitUD/3GHOehU8zKjMmLHaytDdAA2kLqrstQ9jZbA/CuKqDy81g7gP1
	KSfui/eLxXAVXkmMBTitwoOcpLgTl7K0+Olvc5gNbjcKfwHGl4Fhtu9fFULL5NWQnPLj
	GAcv490MOV1D3b8x3N6OJlC3yGP77iTPyN3eZdd8poZiCUiYzwggnPxxk2NGVztq6wdW
	ewWFsOmuSNCJoFNyvKiHZHaLrhwDRfalpg4Ek7hOARFZejKoDC4v3s29jCvjpFBvBrQP
	3Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IVtIN8CT0isQuglDsLQPxD8PdoqZ28QDycZ96JaX3GA=;
	b=YLlnGzvjFjxYrHD4XteJluS5gSDeoViyTBacFD6nzPdtkK1ljVB46in/jaDtgTvJhf
	U4PCd01VlYdxlaRGBwbeqoT1xLB4VYZPtd0di+F+ctZ5kGFVI2pzoxP4SGTnYRVwe8MB
	ATPi76IN8NAxaYRdQrfaIFGUu+6w2DJLVh6G6uNs7S1jc6xDLzb063obERmtZA0TnddI
	2g4w1wxgPS4xTerPkppwgJEV5G8m1zlfIughIMiIYSvnrchoiJnPa2OeBxY71nRWgn92
	oPQriGbIt4XRIavQ0Va1LqI2sBrNWVE36c5QG0uI/ddGiW5N+2b/DUZctVf+aSId8yri
	J3VA==
X-Gm-Message-State: AOPr4FUGhg81LXLuLhAW17m6/2rb9t03A3qWf6dxlOKc63SSMciLbnRMpv7zG10D1JyR+1Ew
X-Received: by 10.194.62.145 with SMTP id y17mr4347395wjr.109.1461083337556;
	Tue, 19 Apr 2016 09:28:57 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.28.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:28:56 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:39 +0100
Message-Id: <1461083327-11668-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
References: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 02/10] toaster: fix sorting after hiding a column in build tables
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
X-List-Received-Date: Tue, 19 Apr 2016 16:28:58 -0000

From: Elliot Smith <elliot.smith@intel.com>

When hiding a column in the build tasks or build packages included
table, if the column is set as the current order by for the table, the
order by is not reset to the default. The result is that the table
stays sorted by the hidden column.

Set the default_orderby for these two tables correctly to ensure the
corresponding table is re-sorted when a column is hidden, if that column
was being used as the order by.

[YOCTO #9011]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/tasks.html |  2 +-
 lib/toaster/toastergui/views.py             | 50 ++++++++++++++---------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index 23eb957..84bc103 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -131,7 +131,7 @@
 <script type="text/javascript">
 
     $(document).ready(function() {
-        // enable blue hightlight animation for the order link
+        // highlight heading on the column for the field used for ordering
         if (location.href.search('#') > -1) {
             var task_order = location.href.split('#')[1];
             $("#" + task_order).addClass("highlight");
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 30295a7..a11c9da 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -663,7 +663,9 @@ def recipe_packages(request, build_id, recipe_id):
 
 def target_common( request, build_id, target_id, variant ):
     template = "target.html"
-    (pagesize, orderby) = _get_parameters_values(request, 25, 'name:+')
+    default_orderby = 'name:+'
+
+    (pagesize, orderby) = _get_parameters_values(request, 25, default_orderby)
     mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby': orderby }
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
@@ -683,8 +685,6 @@ def target_common( request, build_id, target_id, variant ):
     queryset = queryset.select_related("recipe", "recipe__layer_version", "recipe__layer_version__layer")
     packages = _build_page_range( Paginator(queryset, pagesize), request.GET.get( 'page', 1 ))
 
-
-
     build = Build.objects.get( pk = build_id )
 
     # bring in package dependencies
@@ -801,7 +801,7 @@ eans multiple licenses exist that cover different parts of the source',
         'objects'              : packages,
         'packages_sum'         : packages_sum[ 'installed_size__sum' ],
         'object_search_display': "packages included",
-        'default_orderby'      : orderby,
+        'default_orderby'      : default_orderby,
         'tablecols'            : [
                     tc_package,
                     tc_packageVersion,
@@ -996,29 +996,29 @@ def tasks_common(request, build_id, variant, task_anchor):
         anchor=task_anchor
 
     # default ordering depends on variant
-    if   'buildtime' == variant:
-        title_variant='Time'
-        object_search_display="time data"
-        filter_search_display="tasks"
-        (pagesize, orderby) = _get_parameters_values(request, 25, 'elapsed_time:-')
-    elif 'diskio'    == variant:
-        title_variant='Disk I/O'
-        object_search_display="disk I/O data"
-        filter_search_display="tasks"
-        (pagesize, orderby) = _get_parameters_values(request, 25, 'disk_io:-')
-    elif 'cputime'  == variant:
+    default_orderby = None
+    filter_search_display = 'tasks'
+
+    if 'buildtime' == variant:
+        default_orderby = 'elapsed_time:-'
+        title_variant = 'Time'
+        object_search_display = 'time data'
+    elif 'diskio' == variant:
+        default_orderby = 'disk_io:-'
+        title_variant = 'Disk I/O'
+        object_search_display = 'disk I/O data'
+    elif 'cputime' == variant:
+        default_orderby = 'cpu_time_system:-'
         title_variant='CPU time'
-        object_search_display="CPU time data"
-        filter_search_display="tasks"
-        (pagesize, orderby) = _get_parameters_values(request, 25, 'cpu_time_system:-')
-    else :
-        title_variant='Tasks'
-        object_search_display="tasks"
-        filter_search_display="tasks"
-        (pagesize, orderby) = _get_parameters_values(request, 25, 'order:+')
+        object_search_display = 'CPU time data'
+    else:
+        default_orderby = 'order:+'
+        title_variant = 'Tasks'
+        object_search_display = 'tasks'
 
+    (pagesize, orderby) = _get_parameters_values(request, 25, default_orderby)
 
-    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby': orderby }
+    mandatory_parameters = {'count': pagesize, 'page' : 1, 'orderby': orderby}
 
     template = 'tasks.html'
     retval = _verify_parameters( request.GET, mandatory_parameters )
@@ -1212,7 +1212,7 @@ def tasks_common(request, build_id, variant, task_anchor):
                 'mainheading': title_variant,
                 'build': build,
                 'objects': task_objects,
-                'default_orderby' : orderby,
+                'default_orderby' : default_orderby,
                 'search_term': search_term,
                 'total_count': queryset_with_search.count(),
                 'tablecols':[
-- 
2.5.0


