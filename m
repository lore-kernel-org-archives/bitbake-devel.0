Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 7DD576FB0D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 18:02:38 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id l18so560138wgh.28
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 11:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Vnp5BW9KSaJGBG35RvnacSb7Ws3pk+tqJZ2w8Lgpg98=;
	b=lLX/DtfnTho+of37Y7gveY84b2DRojtciMlt7krdCpNjGb08tOKRTGoshKizWsy8ft
	Qk/sM6b2M9xR1vKXqrbWlyuSQidyAD50Y2hLK6/TQstcTA8pf4RTWKNU7sz7G10Cqwut
	Du7eRTK2umXcwJixSeeULzKhV+AP8SBk13PXUc38Y8z9NjOOKTQ6zFwmjECnJmdzY+Bb
	PHWfYonyfnmBZwSCuDR9HhuaSfptfo0Tm6Ome05z31ysPfzKb0RzzbUetJc0jfpaVuqd
	7BzLKw9D6d1f8YgrO1577Wsu4DoLXm6lCMrifk2leOd+ivcB+wSCHGorM1g7QlD/iyrQ
	84Gw==
X-Gm-Message-State: ALoCoQn+1A7L9HhWz4HbzL2RDQtr4pKSYmnAvSXTZmXz3SWqgfwu//GQOL6pOv4wnhA+0w0HpwE1
X-Received: by 10.180.85.234 with SMTP id k10mr25194070wiz.32.1395770559106;
	Tue, 25 Mar 2014 11:02:39 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gz1sm10313084wib.14.2014.03.25.11.02.37 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 25 Mar 2014 11:02:37 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 97D5C561135; Tue, 25 Mar 2014 17:51:14 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Mar 2014 17:51:13 +0000
Message-Id: <87e75c8a665060d14ab5a89139224c78406615ea.1395769683.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7cdff1413429eb64bae7522e587b42f850aa0fe0.1395769683.git.alexandru.damian@intel.com>
References: <7cdff1413429eb64bae7522e587b42f850aa0fe0.1395769683.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395769683.git.alexandru.damian@intel.com>
References: <cover.1395769683.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/5] toaster: format packages with size = -1
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
X-List-Received-Date: Tue, 25 Mar 2014 18:02:40 -0000

From: Dave Lerner <dave.lerner@windriver.com>

Packages that have a size of -1 are virtual packages with limited
information.  Such packages should be suppressed from the package
list page for an image.  On dependency and reverse dependency lists of
package, such packages should appear in muted rows, without links,
and with help information.

The formatting rules are encapsulated into projecttags filters when
possible to minimize tests on size==-1 in the templates.

Testing the relevant pages with an HTML5 validator found a stray end
tag in package_detail_base which has been fixed in this commit.

