Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
	[209.85.192.182])
	by mail.openembedded.org (Postfix) with ESMTP id 21F8E732A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:10 +0000 (UTC)
Received: by pdjg10 with SMTP id g10so26636547pdj.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=08ZxXgGLa2kJ86D2lQx7TSmJYgalMbu70fL0LYK0c48=;
	b=Q3nWU4X3SI7FlarFDQVKJQ/CrPDs1Pdmvb5dQO/aBYlgTlcxAE2l8X8DHjqTBkeu0U
	FiRHPJ1t/yJV0V4aRuDOAqh56zBmKFvZsJePxr83lnVZvJpZn5naFkDdtiu98x1cDPRO
	DUvPp5WPvASdX/8EN2wgK6pxH6ttiuKzJEOm4Agwpw20yZly4GYz3xeJNNpCGi67rOqu
	v8R7zAvcZP2Kyj883G4LqfVaYFpgAavRacvHXmSRFYQHN0o6QwmrNGPWpPHMWXdlF+bE
	lYhV1u8mAMgDnbFKSboFWrm/fvTi6bRTxADjRn95xG5vT2fxCqbLSkSRS6kFn9AVSOdq
	jrWA==
X-Gm-Message-State: ALoCoQnh9jh8dNsy5PhBDZa5ojIcsm9t5bkS0+Gyo0qiRfH5HVA3VU8jKUeiKhP6fJkKZu58LaH3
X-Received: by 10.66.136.17 with SMTP id pw17mr31304985pab.33.1423504932122;
	Mon, 09 Feb 2015 10:02:12 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id di5sm3896290pbc.36.2015.02.09.10.02.09
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 633325661B7; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:49 +0000
Message-Id: <8fffd7b5fd53bd66ed7621595f57e2cae416e80d.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 19/27] toaster: All machines Add layer name order by functions
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:11 -0000

From: Michael Wood <michael.g.wood@intel.com>

Allow the layer name to be sorted alphabetically in the machines table.
Also fix the default ordering to be machine name

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/machines.html | 2 +-
 lib/toaster/toastergui/views.py                | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index 487d6b7..650c47b 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -31,7 +31,7 @@
 <div class="page-header">
   <h1>
     All machines
-    <i class="icon-question-sign get-help heading-help" title="This page lists all the machines compatible with Yocto Project 1.7 'Dxxxx' that Toaster knows about. They include community-created targets suitable for use on top of OpenEmbedded Core and any targets you have imported"></i>
+    <i class="icon-question-sign get-help heading-help" title="This page lists all the machines compatible with the current project that Toaster knows about. They include community-created targets suitable for use on top of OpenEmbedded Core and any targets you have imported"></i>
   </h1>
 </div>
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index c89b67b..2e52d2b 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2777,7 +2777,7 @@ if toastermain.settings.MANAGED:
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
-        (pagesize, orderby) = _get_parameters_values(request, 10, 'updated:+')
+        (pagesize, orderby) = _get_parameters_values(request, 10, 'name:+')
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby };
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
@@ -2815,6 +2815,8 @@ if toastermain.settings.MANAGED:
                 },
                 {   'name': 'Layer',
                     'clclass': 'layer',
+                    'orderfield': _get_toggle_order(request, "layer_version__layer__name"),
+                    'ordericon' : _get_toggle_order_icon(request, "layer_version__layer__name"),
                 },
                 {   'name': 'Layer source',
                     'clclass': 'source',
-- 
1.9.1


