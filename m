Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by mail.openembedded.org (Postfix) with ESMTP id D7A3A7149B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Sep 2014 16:45:20 +0000 (UTC)
Received: by mail-we0-f179.google.com with SMTP id t60so10431290wes.38
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Sep 2014 09:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=oJzDEx8Nb2foYm8Tccrj5Llpm5HD9VXY/x/mOT3GbZo=;
	b=FGSvUS1/Q7kXld8bSAeuZCG3fGBNUa7V3KSfgGTDVA1QiVa+EsvVptAnr87KHlfSPZ
	dNFKGNIa9YQnz74p7fJm4PNUesEmB8eKbKnJ/lx7c1G1QepydqwJI/S0gYZZjE75+xxJ
	vhBtxsoGEgS32q/heuCc3yjLeIr5KyiDyQ4xTH1zboEnJLUSS+3dlh8aAoXt7WwPy4n9
	8TQqy2Ua78zpNASY+VQCxeUcXpTLJCdfyXUpMLxa9yv+qq3uV8NKEKUNuoY9Vo+TV04a
	NTKjBYa0eFmym32lTb331HQyLIBw/SzUdkXKxDG/ywPfjCH9hxYg7tWNi0aAPphc+dTX
	RKpA==
X-Gm-Message-State: ALoCoQkQJBu/dyBtWdF7Lws1JJgBdYIJWbNti92okRTb7xSKZs6ZaUNzwdrtHLMouo6hfjsL7QXN
X-Received: by 10.194.78.170 with SMTP id c10mr7746516wjx.22.1409849121331;
	Thu, 04 Sep 2014 09:45:21 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h3sm19977904wjz.24.2014.09.04.09.45.18
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Sep 2014 09:45:19 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 733005626B1; Thu,  4 Sep 2014 17:45:19 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  4 Sep 2014 17:45:16 +0100
Message-Id: <880b58c845e3a501fa90d24e1bd89c87ca84b709.1409848901.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
References: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409848901.git.alexandru.damian@intel.com>
References: <cover.1409848901.git.alexandru.damian@intel.com>
Subject: [PATCH 5/6] toaster: use cookies for count and sorting in templates tables
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
X-List-Received-Date: Thu, 04 Sep 2014 16:45:21 -0000

From: Marius Avram <marius.avram@intel.com>

Until now cookies were used to save which columns were shown and which
were hidden in toaster tables. The tables from the templates also have
functionalities like sorting the entries on a certain column and
limiting the number of entries displayed on a page. The later however
were not saved using cookies. This patch brings this new feature.

The cookies are not saved only in the front-end. They are saved both
in the frontend in case the user uses the inputs/buttons to change
a parameter and also in the backend in case the user specifies manually
using GET variables the value of the parameters.

When no GET parameters are given the views will redirect the url to one
containg the parameters saved as cookies. When no cookies exist, default
values will be used.

[YOCTO #6126]

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 .../toastergui/templates/basetable_bottom.html     |  15 ++-
 .../toastergui/templates/basetable_top.html        |  11 +-
 lib/toaster/toastergui/views.py                    | 122 ++++++++++++++-------
 3 files changed, 102 insertions(+), 46 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basetable_bottom.html b/lib/toaster/toastergui/templates/basetable_bottom.html
index ac14363..cbdc164 100644
--- a/lib/toaster/toastergui/templates/basetable_bottom.html
+++ b/lib/toaster/toastergui/templates/basetable_bottom.html
@@ -26,7 +26,7 @@
                             <span class="help-inline" style="padding-top:5px;">Show rows:</span>
                             <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
   {% with "2 5 10 25 50 100" as list%}
-    {% for i in list.split %}<option{%if i == request.GET.count %} selected{%endif%}>{{i}}</option>
+    {% for i in list.split %}<option value="{{i}}">{{i}}</option>
     {% endfor %}
   {% endwith %}
                             </select>
@@ -56,6 +56,14 @@
     }
     }
 
