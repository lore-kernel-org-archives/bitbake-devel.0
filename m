Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0844CDDE40
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.5147.1729677600594665726
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AOUGyQlU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314a26002bso72856795e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677599; x=1730282399; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFGIN9R8u/3oSpdsb4RenPPPK9+HW3v6VQeYXJI+Mgs=;
        b=AOUGyQlU14mNDaCXfptcbnzprL6z8OVGdcmbbfVHKSsS9VvNk0/6mFd1tdHSRBIb8D
         LPUf6iHFPD3htF+3LgfONCvpAz1YYCWdo4L0+JzvGnpt9JbtxjGurLRWpiRBEKlmHZ+R
         1lQVQIq4PGDkUmClUjApEtfbKC77HmfmOYDRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677599; x=1730282399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFGIN9R8u/3oSpdsb4RenPPPK9+HW3v6VQeYXJI+Mgs=;
        b=oBD00Sk/+6Khl3gmdr5lNmUvG8XcstO05dAOSXm11h8BAZ7NJugjh1dmUf8A6LnOYs
         zworydRSze1Q/UGPtzubXRmMA6y5vssX1+HpkknsVjdetuMo9CQRGjRry57yPiQr6Xno
         xXFG6ZdoVJy0AZklGKz2+7pKlM/QGqQGtMzze9/abZtNm0SrJuYc/qsrWK+nOGOBVl/M
         AJvS/1VKFIstQcd4zUnFdtxGOgRrwwZSUXcQ2idxc6cDkVYi0ml+CTGymgJKq56qsKEJ
         bEslzheM7VfQii3C6ja84wy81CbbBvjpqrdXulMYGXsCwSaYpUz2FlEpmVrqTh4OH0dA
         8ncg==
X-Gm-Message-State: AOJu0YxVURrOmfj1Fi7x4TY1ktDk+VImXudrYW+6rxzqRZMnHJQnOMRE
	Cd9ztWFdYhySl91KOBOddRKqOn7SXg8WzfzdB5TumTo87jnBh0eyvU5lBid9eUzHjlmwq6e5r4+
	W
X-Google-Smtp-Source: AGHT+IGOVyw9Wrk5T+OAufhrzUeo+xEFGGuV85WSVyz6/3/wWl9Y/vTDocOpqyyAVHddxRbrq20nLg==
X-Received: by 2002:a05:600c:45c3:b0:431:7ca6:57b1 with SMTP id 5b1f17b1804b1-431841a3bdamr19992895e9.32.1729677598682;
        Wed, 23 Oct 2024 02:59:58 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 08/28] toaster/tests/browser: Drop unneeded poll parameters
Date: Wed, 23 Oct 2024 10:59:29 +0100
Message-ID: <20241023095949.3351980-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16699

In my testing I wasn't able to see issues needing the poll parameter in the
browser tests. Drop those.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/test_all_builds_page.py    |  6 +++---
 lib/toaster/tests/browser/test_all_projects_page.py  | 12 ++++++------
 .../tests/browser/test_builddashboard_page.py        |  2 +-
 lib/toaster/tests/browser/test_landing_page.py       |  2 +-
 lib/toaster/tests/browser/test_layerdetails_page.py  |  8 ++++----
 .../tests/browser/test_new_custom_image_page.py      |  2 +-
 lib/toaster/tests/browser/test_new_project_page.py   |  8 ++++----
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toaster/tests/browser/test_all_builds_page.py
index b9356a0344..a1f8057113 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -224,7 +224,7 @@ class TestAllBuildsPage(SeleniumTestCase):
 
         url = reverse('all-builds')
         self.get(url)
-        self.wait_until_visible('#allbuildstable', poll=3)
+        self.wait_until_visible('#allbuildstable')
 
         # get the project name cells from the table
         cells = self.find_all('#allbuildstable td[class="project"]')
@@ -257,7 +257,7 @@ class TestAllBuildsPage(SeleniumTestCase):
 
         url = reverse('all-builds')
         self.get(url)
-        self.wait_until_visible('#allbuildstable', poll=3)
+        self.wait_until_visible('#allbuildstable')
 
         # test recent builds area for successful build
         element = self._get_build_time_element(build1)
@@ -452,7 +452,7 @@ class TestAllBuildsPage(SeleniumTestCase):
         def test_show_rows(row_to_show, show_row_link):
             # Check that we can show rows == row_to_show
             show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_visible('#allbuildstable tbody tr', poll=3)
+            self.wait_until_visible('#allbuildstable tbody tr')
             # check at least some rows are visible
             self.assertTrue(
                 len(self.find_all('#allbuildstable tbody tr')) > 0
diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/toaster/tests/browser/test_all_projects_page.py
index 9ed1901cc9..05e12892be 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -81,7 +81,7 @@ class TestAllProjectsPage(SeleniumTestCase):
 
     def _get_row_for_project(self, project_name):
         """ Get the HTML row for a project, or None if not found """
-        self.wait_until_visible('#projectstable tbody tr', poll=3)
+        self.wait_until_visible('#projectstable tbody tr')
         rows = self.find_all('#projectstable tbody tr')
 
         # find the row with a project name matching the one supplied
@@ -236,7 +236,7 @@ class TestAllProjectsPage(SeleniumTestCase):
         self.get(url)
 
         # Chseck search box is present and works
-        self.wait_until_visible('#projectstable tbody tr', poll=3)
+        self.wait_until_visible('#projectstable tbody tr')
         search_box = self.find('#search-input-projectstable')
         self.assertTrue(search_box.is_displayed())
 
@@ -244,7 +244,7 @@ class TestAllProjectsPage(SeleniumTestCase):
         search_box.send_keys('test project 10')
         search_btn = self.find('#search-submit-projectstable')
         search_btn.click()
-        self.wait_until_visible('#projectstable tbody tr', poll=3)
+        self.wait_until_visible('#projectstable tbody tr')
         rows = self.find_all('#projectstable tbody tr')
         self.assertTrue(len(rows) == 1)
 
@@ -290,7 +290,7 @@ class TestAllProjectsPage(SeleniumTestCase):
                 )
         url = reverse('all-projects')
         self.get(url)
