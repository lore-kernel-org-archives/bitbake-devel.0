Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 1DA0E6D840
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:36 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449359953"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:33 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:14 +0000
Message-Id: <2d37a1731a2b681bc976f3f391d65abb7745b6f9.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 08/11] toaster: update to Django 1.5
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:36 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In order to remain up to date with the relevant technologies,
Toaster is updated with this patch to Django 1.5. This also
makes headways to allow usage of emerging
Django-related technologies.

Changes include the startup script Django version check, usage
of TemplateView instead of deprecated simple function to do
redirects, and update to the new form of the _url_ template tag.

Support for Django 1.4.5 is now deprecated.

    [YOCTO #5558]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                        | 4 ++--
 lib/toaster/bldviewer/templates/base.html          | 4 ++--
 lib/toaster/bldviewer/templates/basebuildpage.html | 8 ++++----
 lib/toaster/bldviewer/templates/bpackage.html      | 4 ++--
 lib/toaster/bldviewer/templates/build.html         | 4 ++--
 lib/toaster/bldviewer/templates/layer.html         | 2 +-
 lib/toaster/bldviewer/templates/package.html       | 2 +-
 lib/toaster/bldviewer/templates/task.html          | 2 +-
 lib/toaster/bldviewer/urls.py                      | 4 ++--
 lib/toaster/toastermain/urls.py                    | 4 ++--
 10 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index d4715fa..7e51014 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -87,8 +87,8 @@ BBBASEDIR=`dirname ${BASH_SOURCE}`/..
 
 # Verify prerequisites
 
-if ! echo "import django; print (1,4,5) == django.VERSION[0:3]" | python 2>/dev/null | grep True >/dev/null; then
-    echo -e "This program needs Django 1.4.5. Please install with\n\nsudo pip install django==1.4.5"
+if ! echo "import django; print (1,5) == django.VERSION[0:2]" | python 2>/dev/null | grep True >/dev/null; then
+    echo -e "This program needs Django 1.5. Please install with\n\nsudo pip install django==1.5"
     return 2
 fi
 
diff --git a/lib/toaster/bldviewer/templates/base.html b/lib/toaster/bldviewer/templates/base.html
index 101880d..d58cbea 100644
--- a/lib/toaster/bldviewer/templates/base.html
+++ b/lib/toaster/bldviewer/templates/base.html
@@ -14,8 +14,8 @@
 <div style="width:100%; height: 100%; position:absolute">
 <div style="width: 100%; height: 3em" class="nav">
     <ul class="nav nav-tabs">
-        <li><a href="{% url all-builds %}">All Builds</a></li>
-        <li><a href="{% url all-layers %}">All Layers</a></li>
+        <li><a href="{% url "all-builds" %}">All Builds</a></li>
+        <li><a href="{% url "all-layers" %}">All Layers</a></li>
     </ul>
 </div>
 
diff --git a/lib/toaster/bldviewer/templates/basebuildpage.html b/lib/toaster/bldviewer/templates/basebuildpage.html
index 873f271..d590f28 100644
--- a/lib/toaster/bldviewer/templates/basebuildpage.html
+++ b/lib/toaster/bldviewer/templates/basebuildpage.html
@@ -3,14 +3,14 @@
 {% block pagename %}
 <ul class="nav nav-tabs" style="display: inline-block">
   <li><a>Build {{build.target_set.all|join:"&nbsp;"}} at {{build.started_on}} : </a></li>
-  <li><a href="{% url task build.id %}"> Tasks </a></li>
-  <li><a href="{% url bpackage build.id %}"> Build Packages </a></li>
+  <li><a href="{% url "task" build.id %}"> Tasks </a></li>
+  <li><a href="{% url "bpackage" build.id %}"> Build Packages </a></li>
     {% for t in build.target_set.all %}
         {% if t.is_image %}
-  <li><a href="{% url tpackage build.id t.pk %}"> Packages for {{t.target}} </a> </li>
+  <li><a href="{% url "tpackage" build.id t.pk %}"> Packages for {{t.target}} </a> </li>
         {% endif %}
     {% endfor %}
-  <li><a href="{% url configuration build.id %}"> Configuration </a> </li>
+  <li><a href="{% url "configuration" build.id %}"> Configuration </a> </li>
 </ul>
      <h1>Toaster - Build {% block pagetitle %} {% endblock %}</h1>
 {% endblock %}
diff --git a/lib/toaster/bldviewer/templates/bpackage.html b/lib/toaster/bldviewer/templates/bpackage.html
index ca092ca..07d0792 100644
--- a/lib/toaster/bldviewer/templates/bpackage.html
+++ b/lib/toaster/bldviewer/templates/bpackage.html
@@ -21,9 +21,9 @@
             {% for package in packages %}
 
             <tr class="data">
-                <td><a name="#{{package.name}}" href="{% url bfile build.pk package.pk %}">{{package.name}} ({{package.filelist_bpackage.count}} files)</a></td>
+                <td><a name="#{{package.name}}" href="{% url "bfile" build.pk package.pk %}">{{package.name}} ({{package.filelist_bpackage.count}} files)</a></td>
                 <td>{{package.version}}-{{package.revision}}</td>
-                <td>{%if package.recipe%}<a href="{% url "layer_versions_recipes" package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a>{%endif%}</td>
+                <td><a href="{% url "layer_versions_recipes" package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
 
             <td>{{package.summary}}</td>
             <td>{{package.section}}</td>
diff --git a/lib/toaster/bldviewer/templates/build.html b/lib/toaster/bldviewer/templates/build.html
index 5f62350..5653cca 100644
--- a/lib/toaster/bldviewer/templates/build.html
+++ b/lib/toaster/bldviewer/templates/build.html
@@ -23,10 +23,10 @@
         </tr>
         {% for build in builds %}
         <tr class="data">
-            <td><a href="{% url configuration build.id %}">{{build.get_outcome_display}}</a></td>
+            <td><a href="{% url "configuration" build.id %}">{{build.get_outcome_display}}</a></td>
             <td>{{build.started_on}}</td>
             <td>{{build.completed_on}}</td>
-            <td>{% for t in build.target_set.all %}{%if t.is_image %}<a href="{% url tpackage build.id t.id %}">{% endif %}{{t.target}}{% if t.is_image %}</a>{% endif %}<br/>{% endfor %}</td>
+            <td>{% for t in build.target_set.all %}{%if t.is_image %}<a href="{% url "tpackage" build.id t.id %}">{% endif %}{{t.target}}{% if t.is_image %}</a>{% endif %}<br/>{% endfor %}</td>
             <td>{{build.machine}}</td>
             <td>{% time_difference build.started_on build.completed_on %}</td>
             <td>{{build.errors_no}}:{% if  build.errors_no %}{% for error in logs %}{% if error.build == build %}{% if error.level == 2 %}<p>{{error.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
diff --git a/lib/toaster/bldviewer/templates/layer.html b/lib/toaster/bldviewer/templates/layer.html
index fa4fd9b..c5034de 100644
--- a/lib/toaster/bldviewer/templates/layer.html
+++ b/lib/toaster/bldviewer/templates/layer.html
@@ -23,7 +23,7 @@
             <td><table>
             {% for lv in layer.versions %}
                 <tr><td>
-        <a href="{% url layer_versions_recipes lv.id %}">({{lv.priority}}){{lv.branch}}:{{lv.commit}} ({{lv.count}} recipes)</a>
+        <a href="{% url "layer_versions_recipes" lv.id %}">({{lv.priority}}){{lv.branch}}:{{lv.commit}} ({{lv.count}} recipes)</a>
                 </td></tr>
             {% endfor %}
             </table></td>
diff --git a/lib/toaster/bldviewer/templates/package.html b/lib/toaster/bldviewer/templates/package.html
index b1246e7..fda9dab 100644
--- a/lib/toaster/bldviewer/templates/package.html
+++ b/lib/toaster/bldviewer/templates/package.html
@@ -20,7 +20,7 @@
                 <td>{{package.version}}</td>
                 <td>{{package.size}}</td>
                 <td>{%if package.recipe %}<a name="{{package.recipe.name}}.{{package.package_name}}">
-                <a href="{% url layer_versions_recipes package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a>{%endif%}</td>
+                <a href="{% url "layer_versions_recipes" package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a>{%endif%}</td>
                 <td>
             <div style="height: 4em; overflow:auto">
                     {% for d in package.package_dependencies_source.all %}
diff --git a/lib/toaster/bldviewer/templates/task.html b/lib/toaster/bldviewer/templates/task.html
index e725369..5d9887e 100644
--- a/lib/toaster/bldviewer/templates/task.html
+++ b/lib/toaster/bldviewer/templates/task.html
@@ -28,7 +28,7 @@
             <tr class="data">
                 <td>{{task.order}}</td>
                 <td><a name="{{task.recipe.name}}.{{task.task_name}}">
-                <a href="{% url layer_versions_recipes task.recipe.layer_version_id %}#{{task.recipe.name}}">{{task.recipe.name}}</a>.{{task.task_name}}</a></td>
+                <a href="{% url "layer_versions_recipes" task.recipe.layer_version_id %}#{{task.recipe.name}}">{{task.recipe.name}}</a>.{{task.task_name}}</a></td>
                 <td>{{task.recipe.version}}</td>
 
                 {% if task.task_executed %}
diff --git a/lib/toaster/bldviewer/urls.py b/lib/toaster/bldviewer/urls.py
index becc679..b84c95f 100644
--- a/lib/toaster/bldviewer/urls.py
+++ b/lib/toaster/bldviewer/urls.py
@@ -17,7 +17,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.conf.urls import patterns, include, url
-from django.views.generic.simple import redirect_to
+from django.views.generic import RedirectView
 
 urlpatterns = patterns('bldviewer.views',
         url(r'^builds/$', 'build', name='all-builds'),
@@ -28,5 +28,5 @@ urlpatterns = patterns('bldviewer.views',
         url(r'^build/(?P<build_id>\d+)/configuration/$', 'configuration', name='configuration'),
         url(r'^layers/$', 'layer', name='all-layers'),
         url(r'^layerversions/(?P<layerversion_id>\d+)/recipes/.*$', 'layer_versions_recipes', name='layer_versions_recipes'),
-        url(r'^$', redirect_to, {'url': 'builds/'}),
+        url(r'^$', RedirectView.as_view( url= 'builds/')),
 )
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index d0606bc..a696a0b 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -17,7 +17,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.conf.urls import patterns, include, url
-from django.views.generic.simple import redirect_to
+from django.views.generic import RedirectView
 from django.views.decorators.cache import never_cache
 
 
@@ -29,7 +29,7 @@ urlpatterns = patterns('',
     url(r'^simple/', include('bldviewer.urls')),
     url(r'^api/1.0/', include('bldviewer.api')),
     url(r'^gui/', include('toastergui.urls')),
-    url(r'^$', never_cache(redirect_to), {'url': '/simple/'}),
+    url(r'^$', never_cache(RedirectView.as_view(url='/simple/'))),
     # Examples:
     # url(r'^toaster/', include('toaster.foo.urls')),
 
-- 
1.8.1.2


