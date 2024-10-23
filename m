Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E507CDDE60
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:20 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.5155.1729677618078588336
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Us0rHSR4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431688d5127so43005285e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677616; x=1730282416; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHK/CvLBJcxnzPT/eL7NMrXh3OO2AcEuQNYyhXMeXOQ=;
        b=Us0rHSR4dDf7gh6MT92jHG726Q2W3SMW8Cbz6qFSUOCbdVHwDSE/uTtIna+K4fu6rm
         cisf6esLoUDwBki5u06FWVAPqXHNkRVApCFdWStRlaIg/1taLDeNyAxY1H9RNXVZW2r3
         /R1w+HXA1kSnyIEmCOY4ykjeEXqg8uZ4ixLek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677616; x=1730282416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHK/CvLBJcxnzPT/eL7NMrXh3OO2AcEuQNYyhXMeXOQ=;
        b=nQ/nv1fQjgu09wPenq5h2a5TUSDVBtD9xj9QdGhcm/ClL+9X396YWtUlD/Qks3sK1n
         oH8G/lIWj8JXZ4SIMltRYM98AZg0ORdwgrMVV8nOtIcXOwEdvW7l7rC0KGKjPAZbnCYC
         qjIZin4H0Q9VIudyeM96vuMDRQjWb24ZH5Lvf35+ACFaptSwBDw156sVUEMV0hj2CVQX
         vP4GhD3w9GympZur67AOvLxBgKs/ZugsTv4otlrji5PnqV2V+J4/h8JyjfNau1MBVwwq
         kg0pl20ER/+QgFeGVfE9ZRtHGMvuqqDkil/5WolHT1LXoovjRIICKs0euK1lqGryZCgB
         YiYQ==
X-Gm-Message-State: AOJu0Yylv0QLpdB3iW8smfZfAeuv7QGol6vRnisGmce/8Dedru+QXLYm
	5+hXZpsav74pkUg52Xt3Lyyjg9ix0yPUBp2cDoWreP6t/73B1Scg5pHGgDBcKtpaGEAArW04C/J
	n
X-Google-Smtp-Source: AGHT+IEusAGzyQhavpeLvg1+D82wIuFtovI8t86W0+NoZq/Rm9ZA0AnCLu0ssAmgKzCAZ4xcEQ9Y4Q==
X-Received: by 2002:a05:600c:524a:b0:431:12d0:746b with SMTP id 5b1f17b1804b1-431841af63amr13313245e9.35.1729677615886;
        Wed, 23 Oct 2024 03:00:15 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:15 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 24/28] toaster/tests/functional/project_page: Use wait_until_element_clickable before click calls
Date: Wed, 23 Oct 2024 10:59:45 +0100
Message-ID: <20241023095949.3351980-24-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16715

Switch the clickable() calls to use the new element_clickable() function
which accepts a finder labmda function. This means if the element doesn't
yet exist, the code can rebuild the query and try again once a small
amount of time has elapsed.

There were a ton of timing related races around these element interactions
and this seemed to be the most robust way to address the issues.

The change also makes some of the elements slightly more specific so
the code can work effectively.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_project_page.py     | 93 ++++++++-----------
 1 file changed, 40 insertions(+), 53 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index f34ccf5e8e..c6dad0eb5d 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -92,7 +92,8 @@ class TestProjectPageBase(SeleniumFunctionalTestCase):
             list_check_box_id: list
     ):
         # Check edit column
-        edit_column = self.find(f'#{edit_btn_id}')
+        finder = lambda driver: self.find(f'#{edit_btn_id}')
+        edit_column = self.wait_until_element_clickable(finder)
         self.assertTrue(edit_column.is_displayed())
         edit_column.click()
         # Check dropdown is visible
@@ -280,7 +281,8 @@ class TestProjectPage(TestProjectPageBase):
 
         # click on "Edit" icon button
         self.wait_until_visible('#project-name-container')
-        edit_button = self.find('#project-change-form-toggle')
+        finder = lambda driver: self.find('#project-change-form-toggle')
+        edit_button = self.wait_until_element_clickable(finder)
         edit_button.click()
         project_name_input = self.find('#project-name-change-input')
         self.assertTrue(project_name_input.is_displayed())
