Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCCCCDDE4E
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:19 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.5156.1729677611608054094
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ULMpXZ/Z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d41894a32so480746f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677610; x=1730282410; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gd7q7v6mWZ2pUeq5uL4WLCd2K413Gi1rq9ETR0SeQo=;
        b=ULMpXZ/ZsW2rc7qkqg40LwRE4aCBKnHuhVdOzgbu95a1JEEJmK1bZ+tmMs8LDj10rL
         6IfWenA++7HvCIcaHZt1cftVVIVQwlyRUK2cIJ6IyDiPicPjVQTHgfIjfmqXyj3WMDVY
         XXmespFCx5bGGRvitmWQqKmQZP0exX8dPKh3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677610; x=1730282410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gd7q7v6mWZ2pUeq5uL4WLCd2K413Gi1rq9ETR0SeQo=;
        b=BzunCHPCpsLq3ie91xQQ5HnQQvuK0UZ7cu+zFLuKkebbZC/JtagNWhQgUO8uJzoePy
         MIvLvua0gu8/qibiTAoAXMBSPOcTvWAwddCQEFglTBBx/fkuapq3qZA3ZfXQgguB+d2a
         AXZLHCL+fohx1mO/kiIxsDsHJ25rQXkdSvv/BFds+4Z861O25fHK4P0NuMajbZX3i0Gg
         FfvYrcxGmIJCMMS8HOtTeZlwOmkU5eKErf5F+niqGXSf1BA5yyiVMswjRpnw+3++6Adt
         IBjYc0I424sqD5HiWaI2on2MrhzsW3w/RWKT/+jiibZqZiCR4Pf6sprFFQCv6lKIJObP
         UQRA==
X-Gm-Message-State: AOJu0YxquTHK+TaINvaYzzotyR6AFn9o41PL3R4E/vbcQXBidIxT6rlO
	4klbCbIEnhH+/meFcOXGHQQREt41bsZNLFRsNcrHA78PYLnB9vw7tdHdkPEZqNJfNcJtBrhgvUn
	y
X-Google-Smtp-Source: AGHT+IFE2TnmU8jejZf3q/4SH/WPiJbO0Hb1MeiSwBJx4aLomfaekqTeG7yZkDvEjcIaa7LfMtMF+w==
X-Received: by 2002:a5d:6612:0:b0:374:b9ca:f1e8 with SMTP id ffacd0b85a97d-37ef14da769mr4274051f8f.20.1729677608030;
        Wed, 23 Oct 2024 03:00:08 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:07 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 16/28] toaster/tests/functiona/project_page_tab_config: Switch to using library create_project function
Date: Wed, 23 Oct 2024 10:59:37 +0100
Message-ID: <20241023095949.3351980-16-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16708

Switch this test module to use the common project creation code which contains
race fixes. That code requires the database access wrapper be dropped and
we no longer have ordering constraints.

There is one test that does require database access. Move this to a separate class
and allow database access there. Use ordering constraints to allow them to run
after the main code. They depend on the project creation from the other class which
isn't ideal but good enough for now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../test_project_page_tab_config.py           | 213 ++++++++----------
 1 file changed, 90 insertions(+), 123 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py b/lib/toaster/tests/functional/test_project_page_tab_config.py
index 5da9706b29..daf00d8f1d 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -7,7 +7,6 @@
 #
 
 import string
-import random
 import pytest
 from django.urls import reverse
 from selenium.webdriver import Keys
@@ -19,60 +18,16 @@ from selenium.webdriver.common.by import By
 
 from .utils import get_projectId_from_url, wait_until_build, wait_until_build_cancelled
 
-
-@pytest.mark.django_db
-@pytest.mark.order("last")
-class TestProjectConfigTab(SeleniumFunctionalTestCase):
+class TestProjectConfigTabBase(SeleniumFunctionalTestCase):
     PROJECT_NAME = 'TestProjectConfigTab'
     project_id = None
 
