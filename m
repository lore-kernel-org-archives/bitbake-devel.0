Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE74D2C56C
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 09:59:59 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.5144.1729677597562350303
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 02:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZURcfqgF;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so4718534f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677596; x=1730282396; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LedckD95iwBVE2phJ3gNNH1vyjovrnxZWR45dEBd0jo=;
        b=ZURcfqgF5wWlWVgwx/aKVJhIstEOlRkGLUL4C8TJ8mr/gccLiJcQKXwIQloghyyyR9
         t0UGdKdo40h+JLzwbeLuhazD+kbzCbn/JkcZvlndq/w7Xr1Ua14EdyDDoQhvIE2+NHIh
         caS/pHgEvJXsiVaAzbgumyfMwCd9j42pTFS9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677596; x=1730282396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LedckD95iwBVE2phJ3gNNH1vyjovrnxZWR45dEBd0jo=;
        b=X9/U71FAXLuQIm2QQvyoNjunJxCD/p4LYIHj1n0nj00CqdXbH23HpdNuMYiGmVXWnz
         h0Eyu/qCxED4h6jEtfno5ElcoEl0En+zd3FVhxtRh4o7PS8VNOLrAyut/kPjOGwryKHE
         UEi8OCjd8xQZ39P7eSwe92otP/KqDVDLuO8WV3ZJXCkYCbuXSV81fH41RTu37OjPeyVz
         QNl0Lhrv35wPifoONAmMfo/oSj1PQ6MGe9qi4EofMYlLMTz1HYR/N0yXmTJDTooDN+Wl
         RaTVFsFlv1CFkdxNejEcJ+x/M41RKqEuVDRg9wWD9BuW4VXXjzRgGj8IUnqEl3bT42So
         kn+Q==
X-Gm-Message-State: AOJu0YyWD5MJKJ068Fm0GRai6bUOg05C2lbaNwg6G4HK4O8mf2lGBAR+
	zqklDzGKiZQcnhXC8ESVWDDyAJD/gnVdJwPiCIJPNnvONzVBfmGaIuEQxh1Hh1K5caofxrCDS0x
	E
X-Google-Smtp-Source: AGHT+IHtgUcAUPWkMdbAfjNxNFYaq6hBG0CjjvDePiXzs5r9l/peKdbp9q2akfe1a5mYAxJKSQEnXA==
X-Received: by 2002:adf:ea92:0:b0:37d:4956:b0be with SMTP id ffacd0b85a97d-37efcf069b1mr1203236f8f.18.1729677595533;
        Wed, 23 Oct 2024 02:59:55 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 05/28] toaster/tests/function/basic: Improve exception handling for error readability
Date: Wed, 23 Oct 2024 10:59:26 +0100
Message-ID: <20241023095949.3351980-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 09:59:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16696

The 'fail' calls are useful for find() failures but not for wrapping existing asserts
where they hide more useful error messages. Rework the code flow to give more readable
error reporting.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_functional_basic.py | 108 ++++++++++--------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index e2d1c7dd86..a95ce4862c 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -40,44 +40,44 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'customimages/"'+"]").click()
             self.wait_until_present('#config-nav', poll=10)
