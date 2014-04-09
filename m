Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
	[74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id 2836065E14
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Apr 2014 13:17:47 +0000 (UTC)
Received: by mail-we0-f169.google.com with SMTP id w62so2464823wes.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Apr 2014 06:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=S9A0ITppVwYNePURZQQO0Ugw6+baafrtfldrPOIA5yc=;
	b=bPjuIvjmW7c5TW1SemtlXaorl/7Dg/jBV1cwxfvSRe2GW6CKuf8Qnz6nhebTRtMuoy
	0hqo37Bc/PEytV7gJpiUxxX4mv9cGnZvzwKAGq29TuOboy5bUW7LuK5QWC9Sl0WO8wQt
	w7mfGzTuxgpdudLna9BlpQ04+AdakynlvsUl7ytbWZDczEydRWBfSQfsS4FHrhyGW7Fe
	5m6JhjcrWqrrQdNH6CzpZAwKe0zdrLDPC+tCVoY7sE+xNhln7zjx99ZrWCjQTtn5nNjN
	NegJOXcVLsRvpNjk21uCz246MGoW3wFcByPM2CRp5fZAeWSKAIWjH9pFiwTq+7Smg6lV
	i1+w==
X-Gm-Message-State: ALoCoQka4gYJMtgXdp/ZDOO2XcU+5Nn+HLX1yL0YHxe34PqcxTkGv0gil2ZOWqYjc6AJaH1kdv2y
X-Received: by 10.180.92.196 with SMTP id co4mr10036773wib.50.1397049467277;
	Wed, 09 Apr 2014 06:17:47 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id n5sm4371520wiz.1.2014.04.09.06.17.44
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Apr 2014 06:17:45 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 7E5C956035A; Wed,  9 Apr 2014 14:17:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Apr 2014 14:17:39 +0100
Message-Id: <af62b7c1209db669870c42d64f3ab2a193f1af49.1397049329.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
References: <c93e5ca809d9c335b0cf35dcad4705487414c71b.1397049329.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1397049329.git.alexandru.damian@intel.com>
References: <cover.1397049329.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 8/9] toaster: sort on size in detail pages
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
X-List-Received-Date: Wed, 09 Apr 2014 13:17:48 -0000

From: Dave Lerner <dave.lerner@windriver.com>

[YOCTO 5778]

Implements the features described in the attachment to bugzilla 5778
   - new global changes to the format of size data, and
   - adding sorts by selected columns to specific detail pages.

Although new pagination and row search capabilities are shown on the
screen shots for the 5778 attachment, those features are specified in
a different bugzilla entry 5777 and are not implemented in this commit.

Also, the 5778 spec includes table sorting for the recipe package
detail page, but sorting for that page was not implemented in this
commit due to complications with sorting then returning to a page that
is only one URL fragment in a template.

The scope of file changes are described below.
Changes to support new 'size' field column formats...
    default.css - added sizecol class style (right justified)
    projecttags.py - changed filtered_filesizeformat to allow
        ".0" suffixes

Changes that add class 'sizecol, span2(as spec'd) ' to <th> and/or
<td> size columns were made to...
    dirinfo.py,
    package_built_dependencies.html,
    package_included_dependencies.html,
    recipe.html,
    bpackage.html, and
    target.html

