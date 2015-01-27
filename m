Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 900F772D09
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:34 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id r20so5205905wiv.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Tt5AGB+iXi92CieDEjK06u0A0h7CLGSn9Lc5gPrsSTY=;
	b=UQEW3wALIm1Zo/z0SRc72OI2g7nRVCn0lV8/Dl52hV/HaYPW3Dsy6G4ft8D7tlS5/o
	AwvaGmBw3uL8AKFSuA4RuAhJPRsRZgXZL1WS7AMpyR4E7gbOtd9BdsUNXH/eXM/q7zPA
	YydKrZs0QNq1cWLMokGQ7DgJOS9TgB10iulPC9+sXFW/Se+UldOHEUlyxUNFRufU60DY
	kw1zeUiRvHMtlqJ3MD7f+VTVYepw9CA1s9F8dvzNFNolXbylFwTkgiZbkjDlfcE6rPov
	XmBxvzhJ+Tw/b/i60iecVlri5uuaiqou9SYTEZIhmFcz7mQ0GSkqHkkVrcs3TjMRCWCo
	lGgQ==
X-Gm-Message-State: ALoCoQl3+iSYrtbtPWFOq/3rvPAb+02fLNNxSIj49OQdkfo982LN3kSf9VTI4Cqffp4DHZOiIuS6
X-Received: by 10.194.242.6 with SMTP id wm6mr306522wjc.7.1422368855433;
	Tue, 27 Jan 2015 06:27:35 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id cm7sm18351324wib.6.2015.01.27.06.27.32
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:33 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id A5424562162; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:23 +0000
Message-Id: <aed92feac017c967834575344faa3bad7a905b18.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Subject: [PATCH 02/14] toaster: apply common styles to right hand column of detail pages
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:39 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Layer, recipe and package details pages have a right column
with additional information. This commit standardises the
formatting of the content in that right column across
all these pages by creating a new css class .item-info
in default.css

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/css/default.css             | 3 +--
 lib/toaster/toastergui/templates/layerdetails.html        | 2 +-
 lib/toaster/toastergui/templates/package_detail_base.html | 2 +-
 lib/toaster/toastergui/templates/recipe.html              | 6 +++---
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index a3fa0dd..5eeeea4 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -38,7 +38,7 @@ dd code, .alert code { white-space: pre-wrap; word-break: break-all; word-wrap:
 dd ul { list-style-type: none; margin: 0px; }
 dt, dd  {line-height: 25px; }
 dd li { line-height: 25px; }
-dd p { line-height: 20px; }
+.item-info dd { line-height: 20px; margin-bottom: 10px; }
 
 /* Style the filter modal dialogs */
 .modal { width: 800px; margin-left: -400px; }
@@ -200,7 +200,6 @@ dl textarea { resize: vertical; }
 .lead .help-block { font-size: 14px; line-height: 20px; font-weight: normal; }
 .button-place  .btn { margin: 0 0 20px 0; }
 .tooltip-inner { max-width: 250px; }
-dd > span { line-height: 20px; }
 .new-build { padding: 20px; }
 .new-build li { line-height: 30px; }
 .new-build h6 { margin: 10px 0 0 0; color: #5a5a5a; }
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 22e99e0..9286df6 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -431,7 +431,7 @@
             </div>
             <div class="row-fluid span4 well">
               <h2>About {{layerversion.layer.name}}</h2>
-              <dl>
+              <dl class="item-info">
 
                 <dt>
                   Summary
diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index dfeba55..ad75454 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -54,7 +54,7 @@
         <h2>Package information</h2>
 
         <!-- info presented as definition list -->
-        <dl>
+        <dl class="item-info">
             <dt>
                 Size
                 <i class="icon-question-sign get-help" title="The size of the package"></i>
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index b20c65e..d91768d 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -250,14 +250,14 @@
 
 <div class="row span4 well">
     <h2>About {{object.name}}</h2>
-    <dl>
+    <dl class="item-info">
         {% if object.summary %}
             <dt>Summary</dt>
-            <dd><p>{{object.summary}}</p></dd>
+            <dd>{{object.summary}}</dd>
         {% endif %}
         {% if object.description %}
             <dt>Description</dt>
-            <dd><p>{{object.description}}</dd>
+            <dd>{{object.description}}</dd>
         {% endif %}
         {% if object.homepage %}
             <dt>Homepage</dt>
-- 
1.9.1


