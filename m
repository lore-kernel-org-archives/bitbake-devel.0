Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
	[74.125.82.182])
	by mail.openembedded.org (Postfix) with ESMTP id B9DDB7378C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 21:42:26 +0000 (UTC)
Received: by wesu56 with SMTP id u56so15033657wes.10
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 13:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=AmlgEwhrxA4GkCo1uiitZ1egK/YTczB110wU6CsHmCI=;
	b=FWKKm9guNkLjvABO4QL+gPOpjk4qIvh3UZ5mSnLWe975opEG/+Gs1fIIsBmNsT0WjA
	QzfiPT4b5KKJX8dY64rIh/FpRJ9OnoGcUWhfZTVlMbC1qYXwTeg0sTYgEuOHiiYl3NWB
	SkdslmX2TfCV0MUx0J1tfVMxTS0SmaO+n4FCxpOyLccuEJdKXFqAWLf9kHISumFbsc2N
	xy7An061oIkZhs9zE0J0Ulrpg8xNhRJF/tE1w8pYoMBQx+2IpQOHVMA1S3z0eC5WekEg
	ajLjIPJd3Xhd7vRKxp/SiUOfkSOsgkRx0geREnCEWXQ9MwXH8iGva4YmUO1QbPVnLJcD
	WbQA==
X-Gm-Message-State: ALoCoQmkYNcEG7iRqTWNYTl1PhEy6G323fHDcVM/2O2uqU7UpasFja5JZVne8uGLJG4oOvDY0iQ6
X-Received: by 10.180.206.14 with SMTP id lk14mr54410735wic.71.1424986947185; 
	Thu, 26 Feb 2015 13:42:27 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id hd5sm19492wib.21.2015.02.26.13.42.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 13:42:25 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C83B956180A; Thu, 26 Feb 2015 21:42:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 21:42:01 +0000
Message-Id: <a6e7f3f18be36fe837ec0f646bb703a87b8a9ffa.1424986746.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
References: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424986746.git.alexandru.damian@intel.com>
References: <cover.1424986746.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 8/8] toaster: config var layout fixes
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
X-List-Received-Date: Thu, 26 Feb 2015 21:42:26 -0000

From: David Reyna <David.Reyna@windriver.com>

Block duplicates of custom variables regardless of case, fix spacing of
delete icon, no extra error msg on blank DISTRO name

[YOCTO #7359]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/css/default.css     |  2 +-
 lib/toaster/toastergui/templates/projectconf.html | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 0cf0f19..dc1b92a 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -151,7 +151,7 @@ select { width: auto; }
 #dependencies_modal_form { margin-bottom: 0px; }
 
 /* Configuration styles */
-.icon-trash { color: #B94A48; font-size: 16px; padding-left: 2px; }
+.icon-trash { color: #B94A48; font-size: 16px; padding-left: 5px; }
 .icon-trash:hover { color: #943A38; text-decoration: none; cursor: pointer; }
 .icon-pencil, .icon-download-alt, .icon-refresh, .icon-star-empty, .icon-star, .icon-tasks { font-size: 16px; color: #0088CC; padding-left: 2px; }
 .icon-pencil:hover, .icon-download-alt:hover, .icon-refresh:hover, .icon-star-empty:hover, .icon-star:hover, .icon-tasks:hover { color: #005580; text-decoration: none; cursor: pointer; }
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index dde8a11..774e9ea 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -23,12 +23,12 @@
                 <i class="icon-pencil" id="change-distro-icon"></i>
                 <form id="change-distro-form" style="display:none;">
                     <div class="input-append">
-                  <span  id="edit-distro-name-div" class="control-group">
-                        <input type="text" id="new-distro" value="{{distro}}">
-                        <button id="apply-change-distro" class="btn" type="button">Save</button>
-                        <button id="cancel-change-distro" type="button" class="btn btn-link">Cancel</button>
+                        <span  id="edit-distro-name-div" class="control-group">
+                            <input type="text" id="new-distro" value="{{distro}}">
+                            <button id="apply-change-distro" class="btn" type="button">Save</button>
+                            <button id="cancel-change-distro" type="button" class="btn btn-link">Cancel</button>
+                        </span>
                         <span class="help-block error" id="distro-error-message"></span>
-                  </span>
                     </div>
                 </form>
             </dd>
@@ -52,7 +52,7 @@
                 <i class="icon-question-sign get-help" title="Specifies additional packages to install into an image. If your build creates more than one image, the packages will be installed in <strong>all of them</strong> <br /><a href='http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-IMAGE_INSTALL' target='_blank'>Read more in the manual</a>"></i>
             </dt>
             <dd class="lead">
-                <span id="image_install">{% if image_install_append %}{{image_install_append}}{%else%}<i>Not set</i>{%endif%}</span>
+                <span id="image_install"{% if image_install_append %}{%else%} class="muted"{%endif%}>{% if image_install_append %}{{image_install_append}}{%else%}Not set{%endif%}</span>
                 <i class="icon-pencil" id="change-image_install-icon"></i>
                 <i class="icon-trash" id="delete-image_install-icon" {% if image_install_append %}{%else%}style="display:none;"{%endif%}></i>
                 <form id="change-image_install-form" style="display:none;">
@@ -198,14 +198,14 @@
 
             var existing_configvars = document.getElementsByClassName('js-config-var-name');
             for (var i = 0, length = existing_configvars.length; i < length; i++) {
-                if (existing_configvars[i].innerHTML == variable) {
+                if (existing_configvars[i].innerHTML.toUpperCase() == variable.toUpperCase()) {
                     error_msg = "This variable is already set in this page, edit its value instead";
                 }
             }
 
             var blacklist_configvars = document.getElementsByClassName('js-config-blacklist-name');
             for (var i = 0, length = blacklist_configvars.length; i < length; i++) {
-                if (blacklist_configvars[i].value == variable.toUpperCase()) {
+                if (blacklist_configvars[i].value.toUpperCase() == variable.toUpperCase()) {
                     error_msg = "You cannot edit this variable in Toaster because it is set by the build servers";
                 }
             }
@@ -257,7 +257,7 @@
             if (has_spaces) {
                 error_msg = "A valid distro name cannot include spaces";
             } else if (0 == value.length) {
-                error_msg = "A valid distro name cannot be empty";
+                error_msg = " ";
             }
 
             if ("" != error_msg) {
@@ -609,7 +609,7 @@
                 var name = $('#new-image_install').val();
                 postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+name});
                 $('#image_install').text(name);
-                $('#image_install').parent().removeClass('muted');
+                $('#image_install').removeClass('muted');
                 $("#change-image_install-form").slideUp(function () {
                     $('#image_install, #change-image_install-icon').show();
                     if (name.length > -1) {
@@ -624,7 +624,7 @@
                 $(this).tooltip('hide');
                 postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+''});
                 $('#image_install').parent().fadeOut(1000, function(){
-                    $('#image_install').parent().addClass('muted');
+                    $('#image_install').addClass('muted');
                     $('#image_install').text('Not set');
                     $('#delete-image_install-icon').hide();
                     $('#image_install').parent().fadeIn(1000);
-- 
1.9.1


