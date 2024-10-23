Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6191CDDE49
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:19 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.5151.1729677610760224897
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bWkM7bGY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315eac969aso4821185e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677609; x=1730282409; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWE9EpkyPY6jCqvll7xAm29ieg9iu30x3cPV4PHlkNA=;
        b=bWkM7bGYrPqsgPMAtoI8vXIDH+ATgHCp9TQAB5q5uZjPNrRCs299ZaCdj6TRZNDWCP
         ZHtO0HnUpr97KHnFhx0N7CirfnzLfQfZZsWuCEHM+oOzqE1VU2+F9fP9WHxvia93kZJf
         ekzfvA9RVnea2qdZY4denLfpWQutnnDsYHZ8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677609; x=1730282409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWE9EpkyPY6jCqvll7xAm29ieg9iu30x3cPV4PHlkNA=;
        b=PHoOjxLEvt8pbPnhC8CkRI4cXdpYtvFMfzm9597Nk3YOxPxxSHoZ2QvKhkddoj6Idg
         HWmKPe4zxTHJPtx/sX88+f4TheYxivR0xx6qBYROQhS0/2CqWNqrdYIWOi5CGbETatJv
         jLYgaF1ZCTZ4aKZektP1vN3/HPMCsCjxN2LIwy39jga4l+lBFSI17zJt4KT+ynrxDA+I
         aogEpEycEKAdORhuLu7UBucrf78hMNZv9zUTJYLmdIGg40e49n9ehHb5UxZNMwrQWkcK
         Hema9j6YkKdYociC236nr96HaX1T4D1eOgoPFLEmGK8SrNXEcYTlKmn99H8gpfvak1FY
         GtqA==
X-Gm-Message-State: AOJu0YxTvlxV9p/qUuFlmlmDGQ1EwWjff1S0CnLFDWxAYLuECxYEvtm1
	x8wegPXHjDt7HNpyGCPKFbjjD1rq+NNwWMfi0xDDU+Ta+alkNk+Z2vJYpWYWJkYJ1C3h3umYBmr
	r
X-Google-Smtp-Source: AGHT+IHCRGQwWYDjgn3AA17113z5hjJtDMbmxTv4gMhOJlkzw1kRHtufK19cKApGQLwCBmOJDMVqew==
X-Received: by 2002:a05:600c:3590:b0:431:4a82:97f2 with SMTP id 5b1f17b1804b1-4317bd7f68fmr41312245e9.6.1729677608769;
        Wed, 23 Oct 2024 03:00:08 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:08 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 17/28] toaster/tests/functiona/project_page_tab_config: Improve waits and drop polling
Date: Wed, 23 Oct 2024 10:59:38 +0100
Message-ID: <20241023095949.3351980-17-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16707

Drop the poll parameters and make the waits much more specific for
the requirements of the tests. This includes looping waiting for
a list of layer elements as that code was previously particularly
fragile.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../test_project_page_tab_config.py           | 52 ++++++++++++-------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py b/lib/toaster/tests/functional/test_project_page_tab_config.py
index daf00d8f1d..80c53e1544 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -7,12 +7,12 @@
 #
 
 import string
+import time
 import pytest
 from django.urls import reverse
 from selenium.webdriver import Keys
 from selenium.webdriver.support.select import Select
 from selenium.common.exceptions import ElementClickInterceptedException, NoSuchElementException, TimeoutException
-from orm.models import Project
 from tests.functional.functional_helpers import SeleniumFunctionalTestCase
 from selenium.webdriver.common.by import By
 
@@ -210,7 +210,7 @@ class TestProjectConfigTab(TestProjectConfigTabBase):
         def test_show_rows(row_to_show, show_row_link):
             # Check that we can show rows == row_to_show
             show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_visible('#imagerecipestable tbody tr', poll=3)
