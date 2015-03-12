Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id EE6EE73B54
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:52 +0000 (UTC)
Received: by wibbs8 with SMTP id bs8so19158803wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=NBfwOitAVnEjZ9dIhMh2WM8CZMxxrNC/bdVPgUZ49WA=;
	b=RY0yDmYTBAIAn1Atbyu+osEFMXSwA5XK0tMTKI+2Q9TTbmJHpGA0FRLKKQecUvIZZw
	3ZFZESkuc49QwJxmplDERxouVbQB6qPj1wg+QbrglI+04TJEzADmFxEFOmzQmFwzeQZa
	KDE0omw2npbzAyP7l8zn0UEfi2DF3zsBr4dCgdzjE0xt9JNInzDc7WA4qvaQcIhDpVMb
	134ywKjCIWTV/g9drzDYAfaVEyHQiNOrvSxjqOxuUuQAWGID9ZAt5EAF3191hdQ4TxpC
	9+9R1xdTsr3oI2MvRWVfuAbyY7fCs6EJMBa7blLmgUo/LoD3U42QP6KDeHOTeQo29m2L
	8X2g==
X-Gm-Message-State: ALoCoQmGaaMhDIRCquH/ePg+wTM9fy6Axy3GVWUq9wWn6ZG/kCef/VNAtKgEBfy+we5a4PsvdDQ5
X-Received: by 10.194.175.137 with SMTP id ca9mr23973400wjc.67.1426157213334; 
	Thu, 12 Mar 2015 03:46:53 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ge8sm9413793wjc.32.2015.03.12.03.46.51
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 701565620F3; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:43 +0000
Message-Id: <7a581b998f6ab95cd14c7360a6771789f535af98.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 10/17] toastergui: dirinfo needs path separation
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In the dirinfo URLs we use the "/" separator for directory
separation which coincides with the "/" separator in HTTP URIs.

This is not a problem, but we must not have consecutive "/"
characters as the web servers will conflate those - we add
a "_" delimitator to separate the Django managed URL from the
dirpath parameter, while maintaining the unique ID of REST urls.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/urls.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 8a7fef1..76357e3 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -55,7 +55,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/targetpkg$', 'targetpkg', name='targetpkg'),
         url(r'^dentries/build/(?P<build_id>\d+)/target/(?P<target_id>\d+)$', 'dirinfo_ajax', name='dirinfo_ajax'),
         url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/dirinfo$', 'dirinfo', name='dirinfo'),
-        url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/dirinfo_filepath/(?P<file_path>(?:/[^/\n]+)*)$', 'dirinfo', name='dirinfo_filepath'),
+        url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/dirinfo_filepath/_(?P<file_path>(?:/[^/\n]+)*)$', 'dirinfo', name='dirinfo_filepath'),
         url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/packages$', 'tpackage', name='targetpackages'),
         url(r'^build/(?P<build_id>\d+)/configuration$', 'configuration', name='configuration'),
         url(r'^build/(?P<build_id>\d+)/configvars$', 'configvars', name='configvars'),
-- 
1.9.1


