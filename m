Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFFCCDDE4A
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.5138.1729677602782704450
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BqkqniOC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so72639265e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677601; x=1730282401; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fhpzv6XJPkz0xg7HJqtYVgbpFBZ7mGMyZCBsq0rCHok=;
        b=BqkqniOCTNrkb3aR3VdDCt3jbslMSrp51/GK5ABesX1B7/1WxQv1KGI5ca6sYQLYq4
         sNsn4NRgizb/A21Ehsrz69JQekHVouGOzFCW8OBNlrE/tyq4jzG6Z/QHrGLiEvjFyjrZ
         nA2OoweYWP0jOydPLWICOFMRnhxFDZ/nC46lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677601; x=1730282401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fhpzv6XJPkz0xg7HJqtYVgbpFBZ7mGMyZCBsq0rCHok=;
        b=ujO2LqrJDZyqcvD9FDU6WqaJgW7iJQzT7II3W512hFhNgixABxVc7jJtIkjs1Zjb3S
         r/336TXQ5lsBU22679XAjIroEZbz+Xx1feV7Hl+LP+R+DAFMhbHZN9LFnWlH9vjof7g3
         BDhumxh6shHXxt6Ri/QawtHl6sLfONrAn2JGFWeN65KzBTycUsVlK3fLXf8wIAYzdN/s
         7TM2eMETNqbJX426dyXUJt4Fbrd8NfnSc5Q+AYbW00LzYEhBq3Ou3pA0WEJKSaubntnI
         gi9MPMH54eLYnIEWty7aq0V16Ft9R6qh87aPgapp+lxCbnC3ar1OjRcbW+PrEIFfTeva
         ZaXQ==
X-Gm-Message-State: AOJu0Yy/TJJOX+IizdBNBpo3FWOoJPWiTP5N/QCu0d/mFiVUAojz73Fj
	KlRmEibKxGkT8kOCqHKgcZWtjF1vf+k2wZu4YqgONiQQFfxHklvdZTKQKlSMHIHzKItfJ7sKPye
	v
X-Google-Smtp-Source: AGHT+IGFZDmzU1ug7qMp5Py7N1KC4xf81eeCd59I179t7t1Pm3I3kY7FcTEglrewEN9fdkTMuKHcZA==
X-Received: by 2002:a05:600c:1c9d:b0:431:12a8:7f1a with SMTP id 5b1f17b1804b1-4318415a497mr18654625e9.16.1729677600899;
        Wed, 23 Oct 2024 03:00:00 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:59 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 10/28] toaster/tests/functional/basic: Improve the projects table selection to a common function
Date: Wed, 23 Oct 2024 10:59:31 +0100
Message-ID: <20241023095949.3351980-10-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16701

The project page selection code is race prone. Create a common function to resolve
the race issue and use it from all the call sites rather than duplicate code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/functional_helpers.py        |  6 ++++++
 .../tests/functional/test_functional_basic.py     | 15 ++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
index a7a3459630..e28f2024f5 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -216,3 +216,9 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
                             'The project release is not defined')
 
         return project_id
+        
+    def load_projects_page_helper(self):        
+        self.wait_until_present('#projectstable')
+        # Need to wait for some data in the table too
+        self.wait_until_present('td[class="updated"]')
+
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index c73a278f6c..d5c9708617 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -20,6 +20,7 @@ from tests.functional.utils import get_projectId_from_url
 class FuntionalTestBasic(SeleniumFunctionalTestCase):
     """Basic functional tests for Toaster"""
     project_id = None
+    project_url = None
 
     def setUp(self):
         super(FuntionalTestBasic, self).setUp()
@@ -29,7 +30,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
  #  testcase (1515)
     def test_verify_left_bar_menu(self):
         self.get(reverse('all-projects'))
-        self.wait_until_present('#projectstable', poll=10)
+        self.load_projects_page_helper()
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         self.wait_until_present('#config-nav')
         self.assertTrue(self.element_exists('#config-nav'),'Configuration Tab does not exist')
@@ -82,7 +83,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1516)
     def test_review_configuration_information(self):
         self.get(reverse('all-projects'))
-        self.wait_until_present('#projectstable', poll=10)
+        self.load_projects_page_helper()
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         project_URL=self.get_URL()
 
@@ -131,7 +132,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1517)
     def test_verify_machine_information(self):
         self.get(reverse('all-projects'))
-        self.wait_until_present('#projectstable', poll=10)
+        self.load_projects_page_helper()
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
 
         self.wait_until_visible('#machine-section')
@@ -149,7 +150,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1518)
     def test_verify_most_built_recipes_information(self):
         self.get(reverse('all-projects'))
-        self.wait_until_present('#projectstable', poll=10)
+        self.load_projects_page_helper()
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         self.wait_until_present('#config-nav')
         project_URL=self.get_URL()
@@ -166,7 +167,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1519)
     def test_verify_project_release_information(self):
         self.get(reverse('all-projects'))
-        self.wait_until_present('#projectstable', poll=10)
+        self.load_projects_page_helper()
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         self.wait_until_visible('#project-release-title')
         self.assertTrue(re.search("Yocto Project master",self.driver.find_element(By.ID, "project-release-title").text), 'No project release title information in project detail page')
@@ -174,7 +175,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1520)
     def test_verify_layer_information(self):
         self.get(reverse('all-projects'))
-        self.wait_until_present('#projectstable', poll=10)
+        self.load_projects_page_helper()
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         self.wait_until_present('#config-nav')
         project_URL=self.get_URL()
@@ -210,7 +211,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1521)
     def test_verify_project_detail_links(self):
         self.get(reverse('all-projects'))
-        self.wait_until_present('#projectstable', poll=10)
+        self.load_projects_page_helper()
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         self.wait_until_present('#config-nav')
         project_URL=self.get_URL()

