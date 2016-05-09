Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 58159606A8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 23:01:59 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id n129so156450703wmn.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 May 2016 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=95I8flwLSTHezkaskYKILpk7MiLjqFcWUyfpk/dCp3Q=;
	b=LKGx38iOjastU7GBIZUgKTrb6OW64sfHdmxzJV0NGEZG3ujQZkj/liemXj9Ameb8oM
	T8kKvXCQGIBPO9mmfLnzPiVj/HaYwdEZpDLJga9FzR2wuyDssfz+wn1Bt9pos8EkTRFk
	Rn2lNhUfIbLHwApfgdetSrc/V9qAViYsdG40sG2GzgbwEf2z4VhMuuY1nIb/YLFPEy7c
	rte1FTGfd0t9RDiXbLPE1vNTuQzc+q9cwZYsfH3ooUVcZBjuoNKrQB85BUr7/9PPH8pc
	Z8L+XY8RByEoDs2dJ41MUFFvgoMJXZl0uw16xx9uwP111Qsa6laW/k5xcR/YEeK9w5nI
	DR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=95I8flwLSTHezkaskYKILpk7MiLjqFcWUyfpk/dCp3Q=;
	b=I86DgHsoXE6wHSV2cJu5BANVdxl6wv/nf/O/0c2MgXKIO8sv3R6MBxVsMRn8IhWmam
	9qncB2UCEMoBwX5s0/JxoBy5IHHBcEo8A0cFqbDyloVXHZtCqeIsls1mlJZsMB2G/eC/
	IpON01H1oUBDMXxrkuMjr/nnpblBRVzBMXxCen7/ZFWecH/2LP5L8cb2o3nNX3mf/DAV
	qZVkPNer8YEa86mWAqCpcfi4Rw/oLWdb0Y7Vw34Jbd1O0c0ZxPRjuYS0Bm7KYXyzNZJ8
	CB5F4v5D4RjCxphn/Gdx1KbT8JmQfhlZpUegkt/tEDZHHG41FEobQS3s0CfDZLqHxHiQ
	mnoQ==
X-Gm-Message-State: AOPr4FUXeq7HvehMR26dxkaf0T/45ad8nfu7uimMd+UzLTG41w2Zmo5b7Qkrbxrq/Q9//wWQ
X-Received: by 10.28.20.144 with SMTP id 138mr13505385wmu.103.1462834920313;
	Mon, 09 May 2016 16:02:00 -0700 (PDT)
Received: from orion.home (host109-151-244-175.range109-151.btcentralplus.com.
	[109.151.244.175]) by smtp.gmail.com with ESMTPSA id
	b22sm27111436wmb.9.2016.05.09.16.01.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 09 May 2016 16:01:59 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 May 2016 00:01:48 +0100
Message-Id: <1462834912-23449-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
References: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 1/5] toaster: projectNameValidation API added
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
X-List-Received-Date: Mon, 09 May 2016 23:02:00 -0000

From: Sujith H <sujith.h@gmail.com>

The projectNameValidation API would help users
to validate if a project name exists or not. This
API is added to libtoaster.

[YOCTO #7005]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 43930a2..0d1486b 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -374,6 +374,67 @@ var libtoaster = (function (){
     });
   }
 
+  /* Validate project names. Use unique project names
+
+     All arguments accepted by this function are JQeury objects.
+
+     For example if the HTML element has "hint-error-project-name", then
+     it is passed to this function as $("#hint-error-project-name").
+
+     Arg1 - projectName : This is a string object. In the HTML, project name will be entered here.
+     Arg2 - hintEerror : This is a jquery object which will accept span which throws error for
+            duplicate project
+     Arg3 - ctrlGrpValidateProjectName : This object holds the div with class "control-group"
+     Arg4 - enableOrDisableBtn : This object will help the API to enable or disable the form.
+            For example in the new project the create project button will be hidden if the
+            duplicate project exist. Similarly in the projecttopbar the save button will be
+            disabled if the project name already exist.
+
+     Return - This function doesn't return anything. It sets/unsets the behavior of the elements.
+  */
+
+  function _makeProjectNameValidation(projectName, hintError,
+                ctrlGrpValidateProjectName, enableOrDisableBtn ) {
+
+     function checkProjectName(projectName){
+       $.ajax({
+            type: "GET",
+            url: libtoaster.ctx.projectsTypeAheadUrl,
+            data: { 'search' : projectName },
+            headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+            success: function(data){
+              if (data.results.length > 0 &&
+                  data.results[0].name === projectName) {
+                // This project name exists hence show the error and disable
+                // the save button
+                ctrlGrpValidateProjectName.addClass('control-group error');
+                hintError.show();
+                enableOrDisableBtn.attr('disabled', 'disabled');
+              } else {
+                ctrlGrpValidateProjectName.removeClass('control-group error');
+                hintError.hide();
+                enableOrDisableBtn.removeAttr('disabled');
+              }
+            },
+            error: function (data) {
+              console.log(data);
+            },
+       });
+     }
+
+     /* The moment user types project name remove the error */
+     projectName.on("input", function() {
+        var projectName = $(this).val();
+        checkProjectName(projectName)
+     });
+
+     /* Validate new project name */
+     projectName.on("blur", function(){
+        var projectName = $(this).val();
+        checkProjectName(projectName)
+     });
+  }
+
 
   return {
     reload_params : reload_params,
@@ -390,6 +451,7 @@ var libtoaster = (function (){
     makeLayerAddRmAlertMsg : _makeLayerAddRmAlertMsg,
     showChangeNotification : _showChangeNotification,
     createCustomRecipe: _createCustomRecipe,
+    makeProjectNameValidation: _makeProjectNameValidation,
   };
 })();
 
-- 
2.7.4


