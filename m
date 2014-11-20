Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
	[209.85.192.174])
	by mail.openembedded.org (Postfix) with ESMTP id EE354721CA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:38 +0000 (UTC)
Received: by mail-pd0-f174.google.com with SMTP id w10so3329440pde.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Ke6Jz3tgUyDwwpqMcdFWcU2MoCKknp42kAqXjMT/Z8Q=;
	b=FhyJ/lKijxlKG8WHMIvrQIy2Ljbq/P3zOMgiEK0dYgPXIQqsF86hnMwdxdbik8h5Xs
	69G67fOaE4QjiFc9vogWG+sXSz8Rbm3PM9feGfVQZ2gr2AEuv7qwLwZNfamp7uZfvMJp
	a7g+fuyxy3rDMu5Nt0yEkI0vWHN5Q36sFLRs6LQWX4oyTZM25TsXNH4WSvLO27ZS3Jxg
	Q2NxLkMUF0juiH2I4ht9XuAud/Xl24iROb0yfvnV9s1wjD1MlqHwOa3vc5IQEU796A/F
	oC3duLafz7rld9XonHC/BKJh73DgKStpyJiIzVaJPrVI3hz8GVeHfSeiXWqCssB67RW3
	ah1Q==
X-Gm-Message-State: ALoCoQnJq7GFAk1418ZhdqVqQrI/Wy7u0y6d+luBALfRlmPASVGXov1CIKiK1JnyLH6ERVZP6Ies
X-Received: by 10.69.0.138 with SMTP id ay10mr57022407pbd.110.1416500859115;
	Thu, 20 Nov 2014 08:27:39 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ub7sm2483881pbc.30.2014.11.20.08.27.35
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:37 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 88343561F6D; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:26 +0000
Message-Id: <dc9b4a4ab06ed49f3fcab4f644b8bc136f19fdb0.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 10/11] toaster: fix dependencies dialog layout
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:39 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

Remove the bottom margin of forms inside dependencies
modal dialogs.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 3 +++
 lib/toaster/toastergui/templates/layers.html  | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 902a2bd..dcb8e34 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -136,6 +136,9 @@ select { width: auto; }
 .new-build .alert { margin-top: 10px; }
 .new-build .alert p { margin-top: 10px; }
 
+/* Remove bottom margin for forms inside modal dialogs */
+#dependencies_modal_form { margin-bottom: 0px; }
+
 /* Configuration styles */
 .icon-trash { color: #B94A48; font-size: 16px; padding-left: 2px; }
 .icon-trash:hover { color: #943A38; text-decoration: none; cursor: pointer; }
diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index e9f910f..4e92332 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -89,7 +89,7 @@
 
     <!-- 'Layer dependencies modal' -->
     <div id="dependencies_modal" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
-        <form id="dependencies_modal_form" style="margin: 0px">
+        <form id="dependencies_modal_form">
         <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
             <h3><span class="layer-name"></span> dependencies</h3>
-- 
1.9.1


