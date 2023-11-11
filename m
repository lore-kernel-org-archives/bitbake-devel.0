Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C52C4332F
	for <webhook@archiver.kernel.org>; Sat, 11 Nov 2023 19:19:06 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.2194.1699730336757688997
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Nov 2023 11:18:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IN7JUUbd;
 spf=pass (domain: gmail.com, ip: 209.85.215.178, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2364487a12.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Nov 2023 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699730336; x=1700335136; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N21WFUXBp4Q4FzSLy/qHaZ4iRrgQn/UAglG1WKi2obw=;
        b=IN7JUUbdSNp04g6zJHycnZfvrVhMXCmiPr/GMeLOYFFqqWI/FcroPa7uB78Elu1P2P
         4UMkxsk2Q0+qX2ioW4wIW1eAuZe4yyPyG2KXPjnrUZBm2VhPqrlSESW159SZ5l8MKuix
         YvTR5m5xbquPIi7FkLNWXCPWJ/GxkIGW0UGQiTArCQck8TnxGepOnuEmQ2455NqKmdv9
         1EiYty2REF/XUtEix2s7iIUriHp60N81xC6Gw0tYb4iyY6uW55ZwdRi99S1TG4vce9ZO
         Ym3tELFuzJBJQ728Iz8Exa4Mfd9eDbEehy3MO6km+Krjaq0w+G6124xNmPseLlWDLjt9
         x0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699730336; x=1700335136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N21WFUXBp4Q4FzSLy/qHaZ4iRrgQn/UAglG1WKi2obw=;
        b=wj09QMuq7l24S1GwYb92col7kXbtdlwmj5qw7rg3ScJlku5kqfbaAkUbUti0F/SODw
         r9GCdInNfRwshYPFU3C04C0NpEBCGLownyiYNi6iV6dKFyjF9RibCZZWNd+YNaiI2iuo
         bZk76Dq8p6oF97nDpHMaf0adbq1tKR3td8G1WZE2shz17A481YtAtgJEzNGytlTWHG9z
         Ir6msMskcm0k/gcQAd9oLLn2hv+LprVqj83v14nO1dWAWLJzQHO5pWsVVUiOM7oS8Etu
         v7uuK31S9zyt9+hatIZegBDrJL1hoH36065veg/K59vRq0sV07Sop9TIu/LtIBydslp0
         SogA==
X-Gm-Message-State: AOJu0YzHD/O4jtPMBbfdBN8K8Lu1sC4iIa3+fnHldXOYoR2Pq0XeY1oA
	FXDCmd7YxFHKdwrAuw2PvASrORdWlUSEtw==
X-Google-Smtp-Source: AGHT+IGeIZgCvrKQYgBb5sFiKNyr2XkAlgSWhdjIJ+Bg/866aPS6WgjZAsrGgdOAmoSRYhdu5ZRHpg==
X-Received: by 2002:a17:90b:3e89:b0:280:74fc:6545 with SMTP id rj9-20020a17090b3e8900b0028074fc6545mr2669128pjb.24.1699730335707;
        Sat, 11 Nov 2023 11:18:55 -0800 (PST)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:3313:4488:79b1:32e])
        by smtp.gmail.com with ESMTPSA id oo3-20020a17090b1c8300b0028328057c67sm1255997pjb.45.2023.11.11.11.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 11:18:55 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH 2/3] toaster: fix obsolete use of find_element_by_link_text
Date: Sat, 11 Nov 2023 11:17:55 -0800
Message-Id: <20231111191754.2322314-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111191754.2322314-1-tim.orling@konsulko.com>
References: <20231111191754.2322314-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Nov 2023 19:19:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15517

The find_element_by_* commands were deprecated in 4.1.4 and have been
removed in 4.3.0:
https://github.com/SeleniumHQ/selenium/blob/selenium-4.3.0/py/CHANGES#L2
as they relied on the use of APIs only intended for internal use.

The recommended method is to use find_elements(By.*) instead.

https://www.selenium.dev/documentation/webdriver/elements/finders/#find-elements-from-element

Also fix some trailing whitespace errors.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .../tests/browser/test_landing_page.py        | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
index e010c59c..7ec52a4b 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -10,6 +10,7 @@
 from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
