Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 4849D62133
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:28:58 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id e201so20499875wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IvvHx65bx/992g1jHO3sqsO5E4+BB6LsDMPh7awGHag=;
	b=Cwld3HgSQh9W2kCA5H3b/5dewvo0Zclawu2T0IPWBWDptuf2H/aOBWDOM2Lh0RJrKT
	Pig+/+IuzDQ0OovO7KVadyAshBs5O7Rj8QhYs/xMUaKXkanUHbIlBl4Wh5Cepiukgcfp
	xk58osz8J0g54DRbstrm9wNbSXmNd8+gs7I2idkmYcEggRbCAjNtc8cumaDi70ITHynl
	017zBbEO1LcMiL92w8hZELyqY6/NA0fPd3/9TO57Jyp4r+9+785SE8S1vGcFqTDsOf5J
	w8J1FkxT2RgTYa0lpWzP0xg3b6UiNvzElG+ACUQ1fBvZS5HjVLFl+ruFIjb0hNtS0Vzy
	YSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IvvHx65bx/992g1jHO3sqsO5E4+BB6LsDMPh7awGHag=;
	b=VaaawOxn7aRTfdpW1aLhSaZ0sMqbEMadEnLmmtEtHtMdpCQvebPIXG/sah8DpCfGG8
	zWfjwEPM3HSb4n6wkBbIannAZWwT92Mhdrhfxp47JcEVhWFtzfKuIn1OIXwBOMtSmrF1
	bkU3uHThzpPfTxixu4A90SEtlXpDmTt3N6PJzWAR9Hwwc3pJr3KQxz+FWwgnjhmukrkW
	ySMaw0OQYxEcLE6KykohmwRwp6q3rtkn2VjSzg9ldfXwC9QAsNMtDzyRw0lqgWij4JmD
	xXZXiUEeNapMUlnCPiMFHJMkhPgJJbEcP5AvukhQzv1Q3TnW0lv2LTKcZSSngZdDSkTK
	htCw==
X-Gm-Message-State: AOPr4FWCCB8UC4uS1OY8ktU7QKqGHF9FNaJBr3jGRRTWTjM5+pVEK96ItuPHwnGHnQgJcb9z
X-Received: by 10.194.3.105 with SMTP id b9mr4320535wjb.140.1461083339279;
	Tue, 19 Apr 2016 09:28:59 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.28.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:28:58 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:41 +0100
Message-Id: <1461083327-11668-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
References: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 04/10] toaster: only prevent duplicate custom image names within a project
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
X-List-Received-Date: Tue, 19 Apr 2016 16:28:59 -0000

From: Elliot Smith <elliot.smith@intel.com>

We currently prevent the same name being used for multiple custom
images, but make the check across all projects. This means that
custom image names have to be unique across all projects in
the Toaster installation.

Modify how we validate the name of a custom image so that we
only prevent duplication of custom image names within a project,
while ensuring that the name of a custom image doesn't duplicate
the name of a recipe which is not a custom image recipe.

[YOCTO #9209]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../toastergui/static/js/newcustomimage_modal.js   |  8 ++++--
 lib/toaster/toastergui/views.py                    | 33 ++++++++++++----------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/newcustomimage_modal.js b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
index 328997a..98e87f4 100644
--- a/lib/toaster/toastergui/static/js/newcustomimage_modal.js
+++ b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
@@ -9,6 +9,8 @@ function newCustomImageModalInit(){
   var nameInput = imgCustomModal.find('input');
 
   var invalidMsg = "Image names cannot contain spaces or capital letters. The only allowed special character is dash (-).";
+  var duplicateImageMsg = "An image with this name already exists in this project.";
+  var duplicateRecipeMsg = "A non-image recipe with this name already exists.";
 
   newCustomImgBtn.click(function(e){
     e.preventDefault();
@@ -22,8 +24,10 @@ function newCustomImageModalInit(){
           console.warn(ret.error);
           if (ret.error === "invalid-name") {
             showError(invalidMsg);
-          } else if (ret.error === "already-exists") {
-            showError("An image with this name already exists. Image names must be unique.");
+          } else if (ret.error === "image-already-exists") {
+            showError(duplicateImageMsg);
+          } else if (ret.error === "recipe-already-exists") {
+            showError(duplicateRecipeMsg);
           }
         } else {
           imgCustomModal.modal('hide');
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a11c9da..9744f4e 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2409,21 +2409,24 @@ if True:
             if re.search(r'[^a-z|0-9|-]', request.POST["name"]):
                 return {"error": "invalid-name"}
 
-            # Are there any recipes with the name already?
-            for existing_recipe in Recipe.objects.filter(
-                name=request.POST["name"]):
-                try:
-                    ci = CustomImageRecipe.objects.get(pk=existing_recipe.pk)
-                    if ci.project == params["project"]:
-                        return {"error": "already-exists" }
-                    else:
-                        # It is a CustomImageRecipe but not in our project
-                        # this is fine so
-                        continue
-                except:
-                    # It isn't a CustomImageRecipe so is a recipe from
-                    # another source.
-                    return {"error": "already-exists" }
+            custom_images = CustomImageRecipe.objects.all()
+
+            # Are there any recipes with this name already in our project?
+            existing_image_recipes_in_project = custom_images.filter(
+                name=request.POST["name"], project=params["project"])
+
+            if existing_image_recipes_in_project.count() > 0:
+                return {"error": "image-already-exists"}
+
+            # Are there any recipes with this name which aren't custom
+            # image recipes?
+            custom_image_ids = custom_images.values_list('id', flat=True)
+            existing_non_image_recipes = Recipe.objects.filter(
+                Q(name=request.POST["name"]) & ~Q(pk__in=custom_image_ids)
+            )
+
+            if existing_non_image_recipes.count() > 0:
+                return {"error": "recipe-already-exists"}
 
             # create layer 'Custom layer' and verion if needed
             layer = Layer.objects.get_or_create(
-- 
2.5.0


