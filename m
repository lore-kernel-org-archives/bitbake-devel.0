Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 6F97272513
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:28 +0000 (UTC)
Received: by mail-wi0-f182.google.com with SMTP id h11so2234994wiw.15
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=G8JZ+NZtyAguQD99A5J1lr/nPxrLr7Ms6b4AvM9VU8M=;
	b=Tdk2u6oxrin5umu5sKQxr7fwV/rpNSU+Kj4/I2oJys0/JpRZhU1l++YPEGCDmnQsaq
	kFpL3grJA9bajlC72CT6nbaLIsgh02b9UmOVphlX9ndzSahAMA8YhNRINzRLbj/gr4sn
	CV3zkTV/Tu5wuynQ2VUB5lA1U7nRdoaFIgsCC4JSeVwMEnKJcjwiwIYhZV3PMNbMZQ3L
	KS/Jl0sGpMFUjjLlDdmPyHXpSMK3P+zKLc3uOWJq88zBFXDpLPu7pxB14ji+mLdUMvj2
	TT78J52KIhOJJc26eCV8swjkgbQ5kK/Cnwy/AIq3QigLRNKWphMCGI4MU5cY9+STGzDs
	Rf2g==
X-Gm-Message-State: ALoCoQkEsveZBpTOu9FFFF+LpDFAEr37+1JD1x6HJ/RsE1qzL+ImAI3Lv9phChuMB6m6UhG8uw/6
X-Received: by 10.180.82.165 with SMTP id j5mr6914621wiy.57.1418384728953;
	Fri, 12 Dec 2014 03:45:28 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id wb9sm1731717wic.20.2014.12.12.03.45.23
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:26 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4DBEB566255; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:15 +0000
Message-Id: <19b8ff1949072691dade96038af529200175843a.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 16/18] toaster: Formatting changes to error messages
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:28 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Just giving a bit of space to the content of the error
messages we show when you try to import a layer that
already exists.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js   | 6 +++---
 lib/toaster/toastergui/templates/importlayer.html | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 5748efd..d6e140f 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -169,7 +169,7 @@ function importLayerPageInit (ctx) {
 
     var errorMsg = $("#import-error").fadeIn();
     var errorType = error.error;
-    var body = errorMsg.children("span");
+    var body = errorMsg.children("p");
     var title = errorMsg.children("h3");
     var optionsList = errorMsg.children("ul");
     var invalidLayerRevision = $("#invalid-layer-revision-hint");
@@ -198,7 +198,7 @@ function importLayerPageInit (ctx) {
 
       case 'hint-layer-exists-with-different-url':
         title.text("This layer already exists");
-        body.html("A layer <strong>"+layerData.name+"</strong> already exists with a different Git repository URL:<br /><br />"+error.current_url+"<br /><br />You Can:");
+        body.html("A layer <strong>"+layerData.name+"</strong> already exists with a different Git repository URL:<p style='margin-top:10px;'><strong>"+error.current_url+"</strong></p><p>You can:</p>");
         optionsList.append("<li>Import the layer under a different name</li>");
         optionsList.append("<li>or <a href=\""+ctx.layerDetailsUrl+error.current_id+"/\" >change the Git repository URL of the existing layer</a></li>");
         duplicatedLayerName.html("A layer <strong>"+layerData.name+"</strong> already exists with a different Git repository URL.<br />To import this layer give it a different name.");
@@ -208,7 +208,7 @@ function importLayerPageInit (ctx) {
 
       case 'hint-layer-exists':
         title.text("This layer already exists");
-        body.html("A layer <strong>"+layerData.name+"</strong> already exists: You Can:");
+        body.html("A layer <strong>"+layerData.name+"</strong> already exists. You can:");
         optionsList.append("<li>Import the layer under a different name</li>");
         break;
       default:
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index c59247f..c92e552 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -43,7 +43,7 @@
                       <div class="alert alert-error" id="import-error" style="display:none">
                         <button type="button" class="close" data-dismiss="alert">&times;</button>
                         <h3></h3>
-                        <span></span>
+                        <p></p>
                         <ul></ul>
                       </div>
 
-- 
1.9.1


