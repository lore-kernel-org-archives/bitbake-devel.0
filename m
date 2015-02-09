Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id EFADC732A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:04 +0000 (UTC)
Received: by mail-pa0-f42.google.com with SMTP id bj1so35362908pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=oYfewramIP33V3GO28DUrdoypziByHllohIzFgPFFS0=;
	b=f4EjvUI6M18s/p/SfnFbHY+9TPqxXkN2zsaWdaOQUzlLaY4I9kfJ1ZvqVBCzp8vPmv
	LkJqLkqIzyfVpKTE4qvj5gEMeSKj8eZGvCPlC+1v3JlVf637iaj7hXllTYb1cgOwwIsy
	EcZ0mTGhprKOa4RX0JWTlO0YM2WK7ruK1EAnaNRyByH5J8nQ87vDpZKl/4ltxgQhrGeq
	O0769kkmPyRPGYV6v9pFKb76uG/Kvw09BAVNbi957Cv0Xo6u26d0MXDiHqJSdKn8l++2
	TyWwGsdOjscquUeGwvjOaNdMx4r+OWv6auKN3BekD++z5NP88FNegLgfGkc06fKL0flC
	WpQg==
X-Gm-Message-State: ALoCoQkHBC2Z1sRB4GxdsXYbszKka/Q80dqJC6bFHMGp4vHrofSLR0Rw8gtwtWW5DwxXuUXWQFLY
X-Received: by 10.70.55.105 with SMTP id r9mr31330085pdp.147.1423504925914;
	Mon, 09 Feb 2015 10:02:05 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	oc17sm7777674pdb.56.2015.02.09.10.02.03
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:03 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4D51D56619A; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:35 +0000
Message-Id: <00496fb67fa341477edbf80c5438f0b069871ac6.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 05/27] toaster: enable server-side caches and debug-panel
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch enables the server-side caches for Django using
file cache in /tmp/ directory.

Patch enables django debug panel if available.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastermain/settings.py | 41 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index acc20cc..7cf9052 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -211,10 +211,25 @@ MIDDLEWARE_CLASSES = (
     'django.middleware.csrf.CsrfViewMiddleware',
     'django.contrib.auth.middleware.AuthenticationMiddleware',
     'django.contrib.messages.middleware.MessageMiddleware',
+    'django.middleware.cache.UpdateCacheMiddleware',
+    'django.middleware.cache.FetchFromCacheMiddleware',
     # Uncomment the next line for simple clickjacking protection:
     # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
 )
 
+CACHES = {
+    #        'default': {
+    #            'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
+    #            'LOCATION': '127.0.0.1:11211',
+    #        },
+           'default': {
+               'BACKEND': 'django.core.cache.backends.filebased.FileBasedCache',
+               'LOCATION': '/tmp/django-default-cache',
+               'TIMEOUT': 5,
+            }
+          }
+
+
 from os.path import dirname as DN
 SITE_ROOT=DN(DN(os.path.abspath(__file__)))
 
@@ -252,17 +267,41 @@ INSTALLED_APPS = (
 )
 
 
+INTERNAL_IPS = ['127.0.0.1', '192.168.2.28']
+
 # Load django-fresh is TOASTER_DEVEL is set, and the module is available
 FRESH_ENABLED = False
 if os.environ.get('TOASTER_DEVEL', None) is not None:
     try:
         import fresh
-        MIDDLEWARE_CLASSES = MIDDLEWARE_CLASSES + ("fresh.middleware.FreshMiddleware",)
+        MIDDLEWARE_CLASSES = ("fresh.middleware.FreshMiddleware",) + MIDDLEWARE_CLASSES
         INSTALLED_APPS = INSTALLED_APPS + ('fresh',)
         FRESH_ENABLED = True
     except:
         pass
 
+DEBUG_PANEL_ENABLED = False
+if os.environ.get('TOASTER_DEVEL', None) is not None:
+    try:
+        import debug_toolbar, debug_panel
+        MIDDLEWARE_CLASSES = ('debug_panel.middleware.DebugPanelMiddleware',) + MIDDLEWARE_CLASSES
+        #MIDDLEWARE_CLASSES = MIDDLEWARE_CLASSES + ('debug_toolbar.middleware.DebugToolbarMiddleware',)
+        INSTALLED_APPS = INSTALLED_APPS + ('debug_toolbar','debug_panel',)
+        DEBUG_PANEL_ENABLED = True
+
+        # this cache backend will be used by django-debug-panel
+        CACHES['debug-panel'] = {
+                'BACKEND': 'django.core.cache.backends.filebased.FileBasedCache',
+                'LOCATION': '/var/tmp/debug-panel-cache',
+                'TIMEOUT': 300,
+                'OPTIONS': {
+                    'MAX_ENTRIES': 200
+                }
+        }
+
+    except:
+        pass
+
 
 SOUTH_TESTS_MIGRATE = False
 
-- 
1.9.1


