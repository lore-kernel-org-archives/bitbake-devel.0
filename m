Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94924CDD0F9
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 09:59:59 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.5133.1729677593492478647
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 02:59:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=K26HX7fR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so69720335e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677591; x=1730282391; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DBT5iADvxGq4dxMQB/2a2s7WeYLRYVXxfSdIfvi0p4=;
        b=K26HX7fRlmVvIX8G9K/FdggJ0dkFFah+6xY3CWBODiQa+wOVOyhsWL98/ajL8+DHBI
         GjEypsv82c3wOynMZ5U0MWtz2mqMf88Zzo2k0zQ3oEupwHN6HkyBH5pJyLAQCC5XkRgX
         HfGzem7C3zhvTBgWStT0ds3I4jiSW2M9TT5TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677591; x=1730282391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DBT5iADvxGq4dxMQB/2a2s7WeYLRYVXxfSdIfvi0p4=;
        b=pBFf3BL7CB3+7BAkdFxFVMujz9XQjdpCCSb9ojBu0cvcYlwh6cYRw+56Ym8pII8pmX
         y3TgdMOF1yG7OBV5ugyR1ezFssWs44/sFAmhGBbKJU7DczWjiqmrgKWq7sDCW43mOlM3
         g/iX7E97qt4qf+mCqpsb64eKgvcKrOAJYm2z6sJxEqzQXu7YuUEme9Stp5jq3TK79RxH
         oPUHPqpPu3oEYX2H5G57TZKSNPCTvcbGZQAwLQuwSvExe6meeWwJKuDMkoTCFGTO7stf
         1RBQN6827hhxMk99+pO9l3DWr1v28yrMV7CJuH95BI+EWflUrQXfizjaeZGSQ6JwFPcZ
         F7ow==
X-Gm-Message-State: AOJu0YwxXlTnKUFpcuJeoeVzqK56QDbdyFdfuzk3xWoSTKZMs8j+o992
	745xoaM5GrlWLmKtOdvmO/KygqfGtASspXpbMoXp+Zi2aMzH6xN4gOulLqJtqNQEWdlws6LWQWc
	z
X-Google-Smtp-Source: AGHT+IHIMa+NJprsNga2EQFhh2GEBRrFs7Bf9qxH0p+YeKoWc6h6oDjPZ12SbaUtGgm8rsI4e01N6g==
X-Received: by 2002:a05:600c:45cb:b0:42f:8515:e490 with SMTP id 5b1f17b1804b1-431841341e2mr16728575e9.5.1729677590873;
        Wed, 23 Oct 2024 02:59:50 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 01/28] toaster/test/functional: Move _create_test_new_project to base class as helper
Date: Wed, 23 Oct 2024 10:59:22 +0100
Message-ID: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 09:59:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16692

The test project creation is needed by mutliple tests. Move it to the
base class as a helper function for reuse.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/functional_helpers.py    | 72 +++++++++++++++++++
 .../functional/test_create_new_project.py     | 69 ------------------
 2 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
index 7c20437d14..d3e38b658b 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -12,9 +12,12 @@ import logging
 import subprocess
 import signal
 import re
+import requests
 
+from django.urls import reverse
 from tests.browser.selenium_helpers_base import SeleniumTestCaseBase
 from selenium.webdriver.common.by import By
+from selenium.webdriver.support.select import Select
 from selenium.common.exceptions import NoSuchElementException
 
 logger = logging.getLogger("toaster")
@@ -136,3 +139,72 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
         except NoSuchElementException:
             return False
         return element
