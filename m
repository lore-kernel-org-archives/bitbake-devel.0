Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363C9CDDE5D
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:20 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.5153.1729677616442897517
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=H1FC9pTf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so36540975e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677614; x=1730282414; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLT/65MIunZFV7t6u2EW/stQsJTX08BL4Fduvxyy7po=;
        b=H1FC9pTfOfUnhXX89xifice8EBU4pnjw5HpnHF6faR1xWJv3ZYtivVlDxTCXM0F6Bj
         YsTJQq/jikIeaEo3ErgEZa4lWnStCF1HufftoCDi1Uou6eWuyS8PTGqJ5LN8z9LnbPu5
         3GK7/iH4A43hb/uj66VRBflqx8MbJpcusVtKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677614; x=1730282414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLT/65MIunZFV7t6u2EW/stQsJTX08BL4Fduvxyy7po=;
        b=Qpyy1p6P8iRk0QzuzrMx899AdK0JcUdtH3kcXJDyDK43tSYjVu8OgkjL9KoAvRHR4/
         FcXXd3fn2HCMW7Y7St9KjZhl9V9vtMtB2AkDKvNMx4UEfwSuOUQe280ipxAJkJfv6lIg
         rcU+Ewp3Ek4Q6wDXQw+VK9Cx14lXpR1t90+ZYO8yEJCFIcwICttT8twKtZ8tzlbB67Zw
         jFdYwS+fP4rt7XKUY6dEW43Vk2gCuqQXZXPf6uV8la/B558Qt8SZIUQtaHxl0hkN3o2a
         ojw1ZimDHA7WmcmM4i2+TBAxIt1gvAW4KZQy+fPcnFgSkF1z4Qdfyfv7Q7NnVu7M6JWi
         aveg==
X-Gm-Message-State: AOJu0Yy6KF/F2xeKS64X8aOjO2QA1yLzv+oGXarw2d22NxCcG3t8mufn
	d/un00jTqfduHA8v8EAMdy0i+9zKbDgAO5MhISNIkimjMO48Wu7/6acv/Sh10D2keibAn/kcwe8
	N
X-Google-Smtp-Source: AGHT+IEOymmv1bkVf8qNqxDe5qXogKzLi0gQAUqbhEj1FSb90GKWou+9ma+JrxPgRPywHDM+ykaYXA==
X-Received: by 2002:a05:600c:4750:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-43184130160mr15415035e9.2.1729677614442;
        Wed, 23 Oct 2024 03:00:14 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 22/28] toaster/tests/browser: Add various fixes for test failures encountered
Date: Wed, 23 Oct 2024 10:59:43 +0100
Message-ID: <20241023095949.3351980-22-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16713

Fixes for the browser tests which:
* Add/improve waiting for specific elements
* Waiting for elements to be interactable, not just visible
* Hiding notification windows
* Using more specific asserts to obtain improved error messages

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/test_all_builds_page.py   |  1 +
 lib/toaster/tests/browser/test_landing_page.py      |  1 +
 lib/toaster/tests/browser/test_layerdetails_page.py | 12 +++++++++---
 lib/toaster/tests/browser/test_new_project_page.py  |  6 ++----
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toaster/tests/browser/test_all_builds_page.py
index a1f8057113..9ab81fb11b 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -200,6 +200,7 @@ class TestAllBuildsPage(SeleniumTestCase):
 
         # should see a rebuild button for non-command-line builds
         self.wait_until_visible('#allbuildstable tbody tr')
+        self.wait_until_visible('.rebuild-btn')
         selector = 'div[data-latest-build-result="%s"] .rebuild-btn' % build1.id
         run_again_button = self.find_all(selector)
         self.assertEqual(len(run_again_button), 1,
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
index f3300430ba..210359d561 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -44,6 +44,7 @@ class TestLandingPage(SeleniumTestCase):
         # and info modal is appearing when clicking on the info sign
         info_sign.click()  # click on the info sign make attribute 'aria-describedby' visible
         info_model_id = info_sign.get_attribute('aria-describedby')
+        self.wait_until_visible(f'#{info_model_id}')
         info_modal = self.find(f'#{info_model_id}')
         self.assertTrue(info_modal.is_displayed())
         self.assertTrue("Toaster version information" in info_modal.text)
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index c4f3f79d34..a6d1bc46c2 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -100,7 +100,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
                             (self.initial_values, value))
 
             # Make sure the input visible beofre sending keys
-            self.wait_until_visible("#layer-git input[type=text]")
+            self.wait_until_clickable("#layer-git input[type=text]")
             inputs.send_keys("-edited")
 
         # Save the new values
@@ -211,6 +211,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
         self.get(self.url)
 
         # Add the layer
+        self.wait_until_clickable("#add-remove-layer-btn")
         self.click("#add-remove-layer-btn")
 
         notification = self.wait_until_visible("#change-notification-msg")
@@ -218,12 +219,17 @@ class TestLayerDetailsPage(SeleniumTestCase):
         expected_text = "You have added 1 layer to your project: %s" % \
             self.imported_layer_version.layer.name
 
-        self.assertTrue(expected_text in notification.text,
+        self.assertIn(expected_text, notification.text,
                         "Expected notification text %s not found was "
                         " \"%s\" instead" %
                         (expected_text, notification.text))
 
+        hide_button = self.find('#hide-alert')
+        hide_button.click()
+        self.wait_until_not_visible('#change-notification')
+
         # Remove the layer
+        self.wait_until_clickable("#add-remove-layer-btn")
         self.click("#add-remove-layer-btn")
 
         notification = self.wait_until_visible("#change-notification-msg")
@@ -231,7 +237,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
         expected_text = "You have removed 1 layer from your project: %s" % \
             self.imported_layer_version.layer.name
 
-        self.assertTrue(expected_text in notification.text,
+        self.assertIn(expected_text, notification.text,
                         "Expected notification text %s not found was "
                         " \"%s\" instead" %
                         (expected_text, notification.text))
diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toaster/tests/browser/test_new_project_page.py
index b6187db105..e50f236c32 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -89,12 +89,10 @@ class TestNewProjectPage(SeleniumTestCase):
         radio = self.driver.find_element(By.ID, 'type-new')
         radio.click()
 
-        self.click("#create-project-button")
-
-        self.wait_until_present('#hint-error-project-name')
+        self.wait_until_visible('#hint-error-project-name')
         element = self.find('#hint-error-project-name')
 
-        self.assertTrue(("Project names must be unique" in element.text),
+        self.assertIn("Project names must be unique", element.text,
                         "Did not find unique project name error message")
 
         # Try and click it anyway, if it submits we'll have a new project in

