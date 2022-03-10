Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31327C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 13:53:49 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web12.9652.1646920428457010188
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 05:53:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NuK7DAGN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id q14so8108126wrc.4
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 05:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjGNPlbxOZqGiKjfUGvkAWM0slZj2dLlksM2XLcm66A=;
        b=NuK7DAGNY4G+KI29oNLy86iu2mOK9kazNybfqRcirmnjZ140d5SXkEYrgX57z6XXNG
         8ItDoab/fsb68HXF1x2l4rYNiD/DVEtDMcA9GdT9xvpFP0H0iEwp7GN175avmnWjTk/6
         TWmuVEshOrV8a0GqFaDC101zpXHHerbWsSLeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjGNPlbxOZqGiKjfUGvkAWM0slZj2dLlksM2XLcm66A=;
        b=3BU26WJOFFifVV+WQJkjBKcM9MHiEOoa1jjwJUGNVtbio7khPrZzseXmj375GyANcI
         kjJm19gt3Z0PKgsiQ2IM4+SJEg88n3X99bvNkpskFMv+oXu6SHfpEpaCwj+kBsmREioY
         AJ8a0YJqw77Z0VwYpLcGRBSfAOfoV4Q+X8DjuwK7BWdwGPPOwQQFlqP9ce6bUOGfqxM8
         0C5Tw2gqJgJn1huJ786CAHNuIpSMWUkpcBLje9LtQA3yyXty+THN0Zxn3uzm2gflU8XK
         bYe4SA/0KeM0SXvCV1WyKGu3AWr9EglQeMwwjtqhkRmqCLqMzpb1HtFK4XjgRbONYtLV
         ntww==
X-Gm-Message-State: AOAM530xiQLWh5josfKdADfhMZT0vNwPqqj6HvnBZOBOc/9obL1awZAy
	4efEceh9Vc6JPX/G4xWfk7TD9P/9UUJJUzf/
X-Google-Smtp-Source: 
 ABdhPJw3AY0LazLedyDoa8n6ziLF5Mhb44zSMUUlCSCgr7Vbe8DMkX0hvHhcREuF8ORroFsO67AQmQ==
X-Received: by 2002:a5d:63cf:0:b0:1f0:7916:6a39 with SMTP id
 c15-20020a5d63cf000000b001f079166a39mr3799621wrw.500.1646920426437;
        Thu, 10 Mar 2022 05:53:46 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4dd4:e08f:40b6:a45e])
        by smtp.gmail.com with ESMTPSA id
 l10-20020a056000022a00b001f017dfb5cdsm5604141wrz.90.2022.03.10.05.53.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:53:45 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster: Fix IMAGE_INSTALL issues with _append vs :append
Date: Thu, 10 Mar 2022 13:53:44 +0000
Message-Id: <20220310135344.612089-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 13:53:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13465

After the override syntax change, toaster isn't working correctly. This
is because it uses IMAGE_INSTALL_append instead of IMAGE_INSTALL:append.

This tweaks the code accordingly to fix this.

I have a suspicion that exiting toaster databases may struggle with
the change and there are some migration steps missing for the whole
overrides syntax change step.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/settings.xml            |  2 +-
 lib/toaster/orm/models.py                        |  2 +-
 .../toastergui/templates/projectconf.html        | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/orm/fixtures/settings.xml b/lib/toaster/orm/fixtures/settings.xml
index 78c0fdca7f..ab3ea021f5 100644
--- a/lib/toaster/orm/fixtures/settings.xml
+++ b/lib/toaster/orm/fixtures/settings.xml
@@ -19,7 +19,7 @@
     <field type="CharField" name="value">${TOPDIR}/../sstate-cache</field>
   </object>
   <object model="orm.toastersetting" pk="6">
-    <field type="CharField" name="name">DEFCONF_IMAGE_INSTALL_append</field>
+    <field type="CharField" name="name">DEFCONF_IMAGE_INSTALL:append</field>
     <field type="CharField" name="value"></field>
   </object>
   <object model="orm.toastersetting" pk="7">
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4c94b407d7..6d772367d8 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1717,7 +1717,7 @@ class CustomImageRecipe(Recipe):
 
     def generate_recipe_file_contents(self):
         """Generate the contents for the recipe file."""
-        # If we have no excluded packages we only need to _append
+        # If we have no excluded packages we only need to :append
         if self.excludes_set.count() == 0:
             packages_conf = "IMAGE_INSTALL:append = \" "
 
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index d62691df1d..3b91b6679b 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -73,7 +73,7 @@
 
     {% if image_install_append_defined %}
     <dt>
-    <span class="js-config-var-name js-config-var-managed-name">IMAGE_INSTALL_append</span>
+    <span class="js-config-var-name js-config-var-managed-name">IMAGE_INSTALL:append</span>
     <span class="glyphicon glyphicon-question-sign get-help" title="Specifies additional packages to install into an image. If your build creates more than one image, the packages will be installed in all of them"></span>
     </dt>
     <dd class="variable-list">
@@ -83,7 +83,7 @@
     <form id="change-image_install-form" class="form-inline" style="display:none;">
       <div class="row">
         <div class="col-md-4">
-          <span class="help-block">To set IMAGE_INSTALL_append to more than one package, type the package names separated by a space.</span>
+          <span class="help-block">To set IMAGE_INSTALL:append to more than one package, type the package names separated by a space.</span>
         </div>
       </div>
       <div class="form-group">
@@ -771,10 +771,10 @@ $(document).ready(function() {
 
   {% if image_install_append_defined %}
 
-  // init IMAGE_INSTALL_append trash icon
+  // init IMAGE_INSTALL:append trash icon
   setDeleteTooltip($('#delete-image_install-icon'));
 
-  // change IMAGE_INSTALL_append variable
+  // change IMAGE_INSTALL:append variable
   $('#change-image_install-icon').click(function() {
     // preset the edit value
     var current_val = $("span#image_install").text().trim();
@@ -814,7 +814,7 @@ $(document).ready(function() {
   $('#apply-change-image_install').click(function(){
     // insure these non-empty values have single space prefix
     var value = " " + $('#new-image_install').val().trim();
-    postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+value});
+    postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL:append:'+value});
     $('#image_install').text(value);
     $('#image_install').removeClass('text-muted');
     $("#change-image_install-form").slideUp(function () {
@@ -826,10 +826,10 @@ $(document).ready(function() {
     });
   });
 
-  // delete IMAGE_INSTALL_append variable value
+  // delete IMAGE_INSTALL:append variable value
   $('#delete-image_install-icon').click(function(){
     $(this).tooltip('hide');
-    postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL_append:'+''});
+    postEditAjaxRequest({"configvarChange" : 'IMAGE_INSTALL:append:'+''});
     $('#image_install').parent().fadeOut(1000, function(){
       $('#image_install').addClass('text-muted');
       $('#image_install').text('Not set');
@@ -1011,7 +1011,7 @@ $(document).ready(function() {
     $(".save").attr("disabled","disabled");
 
     // Reload page if admin-removed core managed value is manually added back in
-    if (0 <= " DISTRO DL_DIR IMAGE_FSTYPES IMAGE_INSTALL_append PACKAGE_CLASSES SSTATE_DIR ".indexOf( " "+variable+" " )) {
+    if (0 <= " DISTRO DL_DIR IMAGE_FSTYPES IMAGE_INSTALL:append PACKAGE_CLASSES SSTATE_DIR ".indexOf( " "+variable+" " )) {
       // delayed reload to avoid race condition with postEditAjaxRequest
       do_reload=true;
     }
-- 
2.32.0


