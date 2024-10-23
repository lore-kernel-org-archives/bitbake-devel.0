Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EE0CDDE60
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:44:40 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.5860.1729680278632542313
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:44:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aRkueLhk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso69954935e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729680277; x=1730285077; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNOrilyqfrXRRyd1yNrWv2Qxh7lgfcOmEhXAlkEhOQU=;
        b=aRkueLhkFPuLUNcBJvaOyoYEr1dwSqFY7GSWN9jAutgELIcZi8prcyuvAhpX/sDd9g
         bQQIUS2CUYj8jTo/UJ7eykcsaitnIiufNGAP/Xy9j8apdDeVHEtEbRwuMbrPoz5GJJW7
         8tsIardLS0U9JSdfmLur63LMj7sI/530tTdH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729680277; x=1730285077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNOrilyqfrXRRyd1yNrWv2Qxh7lgfcOmEhXAlkEhOQU=;
        b=SlMTwVlZgtPRs4y9uXj1qTWdHrC1WwNdiNSc0QOArhakC37OnTS3z70OtG2uioLTxN
         k6l+EtpPoHE3TibIpFM1l3jAUtt3syaf/i+6ZFnRBEETxcoaypUHqjihloj3abxM6GEI
         duK64MAwoH9gViAU4IHRhV7jQNTcLM+SJyMQ7tOn8OxGoq+z7VuMbQw+mw6xEDq08gTh
         c25osSMsNoXFqSNGvDCkfsA+6kqqZq5Lye2xnfcG9ippWtrtMVABBENyb+k5xOgVKztM
         slp5A2RDN5JG8XZ+AwKL9NjyUNGx7TwQ37Sibh22/1Qnz+aCEb9QZawIBU23A75ju+0f
         DI2w==
X-Gm-Message-State: AOJu0Yxd8gtsx1Jp9U0PW9koJqQVTuZ3QJcbOdhgkcq3kciphZ68f69L
	cpBLp0YDmzWdIZ00nMiu8H+oL8d0XNcuGwa9UKBmJjFAFHirJ5j7uKBia9E6uxMQnKSG6OTgZxI
	7
X-Google-Smtp-Source: AGHT+IEfws0315TgjHDGGKuTAQCT8d4GMAl/srVrFB+cs4Wc8afkwu+M2m6nv2CofHDKQJSCvcaQHw==
X-Received: by 2002:a05:600c:1c03:b0:431:5533:8f0d with SMTP id 5b1f17b1804b1-4318424ea29mr20942085e9.30.1729680276490;
        Wed, 23 Oct 2024 03:44:36 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c15684sm12661045e9.39.2024.10.23.03.44.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:44:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster/tests/functional: Improve project creation tests
Date: Wed, 23 Oct 2024 11:44:34 +0100
Message-ID: <20241023104434.3371528-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:44:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16720

Mixing database access and access via a running server is fraught with
danger and problems. The "django_db" marker means the transactions are
dropped at the end of the test but the transactions made via the webapi
remain so the database ends up confused at best.

Drop the database accesses and use the server API. This means slightly
abusing the typeahead to get lists of projects in the database.

Add code to delete a project if it already exists. This allows tests
to re-run against an existing database. Deletion is done using the
server API but this means handling CSRF tokens.

Add requests module requirement to requirements file since the project
creation code now uses requests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../functional/test_create_new_project.py     | 28 +++++++++++++------
 .../tests/toaster-tests-requirements.txt      |  2 ++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index f7d17847ae..577ca7239d 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -8,15 +8,12 @@
 
 import re
 import pytest
+import requests
 from django.urls import reverse
 from selenium.webdriver.support.select import Select
 from tests.functional.functional_helpers import SeleniumFunctionalTestCase
-from orm.models import Project
 from selenium.webdriver.common.by import By
 
-
-@pytest.mark.django_db
-@pytest.mark.order("last")
 class TestCreateNewProject(SeleniumFunctionalTestCase):
 
     def _create_test_new_project(
@@ -31,6 +28,20 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
           - Release: Any string
           - Merge Toaster settings: True or False
         """
+
+        # Obtain a CSRF token from a suitable URL
+        projs = requests.get(self.live_server_url + reverse('newproject'))
+        csrftoken = projs.cookies.get('csrftoken')
+
+        # Use the projects typeahead to find out if the project already exists
+        req = requests.get(self.live_server_url + reverse('xhr_projectstypeahead'), {'search': project_name, 'format' : 'json'})
+        data = req.json()
+        # Delete any existing projects
+        for result in data['results']:
+            del_url = reverse('xhr_project', args=(result['id'],))
+            del_response = requests.delete(self.live_server_url + del_url, cookies={'csrftoken': csrftoken}, headers={'X-CSRFToken': csrftoken})
+            self.assertEqual(del_response.status_code, 200)
+
         self.get(reverse('newproject'))
         self.wait_until_visible('#new-project-name', poll=3)
         self.driver.find_element(By.ID,
@@ -59,10 +70,11 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
             project_name in element.text,
             f"New project name:{project_name} not in new project notification"
         )
-        self.assertTrue(
-            Project.objects.filter(name=project_name).count(),
-            f"New project:{project_name} not found in database"
-        )
+
+        # Use the projects typeahead again to check the project now exists
+        req = requests.get(self.live_server_url + reverse('xhr_projectstypeahead'), {'search': project_name, 'format' : 'json'})
+        data = req.json()
+        self.assertGreater(len(data['results']), 0, f"New project:{project_name} not found in database")
 
         # check release
         self.assertTrue(re.search(
diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toaster/tests/toaster-tests-requirements.txt
index 71cc083436..6243c00a36 100644
--- a/lib/toaster/tests/toaster-tests-requirements.txt
+++ b/lib/toaster/tests/toaster-tests-requirements.txt
@@ -5,3 +5,5 @@ pytest-env==1.1.0
 pytest-html==4.0.2
 pytest-metadata==3.0.0
 pytest-order==1.1.0
+requests
+

