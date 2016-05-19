Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 1D5E26E668
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 May 2016 10:43:43 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 19 May 2016 03:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,334,1459839600"; 
	d="scan'208,217";a="980343616"
Received: from gfois-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.121])
	by orsmga002.jf.intel.com with ESMTP; 19 May 2016 03:43:43 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 May 2016 11:43:30 +0100
Message-Id: <1463654612-30647-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 1/3] toaster: handle multiple imagefs types
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
X-List-Received-Date: Thu, 19 May 2016 10:43:44 -0000

From: Sujith H <sujith.h@gmail.com>

This functionality helps users to add custom
image fs types available other than the checkboxes
in the UI. User can add imagefs types in the text
box and use them in the build.

[YOCTO #7828]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/toastergui/templates/projectconf.html  | 111 +++++++++++++--------
 1 file changed, 70 insertions(+), 41 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/projectconf.html b/bitbake/lib/toaster/toastergui/templates/projectconf.html
index 27a898b..c007859 100644
--- a/bitbake/lib/toaster/toastergui/templates/projectconf.html
+++ b/bitbake/lib/toaster/toastergui/templates/projectconf.html
@@ -62,12 +62,16 @@
                 <span id="image_fstypes">{{fstypes}}</span>
                 <i class="icon-pencil" id="change-image_fstypes-icon"></i>
                 <form id="change-image_fstypes-form" style="display:none;">
+                    <div class="input-append" id="validate-image_fstypes">
+                        <input type="text" class="input-xlarge" id="new-imagefs_types">
+                        <button id="apply-change-image_fstypes" type="button" class="btn">Save</button>
+                        <button id="cancel-change-image_fstypes" type="button" class="btn btn-link">Cancel</button>
+                    </div>
+                    </br><span class="help-block error" style="display:none;" id="hintError-image-fs_type">A valid image type cannot include underscores.</span>
+                    <p>Choose from known image types</p>
                     <input id="filter-image_fstypes" type="text" placeholder="Search image types" class="span4">
                     <div id="all-image_fstypes" class="scrolling">
                     </div>
-                    <span class="help-block" id="fstypes-error-message">You must select at least one image type</span>
-                    <button id="apply-change-image_fstypes" type="button" class="btn">Save</button>
-                    <button id="cancel-change-image_fstypes" type="button" class="btn btn-link">Cancel</button>
                 </form>
             </dd>
             {% endif %}
@@ -322,22 +326,6 @@
             return true;
         }
 