+    // load cookie for number of entries to be displayed on page
+    pagesize = $.cookie('count');
+    if (!pagesize)
+        pagesize = 10;
+    $('.pagesize option').prop('selected', false)
+                         .filter('[value="' + pagesize + '"]')
+                         .attr('selected', true);
+
     $('.chbxtoggle').each(function () {
         showhideTableColumn($(this).attr('id'), $(this).is(':checked'))
     });
@@ -72,8 +80,9 @@
     $('.progress, .lead span').tooltip({container:'table', placement:'top'});
 
     $(".pagesize").change(function () {
-        console.log("page size change");
-        reload_params({"count":$(this).val()}); ;
+        reload_params({"count":$(this).val()});
+        // save cookie with pagesize
+        $.cookie("count", $(this).val(), { path : $(location).attr('pathname') });
     });
 });
 </script>
diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 1231e1f..037554b 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -156,6 +156,13 @@
         showhideImmediateTableAction( clname, sh, orderkey );
     }
 
+    //
+    // saves a cookie with selected order field
+    //
+    function saveOrderCookie( orderfield ) {
+        $.cookie("orderby", orderfield, { path: $(location).attr('pathname') });
+    }
+
     </script>
 
 <!-- control header -->
@@ -205,7 +212,7 @@
                 <span class="help-inline" style="padding-top:5px;">Show rows:</span>
                 <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
   {% with "2 5 10 25 50 100" as list%}
-{% for i in list.split %}                    <option{%if i == request.GET.count %} selected{%endif%}>{{i}}</option>
+{% for i in list.split %}                    <option value="{{i}}">{{i}}</option>
     {% endfor %}
   {% endwith %}
                 </select>
@@ -221,7 +228,7 @@
         <tr>
             {% for tc in tablecols %}<th class="{{tc.dclass}} {{tc.clclass}}">
                 {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
-                {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })" >{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
+                {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })" onclick="saveOrderCookie('{{tc.orderfield}}')">{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
                 {%if tc.ordericon%} <i class="icon-caret-{{tc.ordericon}}"></i>{%endif%}
                 {%if tc.filter%}<div class="btn-group pull-right">
                     <a href="#filter_{{tc.filter.class}}" role="button" class="btn btn-mini {%if request.GET.filter%}{{tc.filter.options|filtered_icon:request.GET.filter}} {%endif%}" {%if request.GET.filter and tc.filter.options|filtered_tooltip:request.GET.filter %} title="<p>{{tc.filter.options|filtered_tooltip:request.GET.filter}}</p><p><a class='btn btn-small btn-primary' href=javascript:reload_params({'filter':''})>Show all {% if filter_search_display %}{{filter_search_display}}{% else %}{{objectname}}{% endif %}</a></p>" {%endif%} data-toggle="modal"> <i class="icon-filter filtered"></i> </a>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 22b26d0..defbbbf 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -20,6 +20,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import operator,re
+import HTMLParser
 
 from django.db.models import Q, Sum
 from django.db import IntegrityError
@@ -32,6 +33,7 @@ from django.core.urlresolvers import reverse
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseBadRequest, HttpResponseNotFound
 from django.utils import timezone
+from django.utils.html import escape
 from datetime import timedelta
 from django.utils import formats
 import json
@@ -200,6 +202,22 @@ def _get_queryset(model, queryset, filter_string, search_term, ordering_string,
     # insure only distinct records (e.g. from multiple search hits) are returned
     return queryset.distinct()
 
+# returns the value of entries per page and the name of the applied sorting field.
+# if the value is given explicitly as a GET parameter it will be the first selected,
+# otherwise the cookie value will be used.
+def _get_parameters_values(request, default_count, default_order):
+    pagesize = request.GET.get('count', request.COOKIES.get('count', default_count))
+    orderby = request.GET.get('orderby', request.COOKIES.get('orderby', default_order))
+    return (pagesize, orderby)
+
+
+# set cookies for parameters. this is usefull in case parameters are set
+# manually from the GET values of the link
+def _save_parameters_cookies(response, pagesize, orderby, request):
+    html_parser = HTMLParser.HTMLParser()
+    response.set_cookie(key='count', value=pagesize, path=request.path)
+    response.set_cookie(key='orderby', value=html_parser.unescape(orderby), path=request.path)
+    return response
 
 # shows the "all builds" page
 def builds(request):
@@ -207,7 +225,8 @@ def builds(request):
     # define here what parameters the view needs in the GET portion in order to
     # be able to display something.  'count' and 'page' are mandatory for all views
     # that use paginators.
-    mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'completed_on:-' };
+    (pagesize, orderby) = _get_parameters_values(request, 10, 'completed_on:-')
+    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
         return _redirect_parameters( 'all-builds', request.GET, mandatory_parameters)
