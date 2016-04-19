Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 211E46FFF7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:29:00 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id u206so39018494wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=REn3/reuCvFUYnZt/cJLMSDbuuAnW4lJF0d0e0rc+Ik=;
	b=p7wEyswVGXD4pZg+hnxk3aogz7LpLVKkzDy5m9ffzk+2kN28F+LR/gZW9ozOneLX4f
	OrOrv622qxsQWLd0eFKvwF5JrBxPbLSaCDGjgVgsFV/H975Mhnst5xp9y0/vxwPne3V6
	M5Wtr7pYcEmnzvXbW2Zh1tLVOJ0nnxuhD62GnRomT+5nD+rfa9whSJNtyMLTnLwbBBqt
	LuI2Jq+AI6+6DsNqMqaXKII0Dt2t9GwOHLubWqNeabsaOe34iedlNnVZ3tAeQGMJzy5c
	wPdzyPTemysgaBqB/5X53arJOb5XfZCFfCTdkWYAms+twqG6fAu4+pTn33d4zifMkyr8
	4Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=REn3/reuCvFUYnZt/cJLMSDbuuAnW4lJF0d0e0rc+Ik=;
	b=Nj4eEkXc8U7KI0L1AehoLeb0GnixeBKdeU+ZbYknrq9eyad0J9AvPz8W4qxxuUXRZF
	6++ldqUkEg7ddUOU9/JFig2bY4KT3PXBcbQarN2+Iy9u/blOZEEyIWj2ALGXckLtIgZC
	W8wqx6vkXvfWkE/in/NwtGRo7FaxbsOhHR9S4zFIk3VyvUvM5O52+2bSZdozhuByAM8w
	qO4WKtkiQGrj3/EUEsQra2KcuFFJD+AlFubxo+s46O3LMwgAV2uOk6MzcZTkAL2XLupZ
	OYWkjJNhC6LooLVfBWk9myDIhLoLl3i/P+n+bIGAzg8+jo4nDU6glMNx/IpEauEs7dg4
	5pwQ==
X-Gm-Message-State: AOPr4FXS3Hh6cpg9hIUA0xVr9/FNHe+5J8sVDmx6dVRp0nZHFLXPGCmXKElbr0dbqx3xxzfG
X-Received: by 10.194.186.242 with SMTP id fn18mr4335935wjc.65.1461083341109; 
	Tue, 19 Apr 2016 09:29:01 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.29.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:29:00 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:43 +0100
Message-Id: <1461083327-11668-7-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
References: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 06/10] toaster-tests: add tests for new custom image page
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
X-List-Received-Date: Tue, 19 Apr 2016 16:29:02 -0000

From: Elliot Smith <elliot.smith@intel.com>

Test adding a new custom image when:

1. No custom images are in the project yet.
2. User tries to add custom image which duplicates the name of
an existing custom image.
3. User tries to add custom image which duplicates the name
of a non-image recipe.

