Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (unknown [209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 2B39165F65
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 May 2014 13:31:42 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id bs8so1001236wib.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 May 2014 06:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ffLaD2oiMe5+YvqrbTcMr+4t2sw44FfTVU9pOjEmU2w=;
	b=S2uSL5QvzLriKq5dCrdZnCgyLQNDivpuQOvjX5Q6Rp09sqL0tzqhrOHZnPt4vxk86H
	xre+Zu65FhW8c0jc0EGR5vmo6qehUgrMellWi+iP5UOkFXBcHt77BEKtx6sUzMVyms7z
	MPSE2uyhCeIIQEeaNuW96lALtjPeid/GmUgKcPjT4i+HzR6UogJXohRYVdDk5NDeAMEo
	bk4+8URfZDkHX8/xnL66pUaIunTZWJk/u/THKSM2KCVs4Ucu3jjccLkJYt6oBYo5QAYh
	nHEXYrlCkNoLv1ZSNMtUbIf+RFAi7qBRPIrmoXKwvD+2SKHw1RhfqB5f4EuUq5BEZHtS
	lyNg==
X-Gm-Message-State: ALoCoQmORul9GYlaR4lthndo1a91OGTm+ow8X2ibnChErOvDsIsXlOYxjK6N8s4Xn6rzUNynDNhA
X-Received: by 10.180.77.225 with SMTP id v1mr12885559wiw.5.1399555479377;
	Thu, 08 May 2014 06:24:39 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id dn1sm4898947wid.6.2014.05.08.06.24.37
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 May 2014 06:24:37 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id F0010560458; Thu,  8 May 2014 21:24:36 +0800 (HKT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 May 2014 14:24:33 +0100
Message-Id: <0d19987bd81fb2fc785b05220db22d422e5cc536.1399555312.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7fc64b40c28e09f8fe549d8d2972d5066bc1d125.1399555312.git.alexandru.damian@intel.com>
References: <7fc64b40c28e09f8fe549d8d2972d5066bc1d125.1399555312.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1399555312.git.alexandru.damian@intel.com>
References: <cover.1399555312.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 3/5] toaster: fix span2 headings for packages
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
X-List-Received-Date: Thu, 08 May 2014 13:31:43 -0000

From: Dave Lerner <dave.lerner@windriver.com>

[YOCTO 6147]

Fix bug in views.py that put 'span2' class id in a 'clclass' key
instead of the 'dclass' key.  This fix exposed another problem in
target.html and the target view function that used 'package_size'
instead of 'size' as the 'clclass' which is inconsistent with the
model field name, causing table data columns to be shown when
the header is hidden.

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
---
 lib/toaster/toastergui/templates/target.html | 2 +-
 lib/toaster/toastergui/views.py              | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index 86e46dc..564fd27 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -79,7 +79,7 @@
             {{package.version|filtered_packageversion:package.revision}}
             </a>
         </td>
-        <td class="package-size sizecol">
+        <td class="size sizecol">
             {{package.size|filtered_installedsize:package.installed_size|filtered_filesizeformat}}
         </td>
         <td class="size_over_total sizecol">
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 3d2ed4c..e3b24ba 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -575,13 +575,15 @@ def target(request, build_id, target_id):
                     'qhelp':'The size of the package',
                     'orderfield': _get_toggle_order(request, "size", True),
                     'ordericon':_get_toggle_order_icon(request, "size"),
-                    'clclass': 'package_size span2',
+                    'clclass': 'size',
+                    'dclass' : 'span2',
                     'hidden' : 0,
                 },
                 {
                     'name':'Size over total (%)',
                     'qhelp':'Proportion of the overall included package size represented by this package',
-                    'clclass': 'size_over_total span2',
+                    'clclass': 'size_over_total',
+                    'dclass' : 'span2',
                     'hidden' : 1,
                 },
                 {
@@ -1273,7 +1275,8 @@ def bpackage(request, build_id):
                 'qhelp':'The size of the package',
                 'orderfield': _get_toggle_order(request, "size", True),
                 'ordericon':_get_toggle_order_icon(request, "size"),
-                'clclass': 'size span2', 'hidden': 0,
+                'clclass': 'size', 'hidden': 0,
+                'dclass' : 'span2',
             },
             {
                 'name':'License',
-- 
1.9.1