More significant changes to support detail page table sorting
are:
    - tablesort.html: New created to implement the sort icons,
        directions, and table headings, and
        suppress sort handling if 'disable_sort' in context,
        without search or pagination elements ingrained
        in basetable_top. Confining the changes to this small file
        reduces the impact (testing and risk) on the larger set of
        files that arleady include basetable_top/bottom files.
    - view.py: Modified the following view functions with
        - trivial changes for size formatting to the views: target,
        - changes to package_built_detail, package_included_detail,
            package_included_reverse_dependencies to handle the sorting
            implementation as well as moving headings and size
            formatting for size columns from templates to the views.
    - Implementation of the detail sorting using above in:
            package_built_detail.html,
            package_included_detail.html, and
            package_included_reverse_dependencies.html
        to include the tablesort heading setup, format the size column,
        and iterate over the new sorted objects, suppressing sorts if
        table row count less than 2.

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
---
 lib/toaster/toastergui/static/css/default.css      |   4 +-
 lib/toaster/toastergui/templates/bpackage.html     |   2 +-
 lib/toaster/toastergui/templates/dirinfo.html      |   2 +-
 .../templates/package_built_dependencies.html      |   8 +-
 .../toastergui/templates/package_built_detail.html |  14 +--
 .../templates/package_included_dependencies.html   |   8 +-
 .../templates/package_included_detail.html         |  14 +--
 .../package_included_reverse_dependencies.html     |  19 ++--
 lib/toaster/toastergui/templates/recipe.html       |   4 +-
 lib/toaster/toastergui/templates/tablesort.html    |  38 +++++++
 lib/toaster/toastergui/templates/target.html       |   4 +-
 lib/toaster/toastergui/templatetags/projecttags.py |   2 +-
 lib/toaster/toastergui/views.py                    | 115 ++++++++++++++++-----
 13 files changed, 161 insertions(+), 73 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/tablesort.html

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index e33f177..2c283fe 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -62,6 +62,9 @@ td a:hover { color: #000000; text-decoration: underline; }
 .table tbody tr.error > td { background-color: #FFFFFF; } /* override default Bootstrap behaviour */
 .table-hover tbody tr.error:hover > td { background-color: #F5F5F5;} /* override default Bootstrap behaviour */
 
+/* Right justify Bootstrap table columns for size fields */
+.table .sizecol { text-align: right; }
+
 /* Set error, warning, success and muted styles */
 .error, .red, td.error a, tr.error a { color: #b94a48; }
 a.error:hover, a.error:focus, tr.error a:hover { color: #943A38; text-decoration: underline; }
@@ -127,4 +130,3 @@ select { width: auto; }
 
 
 
-
diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index c6ec634..2d4948b 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -64,7 +64,7 @@
         <!-- Package Version -->
         <td>{%if package.version%}<a href="{% url "package_built_detail" build.pk package.pk %}">{{package.version}}-{{package.revision}}</a>{%endif%}</td>
         <!-- Package Size -->
-        <td class="size">{{package.size|filtered_filesizeformat}}</td>
+        <td class="size sizecol">{{package.size|filtered_filesizeformat}}</td>
         <!-- License -->
         <td class="license">{{package.license}}</td>
 
diff --git a/lib/toaster/toastergui/templates/dirinfo.html b/lib/toaster/toastergui/templates/dirinfo.html
index 9b76a1c..749ae24 100644
--- a/lib/toaster/toastergui/templates/dirinfo.html
+++ b/lib/toaster/toastergui/templates/dirinfo.html
@@ -76,7 +76,7 @@
 
         /* setup td specific formatting */
         var link_to = td(o.link_to);
-        var size = td(o.size);
+        var size = '<td class = "sizecol">' + o.size + '</td>'
         var permission = td(o.permission);
         var owner = td(o.owner);
         var group = td(o.group);
diff --git a/lib/toaster/toastergui/templates/package_built_dependencies.html b/lib/toaster/toastergui/templates/package_built_dependencies.html
index 4e86da5..a0c5a1e 100644
--- a/lib/toaster/toastergui/templates/package_built_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_built_dependencies.html
@@ -31,7 +31,7 @@
                         <tr>
                             <th>Package</th>
                             <th>Version</th>
-                            <th>Size</th>
+                            <th class="sizecol span2">Size</th>
                         </tr>
                     </thead>
                     <tbody>
@@ -49,7 +49,7 @@
                             </td>
                             {% endif %}
                             <td>{{runtime_dep.version}}</td>
-                            <td>{{runtime_dep.size|filtered_filesizeformat}}</td>
+                            <td class="sizecol">{{runtime_dep.size|filtered_filesizeformat}}</td>
                         </tr>
 						{% endfor %}
                     </tbody>
@@ -62,7 +62,7 @@
                         <tr>
                             <th>Package</th>
                             <th>Version</th>
-                            <th>Size</th>
+                            <th class="sizecol span2">Size</th>
                             <th>
                                 <i class="icon-question-sign get-help" title="Five relationship types exist: recommends, suggests, provides, replaces and conflicts"></i>
                                 Relationship type
@@ -84,7 +84,7 @@
                             </td>
                         {% endif %}
                             <td>{{other_dep.version}}</td>
-                            <td>{{other_dep.size|filtered_filesizeformat}}</td>
+                            <td class="sizecol">{{other_dep.size|filtered_filesizeformat}}</td>
                             <td>
                                 {{other_dep.dep_type_display}}
                                 <i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
diff --git a/lib/toaster/toastergui/templates/package_built_detail.html b/lib/toaster/toastergui/templates/package_built_detail.html
index 3aa1b2a..0fe0116 100644
--- a/lib/toaster/toastergui/templates/package_built_detail.html
+++ b/lib/toaster/toastergui/templates/package_built_detail.html
@@ -23,18 +23,12 @@
                 <div class="alert alert-info">
                     <strong>{{package.fullpackagespec}}</strong> is <strong>not included</strong> in any image. This page shows you the files added to an image root file system if you include <strong>{{package.fullpackagespec}}</strong> in future builds.
                 </div>
-                <table class="table table-bordered table-hover">
-                    <thead>
-                        <tr>
-                            <th>File</th>
-                            <th>Size</th>
-                        </tr>
-                    </thead>
+                {% include "tablesort.html" %}
                     <tbody>
-						{% for file in package.buildfilelist_package.all|dictsort:"path" %}
+						{% for file in objects %}
                             <tr>
-                                <td>{{file.path}}</td>
-                                <td>{{file.size|filtered_filesizeformat}}</td>
+                                <td class="path">{{file.path}}</td>
+                                <td class="filesize sizecol">{{file.size|filtered_filesizeformat}}</td>
                             </tr>
 						{% endfor %}
                     </tbody>
diff --git a/lib/toaster/toastergui/templates/package_included_dependencies.html b/lib/toaster/toastergui/templates/package_included_dependencies.html
index 9169ee9..642ca69 100644
--- a/lib/toaster/toastergui/templates/package_included_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_dependencies.html
@@ -20,7 +20,7 @@
                     <tr>
                         <th>Package</th>
                         <th>Version</th>
-                        <th>Size</th>
+                        <th class='sizecol span2'>Size</th>
                     </tr>
                 </thead>
                 <tbody>
@@ -39,7 +39,7 @@
                             </td>
                             {% endif %}
                             <td>{{runtime_dep.version}}&nbsp;</td>
-                            <td>{{runtime_dep.size|filtered_filesizeformat}}&nbsp;</td>
+                            <td class='sizecol'>{{runtime_dep.size|filtered_filesizeformat}}&nbsp;</td>
                         </tr>
 					{% endfor %}
                  </tbody>
@@ -57,7 +57,7 @@
                     <tr>
                         <th>Package</th>
                         <th>Version</th>
-                        <th>Size</th>
+                        <th class='sizecol span2'>Size</th>
                         <th>
                             <i class="icon-question-sign get-help" title="Five relationship types exist: recommends, suggests, provides, replaces and conflicts"></i>
                             Relationship type
@@ -83,7 +83,7 @@
                                     </td>
                                 {% endif %}
                                 <td>{{other_dep.version}}&nbsp;</td>
-                                <td>{{other_dep.size|filtered_filesizeformat}}&nbsp;</td>
+                                <td class='sizecol'>{{other_dep.size|filtered_filesizeformat}}&nbsp;</td>
                                 <td>
                                     {{other_dep.dep_type_display}}
                                     <i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
diff --git a/lib/toaster/toastergui/templates/package_included_detail.html b/lib/toaster/toastergui/templates/package_included_detail.html
index e89ebdf..d2aa26e 100644
--- a/lib/toaster/toastergui/templates/package_included_detail.html
+++ b/lib/toaster/toastergui/templates/package_included_detail.html
@@ -17,22 +17,16 @@
     <div class="tab-content">
         <div class="tab-pane active" id="files">
             {% if packageFileCount > 0 %}
-            <table class="table table-bordered table-hover">
-                <thead>
-                    <tr>
-                        <th>File</th>
-                        <th>Size</th>
-                    </tr>
-                </thead>
+            {% include "tablesort.html" %}
                 <tbody>
-					{% for file in package.buildfilelist_package.all|dictsort:"path" %}
+					{% for file in objects %}
                         <tr>
-                            <td>
+                            <td class="path">
                                 <a href="{% url 'dirinfo_filepath' build.id target.id file.path %}">
                                     {{file.path}}
                                 </a>
                              </td>
-                            <td>{{file.size|filtered_filesizeformat}}</td>
+                            <td class="filesize sizecol" >{{file.size|filtered_filesizeformat}}</td>
                         </tr>
 					{% endfor %}
                 </tbody>
diff --git a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
index 1efcb1a..a36464c 100644
--- a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
@@ -20,21 +20,14 @@
                 <strong>{{package.fullpackagespec}}</strong> has no reverse runtime dependencies.
             </div>
         {% else %}
-            <table class="table table-bordered table-hover">
-                <thead>
-                    <tr>
-                        <th>Package</th>
-                        <th>Version</th>
-                        <th>Size</th>
-                    </tr>
-                </thead>
+            {% include "tablesort.html" %}
                 <tbody>
-					{% for reverse_dep in reverse_deps|dictsort:"name" %}
+					{% for reverse_dep in objects %}
                         <tr {{reverse_dep.size|format_vpackage_rowclass}} >
                         {% if reverse_dep.size != -1 %}
                             <td>
-                                <a href="{% url 'package_included_detail' build.id target.id reverse_dep.dependent_id %}">
-                                    {{reverse_dep.name}}
+                                <a href="{% url 'package_included_detail' build.id target.id reverse_dep.package_id %}">
+                                    {{reverse_dep.package.name}}
                                 </a>
                                 <script>fmtAliasHelp("{{reverse_dep.name}}", "{{reverse_dep.alias}}", true)</script>
                             </td>
@@ -44,8 +37,8 @@
                             </td>
                             {% endif %}
 
-                            <td>{{reverse_dep.version}}&nbsp;</td>
-                            <td>{{reverse_dep.size|filtered_filesizeformat}}&nbsp;</td>
+                            <td>{{reverse_dep.package.version}}&nbsp;</td>
+                            <td class='sizecol'>{{reverse_dep.package.size|filtered_filesizeformat}}&nbsp;</td>
                         </tr>
 					{% endfor %}
                 </tbody>
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index c846aa9..6e9cd23 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -149,7 +149,7 @@
                         <th>
                             Version
                         </th>
-                        <th>
+                        <th class="sizecol span2">
                             Size
                         </th>
                     </tr>
@@ -161,7 +161,7 @@
                     <tr>
                         <td><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.name}}</a></td>
                         <td><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.version}}_{{package.revision}}</a></td>
-                        <td><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.size|filtered_filesizeformat}}</a></td>
+                        <td class="sizecol"><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.size|filtered_filesizeformat}}</a></td>
                     </tr>
 
                     {% endfor %}