+from selenium.webdriver.common.by import By
 
 from orm.models import Layer, Layer_Version, Project, Build
 
@@ -52,11 +53,11 @@ class TestLandingPage(SeleniumTestCase):
 
         # check that the documentation link is visible
         self.assertTrue(documentation_link.is_displayed())
-        
+
         # check browser open new tab toaster manual when clicking on the documentation link
         self.assertEqual(documentation_link.get_attribute('target') , '_blank')
         self.assertEqual(
-            documentation_link.get_attribute('href'), 
+            documentation_link.get_attribute('href'),
             'http://docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manual')
         self.assertTrue("Documentation" in documentation_link.text)
 
@@ -66,7 +67,7 @@ class TestLandingPage(SeleniumTestCase):
         jumbotron = self.find('.jumbotron')
 
         # check OpenEmbedded
-        openembedded = jumbotron.find_element_by_link_text('OpenEmbedded')
+        openembedded = jumbotron.find_element(By.LINK_TEXT, 'OpenEmbedded')
         self.assertTrue(openembedded.is_displayed())
         openembedded.click()
         self.assertTrue("openembedded.org" in self.driver.current_url)
@@ -77,7 +78,7 @@ class TestLandingPage(SeleniumTestCase):
         jumbotron = self.find('.jumbotron')
 
         # check BitBake
-        bitbake = jumbotron.find_element_by_link_text('BitBake')
+        bitbake = jumbotron.find_element(By.LINK_TEXT, 'BitBake')
         self.assertTrue(bitbake.is_displayed())
         bitbake.click()
         self.assertTrue("docs.yoctoproject.org/bitbake.html" in self.driver.current_url)
@@ -88,7 +89,7 @@ class TestLandingPage(SeleniumTestCase):
         jumbotron = self.find('.jumbotron')
 
         # check Yocto Project
-        yoctoproject = jumbotron.find_element_by_link_text('Yocto Project')
+        yoctoproject = jumbotron.find_element(By.LINK_TEXT, 'Yocto Project')
         self.assertTrue(yoctoproject.is_displayed())
         yoctoproject.click()
         self.assertTrue("yoctoproject.org" in self.driver.current_url)
@@ -101,7 +102,7 @@ class TestLandingPage(SeleniumTestCase):
         jumbotron = self.find('.jumbotron')
 
         # check Big magenta button
-        big_magenta_button = jumbotron.find_element_by_link_text(
+        big_magenta_button = jumbotron.find_element(By.LINK_TEXT,
             'Toaster is ready to capture your command line builds'
         )
         self.assertTrue(big_magenta_button.is_displayed())
@@ -118,7 +119,7 @@ class TestLandingPage(SeleniumTestCase):
         jumbotron = self.find('.jumbotron')
 
         # check Big Blue button
-        big_blue_button = jumbotron.find_element_by_link_text(
+        big_blue_button = jumbotron.find_element(By.LINK_TEXT,
             'Create your first Toaster project to run manage builds'
         )
         self.assertTrue(big_blue_button.is_displayed())
@@ -131,7 +132,7 @@ class TestLandingPage(SeleniumTestCase):
         jumbotron = self.find('.jumbotron')
 
         # check Read the Toaster manual
-        toaster_manual = jumbotron.find_element_by_link_text('Read the Toaster manual')
+        toaster_manual = jumbotron.find_element(By.LINK_TEXT, 'Read the Toaster manual')
         self.assertTrue(toaster_manual.is_displayed())
         toaster_manual.click()
         self.assertTrue("https://docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manual" in self.driver.current_url)
@@ -142,7 +143,7 @@ class TestLandingPage(SeleniumTestCase):
         jumbotron = self.find('.jumbotron')
 
         # check Contribute to Toaster
-        contribute_to_toaster = jumbotron.find_element_by_link_text('Contribute to Toaster')
+        contribute_to_toaster = jumbotron.find_element(By.LINK_TEXT, 'Contribute to Toaster')
         self.assertTrue(contribute_to_toaster.is_displayed())
         contribute_to_toaster.click()
         self.assertTrue("wiki.yoctoproject.org/wiki/contribute_to_toaster" in str(self.driver.current_url).lower())
-- 
2.34.1


