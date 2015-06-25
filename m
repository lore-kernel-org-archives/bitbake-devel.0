Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id A210C758E8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:35:18 +0000 (UTC)
Received: by wgbhy7 with SMTP id hy7so58690659wgb.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=kwz+TZDHa7Udqi7SkZ8KnWSreV39Jv7qdkPEHSbr1H0=;
	b=Fqoc6Y48nwgNmHraTEOhNip0T0D6vK4osFOU6DC6aD116Rpczy9/2CxSXfZXOTJO4L
	8FaMqkzLguwXvI73eG5RQ1VUxVvl4QitDfsj2b3NTljmfrjf2jeFkdXCjZThfhDW3w2f
	TnaMop9cVZx3jNi6ZtJ8m5S0qK+kpN5V3uId2KvHJMOrHw+dT2ynQOK3lPOn9aeo8rST
	56Ja1+5rgD5Ay9NLg/n0IbxEqwzjj4TKF+3C2UBA/Kg7JIeGPRbuaIoWoU8xWfS+GQ+U
	a8uCrsriWcrOihEX7S8t8l7E4TAFkazZo71wivK7OIJQlzVgAO3fIpugG+f3hJqrOD+z
	Q4rw==
X-Gm-Message-State: ALoCoQm2tCoyyzV7be8/50Wmoy3rgj05JUYbQDTSBEXWaL8cOHSXSZ3Vi/IH0x9pSBaaBwigAhv6
X-Received: by 10.194.60.131 with SMTP id h3mr78901314wjr.156.1435228519345;
	Thu, 25 Jun 2015 03:35:19 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ym2sm45166716wjc.44.2015.06.25.03.35.18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:35:18 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E9142562DE0; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:59 +0100
Message-Id: <8ca10764ffd6cfec12cbfeabf240d81213a07845.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 22/23] toaster: split orm app into it's own module and app
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
X-List-Received-Date: Thu, 25 Jun 2015 10:35:19 -0000

From: Michael Wood <michael.g.wood@intel.com>

The orm application was also the django application to collect the build
information. Splitting this module up into it's functional parts. orm
for the data module and bldcollector for build collection data.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcollector/__init__.py       | 0
 lib/toaster/{orm => bldcollector}/admin.py | 3 +--
 lib/toaster/{orm => bldcollector}/urls.py  | 3 +--
 lib/toaster/{orm => bldcollector}/views.py | 0
 lib/toaster/toastermain/settings.py        | 2 +-
 5 files changed, 3 insertions(+), 5 deletions(-)
 create mode 100644 lib/toaster/bldcollector/__init__.py
 rename lib/toaster/{orm => bldcollector}/admin.py (92%)
 rename lib/toaster/{orm => bldcollector}/urls.py (95%)
 rename lib/toaster/{orm => bldcollector}/views.py (100%)

diff --git a/lib/toaster/bldcollector/__init__.py b/lib/toaster/bldcollector/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/orm/admin.py b/lib/toaster/bldcollector/admin.py
similarity index 92%
rename from lib/toaster/orm/admin.py
rename to lib/toaster/bldcollector/admin.py
index 706e517..c1f85d7 100644
--- a/lib/toaster/orm/admin.py
+++ b/lib/toaster/bldcollector/admin.py
@@ -1,6 +1,6 @@
 from django.contrib import admin
 from django.contrib.admin.filters import RelatedFieldListFilter
-from .models import BitbakeVersion, Release, LayerSource, ToasterSetting
+from orm.models import BitbakeVersion, Release, LayerSource, ToasterSetting
 from django.forms.widgets import Textarea
 from django import forms
 import django.db.models as models
@@ -31,4 +31,3 @@ admin.site.register(LayerSource, LayerSourceAdmin)
 admin.site.register(BitbakeVersion, BitbakeVersionAdmin)
 admin.site.register(Release, ReleaseAdmin)
 admin.site.register(ToasterSetting, ToasterSettingAdmin)
-
diff --git a/lib/toaster/orm/urls.py b/lib/toaster/bldcollector/urls.py
similarity index 95%
rename from lib/toaster/orm/urls.py
rename to lib/toaster/bldcollector/urls.py
index 961bc19..144387b 100644
--- a/lib/toaster/orm/urls.py
+++ b/lib/toaster/bldcollector/urls.py
@@ -20,8 +20,7 @@
 from django.conf.urls import patterns, include, url
 from django.views.generic import RedirectView
 
-urlpatterns = patterns('orm.views',
+urlpatterns = patterns('bldcollector.views',
         # landing point for pushing a bitbake_eventlog.json file to this toaster instace
         url(r'^eventfile$', 'eventfile', name='eventfile'),
         )
-
diff --git a/lib/toaster/orm/views.py b/lib/toaster/bldcollector/views.py
similarity index 100%
rename from lib/toaster/orm/views.py
rename to lib/toaster/bldcollector/views.py
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 60e80de..c72a904 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -268,7 +268,7 @@ INSTALLED_APPS = (
     # Uncomment the next line to enable admin documentation:
     # 'django.contrib.admindocs',
     'django.contrib.humanize',
-    'orm',
+    'bldcollector',
     'toastermain',
     'south',
 )
-- 
1.9.1


