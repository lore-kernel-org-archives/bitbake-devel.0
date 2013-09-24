Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 650686CAF4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:08 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="400405702"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id AC910561263; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:50 +0100
Message-Id: <40ec5cb935911dba08b21d0db9acd1722d52dcdf.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Subject: [PATCH 21/94] bitbake: webhob: add layer information to the database
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:08 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch adds the layer information to the database. Using the
values stored in BBLAYERS it retrieves all the information needed
for the database fields.
It also includes a hardcoded mapping to deal with the URLs that
are different from the standard naming convention.
---
 bitbake/lib/bb/ui/buildinfohelper.py              | 45 +++++++++++++++++++++++
 bitbake/lib/webhob/bldviewer/templates/layer.html | 34 +++++++++++++++++
 bitbake/lib/webhob/bldviewer/urls.py              |  1 +
 bitbake/lib/webhob/bldviewer/views.py             | 10 ++++-
 4 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/layer.html

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index a0da2e1..2da38e2 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -336,6 +336,49 @@ class ORMWrapper(object):
 
         return layer_info
 
+    def _get_layer_dict(self, layer_path):
+
+        layer_info = {}
+        layer_name = layer_path.split('/')[-1]
+        layer_url = 'http://layers.openembedded.org/layerindex/layer/{layer}/'
+        layer_url_name = self._get_url_map_name(layer_name)
+
+        layer_info['name'] = layer_name
+        layer_info['local_path'] = layer_path
+        layer_info['layer_index_url'] = layer_url.format(layer=layer_url_name)
+
+        return layer_info
+
+    def _get_url_map_name(self, layer_name):
+        """ Some layers have a different name on openembedded.org site,
+            this method returns the correct name to use in the URL
+        """
+
+        url_name = layer_name
+        url_mapping = {'meta': 'openembedded-core'}
+
+        for key in url_mapping.keys():
+            if key == layer_name:
+                url_name = url_mapping[key]
+
+        return url_name
+
+    def _save_layer_object(self, layer_path):
+
+        layer_information = self._get_layer_dict(layer_path)
+
+        layer_object = Layer.objects.get_or_create(
+                            name=layer_information['name'],
+                            local_path=layer_information['local_path'],
+                            layer_index_url=layer_information['layer_index_url'])
+
+        layer_object[0].save()
+
+    def store_layer_info(self):
+        layers = self.server.runCommand(["getVariable", "BBLAYERS"])[0].strip().split(" ")
+        for layer_path in layers:
+            self._save_layer_object(layer_path)
+
 
 class BuildInfoHelper(object):
     """ This class gathers the build information from the server and sends it
@@ -352,6 +395,8 @@ class BuildInfoHelper(object):
 
     def store_started_build(self, event):
 
+        self.orm_wrapper.store_layer_info()
+
         machine_information = self.orm_wrapper.get_machine_information()
         machine_obj = self.orm_wrapper.create_machine_object(machine_information)
 
diff --git a/bitbake/lib/webhob/bldviewer/templates/layer.html b/bitbake/lib/webhob/bldviewer/templates/layer.html
new file mode 100644
index 0000000..905a781
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/layer.html
@@ -0,0 +1,34 @@
+<html>
+
+	<head>
+		<title>WebHob Layer page</title>
+	</head>
+
+<body>
+	<h1>WebHob Layers</h1>
+
+	<table border="1">
+
+	{% load projecttags %}
+
+		<tr>
+			<th>Name</th>
+			<th>Local Path</th>
+			<th>Layer Index URL</th>
+		</tr>
+
+		{% for layer in layers %}
+
+		<tr>
+			<td>{{layer.name}}</td>
+			<td>{{layer.local_path}}</td>
+			<td><a href='{{layer.layer_index_url}}'>{{layer.layer_index_url}}</a></td>
+		</tr>
+
+		{% endfor %}
+
+	</table>
+
+</body>
+
+</html>
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
index 335885c..8d5dc6e 100644
--- a/bitbake/lib/webhob/bldviewer/urls.py
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -3,5 +3,6 @@ from django.conf.urls import patterns, include, url
 
 urlpatterns = patterns('bldviewer.views',
         url(r'^$', 'build', name='build'),
+        url(r'^layers/$', 'layer', name='layer'),
         url(r'^(?P<build_id>\d+)/$', 'task', name='task'),
 )
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
index 292a638..f40d396 100644
--- a/bitbake/lib/webhob/bldviewer/views.py
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -1,5 +1,5 @@
 from django.shortcuts import render
-from orm.models import Build, Task
+from orm.models import Build, Task, Layer
 
 
 def build(request):
@@ -18,3 +18,11 @@ def task(request, build_id):
     context = {'tasks': tasks}
 
     return render(request, template, context)
+
+def layer(request):
+    template = 'layer.html'
+    layer_info = Layer.objects.all()
+
+    context = {'layers': layer_info}
+
+    return render(request, template, context)
-- 
1.8.1.2


