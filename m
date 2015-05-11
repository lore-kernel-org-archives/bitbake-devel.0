Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 2989773FD4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 11:00:45 +0000 (UTC)
Received: by wizk4 with SMTP id k4so100553632wiz.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 04:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=+/voXZu/WfsNgefP3+BqJLaMEk8HZSpYiC+C+1Vn2xA=;
	b=XKEa2W08JugZO1R1C78wfzqnHBDwHf0EuHvJEQC7o+1U9E4WsZg4TLuz+cVqh9ceMT
	d0uBNj+E1yehsmgOKe6d49M1LMcVOZJ5QGZS9bVGEhUUmglohgqXbtsM3nneq4cC9q1g
	Q6ZrS209MBs9omPWy8IHmNzmevc62AbQpXAY7GRHlbDIOJQtF/37NuoD7jLmKQgTChnY
	u1O6fo90CbpRGW5pWO5X3xa0HEcfeL3t+NjPS538zKryOYPPJwnvLsWwFWu2FYsQv/Io
	7juq9LenGV/G7L/qyQXrhgLf3iLGV2i9AVX8PDCmwzOtbp8NKBZ2gfKbZa8DMyrOHKK8
	gpmw==
X-Gm-Message-State: ALoCoQnhvZGxxs40B1aklYc9Jy5YsZeM1wp6OXCIKBrZ5GEY4PafOiUPTtlSFeC/OyOM8ViwkrUO
X-Received: by 10.194.77.44 with SMTP id p12mr19530882wjw.1.1431342046669;
	Mon, 11 May 2015 04:00:46 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dg8sm22274109wjc.9.2015.05.11.04.00.45
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 04:00:45 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 01749560762; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:42 +0100
Message-Id: <33b1921789e2baade20f17aa003c129f3aca635a.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Subject: [PATCH 11/11] toastergui: removing unused views
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
X-List-Received-Date: Mon, 11 May 2015 11:00:47 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We remove url entries, views and templates that are not
used in the interface; these are leftovers from the development
process, and are not linked anywhere in the interface nor
mentioned in documentation.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/layer.html   | 34 -------------------------
 lib/toaster/toastergui/templates/package.html | 36 ---------------------------
 lib/toaster/toastergui/urls.py                |  5 ----
 lib/toaster/toastergui/views.py               | 29 ---------------------
 4 files changed, 104 deletions(-)
 delete mode 100644 lib/toaster/toastergui/templates/layer.html
 delete mode 100644 lib/toaster/toastergui/templates/package.html

