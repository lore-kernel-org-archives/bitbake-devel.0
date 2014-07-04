Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id C77BB7018F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 12:44:29 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id n3so3881240wiv.14
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Jul 2014 05:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=P8BBnwjSsgk+6bmkx9uc6xbDmcDMj+i64CZ2E/8QpX0=;
	b=CBq64FOub6ZxT76vV3CUY0EcStDBJkUcDOyU94+O0cyHUi8O5lTdJ0Bn7Fs0wWPM/G
	zWGoMBNxF9WgTT9h1J/U/ZyPaaNhX8NeSwi14tDQlU896zZTFzELDF97HSoK/LqftJkn
	YdZsGRmLZom9kwicb9Dufcn+vdGHQ+x18JjBuGDm/zrvHYc7wnGv1HH/Vm3vmmyOVPnF
	6qhSTyY08AICkmBCP1yYrC7MT9EnpZi7UsWV6J8zen6cU+QU5f1J2d5MRnbETxl2yMUM
	55AjCMJrmFdgyJLdLBxk3qgervcaC7LKaXAW7Lq1S4cGXHBIEpNFK12lsypDTVSrNavq
	Tfdg==
X-Gm-Message-State: ALoCoQkGF8bXBSDIHIWA3P+jEsM5BxVmTPkvlcNtRG8lG/6jkqaMH5cHe6DyYq1ibRG4thgH+nUZ
X-Received: by 10.180.82.166 with SMTP id j6mr56035628wiy.71.1404477869275;
	Fri, 04 Jul 2014 05:44:29 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id bq7sm78903660wib.7.2014.07.04.05.44.26
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Jul 2014 05:44:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 1ECBA560609; Fri,  4 Jul 2014 13:44:27 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jul 2014 13:44:19 +0100
Message-Id: <4000d8224206f404d174a5bc4aa49af55cb44d27.1404477729.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404477729.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404477729.git.alexandru.damian@intel.com>
References: <cover.1404477729.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/9] toaster: automatically discover urls.py files
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
X-List-Received-Date: Fri, 04 Jul 2014 12:44:32 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Added code to automatically discover and add url dispatchers
to the urlpattern list. This allows extension of Toaster
through adding applications that will be automatically
registered with the URL dispatcher.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/urls.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index ede5e4f..0e7b5c2 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -27,12 +27,10 @@ from django.views.decorators.cache import never_cache
 # Uncomment the next two lines to enable the admin:
 # from django.contrib import admin
 # admin.autodiscover()
-
 urlpatterns = patterns('',
-    url(r'^simple/', include('bldviewer.urls')),
     url(r'^api/1.0/', include('bldviewer.api')),
-    url(r'^gui/', include('toastergui.urls')),
-    url(r'^$', never_cache(RedirectView.as_view(url='/gui/'))),
+    url(r'^$', never_cache(RedirectView.as_view(url='/toastergui/'))),
+
     # Examples:
     # url(r'^toaster/', include('toaster.foo.urls')),
 
@@ -42,3 +40,13 @@ urlpatterns = patterns('',
     # Uncomment the next line to enable the admin:
     # url(r'^admin/', include(admin.site.urls)),
 )
+
+# Automatically discover urls.py in various apps, beside our own
+# and map module directories to the patterns
+
+import os
+currentdir = os.path.dirname(__file__)
+for t in os.walk(os.path.dirname(currentdir)):
+    if "urls.py" in t[2] and t[0] != currentdir:
+        modulename = os.path.basename(t[0])
+        urlpatterns.append( url(r'^' + modulename + '/', include ( modulename + '.urls')))
-- 
1.9.1