[YOCTO #9209]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../tests/browser/test_new_custom_image_page.py    | 160 +++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 lib/toaster/tests/browser/test_new_custom_image_page.py

diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/lib/toaster/tests/browser/test_new_custom_image_page.py
new file mode 100644
index 0000000..8906cb2
--- /dev/null
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -0,0 +1,160 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2013-2016 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from django.core.urlresolvers import reverse
+from tests.browser.selenium_helpers import SeleniumTestCase
+
+from orm.models import BitbakeVersion, Release, Project, ProjectLayer, Layer
+from orm.models import Layer_Version, Recipe, CustomImageRecipe
+
+class TestNewCustomImagePage(SeleniumTestCase):
+    CUSTOM_IMAGE_NAME = 'roopa-doopa'
+
+    def setUp(self):
+        release = Release.objects.create(
+            name='baz',
+            bitbake_version=BitbakeVersion.objects.create(name='v1')
+        )
+
+        # project to add new custom images to
+        self.project = Project.objects.create(name='foo', release=release)
+
+        # layer associated with the project
+        layer = Layer.objects.create(name='bar')
+        layer_version = Layer_Version.objects.create(
+            layer=layer,
+            project=self.project
+        )
+
+        # properly add the layer to the project
+        ProjectLayer.objects.create(
+            project=self.project,
+            layercommit=layer_version,
+            optional=False
+        )
+
+        # add a fake image recipe to the layer that can be customised
+        self.recipe = Recipe.objects.create(
+            name='core-image-minimal',
+            layer_version=layer_version,
+            is_image=True
+        )
+
+        # another project with a custom image already in it
+        project2 = Project.objects.create(name='whoop', release=release)
+        layer_version2 = Layer_Version.objects.create(
+            layer=layer,
+            project=project2
+        )
+        ProjectLayer.objects.create(
+            project=project2,
+            layercommit=layer_version2,
+            optional=False
+        )
+        recipe2 = Recipe.objects.create(
+            name='core-image-minimal',
+            layer_version=layer_version2,
+            is_image=True
+        )
+        CustomImageRecipe.objects.create(
+            name=self.CUSTOM_IMAGE_NAME,
+            base_recipe=recipe2,
+            layer_version=layer_version2,
+            file_path='/1/2',
+            project=project2
+        )
+
+    def _create_custom_image(self, new_custom_image_name):
+        """
+        1. Go to the 'new custom image' page
+        2. Click the button for the fake core-image-minimal
+        3. Wait for the dialog box for setting the name of the new custom
+           image
+        4. Insert new_custom_image_name into that dialog's text box
+        """
+        url = reverse('newcustomimage', args=(self.project.id,))
+        self.get(url)
+
+        self.click('button[data-recipe="%s"]' % self.recipe.id)
+
+        selector = '#new-custom-image-modal input[type="text"]'
+        self.enter_text(selector, new_custom_image_name)
+
+        self.click('#create-new-custom-image-btn')
+
+    def _check_for_custom_image(self, image_name):
+        """
+        Fetch the list of custom images for the project and check the
+        image with name image_name is listed there
+        """
+        url = reverse('projectcustomimages', args=(self.project.id,))
+        self.get(url)
+
+        self.wait_until_visible('#customimagestable')
+
+        element = self.find('#customimagestable td[class="name"] a')
+        msg = 'should be a custom image link with text %s' % image_name
+        self.assertEqual(element.text.strip(), image_name, msg)
+
+    def test_new_image(self):
+        """
+        Should be able to create a new custom image
+        """
+        custom_image_name = 'boo-image'
+        self._create_custom_image(custom_image_name)
+        self.wait_until_visible('#image-created-notification')
+        self._check_for_custom_image(custom_image_name)
+
+    def test_new_duplicates_other_project_image(self):
+        """
+        Should be able to create a new custom image if its name is the same
+        as a custom image in another project
+        """
+        self._create_custom_image(self.CUSTOM_IMAGE_NAME)
+        self.wait_until_visible('#image-created-notification')
+        self._check_for_custom_image(self.CUSTOM_IMAGE_NAME)
+
+    def test_new_duplicates_non_image_recipe(self):
+        """
+        Should not be able to create a new custom image whose name is the
+        same as an existing non-image recipe
+        """
+        self._create_custom_image(self.recipe.name)
+        element = self.wait_until_visible('#invalid-name-help')
+        self.assertRegexpMatches(element.text.strip(),
+                                 'recipe with this name already exists')
+
+    def test_new_duplicates_project_image(self):
+        """
+        Should not be able to create a new custom image whose name is the same
+        as a custom image in this project
+        """
+        # create the image
+        custom_image_name = 'doh-image'
+        self._create_custom_image(custom_image_name)
+        self.wait_until_visible('#image-created-notification')
+        self._check_for_custom_image(custom_image_name)
+
+        # try to create an image with the same name
+        self._create_custom_image(custom_image_name)
+        element = self.wait_until_visible('#invalid-name-help')
+        expected = 'An image with this name already exists in this project'
+        self.assertRegexpMatches(element.text.strip(), expected)
-- 
2.5.0