@@ -391,12 +393,8 @@ class TestProjectPage(TestProjectPageBase):
             table_selector='softwarerecipestable'
         )
         # check "build recipe" button works
-        rows = self.find_all('#softwarerecipestable tbody tr')
-        image_to_build = rows[0]
-        build_btn = image_to_build.find_element(
-            By.XPATH,
-            '//td[@class="add-del-layers"]//a[1]'
-        )
+        finder = lambda driver: self.find_all('#softwarerecipestable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]/a')
+        build_btn = self.wait_until_element_clickable(finder)
         build_btn.click()
         build_state = wait_until_build(self, 'queued cloning starting parsing failed')
         lastest_builds = self.driver.find_elements(
@@ -404,11 +402,10 @@ class TestProjectPage(TestProjectPageBase):
             '//div[@id="latest-builds"]/div'
         )
         self.assertTrue(len(lastest_builds) > 0)
-        last_build = lastest_builds[0]
-        cancel_button = last_build.find_element(
-            By.XPATH,
-            '//span[@class="cancel-build-btn pull-right alert-link"]',
-        )
+        # Find the latest builds, the last build and then the cancel button
+ 
+        finder = lambda driver: driver.find_elements(By.XPATH, '//div[@id="latest-builds"]/div')[0].find_element(By.XPATH, '//span[@class="cancel-build-btn pull-right alert-link"]')
+        cancel_button = self.wait_until_element_clickable(finder)
         cancel_button.click()
         if 'starting' not in build_state:  # change build state when cancelled in starting state
             wait_until_build_cancelled(self)
@@ -455,14 +452,10 @@ class TestProjectPage(TestProjectPageBase):
             table_selector='machinestable'
         )
         # check "Select machine" button works
-        rows = self.find_all('#machinestable tbody tr')
-        machine_to_select = rows[0]
-        select_btn = machine_to_select.find_element(
-            By.XPATH,
-            '//td[@class="add-del-layers"]//a[1]'
-        )
-        select_btn.send_keys(Keys.RETURN)
-        self.wait_until_visible('#config-nav')
+        finder = lambda driver: self.find_all('#machinestable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]')
+        select_btn = self.wait_until_element_clickable(finder)
+        select_btn.click()
+        self.wait_until_visible('#project-machine-name')
         project_machine_name = self.find('#project-machine-name')
         self.assertIn(
             'qemux86-64', project_machine_name.text
@@ -478,9 +471,9 @@ class TestProjectPage(TestProjectPageBase):
         )
 
         self.wait_until_visible('#machinestable tbody tr')
-        rows = self.find_all('#machinestable tbody tr')
-        machine_to_add = rows[0]
-        add_btn = machine_to_add.find_element(By.XPATH, '//td[@class="add-del-layers"]')
+        # Locate a machine to add button
+        finder = lambda driver: self.find_all('#machinestable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]')
+        add_btn = self.wait_until_element_clickable(finder)
         add_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -488,7 +481,8 @@ class TestProjectPage(TestProjectPageBase):
             f'You have added 1 layer to your project', str(change_notification.text)
         )
 
-        hide_button = self.find('#hide-alert')
+        finder = lambda driver: self.find('#hide-alert')
+        hide_button = self.wait_until_element_clickable(finder)
         hide_button.click()
         self.wait_until_not_visible('#change-notification')
 
@@ -533,21 +527,15 @@ class TestProjectPage(TestProjectPageBase):
         )
         # check "Add layer" button works
         self.wait_until_visible('#layerstable tbody tr')
-        rows = self.find_all('#layerstable tbody tr')
-        layer_to_add = rows[0]
-        add_btn = layer_to_add.find_element(
-            By.XPATH,
-            '//td[@class="add-del-layers"]'
-        )
+        finder = lambda driver: self.find_all('#layerstable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]/a[@data-directive="add"]')
+        add_btn = self.wait_until_element_clickable(finder)
         add_btn.click()
         # check modal is displayed
         self.wait_until_visible('#dependencies-modal')
         list_dependencies = self.find_all('#dependencies-list li')
         # click on add-layers button
