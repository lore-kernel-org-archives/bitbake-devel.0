Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 265A0771EA
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:38 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id l6so73381517wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=l3dNkyrcPtQ7sI2kaJgcESdv/ck1vlza1wnZ6sAlR4M=;
	b=Qb0yS99W/jPbY6DWmplVO6Dep9ro+hOchaHEyfzwcmryGJk9fL+soIyWbVmRg6ElFy
	oJE+qTKbjekPLBESgiB8SUs65XUXGY4YEs4dpf5sTs63eg9CKxLAlDsVBnsogN7+2EtN
	ZpZRWuqCUAxZay24P3ET2mB1ePgaxJGnK8JR4pFtuaWmniJ8PP+q/AZfO3K1c2GEPg85
	fIjWH5UDbJc+OI5LCHZKcwfIwOtbVA1Js0nlmcC0d18cD/AKHLqm/kZTshglfgKRIlqk
	/Ps3qf1rKmGhWVfs8rsElgTUpMZ5rDcbNC166RDQYCCtgJyp9aoIDYPuFreGhSvM0FzE
	3Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=l3dNkyrcPtQ7sI2kaJgcESdv/ck1vlza1wnZ6sAlR4M=;
	b=c4y8Pdx5p6WsaCVdA6G8w7prag5BoRRCCrCC5FPZv/l81QifisDgSMTDQODp7z8I0u
	gJznFVrIDpW0JnkcMHo6xY7QX57E8PwWyb4AtnryzAFXZ12rjAXU2K2SpqJntrFmrTsw
	Pyp+GE1yK8THpk1Horqkj3FNBpkz7CqYCIIaQvojrGMoi2XLcrZVJ5paJQ5b2d5PTU4w
	hQoxHYJBz9IBm2CMEFQoiRfaLWS2Q2WEhPhfctwixdT3iNHkyt51BPJx+R7tomNSsT3O
	6j9NFooQX5anWg0kiKMyEuWiJ1ycrLpmZ7zM5vXMGIHHR7DC2HNjKONQ4ygv+hLWyqDE
	y6Lg==
X-Gm-Message-State: AD7BkJKo/LtMnxeO4Jx84GO2rl+MU/1k+RhzXqvwj1ublloLQ0XONYfa+mEdmUkqD+XUlKm6
X-Received: by 10.194.119.201 with SMTP id kw9mr27725547wjb.173.1459961258701; 
	Wed, 06 Apr 2016 09:47:38 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:38 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:44 +0100
Message-Id: <d8b544c569ce3f1e1bdae70ad4e61ce6394dadde.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 34/38] toaster: update projectconf.html for DL_DIR and SSTATE_DIR
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:38 -0000

From: Sujith H <sujith.h@gmail.com>

Modified the projectconf.html to include DL_DIR and
SSTATE_DIR. Updated the script section in the html
to handle the changes made by the user on DL_DIR
and SSTATE_DIR. Included validation check for the
folder names.