@@ -220,7 +239,7 @@ def builds(request):
     queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
 
     # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
-    build_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
+    build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
 
     # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
     build_mru = Build.objects.filter(completed_on__gte=(timezone.now()-timedelta(hours=24))).order_by("-started_on")[:3]
@@ -368,7 +387,9 @@ def builds(request):
                 ]
             }
 
-    return render(request, template, context)
+    response = render(request, template, context)
+    _save_parameters_cookies(response, pagesize, orderby, request)
+    return response
 
 
 ##
@@ -537,8 +558,8 @@ def recipe(request, build_id, recipe_id):
 
 def target_common( request, build_id, target_id, variant ):
     template = "target.html"
-    default_orderby = 'name:+';
-    mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'name:+'};
+    (pagesize, orderby) = _get_parameters_values(request, 25, 'name:+')
+    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby': orderby }
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
         return _redirect_parameters(
@@ -554,8 +575,7 @@ def target_common( request, build_id, target_id, variant ):
     packages_sum =  queryset.aggregate( Sum( 'installed_size' ))
     queryset = _get_queryset(
             Package, queryset, filter_string, search_term, ordering_string, 'name' )
-    packages = _build_page_range( Paginator(
-            queryset, request.GET.get( 'count', 25 )),request.GET.get( 'page', 1 ))
+    packages = _build_page_range( Paginator(queryset, pagesize), request.GET.get( 'page', 1 ))
 
     # bring in package dependencies
     for p in packages.object_list:
@@ -679,7 +699,7 @@ his package',
         'objects'              : packages,
         'packages_sum'         : packages_sum[ 'installed_size__sum' ],
         'object_search_display': "packages included",
-        'default_orderby'      : default_orderby,
+        'default_orderby'      : orderby,
         'tablecols'            : [
                     tc_package,
                     tc_packageVersion,
@@ -696,7 +716,10 @@ his package',
                     tc_layerDir,
                 ]
         }
-    return( render( request, template, context ))
+
+    response = render(request, template, context)
+    _save_parameters_cookies(response, pagesize, orderby, request)
+    return response
 
 def target( request, build_id, target_id ):
     return( target_common( request, build_id, target_id, "target" ))
@@ -878,26 +901,25 @@ def tasks_common(request, build_id, variant, task_anchor):
         title_variant='Time'
         object_search_display="time data"
         filter_search_display="tasks"
-        mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'elapsed_time:-'};
-        default_orderby = 'elapsed_time:-';
+        (pagesize, orderby) = _get_parameters_values(request, 25, 'elapsed_time:-')
     elif 'diskio'    == variant:
         title_variant='Disk I/O'
         object_search_display="disk I/O data"
         filter_search_display="tasks"
-        mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'disk_io:-'};
-        default_orderby = 'disk_io:-';
+        (pagesize, orderby) = _get_parameters_values(request, 25, 'disk_io:-')
     elif 'cpuusage'  == variant:
         title_variant='CPU usage'
         object_search_display="CPU usage data"
         filter_search_display="tasks"
-        mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'cpu_usage:-'};
-        default_orderby = 'cpu_usage:-';
+        (pagesize, orderby) = _get_parameters_values(request, 25, 'cpu_usage:-')
     else :
         title_variant='Tasks'
         object_search_display="tasks"
         filter_search_display="tasks"