-        add_layers_btn = self.driver.find_element(
-            By.XPATH,
-            '//form[@id="dependencies-modal-form"]//button[@class="btn btn-primary"]'
-        )
+        finder = lambda driver: self.driver.find_element(By.XPATH, '//form[@id="dependencies-modal-form"]//button[@class="btn btn-primary"]')
+        add_layers_btn = self.wait_until_element_clickable(finder)
         add_layers_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -555,18 +543,15 @@ class TestProjectPage(TestProjectPageBase):
             f'You have added {len(list_dependencies)+1} layers to your project: {input_text} and its dependencies', str(change_notification.text)
         )
 
-        hide_button = self.find('#hide-alert')
+        finder = lambda driver: self.find('#hide-alert')
+        hide_button = self.wait_until_element_clickable(finder)
         hide_button.click()
         self.wait_until_not_visible('#change-notification')
 
         # check "Remove layer" button works
         self.wait_until_visible('#layerstable tbody tr')
-        rows = self.find_all('#layerstable tbody tr')
-        layer_to_remove = rows[0]
-        remove_btn = layer_to_remove.find_element(
-            By.XPATH,
-            '//td[@class="add-del-layers"]'
-        )
+        finder = lambda driver: self.find_all('#layerstable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]/a[@data-directive="remove"]')
+        remove_btn = self.wait_until_element_clickable(finder)
         remove_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -574,7 +559,8 @@ class TestProjectPage(TestProjectPageBase):
             f'You have removed 1 layer from your project: {input_text}', str(change_notification.text)
         )
 
-        hide_button = self.find('#hide-alert')
+        finder = lambda driver: self.find('#hide-alert')
+        hide_button = self.wait_until_element_clickable(finder)
         hide_button.click()
         self.wait_until_not_visible('#change-notification')
 
@@ -618,12 +604,9 @@ class TestProjectPage(TestProjectPageBase):
             table_selector='distrostable'
         )
         # check "Add distro" button works
-        rows = self.find_all('#distrostable tbody tr')
-        distro_to_add = rows[0]
-        add_btn = distro_to_add.find_element(
-            By.XPATH,
-            '//td[@class="add-del-layers"]//a[1]'
-        )
+        self.wait_until_visible(".add-del-layers")
+        finder = lambda driver: self.find_all('#distrostable tbody tr')[0].find_element(By.XPATH, '//td[@class="add-del-layers"]')
+        add_btn = self.wait_until_element_clickable(finder)
         add_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
@@ -668,25 +651,29 @@ class TestProjectPage(TestProjectPageBase):
         self.assertTrue(self.find('.page-header h1').is_displayed())
 
         # check remove layer button works
-        remove_layer_btn = self.find('#add-remove-layer-btn')
+        finder = lambda driver: self.find('#add-remove-layer-btn')
+        remove_layer_btn = self.wait_until_element_clickable(finder)
         remove_layer_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
         self.assertIn(
             f'You have removed 1 layer from your project', str(change_notification.text)
         )
-        hide_button = self.find('#hide-alert')
+        finder = lambda driver: self.find('#hide-alert')
+        hide_button = self.wait_until_element_clickable(finder)
         hide_button.click()
         # check add layer button works
         self.wait_until_not_visible('#change-notification')
-        add_layer_btn = self.find('#add-remove-layer-btn')
+        finder = lambda driver: self.find('#add-remove-layer-btn')
+        add_layer_btn = self.wait_until_element_clickable(finder)
         add_layer_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
         self.assertIn(
             f'You have added 1 layer to your project', str(change_notification.text)
         )
-        hide_button = self.find('#hide-alert')
+        finder = lambda driver: self.find('#hide-alert')
+        hide_button = self.wait_until_element_clickable(finder)
         hide_button.click()
         self.wait_until_not_visible('#change-notification')
         # check tabs(layers, recipes, machines) are displayed

