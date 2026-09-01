Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30940C61DD6
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 22:56:03 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.215.1788303359981052371
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Sep 2026 15:56:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YkHiZ3qi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so265014f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 15:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788303358; x=1788908158; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/F4EpwlNfbbWc8PsIDnf83GHXk96PbJHBpkqjxo69iY=;
        b=YkHiZ3qiss2apn8w2XK/vRL23Ch7S7U/lHjREJGS03HBppdSAGg9ToAWJkMdSqz20d
         d/h5cqwdxn28SWzBMAiNOaD5H9Lb4G6eJ/df7YztVlq7cn98jtvNw4d3pFyL6TveHmk4
         facLPJJOU+diybhysnoh9LiN0Vpqqki3Pe/rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303358; x=1788908158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/F4EpwlNfbbWc8PsIDnf83GHXk96PbJHBpkqjxo69iY=;
        b=C25MIGwAE4yL7X4lZYK26O25NrKEuVF053NKXGTNb1d0MrG8jTJyQPCNtnlg50WLIJ
         IDrWyiQdKjXj/00ox6qWfh6HR1hssUkrS8VBAtTKG/PlieyNip3abzfyXs2VbB3Anxn3
         GTWShRNiEkZ3tr21oXWuLrc8qNzpqlwd/XNCrdPi9lp1/qy24bWMonTHWPIINH0dfYST
         GaBACirgQ07mnKglxwF2OlgG7giAvikNzWK7zzX6I3SDO1XW3OsmNjSHGhJtS02eKdVz
         IKI2dVS1vUqhSNxYonflLKsyuOgoOrHQpjEccdxy89vkl4i0auLmzzy3GObS0i+ctM7j
         0T+A==
X-Gm-Message-State: AFuF++mFHTfiqcjZp5o+RVC0JCgf3UwTZYp9ScgL5KElvqtiuQrYIHzd
	i4VBv/I+3jii1/IXTAo1MEGZ4gnFt16tx8Ee6oyWRhX9OgS+xKWbw7AqtlvMgeBa0sTfzXkc24a
	mamWo4NA=
X-Gm-Gg: AYBFou3gEFKDDigJBoXQ3twPih1D9pY2hynOzKHFDPJunPy3pgQh4hiEAS4kH7yMhMv
	ULp+fT4QTgUIX9jHH9aLzrR7Y/Ul23c4MfBvU4efEK2NsI6O/wgqKGYV/MGb+i3Qmg1WNdIAJ/L
	uuTKfiztKhe0khGyfn354RcjsdtuI8hWIAvav7pCgIS4wBkm3TGlBhIRlLUlIaM5JBjvPqY27jt
	aOK8uUz0ahSVbCaidtJ2a+XSon2xRwOdt8df/IjMGLT/nHx5wXLermeXDypXJgAcdVqMbCjV9w8
	dwPGX4vhwGpktodSF01LVuhzZFC5FEeDlYJJ+a0kE2yN2MBzVslAxxsqUlDXcBUlBRUo4e7A4D9
	hgXvTQ57aXOnyTsFrRZOOPZ1seckEaeXau+FzZqzKaCk4SkWRD3vAxcN6W4JihkO4xxwgxsla3g
	8c2s2BTijWxTjtbVgPUmPsteeslR0hP1UI5sGz6GYRHMklqHILakGBq5vPLlw03peO5MDpYayvl
	o+Dys6gCMbgo87YJg==
X-Received: by 2002:a05:6000:461d:b0:484:3c3a:5932 with SMTP id ffacd0b85a97d-484914bf982mr910400f8f.22.1788303358097;
        Tue, 01 Sep 2026 15:55:58 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9e4b:8577:fa6f:4727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed37c4sm1644388f8f.21.2026.09.01.15.55.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:55:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/5] toaster: Rename wait_until_element_clickable -> wait_under_finder_clickable
Date: Tue,  1 Sep 2026 23:55:51 +0100
Message-ID: <20260901225555.2254932-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 22:56:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20140

