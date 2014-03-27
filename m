Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id 11AAE6F974
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:50:06 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id w61so1934198wes.18
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=EcVdlndosQHnnvFYCIO195QQNC700ysRvbXWvIif0NI=;
	b=RPIIHNV8h9X0kFDMDYzva+Ki2+VQ80XMBK9/p+/xWGh3NN84fcZbmofZhXjS3nfh8Z
	xGqqkvtenRH7NT4ev1q68Ps654UX10zdTxMYctV2KSMDudEXWcpCQ2Ca2b1Pn2gn73Rk
	EBrFIkrsAyJduedHWXt2bfChgtlKascRxXPWPYYe/AV/o4X04aQB/Xuv49WwEJujIwWj
	IEnoioj8L/mac47zgf1OHEiRxdZu0GR9lGu0c4dwk34FRfNoQX80cPVz8PuRS11NOvfi
	doGbkB9A38d8MoS393ve68r+H8Q5x2dltrdyJU+SstGNbHCi5WqciX08UG18TPiE6Bru
	RTVw==
X-Gm-Message-State: ALoCoQmYYDBOjGDIoVkYPuvqt7PpvYnoHpOUBfwwPdYX5hRT54V67t4UmJGthIQPNF60nXDT4iTX
X-Received: by 10.180.19.69 with SMTP id c5mr6379422wie.7.1395939007609;
	Thu, 27 Mar 2014 09:50:07 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id w10sm13897597wiy.9.2014.03.27.09.50.04
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:50:06 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 81A27560C67; Thu, 27 Mar 2014 16:50:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:49:57 +0000
Message-Id: <a738a837a71d2af68dceb56adbc295b0180c38fb.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
References: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395938903.git.alexandru.damian@intel.com>
References: <cover.1395938903.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 5/9] toaster: show installed package name
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
X-List-Received-Date: Thu, 27 Mar 2014 16:50:07 -0000

From: Dave Lerner <dave.lerner@windriver.com>

