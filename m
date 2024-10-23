Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B67CDDE41
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 09:59:59 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.5135.1729677598926775548
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 02:59:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ghy1Gray;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so4514186f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677597; x=1730282397; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sj/uS8zMOpUt+1r2muESS8WuGMMZ7DCPNNNVCzoDHAg=;
        b=ghy1GraycUJX9wRZqoXIAGyPWMAQSwnzQjkrXAS94YrWq+A+TIAoDSwNmp7qCIXbX6
         B96/bY5uZAkooP0u5swUSqoigd3w+dDffEwZHT8R5twLa7HCDPv3+ZqsEKAyeQPYCmEN
         np7dzulIgQVLLrlsnFSAqde5EcN8pJIzVsWls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677597; x=1730282397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj/uS8zMOpUt+1r2muESS8WuGMMZ7DCPNNNVCzoDHAg=;
        b=GnkNcYcbEHkO8CxXZZUDmlW+GTwS9MgeuarlmUyvNGM7BNZlN1TCoeYZ+a05O+VONk
         rRpAkxv0p49HmyTLSghanRn5CoukOmDSvMYb2v2N5/PNnkRbDP3MvzJk/J0QxGrMnkj2
         dXhQXRZrEFAeBRqSLtoGDSqCpwqWH2Ek32M+B3DO6tiWZPMVktbHSOxj+dkZWxy+dq8l
         WcBdGZugisEjUspyxClfhToDkpcL8SCFuW103nswKqANNsskvkqp4tY1HXmQFIXXhXcA
         q+LM/Z+i7Fl80OOKnaURrnUMceV6P1O9kgoDZFBMqIxs5EH7p3Qpxz9jnQ2pqtuaWsqQ
         kJdg==
X-Gm-Message-State: AOJu0Yx6d1uJVbJjogUJDRp+kitxaSzAeDjiGwkQian0yt/KatEWcPd3
	R0ba1DL3UKPmJrdL7ozVc/KOstiCePiXR+TUBAVGM8YFHh2WqENa/fxg7KmGUMsCKCCpy8MUjdS
	m
X-Google-Smtp-Source: AGHT+IHg/AhIh3OiTqcD13PhRQgPnXc6Jfyb7Y9YVOvWXbXONOP6x7A+C4N66GFs9FFG6xE1N5gevA==
X-Received: by 2002:a5d:558a:0:b0:37d:4a82:6412 with SMTP id ffacd0b85a97d-37efcf84cdcmr1253210f8f.46.1729677596801;
        Wed, 23 Oct 2024 02:59:56 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:55 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 06/28] toaster/tests/function/basic: Make element detection more specific
Date: Wed, 23 Oct 2024 10:59:27 +0100
Message-ID: <20241023095949.3351980-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 09:59:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16697

The tests would race and potentially fail as the elements on the
page being waited for were not specific enough.

Add suitable elements to wait for and drop the remainder of the poll
parameters since these are no longer needed since we no longer need
to sleep for things to appear.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_functional_basic.py | 55 +++++++++++--------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index a95ce4862c..c73a278f6c 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -31,50 +31,50 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.get(reverse('all-projects'))
         self.wait_until_present('#projectstable', poll=10)
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
-        self.wait_until_present('#config-nav', poll=10)
+        self.wait_until_present('#config-nav')
         self.assertTrue(self.element_exists('#config-nav'),'Configuration Tab does not exist')
         project_URL=self.get_URL()
         self.driver.find_element(By.XPATH, '//a[@href="'+project_URL+'"]').click()
-        self.wait_until_present('#config-nav', poll=10)
 
         try:
