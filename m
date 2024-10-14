Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A221CFC502
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:49:23 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.49710.1728892153383923612
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Oct 2024 00:49:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=c7uxTfPh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43117ed8adbso43138055e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Oct 2024 00:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728892151; x=1729496951; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pUg+3EhE/kWyplV/1p1PmVrxYAZBpSxo0AWqvcCm+w=;
        b=c7uxTfPhuFM1r62z9RUAd1Q7S7gGt8+wTU91hJNDR8rLblLFSCr8BvAJ34dJGnXaOF
         b1MJEMeBGriDQjSpeTSjbGiL8k54I2vceo6T7gJ+cms3PXHwDe1gxI3ZcQ3D1BkIaRLB
         TnSKLzkHhB7es6Aujy5Evrk9s8U3DBRmK2xIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892151; x=1729496951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pUg+3EhE/kWyplV/1p1PmVrxYAZBpSxo0AWqvcCm+w=;
        b=jpdgFhEEcVJ4JE9NRtCCZQKHTtqN4IF3K6mudtbnSn4eSC96+g0aDQsUmT0j9WTgR5
         gU508KchFjUckfly4XFT/AXGLUPRMtXpBOFo/ZoBAEwqdTijm5Sge2RUAnX+a0sZScxc
         UdOQ6kob/bBDIJasJQSwuWV8QImuN+ZsdSLBiYLqU3DetiNx7KDEeAjFoj/Wjzdat73q
         djPKVPeYA/60f1xJiuRUYh0nUk7xm1DDqHlp2XDdKOHkw0XEgYFlKU0Ox9unYVP+i96d
         RskzSm5iy75D0p9xBBCjv6sAbf+LHn4ER9xeV6H7p9GR8qjB/5JnE/dxhUKjfHArPMg/
         Q1JA==
X-Gm-Message-State: AOJu0YwCA2mispAW6Br/33l0LovNX8z0Pbd0HINRerPf8LvprN8iKs3i
	0clBK6V3OIlY9pzLmfc9nnoIO10QCmoy07AcaGhD1ecALDvWtIFdm/c9fRDAa13GQUGQudx4CCu
	e
X-Google-Smtp-Source: AGHT+IEJHrpZ+P4y6ZoAcV1FJBJ0IL9PRJXB6PRP2FYO6Ez6m9JNhqjPEfxjcGb1vAJWrLvbDG2A6g==
X-Received: by 2002:a05:6000:4388:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-37d612c5e79mr6046238f8f.0.1728892150722;
        Mon, 14 Oct 2024 00:49:10 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4468:7613:7612:e2d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a859fsm10747530f8f.2.2024.10.14.00.49.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:49:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster/tests: Replace assertTrue for more specific asserts
Date: Mon, 14 Oct 2024 08:49:09 +0100
Message-ID: <20241014074909.1414245-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Oct 2024 07:49:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16678

assetTrue is a poor choice for "x in y" since assertIn gives much more
useful output upon failure.

Change such inserts to assertIn or assertEqual to make errors easier
to debug.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_project_page.py     | 124 +++++++++---------
 .../test_project_page_tab_config.py           |  58 ++++----
 2 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index 8b34658418..5d10513d9d 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -272,8 +272,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         logo_img = logo.find_element(By.TAG_NAME, 'img')
         self.assertTrue(logo_img.is_displayed(),
                         'Logo of Yocto project not found')
-        self.assertTrue(
-            '/static/img/logo.png' in str(logo_img.get_attribute('src')),
+        self.assertIn(
+            '/static/img/logo.png', str(logo_img.get_attribute('src')),
             'Logo of Yocto project not found'
         )
         # "Toaster"+" Information icon", clickable
@@ -282,34 +282,34 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             "//div[@class='toaster-navbar-brand']//a[@class='brand']",
         )
         self.assertTrue(toaster.is_displayed(), 'Toaster not found')
-        self.assertTrue(toaster.text == 'Toaster')
+        self.assertEqual(toaster.text, 'Toaster')
         info_sign = self.find('.glyphicon-info-sign')
         self.assertTrue(info_sign.is_displayed())
 
         # "Server Icon" + "All builds"
         all_builds = self.find('#navbar-all-builds')
         all_builds_link = all_builds.find_element(By.TAG_NAME, 'a')
