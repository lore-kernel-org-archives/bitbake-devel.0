Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id B7B6E6CB0C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:06 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; 
	d="scan'208,217";a="400405670"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2013 09:53:05 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 8858A561064; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:37 +0100
Message-Id: <0032f0628390b22b0e6eb0d384d59ce1c6b5c404.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 08/94] bitbake: webhob: view a table with all builds
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:06 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch creates a page in Webhob in which you can view detailed
information about each executed build. There is data about the
outcome of each build, execution times, hardware usage, logs,
errors, warnings and others.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/__init__.py           |  0
 bitbake/lib/webhob/bldviewer/templates/build.html  | 54 ++++++++++++++++++++++
 .../lib/webhob/bldviewer/templatetags/__init__.py  |  0
 .../webhob/bldviewer/templatetags/projecttags.py   |  8 ++++
 bitbake/lib/webhob/bldviewer/urls.py               |  6 +++
 bitbake/lib/webhob/bldviewer/views.py              | 11 +++++
 bitbake/lib/webhob/whbmain/urls.py                 |  2 +-
 7 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/webhob/bldviewer/__init__.py
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/build.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templatetags/__init__.py
 create mode 100644 bitbake/lib/webhob/bldviewer/templatetags/projecttags.py
 create mode 100644 bitbake/lib/webhob/bldviewer/urls.py
 create mode 100644 bitbake/lib/webhob/bldviewer/views.py

diff --git a/bitbake/lib/webhob/bldviewer/__init__.py b/bitbake/lib/webhob/bldviewer/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
new file mode 100644
index 0000000..9a2d412
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -0,0 +1,54 @@
+<html>
+
+	<head>
+		<title>WebHob Build page</title>
+	</head>
+
+<body>
+	<h1>WebHob Builds</h1>
+
+	<table border="1">
+
+	{% load projecttags %}
+
+		<tr>
+			<th>Outcome</th>
+			<th>Started On</th>
+			<th>Completed On</th>
+			<th>Target</th>
+			<th>Machine</th>
+			<th>Time</th>
+			<th>Errors</th>
+			<th>Warnings</th>
+			<th>CPU usage</th>
+			<th>Disk I/O</th>
+			<th>Log</th>
+			<th>Bitbake Version</th>
+			<th>Build Name</th>
+		</tr>
+
+		{% for build in builds %}
+
+		<tr>
+			<td><a href="/build/{{build.id}}">{{build.get_outcome_display}}</a></td>
+			<td>{{build.started_on}}</td>
+			<td>{{build.completed_on}}</td>
+			<td>{{build.target}}</td>
+			<td>{{build.machine.name}}</td>
+			<td>{% time_difference build.started_on build.completed_on %}</td>
+			<td>{{build.errors_no}}</td>
+			<td>{{build.warnings_no}}</td>
+			<td>{{build.cpu_usage}}</td>
+			<td>{{build.disk_io}}</td>
+			<td>{{build.cooker_log_path}}</td>
+			<td>{{build.bitbake_version}}</td>
+			<td>{{build.build_name}}</td>
+		</tr>
+
+		{% endfor %}
+
+	</table>
+
+</body>
+
+</html>
diff --git a/bitbake/lib/webhob/bldviewer/templatetags/__init__.py b/bitbake/lib/webhob/bldviewer/templatetags/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/bldviewer/templatetags/projecttags.py b/bitbake/lib/webhob/bldviewer/templatetags/projecttags.py
new file mode 100644
index 0000000..9ae6214
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/templatetags/projecttags.py
@@ -0,0 +1,8 @@
+from datetime import datetime
+from django import template
+
+register = template.Library()
+
+@register.simple_tag
+def time_difference(start_time, end_time):
+    return end_time - start_time
diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
new file mode 100644
index 0000000..3ec2a30
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -0,0 +1,6 @@
+from django.conf.urls import patterns, include, url
+
+
+urlpatterns = patterns('bldviewer.views',
+        url(r'^$', 'build', name='build'),
+)
diff --git a/bitbake/lib/webhob/bldviewer/views.py b/bitbake/lib/webhob/bldviewer/views.py
new file mode 100644
index 0000000..15a2d1d
--- /dev/null
+++ b/bitbake/lib/webhob/bldviewer/views.py
@@ -0,0 +1,11 @@
+from django.shortcuts import render
+from orm.models import Build
+
+
+def build(request):
+    template = 'build.html'
+    build_info = Build.objects.all()
+
+    context = {'builds': build_info}
+
+    return render(request, template, context)
diff --git a/bitbake/lib/webhob/whbmain/urls.py b/bitbake/lib/webhob/whbmain/urls.py
index 04e0352..a15fc1b 100644
--- a/bitbake/lib/webhob/whbmain/urls.py
+++ b/bitbake/lib/webhob/whbmain/urls.py
@@ -5,8 +5,8 @@ from django.conf.urls import patterns, include, url
 # admin.autodiscover()
 
 urlpatterns = patterns('',
+    url(r'^build/$', include('bldviewer.urls')),
     # Examples:
-    # url(r'^$', 'webhob.views.home', name='home'),
     # url(r'^webhob/', include('webhob.foo.urls')),
 
     # Uncomment the admin/doc line below to enable admin documentation:
-- 
1.8.1.2


