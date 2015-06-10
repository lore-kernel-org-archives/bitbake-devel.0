Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id D04F9758DE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:40:08 +0000 (UTC)
Received: by wifx6 with SMTP id x6so49723668wif.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=tk8gpBjcNkSl/+i5STpyg8eaZ69rYH08B7x1sROEENs=;
	b=kGHOZNWqqPdfy+kAwy/hKEg49dvzA62pzOW4KGSPOO0fmOB+6OpwyAHmY10xo6GVBl
	wd9Ac6The/7ysq3jLc49bk70URAT39VoQbAi3twxr3954Zs7DHgCBlrRIiiv7at8SVNi
	7khVQE51GRReK5pfBZZ8oytAl2AvzwCBkvl8rFgV0kARU3hURXdyVtJ3YRqQR8KuoLJ0
	CakW2j32AG4Xl2sl/nsudb588y+MuJGrm0R1fBeyOIs55BlOQttwGTNs2Am4peoatgvI
	bfEiefukBS+cb07GZ0qsaEYViQoL38L4V5VyebKKePrW7HPux2rn2kMARCqmdi4t/sbC
	U/kA==
X-Gm-Message-State: ALoCoQmmyBPoQ6HagTiUf4hyjsvkdi+itTqC1WgabDZUv3hTXe5UZBd4NGhkhAOV4mNSSqAzd/KU
X-Received: by 10.180.77.34 with SMTP id p2mr9068479wiw.22.1433947209597;
	Wed, 10 Jun 2015 07:40:09 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id l6sm8294025wib.18.2015.06.10.07.40.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:40:09 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 27112561258; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:39:05 +0100
Message-Id: <ecb70b0bc996529f1a6e58e5716b31e273395c98.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 17/19] toaster: Add ajax loading spinner
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
X-List-Received-Date: Wed, 10 Jun 2015 14:40:09 -0000

From: Michael Wood <michael.g.wood@intel.com>

This adds an ajax loading spinner to provide feedback when in-page
loading is happening. It will show after 1.2 seconds of initial loading.

[YOCTO #7790]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/css/default.css  | 49 ++++++++++++++++++++++++++
 lib/toaster/toastergui/static/js/libtoaster.js | 22 ++++++++++++
 lib/toaster/toastergui/templates/base.html     |  5 +++
 3 files changed, 76 insertions(+)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 739efbf..115abc4 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -259,3 +259,52 @@ div.add-deps { margin-top: 15px; }
 
 thead .description, .get_description_or_summary { width: 364px; }
 thead .add-del-layers { width: 124px; }
+
+#loading-notification {
+  position: fixed;
+  z-index: 101;
+  top: 3%;
+  left: 40%;
+  right: 40%;
+  #c09853
+  -webkit-box-shadow: 0 0 10px #c09853;
+  -moz-box-shadow: 0 0 10px #c09853;
+  box-shadow: 0 0 10px #c09853;
+}
+
+/* Copied in from newer version of Font-Awesome 4.3.0 */
+.fa-spin {
+  -webkit-animation: fa-spin 2s infinite linear;
+  animation: fa-spin 2s infinite linear;
+  display: inline-block;
+}
+.fa-pulse {
+  -webkit-animation: fa-spin 1s infinite steps(8);
+  animation: fa-spin 1s infinite steps(8);
+  display: inline-block;
+}
+
+@-webkit-keyframes fa-spin {
+  0% {
+    -webkit-transform: rotate(0deg);
+    transform: rotate(0deg);
+  }
+  100% {
+    -webkit-transform: rotate(359deg);
+    transform: rotate(359deg);
+  }
+}
+
+@keyframes fa-spin {
+  0% {
+    -webkit-transform: rotate(0deg);
+    -moz-transform: rotate(0deg);
+    transform: rotate(0deg);
+  }
+  100% {
+    -webkit-transform: rotate(359deg);
+    -moz-transform: rotate(359deg);
+    transform: rotate(359deg);
+  }
+}
+/* End copied in from newer version of Font-Awesome 4.3.0 */
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 23755a7..c379833 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -341,6 +341,8 @@ function reload_params(params) {
 /* Things that happen for all pages */
 $(document).ready(function() {
 
+  var ajaxLoadingTimer;
+
   /* If we don't have a console object which might be the case in some
      * browsers, no-op it to avoid undefined errors.
      */
@@ -482,6 +484,26 @@ $(document).ready(function() {
         $('#collapse-warnings').addClass('in');
     }
 
+    /* Show the loading notification if nothing has happend after 1.5
+     * seconds
+     */
+    $(document).bind("ajaxStart", function(){
+      if (ajaxLoadingTimer)
+        window.clearTimeout(ajaxLoadingTimer);
+
+      ajaxLoadingTimer = window.setTimeout(function() {
+        $("#loading-notification").fadeIn();
+      }, 1200);
+    });
+
+    $(document).bind("ajaxStop", function(){
+      if (ajaxLoadingTimer)
+        window.clearTimeout(ajaxLoadingTimer);
+
+      $("#loading-notification").fadeOut();
+    });
+
+
     function check_for_duplicate_ids () {
       /* warn about duplicate element ids */
       var ids = {};
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 6cdc5e8..9f19c03 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -68,6 +68,11 @@
     </head>
 
 <body style="height: 100%">
+
+  <div id="loading-notification" class="alert lead text-center" style="display:none">
+    Loading <i class="fa-pulse icon-spinner"></i>
+  </div>
+
 <div class="navbar navbar-static-top">
     <div class="navbar-inner">
             <a class="brand logo" href="#"><img src="{% static 'img/logo.png' %}" class="" alt="Yocto logo project"/></a>
-- 
1.9.1


