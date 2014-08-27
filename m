Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id 3C0E36FE3B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:49 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id q58so552973wes.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=5/KTQvyWhEwB9FeiRwtpydplMHC0fitxKZ9zodnzA2s=;
	b=ABsD7LcpvePJqn6cqq1AhfrlP9JHimEsQX350icor1N071HlLlYVDCjMe9QzobdFFu
	2w8KkM46sLASQHkUeGzOk4diw3Wz4E+3RbZpUMEiUOdfhXHLUFIvdZAkqN5WH53AKKUd
	lFJNkB44kHdMUL5inrr2FrKmly7DR4RwIyu1HAbs/MO+FqPSMltaNocMti6xkw19+UlS
	qMOMzAAiti/O43CKdiWlEFkkzFhYiphtpu+fFunh6WG4GiZPmRsqhOQmvbJR6n7v+kW+
	N8CiFD/FIphyXX4zI2XMMWbNvRLqe0BBwJA7wVFVanN0DXT0dyHkhgXxDFvwSleMvkPW
	XUYQ==
X-Gm-Message-State: ALoCoQko77+1nC9CakSzDyFSwuDTv8+YvL3es568s3s3SRvIZGExC/Tzhs6ABRHdT668QinDSIvi
X-Received: by 10.194.82.106 with SMTP id h10mr37371898wjy.37.1409160229311;
	Wed, 27 Aug 2014 10:23:49 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id pm6sm2606955wjb.36.2014.08.27.10.23.46
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:48 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 5F6355610B2; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:36 +0100
Message-Id: <af9b773766a65abd621606c2357835b8e146c4aa.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 04/11] toaster: enable admin interface on select models
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:51 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We enable the admin interface in Toaster.

We add admin models for Build Environments (where the
sysadmin can configure where the builds take place)
and for Layer Sources (marking the upstream provider
for layer information).

The admin interface and associated data are enabled
only for the MANAGED version.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/admin.py     |  8 ++++++++
 lib/toaster/orm/admin.py            | 17 +++++++++++++++++
 lib/toaster/toastermain/settings.py | 10 +++++-----
 lib/toaster/toastermain/urls.py     | 18 +++++++++++++-----
 4 files changed, 43 insertions(+), 10 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/admin.py
 create mode 100644 lib/toaster/orm/admin.py

diff --git a/lib/toaster/bldcontrol/admin.py b/lib/toaster/bldcontrol/admin.py
new file mode 100644
index 0000000..fcbe5f5
--- /dev/null
+++ b/lib/toaster/bldcontrol/admin.py
@@ -0,0 +1,8 @@
+from django.contrib import admin
+from django.contrib.admin.filters import RelatedFieldListFilter
+from .models import BuildEnvironment
+
+class BuildEnvironmentAdmin(admin.ModelAdmin):
+    pass
+
+admin.site.register(BuildEnvironment, BuildEnvironmentAdmin)
diff --git a/lib/toaster/orm/admin.py b/lib/toaster/orm/admin.py
new file mode 100644
index 0000000..9383630
--- /dev/null
+++ b/lib/toaster/orm/admin.py
@@ -0,0 +1,17 @@
+from django.contrib import admin
+from django.contrib.admin.filters import RelatedFieldListFilter
+from .models import Branch, LayerSource, ToasterSetting
+
+class LayerSourceAdmin(admin.ModelAdmin):
+    pass
+
+class BranchAdmin(admin.ModelAdmin):
+    pass
+
+class ToasterSettingAdmin(admin.ModelAdmin):
+    pass
+
+admin.site.register(LayerSource, LayerSourceAdmin)
+admin.site.register(Branch, BranchAdmin)
+admin.site.register(ToasterSetting, ToasterSettingAdmin)
+
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 1dab25a..42581f2 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -232,17 +232,13 @@ TEMPLATE_CONTEXT_PROCESSORS = ('django.contrib.auth.context_processors.auth',
 
 INSTALLED_APPS = (
     #'django.contrib.sites',
-    #'django.contrib.messages',
     'django.contrib.staticfiles',
-    # Uncomment the next line to enable the admin:
-    # 'django.contrib.admin',
     # Uncomment the next line to enable admin documentation:
     # 'django.contrib.admindocs',
     'django.contrib.humanize',
     'orm',
     'toastermain',
     'south',
-    'bldcontrol',
 )
 
 SOUTH_TESTS_MIGRATE = False
@@ -251,7 +247,11 @@ SOUTH_TESTS_MIGRATE = False
 if MANAGED:
     INSTALLED_APPS = ('django.contrib.auth',
     'django.contrib.contenttypes',
-    'django.contrib.sessions',) + INSTALLED_APPS
+    'django.contrib.messages',
+    'django.contrib.sessions',
+    # Uncomment the next line to enable the admin:
+    'django.contrib.admin',
+        ) + INSTALLED_APPS
 
 
 # We automatically detect and install applications here if
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 0e7b5c2..1ae6245 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -25,11 +25,12 @@ from django.views.decorators.cache import never_cache
 
 
 # Uncomment the next two lines to enable the admin:
-# from django.contrib import admin
-# admin.autodiscover()
+from django.contrib import admin
+admin.autodiscover()
+
 urlpatterns = patterns('',
+    # the api-s are not auto-discoverable
     url(r'^api/1.0/', include('bldviewer.api')),
-    url(r'^$', never_cache(RedirectView.as_view(url='/toastergui/'))),
 
     # Examples:
     # url(r'^toaster/', include('toaster.foo.urls')),
@@ -37,10 +38,17 @@ urlpatterns = patterns('',
     # Uncomment the admin/doc line below to enable admin documentation:
     # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
 
-    # Uncomment the next line to enable the admin:
-    # url(r'^admin/', include(admin.site.urls)),
+
+    # if no application is selected, we have the magic toastergui app here
+    url(r'^$', never_cache(RedirectView.as_view(url='/toastergui/'))),
 )
 
+import toastermain.settings
+if toastermain.settings.MANAGED:
+    urlpatterns = urlpatterns + [
+        # Uncomment the next line to enable the admin:
+        url(r'^admin/', include(admin.site.urls)),
+    ]
 # Automatically discover urls.py in various apps, beside our own
 # and map module directories to the patterns
 
-- 
1.9.1


