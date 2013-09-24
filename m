Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 462AC6CAF3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:07 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="408442558"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:08 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id B19A656130B; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:52 +0100
Message-Id: <a3f76edc0546f1ec6d0c14e8fece7521f46cd276.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 23/94] bitbake: webhob: create basic structure for static files
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:07 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch creates the basic structure for the front end
files needed by Webhob. It sets up a new application called
whbgui which will host all the static files we need.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/whbgui/__init__.py             |   0
 bitbake/lib/webhob/whbgui/static/images/yocto.jpg | Bin 0 -> 6582 bytes
 bitbake/lib/webhob/whbgui/templates/index.html    |  13 +++++++++++++
 bitbake/lib/webhob/whbgui/tests.py                |  16 ++++++++++++++++
 bitbake/lib/webhob/whbgui/urls.py                 |   9 +++++++++
 bitbake/lib/webhob/whbgui/views.py                |   8 ++++++++
 bitbake/lib/webhob/whbmain/settings.py            |   3 ++-
 bitbake/lib/webhob/whbmain/urls.py                |   1 +
 8 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/webhob/whbgui/__init__.py
 create mode 100644 bitbake/lib/webhob/whbgui/static/images/yocto.jpg
 create mode 100644 bitbake/lib/webhob/whbgui/templates/index.html
 create mode 100644 bitbake/lib/webhob/whbgui/tests.py
 create mode 100644 bitbake/lib/webhob/whbgui/urls.py
 create mode 100644 bitbake/lib/webhob/whbgui/views.py

diff --git a/bitbake/lib/webhob/whbgui/__init__.py b/bitbake/lib/webhob/whbgui/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/whbgui/static/images/yocto.jpg b/bitbake/lib/webhob/whbgui/static/images/yocto.jpg
new file mode 100644
index 0000000000000000000000000000000000000000..5de4b7693aa330bb8220baa81567bf82c307a8ab
GIT binary patch
literal 6582
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
aOU31^K>#@}(ZTG-?Z2-R|4z5g$NmTTvPqNx

literal 0
HcmV?d00001

diff --git a/bitbake/lib/webhob/whbgui/templates/index.html b/bitbake/lib/webhob/whbgui/templates/index.html
new file mode 100644
index 0000000..80b02d9
--- /dev/null
+++ b/bitbake/lib/webhob/whbgui/templates/index.html
@@ -0,0 +1,13 @@
+<html>
+<head>
+	<title>GUI Page</title>
+</head>
+<body>
+{% load staticfiles %}
+
+<img src="{% static "/static/images/yocto.jpg" %}" alt="Yocto"/>
+
+This is your basic index page!
+</body>
+
+</html>
\ No newline at end of file
diff --git a/bitbake/lib/webhob/whbgui/tests.py b/bitbake/lib/webhob/whbgui/tests.py
new file mode 100644
index 0000000..501deb7
--- /dev/null
+++ b/bitbake/lib/webhob/whbgui/tests.py
@@ -0,0 +1,16 @@
+"""
+This file demonstrates writing tests using the unittest module. These will pass
+when you run "manage.py test".
+
+Replace this with more appropriate tests for your application.
+"""
+
+from django.test import TestCase
+
+
+class SimpleTest(TestCase):
+    def test_basic_addition(self):
+        """
+        Tests that 1 + 1 always equals 2.
+        """
+        self.assertEqual(1 + 1, 2)
diff --git a/bitbake/lib/webhob/whbgui/urls.py b/bitbake/lib/webhob/whbgui/urls.py
new file mode 100644
index 0000000..321955a
--- /dev/null
+++ b/bitbake/lib/webhob/whbgui/urls.py
@@ -0,0 +1,9 @@
+import os
+
+from django.conf import settings
+from django.conf.urls import patterns, include, url
+
+
+urlpatterns = patterns('whbgui.views',
+        url(r'^$', 'guihome', name='guihome'),
+)
diff --git a/bitbake/lib/webhob/whbgui/views.py b/bitbake/lib/webhob/whbgui/views.py
new file mode 100644
index 0000000..e53a776
--- /dev/null
+++ b/bitbake/lib/webhob/whbgui/views.py
@@ -0,0 +1,8 @@
+from django.shortcuts import render
+from orm.models import Build, Task
+
+
+def guihome(request):
+    template = 'index.html'
+
+    return render(request, template)
diff --git a/bitbake/lib/webhob/whbmain/settings.py b/bitbake/lib/webhob/whbmain/settings.py
index aa1d4fc..d470328 100644
--- a/bitbake/lib/webhob/whbmain/settings.py
+++ b/bitbake/lib/webhob/whbmain/settings.py
@@ -128,7 +128,7 @@ INSTALLED_APPS = (
     #'django.contrib.sessions',
     #'django.contrib.sites',
     #'django.contrib.messages',
-    #'django.contrib.staticfiles',
+    'django.contrib.staticfiles',
     # Uncomment the next line to enable the admin:
     # 'django.contrib.admin',
     # Uncomment the next line to enable admin documentation:
@@ -136,6 +136,7 @@ INSTALLED_APPS = (
     'orm',
     'whbmain',
     'bldviewer',
+    'whbgui',
 )
 
 # A sample logging configuration. The only tangible logging
diff --git a/bitbake/lib/webhob/whbmain/urls.py b/bitbake/lib/webhob/whbmain/urls.py
index c40e7c7..af536aa 100644
--- a/bitbake/lib/webhob/whbmain/urls.py
+++ b/bitbake/lib/webhob/whbmain/urls.py
@@ -6,6 +6,7 @@ from django.conf.urls import patterns, include, url
 
 urlpatterns = patterns('',
     url(r'^build/', include('bldviewer.urls')),
+    url(r'^gui/', include('whbgui.urls')),
     # Examples:
     # url(r'^webhob/', include('webhob.foo.urls')),
 
-- 
1.8.1.2


