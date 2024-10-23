Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C76CCDDE51
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:30 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.5166.1729677620708824449
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=anERzs+P;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315baec69eso62166545e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677619; x=1730282419; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvgM7OwZ4WBVxggn+6NP+nAk5qO8MKamwxoIAQMCN8s=;
        b=anERzs+POKUc8CEKKO0tW2La3zWAo7oDT8RovfLiMkP0zZCXYvvSqL/WG32kiubZiB
         Semeyy9b/n7WkQaJtuAYX3EMnwPhpR7/1cDaJNlkSoEvcYhN7DWaeELurdJMBYfRURHu
         iaixcrxYmRtiqHL46i8HLon4H6GewVhWzYP1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677619; x=1730282419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvgM7OwZ4WBVxggn+6NP+nAk5qO8MKamwxoIAQMCN8s=;
        b=s8HuQBbO7eyotxfjJ/HjN3tnjEngmVIWGOoeFhGJnPXtqAQ24gqXo9t/hTp35qaJzU
         2nbN3a+Quv8TPH5HjXXurT/h98yvyTjP0CfPoZF8dRyRmk2nBVwLxmTWzWvA0EOeSMFr
         cGlFlgkYeQo2/aDrKva2maxEbmryfASRl40oSQFGwwFh+7yWFWoJd/IWq1amEAXwHIS9
         aIhnCTCJRFLJC4jZiILhTvpQ4h0pXdTUGwLKc0rQDJ2VQfzKVV1TO6PzKdoQF83IkreV
         F7gTqPiJG2dUolQU/xbdjPsjYPX/Grlp0C3O/ZNYtEQJfl292pujaoRAgwYUFSyjKkfc
         b3IQ==
X-Gm-Message-State: AOJu0YxhX2lgCNbWhs02a/N4IqhhzHvxlvh0tR2sKEiXFY8zMi9Hme8z
	B6cSqOPCimEjqYmLitceu1cO8Ln5nPdmI0h72qpMpAz8AsViybyZsLpECYWJFNkn/9iqIO6YhIw
	g
X-Google-Smtp-Source: AGHT+IHNpK/SkCQCpzWRM9iMrQqYHchW2G5bJI5t8BezXQ35XygAo46qCtahUao26lMEshKlm0E5VA==
X-Received: by 2002:a05:600c:6002:b0:431:5f1b:a7c4 with SMTP id 5b1f17b1804b1-431842608a3mr15517535e9.34.1729677618688;
        Wed, 23 Oct 2024 03:00:18 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:18 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 27/28] toaster/tests/browser/layerdetails: Drop unwanted test skipping/exception handling
Date: Wed, 23 Oct 2024 10:59:48 +0100
Message-ID: <20241023095949.3351980-27-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16718

We really don't want to be skipping a test like this, drop the exception handling
code as in my testing we thankfully no longer seem to be seeing it. If we do again
we need to fix the underlying issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/browser/test_layerdetails_page.py   | 38 +++++--------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index a6d1bc46c2..69493833f4 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -64,7 +64,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
                            args=(self.project.pk,
                                  self.imported_layer_version.pk))
 
-    def _edit_layerdetails(self):
+    def test_edit_layerdetails_page(self):
         """ Edit all the editable fields for the layer refresh the page and
         check that the new values exist"""
 
@@ -107,17 +107,10 @@ class TestLayerDetailsPage(SeleniumTestCase):
         for save_btn in self.find_all(".change-btn"):
             save_btn.click()
 
-        try:
-            self.wait_until_visible("#save-changes-for-switch")
-            btn_save_chg_for_switch = self.wait_until_clickable(
-                "#save-changes-for-switch")
-            btn_save_chg_for_switch.click()
-        except ElementClickInterceptedException:
-            self.skipTest(
-                "save-changes-for-switch click intercepted. Element not visible or maybe covered by another element.")
-        except TimeoutException:
-            self.skipTest(
-                "save-changes-for-switch is not clickable within the specified timeout.")
+        self.wait_until_visible("#save-changes-for-switch")
+        btn_save_chg_for_switch = self.wait_until_clickable(
+            "#save-changes-for-switch")
+        btn_save_chg_for_switch.click()
 
         self.wait_until_visible("#edit-layer-source")
 
@@ -147,17 +140,10 @@ class TestLayerDetailsPage(SeleniumTestCase):
         new_dir = "/home/test/my-meta-dir"
         dir_input.send_keys(new_dir)
 
-        try:
-            self.wait_until_visible("#save-changes-for-switch")
-            btn_save_chg_for_switch = self.wait_until_clickable(
-                "#save-changes-for-switch")
-            btn_save_chg_for_switch.click()
-        except ElementClickInterceptedException:
-            self.skipTest(
-                "save-changes-for-switch click intercepted. Element not properly visible or maybe behind another element.")
-        except TimeoutException:
-            self.skipTest(
-                "save-changes-for-switch is not clickable within the specified timeout.")
+        self.wait_until_visible("#save-changes-for-switch")
+        btn_save_chg_for_switch = self.wait_until_clickable(
+            "#save-changes-for-switch")
+        btn_save_chg_for_switch.click()
 
         self.wait_until_visible("#edit-layer-source")
 
@@ -168,12 +154,6 @@ class TestLayerDetailsPage(SeleniumTestCase):
                         "Expected %s in the dir value for layer directory" %
                         new_dir)
 
-    def test_edit_layerdetails_page(self):
-        try:
-            self._edit_layerdetails()
-        except ElementClickInterceptedException:
-            self.skipTest(
-                "ElementClickInterceptedException occured. Element not visible or maybe covered by another element.")
 
     def test_delete_layer(self):
         """ Delete the layer """