-    def _create_project(self, project_name, **kwargs):
-        """ Create/Test new project using:
-          - Project Name: Any string
-          - Release: Any string
-          - Merge Toaster settings: True or False
-        """
-        release = kwargs.get('release', '3')
-        self.get(reverse('newproject'))
-        self.wait_until_visible('#new-project-name')
-        self.find("#new-project-name").send_keys(project_name)
-        select = Select(self.find("#projectversion"))
-        select.select_by_value(release)
-
-        # check merge toaster settings
-        checkbox = self.find('.checkbox-mergeattr')
-        if not checkbox.is_selected():
-            checkbox.click()
-
-        if self.PROJECT_NAME != 'TestProjectConfigTab':
-            # Reset project name if it's not the default one
-            self.PROJECT_NAME = 'TestProjectConfigTab'
-
-        self.find("#create-project-button").click()
-
-        try:
-            self.wait_until_visible('#hint-error-project-name', poll=3)
-            url = reverse('project', args=(TestProjectConfigTab.project_id, ))
-            self.get(url)
-            self.wait_until_visible('#config-nav', poll=3)
-        except TimeoutException:
-            self.wait_until_visible('#config-nav', poll=3)
-
-    def _random_string(self, length):
-        return ''.join(
-            random.choice(string.ascii_letters) for _ in range(length)
-        )
-
     def _navigate_to_project_page(self):
         # Navigate to project page
-        if TestProjectConfigTab.project_id is None:
-            self._create_project(project_name=self._random_string(10))
-            current_url = self.driver.current_url
-            TestProjectConfigTab.project_id = get_projectId_from_url(
-                current_url)
-        else:
-            url = reverse('project', args=(TestProjectConfigTab.project_id,))
-            self.get(url)
+        if TestProjectConfigTabBase.project_id is None:
+            TestProjectConfigTabBase.project_id = self.create_new_project(self.PROJECT_NAME, '3', None, True)
+        url = reverse('project', args=(TestProjectConfigTabBase.project_id,))
+        self.get(url)
         self.wait_until_visible('#config-nav')
 
     def _create_builds(self):
@@ -114,6 +69,8 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         config_nav = self.find('#config-nav')
         return config_nav.find_elements(By.TAG_NAME, 'li')[index]
 
+class TestProjectConfigTab(TestProjectConfigTabBase):
+
     def test_project_config_nav(self):
         """ Test project config tab navigation:
         - Check if the menu is displayed and contains the right elements:
@@ -160,26 +117,26 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         conf_nav_list = [
             # config
             [0, 'Configuration',
-                f"/toastergui/project/{TestProjectConfigTab.project_id}"],
+                f"/toastergui/project/{TestProjectConfigTabBase.project_id}"],
             # custom images
             [2, 'Custom images',
-                f"/toastergui/project/{TestProjectConfigTab.project_id}/customimages"],
+                f"/toastergui/project/{TestProjectConfigTabBase.project_id}/customimages"],
             # image recipes
             [3, 'Image recipes',
-                f"/toastergui/project/{TestProjectConfigTab.project_id}/images"],
+                f"/toastergui/project/{TestProjectConfigTabBase.project_id}/images"],
             # software recipes
             [4, 'Software recipes',
-                f"/toastergui/project/{TestProjectConfigTab.project_id}/softwarerecipes"],
+                f"/toastergui/project/{TestProjectConfigTabBase.project_id}/softwarerecipes"],
             # machines
             [5, 'Machines',
-                f"/toastergui/project/{TestProjectConfigTab.project_id}/machines"],
+                f"/toastergui/project/{TestProjectConfigTabBase.project_id}/machines"],
             # layers
             [6, 'Layers',
-                f"/toastergui/project/{TestProjectConfigTab.project_id}/layers"],
+                f"/toastergui/project/{TestProjectConfigTabBase.project_id}/layers"],
             # distro
             [7, 'Distros',
-                f"/toastergui/project/{TestProjectConfigTab.project_id}/distros"],
-            #  [9, 'BitBake variables', f"/toastergui/project/{TestProjectConfigTab.project_id}/configuration"],  # bitbake variables
+                f"/toastergui/project/{TestProjectConfigTabBase.project_id}/distros"],
+            #  [9, 'BitBake variables', f"/toastergui/project/{TestProjectConfigTabBase.project_id}/configuration"],  # bitbake variables
         ]
         for index, item_name, url in conf_nav_list:
             item = _get_config_nav_item(index)
@@ -299,9 +256,11 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
                     - meta-poky
                     - meta-yocto-bsp
         """