diff --git a/lib/toaster/toastergui/templates/tablesort.html b/lib/toaster/toastergui/templates/tablesort.html
new file mode 100644
index 0000000..bf311b6
--- /dev/null
+++ b/lib/toaster/toastergui/templates/tablesort.html
@@ -0,0 +1,38 @@
+{% load projecttags %}
+<!-- component to display a generic table -->
+    {% if disable_sort %}
+    <table class="table table-bordered table-hover" id="detail_table">
+    <thead>
+        <tr>
+            {% for tc in tablecols %}
+            <th class="{{tc.dclass}} {{tc.clclass}}">
+                {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
+                {{tc.name}}
+            </th>
+            {% endfor %}
+        </tr>
+    </thead>
+    {% else %}
+    <table class="table table-bordered table-hover tablesorter" id="otable">
+    <thead>
+        <!-- Table header row; generated from "tablecols" entry in the context dict -->
+        <tr>
+            {% for tc in tablecols %}
+            <th class="{{tc.dclass}} {{tc.clclass}}">
+                {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
+                {%if tc.orderfield%}
+                    <a {%if tc.ordericon%} class="sorted" {%endif%}
+                        href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })" >
+                        {{tc.name}}
+                    </a>
+                {%else%}
+                    <span class="muted">
+                        {{tc.name}}
+                    </span>
+                {%endif%}
+                {%if tc.ordericon%} <i class="icon-caret-{{tc.ordericon}}"></i>{%endif%}
+            </th>
+            {% endfor %}
+        </tr>
+    </thead>
+    {% endif %}
diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index 5db0c0c..3a0c4d7 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -79,10 +79,10 @@
             {{package.version|filtered_packageversion:package.revision}}
             </a>
         </td>
