Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA2BCEE333
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 17:25:13 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.22901.1728494711988954243
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Oct 2024 10:25:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KshEEzyG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so64565e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Oct 2024 10:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728494710; x=1729099510; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4H71FBESL0OMq3treR52HpgMiiQLpeZwmFrLZY0YOYw=;
        b=KshEEzyGkdKbM0M/496EkVW94MtdmXvWFbAEJWPhmMD3SQdRM+aQIRHT7p6b8/0YbN
         mE4pqN8YaJDye8ffB2CxUyygJWhldqOGYf1US9Y/8Pir1VdAvRXZVKPMb4xdBzXxbyxi
         wv+XXuY+D2S1us+5b+60RpZ7mjhErlLUJoVE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494710; x=1729099510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4H71FBESL0OMq3treR52HpgMiiQLpeZwmFrLZY0YOYw=;
        b=eEKZgkrYH91HNq9MjUmN7fhMUx3PNiWv9GtWtUpRFZCgjO8n5vXiRH0cyriI0JQPhj
         Ex/30uIszncEqmOXrS293z7pqGJF8PXXUeLIrDAoICFx7QEWfKTiijZZst/8UnjwLPsK
         EhiPm3ECWbU+sOkDuE0wAjxiFKoH4+HnfJCoYrSB+itIPR8M1NAxuzNQGIhQNajADe5i
         o+/ThMOiBSWke3EtjKvgoUDkem2s1HjlOGpm0IQB7ItzUSQJAn1zLejNuTu6CQ7d909v
         Tqe/9zHpwtqlgocitaqJv23VhBHwIYdy6J12SIKLc1+4TZn4Ly22lybggZ0j6+pKsgCM
         dXmw==
X-Gm-Message-State: AOJu0YwyfGnzjSstjJWJ7DDrkM1+QmYWQ2kisGfxH+5MHNzIWKj2JBkL
	nYsTgPUy3168IHd3N4zRwzuk4xUJ2A8RkepD1cr/KsDZd1nF8EIPd4qLFAg/pjCEO621jAKC6nI
	v
X-Google-Smtp-Source: AGHT+IF8j6TY67u/aSyfsjPIFSFGYO0uugoZtAtxtWKlo/oZd6C7kdvzjRhoWmaFHWyAPowkVJVfjA==
X-Received: by 2002:a05:600c:4f14:b0:430:9fde:3b92 with SMTP id 5b1f17b1804b1-430ccf312c9mr37928945e9.14.1728494709844;
        Wed, 09 Oct 2024 10:25:09 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fb33:4e5d:4941:5018])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d3f568fd7sm1761267f8f.102.2024.10.09.10.25.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:25:09 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] toaster/tests/functional: Fix later details page test issues
Date: Wed,  9 Oct 2024 18:25:06 +0100
Message-ID: <20241009172508.447620-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Oct 2024 17:25:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16664

Consistently use meta-poky as the test target, instead of a magic number
ID which can vary.

Fix incorrect comments.

Also ensure the viewport is scrolled to the top when changing tabs.
This breaks if other layers are selected like openembedded-core due
to the number of recipes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_project_page.py     | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index deb26812ea..6b6d45eaba 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -699,7 +699,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         )
 
     def test_single_layer_page(self):
-        """ Test layer page
+        """ Test layer details page using meta-poky as an example (assumes is added to start with)
             - Check if title is displayed
             - Check add/remove layer button works
             - Check tabs(layers, recipes, machines) are displayed
@@ -708,13 +708,14 @@ class TestProjectPage(SeleniumFunctionalTestCase):
                 - Check layer summary
                 - Check layer description
         """
-        url = reverse("layerdetails", args=(TestProjectPage.project_id, 7))
-        self.get(url)
+        self._navigate_to_config_nav('layerstable', 6)
+        layer_link = self.driver.find_element(By.XPATH, '//tr/td[@class="layer__name"]/a[contains(text(),"meta-poky")]')
+        layer_link.click()
         self.wait_until_visible('.page-header')
         # check title is displayed
         self.assertTrue(self.find('.page-header h1').is_displayed())
 
-        # check add layer button works
+        # check remove layer button works
         remove_layer_btn = self.find('#add-remove-layer-btn')
         remove_layer_btn.click()
         self.wait_until_visible('#change-notification', poll=2)
@@ -722,7 +723,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertIn(
             f'You have removed 1 layer from your project', str(change_notification.text)
         )
-        # check add layer button works, 18 is the random layer id
+        # check add layer button works
         add_layer_btn = self.find('#add-remove-layer-btn')
         add_layer_btn.click()
         self.wait_until_visible('#change-notification')
@@ -738,12 +739,18 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertTrue(
             'active' in str(self.find('#information').get_attribute('class'))
         )
-        # Check second tab
+        # Check second tab (recipes)
+        # Ensure page is scrolled to the top
+        self.driver.find_element(By.XPATH, '//body').send_keys(Keys.CONTROL + Keys.HOME)
+        self.wait_until_visible('.nav-tabs')
         tabs[1].click()
         self.assertTrue(
             'active' in str(self.find('#recipes').get_attribute('class'))
         )
-        # Check third tab
+        # Check third tab (machines)
+        # Ensure page is scrolled to the top
+        self.driver.find_element(By.XPATH, '//body').send_keys(Keys.CONTROL + Keys.HOME)
+        self.wait_until_visible('.nav-tabs')
         tabs[2].click()
         self.assertTrue(
             'active' in str(self.find('#machines').get_attribute('class'))

