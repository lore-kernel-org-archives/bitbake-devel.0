Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE024CDDE4B
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.5146.1729677605863828368
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G8Vprya6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so4784855f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677604; x=1730282404; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+855hAK9fRr4KCPn6ttUepqUDXIDDP+C8pwp/LiuBc=;
        b=G8Vprya6zBLChrB0a/vPtRK/lFrxeWrZp0X14rW2PzHLmv+6jLDo+xn5xAvftSRDv0
         slZSZIdhm5l6OHdHHgRIhezJu2nGqycrNAKYTuNVdJf0PWw9bodDE0JLJCGjecHArpUP
         K5oByfz6u4TYqTVFAV6C578fHMI2qiiHa1Vwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677604; x=1730282404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+855hAK9fRr4KCPn6ttUepqUDXIDDP+C8pwp/LiuBc=;
        b=Xt1pKD1R2SktudrFbMau8WObmiLjSnRhMrecYTuRr5vV2OYc4iZOK1ifWx8ZWmuvtx
         hfMYhxPBWmQrDO1LpWm5H+TlS4PU/n7R5aGqwwwHpyLYzS7TonWHWoDRprNnaSh1RBKG
         MyPFV8x6JtSxgj9Vo+CgWoMbt34o0LpbxX2xXbY2pNiyOUJc3CgINlQYMnnW0buq8sT8
         OqmL7a0gKC6dJhsJO6vviPiq5DBep158ZVC2AU/A29foHS3Q7TdqLv+1LtgMaWoP6H3Z
         RjnwNYGxMz4yG1RnWxW58M0Q04l2/KuD7lDmSIjHvSMJNNNuIqTM0cSjnAfV4fwNFygg
         rZ6Q==
X-Gm-Message-State: AOJu0YxxLNxMHbD62YS7b02DfuXvny2sAOuH1xUkr9uCtjNP1NKYKCSa
	NpmgWdVqni4Tg7eL6kol7GvynlMVFFG0ldSHDruHR5mAl0PoTkMVTaCjHTdLAID7tiibftdT/JW
	o
X-Google-Smtp-Source: AGHT+IGIocagPUKRibgSmzdMuE7Dct71QgMjCpVsJypa4C/Q6BIVV+Nampy53gHkn0bYvCHuGT47WQ==
X-Received: by 2002:a5d:694f:0:b0:374:b6f3:728d with SMTP id ffacd0b85a97d-37efcf84c95mr1320984f8f.46.1729677603695;
        Wed, 23 Oct 2024 03:00:03 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 12/28] toaster/tests/functiona/project_page: Switch to using library create_project function
Date: Wed, 23 Oct 2024 10:59:33 +0100
Message-ID: <20241023095949.3351980-12-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16703

Switch this test module to use the common project creation code which contains
race fixes. That code requires the database access wrapper be dropped and
we no longer have ordering constraints.

There are two tests that do require database access. Move these to a separate class
and allow database access there. Use ordering constraints to allow them to run
after the main code. They depend on the project creation from the other class which
isn't ideal but good enough for now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_project_page.py     | 118 +++++++-----------
 1 file changed, 42 insertions(+), 76 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index 5d10513d9d..40ef5f486a 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -7,7 +7,6 @@
 #
 
 import os
-import random
 import string
 from unittest import skip
 import pytest
@@ -22,58 +21,17 @@ from selenium.webdriver.common.by import By
 
 from .utils import get_projectId_from_url, wait_until_build, wait_until_build_cancelled
 
-
-@pytest.mark.django_db
-@pytest.mark.order("last")
-class TestProjectPage(SeleniumFunctionalTestCase):
+class TestProjectPageBase(SeleniumFunctionalTestCase):
     project_id = None
     PROJECT_NAME = 'TestProjectPage'
 
-    def _create_project(self, project_name):
-        """ Create/Test new project using:
-          - Project Name: Any string
-          - Release: Any string
-          - Merge Toaster settings: True or False
-        """
-        self.get(reverse('newproject'))
-        self.wait_until_visible('#new-project-name')
-        self.find("#new-project-name").send_keys(project_name)
-        select = Select(self.find("#projectversion"))
-        select.select_by_value('3')
-
-        # check merge toaster settings
-        checkbox = self.find('.checkbox-mergeattr')
-        if not checkbox.is_selected():
-            checkbox.click()
-
-        if self.PROJECT_NAME != 'TestProjectPage':
-            # Reset project name if it's not the default one
-            self.PROJECT_NAME = 'TestProjectPage'
-
-        self.find("#create-project-button").click()
-
-        try:
-            self.wait_until_visible('#hint-error-project-name')
-            url = reverse('project', args=(TestProjectPage.project_id, ))
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
-        if TestProjectPage.project_id is None:
-            self._create_project(project_name=self._random_string(10))
-            current_url = self.driver.current_url
-            TestProjectPage.project_id = get_projectId_from_url(current_url)
-        else:
-            url = reverse('project', args=(TestProjectPage.project_id,))
-            self.get(url)
+        if TestProjectPageBase.project_id is None:
+            TestProjectPageBase.project_id = self.create_new_project(self.PROJECT_NAME, '3', None, True)
+
+        url = reverse('project', args=(TestProjectPageBase.project_id,))
+        self.get(url)
         self.wait_until_visible('#config-nav')
 
     def _get_create_builds(self, **kwargs):