-        <td class="package_size">
+        <td class="package-size sizecol">
             {{package.size|filtered_installedsize:package.installed_size|filtered_filesizeformat}}
         </td>
-        <td class="size_over_total">
+        <td class="size_over_total sizecol">
             {{package|filter_sizeovertotal:packages_sum}}
         </td>
         <td class="license">
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index e863457..be75b21 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -118,7 +118,7 @@ def filtered_filesizeformat(value):
     if value == -1:
         return ''
 
-    return filesizeformat(value).replace("bytes", "B").replace(".0", "")
+    return filesizeformat(value).replace("bytes", "B")
 
 @register.filter
 def filtered_packagespec(value):
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index f5fa72e..36eb0bf 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -563,13 +563,13 @@ def target(request, build_id, target_id):
                     'qhelp':'The size of the package',
                     'orderfield': _get_toggle_order(request, "size", True),
                     'ordericon':_get_toggle_order_icon(request, "size"),
-                    'clclass': 'package_size',
+                    'clclass': 'package_size span2',
                     'hidden' : 0,
                 },
                 {
                     'name':'Size over total (%)',
                     'qhelp':'Proportion of the overall included package size represented by this package',
-                    'clclass': 'size_over_total',
+                    'clclass': 'size_over_total span2',
                     'hidden' : 1,
                 },
                 {
@@ -1254,7 +1254,7 @@ def bpackage(request, build_id):
                 'qhelp':'The size of the package',
                 'orderfield': _get_toggle_order(request, "size", True),
                 'ordericon':_get_toggle_order_icon(request, "size"),
-                'clclass': 'size', 'hidden': 0,
+                'clclass': 'size span2', 'hidden': 0,
             },
             {
                 'name':'License',
@@ -1456,13 +1456,40 @@ def package_built_detail(request, build_id, package_id):
     template = "package_built_detail.html"
     if Build.objects.filter(pk=build_id).count() == 0 :
         return redirect(builds)
+
+    # follow convention for pagination w/ search although not used for this view
+    queryset = Package_File.objects.filter(package_id__exact=package_id)
+    mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'path:+'};
+    retval = _verify_parameters( request.GET, mandatory_parameters )
+    if retval:
+        return _redirect_parameters( 'package_built_detail', request.GET, mandatory_parameters, build_id = build_id, package_id = package_id)
+
+    (filter_string, search_term, ordering_string) = _search_tuple(request, Package_File)
+    paths = _get_queryset(Package_File, queryset, filter_string, search_term, ordering_string, 'path')
+
     package = Package.objects.filter(pk=package_id)[0]
     package.fullpackagespec = _get_fullpackagespec(package)
     context = {
             'build' : Build.objects.filter(pk=build_id)[0],
             'package' : package,
             'dependency_count' : _get_package_dependency_count(package, -1, False),
+            'objects' : paths,
+            'tablecols':[
+                {
+                    'name':'File',
+                    'orderfield': _get_toggle_order(request, "path"),
+                    'ordericon':_get_toggle_order_icon(request, "path"),
+                },
+                {
+                    'name':'Size',
+                    'orderfield': _get_toggle_order(request, "size", True),
+                    'ordericon':_get_toggle_order_icon(request, "size"),
+                    'dclass': 'sizecol span2',
+                },
+            ]
     }
