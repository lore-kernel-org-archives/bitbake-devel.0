Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594C2C71157
	for <webhook@archiver.kernel.org>; Sat, 21 Jun 2025 14:35:44 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.8442.1750516538269655680
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jun 2025 07:35:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hDEWnngm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so2348089f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jun 2025 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750516536; x=1751121336; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1VOgRNa1Tln8hUbMrYHKl8/y1OU6c8pBAXU4W+ECTs4=;
        b=hDEWnngmWJwUApV5Yzlc5QHWWMHZijO6NASqTEaoU9FqR35IEVzihqLixmNQFdB00j
         BEqZenOXf/eX6RGLO1bq0XPeTljJ67IVsCW9I1BcBcKe2PUxDn/qdAIszwDE4OPPxn8K
         vBx7Ngzvf8mz2p0Aup8otfQMxh2fAX+SfGunY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750516536; x=1751121336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VOgRNa1Tln8hUbMrYHKl8/y1OU6c8pBAXU4W+ECTs4=;
        b=vEvVOGmAU5mJCDo8NFMozlzFl4CC2HpxbfNGb2peqtDbdb9iBuJpVSLGYdb4R+BKt7
         ashAIFfzW1waESuyVO330zubK8wKqnc4xCYFT3kHyT3XZ8ZZUeUDIAmOFpC4s2xQdT74
         xhXiVY+uXjvr6dc2HAH5cLz617cDFPsATKLGR2ShuFGBGntF0iMAQlu5UleeatjjQlTf
         F65P+whfxvWHokjuChIp2hYNTa8SWIhi5OUI7VX6t4xVyNVe7PRjID6lP1csAHK4TNPp
         er3wE8Txdaz0mVTsLx1hANI1F/UPlWcwyPk0WAVuf+uD7F5GKBPT7b239rA4u1PmR5TM
         JdKQ==
X-Gm-Message-State: AOJu0YxgvjBO1bqoQg8a7vBv5cIRMpn3cyLV8NnT5oYPreOS8kFZgiPY
	uycjECzYtRpYtZGcnJ7uhd/B1hOkYzY4+HLdeZ9uo+V1F3q6BgPEgLVVSc/4ht0COgI2X4neQkK
	o3voWC/o=
X-Gm-Gg: ASbGncsbks7gSf4yhLE9fQLoKCNBNuwm3iHmqSqg9G4419sG1AX0d24CugkMKhUJ9W3
	DsZk8IrNwADqGk6vviCWWYau+sgjMO0WJmbmgD5L4sn+1wRBvrZKTS2WYsaq/4Fd0KreE0pHHUI
	PHzVY82iEYqzZqVLUBxjlxFEDn8dcArwxuRav3NZPjF4CFcFLFTMwHhlSQ5fgK+NoT90pY4keNt
	q350aEygEbJ1rIze+S7186w2PcXOcc7buo1ma37IK2CN9XjspLZ4tUTs+uijuXGNNBlrvKqCM8f
	v7IHJLNlbPsVNRnv3Q1aTOf0ZZLxkfz3s44C3kWv0M+oveb2XTK7ug+WYGw+VPkOBvyAdQLrqQv
	oWz+VGYTx5vZarw==
X-Google-Smtp-Source: AGHT+IEW8SUskxmJtT4XALkCHuWQRZLNYM++Nd/5tuA46JveepgLIczkAeyunkSRKlxXxtsx7frJWA==
X-Received: by 2002:a05:6000:2013:b0:3a5:4b67:5a70 with SMTP id ffacd0b85a97d-3a6d12e8d1amr5671892f8f.18.1750516535860;
        Sat, 21 Jun 2025 07:35:35 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3287:1ee:865a:f13c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10502sm4982444f8f.18.2025.06.21.07.35.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 07:35:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster/tests: Fix automated testing failures
Date: Sat, 21 Jun 2025 15:35:34 +0100
Message-ID: <20250621143534.2664773-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jun 2025 14:35:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17708

The display window scrolling mechanism we were using was failing in one case
and needed in another. After trying various approaches, this one with
window.scrollTo seems to work and fixes the test failures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/test_layerdetails_page.py | 2 ++
 lib/toaster/tests/functional/test_project_page.py   | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index 69493833f4..6abfdef699 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -108,6 +108,8 @@ class TestLayerDetailsPage(SeleniumTestCase):
             save_btn.click()
 
         self.wait_until_visible("#save-changes-for-switch")
+        # Ensure scrolled into view
+        self.driver.execute_script('window.scrollTo({behavior: "instant", top: 0, left: 0})')
         btn_save_chg_for_switch = self.wait_until_clickable(
             "#save-changes-for-switch")
         btn_save_chg_for_switch.click()
diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toaster/tests/functional/test_project_page.py
index c6dad0eb5d..429d86feba 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -685,17 +685,17 @@ class TestProjectPage(TestProjectPageBase):
             'active', str(self.find('#information').get_attribute('class'))
         )
         # Check second tab (recipes)
-        # Ensure page is scrolled to the top
-        self.driver.find_element(By.XPATH, '//body').send_keys(Keys.CONTROL + Keys.HOME)
         self.wait_until_visible('.nav-tabs')
+        # Ensure page is scrolled to the top
+        self.driver.execute_script('window.scrollTo({behavior: "instant", top: 0, left: 0})')
         tabs[1].click()
         self.assertIn(
             'active', str(self.find('#recipes').get_attribute('class'))
         )
         # Check third tab (machines)
-        # Ensure page is scrolled to the top
-        self.driver.find_element(By.XPATH, '//body').send_keys(Keys.CONTROL + Keys.HOME)
         self.wait_until_visible('.nav-tabs')
+        # Ensure page is scrolled to the top
+        self.driver.execute_script('window.scrollTo({behavior: "instant", top: 0, left: 0})')
         tabs[2].click()
         self.assertIn(
             'active', str(self.find('#machines').get_attribute('class'))

