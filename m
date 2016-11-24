Return-Path: <michael.g.wood@intel.com>
Received: from mail-wj0-f182.google.com (mail-wj0-f182.google.com
	[209.85.210.182])
	by mail.openembedded.org (Postfix) with ESMTP id 1552571B5D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:22 +0000 (UTC)
Received: by mail-wj0-f182.google.com with SMTP id xy5so31037314wjc.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BC+fEPPBBw49ITrbgylyCrgzP5XGy3YvyBjXosOdsGk=;
	b=ExaVR2WTmGvp/pQueDq+R/EZv/fwikf6Gk3AJHVmMN0D3/kVxaxU6TWwD7+t1qDPh8
	L7Zc0KdEAVhi8d3obt7v2OXTtml0NQPVlNTgEGWKlbKyGf9dZSR+FsGuZMCQp14XPTkW
	+0c0gF8sK5ay8rSq/hcu3xBEwJxGOJ7H9LrMMHVaMmuFEDDYqv3o7HU4YaOLwdRjyNEu
	MjtepCTywtHEA529AI5Sni5hmHaaFQ67HP29XicZQ8nrqnMg+xSFr8BYb0OsSAuYRKya
	eT2Jm+JUWR89DSh5E3R8u78NtnOh4hJdfN8RtmpZJE9A5K7YFZ1Kjtwrh5GtnDcgD2fm
	74wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BC+fEPPBBw49ITrbgylyCrgzP5XGy3YvyBjXosOdsGk=;
	b=BzDYMH/9sfRrIpbnJMDL6ADABKuTB8ZoR1gXxgwoaQVnEgOY1kgLIZqnjH04hADeHH
	wgfKAtIeTxYERJBD8kaQi/6kpygSMzilmm7wr3FiXgHiVR7XiVmPk1ThKlDRLR9b1YMa
	PRgvtuW44/H5yeoyozq2Yz2fn+jDZzSGVldGz22TcjyKr1d6y0wlctVddXy105GnYmlg
	IkapmeZu63Qg0mpZYytP1iUeeMoyl7Y/BBkpQDX909UH9bLif4DVEcYbwScpc4SwCENN
	oqDnpbAUzGPMpdwM15lIbjbWHXSHvvKIEKYC3P4k94c5ygCsH2e1tb1Vv3NoOAu0UUp6
	zlow==
X-Gm-Message-State: AKaTC00OsxJA8K4lLHushQfluDBJJglIeghg0ySuQNdI6CaeXJyfsE+JE+zSN7j7vFXtoga8
X-Received: by 10.194.109.42 with SMTP id hp10mr1762467wjb.167.1479986423577; 
	Thu, 24 Nov 2016 03:20:23 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:23 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:19:54 +0000
Message-Id: <1479986406-4657-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 03/15] toaster: Add an example production settings file
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:23 -0000

Add an example settings that can be used for the basis of the production
instance of Toaster.

[YOCTO #10581]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../toastermain/settings_production_example.py     | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 lib/toaster/toastermain/settings_production_example.py

diff --git a/lib/toaster/toastermain/settings_production_example.py b/lib/toaster/toastermain/settings_production_example.py
new file mode 100644
index 0000000..61a2888
--- /dev/null
+++ b/lib/toaster/toastermain/settings_production_example.py
@@ -0,0 +1,58 @@
+#
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2016        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+# See Django documentation for more information about deployment
+# https://docs.djangoproject.com/en/1.8/howto/deployment/checklist/
+
+# Toaster production settings example overlay
+# To use this copy this example to "settings_production.py" and set in your
+# environment DJANGO_SETTINGS_MODULE=toastermain.settings_production
+# This can be permanently set in a new .wsgi file
+
+from toastermain.settings import *  # NOQA
+
+# Set this value!
+SECRET_KEY = None
+
+# Switch off any debugging
+DEBUG = True
+TEMPLATE_DEBUG = DEBUG
+
+DATABASES = {
+     'default': {
+         'ENGINE': 'django.db.backends.mysql',
+         'NAME': 'toaster_data',
+         'USER': 'toaster',
+         'PASSWORD': 'yourpasswordhere',
+         'HOST': '127.0.0.1',
+         'PORT': '3306',
+     }
+}
+
+# Location where static files will be placed by "manage.py collectstatic"
+STATIC_ROOT = '/var/www/static-toaster/'
+
+# URL prefix for static files.
+STATIC_URL = '/static-toaster/'
+
+# Hosts that Django will serve
+# https://docs.djangoproject.com/en/1.8/ref/settings/#std:setting-ALLOWED_HOSTS
+ALLOWED_HOSTS = ['toaster-example.example.com']
-- 
2.7.4