+    if paths.all().count() < 2:
+        context['disable_sort'] = True;
     return render(request, template, context)
 
 def package_built_dependencies(request, build_id, package_id):
@@ -1488,6 +1515,17 @@ def package_included_detail(request, build_id, target_id, package_id):
     if Build.objects.filter(pk=build_id).count() == 0 :
         return redirect(builds)
 
+
+    # follow convention for pagination w/ search although not used for this view
+    mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'path:+'};
+    retval = _verify_parameters( request.GET, mandatory_parameters )
+    if retval:
+        return _redirect_parameters( 'package_included_detail', request.GET, mandatory_parameters, build_id = build_id, target_id = target_id, package_id = package_id)
+    (filter_string, search_term, ordering_string) = _search_tuple(request, Package_File)
+
+    queryset = Package_File.objects.filter(package_id__exact=package_id)
+    paths = _get_queryset(Package_File, queryset, filter_string, search_term, ordering_string, 'path')
+
     package = Package.objects.filter(pk=package_id)[0]
     package.fullpackagespec = _get_fullpackagespec(package)
     package.alias = _get_package_alias(package)
@@ -1497,8 +1535,24 @@ def package_included_detail(request, build_id, target_id, package_id):
             'target'  : target,
             'package' : package,
             'reverse_count' : _get_package_reverse_dep_count(package, target_id),