We want a version of the function which accepts elements but we need
to fix the naming of the finder variant first to stop things getting
too consfusing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/browser/selenium_helpers_base.py    |  2 +-
 .../tests/functional/test_project_page.py     | 34 +++++++++----------
 .../test_project_page_tab_config.py           |  2 +-
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index a901791aa16..ca27b3b9877 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -247,7 +247,7 @@ class SeleniumTestCaseBase(unittest.TestCase):
         Wait(self.driver, timeout=timeout).until(is_clickable, msg)
         return self.find(selector)
 
-    def wait_until_element_clickable(self, finder, timeout=Wait._TIMEOUT):
+    def wait_until_finder_clickable(self, finder, timeout=Wait._TIMEOUT):
         """ Wait until element is clickable """
         WebDriverWait(self.driver, timeout=timeout).until(lambda driver: self.driver.execute_script("return jQuery.active == 0"))
         is_clickable = lambda driver: (finder(driver).is_displayed() and finder(driver).is_enabled())
diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index 429d86feba0..0a8aa1c7dcb 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -93,7 +93,7 @@ class TestProjectPageBase(SeleniumFunctionalTestCase):
     ):
         # Check edit column
         finder = lambda driver: self.find(f'#{edit_btn_id}')
-        edit_column = self.wait_until_element_clickable(finder)
+        edit_column = self.wait_until_finder_clickable(finder)
         self.assertTrue(edit_column.is_displayed())
         edit_column.click()
         # Check dropdown is visible
@@ -282,7 +282,7 @@ class TestProjectPage(TestProjectPageBase):
         # click on "Edit" icon button
         self.wait_until_visible('#project-name-container')
         finder = lambda driver: self.find('#project-change-form-toggle')
-        edit_button = self.wait_until_element_clickable(finder)
+        edit_button = self.wait_until_finder_clickable(finder)
         edit_button.click()
         project_name_input = self.find('#project-name-change-input')
         self.assertTrue(project_name_input.is_displayed())
@@ -394,7 +394,7 @@ class TestProjectPage(TestProjectPageBase):
         )
         # check "build recipe" button works
         finder = lambda driver: self.find_all('#softwarerecipestable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]/a')
-        build_btn = self.wait_until_element_clickable(finder)
+        build_btn = self.wait_until_finder_clickable(finder)
         build_btn.click()
         build_state = wait_until_build(self, 'queued cloning starting parsing failed')
         lastest_builds = self.driver.find_elements(
@@ -405,7 +405,7 @@ class TestProjectPage(TestProjectPageBase):
         # Find the latest builds, the last build and then the cancel button
  
         finder = lambda driver: driver.find_elements(By.XPATH, '//div[@id="latest-builds"]/div')[0].find_element(By.XPATH, '//span[@class="cancel-build-btn pull-right alert-link"]')
-        cancel_button = self.wait_until_element_clickable(finder)
+        cancel_button = self.wait_until_finder_clickable(finder)
         cancel_button.click()
         if 'starting' not in build_state:  # change build state when cancelled in starting state
             wait_until_build_cancelled(self)
@@ -453,7 +453,7 @@ class TestProjectPage(TestProjectPageBase):
         )
         # check "Select machine" button works
         finder = lambda driver: self.find_all('#machinestable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]')
-        select_btn = self.wait_until_element_clickable(finder)
+        select_btn = self.wait_until_finder_clickable(finder)
         select_btn.click()
         self.wait_until_visible('#project-machine-name')
         project_machine_name = self.find('#project-machine-name')
@@ -473,7 +473,7 @@ class TestProjectPage(TestProjectPageBase):
         self.wait_until_visible('#machinestable tbody tr')
         # Locate a machine to add button
         finder = lambda driver: self.find_all('#machinestable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]')
-        add_btn = self.wait_until_element_clickable(finder)
+        add_btn = self.wait_until_finder_clickable(finder)
         add_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -482,7 +482,7 @@ class TestProjectPage(TestProjectPageBase):
         )
 
         finder = lambda driver: self.find('#hide-alert')
-        hide_button = self.wait_until_element_clickable(finder)
+        hide_button = self.wait_until_finder_clickable(finder)
         hide_button.click()
         self.wait_until_not_visible('#change-notification')
 
@@ -528,14 +528,14 @@ class TestProjectPage(TestProjectPageBase):
         # check "Add layer" button works
         self.wait_until_visible('#layerstable tbody tr')
         finder = lambda driver: self.find_all('#layerstable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]/a[@data-directive="add"]')