[YOCTO #5922]

Implement changes that show the installed package name after the
official 'recipe-named' package name.  If the alias exists and
is different than the package name, then the alias is shown as a
'muted' string after the package name in the form 'as some-alias-name'.
This formatting appears in the included package pages in the elements:
* local breadcrumbs at the top of package included pages,
* <h1> title headings along with a help bubble that is not hovering,
and
* package lists where the help bubble appears when the mouse hovers
over the row.

The changes in detail in this patch per file are:
views.py
- added function that tests whether the package object's installed_name
should be shown,
- added function that appends package name with version and revision to
encapsulate package name formatting in one place and referred to as
package.fullpackagespec,
- changed package_built* and package_included* functions to use both
of the above new formatting functions, passing the formatted values to
templates, and
- adhered to django coding styles by renaming  module local
'get_package*' functions with "_" prefix.

package_detail_base.html
- added display of package aliases for included package page,
- refactored to use package.fullpackagespec, formatted by view function,
- added javascript function to format package alias with help, and
- removed trailing whitespace.

package_included_detail.html
- used javascript function above to format package alias, and
- refactored to use package.fullpackagespec.

package_included_dependencies.html
- used javascript function above to format package alias,
- refactored to use package.fullpackagespec,
- forced empty data cells following hover-help to draw borders
by appending space, and
- removed trailing whitespace.

package_included_reverse_dependencies.html
- use javascript function above to format package alias,
- refactor to use views fullpackagespe, and
- force empty data cells following hover-help to draw borders
by appending space.

package_built_detail.html
- refactored to use package.fullpackagespec, and
- removed trailing whitespace.

package_built_dependencies.html
- refactored to use package.fullpackagespec, and
- removed trailing whitespace.

projecttags.py
- removed unused filter to handle installed name
- removed extra spaces around "title = " in format_vpackage_namehelp

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
---
 .../templates/package_built_dependencies.html      | 10 ++--
 .../toastergui/templates/package_built_detail.html |  8 +--
 .../toastergui/templates/package_detail_base.html  | 36 ++++++++++---
 .../templates/package_included_dependencies.html   | 31 ++++++-----
 .../templates/package_included_detail.html         | 14 +++--
 .../package_included_reverse_dependencies.html     | 17 +++---
 lib/toaster/toastergui/templatetags/projecttags.py | 10 +---
 lib/toaster/toastergui/views.py                    | 60 +++++++++++++++++-----
 8 files changed, 121 insertions(+), 65 deletions(-)

diff --git a/lib/toaster/toastergui/templates/package_built_dependencies.html b/lib/toaster/toastergui/templates/package_built_dependencies.html
index 4932f74..a2011d6 100644
--- a/lib/toaster/toastergui/templates/package_built_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_built_dependencies.html
@@ -2,7 +2,6 @@
 {% load projecttags %}
 
 {% block tabcontent %}
-    {% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
         <ul class="nav nav-pills">
             <li class="">
                 <a href="{% url 'package_built_detail' build.id package.id %}">
@@ -21,11 +20,11 @@
             <div class="tab-pane active" id="dependencies">
             {% ifequal runtime_deps|length 0 %}
                 <div class="alert alert-info">
-                    <strong>{{fullPackageSpec}}</strong> has no runtime dependencies.
+                    <strong>{{package.fullpackagespec}}</strong> has no runtime dependencies.
                 </div>
             {% else %}
                 <div class="alert alert-info">
-                    <strong>{{fullPackageSpec}}</strong> is <strong>not included</strong> in any image.  These are its projected runtime dependencies if you were to include it in future builds.
+                    <strong>{{package.fullpackagespec}}</strong> is <strong>not included</strong> in any image.  These are its projected runtime dependencies if you were to include it in future builds.
                 </div>
                 <table class="table table-bordered table-hover">
                     <thead>
@@ -56,7 +55,7 @@
                                 </tr>
                             {% endifequal %}
 						{% endfor %}
-                    </tbody>    
+                    </tbody>
                 </table>
             {% endifequal %}
             {% ifnotequal other_deps|length 0 %}
@@ -72,7 +71,7 @@
                                 Relationship type
                             </th>
                         </tr>
-                    </thead>       
+                    </thead>
                     <tbody>
 						{% for other_dep in other_deps %}
                         	{% ifequal other_dep.version '' %}
@@ -106,5 +105,4 @@
                 {% endifnotequal %}
             </div> <!-- tab-pane -->
         </div> <!-- tab-content -->
-    {% endwith %}
 {% endblock tabcontent %}
diff --git a/lib/toaster/toastergui/templates/package_built_detail.html b/lib/toaster/toastergui/templates/package_built_detail.html
index d8f0b75..6ccd405 100644
--- a/lib/toaster/toastergui/templates/package_built_detail.html
+++ b/lib/toaster/toastergui/templates/package_built_detail.html
@@ -2,7 +2,7 @@
 {% load projecttags %}
 
 {% block tabcontent %}
-    {% with fullPackageSpec=package.name|add:"-"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
+    {% with packageFileCount=package.buildfilelist_package.count %}
         <!-- Generated Files -->
         {% if package.buildtargetlist_package.count == 0 %}
             {# Not included case #}
@@ -21,7 +21,7 @@
             <!-- Package file list or if empty, alert pane -->
             {% if packageFileCount > 0 %}
                 <div class="alert alert-info">
-                    {{fullPackageSpec}} is <strong>not included</strong> in any image.  These are the files that would be added to an image root file system if you were to include it in future builds.
+                    {{package.fullpackagespec}} is <strong>not included</strong> in any image.  These are the files that would be added to an image root file system if you were to include it in future builds.
                 </div>
                 <table class="table table-bordered table-hover">
                     <thead>
@@ -29,7 +29,7 @@
                             <th>File</th>
                             <th>Size</th>
                         </tr>
-                    </thead>                   
+                    </thead>
                     <tbody>
 						{% for file in package.buildfilelist_package.all|dictsort:"path" %}
                             <tr>
@@ -42,7 +42,7 @@
 
             {% else %}
                 <div class="alert alert-info">
-                    <strong>{{fullPackageSpec}}</strong> does not generate any files.
+                    <strong>{{package.fullpackagespec}}</strong> does not generate any files.
                 </div>
             {% endif %}
 
diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index 6925aec..5ec9dd7 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -1,24 +1,45 @@
 {% extends "basebuilddetailpage.html" %}
 {% load projecttags %}
 
+{% block extraheadcontent %}
+    <!-- functions to format package 'installed_package' alias -->
+    <script>
+    function fmtAliasHelp(package_name, alias, hover) {
+        var r = null;
+        if (alias != null && alias != '') {
+            r = '<span class="muted"> as ' + alias + '&nbsp';
+            r += '<i class="icon-question-sign get-help';
+            if (hover) {
+                r+= ' hover-help';
+            }
+            else {
+                r+= ' heading-help';
+            }
+            r += '"';
+            title = package_name + ' was renamed at packaging time and was installed on your system as ' + alias;
+            r += ' title="' + title + '">';
+            r += '</i>';
+            r += '</span>';
+            document.write(r);
+        }
+    }
+    </script>
+{% endblock extraheadcontent %}
 {% block localbreadcrumb %}
-{% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
     {% if target %}
         <li><a href="{% url "target" build.id target.id %}">{{target.target}}</a></li>
+        <li>{{package.fullpackagespec}} {% if package.alias %} as {{package.alias}}{% endif %}</li>
     {% else %}
         <li><a href="{% url "packages" build.id %}"> Packages </a></li>
+        <li>{{package.fullpackagespec}}</li>
     {% endif %}
-        <li>{{fullPackageSpec}}</li>
-{% endwith %}
 {% endblock localbreadcrumb %}
 
 {% block pagedetailinfomain %}
-{% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
-
     <div class="row span11">
         <div class="page-header">
             {% block title %}
-            <h1>{{fullPackageSpec}}</h1>
+            <h1>{{package.fullpackagespec}}</h1>
             {% endblock title %}
         </div> <!-- page-header -->
     </div> <!-- row span11 page-header -->
@@ -93,7 +114,7 @@
                 {{package.recipe.layer_version.layer.name}}
                 {% if package.recipe.layer_version.layer.name|format_none_and_zero != "" %}
                     {% comment %}
-                    # Removed per team meeting of 1/29/2014 until 
+                    # Removed per team meeting of 1/29/2014 until
                     # decision on index search algorithm
                     <a href="http://layers.openembedded.org"  target="_blank">
                     <i class="icon-share get-info"></i>
@@ -121,5 +142,4 @@
         </dl>
     </div> <!-- row4 well -->
     {% endblock twocolumns %}
-{% endwith %}
 {% endblock pagedetailinfomain %}
diff --git a/lib/toaster/toastergui/templates/package_included_dependencies.html b/lib/toaster/toastergui/templates/package_included_dependencies.html
index c76774a..e06e073 100644
--- a/lib/toaster/toastergui/templates/package_included_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_dependencies.html
@@ -2,13 +2,15 @@
 {% load projecttags %}
 
 {% block title %}
-    {% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
-        <h1>{{fullPackageSpec}} <small>({{target.target}})</small></h1>
-    {% endwith %}
+    <h1>
+        {{package.fullpackagespec}}
+        <script> fmtAliasHelp("{{package.name}}", "{{package.alias}}", false) </script>
+        <small>({{target.target}})</small>
+    </h1>
 {% endblock title %}
 
 {% block tabcontent %}
-    {% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
+    {% with packageFileCount=package.buildfilelist_package.count %}
     {% include "package_included_tabs.html" with active_tab="dependencies" %}
     <div class="tab-content">
        <div class="tab-pane active" id="dependencies">
@@ -29,22 +31,22 @@
                                <a href="{% url 'package_included_detail' build.id target.id runtime_dep.depends_on_id %}">
                                     {{runtime_dep.name}}
                                 </a>
+                                <script>fmtAliasHelp("{{runtime_dep.name}}", "{{runtime_dep.alias}}", true)</script>
                             </td>
                             {% else %}
                             <td>
                                 {{runtime_dep.name|format_vpackage_namehelp}}
                             </td>
                             {% endif %}
-
-                            <td>{{runtime_dep.version}}</td>
-                            <td>{{runtime_dep.size|filtered_filesizeformat}}</td>
+                            <td>{{runtime_dep.version}}&nbsp;</td>
+                            <td>{{runtime_dep.size|filtered_filesizeformat}}&nbsp;</td>
                         </tr>
 					{% endfor %}
-                 </tbody>                
+                 </tbody>
             </table>
         {% else %}
             <div class="alert alert-info">
-                <strong>{{fullPackageSpec}}</strong> has no runtime dependencies.
+                <strong>{{package.fullpackagespec}}</strong> has no runtime dependencies.
             </div>
         {% endifnotequal %}
 
@@ -61,7 +63,7 @@
                             Relationship type
                         </th>
                     </tr>
-                </thead>               
+                </thead>
                 <tbody>
 					{% for other_dep in other_deps %}
                         {% if other_dep.installed %}
@@ -70,6 +72,9 @@
                                 <td>
                                     <a href="{% url 'package_included_detail' build.id target.id other_dep.depends_on_id %}">
                                         {{other_dep.name}}
+                                        <script>
+                                        fmtAliasHelp("{{other_dep.name}}","{{other_dep.alias}}", true)
+                                        </script>
                                     </a>
                                 </td>
                                 {% else %}
@@ -77,8 +82,8 @@
                                         {{other_dep.name|format_vpackage_namehelp}}
                                     </td>
                                 {% endif %}
-                                <td>{{other_dep.version}}</td>
-                                <td>{{other_dep.size|filtered_filesizeformat}}</td>
+                                <td>{{other_dep.version}}&nbsp;</td>
+                                <td>{{other_dep.size|filtered_filesizeformat}}&nbsp;</td>
                                 <td>
                                     {{other_dep.dep_type_display}}
                                     <i class="icon-question-sign get-help hover-help" title="{{other_dep.dep_type_help}}" ></i>
@@ -96,7 +101,7 @@
                             </tr>
                         {% endif %}
 					{% endfor %}
-                </tbody>               
+                </tbody>
             </table>
         {% endifnotequal %}
         </div> <!-- end tab-pane -->
diff --git a/lib/toaster/toastergui/templates/package_included_detail.html b/lib/toaster/toastergui/templates/package_included_detail.html
index ce4f1cb..e89ebdf 100644
--- a/lib/toaster/toastergui/templates/package_included_detail.html
+++ b/lib/toaster/toastergui/templates/package_included_detail.html
@@ -2,13 +2,17 @@
 {% load projecttags %}
 
 {% block title %}
-{% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec %}
-        <h1>{{fullPackageSpec}} <small>({{target.target}})</small></h1>
-{% endwith %}
+        <h1>
+            {{package.fullpackagespec}}
+            <script>
+                fmtAliasHelp("{{package.name}}", "{{package.alias}}", false)
+            </script>
+            <small>({{target.target}})</small>
+        </h1>
 {% endblock title %}
 
 {% block tabcontent %}
-{% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
+{% with packageFileCount=package.buildfilelist_package.count %}
     {% include "package_included_tabs.html" with active_tab="detail" %}
     <div class="tab-content">
         <div class="tab-pane active" id="files">
@@ -36,7 +40,7 @@
 
             {% else %}
             <div class="alert alert-info">
-                <strong>{{fullPackageSpec}}</strong> does not generate any files.
+                <strong>{{package.fullpackagespec}}</strong> does not generate any files.
             </div>
             {% endif %}
         </div> <!-- end tab-pane -->
diff --git a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
index 8653ae0..1efcb1a 100644
--- a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
@@ -2,20 +2,22 @@
 {% load projecttags %}
 
 {% block title %}
-    {% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec  %}
-        <h1>{{fullPackageSpec}} <small>({{target.target}})</small></h1>
-    {% endwith %}
+        <h1>
+            {{package.fullpackagespec}}
+            <script> fmtAliasHelp("{{package.name}}", "{{package.alias}}", false) </script>
+            <small>({{target.target}})</small>
+        </h1>
 {% endblock title %}
 
 {% block tabcontent %}
-    {% with fullPackageSpec=package.name|add:"_"|add:package.version|add:"-"|add:package.revision|filtered_packagespec packageFileCount=package.buildfilelist_package.count %}
+    {% with packageFileCount=package.buildfilelist_package.count %}
     {% include "package_included_tabs.html" with active_tab="reverse" %}
     <div class="tab-content">
         <div class="tab-pane active" id="brought-in-by">
 
         {% ifequal reverse_deps|length  0 %}
            <div class="alert alert-info">
-                <strong>{{fullPackageSpec}}</strong> has no reverse runtime dependencies.
+                <strong>{{package.fullpackagespec}}</strong> has no reverse runtime dependencies.
             </div>
         {% else %}
             <table class="table table-bordered table-hover">
@@ -34,6 +36,7 @@
                                 <a href="{% url 'package_included_detail' build.id target.id reverse_dep.dependent_id %}">
                                     {{reverse_dep.name}}
                                 </a>
+                                <script>fmtAliasHelp("{{reverse_dep.name}}", "{{reverse_dep.alias}}", true)</script>
                             </td>
                             {% else %}
                             <td>
@@ -41,8 +44,8 @@
                             </td>
                             {% endif %}
 
-                            <td>{{reverse_dep.version}}</td>
-                            <td>{{reverse_dep.size|filtered_filesizeformat}}</td>
+                            <td>{{reverse_dep.version}}&nbsp;</td>
+                            <td>{{reverse_dep.size|filtered_filesizeformat}}&nbsp;</td>
                         </tr>
 					{% endfor %}
                 </tbody>
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 34c3c21..76166ca 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -208,14 +208,6 @@ def filtered_installedsize(size, installed_size):
     return size if (installed_size == 0) or (installed_size == "") or (installed_size == None) else installed_size
 
 @register.filter
-def filtered_installedname(name, installed_name):
-    """If package.installed_name not null and not empty
-        return <div class=muted> as {{package.installed_name}}
-        otherwise ""
-    """
-    return name if (name == installed_name) or (not installed_name) or (installed_name == "") else name + " as " + installed_name
-
-@register.filter
 def filtered_packageversion(version, revision):
     """ Emit "version-revision" if version and revision are not null
         else "version" if version is not null
@@ -245,6 +237,6 @@ def format_vpackage_rowclass(size):
 def format_vpackage_namehelp(name):
     r =  name + '&nbsp;'
     r += '<i class="icon-question-sign get-help hover-help"'
-    r += ' title = "' + name + ' only has dependency information available.">'
+    r += ' title="' + name + ' only has dependency information available.">'
     r += '</i>'
     return mark_safe(r)
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 8f6e201..0f92caf 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1280,7 +1280,7 @@ the RRECOMENDS or TRECOMENDS value.
 The lists are built in the sort order specified for the package runtime
 dependency views.
 """
-def get_package_dependencies(package_id, target_id = INVALID_KEY):
+def _get_package_dependencies(package_id, target_id = INVALID_KEY):
     runtime_deps = []
     other_deps = []
     other_depends_types = OTHER_DEPENDS_BASE
@@ -1318,6 +1318,10 @@ def get_package_dependencies(package_id, target_id = INVALID_KEY):
                 'depends_on_id' : dep_package.id,
                 'installed' : installed,
                 }
+
+        if target_id != INVALID_KEY:
+                dep['alias'] = _get_package_alias(dep_package)
+
         if idep.dep_type == rdepends_type :
             runtime_deps.append(dep)
         elif idep.dep_type in other_depends_types :
@@ -1331,28 +1335,50 @@ def get_package_dependencies(package_id, target_id = INVALID_KEY):
     return retvalues
 
 # Return the count of packages dependent on package for this target_id image
-def get_package_reverse_dep_count(package, target_id):
+def _get_package_reverse_dep_count(package, target_id):
     return package.package_dependencies_target.filter(target_id__exact=target_id, dep_type__exact = Package_Dependency.TYPE_TRDEPENDS).count()
 
 # Return the count of the packages that this package_id is dependent on.
 # Use one of the two RDEPENDS types, either TRDEPENDS if the package was
 # installed, or else RDEPENDS if only built.
-def get_package_dependency_count(package, target_id, is_installed):
+def _get_package_dependency_count(package, target_id, is_installed):
     if is_installed :
         return package.package_dependencies_source.filter(target_id__exact = target_id,
             dep_type__exact = Package_Dependency.TYPE_TRDEPENDS).count()
     else :
         return package.package_dependencies_source.filter(dep_type__exact = Package_Dependency.TYPE_RDEPENDS).count()
 
+def _get_package_alias(package):
+    alias = package.installed_name
+    if alias != None and alias != '' and alias != package.name:
+        return alias
+    else:
+        return ''
+
+def _get_fullpackagespec(package):
+    r = package.name
+    version_good = package.version != None and  package.version != ''
+    revision_good = package.revision != None and package.revision != ''
+    if version_good or revision_good:
+        r += '_'
+        if version_good:
+            r += package.version
+            if revision_good:
+                r += '-'
+        if revision_good:
+            r += package.revision
+    return r
+
 def package_built_detail(request, build_id, package_id):
     template = "package_built_detail.html"
     if Build.objects.filter(pk=build_id).count() == 0 :
         return redirect(builds)
     package = Package.objects.filter(pk=package_id)[0]
+    package.fullpackagespec = _get_fullpackagespec(package)
     context = {
             'build' : Build.objects.filter(pk=build_id)[0],
             'package' : package,
-            'dependency_count' : get_package_dependency_count(package, -1, False),
+            'dependency_count' : _get_package_dependency_count(package, -1, False),
     }
     return render(request, template, context)
 
@@ -1362,13 +1388,14 @@ def package_built_dependencies(request, build_id, package_id):
          return redirect(builds)
 
     package = Package.objects.filter(pk=package_id)[0]
-    dependencies = get_package_dependencies(package_id)
+    package.fullpackagespec = _get_fullpackagespec(package)
+    dependencies = _get_package_dependencies(package_id)
     context = {
             'build' : Build.objects.filter(pk=build_id)[0],
             'package' : package,
             'runtime_deps' : dependencies['runtime_deps'],
             'other_deps' :   dependencies['other_deps'],
-            'dependency_count' : get_package_dependency_count(package, -1,  False)
+            'dependency_count' : _get_package_dependency_count(package, -1,  False)
     }
     return render(request, template, context)
 
@@ -1379,13 +1406,15 @@ def package_included_detail(request, build_id, target_id, package_id):
         return redirect(builds)
 
     package = Package.objects.filter(pk=package_id)[0]
+    package.fullpackagespec = _get_fullpackagespec(package)
+    package.alias = _get_package_alias(package)
     target = Target.objects.filter(pk=target_id)[0]
     context = {
             'build' : Build.objects.filter(pk=build_id)[0],
             'target'  : target,
             'package' : package,
-            'reverse_count' : get_package_reverse_dep_count(package, target_id),
-            'dependency_count' : get_package_dependency_count(package, target_id, True)
+            'reverse_count' : _get_package_reverse_dep_count(package, target_id),
+            'dependency_count' : _get_package_dependency_count(package, target_id, True)
     }
     return render(request, template, context)
 
@@ -1395,17 +1424,19 @@ def package_included_dependencies(request, build_id, target_id, package_id):
         return redirect(builds)
 
     package = Package.objects.filter(pk=package_id)[0]
+    package.fullpackagespec = _get_fullpackagespec(package)
+    package.alias = _get_package_alias(package)
     target = Target.objects.filter(pk=target_id)[0]
 
-    dependencies = get_package_dependencies(package_id, target_id)
+    dependencies = _get_package_dependencies(package_id, target_id)
     context = {
             'build' : Build.objects.filter(pk=build_id)[0],
             'package' : package,
             'target' : target,
             'runtime_deps' : dependencies['runtime_deps'],
             'other_deps' :   dependencies['other_deps'],
-            'reverse_count' : get_package_reverse_dep_count(package, target_id),
-            'dependency_count' : get_package_dependency_count(package, target_id, True)
+            'reverse_count' : _get_package_reverse_dep_count(package, target_id),
+            'dependency_count' : _get_package_dependency_count(package, target_id, True)
     }
     return render(request, template, context)
 
@@ -1415,6 +1446,8 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
         return redirect(builds)
 
     package = Package.objects.filter(pk=package_id)[0]
+    package.fullpackagespec = _get_fullpackagespec(package)
+    package.alias = _get_package_alias(package)
     target = Target.objects.filter(pk=target_id)[0]
 
     reverse_deps = []
@@ -1426,6 +1459,7 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
             version += '-' + dep_package.revision
         dep = {
                 'name' : dep_package.name,
+                'alias' :  _get_package_alias(dep_package),
                 'dependent_id' : dep_package.id,
                 'version' : version,
                 'size' : dep_package.size
@@ -1438,8 +1472,8 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
             'package' : package,
             'target' : target,
             'reverse_deps' : reverse_deps,
-            'reverse_count' : get_package_reverse_dep_count(package, target_id),
-            'dependency_count' : get_package_dependency_count(package, target_id, True)
+            'reverse_count' : _get_package_reverse_dep_count(package, target_id),
+            'dependency_count' : _get_package_dependency_count(package, target_id, True)
     }
     return render(request, template, context)
 
-- 
1.8.3.2


