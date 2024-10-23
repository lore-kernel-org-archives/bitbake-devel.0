Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95753D1712C
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 09:59:59 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.5141.1729677594272328114
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 02:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ctvuF5w2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315baec69eso62161595e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677592; x=1730282392; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBJ9yjGoQOzU/sVLOJfAHgJN/JZtHxnMi8UgM3Aj24w=;
        b=ctvuF5w2jzGyCiDXrX0Ix33l8Wed7d2m3rlWC+sUs+iW0VgNEzlA1LvIfav3AOD0HX
         LhyZc50jx2TmU7ur8cKTXBd3wrNKGisDqnIqsMy9cF69NGsfrjOYMJz3xVKyZyn4p4cD
         /XDKyJNGUXhNizrDkV0F/aAPPTdEwNreT2yqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677592; x=1730282392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBJ9yjGoQOzU/sVLOJfAHgJN/JZtHxnMi8UgM3Aj24w=;
        b=GMjbdrQhQKOaDRajvv34qkTWNKSkasXL8sYIe0vymW9sPoJOHHIVhUAfbCtkOjsiMd
         SSSRJzAOOVH19Gv7W3FP0yxah9dQhnT31jC4LIfObht99R1xntd8txucX2BTAF3ruJBV
         WDawAnDp7iQLS28gTxNyvcKvoa/bvcr1t3WeEhZTQ7wf/ov85P8hd3dZaOB5SrlO9xU5
         MfeB5yAQN8XnKdfBqJqD33SJG7FNwmy5GHi1gyJGlvKCs93mNB1pvH80RKPsB6RzFXRI
         Ko+whEH1lbA/+Zlv5jHkFn/pQbulHlj5Yaz3NJIVmPF1eklqfvmsG+jaTSNVu72HhOZP
         TnuQ==
X-Gm-Message-State: AOJu0YwPUJPunSxsYojR0/S5lKkvP7LAqBVK2T937fuLqQWR4ynu674R
	Ru6QrkVAfWAudQNM8bQLXf23yM+3HSXI4NciezUZ5ApcwxnYcbafx7HenlmjSmsRMzXilu3dE2R
	O
X-Google-Smtp-Source: AGHT+IFmQgjda+tOQoFQyDi4zJMc7mAKjyp8dUTkWb7Ip5+HBr+RhxYbWJIEyF93vkU/Kjf3ll3dUQ==
X-Received: by 2002:a05:600c:3496:b0:431:4b88:d408 with SMTP id 5b1f17b1804b1-431841ee388mr16819195e9.5.1729677592274;
        Wed, 23 Oct 2024 02:59:52 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 02/28] toaster/tests/functional: Tweak the project creation function for better reuse
Date: Wed, 23 Oct 2024 10:59:23 +0100
Message-ID: <20241023095949.3351980-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 09:59:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16693

Tweak the function name and return the created project ID.

Allow the release_name test to be skipped with a value of None.

Add an extra wait call to ensure the create project button is ready
before clicking it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/functional_helpers.py     | 18 +++++++++++++-----
 .../functional/test_create_new_project.py      |  8 ++++----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
index d3e38b658b..cc508e98d9 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -140,7 +140,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
             return False
         return element
 
-    def _create_test_new_project(
+    def create_new_project(
         self,
         project_name,
         release,
@@ -183,6 +183,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
             if checkbox.is_selected():
                 checkbox.click()
 
+        self.wait_until_clickable('#create-project-button')
+
         self.driver.find_element(By.ID, "create-project-button").click()
 
         element = self.wait_until_visible('#project-created-notification', poll=3)
@@ -200,11 +202,17 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
         data = req.json()
         self.assertGreater(len(data['results']), 0, f"New project:{project_name} not found in database")
 
+        project_id = data['results'][0]['id']
+
+        self.wait_until_visible('#project-release-title')
+
         # check release
-        self.assertTrue(re.search(
-            release_title,
-            self.driver.find_element(By.XPATH,
+        if release_title is not None:
+            self.assertTrue(re.search(
+                release_title,
+                self.driver.find_element(By.XPATH,
                                      "//span[@id='project-release-title']"
                                      ).text),
-                        'The project release is not defined')
+                            'The project release is not defined')
 
+        return project_id
diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index 168a396717..342e008f55 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -24,7 +24,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
         release = '3'
         release_title = 'Yocto Project master'
         project_name = 'projectmaster'
-        self._create_test_new_project(
+        self.create_new_project(
             project_name,
             release,
             release_title,
@@ -40,7 +40,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
         release = '1'
         release_title = 'Yocto Project 5.0 "Scarthgap"'
         project_name = 'projectscarthgap'
-        self._create_test_new_project(
+        self.create_new_project(
             project_name,
             release,
             release_title,
@@ -56,7 +56,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
         release = '5'
         release_title = 'Yocto Project 4.0 "Kirkstone"'
         project_name = 'projectkirkstone'
-        self._create_test_new_project(
+        self.create_new_project(
             project_name,
             release,
             release_title,
@@ -72,7 +72,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
         release = '2'
         release_title = 'Local Yocto Project'
         project_name = 'projectlocal'
-        self._create_test_new_project(
+        self.create_new_project(
             project_name,
             release,
             release_title,