-        add_btn = self.wait_until_element_clickable(finder)
+        add_btn = self.wait_until_finder_clickable(finder)
         add_btn.click()
         # check modal is displayed
         self.wait_until_visible('#dependencies-modal')
         list_dependencies = self.find_all('#dependencies-list li')
         # click on add-layers button
         finder = lambda driver: self.driver.find_element(By.XPATH, '//form[@id="dependencies-modal-form"]//button[@class="btn btn-primary"]')
-        add_layers_btn = self.wait_until_element_clickable(finder)
+        add_layers_btn = self.wait_until_finder_clickable(finder)
         add_layers_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -544,14 +544,14 @@ class TestProjectPage(TestProjectPageBase):
         )
 
         finder = lambda driver: self.find('#hide-alert')
-        hide_button = self.wait_until_element_clickable(finder)
+        hide_button = self.wait_until_finder_clickable(finder)
         hide_button.click()
         self.wait_until_not_visible('#change-notification')
 
         # check "Remove layer" button works
         self.wait_until_visible('#layerstable tbody tr')
         finder = lambda driver: self.find_all('#layerstable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]/a[@data-directive="remove"]')
-        remove_btn = self.wait_until_element_clickable(finder)
+        remove_btn = self.wait_until_finder_clickable(finder)
         remove_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -560,7 +560,7 @@ class TestProjectPage(TestProjectPageBase):
         )
 
         finder = lambda driver: self.find('#hide-alert')
-        hide_button = self.wait_until_element_clickable(finder)
+        hide_button = self.wait_until_finder_clickable(finder)
         hide_button.click()
         self.wait_until_not_visible('#change-notification')
 
@@ -606,7 +606,7 @@ class TestProjectPage(TestProjectPageBase):
         # check "Add distro" button works
         self.wait_until_visible(".add-del-layers")
         finder = lambda driver: self.find_all('#distrostable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]')
-        add_btn = self.wait_until_element_clickable(finder)
+        add_btn = self.wait_until_finder_clickable(finder)
         add_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -652,7 +652,7 @@ class TestProjectPage(TestProjectPageBase):
 
         # check remove layer button works
         finder = lambda driver: self.find('#add-remove-layer-btn')
-        remove_layer_btn = self.wait_until_element_clickable(finder)
+        remove_layer_btn = self.wait_until_finder_clickable(finder)
         remove_layer_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -660,12 +660,12 @@ class TestProjectPage(TestProjectPageBase):
             f'You have removed 1 layer from your project', str(change_notification.text)
         )
         finder = lambda driver: self.find('#hide-alert')
-        hide_button = self.wait_until_element_clickable(finder)
+        hide_button = self.wait_until_finder_clickable(finder)
         hide_button.click()
         # check add layer button works
         self.wait_until_not_visible('#change-notification')
         finder = lambda driver: self.find('#add-remove-layer-btn')
-        add_layer_btn = self.wait_until_element_clickable(finder)
+        add_layer_btn = self.wait_until_finder_clickable(finder)
         add_layer_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -673,7 +673,7 @@ class TestProjectPage(TestProjectPageBase):
             f'You have added 1 layer to your project', str(change_notification.text)
         )
         finder = lambda driver: self.find('#hide-alert')
-        hide_button = self.wait_until_element_clickable(finder)
+        hide_button = self.wait_until_finder_clickable(finder)
         hide_button.click()
         self.wait_until_not_visible('#change-notification')
         # check tabs(layers, recipes, machines) are displayed
diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py b/lib/toaster/tests/functional/test_project_page_tab_config.py
index 80c53e1544a..525073ef6b0 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -330,7 +330,7 @@ class TestProjectConfigTab(TestProjectConfigTabBase):
         self.wait_until_visible('#layer-container > form > div > span > div')
         self.wait_until_visible('.dropdown-menu')
         finder = lambda driver: driver.find_element(By.XPATH, '//*[@id="layer-container"]/form/div/span/div/div/div')
-        dropdown_item = self.wait_until_element_clickable(finder)
+        dropdown_item = self.wait_until_finder_clickable(finder)
         dropdown_item.click()
         self.wait_until_clickable('#add-layer-btn')
         add_layer_btn = layers.find_element(By.ID, 'add-layer-btn')

