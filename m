Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 1CAFE6F934
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:20 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id hm4so3681479wib.8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=kMf4E3jKZsJlbcvq+v4zYriEoGFrHh/Oh/6A6tODFSw=;
	b=cAWrMpWZbEtFhmFj0/1eL4bm+E4e3RDnPLUqPh4Tl9NPJiY5m5Kj4n8cPgq5BoMT4U
	Dyj/fpGPmr525c2X/8hCWCZz8jXMQmDvEhhPxce8vKsRmH5yk2aB3VjBAV5S2bkDu8T5
	XZqlN8MYleNb2XqCi4dLMty8ZflNVQfuI02HOAt8jqSovp+zsiGEQBL6cLEYqB+zwsnS
	DVRrQq8/OSpZXbPtNDi0LPozelATptp17VdbrLPx+PIKhFkcB937HCpyCvntHmQgZFT7
	0H10L7c9xkHXp7ycxf2f1Cgnux3Di5iJ1WrJADxAou4x2nriODP5uSAWPAKfLsgD+HKh
	JCqQ==
X-Gm-Message-State: ALoCoQlDzWYwltY1DVRkn10tt6BKRAo++Mk2qCd4qOOuC9cjeXBcaqiS2y2qUtaD2GkAtfgxz25M
X-Received: by 10.180.87.9 with SMTP id t9mr13436029wiz.36.1396284441396;
	Mon, 31 Mar 2014 09:47:21 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fo6sm27684786wib.7.2014.03.31.09.47.16
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:19 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 2030E560426; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:14 +0100
Message-Id: <a4585f92298665da4b74d3c2fde70c858a511222.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 14/14] toaster: secondary sort key as table's default order
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:21 -0000

From: David Reyna <David.Reyna@windriver.com>

Provide for a secondary sort key based on the table's default
ordering when doing sort on alternate columns.

[YOCTO #5920]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/views.py | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6028d4d..05e24ea 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -175,7 +175,7 @@ def _search_tuple(request, model):
 
 
 # returns a lazy-evaluated queryset for a filter/search/order combination
-def _get_queryset(model, queryset, filter_string, search_term, ordering_string):
+def _get_queryset(model, queryset, filter_string, search_term, ordering_string, ordering_secondary=''):
     if filter_string:
         filter_query = _get_filtering_query(filter_string)
         queryset = queryset.filter(filter_query)
@@ -187,14 +187,19 @@ def _get_queryset(model, queryset, filter_string, search_term, ordering_string):
 
     if ordering_string and queryset:
         column, order = ordering_string.split(':')
+        if column == re.sub('-','',ordering_secondary):
+            ordering_secondary=''
         if order.lower() == DESCENDING:
-            queryset = queryset.order_by('-' + column)
+            column = '-' + column
+        if ordering_secondary:
+            queryset = queryset.order_by(column, ordering_secondary)
         else:
             queryset = queryset.order_by(column)
 
     # insure only distinct records (e.g. from multiple search hits) are returned 
     return queryset.distinct()
 
+
 # shows the "all builds" page
 def builds(request):
     template = 'build.html'
@@ -210,8 +215,8 @@ def builds(request):
     # for that object type. copypasta for all needed table searches
     (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
     queryset_all = Build.objects.exclude(outcome = Build.IN_PROGRESS)
-    queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string)
-    queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string)
+    queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string, '-completed_on')
+    queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
 
     # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
     build_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
@@ -489,7 +494,7 @@ def target(request, build_id, target_id):
     # FUTURE:  get rid of nested sub-queries replacing with ManyToMany field
     queryset = Package.objects.filter(size__gte=0, id__in=Target_Installed_Package.objects.filter(target_id=target_id).values('package_id'))
     packages_sum =  queryset.aggregate(Sum('installed_size'))
-    queryset = _get_queryset(Package, queryset, filter_string, search_term, ordering_string)
+    queryset = _get_queryset(Package, queryset, filter_string, search_term, ordering_string, 'name')
     packages = _build_page_range(Paginator(queryset, request.GET.get('count', 25)),request.GET.get('page', 1))
 
     # bring in package dependencies
@@ -789,8 +794,8 @@ def tasks_common(request, build_id, variant):
         return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Task)
     queryset_all = Task.objects.filter(build=build_id, order__gt=0)
-    queryset_with_search = _get_queryset(Task, queryset_all, None , search_term, ordering_string)
-    queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string)
+    queryset_with_search = _get_queryset(Task, queryset_all, None , search_term, ordering_string, 'order')
+    queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string, 'order')
 
     tasks = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
 
@@ -952,7 +957,7 @@ def recipes(request, build_id):
         return _redirect_parameters( 'recipes', request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Recipe)
     queryset = Recipe.objects.filter(layer_version__id__in=Layer_Version.objects.filter(build=build_id))
-    queryset = _get_queryset(Recipe, queryset, filter_string, search_term, ordering_string)
+    queryset = _get_queryset(Recipe, queryset, filter_string, search_term, ordering_string, 'name')
 
     recipes = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
 
@@ -1081,8 +1086,8 @@ def configvars(request, build_id):
         return _redirect_parameters( 'configvars', request.GET, mandatory_parameters, build_id = build_id)
 
     queryset = Variable.objects.filter(build=build_id).exclude(variable_name__istartswith='B_').exclude(variable_name__istartswith='do_')
-    queryset_with_search =  _get_queryset(Variable, queryset, None, search_term, ordering_string).exclude(variable_value='',vhistory__file_name__isnull=True)
-    queryset = _get_queryset(Variable, queryset, filter_string, search_term, ordering_string)
+    queryset_with_search =  _get_queryset(Variable, queryset, None, search_term, ordering_string, 'variable_name').exclude(variable_value='',vhistory__file_name__isnull=True)
+    queryset = _get_queryset(Variable, queryset, filter_string, search_term, ordering_string, 'variable_name')
     # remove records where the value is empty AND there are no history files
     queryset = queryset.exclude(variable_value='',vhistory__file_name__isnull=True)
 
@@ -1163,7 +1168,7 @@ def bpackage(request, build_id):
         return _redirect_parameters( 'packages', request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Package)
     queryset = Package.objects.filter(build = build_id).filter(size__gte=0)
-    queryset = _get_queryset(Package, queryset, filter_string, search_term, ordering_string)
+    queryset = _get_queryset(Package, queryset, filter_string, search_term, ordering_string, 'name')
 
     packages = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
 
-- 
1.9.1


