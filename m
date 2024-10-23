Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7AD2E03F
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 09:59:59 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.5142.1729677594902163327
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 02:59:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JHRX2dAI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43163667f0eso50970915e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677593; x=1730282393; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHNOSvxKg5b36CBcYVO15YwQs6pAcJ8WLeVqp6dPNrU=;
        b=JHRX2dAILvVaxnetC4p9vXXbIwsQjSv6C3XUlziSu9wI1rgaiMe9ZJQXXM/tC+KMo9
         rSQqKEDrW2NjkLUWn9l+Z1oPVs9360WmNfuwYXnV46D5f9PNZ34nN2hnfH9QMyrEMFDw
         eKGKpH3HP35M+QCfiJ4UbTVjGn1aBbtlXDpoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677593; x=1730282393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHNOSvxKg5b36CBcYVO15YwQs6pAcJ8WLeVqp6dPNrU=;
        b=VCwwh/UuW1mn7ussDdG6rwXC0sNWDtEngjylS6TFLpKTyPAc/UjvjpCeM0I8kHqQ/Z
         Kxq3NSLXyoRkJcsrGutkJBqWyNIHgvYSqS/vArRZ0obOznL1Ggq0RX0R5fMrFgAWaECk
         W84Z5E0w2HZKljlNuO2/VI1Mvg0YCcUjNQ8o0xkFUYP6mOO/cV/wON9/wkSgy1NQtsFS
         EtPy0uRxOE81UfvnlDGUFbUt1aSoW8SozMKyKQiWJ7i0qpKwXJS4ejgEnAcc+Y/9gpU0
         2vK2p8bvXN7NUAVFgokkb4eZXkP//WxJlOX2TdRUqH0W4ZJ/XR3rQJQYel08C4/Zv2Ad
         /cnw==
X-Gm-Message-State: AOJu0Yz0TWfvli2tJhTXQGKXOyHyShp6Rt+M4Ax/u0P23N9EFgrHkzs4
	qauSVE78Xq1MRtzlRDmPkT/5IQKWEarI9Lu/6bc9jLLqFDyD0CPkLKlCP0kE/t6cp9jqEzCbqOM
	O
X-Google-Smtp-Source: AGHT+IH2NQRsFBAoDuaT7j+jJH/JYcLx1zVuYn6+s8EmvZ7qQdLPSnmB1Dhjaoi3Bdk/fr41HSF0dQ==
X-Received: by 2002:a05:600c:3ca3:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-4318423bb1amr17674335e9.22.1729677592970;
        Wed, 23 Oct 2024 02:59:52 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 03/28] toaster/tests/functional_basic: Reuse common project creation code
Date: Wed, 23 Oct 2024 10:59:24 +0100
Message-ID: <20241023095949.3351980-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 09:59:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16694

Switch this test module to use the common project creation code which contains
race fixes. That code requires the database access wrapper be dropped and
we no longer have ordering constraints.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_functional_basic.py | 22 +------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index e4070fbb88..e2d1c7dd86 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -17,8 +17,6 @@ from selenium.webdriver.common.by import By
 from tests.functional.utils import get_projectId_from_url
 
 
-@pytest.mark.django_db
-@pytest.mark.order("second_to_last")
 class FuntionalTestBasic(SeleniumFunctionalTestCase):
     """Basic functional tests for Toaster"""
     project_id = None
@@ -26,25 +24,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
     def setUp(self):
         super(FuntionalTestBasic, self).setUp()
         if not FuntionalTestBasic.project_id:
-            self._create_slenium_project()
-            current_url = self.driver.current_url
-            FuntionalTestBasic.project_id = get_projectId_from_url(current_url)
-
-#   testcase (1514)
-    def _create_slenium_project(self):
-        project_name = 'selenium-project'
-        self.get(reverse('newproject'))
-        self.wait_until_visible('#new-project-name', poll=3)
-        self.driver.find_element(By.ID, "new-project-name").send_keys(project_name)
-        self.driver.find_element(By.ID, 'projectversion').click()
-        self.driver.find_element(By.ID, "create-project-button").click()
-        element = self.wait_until_visible('#project-created-notification', poll=10)
-        self.assertTrue(self.element_exists('#project-created-notification'),'Project creation notification not shown')
-        self.assertTrue(project_name in element.text,
-                        "New project name not in new project notification")
-        self.assertTrue(Project.objects.filter(name=project_name).count(),
-                        "New project not found in database")
-        return Project.objects.last().id
+            FuntionalTestBasic.project_id = self.create_new_project('selenium-project', '3', None, False)
 
  #  testcase (1515)
     def test_verify_left_bar_menu(self):

