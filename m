Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 6079C7354C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:28 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id k14so27746191wgh.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=wSAcyhV4PpYrIA7pqezLLMN4iLIbWe+lUdPlcPe2Bew=;
	b=Phbhm3r71XERBBCHChpNDChWcHN5o4OlVVz9WIG1MgZ2trANrZ1VZlcgXf5fpc/wiS
	zHP/nH/7yzDp+QE3O6urWI5D/S092vPIWOZx7i6HZQmLGz5tC9Sa5n6vjnyLM6Yuvpfn
	1aVFJnwgdRot8MJ0/3RZD1ovqDIqGL4gSm59Pnf65SbP43T7oJVa0LCU27nT4n/Y+A3J
	hmGybztehoC87Zu2FJgtIkHUlh9zKezRL/ooQilruUBoq9UsUF+Do5DzqEZhOFa/6tgM
	b+6p9SYHlD4poTP2V18pdUgBQd/cVjMkFgQOQ0+IgXTalhv2Vk5BZfSt0HacK37gM0GL
	YcAQ==
X-Gm-Message-State: ALoCoQnO+NQqBmT2kUMybmrR3Tm5GGvpcgExBI5YzbcZHPU+j8T3ev+x6ae2lu7KCapMs+Q1EBco
X-Received: by 10.194.94.1 with SMTP id cy1mr51519500wjb.127.1424109209621;
	Mon, 16 Feb 2015 09:53:29 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	mb20sm15979609wic.18.2015.02.16.09.53.27
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:28 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CF2F256088E; Mon, 16 Feb 2015 17:53:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:21 +0000
Message-Id: <58f19f1c3128c303fb8e5338c01f575418dc0b15.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
References: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424108976.git.alexandru.damian@intel.com>
References: <cover.1424108976.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 05/10] toaster: Additional fixes for the project variable page
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:30 -0000

From: David Reyna <David.Reyna@windriver.com>

Fix IMAGE_FSTYPES, IMAGE_INSTALL_append, and DISTRO editing management, plus other usability details.