-        self.assertTrue("All builds" in all_builds_link.text)
-        self.assertTrue(
-            '/toastergui/builds/' in str(all_builds_link.get_attribute('href'))
+        self.assertIn("All builds", all_builds_link.text)
+        self.assertIn(
+            '/toastergui/builds/', str(all_builds_link.get_attribute('href'))
         )
         server_icon = all_builds.find_element(By.TAG_NAME, 'i')
-        self.assertTrue(
-            server_icon.get_attribute('class') == 'glyphicon glyphicon-tasks'
+        self.assertEqual(
+            server_icon.get_attribute('class'), 'glyphicon glyphicon-tasks'
         )
         self.assertTrue(server_icon.is_displayed())
 
         # "Directory Icon" + "All projects"
         all_projects = self.find('#navbar-all-projects')
         all_projects_link = all_projects.find_element(By.TAG_NAME, 'a')
-        self.assertTrue("All projects" in all_projects_link.text)
-        self.assertTrue(
-            '/toastergui/projects/' in str(all_projects_link.get_attribute(
+        self.assertIn("All projects", all_projects_link.text)
+        self.assertIn(
+            '/toastergui/projects/', str(all_projects_link.get_attribute(
                 'href'))
         )
         dir_icon = all_projects.find_element(By.TAG_NAME, 'i')
-        self.assertTrue(
-            dir_icon.get_attribute('class') == 'icon-folder-open'
+        self.assertEqual(
+            dir_icon.get_attribute('class'), 'icon-folder-open'
         )
         self.assertTrue(dir_icon.is_displayed())
 
@@ -317,23 +317,23 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         toaster_docs_link = self.find('#navbar-docs')
         toaster_docs_link_link = toaster_docs_link.find_element(By.TAG_NAME,
                                                                 'a')
-        self.assertTrue("Documentation" in toaster_docs_link_link.text)
-        self.assertTrue(
-            toaster_docs_link_link.get_attribute('href') == 'http://docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manual'
+        self.assertIn("Documentation", toaster_docs_link_link.text)
+        self.assertEqual(
+            toaster_docs_link_link.get_attribute('href'), 'http://docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manual'
         )
         book_icon = toaster_docs_link.find_element(By.TAG_NAME, 'i')
-        self.assertTrue(
-            book_icon.get_attribute('class') == 'glyphicon glyphicon-book'
+        self.assertEqual(
+            book_icon.get_attribute('class'), 'glyphicon glyphicon-book'
         )
         self.assertTrue(book_icon.is_displayed())
 
         # AT RIGHT -> button "New project"
         new_project_button = self.find('#new-project-button')
         self.assertTrue(new_project_button.is_displayed())
-        self.assertTrue(new_project_button.text == 'New project')
+        self.assertEqual(new_project_button.text, 'New project')
         new_project_button.click()
-        self.assertTrue(
-            '/toastergui/newproject/' in str(self.driver.current_url)
+        self.assertIn(
+            '/toastergui/newproject/', str(self.driver.current_url)
         )
 
     def test_edit_project_name(self):
@@ -358,8 +358,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
 
         # check project name is changed
         self.wait_until_visible('#project-name-container')
-        self.assertTrue(
-            'New Name' in str(self.find('#project-name-container').text)
+        self.assertIn(
+            'New Name', str(self.find('#project-name-container').text)
         )
 
     def test_project_page_tabs(self):
@@ -376,10 +376,10 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         # check "configuration" tab
         self.wait_until_visible('#topbar-configuration-tab')
         config_tab = self.find('#topbar-configuration-tab')
-        self.assertTrue(config_tab.get_attribute('class') == 'active')
-        self.assertTrue('Configuration' in str(config_tab.text))
-        self.assertTrue(
-            f"/toastergui/project/{TestProjectPage.project_id}" in str(self.driver.current_url)
+        self.assertEqual(config_tab.get_attribute('class'), 'active')
+        self.assertIn('Configuration', str(config_tab.text))
+        self.assertIn(
+            f"/toastergui/project/{TestProjectPage.project_id}", str(self.driver.current_url)
         )
 
         def get_tabs():
@@ -392,9 +392,9 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         def check_tab_link(tab_index, tab_name, url):
             tab = get_tabs()[tab_index]
             tab_link = tab.find_element(By.TAG_NAME, 'a')
-            self.assertTrue(url in tab_link.get_attribute('href'))
-            self.assertTrue(tab_name in tab_link.text)
-            self.assertTrue(tab.get_attribute('class') == 'active')
+            self.assertIn(url, tab_link.get_attribute('href'))
+            self.assertIn(tab_name, tab_link.text)
+            self.assertEqual(tab.get_attribute('class'), 'active')
 
         # check "Builds" tab
         builds_tab = get_tabs()[1]
@@ -433,8 +433,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             '//div[@id="latest-builds"]',
         )
         last_build = lastest_builds[0]
-        self.assertTrue(
-            'core-image-minimal' in str(last_build.text)
+        self.assertIn(
+            'core-image-minimal', str(last_build.text)
         )
 
     def test_softwareRecipe_page(self):
@@ -446,7 +446,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         """
         self._navigate_to_config_nav('softwarerecipestable', 4)
         # check title "Compatible software recipes" is displayed
-        self.assertTrue("Compatible software recipes" in self.get_page_source())
+        self.assertIn("Compatible software recipes", self.get_page_source())
         # Test search input
         self._mixin_test_table_search_input(
             input_selector='search-input-softwarerecipestable',
@@ -510,7 +510,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         """
         self._navigate_to_config_nav('machinestable', 5)
         # check title "Compatible software recipes" is displayed
-        self.assertTrue("Compatible machines" in self.get_page_source())
+        self.assertIn("Compatible machines", self.get_page_source())
         # Test search input
         self._mixin_test_table_search_input(
             input_selector='search-input-machinestable',
@@ -528,8 +528,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         select_btn.send_keys(Keys.RETURN)
         self.wait_until_visible('#config-nav')
         project_machine_name = self.find('#project-machine-name')
-        self.assertTrue(
-            'qemux86-64' in project_machine_name.text
+        self.assertIn(
+            'qemux86-64', project_machine_name.text
         )
         # check "Add layer" button works
         self._navigate_to_config_nav('machinestable', 5)
@@ -547,8 +547,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         add_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
-        self.assertTrue(
-            f'You have added 1 layer to your project' in str(change_notification.text)
+        self.assertIn(
+            f'You have added 1 layer to your project', str(change_notification.text)
         )
         # check Machine table feature(show/hide column, pagination)
         self._navigate_to_config_nav('machinestable', 5)
@@ -580,7 +580,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         """
         self._navigate_to_config_nav('layerstable', 6)
         # check title "Compatible layers" is displayed
-        self.assertTrue("Compatible layers" in self.get_page_source())
+        self.assertIn("Compatible layers", self.get_page_source())
         # Test search input
         input_text='meta-tanowrt'
         self._mixin_test_table_search_input(
@@ -609,8 +609,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         add_layers_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
-        self.assertTrue(
-            f'You have added {len(list_dependencies)+1} layers to your project: {input_text} and its dependencies' in str(change_notification.text)
+        self.assertIn(
+            f'You have added {len(list_dependencies)+1} layers to your project: {input_text} and its dependencies', str(change_notification.text)
         )
         # check "Remove layer" button works
         self.wait_until_visible('#layerstable tbody tr', poll=3)
@@ -623,8 +623,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         remove_btn.click()
         self.wait_until_visible('#change-notification', poll=2)
         change_notification = self.find('#change-notification')
-        self.assertTrue(
-            f'You have removed 1 layer from your project: {input_text}' in str(change_notification.text)
+        self.assertIn(
+            f'You have removed 1 layer from your project: {input_text}', str(change_notification.text)
         )
         # check layers table feature(show/hide column, pagination)
         self._navigate_to_config_nav('layerstable', 6)
@@ -656,7 +656,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         """
         self._navigate_to_config_nav('distrostable', 7)
         # check title "Compatible distros" is displayed
-        self.assertTrue("Compatible Distros" in self.get_page_source())
+        self.assertIn("Compatible Distros", self.get_page_source())
         # Test search input
         input_text='poky-altcfg'
         self._mixin_test_table_search_input(
@@ -675,8 +675,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         add_btn.click()
         self.wait_until_visible('#change-notification', poll=2)
         change_notification = self.find('#change-notification')
-        self.assertTrue(
-            f'You have changed the distro to: {input_text}' in str(change_notification.text)
+        self.assertIn(
+            f'You have changed the distro to: {input_text}', str(change_notification.text)
         )
         # check distro table feature(show/hide column, pagination)
         self._navigate_to_config_nav('distrostable', 7)
@@ -736,24 +736,24 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertEqual(len(tabs), 3)
         # Check first tab
         tabs[0].click()
-        self.assertTrue(
-            'active' in str(self.find('#information').get_attribute('class'))
+        self.assertIn(
+            'active', str(self.find('#information').get_attribute('class'))
         )
         # Check second tab (recipes)
         # Ensure page is scrolled to the top
         self.driver.find_element(By.XPATH, '//body').send_keys(Keys.CONTROL + Keys.HOME)
         self.wait_until_visible('.nav-tabs')
         tabs[1].click()
-        self.assertTrue(
-            'active' in str(self.find('#recipes').get_attribute('class'))
+        self.assertIn(
+            'active', str(self.find('#recipes').get_attribute('class'))
         )
         # Check third tab (machines)
         # Ensure page is scrolled to the top
         self.driver.find_element(By.XPATH, '//body').send_keys(Keys.CONTROL + Keys.HOME)
         self.wait_until_visible('.nav-tabs')
         tabs[2].click()
-        self.assertTrue(
-            'active' in str(self.find('#machines').get_attribute('class'))
+        self.assertIn(
+            'active', str(self.find('#machines').get_attribute('class'))
         )
         # Check left section is displayed
         section = self.find('.well')
@@ -762,9 +762,9 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             section.find_element(By.XPATH, '//h2[1]').is_displayed()
         )
         # Check layer summary
-        self.assertTrue("Summary" in section.text)
+        self.assertIn("Summary", section.text)
         # Check layer description
-        self.assertTrue("Description" in section.text)
+        self.assertIn("Description", section.text)
 
     def test_single_recipe_page(self):
         """ Test recipe page
@@ -794,11 +794,11 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             section.find_element(By.XPATH, '//h2[1]').is_displayed()
         )
         # Check recipe sections details info are displayed
-        self.assertTrue("Summary" in section.text)
-        self.assertTrue("Description" in section.text)
-        self.assertTrue("Version" in section.text)
-        self.assertTrue("Section" in section.text)
-        self.assertTrue("License" in section.text)
-        self.assertTrue("Approx. packages included" in section.text)
-        self.assertTrue("Approx. package size" in section.text)
-        self.assertTrue("Recipe file" in section.text)
+        self.assertIn("Summary", section.text)
+        self.assertIn("Description", section.text)
+        self.assertIn("Version", section.text)
+        self.assertIn("Section", section.text)
+        self.assertIn("License", section.text)
+        self.assertIn("Approx. packages included", section.text)
+        self.assertIn("Approx. package size", section.text)
+        self.assertIn("Recipe file", section.text)
diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py b/lib/toaster/tests/functional/test_project_page_tab_config.py
index eb905ddf3f..5da9706b29 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -88,8 +88,8 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
             '//div[@id="latest-builds"]/div',
         )
         last_build = lastest_builds[0]
-        self.assertTrue(
-            'foo' in str(last_build.text)
+        self.assertIn(
+            'foo', str(last_build.text)
         )
         last_build = lastest_builds[0]
         try:
@@ -138,24 +138,24 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
 
         def check_config_nav_item(index, item_name, url):
             item = _get_config_nav_item(index)
-            self.assertTrue(item_name in item.text)
-            self.assertTrue(item.get_attribute('class') == 'active')
-            self.assertTrue(url in self.driver.current_url)
+            self.assertIn(item_name, item.text)
+            self.assertEqual(item.get_attribute('class'), 'active')
+            self.assertIn(url, self.driver.current_url)
 
         # check if the menu contains the right elements
         # COMPATIBLE METADATA
         compatible_metadata = _get_config_nav_item(1)
-        self.assertTrue(
-            "compatible metadata" in compatible_metadata.text.lower()
+        self.assertIn(
+            "compatible metadata", compatible_metadata.text.lower()
         )
         # EXTRA CONFIGURATION
         extra_configuration = _get_config_nav_item(8)
-        self.assertTrue(
-            "extra configuration" in extra_configuration.text.lower()
+        self.assertIn(
+            "extra configuration", extra_configuration.text.lower()
         )
         # Actions
         actions = _get_config_nav_item(10)
-        self.assertTrue("actions" in str(actions.text).lower())
+        self.assertIn("actions", str(actions.text).lower())
 
         conf_nav_list = [
             # config
@@ -313,7 +313,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         def check_machine_distro(self, item_name, new_item_name, block_id):
             block = self.find(f'#{block_id}')
             title = block.find_element(By.TAG_NAME, 'h3')
-            self.assertTrue(item_name.capitalize() in title.text)
+            self.assertIn(item_name.capitalize(), title.text)
             edit_btn = self.find(f'#change-{item_name}-toggle')
             edit_btn.click()
             self.wait_until_visible(f'#{item_name}-change-input')
@@ -324,11 +324,11 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
             change_btn.click()
             self.wait_until_visible(f'#project-{item_name}-name')
             project_name = self.find(f'#project-{item_name}-name')
-            self.assertTrue(new_item_name in project_name.text)
+            self.assertIn(new_item_name, project_name.text)
             # check change notificaiton is displayed
             change_notification = self.find('#change-notification')
-            self.assertTrue(
-                f'You have changed the {item_name} to: {new_item_name}' in change_notification.text
+            self.assertIn(
+                f'You have changed the {item_name} to: {new_item_name}', change_notification.text
             )
 
         # Machine
@@ -338,13 +338,13 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
 
         # Project release
         title = project_release.find_element(By.TAG_NAME, 'h3')
-        self.assertTrue("Project release" in title.text)
-        self.assertTrue(
-            "Yocto Project master" in self.find('#project-release-title').text
+        self.assertIn("Project release", title.text)
+        self.assertIn(
+            "Yocto Project master", self.find('#project-release-title').text
         )
         # Layers
         title = layers.find_element(By.TAG_NAME, 'h3')
-        self.assertTrue("Layers" in title.text)
+        self.assertIn("Layers", title.text)
         # check at least three layers are displayed
         # openembedded-core
         # meta-poky
@@ -372,7 +372,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         self.wait_until_visible('#layers-in-project-list')
         # check layer is added
         layers_list_items = layers_list.find_elements(By.TAG_NAME, 'li')
-        self.assertTrue(len(layers_list_items) == 4)
+        self.assertEqual(len(layers_list_items), 4)
 
     def test_most_build_recipes(self):
         """ Test most build recipes block contains"""
@@ -418,14 +418,14 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         most_built_recipes = self.driver.find_element(
             By.XPATH, '//*[@id="project-page"]/div[1]/div[3]')
         title = most_built_recipes.find_element(By.TAG_NAME, 'h3')
-        self.assertTrue("Most built recipes" in title.text)
+        self.assertIn("Most built recipes", title.text)
         # check can select a recipe and build it
         self.wait_until_visible('#freq-build-list', poll=3)
         recipe_list = self.find('#freq-build-list')
         recipe_list_items = recipe_list.find_elements(By.TAG_NAME, 'li')
         self.assertTrue(
             len(recipe_list_items) > 0,
-            msg="Any recipes found in the most built recipes list",
+            msg="No recipes found in the most built recipes list",
         )
         rebuild_from_most_build_recipes(recipe_list_items)
         TestProjectConfigTab.project_id = None  # reset project id
@@ -466,8 +466,8 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         layers = block_l.find_element(By.ID, 'layer-container')
         layers_list = layers.find_element(By.ID, 'layers-in-project-list')
         layers_list_items = layers_list.find_elements(By.TAG_NAME, 'li')
-        self.assertTrue(
-            'meta-fake' in str(layers_list_items[-1].text)
+        self.assertIn(
+            'meta-fake', str(layers_list_items[-1].text)
         )
 
     def test_project_page_custom_image_no_image(self):
@@ -482,8 +482,8 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         self.wait_until_visible('#empty-state-customimagestable')
 
         # Check message when no custom image
-        self.assertTrue(
-            "You have not created any custom images yet." in str(
+        self.assertIn(
+            "You have not created any custom images yet.", str(
                 self.find('#empty-state-customimagestable').text
             )
         )
@@ -491,13 +491,13 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         link_create_custom_image = div_empty_msg.find_element(
             By.TAG_NAME, 'a')
         self.assertTrue(TestProjectConfigTab.project_id is not None)
-        self.assertTrue(
-            f"/toastergui/project/{TestProjectConfigTab.project_id}/newcustomimage" in str(
+        self.assertIn(
+            f"/toastergui/project/{TestProjectConfigTab.project_id}/newcustomimage", str(
                 link_create_custom_image.get_attribute('href')
             )
         )
-        self.assertTrue(
-            "Create your first custom image" in str(
+        self.assertIn(
+            "Create your first custom image", str(
                 link_create_custom_image.text
             )
         )

