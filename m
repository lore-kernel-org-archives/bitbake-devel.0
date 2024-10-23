Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4FBCDDE49
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.5141.1729677604183341408
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YiABFCeD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so4619754f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677602; x=1730282402; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBcJjJxtGAeG5XTX0gIQ8MFz+gZtuRpeHhXT0hG3RNQ=;
        b=YiABFCeDGam5QPwL4kPOQIUrTRyeiUMOVB/dfPJNzf+oy1MonF8nUKiOiJPLhxzMaZ
         9xj7KQ+grY42OxhVTiR7FJC11PCoFo5EwsBiti0p/DLguI1UXZ1ewHQEraaDnVI3abvu
         cfByOBeGtpaaU/6GOK25Z1BWb9oFAVNo56K6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677602; x=1730282402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBcJjJxtGAeG5XTX0gIQ8MFz+gZtuRpeHhXT0hG3RNQ=;
        b=rjRs8h+8OBiTAOFw4sX+P1tiKtbQTnw6yYIVE1iFq7MFsiPYhOj4AvkrNp0yEkaw82
         6bTbELA7lCFQuxzOuZj1llyeZgE1Lm6y5D40Xj1T2oFMvaDl2ZNv6W7Ro1V9oGcFGLgn
         jUzeWrPPOBnLUI+f+MApG+XfM69annvfsibJlCfbEqoGeumtm6ZhWWYsgosQY3g9Xkcf
         wv5t66d6ji7NNgK9INFZwI9S+YYQcXn5YNxiQF0QDPttLrq/pIXoBz8pvg3pNsMNUsrS
         MGsJULXpbop8dyP3bfcDNZmI2wK8XE/l9lLoIWDHSgI2LvgeDeXGd+PbfW2kOXaYAjea
         94Jw==
X-Gm-Message-State: AOJu0YynTLJOI66WHbrDejkjGj+bXcitc0eD3sTyRTrBZQIBItwR4G2R
	fpnYX86iqU5RadnVTUrY3oamM9UXBybORozMuyYSaKOPpFlhge0DrFBbn90IW/vtEofCXqdgHMM
	l
X-Google-Smtp-Source: AGHT+IFKAyiHWl0zQ0i7yxtPmt/u0DiEO6mpUQi97Zfyc16vqPrMSF9qmQIxYzK8BluC+j7o3hilQQ==
X-Received: by 2002:adf:eb06:0:b0:374:c84d:1cfe with SMTP id ffacd0b85a97d-37efcf06b6bmr1164632f8f.21.1729677602322;
        Wed, 23 Oct 2024 03:00:02 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 11/28] toaster/tests/functional/project_config: Fix the wait calls to avoid polling
Date: Wed, 23 Oct 2024 10:59:32 +0100
Message-ID: <20241023095949.3351980-11-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16702

Drop poll calls within the module, adding wait calls for elements of the
page where testing showed it was needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_project_config.py   | 47 +++++++++----------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_config.py b/lib/toaster/tests/functional/test_project_config.py
index 41149e5e55..fcb1bc3284 100644
--- a/lib/toaster/tests/functional/test_project_config.py
+++ b/lib/toaster/tests/functional/test_project_config.py
@@ -36,10 +36,10 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
 
         url = reverse('projectconf', args=(TestProjectConfig.project_id,))
         self.get(url)
-        self.wait_until_visible('#config-nav', poll=3)
+        self.wait_until_visible('#config-nav')
         bbv_page_link = self._get_config_nav_item(9)
         bbv_page_link.click()
-        self.wait_until_visible('#config-nav', poll=3)
+        self.wait_until_visible('#config-nav')
 
     def test_no_underscore_iamgefs_type(self):
         """
@@ -48,13 +48,13 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
         self._navigate_bbv_page()
         imagefs_type = "foo_bar"
 
-        self.wait_until_visible('#change-image_fstypes-icon', poll=2)
+        self.wait_until_visible('#change-image_fstypes-icon')
 
         self.click('#change-image_fstypes-icon')
 
         self.enter_text('#new-imagefs_types', imagefs_type)
 
-        element = self.wait_until_visible('#hintError-image-fs_type', poll=2)
+        element = self.wait_until_visible('#hintError-image-fs_type')
 
         self.assertTrue(("A valid image type cannot include underscores" in element.text),
                         "Did not find underscore error message")
@@ -68,7 +68,7 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
 
         imagefs_type = "btrfs"
 
-        self.wait_until_visible('#change-image_fstypes-icon', poll=2)
+        self.wait_until_visible('#change-image_fstypes-icon')
 
         self.click('#change-image_fstypes-icon')
 
@@ -87,22 +87,20 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
         """
         self._navigate_bbv_page()
 
-        self.wait_until_visible('#change-image_fstypes-icon', poll=2)
-
+        self.wait_until_visible('#change-image_fstypes-icon')
         self.click('#change-image_fstypes-icon')
 
         checkboxes_selector = '.fs-checkbox-fstypes'
 
-        self.wait_until_visible(checkboxes_selector, poll=2)
+        self.wait_until_visible(checkboxes_selector)
         checkboxes = self.find_all(checkboxes_selector)
 
         for checkbox in checkboxes:
             if checkbox.get_attribute("value") == "cpio":
                checkbox.click()
