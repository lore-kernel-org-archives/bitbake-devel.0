Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 0E3476CC68
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:30 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511876"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id CFE18561B94; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:04 +0100
Message-Id: <618a4ca399aa451cba8cf8ab19a7967ef2dd2976.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 35/94] bitbake: webhob: clean up URL structure
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:30 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We clean up the URL structure.
* default redirect to GUI version
* basic HTML interface now available at /simple/
* clear-up simple/ paths towards object-type URLs

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/urls.py | 6 ++++--
 bitbake/lib/webhob/whbmain/urls.py   | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/webhob/bldviewer/urls.py b/bitbake/lib/webhob/bldviewer/urls.py
index 8d5dc6e..756b3fa 100644
--- a/bitbake/lib/webhob/bldviewer/urls.py
+++ b/bitbake/lib/webhob/bldviewer/urls.py
@@ -1,8 +1,10 @@
 from django.conf.urls import patterns, include, url
+from django.views.generic.simple import redirect_to
 
 
 urlpatterns = patterns('bldviewer.views',
-        url(r'^$', 'build', name='build'),
+        url(r'^build/$', 'build', name='build'),
         url(r'^layers/$', 'layer', name='layer'),
-        url(r'^(?P<build_id>\d+)/$', 'task', name='task'),
+        url(r'^build/(?P<build_id>\d+)/task/$', 'task', name='task'),
+        url(r'^$', redirect_to, {'url': 'build/'}),
 )
diff --git a/bitbake/lib/webhob/whbmain/urls.py b/bitbake/lib/webhob/whbmain/urls.py
index 14345f6..0e15eda 100644
--- a/bitbake/lib/webhob/whbmain/urls.py
+++ b/bitbake/lib/webhob/whbmain/urls.py
@@ -1,13 +1,16 @@
 from django.conf.urls import patterns, include, url
+from django.views.generic.simple import redirect_to
+
 
 # Uncomment the next two lines to enable the admin:
 # from django.contrib import admin
 # admin.autodiscover()
 
 urlpatterns = patterns('',
-    url(r'^build/', include('bldviewer.urls')),
+    url(r'^simple/', include('bldviewer.urls')),
     url(r'^api/1.0/', include('bldviewer.api')),
     url(r'^gui/', include('whbgui.urls')),
+    url(r'^$', redirect_to, {'url': '/gui/'}),
     # Examples:
     # url(r'^webhob/', include('webhob.foo.urls')),
 
-- 
1.8.1.2