[YOCTO #7231]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/projectconf.html | 250 ++++++++++++++++------
 lib/toaster/toastergui/views.py                   |  42 ++--
 2 files changed, 210 insertions(+), 82 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index 0d38a92..ec1fb9b 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -23,9 +23,12 @@
                 <i class="icon-pencil" id="change-distro-icon"></i>
                 <form id="change-distro-form" style="display:none;">
                     <div class="input-append">
+                  <span  id="edit-distro-name-div" class="control-group">
                         <input type="text" id="new-distro" value="{{distro}}">
                         <button id="apply-change-distro" class="btn" type="button">Save</button>
                         <button id="cancel-change-distro" type="button" class="btn btn-link">Cancel</button>
+                        <span class="help-block error" id="distro-error-message"></span>
+                  </span>
                     </div>
                 </form>
             </dd>
@@ -48,10 +51,10 @@
                 <span class="js-config-var-name js-config-var-managed-name">IMAGE_INSTALL_append</span>
                 <i class="icon-question-sign get-help" title="Specifies additional packages to install into an image. If your build creates more than one image, the packages will be installed in <strong>all of them</strong> <br /><a href='http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-IMAGE_INSTALL' target='_blank'>Read more in the manual</a>"></i>
             </dt>
-            <dd class="lead muted">
+            <dd class="lead">
                 <span id="image_install">{% if image_install_append %}{{image_install_append}}{%else%}Not set{%endif%}</span>
                 <i class="icon-pencil" id="change-image_install-icon"></i>
-                <i class="icon-trash" id="delete-image_install-icon" style="display:none;"></i>
+                <i class="icon-trash" id="delete-image_install-icon" {% if image_install_append %}{%else%}style="display:none;"{%endif%}></i>
                 <form id="change-image_install-form" style="display:none;">
                     <div class="row-fluid">
                         <span class="help-block span4">To set IMAGE_INSTALL_append to more than one package, type the package names separated by a space.</span>
@@ -185,13 +188,13 @@
     <script>
 
         // validate new variable name
-        function validate_new_variable_name() {
-            var variable = $("input#variable")[0].value;
-            var value    = $("input#value")[0].value;
+        function validate_new_variable() {
+            var variable = $("input#variable").val();
+            var value    = $("input#value").val();
 
             // presumed innocence
-            $('#new-variable-error-message').html("");
-            var error_msg = ""
+            $('#new-variable-error-message').text("");
+            var error_msg = "";
 
             var existing_configvars = document.getElementsByClassName('js-config-var-name');
             for (var i = 0, length = existing_configvars.length; i < length; i++) {
@@ -202,7 +205,7 @@
 
             var blacklist_configvars = document.getElementsByClassName('js-config-blacklist-name');
             for (var i = 0, length = blacklist_configvars.length; i < length; i++) {
-                if (blacklist_configvars[i].value == variable) {
+                if (blacklist_configvars[i].value == variable.toUpperCase()) {
                     error_msg = "You cannot edit this variable in Toaster because it is set by the build servers";
                 }
             }
@@ -220,7 +223,7 @@
             }
 
             if ("" != error_msg) {
-                $('#new-variable-error-message').html(error_msg);
+                $('#new-variable-error-message').text(error_msg);
                 $(".save").attr("disabled","disabled");
 
                 var d = document.getElementById("add-configvar-name-div");
@@ -228,14 +231,68 @@
 
                 return false;
             }
-
             var d = document.getElementById("add-configvar-name-div");
             d.className = d.className.replace(" control-group error","");
+
+            // now set the "Save" enablement if 'value' also passes
+            if (value.trim().length > 0) {
+                $(".save").removeAttr("disabled");
+            } else {
+                $(".save").attr("disabled","disabled");
+            }
+
             return true;
         }
 
+        // validate distro name
+        function validate_distro_name() {
+             var value    = $("input#new-distro").val();
+
+            // presumed innocence
+            $('#distro-error-message').text("");
+            var error_msg = "";
+
+            var has_spaces = (0 <= value.indexOf(" "));
+
+            if (has_spaces) {
+                error_msg = "A valid distro name cannot include spaces";
+            } else if (0 == value.length) {
+                error_msg = "A valid distro name cannot be empty";
+            }
+
+            if ("" != error_msg) {
+                $('#distro-error-message').text(error_msg);
+                $("#apply-change-distro").attr("disabled","disabled");
+
+                var d = document.getElementById("edit-distro-name-div");
+                d.className = d.className + " control-group error";
+
+                return false;
+            }
+
+            var d = document.getElementById("edit-distro-name-div");
+            d.className = d.className.replace(" control-group error","");
+            $("#apply-change-distro").removeAttr("disabled");
+            return true;
+        }
+
+        // Test to insure at least one FS Type is checked
+        function enableFsTypesSave() {
+            var any_checked = 0;
+            $(".fs-checkbox-fstypes:checked").each(function(){
+                any_checked = 1;
+            });
+            if ( 0 == any_checked ) {
+                $("#apply-change-image_fstypes").attr("disabled","disabled");
+            }
+            else {
+                $("#apply-change-image_fstypes").removeAttr("disabled");
+            }
+        }
+
         // Preset or reset the Package Class checkbox labels
         function updatePackageClassCheckboxes() {
+            $('#package_class_1, #package_class_2').hide();
             if ($('select').val() == 'package_dev') {
                 $('#package_class_1').html('<input type="checkbox" id="package_class_1_input"> package_ipk');
                 $('#package_class_2').html('<input type="checkbox" id="package_class_2_input"> package_rpm');
@@ -248,6 +305,7 @@
                 $('#package_class_1').html('<input type="checkbox" id="package_class_1_input"> package_dev');
                 $('#package_class_2').html('<input type="checkbox" id="package_class_2_input"> package_ipk');
             }
+            $('#package_class_1, #package_class_2').fadeIn(1500);
         }
 
         // Re-assert handlers when the page is served and/or refreshed via Ajax
@@ -256,16 +314,16 @@
             // change variable value
             $('.js-icon-pencil-config_var').click(function (evt) {
                 var pk = evt.target.attributes["x-data"].value;
-                var current_val = $("span#config_var_"+pk).html();
-                $('.js-icon-pencil-config_var, .js-icon-trash-config_var, #config_var_'+pk).hide();
+                var current_val = $("span#config_var_value_"+pk).text();
+                $('.js-icon-pencil-config_var, .js-icon-trash-config_var, #config_var_value_'+pk).hide();
                 $("#change-config_var-form_"+pk).slideDown();
-                $("input#new-config_var_"+pk)[0].value = current_val;
+                $("input#new-config_var_"+pk).val(current_val);
             });
 
             $('.js-cancel-change-config_var').click(function (evt) {
                 var pk = evt.target.attributes["x-data"].value;
                 $("#change-config_var-form_"+pk).slideUp(function() {
-                    $('.js-icon-pencil-config_var, .js-icon-trash-config_var, #config_var_'+pk).show();
+                    $('.js-icon-pencil-config_var, .js-icon-trash-config_var, #config_var_value_'+pk).show();
                 });
             });
 
@@ -284,20 +342,25 @@
                 var variable = xdata[1];
                 var val      = $('#new-config_var_'+pk).val();
                 postEditAjaxRequest({"configvarChange" : variable+':'+val});
-                $('#config_var_'+pk).parent().removeClass('muted');
+                $('#config_var_value_'+pk).parent().removeClass('muted');
                 $("#change-config_var-form_"+pk).slideUp(function() {
-                    $('.js-icon-pencil-config_var, .js-icon-trash-config_var, #config_var_'+pk).show();
+                    $('.js-icon-pencil-config_var, .js-icon-trash-config_var, #config_var_value_'+pk).show();
                 });
             });
 
             // delete variable
-              $(".js-icon-trash-config_var").click(function (evt) {
-                    var xdata    = evt.target.attributes["x-data"].value.split(":");
-                    var pk       = xdata[0];
-                    $('#config_var_entry_'+pk).slideUp(function() {
-                        //$('#config_var_entry_'+pk).show();
-                    });
-                    postEditAjaxRequest({"configvarDel": evt.target.attributes["x-data"].value});
+            $(".js-icon-trash-config_var").click(function (evt) {
+                var xdata    = evt.target.attributes["x-data"].value.split(":");
+                var pk       = xdata[0];
+
+                // hide the dangling trash tooltip
+                $('#config_var_trash_'+pk).hide();
+
+                // fade out the variable+value div, then refresh the variable list
+                $('#config_var_entry_'+pk).parent().parent().fadeOut(1000, function(){
+                     postEditAjaxRequest({"configvarDel": evt.target.attributes["x-data"].value});
+                });
+
             });
 
         }
@@ -320,9 +383,9 @@
                     }
                 }
                 if (var_context == undefined) {
-                    orightml += '<dt id="config_var_entry_'+configvars_sorted[i][2]+'"><span class="js-config-var-name">'+configvars_sorted[i][0]+'</span><i class="icon-trash js-icon-trash-config_var" x-data="'+configvars_sorted[i][2]+'"></i> </dt>'
+                    orightml += '<div> <dt><span id="config_var_entry_'+configvars_sorted[i][2]+'" class="js-config-var-name"></span><i class="icon-trash js-icon-trash-config_var" id="config_var_trash_'+configvars_sorted[i][2]+'" x-data="'+configvars_sorted[i][2]+'"></i> </dt>'
                     orightml += '<dd class="lead">'
-                    orightml += '    <span id="config_var_'+configvars_sorted[i][2]+'">'+configvars_sorted[i][1]+'</span>'
+                    orightml += '    <span id="config_var_value_'+configvars_sorted[i][2]+'"></span>'
                     orightml += '    <i class="icon-pencil js-icon-pencil-config_var" x-data="'+configvars_sorted[i][2]+'"></i>'
                     orightml += '    <form id="change-config_var-form_'+configvars_sorted[i][2]+'" style="display:none;">'
                     orightml += '        <div class="input-append">'
@@ -331,13 +394,23 @@
                     orightml += '            <button type="button" class="btn btn-link js-cancel-change-config_var" x-data="'+configvars_sorted[i][2]+'">Cancel</button>'
                     orightml += '        </div>'
                     orightml += '    </form>'
-                    orightml += '</dd>'
+                    orightml += '</dd> </div>'
                 }
             }
 