+               self.wait_until_visible('#new-imagefs_types')
                element = self.driver.find_element(By.ID, 'new-imagefs_types')
 
-               self.wait_until_visible('#new-imagefs_types', poll=2)
-
                self.assertTrue(("cpio" in element.get_attribute('value'),
                                "Imagefs not added into the textbox"))
                checkbox.click()
@@ -118,20 +116,19 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
 
         # activate the input to edit download dir
         try:
-            change_dl_dir_btn = self.wait_until_visible('#change-dl_dir-icon', poll=2)
+            change_dl_dir_btn = self.wait_until_visible('#change-dl_dir-icon')
         except TimeoutException:
             # If download dir is not displayed, test is skipped
             change_dl_dir_btn = None
 
         if change_dl_dir_btn:
-            change_dl_dir_btn = self.wait_until_visible('#change-dl_dir-icon', poll=2)
             change_dl_dir_btn.click()
 
             # downloads dir path doesn't start with / or ${...}
-            input_field = self.wait_until_visible('#new-dl_dir', poll=2)
+            input_field = self.wait_until_visible('#new-dl_dir')
             input_field.clear()
             self.enter_text('#new-dl_dir', 'home/foo')
-            element = self.wait_until_visible('#hintError-initialChar-dl_dir', poll=2)
+            element = self.wait_until_visible('#hintError-initialChar-dl_dir')
 
             msg = 'downloads directory path starts with invalid character but ' \
                 'treated as valid'
@@ -141,7 +138,7 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
             self.driver.find_element(By.ID, 'new-dl_dir').clear()
             self.enter_text('#new-dl_dir', '/foo/bar a')
 
-            element = self.wait_until_visible('#hintError-dl_dir', poll=2)
+            element = self.wait_until_visible('#hintError-dl_dir')
             msg = 'downloads directory path characters invalid but treated as valid'
             self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), msg)
 
@@ -149,7 +146,7 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
             self.driver.find_element(By.ID,'new-dl_dir').clear()
             self.enter_text('#new-dl_dir', '${TOPDIR}/down foo')
 
-            element = self.wait_until_visible('#hintError-dl_dir', poll=2)
+            element = self.wait_until_visible('#hintError-dl_dir')
             msg = 'downloads directory path characters invalid but treated as valid'
             self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), msg)
 
@@ -177,10 +174,7 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
         self._navigate_bbv_page()
 
         try:
-            btn_chg_sstate_dir = self.wait_until_visible(
-                '#change-sstate_dir-icon',
-                poll=2
-            )
+            btn_chg_sstate_dir = self.wait_until_visible('#change-sstate_dir-icon')
             self.click('#change-sstate_dir-icon')
         except TimeoutException:
             # If sstate_dir is not displayed, test is skipped
@@ -188,10 +182,10 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
 
         if btn_chg_sstate_dir:  # Skip continuation if sstate_dir is not displayed
             # path doesn't start with / or ${...}
-            input_field = self.wait_until_visible('#new-sstate_dir', poll=2)
+            input_field = self.wait_until_visible('#new-sstate_dir')
             input_field.clear()
             self.enter_text('#new-sstate_dir', 'home/foo')
-            element = self.wait_until_visible('#hintError-initialChar-sstate_dir', poll=2)
+            element = self.wait_until_visible('#hintError-initialChar-sstate_dir')
 
             msg = 'sstate directory path starts with invalid character but ' \
                 'treated as valid'
@@ -201,7 +195,7 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
             self.driver.find_element(By.ID, 'new-sstate_dir').clear()
             self.enter_text('#new-sstate_dir', '/foo/bar a')
 
-            element = self.wait_until_visible('#hintError-sstate_dir', poll=2)
+            element = self.wait_until_visible('#hintError-sstate_dir')
             msg = 'sstate directory path characters invalid but treated as valid'
             self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), msg)
 
@@ -209,7 +203,7 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
             self.driver.find_element(By.ID,'new-sstate_dir').clear()
             self.enter_text('#new-sstate_dir', '${TOPDIR}/down foo')
 
-            element = self.wait_until_visible('#hintError-sstate_dir', poll=2)
+            element = self.wait_until_visible('#hintError-sstate_dir')
             msg = 'sstate directory path characters invalid but treated as valid'
             self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), msg)
 
@@ -233,13 +227,14 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
         var_name, field, btn_id, input_id, value, save_btn, *_ = kwargs.values()
         """ Change bitbake variable value """
         self._navigate_bbv_page()
-        self.wait_until_visible(f'#{btn_id}', poll=2)
+        self.wait_until_visible(f'#{btn_id}')
         if kwargs.get('new_variable'):
             self.find(f"#{btn_id}").clear()
             self.enter_text(f"#{btn_id}", f"{var_name}")
         else:
             self.click(f'#{btn_id}')
-            self.wait_until_visible(f'#{input_id}', poll=2)
+
+        self.wait_until_visible(f'#{input_id}')
 
         if kwargs.get('is_select'):
             select = Select(self.find(f'#{input_id}'))

