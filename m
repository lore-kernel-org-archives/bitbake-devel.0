Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id C82A1766E9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Oct 2015 15:43:39 +0000 (UTC)
Received: by wiclk2 with SMTP id lk2so165460154wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Oct 2015 08:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=xRSGSBxIfOVEAdVKhJPR28CB2STJA3OXIfLG71Rp0kk=;
	b=RSB1K1WhkXtQQMHTtYKzTxtSMPuDVzXdk0OZlpaMUXo6+ZUfJNHRYkNIE3GByUC9Ls
	+hynyMTLHNl7hlZ+E3VAx5cZQR1SGifrNB6zziGpOqO5zxKR4uvg2S3lXBxsB1nrV0eL
	8nCeGyZI2lBjCLFSAl2TeQdl65FLTHdtRCI5Q6xPDcMxIPAtkrC49eOR8QQQG4nNoROb
	juzRncnBhC1/8Sv8yng9jWKJ+KsxP2itznChlJN36O19mkc9v7p5Zlwmc+AQFzSrpdIk
	/l3ofr0xeieehCBNMjzHVJDDf4zV9wsAZ2eQICIWeMSeQ/g+uflsY8n1you0aGZajsG4
	dYlg==
X-Gm-Message-State: ALoCoQliLNpzjRpUF2m9ZZN66RQLod3KoYasmnuZqoU4iqV+4sv6pYSzukrIIYFrgIl8ostz91jL
X-Received: by 10.180.188.169 with SMTP id gb9mr17069166wic.44.1444146219291; 
	Tue, 06 Oct 2015 08:43:39 -0700 (PDT)
Received: from localhost.localdomain ([2.218.205.118])
	by smtp.gmail.com with ESMTPSA id
	jd7sm11451008wjb.19.2015.10.06.08.43.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 06 Oct 2015 08:43:38 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Oct 2015 16:43:30 +0100
Message-Id: <1444146210-27564-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH] toaster: display warnings for bad "IMAGE_FSTYPES" values
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
X-List-Received-Date: Tue, 06 Oct 2015 15:43:40 -0000

From: David Reyna <David.Reyna@windriver.com>

Display warning message for IMAGE_FSTYPES when no value is selected or
when the filter does not have any matches

[YOCTO #8126]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/projectconf.html | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index 4c5a188..5333ec5 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -43,6 +43,7 @@
                     <input id="filter-image_fstypes" type="text" placeholder="Search image types" class="span4">
                     <div id="all-image_fstypes" class="scrolling">
                     </div>
+                    <span class="help-block" id="fstypes-error-message">You must select at least one image type</span>
                     <button id="apply-change-image_fstypes" type="button" class="btn">Save</button>
                     <button id="cancel-change-image_fstypes" type="button" class="btn btn-link">Cancel</button>
                 </form>
@@ -312,9 +313,11 @@
             });
             if ( 0 == any_checked ) {
                 $("#apply-change-image_fstypes").attr("disabled","disabled");
+                $('#fstypes-error-message').show();
             }
             else {
                 $("#apply-change-image_fstypes").removeAttr("disabled");
+                $('#fstypes-error-message').hide();
             }
         }
 
@@ -546,10 +549,14 @@
                 // Add the un-checked boxes second
                 for (var i = 0, length = fstypes_list.length; i < length; i++) {
                     if (0  > fstypes.indexOf(" "+fstypes_list[i].value+" ")) {
-                            html += '<label class="checkbox"><input type="checkbox" class="fs-checkbox-fstypes" value="'+fstypes_list[i].value+'">'+fstypes_list[i].value+'</label>\n';
+                        html += '<label class="checkbox"><input type="checkbox" class="fs-checkbox-fstypes" value="'+fstypes_list[i].value+'">'+fstypes_list[i].value+'</label>\n';
                     }
                 }
+                // Add the 'no search matches' line last
+                html += '<label id="no-match-fstypes">No image types found</label>\n';
+                // Display the list
                 document.getElementById("all-image_fstypes").innerHTML = html;
+                $('#no-match-fstypes').hide();
 
                 // Watch elements to disable Save when none are checked
                 $(".fs-checkbox-fstypes").each(function(){
@@ -558,8 +565,9 @@
                     });
                 });
 
-                // clear the previous filter values
+                // clear the previous filter values and warning messages
                 $("input#filter-image_fstypes").val("");
+                $('#fstypes-error-message').hide();
             });
 
             $('#cancel-change-image_fstypes').click(function(){
@@ -569,17 +577,24 @@
             });
 
             $('#filter-image_fstypes').on('input', function(){
-                   var valThis = $(this).val().toLowerCase();
+                var valThis = $(this).val().toLowerCase();
+                var matchCount=0;
                 $('#all-image_fstypes label').each(function(){
                     var text = $(this).text().toLowerCase();
                     var match = text.indexOf(valThis);
                     if (match >= 0) {
                         $(this).show();
+                        matchCount += 1;
                     }
                     else {
                         $(this).hide();
                     }
                 });
+                if (matchCount === 0) {
+                   $('#no-match-fstypes').show();
+                } else {
+                   $('#no-match-fstypes').hide();
+                }
             });
 
             $('#apply-change-image_fstypes').click(function(){
-- 
2.1.4


