Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id 3EB3E7571E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:17:13 +0000 (UTC)
Received: by wicmx19 with SMTP id mx19so148343491wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=lDkJ5ub9d5FSLlmQkQ9LXKrkgFGgCAKTI13FKxAUt+U=;
	b=XZIaqRs+j6y6YQ8XXeCuYKpko1/7lxR1d2EkSSl3Inh1NA0FM9cmmV9H6JmUH9YhdE
	L7qWdAXdBgpdx394+Ess+E5cJjYDvDKxkMwd7r3fghSXgURG5jZGBJ4sF7CUl59Zmwgo
	ZRe7lxqJCEk6MUPXGfQ//ocil57rqD56/tqpn/RbngsgdO+GtWilYmA0hsj3o89XhRXe
	I8dgDH5eJt6HFLhwJOJaiHpUqWnnVqhhKGLDcEIuOXy/JpjlNVK7vgOMu+KhHwLKzsRt
	oQNi24Gin3mHodowi7E2SH5QeYNqHja5mKGL2Nn1tg+r6cW5nyldJLDfm/qX8KYiU2ip
	FbBA==
X-Gm-Message-State: ALoCoQnLMckcKkhTBp/sHIAmavlggO9oTJfBXnPrpvi5CBqx7VbC6Zd1RG3BJGFU/eu57cRH4DQP
X-Received: by 10.194.5.135 with SMTP id s7mr5794042wjs.115.1432822634343;
	Thu, 28 May 2015 07:17:14 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ch2sm4200240wib.18.2015.05.28.07.17.13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:17:13 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CF02956132A; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:08 +0100
Message-Id: <1f5217f387892135271c0514368ae0eb7c5b1082.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 14/22] toasterui: replace cookie-based preferences with session data
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
X-List-Received-Date: Thu, 28 May 2015 14:17:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We switch from storing the user preferences using cookies
to saving them in the server-side session.

Patch for "count/pagesize" and "orderby" fields in the table-based
pages.

This patch will solve two problems:
* the browser-side race between the GET header data and the cookie data
* page breakages when field names chances in orderby statements.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../toastergui/templates/basetable_bottom.html     |  4 ---
 .../toastergui/templates/basetable_top.html        |  9 +-----
 .../templates/detail_pagination_bottom.html        |  5 ---
 .../toastergui/templates/detail_sorted_header.html |  2 +-
 lib/toaster/toastergui/views.py                    | 37 +++++++++++-----------
 5 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basetable_bottom.html b/lib/toaster/toastergui/templates/basetable_bottom.html
index d48ad92..4c28cae 100644
--- a/lib/toaster/toastergui/templates/basetable_bottom.html
+++ b/lib/toaster/toastergui/templates/basetable_bottom.html
@@ -60,8 +60,6 @@
     // load cookie for number of entries to be displayed on page
     if ({{request.GET.count}} != "") {
       pagesize = {{request.GET.count}};
-    } else {
-      pagesize = $.cookie('_count');
     }
 
     $('.pagesize option').prop('selected', false)
@@ -84,8 +82,6 @@
     $('.progress, .lead span').tooltip({container:'table', placement:'top'});
 
     $(".pagesize").change(function () {
-        // save cookie with pagesize
-        $.cookie("_count", $(this).val(), { path : $(location).attr('pathname') });
         reload_params({"count":$(this).val()});
     });
 });
diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index 92a3b50..fcd2f03 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -156,13 +156,6 @@
         showhideImmediateTableAction( clname, sh, orderkey );
     }
 
-    //
-    // saves a cookie with selected order field
-    //
-    function saveOrderCookie( orderfield ) {
-        $.cookie("orderby", orderfield, { path: $(location).attr('pathname') });
-    }
-
     </script>
 
 <!-- control header -->
@@ -230,7 +223,7 @@
         <tr>
             {% for tc in tablecols %}<th class="{{tc.dclass}} {{tc.clclass}}">
                 {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
-                {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })" onclick="saveOrderCookie('{{tc.orderfield}}')">{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
+                {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })">{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
                 {%if tc.ordericon%} <i class="icon-caret-{{tc.ordericon}}"></i>{%endif%}
                 {%if tc.filter%}<div class="btn-group pull-right">
                     <a href="#filter_{{tc.filter.class}}" role="button" class="btn btn-mini {%if request.GET.filter%}{{tc.filter.options|filtered_icon:request.GET.filter}} {%endif%}" {%if request.GET.filter and tc.filter.options|filtered_tooltip:request.GET.filter %} title="<p>{{tc.filter.options|filtered_tooltip:request.GET.filter}}</p><p><a class='btn btn-small btn-primary' href=javascript:reload_params({'filter':''})>Show all {% if filter_search_display %}{{filter_search_display}}{% else %}{{objectname}}{% endif %}</a></p>" {%endif%} data-toggle="modal"> <i class="icon-filter filtered"></i> </a>
diff --git a/lib/toaster/toastergui/templates/detail_pagination_bottom.html b/lib/toaster/toastergui/templates/detail_pagination_bottom.html
index 355ae90..434facb 100644
--- a/lib/toaster/toastergui/templates/detail_pagination_bottom.html
+++ b/lib/toaster/toastergui/templates/detail_pagination_bottom.html
@@ -41,17 +41,12 @@
     // load cookie for number of entries to be displayed on page
     if ({{request.GET.count}} != "") {
       pagesize = {{request.GET.count}};
-    } else {
-      pagesize = $.cookie('_count');
     }
-
     $('.pagesize option').prop('selected', false)
                          .filter('[value="' + pagesize + '"]')
                          .attr('selected', true);
 
     $(".pagesize").change(function () {
-        // save cookie with pagesize
-        $.cookie("_count", $(this).val(), { path : $(location).attr('pathname') });
         reload_params({"count":$(this).val()});
     });
 });