+            self.wait_until_present('#config-nav')
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'customimages/"'+"]").click()
-            self.wait_until_present('#config-nav', poll=10)
+            self.wait_until_present('#filter-modal-customimagestable')
         except:
             self.fail(msg='No Custom images tab available')
         self.assertTrue(re.search("Custom images",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'Custom images information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'images/"'+"]").click()
-            self.wait_until_present('#config-nav', poll=10)
+            self.wait_until_present('#filter-modal-imagerecipestable')
         except:
             self.fail(msg='No Compatible image tab available')
         self.assertTrue(re.search("Compatible image recipes",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible image recipes information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'softwarerecipes/"'+"]").click()
-            self.wait_until_present('#config-nav', poll=10)
+            self.wait_until_present('#filter-modal-softwarerecipestable')
         except:
             self.fail(msg='No Compatible software recipe tab available')
         self.assertTrue(re.search("Compatible software recipes",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible software recipe information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'machines/"'+"]").click()
-            self.wait_until_present('#config-nav', poll=10)
+            self.wait_until_present('#filter-modal-machinestable')
         except:
             self.fail(msg='No Compatible machines tab available')
         self.assertTrue(re.search("Compatible machines",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible machine information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'layers/"'+"]").click()
-            self.wait_until_present('#config-nav', poll=10)
+            self.wait_until_present('#filter-modal-layerstable')
         except:
             self.fail(msg='No Compatible layers tab available')
         self.assertTrue(re.search("Compatible layers",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible layer information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'configuration"'+"]").click()
-            self.wait_until_present('#config-nav', poll=10)
+            self.wait_until_present('#configvar-list')
         except:
             self.fail(msg='No Bitbake variables tab available')
         self.assertTrue(re.search("Bitbake variables",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Bitbake variables information is not loading properly')
@@ -85,20 +85,21 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.wait_until_present('#projectstable', poll=10)
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         project_URL=self.get_URL()
-        self.wait_until_present('#config-nav', poll=10)
 
         # Machine section of page
+        self.wait_until_visible('#machine-section')
         self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
         self.assertTrue(re.search("qemux86-64",self.driver.find_element(By.XPATH, "//span[@id='project-machine-name']").text),'The machine type is not assigned')
         try:
            self.driver.find_element(By.XPATH, "//span[@id='change-machine-toggle']").click()
-           self.wait_until_visible('#select-machine-form', poll=10)
-           self.wait_until_visible('#cancel-machine-change', poll=10)
+           self.wait_until_visible('#select-machine-form')
+           self.wait_until_visible('#cancel-machine-change')
            self.driver.find_element(By.XPATH, "//form[@id='select-machine-form']/a[@id='cancel-machine-change']").click()
         except:
            self.fail(msg='The machine information is wrong in the configuration page')
 
         # Most built recipes section
+        self.wait_until_visible('#no-most-built')
         try:
            self.driver.find_element(By.ID, 'no-most-built')
         except:
@@ -108,6 +109,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.assertTrue(re.search("Yocto Project master",self.driver.find_element(By.XPATH, "//span[@id='project-release-title']").text), 'The project release is not defined in the project detail page')
 
         # List of layers in project
+        self.wait_until_visible('#layer-container')
         self.driver.find_element(By.XPATH, "//div[@id='layer-container']")
         self.assertTrue(re.search("3",self.driver.find_element(By.ID, "project-layers-count").text),'There should be 3 layers listed in the layer count')
         try:
@@ -131,14 +133,15 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.get(reverse('all-projects'))
         self.wait_until_present('#projectstable', poll=10)
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
-        self.wait_until_present('#config-nav', poll=10)
 
+        self.wait_until_visible('#machine-section')
         self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
+        self.wait_until_visible('#project-machine-name')
         self.assertTrue(re.search("qemux86-64",self.driver.find_element(By.ID, "project-machine-name").text),'The machine type is not assigned')
         try:
             self.driver.find_element(By.ID, "change-machine-toggle").click()
-            self.wait_until_visible('#select-machine-form', poll=10)
-            self.wait_until_visible('#cancel-machine-change', poll=10)
+            self.wait_until_visible('#select-machine-form')
+            self.wait_until_visible('#cancel-machine-change')
             self.driver.find_element(By.ID, "cancel-machine-change").click()
         except:
             self.fail(msg='The machine information is wrong in the configuration page')
@@ -148,14 +151,16 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.get(reverse('all-projects'))
         self.wait_until_present('#projectstable', poll=10)
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
-        self.wait_until_present('#config-nav', poll=10)
+        self.wait_until_present('#config-nav')
         project_URL=self.get_URL()
+
+        self.wait_until_visible('#no-most-built')
         self.assertTrue(re.search("You haven't built any recipes yet",self.driver.find_element(By.ID, "no-most-built").text),'Default message of no builds is not present')
         try:
             self.driver.find_element(By.XPATH, "//div[@id='no-most-built']/p/a[@href="+'"'+project_URL+'images/"'+"]").click()
         except:
             self.fail(msg='No Most built information in project detail page')
-        self.wait_until_present('#config-nav', poll=10)
+        self.wait_until_visible('#config-nav')
         self.assertTrue(re.search("Compatible image recipes",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Choose a recipe to build link  is not working  properly')
 
 #   testcase (1519)
@@ -163,7 +168,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.get(reverse('all-projects'))
         self.wait_until_present('#projectstable', poll=10)
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
-        self.wait_until_present('#config-nav', poll=10)
+        self.wait_until_visible('#project-release-title')
         self.assertTrue(re.search("Yocto Project master",self.driver.find_element(By.ID, "project-release-title").text), 'No project release title information in project detail page')
 
 #   testcase (1520)
@@ -171,9 +176,11 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.get(reverse('all-projects'))
         self.wait_until_present('#projectstable', poll=10)
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
-        self.wait_until_present('#config-nav', poll=10)
+        self.wait_until_present('#config-nav')
         project_URL=self.get_URL()
+        self.wait_until_visible('#layer-container')
         self.driver.find_element(By.XPATH, "//div[@id='layer-container']")
+        self.wait_until_visible('#project-layers-count')
         self.assertTrue(re.search("3",self.driver.find_element(By.ID, "project-layers-count").text),'There should be 3 layers listed in the layer count')
 
         try:
@@ -205,18 +212,18 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.get(reverse('all-projects'))
         self.wait_until_present('#projectstable', poll=10)
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
-        self.wait_until_present('#config-nav', poll=10)
+        self.wait_until_present('#config-nav')
         project_URL=self.get_URL()
         self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li[@id='topbar-configuration-tab']/a[@href="+'"'+project_URL+'"'+"]").click()
-        self.wait_until_present('#config-nav', poll=10)
+        self.wait_until_visible('#topbar-configuration-tab')
         self.assertTrue(re.search("Configuration",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li[@id='topbar-configuration-tab']/a[@href="+'"'+project_URL+'"'+"]").text), 'Configuration tab in project topbar is misspelled')
 
         try:
             self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'builds/"'+"]").click()
-            self.wait_until_visible('#project-topbar', poll=10)
         except:
             self.fail(msg='Builds tab information is not present')
 
+        self.wait_until_visible('#project-topbar')
         self.assertTrue(re.search("Builds",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'builds/"'+"]").text), 'Builds tab in project topbar is misspelled')
         try:
             self.driver.find_element(By.XPATH, "//div[@id='empty-state-projectbuildstable']")
@@ -225,9 +232,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 
         try:
             self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'importlayer"'+"]").click()
-            self.wait_until_visible('#project-topbar', poll=10)
         except:
             self.fail(msg='Import layer tab not loading properly')
+
+        self.wait_until_visible('#project-topbar')
         self.assertTrue(re.search("Import layer",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'importlayer"'+"]").text), 'Import layer tab in project topbar is misspelled')
         try:
             self.driver.find_element(By.XPATH, "//fieldset[@id='repo-select']")
@@ -237,9 +245,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 
         try:
             self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'newcustomimage/"'+"]").click()
-            self.wait_until_visible('#project-topbar', poll=10)
         except:
             self.fail(msg='New custom image tab not loading properly')
+
+        self.wait_until_visible('#project-topbar')
         self.assertTrue(re.search("New custom image",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'newcustomimage/"'+"]").text), 'New custom image tab in project topbar is misspelled')
         self.assertTrue(re.search("Select the image recipe you want to customise",self.driver.find_element(By.XPATH, "//div[@class='col-md-12']/h2").text),'The new custom image tab is not loading correctly')
 