-        # Create a new project for this test
-        project_name = self._random_string(10)
-        self._create_project(project_name=project_name)
+        project_id = self.create_new_project(self.PROJECT_NAME + "-ST", '3', None, True)
+        url = reverse('project', args=(project_id,))
+        self.get(url)
+        self.wait_until_visible('#config-nav')
+
         # check if the menu is displayed
         self.wait_until_visible('#project-page')
         block_l = self.driver.find_element(
@@ -374,61 +333,6 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         layers_list_items = layers_list.find_elements(By.TAG_NAME, 'li')
         self.assertEqual(len(layers_list_items), 4)
 
-    def test_most_build_recipes(self):
-        """ Test most build recipes block contains"""
-        def rebuild_from_most_build_recipes(recipe_list_items):
-            checkbox = recipe_list_items[0].find_element(By.TAG_NAME, 'input')
-            checkbox.click()
-            build_btn = self.find('#freq-build-btn')
-            build_btn.click()
-            self.wait_until_visible('#latest-builds')
-            wait_until_build(self, 'queued cloning starting parsing failed')
-            lastest_builds = self.driver.find_elements(
-                By.XPATH,
-                '//div[@id="latest-builds"]/div'
-            )
-            self.assertTrue(len(lastest_builds) >= 2)
-            last_build = lastest_builds[0]
-            try:
-                cancel_button = last_build.find_element(
-                    By.XPATH,
-                    '//span[@class="cancel-build-btn pull-right alert-link"]',
-                )
-                cancel_button.click()
-            except NoSuchElementException:
-                # Skip if the build is already cancelled
-                pass
-            wait_until_build_cancelled(self)
-        # Create a new project for remaining asserts
-        project_name = self._random_string(10)
-        self._create_project(project_name=project_name, release='2')
-        current_url = self.driver.current_url
-        TestProjectConfigTab.project_id = get_projectId_from_url(current_url)
-        url = current_url.split('?')[0]
-
-        # Create a new builds
-        self._create_builds()
-
-        # back to project page
-        self.driver.get(url)
-
-        self.wait_until_visible('#project-page', poll=3)
-
-        # Most built recipes
-        most_built_recipes = self.driver.find_element(
-            By.XPATH, '//*[@id="project-page"]/div[1]/div[3]')
-        title = most_built_recipes.find_element(By.TAG_NAME, 'h3')
-        self.assertIn("Most built recipes", title.text)
-        # check can select a recipe and build it
-        self.wait_until_visible('#freq-build-list', poll=3)
-        recipe_list = self.find('#freq-build-list')
-        recipe_list_items = recipe_list.find_elements(By.TAG_NAME, 'li')
-        self.assertTrue(
-            len(recipe_list_items) > 0,
-            msg="No recipes found in the most built recipes list",
-        )
-        rebuild_from_most_build_recipes(recipe_list_items)
-        TestProjectConfigTab.project_id = None  # reset project id
 
     def test_project_page_tab_importlayer(self):
         """ Test project page tab import layer """
@@ -472,10 +376,11 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
 
     def test_project_page_custom_image_no_image(self):
         """ Test project page tab "New custom image" when no custom image """
-        project_name = self._random_string(10)
-        self._create_project(project_name=project_name)
-        current_url = self.driver.current_url
-        TestProjectConfigTab.project_id = get_projectId_from_url(current_url)
+        project_id = self.create_new_project(self.PROJECT_NAME + "-CustomImage", '3', None, True)
+        url = reverse('project', args=(project_id,))
+        self.get(url)
+        self.wait_until_visible('#config-nav')
+
         # navigate to "Custom image" tab
         custom_image_section = self._get_config_nav_item(2)
         custom_image_section.click()
@@ -490,9 +395,9 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         div_empty_msg = self.find('#empty-state-customimagestable')
         link_create_custom_image = div_empty_msg.find_element(
             By.TAG_NAME, 'a')
-        self.assertTrue(TestProjectConfigTab.project_id is not None)
+        self.assertTrue(TestProjectConfigTabBase.project_id is not None)
         self.assertIn(
-            f"/toastergui/project/{TestProjectConfigTab.project_id}/newcustomimage", str(
+            f"/toastergui/project/{project_id}/newcustomimage", str(
                 link_create_custom_image.get_attribute('href')
             )
         )
@@ -501,7 +406,6 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
                 link_create_custom_image.text
             )
         )
