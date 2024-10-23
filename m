Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA334CDDE51
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.5154.1729677607573380721
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h+hUZZJ4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so36538975e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677606; x=1730282406; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsbDpOSGDFITqHfH1ALwhAh/bpByCPlZ8Oya81VEGT8=;
        b=h+hUZZJ4BSL4gFn7bJh9fo/6MJqm/vSWRlVAqeWeUvOU1KG+04Mtwf4VO25JAvsqVj
         jttGZRx2E4/NmC9i1siT0+xdI11A+X8sT1FEa1oi3BGMpI1fJ5hiXypN9Nwt43rEz+ry
         oPS0ec6t5kWpd3QUK1VzpKe8jjIGWcr7VrmMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677606; x=1730282406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsbDpOSGDFITqHfH1ALwhAh/bpByCPlZ8Oya81VEGT8=;
        b=OmFQOp4LCl7/7uva8/sKEVXYD2h/467vmaT2Fnq1HT3RrzpR5cxOBjmwBaIx5Do5F/
         htjZpZkujkiNzp+BWORM9/XSJsVR6+kKh5LRT7kj1yd4U3B/XuOY2ztN8pgZj9gVu6kF
         +TUoQSVs5WjLSWqfGDADAvBWoKJv7KLFfVb4OWF8jbvvIzSK9mKQDAj2LWEtsMDvJHRt
         P6anb02C5yOeE+2fUT78it1AcdAsW0BgDgjca8EjFBteNEFUEQmLDgqvtqPBqXrQZcEH
         aTe41LnmbjqGUms9umncKjx/wYKqbPQloRwOl3gHak8LGJAXsfDVlgGquOI2NDnSQDH0
         IMXw==
X-Gm-Message-State: AOJu0Yw5kOTM+mZ3xsxp0mm8eHC5M2orA2++M44ySa8ShoL7XSKBBV0l
	/vILQa1t7rTUIZsIGfi/XqyOHC4VrVvEpwJbBkAa7ykyCqEpEPkQyB9xo2f/11XS9djf1gusbUY
	8
X-Google-Smtp-Source: AGHT+IHerE9+U9znRniYzr7kG3SCgZ6afzmNPu9A6r7BIX/NTOWMDrrSu+dOvOgM9imZfThSLsv4lg==
X-Received: by 2002:a05:6000:4598:b0:37d:46f4:35 with SMTP id ffacd0b85a97d-37efcf84a6bmr1227873f8f.45.1729677605660;
        Wed, 23 Oct 2024 03:00:05 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 14/28] toaster/tests/functiona/project_page: Improve waits and drop polling
Date: Wed, 23 Oct 2024 10:59:35 +0100
Message-ID: <20241023095949.3351980-14-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16705

These changes:

* Drop the poll parameters
* Add waits where needed or make them more specific
* Add calls to close notification boxes since they can obscure
  other page elements
* In one case wait for a "Loading" message to be replaced

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_project_page.py     | 53 ++++++++++++++-----
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index 7e73cac438..f34ccf5e8e 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -8,6 +8,7 @@
 
 import os
 import string
+import time
 from unittest import skip
 import pytest
 from django.urls import reverse
@@ -150,7 +151,7 @@ class TestProjectPageBase(SeleniumFunctionalTestCase):
         def test_show_rows(row_to_show, show_row_link):
             # Check that we can show rows == row_to_show
             show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_visible(f'#{table_selector} tbody tr', poll=3)
+            self.wait_until_visible(f'#{table_selector} tbody tr')
             # check at least some rows are visible
             self.assertTrue(
                 len(self.find_all(f'#{table_selector} tbody tr')) > 0
@@ -359,11 +360,15 @@ class TestProjectPage(TestProjectPageBase):
         search_box.send_keys('core-image-minimal')
         self.find('#build-button').click()
         self.wait_until_visible('#latest-builds')
-        lastest_builds = self.driver.find_elements(
-            By.XPATH,
-            '//div[@id="latest-builds"]',
-        )
-        last_build = lastest_builds[0]
+        buildtext = "Loading"
+        while "Loading" in buildtext:
+            time.sleep(1)
+            lastest_builds = self.driver.find_elements(
+                By.XPATH,
+                '//div[@id="latest-builds"]',
+            )
+            last_build = lastest_builds[0]
+            buildtext = last_build.text
         self.assertIn(
             'core-image-minimal', str(last_build.text)
         )
@@ -471,7 +476,8 @@ class TestProjectPage(TestProjectPageBase):
             searchBtn_selector='search-submit-machinestable',
             table_selector='machinestable'
         )