diff --git a/lib/toaster/toastergui/templates/detail_sorted_header.html b/lib/toaster/toastergui/templates/detail_sorted_header.html
index a7917dc..5214444 100644
--- a/lib/toaster/toastergui/templates/detail_sorted_header.html
+++ b/lib/toaster/toastergui/templates/detail_sorted_header.html
@@ -11,7 +11,7 @@
         <tr>
             {% for tc in tablecols %}<th class="{{tc.dclass}} {{tc.clclass}}">
                 {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
-                {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })" onclick="saveOrderCookie('{{tc.orderfield}}')">{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
+                {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })">{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
                 {%if tc.ordericon%} <i class="icon-caret-{{tc.ordericon}}"></i>{%endif%}
                 {% if request.GET.search and forloop.first %}
                     <span class="badge badge-info">{{objects.paginator.count}}</span>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index f70cf20..0e248a7 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -20,7 +20,6 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import operator,re
-import HTMLParser
 
 from django.db.models import Q, Sum, Count, Max
 from django.db import IntegrityError
@@ -278,11 +277,11 @@ def _get_parameters_values(request, default_count, default_order):
 
 # set cookies for parameters. this is usefull in case parameters are set
 # manually from the GET values of the link
-def _save_parameters_cookies(response, pagesize, orderby, request):
-    html_parser = HTMLParser.HTMLParser()
-    response.set_cookie(key='count', value=pagesize, path=request.path)
-    response.set_cookie(key='orderby', value=html_parser.unescape(orderby), path=request.path)
-    return response
+def _set_parameters_values(pagesize, orderby, request):
+    from django.core.urlresolvers import resolve
+    current_url = resolve(request.path_info).url_name
+    request.session['%s_count' % current_url] = pagesize
+    request.session['%s_orderby' % current_url] =orderby
 
 # date range: normalize GUI's dd/mm/yyyy to date object
 def _normalize_input_date(date_str,default):
@@ -563,7 +562,7 @@ def recipe_packages(request, build_id, recipe_id):
            ]
        }
     response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
+    _set_parameters_values(pagesize, orderby, request)
     return response
 
 def target_common( request, build_id, target_id, variant ):
@@ -737,7 +736,7 @@ eans multiple licenses exist that cover different parts of the source',
         context['tablecols'].append(tc_layerDir)
 
     response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
+    _set_parameters_values(pagesize, orderby, request)
     return response
 
 def target( request, build_id, target_id ):
@@ -1129,7 +1128,7 @@ def tasks_common(request, build_id, variant, task_anchor):
         context['tablecols'].append(tc_log)
 
     response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
+    _set_parameters_values(pagesize, orderby, request)
     return response
 
 def tasks(request, build_id):
@@ -1265,7 +1264,7 @@ def recipes(request, build_id):
 
 
     response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
+    _set_parameters_values(pagesize, orderby, request)
     return response
 
 def configuration(request, build_id):
@@ -1378,7 +1377,7 @@ def configvars(request, build_id):
             }
 
     response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
+    _set_parameters_values(pagesize, orderby, request)
     return response
 
 def bpackage(request, build_id):
@@ -1479,7 +1478,7 @@ def bpackage(request, build_id):
         context['tablecols'].append(tc_layerDir)
 
     response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
+    _set_parameters_values(pagesize, orderby, request)
     return response
 
 def bfile(request, build_id, package_id):
@@ -1640,7 +1639,7 @@ def package_built_detail(request, build_id, package_id):
         context['disable_sort'] = True;
 
     response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
+    _set_parameters_values(pagesize, orderby, request)
     return response
 
 def package_built_dependencies(request, build_id, package_id):
@@ -1705,7 +1704,7 @@ def package_included_detail(request, build_id, target_id, package_id):
     if paths.all().count() < 2:
         context['disable_sort'] = True
     response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
+    _set_parameters_values(pagesize, orderby, request)
     return response
 
 def package_included_dependencies(request, build_id, target_id, package_id):
@@ -1780,7 +1779,7 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
     if objects.all().count() < 2:
         context['disable_sort'] = True
     response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
+    _set_parameters_values(pagesize, orderby, request)
     return response
 
 def image_information_dir(request, build_id, target_id, packagefile_id):
@@ -1842,7 +1841,7 @@ if toastermain.settings.MANAGED:
             return _redirect_parameters( builds, request.GET, e.response)
 
         response = render(request, template, context)
-        _save_parameters_cookies(response, pagesize, orderby, request)
+        _set_parameters_values(pagesize, orderby, request)
         return response
 
 
@@ -2748,7 +2747,7 @@ if toastermain.settings.MANAGED:
             return _redirect_parameters(projectbuilds, request.GET, e.response, pid = pid)
 
         response = render(request, template, context)
-        _save_parameters_cookies(response, pagesize, orderby, request)
+        _set_parameters_values(pagesize, orderby, request)
 
         return response
 
@@ -2967,7 +2966,7 @@ if toastermain.settings.MANAGED:
             }
 
         response = render(request, template, context)
-        _save_parameters_cookies(response, pagesize, orderby, request)
+        _set_parameters_values(pagesize, orderby, request)
         return response
 
     def buildrequestdetails(request, pid, brid):
@@ -3171,7 +3170,7 @@ else:
         context.update(context_date)
 
         response = render(request, template, context)
-        _save_parameters_cookies(response, pagesize, orderby, request)
+        _set_parameters_values(pagesize, orderby, request)
         return response
 
 
-- 
1.9.1


