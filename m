Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AF9D1713E
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 09:59:59 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.5143.1729677595888574280
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 02:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=F70YtMlg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so67868365e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677594; x=1730282394; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Du6IyycMlm4fxtNe3ElSIQRjxe5L7G3dyPFdVTs3OX4=;
        b=F70YtMlgBpwL+Sy60FPr35sGSBHqtmFSzU0f1y0eKxa3Mg46F/JWzoS2CwsGyCzQna
         w2/AbOtq+In97y2Qelf71tIbyhM8Y/Nhq82L6r4lKYhDGl6NarAR26+ulO0UmLgeGgD8
         HxnMttCyULBEeF1EqqVYvwd3k+uCl/uzLqdeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677594; x=1730282394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du6IyycMlm4fxtNe3ElSIQRjxe5L7G3dyPFdVTs3OX4=;
        b=FoR/lI7o+K4lR60GsTLN7/L4qo9Vb7RqzM2jr2cXGlRSCHEBg/ta7OcoqD++pifQbD
         yXDq7HUccejCSpySB/MM/UR5n3zvlOe83s6rpQdr9FycGkHd2dfAUw0td6NTC+ag0kk6
         PIAx89Yub1XHoeJeupYQ3at1ZJtOQqSNgvi2pH/89CQHKvkM/PgyWaN6U+PDz2uor1OI
         qIhInCSwauJIx9FNUTMTcWwMNmaeMT7cZQ2Q8R6aUZGZtnkJvk85uKinXlOsme0Fq9pb
         TtKtVlZqcRRCnEv4SgNe1J+0WR1vZSl+vEd0dUzHHbrb2orylt54yqimo0n8QLyMdjHt
         YOmg==
X-Gm-Message-State: AOJu0Ywk1JD4vT3pjGXB0fUR9kNOkL2DCKcWMxVFumv6xslzjZ/q8THJ
	mInVqA2I7JynLk24FmmJFysQGywebAkLbCK5IcRmBlbyRnW4xFNgYnIgv99mznrmEOnHU5Jdav2
	+
X-Google-Smtp-Source: AGHT+IH+sOEUpheMD3o+05mvOts09H9oGKQauhocEvVVFez8lezezi6Y3H7B8o7lHp4H71apq61Xvg==
X-Received: by 2002:a05:600c:1d27:b0:431:58cd:b260 with SMTP id 5b1f17b1804b1-4318418a568mr15978585e9.25.1729677593935;
        Wed, 23 Oct 2024 02:59:53 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 04/28] toaster/tests/project_config: Reuse common project creation code
Date: Wed, 23 Oct 2024 10:59:25 +0100
Message-ID: <20241023095949.3351980-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 09:59:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16695

Switch this test module to use the common project creation code which contains
race fixes. That code requires the database access wrapper be dropped and
we no longer have ordering constraints.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/functional/test_project_config.py   | 50 ++-----------------
 1 file changed, 4 insertions(+), 46 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_config.py b/lib/toaster/tests/functional/test_project_config.py
index dbee36aa4e..41149e5e55 100644
--- a/lib/toaster/tests/functional/test_project_config.py
+++ b/lib/toaster/tests/functional/test_project_config.py
@@ -7,7 +7,6 @@
 #
 
 import string
-import random
 import pytest
 from django.urls import reverse
 from selenium.webdriver import Keys
@@ -18,9 +17,6 @@ from selenium.webdriver.common.by import By
 
 from .utils import get_projectId_from_url
 
-
-@pytest.mark.django_db
-@pytest.mark.order("last")
 class TestProjectConfig(SeleniumFunctionalTestCase):
     project_id = None
     PROJECT_NAME = 'TestProjectConfig'
@@ -28,42 +24,6 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
     INVALID_PATH_CHAR_TEXT = 'The directory path cannot include spaces or ' \
         'any of these characters'
 
-    def _create_project(self, project_name):
-        """ Create/Test new project using:
-          - Project Name: Any string
-          - Release: Any string
-          - Merge Toaster settings: True or False
-        """
-        self.get(reverse('newproject'))
-        self.wait_until_visible('#new-project-name', poll=2)
-        self.find("#new-project-name").send_keys(project_name)
-        select = Select(self.find("#projectversion"))
-        select.select_by_value('3')
-
-        # check merge toaster settings
-        checkbox = self.find('.checkbox-mergeattr')
-        if not checkbox.is_selected():
-            checkbox.click()
-
-        if self.PROJECT_NAME != 'TestProjectConfig':
-            # Reset project name if it's not the default one
-            self.PROJECT_NAME = 'TestProjectConfig'
-
-        self.find("#create-project-button").click()
-
-        try:
-            self.wait_until_visible('#hint-error-project-name', poll=2)
-            url = reverse('project', args=(TestProjectConfig.project_id, ))
-            self.get(url)
-            self.wait_until_visible('#config-nav', poll=3)
-        except TimeoutException:
-            self.wait_until_visible('#config-nav', poll=3)
-
-    def _random_string(self, length):
-        return ''.join(
-            random.choice(string.ascii_letters) for _ in range(length)
-        )
-
     def _get_config_nav_item(self, index):
         config_nav = self.find('#config-nav')
         return config_nav.find_elements(By.TAG_NAME, 'li')[index]
@@ -72,12 +32,10 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
         """ Navigate to project BitBake variables page """
         # check if the menu is displayed
         if TestProjectConfig.project_id is None:
-            self._create_project(project_name=self._random_string(10))
-            current_url = self.driver.current_url
-            TestProjectConfig.project_id = get_projectId_from_url(current_url)
-        else:
-            url = reverse('projectconf', args=(TestProjectConfig.project_id,))
-            self.get(url)
+            TestProjectConfig.project_id = self.create_new_project(self.PROJECT_NAME, '3', None, True)
+
+        url = reverse('projectconf', args=(TestProjectConfig.project_id,))
+        self.get(url)
         self.wait_until_visible('#config-nav', poll=3)
         bbv_page_link = self._get_config_nav_item(9)
         bbv_page_link.click()