+            self.wait_until_visible('#imagerecipestable tbody tr')
             # check at least some rows are visible
             self.assertTrue(
                 len(self.find_all('#imagerecipestable tbody tr'))  > 0
@@ -289,6 +289,9 @@ class TestProjectConfigTab(TestProjectConfigTabBase):
             self.assertIn(
                 f'You have changed the {item_name} to: {new_item_name}', change_notification.text
             )
+            hide_button = self.find('#hide-alert')
+            hide_button.click()
+            self.wait_until_not_visible('#change-notification')
 
         # Machine
         check_machine_distro(self, 'machine', 'qemux86-64', 'machine-section')
@@ -304,35 +307,44 @@ class TestProjectConfigTab(TestProjectConfigTabBase):
         # Layers
         title = layers.find_element(By.TAG_NAME, 'h3')
         self.assertIn("Layers", title.text)
+        self.wait_until_clickable('#layer-add-input')
         # check at least three layers are displayed
         # openembedded-core
         # meta-poky
         # meta-yocto-bsp
-        layers_list = layers.find_element(By.ID, 'layers-in-project-list')
-        layers_list_items = layers_list.find_elements(By.TAG_NAME, 'li')
+        layer_list_items = []
+        starttime = time.time()
+        while len(layer_list_items) < 3:
+            layers_list = self.driver.find_element(By.ID, 'layers-in-project-list')
+            layer_list_items = layers_list.find_elements(By.TAG_NAME, 'li')
+            if time.time() > (starttime + 30):
+                self.fail("Layer list didn't contain at least 3 items within 30s (contained %d)" % len(layer_list_items))
+
         # remove all layers except the first three layers
-        for i in range(3, len(layers_list_items)):
-            layers_list_items[i].find_element(By.TAG_NAME, 'span').click()
+        for i in range(3, len(layer_list_items)):
+            layer_list_items[i].find_element(By.TAG_NAME, 'span').click()
+
         # check can add a layer if exists
         add_layer_input = layers.find_element(By.ID, 'layer-add-input')
         add_layer_input.send_keys('meta-oe')
         self.wait_until_visible('#layer-container > form > div > span > div')
-        dropdown_item = self.driver.find_element(
-            By.XPATH,
-            '//*[@id="layer-container"]/form/div/span/div'
-        )
-        try:
-            dropdown_item.click()
-        except ElementClickInterceptedException:
-            self.skipTest(
-                "layer-container dropdown item click intercepted. Element not properly visible.")
+        self.wait_until_visible('.dropdown-menu')
+        finder = lambda driver: driver.find_element(By.XPATH, '//*[@id="layer-container"]/form/div/span/div/div/div')
+        dropdown_item = self.wait_until_element_clickable(finder)
+        dropdown_item.click()
+        self.wait_until_clickable('#add-layer-btn')
         add_layer_btn = layers.find_element(By.ID, 'add-layer-btn')
         add_layer_btn.click()
         self.wait_until_visible('#layers-in-project-list')
-        # check layer is added
-        layers_list_items = layers_list.find_elements(By.TAG_NAME, 'li')
-        self.assertEqual(len(layers_list_items), 4)
 
+        # check layer is added
+        layer_list_items = []
+        starttime = time.time()
+        while len(layer_list_items) < 4:
+            layers_list = self.driver.find_element(By.ID, 'layers-in-project-list')
+            layer_list_items = layers_list.find_elements(By.TAG_NAME, 'li')
+            if time.time() > (starttime + 30):
+                self.fail("Layer list didn't contain at least 4 items within 30s (contained %d)" % len(layer_list_items))
 
     def test_project_page_tab_importlayer(self):
         """ Test project page tab import layer """
@@ -476,7 +488,7 @@ class TestProjectConfigTabDB(TestProjectConfigTabBase):
         # back to project page
         self.driver.get(url)
 
-        self.wait_until_visible('#project-page', poll=3)
+        self.wait_until_visible('#project-page')
 
         # Most built recipes
         most_built_recipes = self.driver.find_element(
@@ -484,7 +496,7 @@ class TestProjectConfigTabDB(TestProjectConfigTabBase):
         title = most_built_recipes.find_element(By.TAG_NAME, 'h3')
         self.assertIn("Most built recipes", title.text)
         # check can select a recipe and build it
-        self.wait_until_visible('#freq-build-list', poll=3)
+        self.wait_until_visible('#freq-build-list')
         recipe_list = self.find('#freq-build-list')
         recipe_list_items = recipe_list.find_elements(By.TAG_NAME, 'li')
         self.assertTrue(