-            self.assertTrue(re.search("Custom images",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'Custom images information is not loading properly')
         except:
             self.fail(msg='No Custom images tab available')
+        self.assertTrue(re.search("Custom images",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'Custom images information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'images/"'+"]").click()
             self.wait_until_present('#config-nav', poll=10)
-            self.assertTrue(re.search("Compatible image recipes",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible image recipes information is not loading properly')
         except:
             self.fail(msg='No Compatible image tab available')
+        self.assertTrue(re.search("Compatible image recipes",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible image recipes information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'softwarerecipes/"'+"]").click()
             self.wait_until_present('#config-nav', poll=10)
-            self.assertTrue(re.search("Compatible software recipes",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible software recipe information is not loading properly')
         except:
             self.fail(msg='No Compatible software recipe tab available')
+        self.assertTrue(re.search("Compatible software recipes",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible software recipe information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'machines/"'+"]").click()
             self.wait_until_present('#config-nav', poll=10)
-            self.assertTrue(re.search("Compatible machines",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible machine information is not loading properly')
         except:
             self.fail(msg='No Compatible machines tab available')
+        self.assertTrue(re.search("Compatible machines",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible machine information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'layers/"'+"]").click()
             self.wait_until_present('#config-nav', poll=10)
-            self.assertTrue(re.search("Compatible layers",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible layer information is not loading properly')
         except:
             self.fail(msg='No Compatible layers tab available')
+        self.assertTrue(re.search("Compatible layers",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Compatible layer information is not loading properly')
 
         try:
             self.driver.find_element(By.XPATH, "//*[@id='config-nav']/ul/li/a[@href="+'"'+project_URL+'configuration"'+"]").click()
             self.wait_until_present('#config-nav', poll=10)
-            self.assertTrue(re.search("Bitbake variables",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Bitbake variables information is not loading properly')
         except:
             self.fail(msg='No Bitbake variables tab available')
+        self.assertTrue(re.search("Bitbake variables",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Bitbake variables information is not loading properly')
 
 #   testcase (1516)
     def test_review_configuration_information(self):
@@ -86,9 +86,11 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         project_URL=self.get_URL()
         self.wait_until_present('#config-nav', poll=10)
+
+        # Machine section of page
+        self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
+        self.assertTrue(re.search("qemux86-64",self.driver.find_element(By.XPATH, "//span[@id='project-machine-name']").text),'The machine type is not assigned')
         try:
-           self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
-           self.assertTrue(re.search("qemux86-64",self.driver.find_element(By.XPATH, "//span[@id='project-machine-name']").text),'The machine type is not assigned')
            self.driver.find_element(By.XPATH, "//span[@id='change-machine-toggle']").click()
            self.wait_until_visible('#select-machine-form', poll=10)
            self.wait_until_visible('#cancel-machine-change', poll=10)
@@ -96,33 +98,34 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         except:
            self.fail(msg='The machine information is wrong in the configuration page')
 
+        # Most built recipes section
         try:
            self.driver.find_element(By.ID, 'no-most-built')
         except:
            self.fail(msg='No Most built information in project detail page')
 
-        try:
-           self.assertTrue(re.search("Yocto Project master",self.driver.find_element(By.XPATH, "//span[@id='project-release-title']").text),'The project release is not defined')
-        except:
-           self.fail(msg='No project release title information in project detail page')
+        # Project Release title
+        self.assertTrue(re.search("Yocto Project master",self.driver.find_element(By.XPATH, "//span[@id='project-release-title']").text), 'The project release is not defined in the project detail page')
 
+        # List of layers in project
+        self.driver.find_element(By.XPATH, "//div[@id='layer-container']")
+        self.assertTrue(re.search("3",self.driver.find_element(By.ID, "project-layers-count").text),'There should be 3 layers listed in the layer count')
         try:
-           self.driver.find_element(By.XPATH, "//div[@id='layer-container']")
-           self.assertTrue(re.search("3",self.driver.find_element(By.ID, "project-layers-count").text),'There should be 3 layers listed in the layer count')
            layer_list = self.driver.find_element(By.ID, "layers-in-project-list")
            layers = layer_list.find_elements(By.TAG_NAME, "li")
-           for layer in layers:
-               if re.match ("openembedded-core",layer.text):
-                    print ("openembedded-core layer is a default layer in the project configuration")
-               elif re.match ("meta-poky",layer.text):
-                  print ("meta-poky layer is a default layer in the project configuration")
-               elif re.match ("meta-yocto-bsp",layer.text):
-                  print ("meta-yocto-bsp is a default layer in the project configuratoin")
-               else:
-                  self.fail(msg='default layers are missing from the project configuration')
         except:
            self.fail(msg='No Layer information in project detail page')
 
+        for layer in layers:
+            if re.match ("openembedded-core", layer.text):
+                print ("openembedded-core layer is a default layer in the project configuration")
+            elif re.match ("meta-poky", layer.text):
+                 print ("meta-poky layer is a default layer in the project configuration")
+            elif re.match ("meta-yocto-bsp", layer.text):
+                 print ("meta-yocto-bsp is a default layer in the project configuratoin")
+            else:
+                 self.fail(msg='default layers are missing from the project configuration')
+
 #   testcase (1517)
     def test_verify_machine_information(self):
         self.get(reverse('all-projects'))
@@ -130,9 +133,9 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         self.wait_until_present('#config-nav', poll=10)
 
+        self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
+        self.assertTrue(re.search("qemux86-64",self.driver.find_element(By.ID, "project-machine-name").text),'The machine type is not assigned')
         try:
-            self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
-            self.assertTrue(re.search("qemux86-64",self.driver.find_element(By.ID, "project-machine-name").text),'The machine type is not assigned')
             self.driver.find_element(By.ID, "change-machine-toggle").click()
             self.wait_until_visible('#select-machine-form', poll=10)
             self.wait_until_visible('#cancel-machine-change', poll=10)
@@ -147,13 +150,13 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         self.wait_until_present('#config-nav', poll=10)
         project_URL=self.get_URL()
+        self.assertTrue(re.search("You haven't built any recipes yet",self.driver.find_element(By.ID, "no-most-built").text),'Default message of no builds is not present')
         try:
-            self.assertTrue(re.search("You haven't built any recipes yet",self.driver.find_element(By.ID, "no-most-built").text),'Default message of no builds is not present')
             self.driver.find_element(By.XPATH, "//div[@id='no-most-built']/p/a[@href="+'"'+project_URL+'images/"'+"]").click()
-            self.wait_until_present('#config-nav', poll=10)
-            self.assertTrue(re.search("Compatible image recipes",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Choose a recipe to build link  is not working  properly')
         except:
             self.fail(msg='No Most built information in project detail page')
+        self.wait_until_present('#config-nav', poll=10)
+        self.assertTrue(re.search("Compatible image recipes",self.driver.find_element(By.XPATH, "//div[@class='col-md-10']").text),'The Choose a recipe to build link  is not working  properly')
 
 #   testcase (1519)
     def test_verify_project_release_information(self):
@@ -161,11 +164,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.wait_until_present('#projectstable', poll=10)
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         self.wait_until_present('#config-nav', poll=10)
-
-        try:
-            self.assertTrue(re.search("Yocto Project master",self.driver.find_element(By.ID, "project-release-title").text),'The project release is not defined')
-        except:
-            self.fail(msg='No project release title information in project detail page')
+        self.assertTrue(re.search("Yocto Project master",self.driver.find_element(By.ID, "project-release-title").text), 'No project release title information in project detail page')
 
 #   testcase (1520)
     def test_verify_layer_information(self):
@@ -174,28 +173,32 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.find_element_by_link_text_in_table('projectstable', 'selenium-project').click()
         self.wait_until_present('#config-nav', poll=10)
         project_URL=self.get_URL()
+        self.driver.find_element(By.XPATH, "//div[@id='layer-container']")
+        self.assertTrue(re.search("3",self.driver.find_element(By.ID, "project-layers-count").text),'There should be 3 layers listed in the layer count')
+
         try:
-           self.driver.find_element(By.XPATH, "//div[@id='layer-container']")
-           self.assertTrue(re.search("3",self.driver.find_element(By.ID, "project-layers-count").text),'There should be 3 layers listed in the layer count')
            layer_list = self.driver.find_element(By.ID, "layers-in-project-list")
            layers = layer_list.find_elements(By.TAG_NAME, "li")
+        except:
+            self.fail(msg='No Layer information in project detail page')
 
-           for layer in layers:
-               if re.match ("openembedded-core",layer.text):
-                    print ("openembedded-core layer is a default layer in the project configuration")
-               elif re.match ("meta-poky",layer.text):
-                  print ("meta-poky layer is a default layer in the project configuration")
-               elif re.match ("meta-yocto-bsp",layer.text):
-                  print ("meta-yocto-bsp is a default layer in the project configuratoin")
-               else:
-                  self.fail(msg='default layers are missing from the project configuration')
+        for layer in layers:
+            if re.match ("openembedded-core",layer.text):
+                print ("openembedded-core layer is a default layer in the project configuration")
+            elif re.match ("meta-poky",layer.text):
+                print ("meta-poky layer is a default layer in the project configuration")
+            elif re.match ("meta-yocto-bsp",layer.text):
+                print ("meta-yocto-bsp is a default layer in the project configuratoin")
+            else:
+                self.fail(msg='default layers are missing from the project configuration')
 
+        try:
            self.driver.find_element(By.XPATH, "//input[@id='layer-add-input']")
            self.driver.find_element(By.XPATH, "//button[@id='add-layer-btn']")
            self.driver.find_element(By.XPATH, "//div[@id='layer-container']/form[@class='form-inline']/p/a[@id='view-compatible-layers']")
            self.driver.find_element(By.XPATH, "//div[@id='layer-container']/form[@class='form-inline']/p/a[@href="+'"'+project_URL+'importlayer"'+"]")
         except:
-            self.fail(msg='No Layer information in project detail page')
+            self.fail(msg='Layer configuration controls missing')
 
 #   testcase (1521)
     def test_verify_project_detail_links(self):
@@ -211,7 +214,11 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         try:
             self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'builds/"'+"]").click()
             self.wait_until_visible('#project-topbar', poll=10)
-            self.assertTrue(re.search("Builds",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'builds/"'+"]").text), 'Builds tab in project topbar is misspelled')
+        except:
+            self.fail(msg='Builds tab information is not present')
+
+        self.assertTrue(re.search("Builds",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'builds/"'+"]").text), 'Builds tab in project topbar is misspelled')
+        try:
             self.driver.find_element(By.XPATH, "//div[@id='empty-state-projectbuildstable']")
         except:
             self.fail(msg='Builds tab information is not present')
@@ -219,7 +226,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         try:
             self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'importlayer"'+"]").click()
             self.wait_until_visible('#project-topbar', poll=10)
-            self.assertTrue(re.search("Import layer",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'importlayer"'+"]").text), 'Import layer tab in project topbar is misspelled')
+        except:
+            self.fail(msg='Import layer tab not loading properly')
+        self.assertTrue(re.search("Import layer",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'importlayer"'+"]").text), 'Import layer tab in project topbar is misspelled')
+        try:
             self.driver.find_element(By.XPATH, "//fieldset[@id='repo-select']")
             self.driver.find_element(By.XPATH, "//fieldset[@id='git-repo']")
         except:
@@ -228,10 +238,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         try:
             self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'newcustomimage/"'+"]").click()
             self.wait_until_visible('#project-topbar', poll=10)
-            self.assertTrue(re.search("New custom image",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'newcustomimage/"'+"]").text), 'New custom image tab in project topbar is misspelled')
-            self.assertTrue(re.search("Select the image recipe you want to customise",self.driver.find_element(By.XPATH, "//div[@class='col-md-12']/h2").text),'The new custom image tab is not loading correctly')
         except:
             self.fail(msg='New custom image tab not loading properly')
+        self.assertTrue(re.search("New custom image",self.driver.find_element(By.XPATH, "//div[@id='project-topbar']/ul[@class='nav nav-tabs']/li/a[@href="+'"'+project_URL+'newcustomimage/"'+"]").text), 'New custom image tab in project topbar is misspelled')
+        self.assertTrue(re.search("Select the image recipe you want to customise",self.driver.find_element(By.XPATH, "//div[@class='col-md-12']/h2").text),'The new custom image tab is not loading correctly')
 
 
 

