Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id 340C5728C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:41 +0000 (UTC)
Received: by pdbcz9 with SMTP id cz9so104865795pdb.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=z8keFIGrAJ8HcxNVtC7+WQ12exrVYelGU8QyYFt7jSw=;
	b=HUmoyzh6v1LoVyK4OPT5KohCZ7ckpV7HRAmL/szdeHOPh5xLWQNWoyUxviCxye/JTK
	4ezTNRg1/3w6Y15TfhZ0rSwkuYuXwLSYsO1KZFFaavyyUwdGgCXMFiIJCBZjL6kta+TT
	mN/Vd8v7izsM0nOz24VNmZr6HOfWnP7DvZegK+SSU0ddsYMx4qN9lmDik83+WdM2EU7c
	MLplGOubRHXNonmtTYKup9wuU8UCJe6wdG2REJLwkzdmc3Bi2lR+muGalJLP+BPsbveh
	iepnrgagZehQr/jopsQyY2JZPul8GlCEQhh+edW+/2P5f96W33mvd8OGPabIcR2F7KA3
	s16g==
X-Gm-Message-State: ALoCoQmmmk/EyJnUhbyV80Q+v0HlD6Y/AAXa04lgerfQYVS3VcQhTEQ+FDYe0mB6YPtZvGgQQX7q
X-Received: by 10.70.35.130 with SMTP id h2mr25050762pdj.28.1426847143036;
	Fri, 20 Mar 2015 03:25:43 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fu14sm7399707pad.44.2015.03.20.03.25.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:42 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BE8335648B0; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:31 +0000
Message-Id: <9f63ca33d65fdd813120ab39f15486a5d049571e.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 14/14] toaster: insure IMAGE_INSTALL_append values have a space prefix
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:42 -0000

From: David Reyna <David.Reyna@windriver.com>

When the IMAGE_INSTALL_append value is not empty, it must have a space prefix
in order for the "append" operator to concatenate the values correctly, so we
enforce it in this variable's submit javascript.

[YOCTO #7394]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/projectconf.html | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index ffdf760..d8ead81 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -468,7 +468,7 @@
             // re-assert the event handlers
         }
 
-	/* ensure cookie exists {% csrf_token %} */
+        /* ensure cookie exists {% csrf_token %} */
         function postEditAjaxRequest(reqdata) {
             var ajax = $.ajax({
                     type:"POST",
@@ -621,10 +621,13 @@
             // change IMAGE_INSTALL_append variable
             $('#change-image_install-icon').click(function() {
                 // preset the edit value
-                var current_val = $("span#image_install").text();
+                var current_val = $("span#image_install").text().trim();
                 if (current_val == "Not set") {
                     current_val="";
                     $("#apply-change-image_install").attr("disabled","disabled");
+                } else {
+                    // insure these non-empty values have single space prefix
+                    current_val=" " + current_val;
                 }
                 $("input#new-image_install").val(current_val);
 
@@ -643,7 +646,7 @@
             });
 
             $("#new-image_install").on('input', function(){
-                if ($(this).val().length == 0) {
+                if ($(this).val().trim().length == 0) {
                     $("#apply-change-image_install").attr("disabled","disabled");
                 }
                 else {
@@ -652,13 +655,14 @@
             });
 
             $('#apply-change-image_install').click(function(){
-                var name = $('#new-image_install').val();
-                postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+name});
-                $('#image_install').text(name);
+                // insure these non-empty values have single space prefix
+                var value = " " + $('#new-image_install').val().trim();
+                postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+value});
+                $('#image_install').text(value);
                 $('#image_install').removeClass('muted');
                 $("#change-image_install-form").slideUp(function () {
                     $('#image_install, #change-image_install-icon').show();
-                    if (name.length > -1) {
+                    if (value.length > -1) {
                         $('#delete-image_install-icon').show();
                         setDeleteTooltip($('#delete-image_install-icon'));
                     }
-- 
1.9.1


