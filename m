Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 5626D768C8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:26 +0000 (UTC)
Received: by wibhh20 with SMTP id hh20so160533561wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=4uAg9wiRqQmVQE4ix43Yv+dznfuyW8OjzOJ9k/jdiq4=;
	b=TPXnrE61ULho5PIGd65QrKgOmICr5VQWQpOaOdK+Hhc9OJ2rrKsLibaEl9lFuB1JNV
	0KAmfZA1BNZ1NNvXoAK5120EmZognD517+qTz+T/iF5QIgPjwi3juCipktM9AAkPJQwx
	xjp+P1OgfRwd1M3IEz5ngj9VFhsdlhbPrjcG9TzvLReSpUzSnSLpqMW1V6va3g8t+5BC
	fJLeJzruYO1Hp3ynk5qTnil0Vgq7SWQ7MSQip2iL9lfDa7eLbJmOhLnEjWLZ3YJw7wwh
	N6j0PTSVfKR/3fW2aFs1LEXWSSuXMU+Sb975UUMv7/kEC3jwrvaU2Erbh30b1YY6LOts
	bgXg==
X-Gm-Message-State: ALoCoQlnJXF+PmsROaln/pWDVR4R/DHjnquKLOzZjElvJiR9u8CyiKA8RYCEoKpK7z/jz9BLVXhE
X-Received: by 10.180.85.74 with SMTP id f10mr25682026wiz.45.1439227646822;
	Mon, 10 Aug 2015 10:27:26 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.26
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:26 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:12 +0100
Message-Id: <b70d0417d4a7bc071d7921a8ab670d5ce9b5c380.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 05/11] toaster: get rid of class attributes
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
X-List-Received-Date: Mon, 10 Aug 2015 17:27:27 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

LAYER_NAME and RECIPE_NAME attributes don't make sense as
they're used only once.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 986e6a5..9755a88 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -9,8 +9,6 @@ PROJECT_NAME = "test project"
 
 class ViewTests(TestCase):
     """Tests to verify view APIs."""
-    LAYER_NAME = "base-layer"
-    RECIPE_NAME = "base-recipe"
 
     def setUp(self):
         self.bbv = BitbakeVersion.objects.create(\
@@ -26,14 +24,14 @@ class ViewTests(TestCase):
                                release=self.release,
                                layer_source=self.layersrc)
         self.layer = Layer.objects.create(\
-                         name=self.LAYER_NAME,
+                         name="base-layer",
                          layer_source=self.layersrc, vcs_url="/tmp/")
         self.lver = Layer_Version.objects.create(\
                         layer=self.layer, project=self.project,
                         layer_source=self.layersrc, commit="master")
 
         self.recipe = Recipe.objects.create(\
-                          layer_source=self.layersrc, name=self.RECIPE_NAME,
+                          layer_source=self.layersrc, name="base-recipe",
                           version="1.2", summary="one recipe",
                           description="recipe", layer_version=self.lver)
 
-- 
2.1.4