-            // update configvars list
+            // update configvars list HTML framework
             $("dl#configvar-list").html(orightml);
 
+            // insert the name/value pairs safely as non-HTML
+            for (i = 0; i < configvars_sorted.length; i++) {
+                $('#config_var_entry_'+configvars_sorted[i][2]).text(configvars_sorted[i][0]);
+                $('#config_var_value_'+configvars_sorted[i][2]).text(configvars_sorted[i][1]);
+            }
+
+            // Add the tooltips
+            $(".js-icon-trash-config_var").each( function(){ setDeleteTooltip($(this)); });
+            $(".js-icon-pencil-config_var").each(function(){ setChangeTooltip($(this)); });
+
             // re-assert these event handlers
             setEventHandlersForDynamicElements();
         }
@@ -364,13 +437,19 @@
                     headers: { 'X-CSRFToken': $.cookie("csrftoken")},
                     success: onEditAjaxSuccess,
                     error: onEditAjaxError,
-                })
+            })
         }
 
+        function setDeleteTooltip(object) {
+            object.tooltip({ container: 'body', html: true, delay: {show: 400}, title: "Delete" });
+        }
+        function setChangeTooltip(object) {
+            object.tooltip({ container: 'body', html: true, delay: {show: 400}, title: "Change" });
+        }
 
         $(document).ready(function() {
 
-             //
+            //
             // Register handlers for static elements
             //
 
@@ -378,33 +457,37 @@
             $('#change-distro-icon').click(function() {
                 $('#change-distro-icon, #distro').hide();
                 $("#change-distro-form").slideDown();
+                $("#new-distro").val( $('#distro').text() );
             });
 
             $('#cancel-change-distro').click(function(){
                 $("#change-distro-form").slideUp(function() {
                     $('#distro, #change-distro-icon').show();
+
+                    // reset any dangling error state
+                    $('#distro-error-message').text("");
+                    var d = document.getElementById("edit-distro-name-div");
+                    d.className = d.className.replace(" control-group error","");
                 });
             });
 
-            $("#new-distro").on('input', function(){
-                if ($(this).val().length == 0) {
-                    $("#apply-change-distro").attr("disabled","disabled");
-                }
-                else {
-                    $("#apply-change-distro").removeAttr("disabled");
-                }
+            // validate new distro name
+            $("input#new-distro").on('input', function (evt) {
+                validate_distro_name();
             });
 
             $('#apply-change-distro').click(function(){
                 //$('#repo').parent().removeClass('highlight-go');
                 var name = $('#new-distro').val();
                 postEditAjaxRequest({"configvarChange" : 'DISTRO:'+name});
-                $('#distro').html(name);
+                $('#distro').text(name);
                 $("#change-distro-form").slideUp(function () {
                     $('#distro, #change-distro-icon').show();
                 });
             });
 
+            // init IMAGE_FSTYPES trash icon
+            setDeleteTooltip($('#delete-image_install-icon'));
 
             // change IMAGE_FSTYPES variable
             $('#change-image_fstypes-icon').click(function() {
@@ -429,26 +512,57 @@
                     }
                 }
                 document.getElementById("all-image_fstypes").innerHTML = html;
+
+                // Watch elements to disable Save when none are checked
+                $(".fs-checkbox-fstypes").each(function(){
+                    $(this).click(function() {
+                        enableFsTypesSave();
+                    });
+                });
+
+                // clear the previous filter values
+                $("input#filter-image_fstypes").val("");
             });
 
+
             $('#cancel-change-image_fstypes').click(function(){
                 $("#change-image_fstypes-form").slideUp(function() {
                     $('#image_fstypes, #change-image_fstypes-icon').show();
                 });
             });
 
+            $('#filter-image_fstypes').on('input', function(){
+                   var valThis = $(this).val().toLowerCase();
+                $('#all-image_fstypes label').each(function(){
+                    var text = $(this).text().toLowerCase();
+                    var match = text.indexOf(valThis);
+                    if (match >= 0) {
+                        $(this).show();
+                    }
+                    else {
+                        $(this).hide();
+                    }
+                });
+            });
+
             $('#apply-change-image_fstypes').click(function(){
-                var fstypes = '';
+                // extract the selected fstypes and sort them
+                var fstypes_array = [];
                 var checkboxes = document.getElementsByClassName('fs-checkbox-fstypes');
-                for (var i = 0, length = checkboxes.length; i < length; i++) {
-                    if (checkboxes[i].checked) {
-                        fstypes += checkboxes[i].value + ' ';
-                    }
+                $(".fs-checkbox-fstypes:checked").each(function(){
+                       fstypes_array.push($(this).val());
+                });
+                fstypes_array.sort();
+
+                // now make a string of them
+                var fstypes = '';
+                for (var i = 0, length = fstypes_array.length; i < length; i++) {
+                    fstypes += fstypes_array[i] + ' ';
                 }
                 fstypes = fstypes.trim();
 
                 postEditAjaxRequest({"configvarChange" : 'IMAGE_FSTYPES:'+fstypes});
-                $('#image_fstypes').html(fstypes);
+                $('#image_fstypes').text(fstypes);
                 $('#image_fstypes').parent().removeClass('muted');
 
                 $("#change-image_fstypes-form").slideUp(function() {
@@ -459,6 +573,14 @@
 
             // change IMAGE_INSTALL_append variable
             $('#change-image_install-icon').click(function() {
+                // preset the edit value
+                var current_val = $("span#image_install").text();
+                if (current_val == "Not set") {
+                    current_val="";
+                    $("#apply-change-image_install").attr("disabled","disabled");
+                }
+                $("input#new-image_install").val(current_val);
+
                 $('#change-image_install-icon, #delete-image_install-icon, #image_install').hide();
                 $("#change-image_install-form").slideDown();
             });
@@ -466,6 +588,10 @@
             $('#cancel-change-image_install').click(function(){
                 $("#change-image_install-form").slideUp(function() {
                     $('#image_install, #change-image_install-icon').show();
+                    if ($("span#image_install").text() != "Not set") {
+                        $('#delete-image_install-icon').show();
+                        setDeleteTooltip($('#delete-image_install-icon'));
+                    }
                 });
             });
 
@@ -481,12 +607,13 @@
             $('#apply-change-image_install').click(function(){
                 var name = $('#new-image_install').val();
                 postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+name});
-                $('#image_install').html(name);
+                $('#image_install').text(name);
                 $('#image_install').parent().removeClass('muted');
                 $("#change-image_install-form").slideUp(function () {
                     $('#image_install, #change-image_install-icon').show();
                     if (name.length > -1) {
                         $('#delete-image_install-icon').show();
+                        setDeleteTooltip($('#delete-image_install-icon'));
                     }
                });
             });
@@ -497,7 +624,7 @@
                 postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+''});
                 $('#image_install').parent().fadeOut(1000, function(){
                     $('#image_install').parent().addClass('muted');
-                    $('#image_install').html('Not set');
+                    $('#image_install').text('Not set');
                     $('#delete-image_install-icon').hide();
                     $('#image_install').parent().fadeIn(1000);
                 });
@@ -560,7 +687,7 @@
                     if (pc2_checked) val = val + " package_ipk";
                 }
 
-                $('#package_classes').html(val);
+                $('#package_classes').text(val);
                 //$('#package_classes').parent().removeClass('muted');
                 postEditAjaxRequest({"configvarChange" : 'PACKAGE_CLASSES:'+val});
                 $("#change-package_classes-form").slideUp(function() {
@@ -600,7 +727,7 @@
                     }
                 }
                 postEditAjaxRequest({"configvarChange" : 'SDKMACHINE:'+value});
-                $('#sdkmachine').html(value);
+                $('#sdkmachine').text(value);
                 $("#change-sdkmachine-form").slideUp(function() {
                     $('#sdkmachine, #change-sdkmachine-icon').show();
                 });
@@ -610,32 +737,19 @@
 
             // add new variable
             $("button#add-configvar-button").click( function (evt) {
-                var variable = $("input#variable")[0].value;
-                var value    = $("input#value")[0].value;
-
-                if (validate_new_variable_name()) {
-                    postEditAjaxRequest({"configvarAdd" : variable+':'+value});
+                var variable = $("input#variable").val();
+                var value    = $("input#value").val();
 
-                    // clear the previous values
-                    $("input#variable")[0].value = "";
-                    $("input#value")[0].value    = "";
+                postEditAjaxRequest({"configvarAdd" : variable+':'+value});
 
-                }
+                // clear the previous values
+                $("input#variable").val("");
+                $("input#value").val("");
             });
 
-            // validate new variable name
-            $("input#variable").focusout( function (evt) {
-                validate_new_variable_name();
-            });
-
-            //activate / deactivate save added variable button
+            // validate new variable name and value
             $("#variable, #value").on('input', function() {
-                if ( $("#variable").val().length > 0  && $("#value").val().trim().length > 0 ) {
-                    $(".save").removeAttr("disabled");
-                }
-                else {
-                    $(".save").attr("disabled","disabled");
-                }
+                validate_new_variable();
             });
 
             //
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a7f58ad..4a1cdec 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2325,12 +2325,9 @@ if toastermain.settings.MANAGED:
                     variable = t
                     value = ""
 
-                try:
-                    pt = ProjectVariable.objects.get(project = prj, name = variable)
-                    pt.value=value
-                    pt.save()
-                except ObjectDoesNotExist:
-                    print("the entry doesn't exist.")
+                pt, created = ProjectVariable.objects.get_or_create(project = prj, name = variable)
+                pt.value=value
+                pt.save()
             # remove conf variables
             if 'configvarDel' in request.POST:
                 t=request.POST['configvarDel'].strip()
@@ -2338,15 +2335,32 @@ if toastermain.settings.MANAGED:
 
             # return all project settings
             vars_managed,vars_fstypes,vars_blacklist = get_project_configvars_context()
-            return HttpResponse(json.dumps( {
+            return_data = {
                 "error": "ok",
                 'configvars'   : map(lambda x: (x.name, x.value, x.pk), ProjectVariable.objects.filter(project_id = pid).all()),
-                'distro'       : ProjectVariable.objects.get(project = prj, name = "DISTRO").value,
-                'fstypes'      : ProjectVariable.objects.get(project = prj, name = "IMAGE_FSTYPES").value,
-                'image_install_append': ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL_append").value,
-                'package_classes': ProjectVariable.objects.get(project = prj, name = "PACKAGE_CLASSES").value,
-                'sdk_machine'  : ProjectVariable.objects.get(project = prj, name = "SDKMACHINE").value,
-               }), content_type = "application/json")
+               }
+            try:
+                return_data['distro'] = ProjectVariable.objects.get(project = prj, name = "DISTRO").value,
+            except ProjectVariable.DoesNotExist:
+                pass
+            try:
+                return_data['fstypes'] = ProjectVariable.objects.get(project = prj, name = "IMAGE_FSTYPES").value,
+            except ProjectVariable.DoesNotExist:
+                pass
+            try:
+                return_data['image_install_append'] = ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL_append").value,
+            except ProjectVariable.DoesNotExist:
+                pass
+            try:
+                return_data['package_classes'] = ProjectVariable.objects.get(project = prj, name = "PACKAGE_CLASSES").value,
+            except ProjectVariable.DoesNotExist:
+                pass
+            try:
+                return_data['sdk_machine'] = ProjectVariable.objects.get(project = prj, name = "SDKMACHINE").value,
+            except ProjectVariable.DoesNotExist:
+                pass
+
+            return HttpResponse(json.dumps( return_data ), content_type = "application/json")
 
         except Exception as e:
             return HttpResponse(json.dumps({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
@@ -2916,7 +2930,7 @@ if toastermain.settings.MANAGED:
 
         vars_fstypes  = {
             'btrfs','cpio','cpio.gz','cpio.lz4','cpio.lzma','cpio.xz','cramfs',
-            'elf','ext2','ext2.bz2','ext2.gz','ext2.lzma' 'ext3','ext3.gz','hddimg',
+            'elf','ext2','ext2.bz2','ext2.gz','ext2.lzma', 'ext3','ext3.gz','hddimg',
             'iso','jffs2','jffs2.sum','squashfs','squashfs-lzo','squashfs-xz','tar.bz2',
             'tar.lz4','tar.xz','tartar.gz','ubi','ubifs','vmdk'
         }
-- 
1.9.1