-        // Test to insure at least one FS Type is checked
-        function enableFsTypesSave() {
-            var any_checked = 0;
-            $(".fs-checkbox-fstypes:checked").each(function(){
-                any_checked = 1;
-            });
-            if ( 0 == any_checked ) {
-                $("#apply-change-image_fstypes").attr("disabled","disabled");
-                $('#fstypes-error-message').show();
-            }
-            else {
-                $("#apply-change-image_fstypes").removeAttr("disabled");
-                $('#fstypes-error-message').hide();
-            }
-        }
-
         // Preset or reset the Package Class checkbox labels
         function updatePackageClassCheckboxes() {
             $('#package_class_1, #package_class_2').hide();
@@ -603,6 +591,46 @@
             {% if fstypes_defined %}
             // change IMAGE_FSTYPES variable
 
+            // get value of fstypes and add to the textbox
+            $("#new-imagefs_types").val("{{fstypes}}");
+
+            // If value of new-imagefs_types is empty disable save button
+            $("#new-imagefs_types").on("input", function() {
+              $(this).val($(this).val().replace(/\s+/g,' '));
+              if ($(this).val().length === 0) {
+                //$('#apply-change-image_fstypes').prop('disabled', true);
+                $('#apply-change-image_fstypes').attr("disabled", "disabled");
+              } else {
+                //$('#apply-change-image_fstypes').prop('disabled', false);
+                $('#apply-change-image_fstypes').removeAttr("disabled");
+              }
+
+              /*If user types imagefs do the action on checkboxes.
+                Lets say if an imagefstype typed by user and the same
+                imagefs is unchecked in the checkbox, then checkbox needs
+                to get checked. Similarly when user deletes imagefs from
+                textbox the checkbox which is checked gets unchecked.
+              */
+              $('#all-image_fstypes input').each(function(){
+                var imagefs_userval = $('#new-imagefs_types').val();
+                if( imagefs_userval.indexOf($(this).val()) > -1) {
+                   $(this).prop('checked', true);
+                } else {
+                   $(this).prop('checked', false);
+                }
+              });
+
+              // Validate underscore in image fs types
+              if ($(this).val().indexOf('_') > -1) {
+                $('#validate-image_fstypes').addClass('control-group error');
+                $('#hintError-image-fs_type').show();
+                $("#apply-change-image_fstypes").prop("disabled", true);
+              } else {
+                $('#validate-image_fstypes').removeClass('control-group error');
+                $('#hintError-image-fs_type').hide();
+              }
+            });
+
             $('#change-image_fstypes-icon').click(function() {
                 $('#change-image_fstypes-icon, #image_fstypes').hide();
                 $("#change-image_fstypes-form").slideDown();
@@ -630,19 +658,33 @@
                 document.getElementById("all-image_fstypes").innerHTML = html;
                 $('#no-match-fstypes').hide();
 
-                // Watch elements to disable Save when none are checked
-                $(".fs-checkbox-fstypes").each(function(){
-                    $(this).click(function() {
-                        enableFsTypesSave();
-                    });
-                });
-
                 // clear the previous filter values and warning messages
                 $("input#filter-image_fstypes").val("");
-                $('#fstypes-error-message').hide();
+            });
+
+            // When checkbox is checked/unchecked kindly update the text
+            $(document).on("change", "#all-image_fstypes :checkbox", function() {
+              var imagefs = $(this);
+              var imagefs_obj = $('#new-imagefs_types');
+              var imagefs_userval = imagefs_obj.val();
+              if ($(this).is(':checked')) {
+                if (imagefs_userval.indexOf($(imagefs).val()) === -1) {
+                  imagefs_obj.val(imagefs_userval + " " + $(imagefs).val());
+                }
+              } else {
+                if (imagefs_userval.indexOf($(imagefs).val()) > -1) {
+                  imagefs_obj.val(imagefs_userval.replace($(imagefs).val(), '').trim());
+                }
+              }
+              if ($('#new-imagefs_types').val().length === 0) {
+                $("#apply-change-image_fstypes").prop("disabled", true);
+              } else {
+                $("#apply-change-image_fstypes").prop("disabled", false);
+              }
             });
 
             $('#cancel-change-image_fstypes').click(function(){
+                $("#new-imagefs_types").val("{{fstypes}}");
                 $("#change-image_fstypes-form").slideUp(function() {
                     $('#image_fstypes, #change-image_fstypes-icon').show();
                 });
@@ -670,20 +712,7 @@
             });
 
             $('#apply-change-image_fstypes').click(function(){
-                // extract the selected fstypes and sort them
-                var fstypes_array = [];
-                var checkboxes = document.getElementsByClassName('fs-checkbox-fstypes');
-                $(".fs-checkbox-fstypes:checked").each(function(){
-                       fstypes_array.push($(this).val());
-                });
-                fstypes_array.sort();
-
-                // now make a string of them
-                var fstypes = '';
-                for (var i = 0, length = fstypes_array.length; i < length; i++) {
-                    fstypes += fstypes_array[i] + ' ';
-                }
-                fstypes = fstypes.trim();
+                var fstypes = $('#new-imagefs_types').val();
 
                 postEditAjaxRequest({"configvarChange" : 'IMAGE_FSTYPES:'+fstypes});
                 $('#image_fstypes').text(fstypes);
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