[YOCTO #5966]

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../toastergui/templates/package_detail_base.html   |  2 +-
 .../templates/package_included_dependencies.html    | 19 ++++++++++++++++---
 .../package_included_reverse_dependencies.html      |  9 ++++++++-
 lib/toaster/toastergui/templatetags/projecttags.py  | 21 ++++++++++++++++++++-
 lib/toaster/toastergui/views.py                     |  2 +-
 5 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index 79f135c..6925aec 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -97,8 +97,8 @@
                     # decision on index search algorithm
                     <a href="http://layers.openembedded.org"  target="_blank">
                     <i class="icon-share get-info"></i>
-                    {% endcomment %}
                     </a>
+                    {% endcomment %}
                 {% endif %}
             </dd>
 
diff --git a/lib/toaster/toastergui/templates/package_included_dependencies.html b/lib/toaster/toastergui/templates/package_included_dependencies.html
index 71043ec..c76774a 100644
--- a/lib/toaster/toastergui/templates/package_included_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_dependencies.html
@@ -23,12 +23,19 @@
                 </thead>
                 <tbody>
 					{% for runtime_dep in runtime_deps %}
-                        <tr>
+                        <tr {{runtime_dep.size|format_vpackage_rowclass}} >
+                            {% if runtime_dep.size != -1 %}
                             <td>
                                <a href="{% url 'package_included_detail' build.id target.id runtime_dep.depends_on_id %}">
                                     {{runtime_dep.name}}
                                 </a>
                             </td>
+                            {% else %}
+                            <td>
+                                {{runtime_dep.name|format_vpackage_namehelp}}
+                            </td>
+                            {% endif %}
+
                             <td>{{runtime_dep.version}}</td>
                             <td>{{runtime_dep.size|filtered_filesizeformat}}</td>
                         </tr>
@@ -58,12 +65,18 @@
                 <tbody>
 					{% for other_dep in other_deps %}
                         {% if other_dep.installed %}
-                            <tr>
+                            <tr {{other_dep.size|format_vpackage_rowclass}}>
+                                {% if other_dep.size != -1 %}
                                 <td>
-                                   <a href="{% url 'package_included_detail' build.id target.id other_dep.depends_on_id %}">
+                                    <a href="{% url 'package_included_detail' build.id target.id other_dep.depends_on_id %}">
                                         {{other_dep.name}}
                                     </a>
                                 </td>
+                                {% else %}
+                                    <td>
+                                        {{other_dep.name|format_vpackage_namehelp}}
+                                    </td>
+                                {% endif %}
                                 <td>{{other_dep.version}}</td>
                                 <td>{{other_dep.size|filtered_filesizeformat}}</td>
                                 <td>
diff --git a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
index 0eb39d3..8653ae0 100644
--- a/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
+++ b/lib/toaster/toastergui/templates/package_included_reverse_dependencies.html
@@ -28,12 +28,19 @@
                 </thead>
                 <tbody>
 					{% for reverse_dep in reverse_deps|dictsort:"name" %}
-                        <tr>
+                        <tr {{reverse_dep.size|format_vpackage_rowclass}} >
+                        {% if reverse_dep.size != -1 %}
                             <td>
                                 <a href="{% url 'package_included_detail' build.id target.id reverse_dep.dependent_id %}">
                                     {{reverse_dep.name}}
                                 </a>
                             </td>
+                            {% else %}
+                            <td>
+                                {{reverse_dep.name|format_vpackage_namehelp}}
+                            </td>
+                            {% endif %}
+
                             <td>{{reverse_dep.version}}</td>
                             <td>{{reverse_dep.size|filtered_filesizeformat}}</td>
                         </tr>
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 12c2468..34c3c21 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -110,8 +110,14 @@ def format_none_and_zero(value):
 
 @register.filter
 def filtered_filesizeformat(value):
-    """Change output from fileformatsize to suppress trailing '.0' and change 'bytes' to 'B'
     """
+    If the value is -1 return an empty string. Otherwise,
+    change output from fileformatsize to suppress trailing '.0'
+    and change 'bytes' to 'B'.
+    """
+    if value == -1:
+        return ''
+
     return filesizeformat(value).replace("bytes", "B").replace(".0", "")
 
 @register.filter
@@ -228,4 +234,17 @@ def filter_sizeovertotal(package_object, total_size):
   
     return '{:.1%}'.format(float(size)/float(total_size))
 
+from django.utils.safestring import mark_safe
+@register.filter
+def format_vpackage_rowclass(size):
+    if size == -1:
+        return mark_safe('class="muted"')
+    return ''
 
+@register.filter
+def format_vpackage_namehelp(name):
+    r =  name + '&nbsp;'
+    r += '<i class="icon-question-sign get-help hover-help"'
+    r += ' title = "' + name + ' only has dependency information available.">'
+    r += '</i>'
+    return mark_safe(r)
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 92814ce..d1234fe 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -425,7 +425,7 @@ def target(request, build_id, target_id):
     (filter_string, search_term, ordering_string) = _search_tuple(request, Package)
 
     # FUTURE:  get rid of nested sub-queries replacing with ManyToMany field
-    queryset = Package.objects.filter(id__in=Target_Installed_Package.objects.filter(target_id=target_id).values('package_id'))
+    queryset = Package.objects.filter(size__gte=0, id__in=Target_Installed_Package.objects.filter(target_id=target_id).values('package_id'))
     packages_sum =  queryset.aggregate(Sum('installed_size'))
     queryset = _get_queryset(Package, queryset, filter_string, search_term, ordering_string)
     packages = _build_page_range(Paginator(queryset, request.GET.get('count', 25)),request.GET.get('page', 1))
-- 
1.8.3.2


