Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09C6C4167B
	for <webhook@archiver.kernel.org>; Sat,  9 Dec 2023 10:04:13 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.6947.1702116251304904358
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 09 Dec 2023 02:04:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FTzsX2+O;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c09f4bea8so31212185e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 09 Dec 2023 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702116249; x=1702721049; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPAFWHYQg514HqFW7HbjOS5M5Wy+1c1VZB7kbApZW6s=;
        b=FTzsX2+OcIrYibKXy+KewM0xN8N4jF2v1SmeFxkIGkX89cqKGdDv6IGDM5SVB6SRyd
         fAMbqr4RKBSC1bBv0uUfmYWUW2w1pkYTWavcDzAaNukHJWQHgpCrKtJzL+jMFHMitd3P
         vOV1MFiDTIFFsKXUnqGm1XAHo5knYKnX5wP74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702116249; x=1702721049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPAFWHYQg514HqFW7HbjOS5M5Wy+1c1VZB7kbApZW6s=;
        b=Q4Fxwfd/YyFg7Mt8q4tm1o4+4K00Nst9mltEW7rKAEGUXpCP85x1vxugcDTKMetLnw
         xg/6Uf5iLoy9NA88KMYJFGJlqikpewjIbpxD2wOUFwlb027Q0Aqp7XxFhziMdwu7wX94
         jO8D2+G3bSrjF+hGNuVPjrA15nyNGu1jyhgQAtoqnyxIK8nhOFN7ogdAJQNTrBiveG+0
         r9YRBk1jSfZLM8BzDuWNhafmiq9vvf38UAQMNQbmjwPJHcKzzieB+HXBDqJcoMYXQdA+
         q/GfAzXpVJKt8AHj5h7SYgXtOKkSKYF4tBB5M2DlL2xXg7USQon7shz3bNvAvzg+Iuu5
         QUYA==
X-Gm-Message-State: AOJu0Yz32c41aFlgtNoVlJJdo8iZbp/ATo9qbY7YbY2NGSlGboxyB095
	WPSSKDArx4AaojtHrTg0v0nRK+0+UZnKhqqSxhk=
X-Google-Smtp-Source: AGHT+IHG3KmNqgMK5vc10yRgMtlzI4h5mEqjK89fXhc5hYI6TeGd1rvbt+iLSuX8zEz95I5sPXDuCw==
X-Received: by 2002:a05:600c:22d0:b0:40c:258d:2f01 with SMTP id 16-20020a05600c22d000b0040c258d2f01mr685226wmg.105.1702116249221;
        Sat, 09 Dec 2023 02:04:09 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:30e:3cdc:729a:15fb])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d48cd000000b0033609750752sm3565550wrs.8.2023.12.09.02.04.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:04:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] toaster: Update to use qemux86-64 machine by default
Date: Sat,  9 Dec 2023 10:04:07 +0000
Message-Id: <20231209100408.2187723-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 Dec 2023 10:04:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15642

Toaster currently uses qemux86 as the default, update to match the
local.conf default changes, i.e. qemux86-64.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/fixtures/settings.xml                     | 2 +-
 lib/toaster/tests/functional/test_functional_basic.py     | 4 ++--
 .../toastergui/fixtures/toastergui-unittest-data.xml      | 8 ++++----
 lib/toaster/toastergui/views.py                           | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/orm/fixtures/settings.xml b/lib/toaster/orm/fixtures/settings.xml
index ab3ea021f5..02c26a6974 100644
--- a/lib/toaster/orm/fixtures/settings.xml
+++ b/lib/toaster/orm/fixtures/settings.xml
@@ -12,7 +12,7 @@
   </object>
   <object model="orm.toastersetting" pk="4">
     <field type="CharField" name="name">DEFCONF_MACHINE</field>
-    <field type="CharField" name="value">qemux86</field>
+    <field type="CharField" name="value">qemux86-64</field>
   </object>
   <object model="orm.toastersetting" pk="5">
     <field type="CharField" name="name">DEFCONF_SSTATE_DIR</field>
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index f558cce884..dcd84c3f64 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -93,7 +93,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         time.sleep(2)
         try:
            self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
-           self.assertTrue(re.search("qemux86",self.driver.find_element(By.XPATH, "//span[@id='project-machine-name']").text),'The machine type is not assigned')
+           self.assertTrue(re.search("qemux86-64",self.driver.find_element(By.XPATH, "//span[@id='project-machine-name']").text),'The machine type is not assigned')
            self.driver.find_element(By.XPATH, "//span[@id='change-machine-toggle']").click()
            time.sleep(2)
            self.wait_until_visible('#select-machine-form')
@@ -140,7 +140,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 
         try:
             self.assertTrue(self.element_exists('#machine-section'),'Machine section for the project configuration page does not exist')
-            self.assertTrue(re.search("qemux86",self.driver.find_element(By.ID, "project-machine-name").text),'The machine type is not assigned')
+            self.assertTrue(re.search("qemux86-64",self.driver.find_element(By.ID, "project-machine-name").text),'The machine type is not assigned')
             self.driver.find_element(By.ID, "change-machine-toggle").click()
             time.sleep(2)
             self.wait_until_visible('#select-machine-form')
diff --git a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
index df106934b2..f626572fd1 100644
--- a/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
+++ b/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
@@ -46,12 +46,12 @@
   <object pk="1" model="orm.ProjectVariable">
     <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
     <field type="CharField" name="name">MACHINE</field>
-    <field type="TextField" name="value">qemux86</field>
+    <field type="TextField" name="value">qemux86-64</field>
   </object>
   <object pk="2" model="orm.ProjectVariable">
     <field to="orm.project" name="project" rel="ManyToOneRel">2</field>
     <field type="CharField" name="name">MACHINE</field>
-    <field type="TextField" name="value">qemux86</field>
+    <field type="TextField" name="value">qemux86-64</field>
   </object>
   <object pk="1" model="orm.build">
     <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
@@ -79,7 +79,7 @@
   </object>
   <object pk="3" model="orm.build">
     <field to="orm.project" name="project" rel="ManyToOneRel">1</field>
-    <field type="CharField" name="machine">qemux86</field>
+    <field type="CharField" name="machine">qemux86-64</field>
     <field type="CharField" name="distro"></field>
     <field type="CharField" name="distro_version"></field>
     <field type="DateTimeField" name="started_on">2016-02-12T18:46:20.114530+00:00</field>
@@ -91,7 +91,7 @@
   </object>
   <object pk="4" model="orm.build">
     <field to="orm.project" name="project" rel="ManyToOneRel">2</field>
-    <field type="CharField" name="machine">qemux86</field>
+    <field type="CharField" name="machine">qemux86-64</field>
     <field type="CharField" name="distro"></field>
     <field type="CharField" name="distro_version"></field>
     <field type="DateTimeField" name="started_on">2016-02-11T18:46:20.114530+00:00</field>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index cc8517ba6c..735d304ad8 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1610,7 +1610,7 @@ if True:
         # make sure we have a machine set for this project
         ProjectVariable.objects.get_or_create(project=new_project,
                                               name="MACHINE",
-                                              value="qemux86")
+                                              value="qemux86-64")
         context = {'project': new_project}
         return toaster_render(request, "js-unit-tests.html", context)
 
-- 
2.39.2