-        mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'order:+'};
-        default_orderby = 'order:+';
+        (pagesize, orderby) = _get_parameters_values(request, 25, 'order:+')
+
+
+    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby': orderby }
 
     template = 'tasks.html'
     retval = _verify_parameters( request.GET, mandatory_parameters )
@@ -923,7 +945,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         del request.GET['anchor']
         i=0
         a=int(anchor)
-        count_per_page=int(request.GET.get('count', 100))
+        count_per_page=int(pagesize)
         for task in queryset.iterator():
             if a == task.order:
                 new_page= (i / count_per_page ) + 1
@@ -932,7 +954,7 @@ def tasks_common(request, build_id, variant, task_anchor):
                 return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
             i += 1
 
-    tasks = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
+    tasks = _build_page_range(Paginator(queryset, pagesize),request.GET.get('page', 1))
 
     # define (and modify by variants) the 'tablecols' members
     tc_order={
@@ -1063,7 +1085,7 @@ def tasks_common(request, build_id, variant, task_anchor):
                 'title': title_variant,
                 'build': Build.objects.filter(pk=build_id)[0],
                 'objects': tasks,
-                'default_orderby' : default_orderby,
+                'default_orderby' : orderby,
                 'search_term': search_term,
                 'total_count': queryset_with_search.count(),
                 'tablecols':[
@@ -1080,7 +1102,9 @@ def tasks_common(request, build_id, variant, task_anchor):
                     tc_log,
                 ]}
 
-    return render(request, template, context)
+    response = render(request, template, context)
+    _save_parameters_cookies(response, pagesize, orderby, request)
+    return response
 
 def tasks(request, build_id):
     return tasks_common(request, build_id, 'tasks', '')
@@ -1100,7 +1124,8 @@ def cpuusage(request, build_id):
 
 def recipes(request, build_id):
     template = 'recipes.html'
-    mandatory_parameters = { 'count': 100,  'page' : 1, 'orderby':'name:+'};
+    (pagesize, orderby) = _get_parameters_values(request, 100, 'name:+')
+    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
         return _redirect_parameters( 'recipes', request.GET, mandatory_parameters, build_id = build_id)
@@ -1108,7 +1133,7 @@ def recipes(request, build_id):
     queryset = Recipe.objects.filter(layer_version__id__in=Layer_Version.objects.filter(build=build_id))
     queryset = _get_queryset(Recipe, queryset, filter_string, search_term, ordering_string, 'name')
 
-    recipes = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
+    recipes = _build_page_range(Paginator(queryset, pagesize),request.GET.get('page', 1))
 
     # prefetch the forward and reverse recipe dependencies
     deps = { }; revs = { }
@@ -1207,8 +1232,9 @@ def recipes(request, build_id):
             ]
         }
 
-    return render(request, template, context)
-
+    response = render(request, template, context)
+    _save_parameters_cookies(response, pagesize, orderby, request)
+    return response
 
 def configuration(request, build_id):
     template = 'configuration.html'
@@ -1247,7 +1273,8 @@ def configuration(request, build_id):
 
 def configvars(request, build_id):
     template = 'configvars.html'
-    mandatory_parameters = { 'count': 100,  'page' : 1, 'orderby':'variable_name:+', 'filter':'description__regex:.+'};
+    (pagesize, orderby) = _get_parameters_values(request, 100, 'variable_name:+')
+    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby, 'filter' : 'description__regex:.+' }
     retval = _verify_parameters( request.GET, mandatory_parameters )
     (filter_string, search_term, ordering_string) = _search_tuple(request, Variable)
     if retval:
@@ -1262,7 +1289,7 @@ def configvars(request, build_id):
     # remove records where the value is empty AND there are no history files
     queryset = queryset.exclude(variable_value='',vhistory__file_name__isnull=True)
 
-    variables = _build_page_range(Paginator(queryset, request.GET.get('count', 50)), request.GET.get('page', 1))
+    variables = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
 
     # show all matching files (not just the last one)
     file_filter= search_term + ":"
@@ -1328,12 +1355,14 @@ def configvars(request, build_id):
                 ],
             }
 
