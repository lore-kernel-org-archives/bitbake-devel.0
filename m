Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 95DE575A06
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:35:06 +0000 (UTC)
Received: by wicnd19 with SMTP id nd19so13679700wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=RnoPBytW1nIjMKjO1NFnoIpeSKuU19x6a3P5mGyJbfE=;
	b=blA3q/XVnnJAqOmYHK+u3piIQSKSd/2qd0yjOwInNMrC0jcbT9QovX7xcbdupy1igH
	tx2cmXqo0Qba1tUG2f81l16FtBN7lg9cnYIcI4+PSvYmqfW+Xt6a4evakX4JRnp8Ttix
	bW9FnSQTrGmEhQswzYLIrOZx5rk1WYSVNSIeES0cNA8aSB1fLypkXjkLPz2pkqigHST3
	5pUPuiQwwjlT5MvI/ppsCeqoYrV3LBkob49XZrXI4jF1OAg1z73GVQInM2msfE5HTamS
	kc/SRaeCZcGTyd8IZhYVTHLSO3DgoCRF6ZWNPdPLF5jyvq7nvgh6OYEnv/5ZEIZIKJJ/
	UKLg==
X-Gm-Message-State: ALoCoQnLbTnVRoQ1iV66tupMxog28Ty4rjJEI3RGPmv43CVy0gkSzaOQpQCVhErtqn6DyK4dZ6W7
X-Received: by 10.194.238.233 with SMTP id vn9mr80510682wjc.24.1435228507726; 
	Thu, 25 Jun 2015 03:35:07 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id c2sm42106940wjf.18.2015.06.25.03.35.06
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:35:06 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E2F20562963; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:56 +0100
Message-Id: <a73f08c79077b6ded0c08ea7d36032f4568d12e3.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 19/23] toaster: table.js fix filter visual indicator and interaction
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
X-List-Received-Date: Thu, 25 Jun 2015 10:35:07 -0000

From: Michael Wood <michael.g.wood@intel.com>

- Fix the id of the filter modal dialog.
- Fix the visual indicator toggle button
- Add check to see if the number of items to filter on is !=0 if it is
  then don't allow applying this filter.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 59 +++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 1072c75..d06a3f5 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -261,23 +261,14 @@ function tableInit(ctx){
         var filterBtn = $('<a href="#" role="button" class="pull-right btn btn-mini" data-toggle="modal"><i class="icon-filter filtered"></i></a>');
 
         filterBtn.data('filter-name', col.filter_name);
+        filterBtn.prop('id', col.filter_name);
         filterBtn.click(filterOpenClicked);
 
         /* If we're currently being filtered setup the visial indicator */
         if (tableParams.filter &&
             tableParams.filter.match('^'+col.filter_name)) {
 
-            filterBtn.addClass("btn-primary");
-
-            filterBtn.tooltip({
-                html: true,
-                title: '<button class="btn btn-small btn-primary" onClick=\'$("#clear-filter-btn").click();\'>Clear filter</button>',
-                placement: 'bottom',
-                delay: {
-                  hide: 1500,
-                  show: 400,
-                },
-            });
+            filterBtnActive(filterBtn, true);
         }
         header.append(filterBtn);
       }
@@ -310,6 +301,26 @@ function tableInit(ctx){
     tableChromeDone = true;
   }
 
+  /* Toggles the active state of the filter button */
+  function filterBtnActive(filterBtn, active){
+    if (active) {
+      filterBtn.addClass("btn-primary");
+
+      filterBtn.tooltip({
+          html: true,
+          title: '<button class="btn btn-small btn-primary" onClick=\'$("#clear-filter-btn-'+ ctx.tableName +'").click();\'>Clear filter</button>',
+          placement: 'bottom',
+          delay: {
+            hide: 1500,
+            show: 400,
+          },
+      });
+    } else {
+      filterBtn.removeClass("btn-primary");
+      filterBtn.tooltip('destroy');
+    }
+  }
+
   /* Display or hide table columns based on the cookie preference or defaults */
   function loadColumnsPreference(){
     var cookie_data = $.cookie("cols");
@@ -427,6 +438,10 @@ function tableInit(ctx){
 
             var radioInput = action.children("input");
 
+            if (Number(filterAction.count) == 0){
+              radioInput.attr("disabled", "disabled");
+            }
+
             action.children(".filter-title").text(actionTitle);
 
             radioInput.val(filterName + ':' + filterAction.name);
@@ -475,7 +490,13 @@ function tableInit(ctx){
 
     tableParams.page = 1;
     tableParams.search = searchTerm;
-    tableParams.filter = null;
+
+    /* If a filter was active we remove it */
+    if (tableParams.filter) {
+      var filterBtn = $("#" + tableParams.filter.split(":")[0]);
+      filterBtnActive(filterBtn, false);
+      tableParams.filter = null;
+    }
 
     loadData(tableParams);
 
@@ -504,6 +525,9 @@ function tableInit(ctx){
   });
 
   $("#clear-filter-btn-"+ctx.tableName).click(function(){
+    var filterBtn = $("#" + tableParams.filter.split(":")[0]);
+    filterBtnActive(filterBtn, false);
+
     tableParams.filter = null;
     loadData(tableParams);
   });
@@ -513,13 +537,18 @@ function tableInit(ctx){
 
     tableParams.filter = $(this).find("input[type='radio']:checked").val();
 
+    var filterBtn = $("#" + tableParams.filter.split(":")[0]);
+
     /* All === remove filter */
-    if (tableParams.filter.match(":all$"))
+    if (tableParams.filter.match(":all$")) {
       tableParams.filter = null;
+      filterBtnActive(filterBtn, false);
+    } else {
+      filterBtnActive(filterBtn, true);
+    }
 
     loadData(tableParams);
 
-
-    $('#filter-modal').modal('hide');
+    $(this).parent().modal('hide');
   });
 }
-- 
1.9.1