-        self.wait_until_visible('#machinestable tbody tr', poll=3)
+
+        self.wait_until_visible('#machinestable tbody tr')
         rows = self.find_all('#machinestable tbody tr')
         machine_to_add = rows[0]
         add_btn = machine_to_add.find_element(By.XPATH, '//td[@class="add-del-layers"]')
@@ -481,6 +487,11 @@ class TestProjectPage(TestProjectPageBase):
         self.assertIn(
             f'You have added 1 layer to your project', str(change_notification.text)
         )
+
+        hide_button = self.find('#hide-alert')
+        hide_button.click()
+        self.wait_until_not_visible('#change-notification')
+
         # check Machine table feature(show/hide column, pagination)
         self._navigate_to_config_nav('machinestable', 5)
         column_list = [
@@ -521,7 +532,7 @@ class TestProjectPage(TestProjectPageBase):
             table_selector='layerstable'
         )
         # check "Add layer" button works
-        self.wait_until_visible('#layerstable tbody tr', poll=3)
+        self.wait_until_visible('#layerstable tbody tr')
         rows = self.find_all('#layerstable tbody tr')
         layer_to_add = rows[0]
         add_btn = layer_to_add.find_element(
@@ -530,7 +541,7 @@ class TestProjectPage(TestProjectPageBase):
         )
         add_btn.click()
         # check modal is displayed
-        self.wait_until_visible('#dependencies-modal', poll=3)
+        self.wait_until_visible('#dependencies-modal')
         list_dependencies = self.find_all('#dependencies-list li')
         # click on add-layers button
         add_layers_btn = self.driver.find_element(
@@ -543,8 +554,13 @@ class TestProjectPage(TestProjectPageBase):
         self.assertIn(
             f'You have added {len(list_dependencies)+1} layers to your project: {input_text} and its dependencies', str(change_notification.text)
         )
+
+        hide_button = self.find('#hide-alert')
+        hide_button.click()
+        self.wait_until_not_visible('#change-notification')
+
         # check "Remove layer" button works
-        self.wait_until_visible('#layerstable tbody tr', poll=3)
+        self.wait_until_visible('#layerstable tbody tr')
         rows = self.find_all('#layerstable tbody tr')
         layer_to_remove = rows[0]
         remove_btn = layer_to_remove.find_element(
@@ -552,11 +568,16 @@ class TestProjectPage(TestProjectPageBase):
             '//td[@class="add-del-layers"]'
         )
         remove_btn.click()
-        self.wait_until_visible('#change-notification', poll=2)
+        self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
         self.assertIn(
             f'You have removed 1 layer from your project: {input_text}', str(change_notification.text)
         )
+
+        hide_button = self.find('#hide-alert')
+        hide_button.click()
+        self.wait_until_not_visible('#change-notification')
+
         # check layers table feature(show/hide column, pagination)
         self._navigate_to_config_nav('layerstable', 6)
         column_list = [
@@ -604,7 +625,7 @@ class TestProjectPage(TestProjectPageBase):
             '//td[@class="add-del-layers"]//a[1]'
         )
         add_btn.click()
-        self.wait_until_visible('#change-notification', poll=2)
+        self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
         self.assertIn(
             f'You have changed the distro to: {input_text}', str(change_notification.text)
@@ -649,12 +670,15 @@ class TestProjectPage(TestProjectPageBase):
         # check remove layer button works
         remove_layer_btn = self.find('#add-remove-layer-btn')
         remove_layer_btn.click()
-        self.wait_until_visible('#change-notification', poll=2)
+        self.wait_until_visible('#change-notification')
         change_notification = self.find('#change-notification')
         self.assertIn(
             f'You have removed 1 layer from your project', str(change_notification.text)
         )
+        hide_button = self.find('#hide-alert')
+        hide_button.click()
         # check add layer button works
+        self.wait_until_not_visible('#change-notification')
         add_layer_btn = self.find('#add-remove-layer-btn')
         add_layer_btn.click()
         self.wait_until_visible('#change-notification')
@@ -662,6 +686,9 @@ class TestProjectPage(TestProjectPageBase):
         self.assertIn(
             f'You have added 1 layer to your project', str(change_notification.text)
         )
+        hide_button = self.find('#hide-alert')
+        hide_button.click()
+        self.wait_until_not_visible('#change-notification')
         # check tabs(layers, recipes, machines) are displayed
         tabs = self.find_all('.nav-tabs li')
         self.assertEqual(len(tabs), 3)