[YOCTO #8422]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/projectconf.html | 160 +++++++++++++++++++++-
 1 file changed, 157 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index 08223da..27a898b 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -31,6 +31,28 @@
             </dd>
             {% endif %}
 
+            {% if dl_dir_defined %}
+            <dt>
+                <span class="js-config-var-name js-config-var-managed-name">DL_DIR</span>
+                <i class="icon-question-sign get-help" title="Absolute path to the directory used to store downloads required for your builds. By default, Toaster projects share the same downloads directory.<br /><a href='http://www.yoctoproject.org/docs/2.1/ref-manual/ref-manual.html#var-DL_DIR' target='_blank'>Read more in the manual</a>"></i>
+            </dt>
+            <dd class="lead">
+                <span id="dl_dir"{% if dl_dir %}{%else%} class="muted"{%endif%}>{% if dl_dir %}{{dl_dir}}{%else%}Not set{%endif%}</span>
+                <i class="icon-pencil" id="change-dl_dir-icon"></i>
+                <form id="change-dl_dir-form" style="display:none;">
+                    <div class="row-fluid">
+                        <span class="help-block span4">To set DL_DIR type the absolute path of the download folder.</span>
+                    </div>
+                    <div class="input-append" id="validate-dl_dir">
+                        <input type="text" class="input-xlarge" id="new-dl_dir" placeholder="Type absolute path of the DL_DIR folder">
+                        <button id="apply-change-dl_dir" class="btn" type="button">Save</button>
+                        <button id="cancel-change-dl_dir" type="button" class="btn btn-link">Cancel</button>
+			</br><span class="help-block error" id="hintError-dl_dir">A valid directory cannot include spaces or any of these characters: . \ ? % * : | " " < ></span>
+                    </div>
+                </form>
+            </dd>
+            {% endif %}
+
             {% if fstypes_defined %}
             <dt>
                 <span class="js-config-var-name js-config-var-managed-name">IMAGE_FSTYPES</span>
@@ -107,6 +129,29 @@
                 </form>
             </dd>
             {% endif %}
+
+            {% if sstate_dir_defined %}
+            <dt>
+                <span class="js-config-var-name js-config-var-managed-name">SSTATE_DIR</span>
+                <i class="icon-question-sign get-help" title="Absolute path to the directory used to store shared state cache files. These files are reused across the builds, which makes the builds faster. By default, Toaster projects share the same cache directory.<br /><a href='http://www.yoctoproject.org/docs/2.1/ref-manual/ref-manual.html#var-SSTATE_DIR' target='_blank'>Read more in the manual</a>"></i>
+            </dt>
+            <dd class="lead">
+                <span id="sstate_dir"{% if sstate_dir %}{%else%} class="muted"{%endif%}>{% if sstate_dir %}{{sstate_dir}}{%else%}Not set{%endif%}</span>
+                <i class="icon-pencil" id="change-sstate_dir-icon"></i>
+                <form id="change-sstate_dir-form" style="display:none;">
+                    <div class="row-fluid">
+                        <span class="help-block span4">To set SSTATE_DIR type the absolute path of the download folder.</span>
+                    </div>
+                    <div class="input-append" id="validate-sstate_dir">
+                        <input type="text" class="input-xlarge" id="new-sstate_dir" placeholder="Type absolute path of the SSTATE_DIR folder">
+                        <span class="error">A valid directory name required</span>
+                        <button id="apply-change-sstate_dir" class="btn" type="button">Save</button>
+                        <button id="cancel-change-sstate_dir" type="button" class="btn btn-link">Cancel</button>
+			</br><p class="help-block error" id="hintError-sstate_dir">A valid directory cannot include spaces or any of these characters: . \ ? % * : | " " < ></span>
+                    </div>
+                </form>
+            </dd>
+            {% endif %}
         </dl>
 
         <!-- <ul class="unstyled configuration-list" id="configvar-list"> -->
@@ -156,9 +201,7 @@
                     <code><a href="http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-BB_NUMBER_THREADS" target="_blank">BB_NUMBER_THREADS</a></code>
                     <code>CVS_PROXY_HOST</code>
                     <code>CVS_PROXY_PORT</code>
-                    <code><a href="http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-DL_DIR" target="_blank">DL_DIR</a></code>
                     <code><a href="http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-PARALLEL_MAKE" target="_blank">PARALLEL_MAKE</a></code>
-                    <code><a href="http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-SSTATE_DIR" target="_blank">SSTATE_DIR</a></code>
                     <code><a href="http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-SSTATE_MIRRORS" target="_blank">SSTATE_MIRRORS</a></code>
                     <code><a href="http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-TMPDIR" target="_blank">TMPDIR</a></code></p>
                     <p>Plus the following standard shell environment variables:</p>
@@ -501,6 +544,61 @@
             });
             {% endif %}
 