diff --git a/lib/toaster/toastergui/templates/layer.html b/lib/toaster/toastergui/templates/layer.html
deleted file mode 100644
index 410d766..0000000
--- a/lib/toaster/toastergui/templates/layer.html
+++ /dev/null
@@ -1,34 +0,0 @@
-{% extends "basetable.html" %}
-
-{% block pagename %}
-    <h1>Toaster - Layers</h1>
-{% endblock %}
-
-{% block pagetable %}
-    {% load projecttags %}
-
-        <tr>
-            <th>Name</th>
-            <th>Local Path</th>
-            <th>Layer Index URL</th>
-            <th>Known Versions</th>
-        </tr>
-
-        {% for layer in objects %}
-
-        <tr class="data">
-            <td>{{layer.name}}</td>
-            <td>{{layer.local_path}}</td>
-            <td><a href='{{layer.layer_index_url}}'>{{layer.layer_index_url}}</a></td>
-            <td><table>
-            {% for lv in layer.versions %}
-                <tr><td>
-        <a href="{% url "layer_versions_recipes" lv.id %}">({{lv.priority}}){{lv.branch}}:{{lv.commit}} ({{lv.count}} recipes)</a>
-                </td></tr>
-            {% endfor %}
-            </table></td>
-        </tr>
-
-        {% endfor %}
-
-{% endblock %}
diff --git a/lib/toaster/toastergui/templates/package.html b/lib/toaster/toastergui/templates/package.html
deleted file mode 100644
index 1ba3726..0000000
--- a/lib/toaster/toastergui/templates/package.html
+++ /dev/null
@@ -1,36 +0,0 @@
-{% extends "basebuildpage.html" %}
-
-{% block pagetable %}
-    {% if not objects %}
-        <p>No packages were recorded for this target!</p>
-    {% else %}
-
-            <tr>
-            <th>Name</th>
-            <th>Version</th>
-            <th>Size (Bytes)</th>
-            <th>Recipe</th>
-            <th>Depends on</th>
-            </tr>
-
-            {% for package in objects %}
-
-            <tr class="data">
-                <td><a name="#{{package.name}}">{{package.name}}</a></td>
-                <td>{{package.version}}</td>
-                <td>{{package.size}}</td>
-                <td>{%if package.recipe %}<a name="{{package.recipe.name}}.{{package.package_name}}">
-                <a href="{% url "layer_versions_recipes" package.recipe.layer_version_id %}#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a>{%endif%}</td>
-                <td>
-            <div style="height: 4em; overflow:auto">
-                    {% for d in package.package_dependencies_source.all %}
-                    <a href="#{{d.name}}">{{d.depends_on.name}}</a><br/>
-                    {% endfor %}
-            </div>
-                </td>
-
-            {% endfor %}
-
-    {% endif %}
-
-{% endblock %}
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 52fc0cc..de8c62c 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -56,7 +56,6 @@ urlpatterns = patterns('toastergui.views',
         url(r'^dentries/build/(?P<build_id>\d+)/target/(?P<target_id>\d+)$', 'dirinfo_ajax', name='dirinfo_ajax'),
         url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/dirinfo$', 'dirinfo', name='dirinfo'),
         url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/dirinfo_filepath/_(?P<file_path>(?:/[^/\n]+)*)$', 'dirinfo', name='dirinfo_filepath'),
-        url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/packages$', 'tpackage', name='targetpackages'),
         url(r'^build/(?P<build_id>\d+)/configuration$', 'configuration', name='configuration'),
         url(r'^build/(?P<build_id>\d+)/configvars$', 'configvars', name='configvars'),
         url(r'^build/(?P<build_id>\d+)/buildtime$', 'buildtime', name='buildtime'),
@@ -67,13 +66,9 @@ urlpatterns = patterns('toastergui.views',
         url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/packagefile/(?P<packagefile_id>\d+)$',
              'image_information_dir', name='image_information_dir'),
 
-
         # build download artifact
         url(r'^build/(?P<build_id>\d+)/artifact/(?P<artifact_type>\w+)/id/(?P<artifact_id>\w+)', 'build_artifact', name="build_artifact"),
 
-        # urls not linked from the dashboard
-        url(r'^layerversions/(?P<layerversion_id>\d+)/recipes/.*$', 'layer_versions_recipes', name='layer_versions_recipes'),
-
         # project URLs
         url(r'^newproject/$', 'newproject', name='newproject'),
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 23025a2..d938fd8 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1479,35 +1479,6 @@ def bfile(request, build_id, package_id):
     context = {'build': Build.objects.get(pk=build_id), 'objects' : files}
     return render(request, template, context)
 
-def tpackage(request, build_id, target_id):
-    template = 'package.html'
-    packages = map(lambda x: x.package, list(Target_Installed_Package.objects.filter(target=target_id)))
-    context = {'build': Build.objects.get(pk=build_id), 'objects' : packages}
-    return render(request, template, context)
-
-def layer(request):
-    template = 'layer.html'
-    layer_info = Layer.objects.all()
-
-    for li in layer_info:
-        li.versions = Layer_Version.objects.filter(layer = li)
-        for liv in li.versions:
-            liv.count = Recipe.objects.filter(layer_version__id = liv.id).count()
-
-    context = {'objects': layer_info}
-
-    return render(request, template, context)
-
-
-def layer_versions_recipes(request, layerversion_id):
-    template = 'recipe.html'
-    recipes = Recipe.objects.filter(layer_version__id = layerversion_id)
-
-    context = {'objects': recipes,
-            'layer_version' : Layer_Version.objects.get( id = layerversion_id )
-    }
-
-    return render(request, template, context)
 
 # A set of dependency types valid for both included and built package views
 OTHER_DEPENDS_BASE = [
-- 
1.9.1


