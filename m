Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 5D10B70474
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 16:55:27 +0000 (UTC)
Received: by mail-wg0-f49.google.com with SMTP id a1so4435781wgh.32
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 09:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=P8BBnwjSsgk+6bmkx9uc6xbDmcDMj+i64CZ2E/8QpX0=;
	b=NfdcABC8WFEAQ7sMZkTWNmSyY5OLq2pvQ3aBoew+cdvPa9CdMqo0EZXYN1ynkPNJKg
	kIkiXNZkU0O6iFyXz3u3IfhYUYAvDYbBg5AX0nJGPhVvcejygwaZDev/7ZWfCvPZcWdT
	Bq2Hi8m2xdxSzj0a7F9BannYKNSW6VoHQAdkCu5pxeYXZIEvf7fIStMpHKDjYHvlh2jp
	pDXOMmqISF+vvlDIcKPR5wzWNrwQBIbPTG4DxvZX+wr1/IfPsOBMHZqmswAVIP+dgDyf
	gIf4hUNmSsyAPkx2OS3qxxuweNc3hqXxhbR3D75MIFlw845mL+uaa/LcQ6GlUxnTuLy/
	Bw7Q==
X-Gm-Message-State: ALoCoQn1PTt2SwiRcgHSBPBU1F6u7phbXqJZ4spnRt6/3iZXdzoXM8y4+OvUagJRqcpoxtgaewf8
X-Received: by 10.180.108.1 with SMTP id hg1mr2175270wib.25.1404924928476;
	Wed, 09 Jul 2014 09:55:28 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	cz4sm21284063wib.23.2014.07.09.09.55.27 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Jul 2014 09:55:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8FA1C56031A; Wed,  9 Jul 2014 17:55:26 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Jul 2014 17:55:18 +0100
Message-Id: <4000d8224206f404d174a5bc4aa49af55cb44d27.1404924714.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404924713.git.alexandru.damian@intel.com>
References: <cover.1404924713.git.alexandru.damian@intel.com>
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
X-List-Received-Date: Wed, 09 Jul 2014 16:55:29 -0000

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