+
+    def _create_test_new_project(
+        self,
+        project_name,
+        release,
+        release_title,
+        merge_toaster_settings,
+    ):
+        """ Create/Test new project using:
+          - Project Name: Any string
+          - Release: Any string
+          - Merge Toaster settings: True or False
+        """
+
+        # Obtain a CSRF token from a suitable URL
+        projs = requests.get(self.live_server_url + reverse('newproject'))
+        csrftoken = projs.cookies.get('csrftoken')
+
+        # Use the projects typeahead to find out if the project already exists
+        req = requests.get(self.live_server_url + reverse('xhr_projectstypeahead'), {'search': project_name, 'format' : 'json'})
+        data = req.json()
+        # Delete any existing projects
+        for result in data['results']:
+            del_url = reverse('xhr_project', args=(result['id'],))
+            del_response = requests.delete(self.live_server_url + del_url, cookies={'csrftoken': csrftoken}, headers={'X-CSRFToken': csrftoken})
+            self.assertEqual(del_response.status_code, 200)
+
+        self.get(reverse('newproject'))
+        self.wait_until_visible('#new-project-name', poll=3)
+        self.driver.find_element(By.ID,
+                                 "new-project-name").send_keys(project_name)
+
+        select = Select(self.find('#projectversion'))
+        select.select_by_value(release)
+
+        # check merge toaster settings
+        checkbox = self.find('.checkbox-mergeattr')
+        if merge_toaster_settings:
+            if not checkbox.is_selected():
+                checkbox.click()
+        else:
+            if checkbox.is_selected():
+                checkbox.click()
+
+        self.driver.find_element(By.ID, "create-project-button").click()
+
+        element = self.wait_until_visible('#project-created-notification', poll=3)
+        self.assertTrue(
+            self.element_exists('#project-created-notification'),
+            f"Project:{project_name} creation notification not shown"
+        )
+        self.assertTrue(
+            project_name in element.text,
+            f"New project name:{project_name} not in new project notification"
+        )
+
+        # Use the projects typeahead again to check the project now exists
+        req = requests.get(self.live_server_url + reverse('xhr_projectstypeahead'), {'search': project_name, 'format' : 'json'})
+        data = req.json()
+        self.assertGreater(len(data['results']), 0, f"New project:{project_name} not found in database")
+
+        # check release
+        self.assertTrue(re.search(
+            release_title,
+            self.driver.find_element(By.XPATH,
+                                     "//span[@id='project-release-title']"
+                                     ).text),
+                        'The project release is not defined')
+
diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index 577ca7239d..168a396717 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -8,7 +8,6 @@
 
 import re
 import pytest
-import requests
 from django.urls import reverse
 from selenium.webdriver.support.select import Select
 from tests.functional.functional_helpers import SeleniumFunctionalTestCase
@@ -16,74 +15,6 @@ from selenium.webdriver.common.by import By
 
 class TestCreateNewProject(SeleniumFunctionalTestCase):
 
-    def _create_test_new_project(
-        self,
-        project_name,
-        release,
-        release_title,
-        merge_toaster_settings,
-    ):
-        """ Create/Test new project using:
-          - Project Name: Any string
-          - Release: Any string
-          - Merge Toaster settings: True or False
-        """
-
-        # Obtain a CSRF token from a suitable URL
-        projs = requests.get(self.live_server_url + reverse('newproject'))
-        csrftoken = projs.cookies.get('csrftoken')
-
-        # Use the projects typeahead to find out if the project already exists
-        req = requests.get(self.live_server_url + reverse('xhr_projectstypeahead'), {'search': project_name, 'format' : 'json'})
-        data = req.json()
-        # Delete any existing projects
-        for result in data['results']:
-            del_url = reverse('xhr_project', args=(result['id'],))
-            del_response = requests.delete(self.live_server_url + del_url, cookies={'csrftoken': csrftoken}, headers={'X-CSRFToken': csrftoken})
-            self.assertEqual(del_response.status_code, 200)
-
-        self.get(reverse('newproject'))
-        self.wait_until_visible('#new-project-name', poll=3)
-        self.driver.find_element(By.ID,
-                                 "new-project-name").send_keys(project_name)
-
-        select = Select(self.find('#projectversion'))
-        select.select_by_value(release)
-
-        # check merge toaster settings
-        checkbox = self.find('.checkbox-mergeattr')
-        if merge_toaster_settings:
-            if not checkbox.is_selected():
-                checkbox.click()
-        else:
-            if checkbox.is_selected():
-                checkbox.click()
-
-        self.driver.find_element(By.ID, "create-project-button").click()
-
-        element = self.wait_until_visible('#project-created-notification', poll=3)
-        self.assertTrue(
-            self.element_exists('#project-created-notification'),
-            f"Project:{project_name} creation notification not shown"
-        )
-        self.assertTrue(
-            project_name in element.text,
-            f"New project name:{project_name} not in new project notification"
-        )
-
-        # Use the projects typeahead again to check the project now exists
-        req = requests.get(self.live_server_url + reverse('xhr_projectstypeahead'), {'search': project_name, 'format' : 'json'})
-        data = req.json()
-        self.assertGreater(len(data['results']), 0, f"New project:{project_name} not found in database")
-
-        # check release
-        self.assertTrue(re.search(
-            release_title,
-            self.driver.find_element(By.XPATH,
-                                     "//span[@id='project-release-title']"
-                                     ).text),
-                        'The project release is not defined')
-
     def test_create_new_project_master(self):
         """ Test create new project using:
           - Project Name: Any string