-            'dependency_count' : _get_package_dependency_count(package, target_id, True)
+            'dependency_count' : _get_package_dependency_count(package, target_id, True),
+            'objects': paths,
+            'tablecols':[
+                {
+                    'name':'File',
+                    'orderfield': _get_toggle_order(request, "path"),
+                    'ordericon':_get_toggle_order_icon(request, "path"),
+                },
+                {
+                    'name':'Size',
+                    'orderfield': _get_toggle_order(request, "size", True),
+                    'ordericon':_get_toggle_order_icon(request, "size"),
+                    'dclass': 'sizecol span2',
+                },
+            ]
     }
+    if paths.all().count() < 2:
+        context['disable_sort'] = True;
     return render(request, template, context)
 
 def package_included_dependencies(request, build_id, target_id, package_id):
@@ -1528,36 +1582,49 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
     if Build.objects.filter(pk=build_id).count() == 0 :
         return redirect(builds)
 
+    mandatory_parameters = { 'count': 25,  'page' : 1, 'orderby':'package__name:+'};
+    retval = _verify_parameters( request.GET, mandatory_parameters )
+    if retval:
+        return _redirect_parameters( 'package_included_reverse_dependencies', request.GET, mandatory_parameters, build_id = build_id, target_id = target_id, package_id = package_id)
+    (filter_string, search_term, ordering_string) = _search_tuple(request, Package_File)
+
+    queryset = Package_Dependency.objects.select_related('depends_on__name', 'depends_on__size').filter(depends_on=package_id, target_id=target_id, dep_type=Package_Dependency.TYPE_TRDEPENDS)
+    objects = _get_queryset(Package_Dependency, queryset, filter_string, search_term, ordering_string, 'package__name')
+
     package = Package.objects.filter(pk=package_id)[0]
     package.fullpackagespec = _get_fullpackagespec(package)
     package.alias = _get_package_alias(package)
     target = Target.objects.filter(pk=target_id)[0]
-
-    reverse_deps = []
-    alldeps = package.package_dependencies_target.filter(target_id__exact=target_id)
-    for idep in alldeps:
-        dep_package = Package.objects.get(pk=idep.package_id)
-        version = dep_package.version
-        if version  != '' :
-            version += '-' + dep_package.revision
-        dep = {
-                'name' : dep_package.name,
-                'alias' :  _get_package_alias(dep_package),
-                'dependent_id' : dep_package.id,
-                'version' : version,
-                'size' : dep_package.size
-        }
-        if idep.dep_type == Package_Dependency.TYPE_TRDEPENDS :
-            reverse_deps.append(dep)
-
+    for o in objects:
+        if o.package.version != '':
+            o.package.version += '-' + o.package.revision
+        o.alias = _get_package_alias(o.package)
     context = {
             'build' : Build.objects.filter(pk=build_id)[0],
             'package' : package,
             'target' : target,
-            'reverse_deps' : reverse_deps,
+            'objects' : objects,
             'reverse_count' : _get_package_reverse_dep_count(package, target_id),
-            'dependency_count' : _get_package_dependency_count(package, target_id, True)
+            'dependency_count' : _get_package_dependency_count(package, target_id, True),
+            'tablecols':[
+                {
+                    'name':'Package',
+                    'orderfield': _get_toggle_order(request, "package__name"),
+                    'ordericon': _get_toggle_order_icon(request, "package__name"),
+                },
+                {
+                    'name':'Version',
+                },
+                {
+                    'name':'Size',
+                    'orderfield': _get_toggle_order(request, "package__size", True),
+                    'ordericon': _get_toggle_order_icon(request, "package__size"),
+                    'dclass': 'sizecol span2',
+                },
+            ]
     }
+    if objects.all().count() < 2:
+        context['disable_sort'] = True;
     return render(request, template, context)
 
 def image_information_dir(request, build_id, target_id, packagefile_id):
-- 
1.9.1


