Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id D6FB87317D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 12:35:22 +0000 (UTC)
Received: by mail-pa0-f41.google.com with SMTP id fy10so109735123pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 04:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=Zwvb4wXNAsmNb1nMug85X2nMFYSs5OfPHVZ0EOh3bEY=;
	b=il+pS09BYGAh5yY4VSaWgaUM44L07dGTgpPuXzXBLgLbkqxR6cNhT6yBWOAIEi0c9E
	7nE8ypq8cvT+IzBCf+m9PYIfzPrqBMyCkRM9AoYToIkl5F+TC0gPOvaVOdB2LI0J9Maq
	Wq8V4H987BRe0R2BeXv+ZOa00npBaI8qhqtxGt5t9gxLq1brBE1mq6nVrE4Y6mdUPhE3
	IqXyBSwbwFI1qP1/OamBMkmrdVr68zsAG2c093RJQJg84IscjwDDPp9ZN9Rg+0ojbsVY
	B97+uV1l2dKKI7T+QX4T6VozJ+qT1XeTFlqc/Wv/BiIghgAFWkuHfoYzyRd/ONsw37H8
	rZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Zwvb4wXNAsmNb1nMug85X2nMFYSs5OfPHVZ0EOh3bEY=;
	b=hS5xaA0Ykk3gwx/PJes/+teEcIkVNB5s9aCzMaSc4yfoZy2o0k+rWxwFTDEdeirxlk
	9wrhu9IbHn/tCxDCuHvEEU69/8scvo9dgqNpgRmIcR6AYlhRgK9iYnLitPUXTh3nohws
	u7rKMCKOidFaPRS19zOXAga6sDongamtUxhTYGakHwKXy3WEqR0oGoRG+vIfgPsniX9Q
	QIT56F/J4ctpArVRO8tD+MKRIRIgJ+irfvRHGTCwbu+hwMG7RdPfQMFWnzFfo7mukZTx
	KJLPpVHFybKH9ChDsWqbJsp1/sJ7blwVGcnFDBDWP+/wEHSuxkyUREiOtqjMvJS7xz8f
	lbzw==
X-Gm-Message-State: AG10YORjwkiknadpvsavGXkjg5QdQDWR4BaMn9QY+/XBAbJKRM51Q0EhDxjzlrCLnjWIiE7e
X-Received: by 10.66.225.177 with SMTP id rl17mr45766199pac.46.1456230923475; 
	Tue, 23 Feb 2016 04:35:23 -0800 (PST)
Received: from dorado.ger.corp.intel.com ([192.55.54.40])
	by smtp.gmail.com with ESMTPSA id
	m5sm43954714pfi.84.2016.02.23.04.35.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 23 Feb 2016 04:35:22 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Feb 2016 12:34:45 +0000
Message-Id: <1456230885-6718-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH] toaster: remove custom images from Image Recipes
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
X-List-Received-Date: Tue, 23 Feb 2016 12:35:24 -0000

From: Dave Lerner <dave.lerner@windriver.com>

Fix the view of 'Image Recipes' under 'Configuration' to only show
image recipes that are not customised since custom images have their
own page.

[YOCTO #9111]

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tables.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index c0ad2b7..528f2ad 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -549,7 +549,10 @@ class ImageRecipesTable(RecipesTable):
     def setup_queryset(self, *args, **kwargs):
         super(ImageRecipesTable, self).setup_queryset(*args, **kwargs)
 
-        self.queryset = self.queryset.filter(is_image=True)
+        custom_image_recipes = CustomImageRecipe.objects.filter(
+                project=kwargs['pid'])
+        self.queryset = self.queryset.filter(
+                Q(is_image=True) & ~Q(pk__in=custom_image_recipes))
         self.queryset = self.queryset.order_by(self.default_orderby)
 
 
-- 
2.5.0