+            {% if dl_dir_defined %}
+
+            // change DL_DIR variable
+            $('#change-dl_dir-icon').click(function() {
+                $('#hintError-dl_dir').hide();
+	        // preset the edit value
+                var current_val = $("span#dl_dir").text().trim();
+                if (current_val == "Not set") {
+                    current_val="";
+                    $("#apply-change-dl_dir").attr("disabled","disabled");
+                }
+                $("input#new-dl_dir").val(current_val);
+
+                $('#change-dl_dir-icon, #dl_dir').hide();
+                $("#change-dl_dir-form").slideDown();
+            });
+
+            $('#cancel-change-dl_dir').click(function(){
+                $("#change-dl_dir-form").slideUp(function() {
+                    $('#dl_dir, #change-dl_dir-icon').show();
+                });
+            });
+
+            $("#new-dl_dir").on('input', function(){
+	        if ($(this).val().trim().length == 0) {
+                    $("#apply-change-dl_dir").attr("disabled","disabled");
+                }
+                else {
+                    var input = $(this);
+                    var re = /^\/([^ <>\\|":\.%\?\*]+)$/;
+	            var invalidDir = re.test(input.val());
+		    console.log(invalidDir);
+                    if ( invalidDir ) {
+                        $('#validate-dl_dir').removeClass('control-group error');
+			$("#apply-change-dl_dir").removeAttr("disabled");
+                        $('#hintError-dl_dir').hide();
+                    } else {
+                        $('#validate-dl_dir').addClass('control-group error');
+			$("#apply-change-dl_dir").attr("disabled","disabled");
+                        $('#hintError-dl_dir').show();
+                    }
+                }
+            });
+
+            $('#apply-change-dl_dir').click(function(){
+                var value = $('#new-dl_dir').val().trim();
+                postEditAjaxRequest({"configvarChange" : 'DL_DIR:'+value});
+                $('#dl_dir').text(value);
+                $('#dl_dir').removeClass('muted');
+                $("#change-dl_dir-form").slideUp(function () {
+                    $('#dl_dir, #change-dl_dir-icon').show();
+               });
+            });
+
+            {% endif %}
 
             {% if fstypes_defined %}
             // change IMAGE_FSTYPES variable
@@ -748,6 +846,62 @@
             });
             {% endif %}
 
+            {% if sstate_dir_defined %}
+
+            // change SSTATE_DIR variable
+            $('#change-sstate_dir-icon').click(function() {
+                $('#hintError-sstate_dir').hide();
+                // preset the edit value
+                var current_val = $("span#sstate_dir").text().trim();
+                if (current_val == "Not set") {
+                    current_val="";
+                    $("#apply-change-sstate_dir").attr("disabled","disabled");
+                }
+                $("input#new-sstate_dir").val(current_val);
+
+                $('#change-sstate_dir-icon, #sstate_dir').hide();
+                $("#change-sstate_dir-form").slideDown();
+            });
+
+            $('#cancel-change-sstate_dir').click(function(){
+                $("#change-sstate_dir-form").slideUp(function() {
+                    $('#sstate_dir, #change-sstate_dir-icon').show();
+                });
+            });
+
+            $("#new-sstate_dir").on('input', function(){
+                if ($(this).val().trim().length == 0) {
+                    $("#apply-change-sstate_dir").attr("disabled","disabled");
+                }
+                else {
+                    var input = $(this);
+                    var re = /^\/([^ <>\\|":\.%\?\*]+)$/;
+	            var invalidDir = re.test(input.val());
+		    console.log(invalidDir);
+                    if ( invalidDir ) {
+                        $('#validate-sstate_dir').removeClass('control-group error');
+			$("#apply-change-sstate_dir").removeAttr("disabled");
+                        $('#hintError-sstate_dir').hide();
+                    } else {
+                        $('#validate-sstate_dir').addClass('control-group error');
+			$("#apply-change-sstate_dir").attr("disabled","disabled");
+                        $('#hintError-sstate_dir').show();
+                    }
+                }
+            });
+
+            $('#apply-change-sstate_dir').click(function(){
+                var value = $('#new-sstate_dir').val().trim();
+                postEditAjaxRequest({"configvarChange" : 'SSTATE_DIR:'+value});
+                $('#sstate_dir').text(value);
+                $('#sstate_dir').removeClass('muted');
+                $("#change-sstate_dir-form").slideUp(function () {
+                    $('#sstate_dir, #change-sstate_dir-icon').show();
+               });
+            });
+
+            {% endif %}
+
             // add new variable
             $("button#add-configvar-button").click( function (evt) {
                 var variable = $("input#variable").val();
@@ -762,7 +916,7 @@
                 $(".save").attr("disabled","disabled");
 
                 // Reload page if admin-removed core managed value is manually added back in
-                if (0 <= " DISTRO IMAGE_FSTYPES IMAGE_INSTALL_append PACKAGE_CLASSES ".indexOf( " "+variable+" " )) {
+                if (0 <= " DISTRO DL_DIR IMAGE_FSTYPES IMAGE_INSTALL_append PACKAGE_CLASSES SSTATE_DIR ".indexOf( " "+variable+" " )) {
                     // delayed reload to avoid race condition with postEditAjaxRequest
                     do_reload=true;
                 }
-- 
2.1.4


