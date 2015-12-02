Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f177.google.com (mail-pf0-f177.google.com
	[209.85.192.177])
	by mail.openembedded.org (Postfix) with ESMTP id 98BE06FFAB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:59 +0000 (UTC)
Received: by pfdd184 with SMTP id d184so1144295pfd.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 10:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=1NkATYXxou0i/vW8WjoRtEAw+EYMX5c1uwe1JRzxtyg=;
	b=HUOpAqZ8cU054Bz97tNa/8uRyHjvjrCV239542Cs6hHfnylugdE5rvLNAqCsuDnsgr
	xZiLRkaSx1wuYiS/vPYx2h18xwyUctYxnpFPSn3mIZm7QfYQHgCNXsJ6pVHkkcOeu9jG
	/tW09aA5ZTwSRj4g9u6WIch58hZHIBxin9kMlbJsfwy9LZ1/J2ECiaMGDcTreoPbkyEl
	azyiGvQHxYlsxn9GeSLZicfbWBTJDpBLW3Ewp3ntTjIZbrOa7lomWGbQN3qynCWxWLsp
	EF5ces4upJEio8fw5bS9vCqAyK+pCkMXmVhdz4YJ54rv1rWEoQiV60ZWta9jVF6PnoUf
	pJ+Q==
X-Received: by 10.98.14.207 with SMTP id 76mr6567168pfo.86.1449079200311;
	Wed, 02 Dec 2015 10:00:00 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:59 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:57 -0800
Message-Id: <2e4fa82e97a0c3b9b67eb0a7fcd344c32c6fffd1.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 25/30] toaster: remove SDKMACHINE from project variables
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:59 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed SDKMACHINE from predefined set of variables
for the project as it causes bitbake build error:
   SDKMACHINE is set, but SDK_ARCH has not been changed as a result

This variable does not need to be predefined as it's not used by
toaster.

It's still possible to specify it in project configuration
if needed. SDK_ARCH variable should be set too to avoid above
mentioned build failure.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/projectconf.html | 70 +----------------------
 lib/toaster/toastergui/views.py                   |  9 ---
 2 files changed, 1 insertion(+), 78 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index 30fd03e..08223da 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -107,32 +107,6 @@
                 </form>
             </dd>
             {% endif %}
-
-            {% if sdk_machine_defined %}
-            <dt>
-                <span class="js-config-var-name js-config-var-managed-name">SDKMACHINE</span>
-                <i class="icon-question-sign get-help" title="Specifies the architecture (i.e. i686 or x86_64) for which to build SDK and ADT items <br /><a href='http://www.yoctoproject.org/docs/1.6.1/ref-manual/ref-manual.html#var-SDKMACHINE' target='_blank'>Read more in the manual</a>"></i>
-            </dt>
-            <dd class="lead">
-                <span id="sdkmachine">{{sdk_machine}}</span>
-                <i id="change-sdkmachine-icon" class="icon-pencil"></i>
-                <form id="change-sdkmachine-form" style="display:none;">
-                    <label class="radio">
-                        <input type="radio" name="sdkmachine" value="i686">
-                        i686
-                    </label>
-                    <label class="radio">
-                        <input type="radio" name="sdkmachine" value="x86_64">
-                        x86_64
-                    </label>
-                    <div style="padding-top:10px;">
-                        <button id="apply-change-sdkmachine" type="button" class="btn">Save</button>
-                        <button id="cancel-change-sdkmachine" type="button" class="btn btn-link">Cancel</button>
-                    </div>
-                </form>
-            </dd>
-            {% endif %}
-
         </dl>
 
         <!-- <ul class="unstyled configuration-list" id="configvar-list"> -->
@@ -774,48 +748,6 @@
             });
             {% endif %}
 
-
-            {% if sdk_machine_defined %}
-            // change SDKMACHINE variable
-            $('#change-sdkmachine-icon').click(function() {
-                var current_value = document.getElementById("sdkmachine").innerHTML;
-                var radios = document.getElementsByName('sdkmachine');
-                for (var i = 0, length = radios.length; i < length; i++) {
-                    radios[i].checked = false;
-                    if (radios[i].value == current_value) {
-                        radios[i].checked = true;
-                    }
-                }
-                $('#change-sdkmachine-icon, #sdkmachine').hide();
-                $("#change-sdkmachine-form").slideDown();
-            });
-
-            $('#cancel-change-sdkmachine').click(function(){
-                $("#change-sdkmachine-form").slideUp(function() {
-                    $('#sdkmachine, #change-sdkmachine-icon').show();
-                });
-            });
-
-            $('#apply-change-sdkmachine').click(function(){
-                var value="";
-                var radios = document.getElementsByName('sdkmachine');
-                for (var i = 0, length = radios.length; i < length; i++) {
-                    if (radios[i].checked) {
-                        // do whatever you want with the checked radio
-                        value=radios[i].value;
-                        break;
-                    }
-                }
-                postEditAjaxRequest({"configvarChange" : 'SDKMACHINE:'+value});
-                $('#sdkmachine').text(value);
-                $("#change-sdkmachine-form").slideUp(function() {
-                    $('#sdkmachine, #change-sdkmachine-icon').show();
-                });
-
-            });
-            {% endif %}
-
-
             // add new variable
             $("button#add-configvar-button").click( function (evt) {
                 var variable = $("input#variable").val();
@@ -830,7 +762,7 @@
                 $(".save").attr("disabled","disabled");
 
                 // Reload page if admin-removed core managed value is manually added back in
-                if (0 <= " DISTRO IMAGE_FSTYPES IMAGE_INSTALL_append PACKAGE_CLASSES SDKMACHINE ".indexOf( " "+variable+" " )) {
+                if (0 <= " DISTRO IMAGE_FSTYPES IMAGE_INSTALL_append PACKAGE_CLASSES ".indexOf( " "+variable+" " )) {
                     // delayed reload to avoid race condition with postEditAjaxRequest
                     do_reload=true;
                 }
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 69f5af0..243bb09 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2456,10 +2456,6 @@ if True:
                 return_data['package_classes'] = ProjectVariable.objects.get(project = prj, name = "PACKAGE_CLASSES").value,
             except ProjectVariable.DoesNotExist:
                 pass
-            try:
-                return_data['sdk_machine'] = ProjectVariable.objects.get(project = prj, name = "SDKMACHINE").value,
-            except ProjectVariable.DoesNotExist:
-                pass
 
             return HttpResponse(json.dumps( return_data ), content_type = "application/json")
 
@@ -2868,11 +2864,6 @@ if True:
             context['package_classes_defined'] = "1"
         except ProjectVariable.DoesNotExist:
             pass
-        try:
-            context['sdk_machine'] =  ProjectVariable.objects.get(project = prj, name = "SDKMACHINE").value
-            context['sdk_machine_defined'] = "1"
-        except ProjectVariable.DoesNotExist:
-            pass
 
         return context
 
-- 
1.9.1