-    return render(request, template, context)
-
+    response = render(request, template, context)
+    _save_parameters_cookies(response, pagesize, orderby, request)
+    return response
 
 def bpackage(request, build_id):
     template = 'bpackage.html'
-    mandatory_parameters = { 'count': 100,  'page' : 1, 'orderby':'name:+'};
+    (pagesize, orderby) = _get_parameters_values(request, 100, 'name:+')
+    mandatory_parameters = { 'count' : pagesize,  'page' : 1, 'orderby' : orderby }
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
         return _redirect_parameters( 'packages', request.GET, mandatory_parameters, build_id = build_id)
@@ -1341,7 +1370,7 @@ def bpackage(request, build_id):
     queryset = Package.objects.filter(build = build_id).filter(size__gte=0)
     queryset = _get_queryset(Package, queryset, filter_string, search_term, ordering_string, 'name')
 
-    packages = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
+    packages = _build_page_range(Paginator(queryset, pagesize),request.GET.get('page', 1))
 
     context = {
         'objectname': 'packages built',
@@ -1421,7 +1450,9 @@ def bpackage(request, build_id):
             ]
         }
 
-    return render(request, template, context)
+    response = render(request, template, context)
+    _save_parameters_cookies(response, pagesize, orderby, request)
+    return response
 
 def bfile(request, build_id, package_id):
     template = 'bfile.html'
@@ -1576,7 +1607,8 @@ def package_built_detail(request, build_id, package_id):
 
     # follow convention for pagination w/ search although not used for this view
     queryset = Package_File.objects.filter(package_id__exact=package_id)
-    mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'path:+'};
+    (pagesize, orderby) = _get_parameters_values(request, 25, 'path:+')
+    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
         return _redirect_parameters( 'package_built_detail', request.GET, mandatory_parameters, build_id = build_id, package_id = package_id)
@@ -1607,7 +1639,10 @@ def package_built_detail(request, build_id, package_id):
     }
     if paths.all().count() < 2:
         context['disable_sort'] = True;
-    return render(request, template, context)
+
+    response = render(request, template, context)
+    _save_parameters_cookies(response, pagesize, orderby, request)
+    return response
 
 def package_built_dependencies(request, build_id, package_id):
     template = "package_built_dependencies.html"
@@ -1632,9 +1667,9 @@ def package_included_detail(request, build_id, target_id, package_id):
     if Build.objects.filter(pk=build_id).count() == 0 :
         return redirect(builds)
 
-
     # follow convention for pagination w/ search although not used for this view
-    mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'path:+'};
+    (pagesize, orderby) = _get_parameters_values(request, 25, 'path:+')
+    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
         return _redirect_parameters( 'package_included_detail', request.GET, mandatory_parameters, build_id = build_id, target_id = target_id, package_id = package_id)
@@ -1669,8 +1704,10 @@ def package_included_detail(request, build_id, target_id, package_id):
             ]
     }
     if paths.all().count() < 2:
-        context['disable_sort'] = True;
-    return render(request, template, context)
+        context['disable_sort'] = True
+    response = render(request, template, context)
+    _save_parameters_cookies(response, pagesize, orderby, request)
+    return response
 
 def package_included_dependencies(request, build_id, target_id, package_id):
     template = "package_included_dependencies.html"
@@ -1699,7 +1736,8 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
     if Build.objects.filter(pk=build_id).count() == 0 :
         return redirect(builds)
 
-    mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'package__name:+'};
+    (pagesize, orderby) = _get_parameters_values(request, 25, 'package__name:+')
+    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby': orderby }
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
         return _redirect_parameters( 'package_included_reverse_dependencies', request.GET, mandatory_parameters, build_id = build_id, target_id = target_id, package_id = package_id)
@@ -1741,8 +1779,10 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
             ]
     }
     if objects.all().count() < 2:
-        context['disable_sort'] = True;
-    return render(request, template, context)
+        context['disable_sort'] = True
+    response = render(request, template, context)
+    _save_parameters_cookies(response, pagesize, orderby, request)
+    return response
 
 def image_information_dir(request, build_id, target_id, packagefile_id):
     # stubbed for now
-- 
1.9.1