-        TestProjectConfigTab.project_id = None  # reset project id
 
     def test_project_page_image_recipe(self):
         """ Test project page section images
@@ -526,3 +430,66 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         self.wait_until_visible('#imagerecipestable tbody tr')
         rows = self.find_all('#imagerecipestable tbody tr')
         self.assertTrue(len(rows) > 0)
+
+@pytest.mark.django_db
+@pytest.mark.order("last") 
+class TestProjectConfigTabDB(TestProjectConfigTabBase):
+
+    def test_most_build_recipes(self):
+        """ Test most build recipes block contains"""
+        def rebuild_from_most_build_recipes(recipe_list_items):
+            checkbox = recipe_list_items[0].find_element(By.TAG_NAME, 'input')
+            checkbox.click()
+            build_btn = self.find('#freq-build-btn')
+            build_btn.click()
+            self.wait_until_visible('#latest-builds')
+            wait_until_build(self, 'queued cloning starting parsing failed')
+            lastest_builds = self.driver.find_elements(
+                By.XPATH,
+                '//div[@id="latest-builds"]/div'
+            )
+            self.assertTrue(len(lastest_builds) >= 2)
+            last_build = lastest_builds[0]
+            try:
+                cancel_button = last_build.find_element(
+                    By.XPATH,
+                    '//span[@class="cancel-build-btn pull-right alert-link"]',
+                )
+                cancel_button.click()
+            except NoSuchElementException:
+                # Skip if the build is already cancelled
+                pass
+            wait_until_build_cancelled(self)
+
+        # Create a new project for remaining asserts
+        project_id = self.create_new_project(self.PROJECT_NAME + "-MostBuilt", '2', None, True)
+        url = reverse('project', args=(project_id,))
+        self.get(url)
+        self.wait_until_visible('#config-nav')
+
+        current_url = self.driver.current_url
+        url = current_url.split('?')[0]
+
+        # Create a new builds
+        self._create_builds()
+
+        # back to project page
+        self.driver.get(url)
+
+        self.wait_until_visible('#project-page', poll=3)
+
+        # Most built recipes
+        most_built_recipes = self.driver.find_element(
+            By.XPATH, '//*[@id="project-page"]/div[1]/div[3]')
+        title = most_built_recipes.find_element(By.TAG_NAME, 'h3')
+        self.assertIn("Most built recipes", title.text)
+        # check can select a recipe and build it
+        self.wait_until_visible('#freq-build-list', poll=3)
+        recipe_list = self.find('#freq-build-list')
+        recipe_list_items = recipe_list.find_elements(By.TAG_NAME, 'li')
+        self.assertTrue(
+            len(recipe_list_items) > 0,
+            msg="No recipes found in the most built recipes list",
+        )
+        rebuild_from_most_build_recipes(recipe_list_items)
+

