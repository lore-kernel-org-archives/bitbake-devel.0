Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ED5D0D7AB
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 14:52:01 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.13821.1728658313367579632
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Oct 2024 07:51:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CjCJih2Z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d51055097so961674f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728658311; x=1729263111; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNUginDAp4h9gI3bgOY3J9tnM7pEBYzRs72R82YLris=;
        b=CjCJih2Zz84q/Em3Dgk/PzKSo7R7AKmd4AT7aN5LJ9WwXpCU8rnJK8+jd7+2/reKE4
         uKpHoDwynHByNpledSJzOZxStm8hNr6ZpnLzxTSKKfmBo59w72r4NaVLJs9kZS34osxk
         ZTh2+GBSa46zauFcLOQMBeqp4PzHIL83Lt4DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658311; x=1729263111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNUginDAp4h9gI3bgOY3J9tnM7pEBYzRs72R82YLris=;
        b=mw80g2hbQdeK7EV0wSzCI2TRL7Ct4OtGYtxG2vIJ0Mi0/sL4cYhPv6YbG8TP+erzhp
         HIk8lzx/PHegkNFNNJK4lIa9BmaRSopNP8amLZVELg2MYycZyPQG9cbnY6YGCpxjliUu
         3AHbjPTQkXQf5LhOuKbqpJbkjCpXpI7Y6qh+QB389gHokpyOZYaa/tIduSCSjCQJof8H
         wTjpaCtE+FpisF4KizbTZyJ8zOWxSJhUCkP5Onsc5cKYsHYcI+7NYXZnLjdJ//bk8K18
         /eegpwrjdIqHlrElJ4eXCFDntPvnjB0G19t2ZMhz1AdGTr2EElszdGlRo/F4EX1bJGHy
         5Meg==
X-Gm-Message-State: AOJu0YwM4xph+Un62Dc0+PcqPVfj++gg1me1a5QZaYC2h7+CImBNl55Q
	TA1fS7Smdb3AbDrb4f65newk4WUVLe2gl9x1igJrC8iQWy5wJmbJaFC8yw9waQzk2mrkaRWBw90
	2
X-Google-Smtp-Source: AGHT+IEd/vrBgwxPVF8BE8GYqV67PX+SiQSwCctdwFjMqkgbNBtKWLBfUNvCnY3kZMJ1nKZuCGwOGA==
X-Received: by 2002:adf:f805:0:b0:37c:fde2:93b6 with SMTP id ffacd0b85a97d-37d551b0267mr1928040f8f.11.1728658311522;
        Fri, 11 Oct 2024 07:51:51 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8145:ba6d:a6de:28af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd032sm4142053f8f.30.2024.10.11.07.51.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:51:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] toaster/tests/brwoser: Add wait for element calls
Date: Fri, 11 Oct 2024 15:51:48 +0100
Message-ID: <20241011145148.800080-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011145148.800080-1-richard.purdie@linuxfoundation.org>
References: <20241011145148.800080-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 14:52:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16671

On faster machines these tests are failing as the tests are running
before the page has rendered. Add appripriate wait calls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/test_landing_page.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
index 8fe5fea467..62fdf83c91 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -34,6 +34,7 @@ class TestLandingPage(SeleniumTestCase):
     def test_icon_info_visible_and_clickable(self):
         """ Test that the information icon is visible and clickable """
         self.get(reverse('landing'))
+        self.wait_until_visible('#toaster-version-info-sign')
         info_sign = self.find('#toaster-version-info-sign')
 
         # check that the info sign is visible
@@ -50,6 +51,7 @@ class TestLandingPage(SeleniumTestCase):
     def test_documentation_link_displayed(self):
         """ Test that the documentation link is displayed """
         self.get(reverse('landing'))
+        self.wait_until_visible('#navbar-docs')
         documentation_link = self.find('#navbar-docs > a')
 
         # check that the documentation link is visible
@@ -65,6 +67,7 @@ class TestLandingPage(SeleniumTestCase):
     def test_openembedded_jumbotron_link_visible_and_clickable(self):
         """ Test OpenEmbedded link jumbotron is visible and clickable: """
         self.get(reverse('landing'))
+        self.wait_until_visible('.jumbotron')
         jumbotron = self.find('.jumbotron')
 
         # check OpenEmbedded
@@ -76,6 +79,7 @@ class TestLandingPage(SeleniumTestCase):
     def test_bitbake_jumbotron_link_visible_and_clickable(self):
         """ Test BitBake link jumbotron is visible and clickable: """
         self.get(reverse('landing'))
+        self.wait_until_visible('.jumbotron')
         jumbotron = self.find('.jumbotron')
 
         # check BitBake
@@ -88,6 +92,7 @@ class TestLandingPage(SeleniumTestCase):
     def test_yoctoproject_jumbotron_link_visible_and_clickable(self):
         """ Test Yocto Project link jumbotron is visible and clickable: """
         self.get(reverse('landing'))
+        self.wait_until_visible('.jumbotron')
         jumbotron = self.find('.jumbotron')
 
         # check Yocto Project
@@ -101,6 +106,7 @@ class TestLandingPage(SeleniumTestCase):
             if visible and clickable
         """
         self.get(reverse('landing'))
+        self.wait_until_visible('.jumbotron')
         jumbotron = self.find('.jumbotron')
 
         # check Big magenta button
@@ -119,6 +125,7 @@ class TestLandingPage(SeleniumTestCase):
         Layer_Version.objects.create(layer=layer)
 
         self.get(reverse('landing'))
+        self.wait_until_visible('.jumbotron')
         jumbotron = self.find('.jumbotron')
 
         # check Big Blue button
@@ -132,6 +139,7 @@ class TestLandingPage(SeleniumTestCase):
     def test_toaster_manual_link_visible_and_clickable(self):
         """ Test Read the Toaster manual link jumbotron is visible and clickable: """
         self.get(reverse('landing'))
+        self.wait_until_visible('.jumbotron')
         jumbotron = self.find('.jumbotron')
 
         # check Read the Toaster manual
@@ -145,6 +153,7 @@ class TestLandingPage(SeleniumTestCase):
     def test_contrib_to_toaster_link_visible_and_clickable(self):
         """ Test Contribute to Toaster link jumbotron is visible and clickable: """
         self.get(reverse('landing'))
+        self.wait_until_visible('.jumbotron')
         jumbotron = self.find('.jumbotron')
 
         # check Contribute to Toaster
@@ -161,6 +170,7 @@ class TestLandingPage(SeleniumTestCase):
         => should see the landing page
         """
         self.get(reverse('landing'))
+        self.wait_until_visible('.jumbotron')
         self.assertTrue(self.LANDING_PAGE_TITLE in self.get_page_source())
 
     def test_default_project_has_build(self):
@@ -193,6 +203,7 @@ class TestLandingPage(SeleniumTestCase):
         user_project.save()
 
         self.get(reverse('landing'))
+        self.wait_until_visible('#projectstable')
 
         elements = self.find_all('#projectstable')
         self.assertEqual(len(elements), 1, 'should redirect to projects')