@@ -81,14 +39,14 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         # parameters for builds to associate with the projects
         now = timezone.now()
         self.project1_build_success = {
-            'project': Project.objects.get(id=TestProjectPage.project_id),
+            'project': Project.objects.get(id=TestProjectPageBase.project_id),
             'started_on': now,
             'completed_on': now,
             'outcome': Build.SUCCEEDED
         }
 
         self.project1_build_failure = {
-            'project': Project.objects.get(id=TestProjectPage.project_id),
+            'project': Project.objects.get(id=TestProjectPageBase.project_id),
             'started_on': now,
             'completed_on': now,
             'outcome': Build.FAILED
@@ -222,6 +180,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         rows = self.find_all(f'#{table_selector} tbody tr')
         self.assertTrue(len(rows) > 0)
 
+class TestProjectPage(TestProjectPageBase):
+
     def test_create_project(self):
         """ Create/Test new project using:
           - Project Name: Any string
@@ -230,26 +190,6 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         """
         self._create_project(project_name=self.PROJECT_NAME)
 
-    def test_image_recipe_editColumn(self):
-        """ Test the edit column feature in image recipe table on project page """
-        self._get_create_builds(success=10, failure=10)
-
-        url = reverse('projectimagerecipes', args=(TestProjectPage.project_id,))
-        self.get(url)
-        self.wait_until_present('#imagerecipestable tbody tr')
-
-        column_list = [
-            'get_description_or_summary', 'layer_version__get_vcs_reference',
-            'layer_version__layer__name', 'license', 'recipe-file', 'section',
-            'version'
-        ]
-
-        # Check that we can hide the edit column
-        self._mixin_test_table_edit_column(
-            'imagerecipestable',
-            'edit-columns-button',
-            [f'checkbox-{column}' for column in column_list]
-        )
 
     def test_page_header_on_project_page(self):
         """ Check page header in project page:
@@ -379,7 +319,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertEqual(config_tab.get_attribute('class'), 'active')
         self.assertIn('Configuration', str(config_tab.text))
         self.assertIn(
-            f"/toastergui/project/{TestProjectPage.project_id}", str(self.driver.current_url)
+            f"/toastergui/project/{TestProjectPageBase.project_id}", str(self.driver.current_url)
         )
 
         def get_tabs():
@@ -402,7 +342,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         check_tab_link(
             1,
             'Builds',
-            f"/toastergui/project/{TestProjectPage.project_id}/builds"
+            f"/toastergui/project/{TestProjectPageBase.project_id}/builds"
         )
 
         # check "Import layers" tab
@@ -411,7 +351,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         check_tab_link(
             2,
             'Import layer',
-            f"/toastergui/project/{TestProjectPage.project_id}/importlayer"
+            f"/toastergui/project/{TestProjectPageBase.project_id}/importlayer"
         )
 
         # check "New custom image" tab
@@ -420,7 +360,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         check_tab_link(
             3,
             'New custom image',
-            f"/toastergui/project/{TestProjectPage.project_id}/newcustomimage"
+            f"/toastergui/project/{TestProjectPageBase.project_id}/newcustomimage"
         )
 
         # check search box can be use to build recipes
@@ -766,6 +706,10 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         # Check layer description
         self.assertIn("Description", section.text)
 
+@pytest.mark.django_db
+@pytest.mark.order("last")
+class TestProjectPageRecipes(TestProjectPageBase):
+
     def test_single_recipe_page(self):
         """ Test recipe page
             - Check if title is displayed
@@ -777,9 +721,9 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         # Use a recipe which is likely to exist in the layer index but not enabled
         # in poky out the box - xen-image-minimal from meta-virtualization
         self._navigate_to_project_page()
-        prj = Project.objects.get(pk=TestProjectPage.project_id)
+        prj = Project.objects.get(pk=TestProjectPageBase.project_id)
         recipe_id = prj.get_all_compatible_recipes().get(name="xen-image-minimal").pk
-        url = reverse("recipedetails", args=(TestProjectPage.project_id, recipe_id))
+        url = reverse("recipedetails", args=(TestProjectPageBase.project_id, recipe_id))
         self.get(url)
         self.wait_until_visible('.page-header')
         # check title is displayed
@@ -802,3 +746,25 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertIn("Approx. packages included", section.text)
         self.assertIn("Approx. package size", section.text)
         self.assertIn("Recipe file", section.text)
+
+    def test_image_recipe_editColumn(self):
+        """ Test the edit column feature in image recipe table on project page """
+        self._get_create_builds(success=10, failure=10)
+
+        url = reverse('projectimagerecipes', args=(TestProjectPageBase.project_id,))
+        self.get(url)
+        self.wait_until_present('#imagerecipestable tbody tr')
+
+        column_list = [
+            'get_description_or_summary', 'layer_version__get_vcs_reference',
+            'layer_version__layer__name', 'license', 'recipe-file', 'section',
+            'version'
+        ]
+
+        # Check that we can hide the edit column
+        self._mixin_test_table_edit_column(
+            'imagerecipestable',
+            'edit-columns-button',
+            [f'checkbox-{column}' for column in column_list]
+        )
+