-        self.wait_until_visible('#projectstable tbody tr', poll=3)
+        self.wait_until_visible('#projectstable tbody tr')
 
         # Check edit column
         edit_column = self.find('#edit-columns-button')
@@ -313,7 +313,7 @@ class TestAllProjectsPage(SeleniumTestCase):
         def test_show_rows(row_to_show, show_row_link):
             # Check that we can show rows == row_to_show
             show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_visible('#projectstable tbody tr', poll=3)
+            self.wait_until_visible('#projectstable tbody tr')
             # check at least some rows are visible
             self.assertTrue(
                 len(self.find_all('#projectstable tbody tr')) > 0
@@ -321,7 +321,7 @@ class TestAllProjectsPage(SeleniumTestCase):
 
         url = reverse('all-projects')
         self.get(url)
-        self.wait_until_visible('#projectstable tbody tr', poll=3)
+        self.wait_until_visible('#projectstable tbody tr')
 
         show_rows = self.driver.find_elements(
             By.XPATH,
diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/toaster/tests/browser/test_builddashboard_page.py
index d838ce363a..82367108e2 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -162,7 +162,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
         """
         url = reverse('builddashboard', args=(build.id,))
         self.get(url)
-        self.wait_until_visible('#global-nav', poll=3)
+        self.wait_until_visible('#global-nav')
 
     def _get_build_dashboard_errors(self, build):
         """
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
index 62fdf83c91..f3300430ba 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -224,7 +224,7 @@ class TestLandingPage(SeleniumTestCase):
 
         self.get(reverse('landing'))
 
-        self.wait_until_visible("#latest-builds", poll=3)
+        self.wait_until_visible("#latest-builds")
         elements = self.find_all('#allbuildstable')
         self.assertEqual(len(elements), 1, 'should redirect to builds')
         content = self.get_page_source()
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index 5c29548b78..c4f3f79d34 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -108,9 +108,9 @@ class TestLayerDetailsPage(SeleniumTestCase):
             save_btn.click()
 
         try:
-            self.wait_until_visible("#save-changes-for-switch", poll=3)
+            self.wait_until_visible("#save-changes-for-switch")
             btn_save_chg_for_switch = self.wait_until_clickable(
-                "#save-changes-for-switch", poll=3)
+                "#save-changes-for-switch")
             btn_save_chg_for_switch.click()
         except ElementClickInterceptedException:
             self.skipTest(
@@ -148,9 +148,9 @@ class TestLayerDetailsPage(SeleniumTestCase):
         dir_input.send_keys(new_dir)
 
         try:
-            self.wait_until_visible("#save-changes-for-switch", poll=3)
+            self.wait_until_visible("#save-changes-for-switch")
             btn_save_chg_for_switch = self.wait_until_clickable(
-                "#save-changes-for-switch", poll=3)
+                "#save-changes-for-switch")
             btn_save_chg_for_switch.click()
         except ElementClickInterceptedException:
             self.skipTest(
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/lib/toaster/tests/browser/test_new_custom_image_page.py
index 9f0b6397fe..bf0304dbec 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -90,7 +90,7 @@ class TestNewCustomImagePage(SeleniumTestCase):
         """
         url = reverse('newcustomimage', args=(self.project.id,))
         self.get(url)
-        self.wait_until_visible('#global-nav', poll=3)
+        self.wait_until_visible('#global-nav')
 
         self.click('button[data-recipe="%s"]' % self.recipe.id)
 
diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toaster/tests/browser/test_new_project_page.py
index 458bb6538d..b6187db105 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -47,7 +47,7 @@ class TestNewProjectPage(SeleniumTestCase):
 
         url = reverse('newproject')
         self.get(url)
-        self.wait_until_visible('#new-project-name', poll=3)
+        self.wait_until_visible('#new-project-name')
         self.enter_text('#new-project-name', project_name)
 
         select = Select(self.find('#projectversion'))
@@ -58,7 +58,7 @@ class TestNewProjectPage(SeleniumTestCase):
         # We should get redirected to the new project's page with the
         # notification at the top
         element = self.wait_until_visible(
-            '#project-created-notification', poll=3)
+            '#project-created-notification')
 
         self.assertTrue(project_name in element.text,
                         "New project name not in new project notification")
@@ -79,7 +79,7 @@ class TestNewProjectPage(SeleniumTestCase):
 
         url = reverse('newproject')
         self.get(url)
-        self.wait_until_visible('#new-project-name', poll=3)
+        self.wait_until_visible('#new-project-name')
 
         self.enter_text('#new-project-name', project_name)
 
@@ -91,7 +91,7 @@ class TestNewProjectPage(SeleniumTestCase):
 
         self.click("#create-project-button")
 
-        self.wait_until_present('#hint-error-project-name', poll=3)
+        self.wait_until_present('#hint-error-project-name')
         element = self.find('#hint-error-project-name')
 
         self.assertTrue(("Project names must be unique" in element.text),

