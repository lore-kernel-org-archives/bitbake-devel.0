Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE0D1AD45
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 08:31:23 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.44435.1729153874678372096
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Oct 2024 01:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SHkqOJ70;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431137d12a5so7076405e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Oct 2024 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729153873; x=1729758673; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1612T9S4cWNbUQ+V7nnJouNRArZbQCsTUS+vOG3N/+Q=;
        b=SHkqOJ70tG4CSi2rTBMK7TvEz/s2tVlMuKKMuv9dYpb/YuShUDJchUsssat4ptpBYT
         yucED+VspymL5GARVrWgj+bkacnAgx893DGDDTHEExRQA2pRngGMpS+i6hDPys9Npktu
         o6wat+iYeybS8r8FRy2EaD/ODVsTvnCitqQsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729153873; x=1729758673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1612T9S4cWNbUQ+V7nnJouNRArZbQCsTUS+vOG3N/+Q=;
        b=SJELNUx/+mkHM3caOL9enuDNWADPsPIcuGGxGa2ak5ApQ2qRUyFXBYdi+TfsnLWgib
         hZjP8p4MARAbdE5xE1guJ3uh81wVFwO+jFz3/cSeolR8kjZgjn1WgRwutwQORtztR8LH
         O00yUUrOmC0GYVlwfLq7BoKXSATmgx87ch2Vn0hFjgigbw27Gr/TMz9g0rxN2QYYwcGt
         a2rYOO4NKyeoeZqBhuLluHaW+3VURrVYTsYxGPTyuPZwU1UTLbldpRxh2J4byfJ5EFEP
         /Zd5EQkdVVMuR2XJE6ELC1gpS0g/pkHMROA+cqeB64nuB/48G40utE7gBDMbDDYO0+Y+
         qlvA==
X-Gm-Message-State: AOJu0Ywn8mk4bt3dscDrhz1KufUZocrpdCZ4toLMlfGIrZgG++eZ0NYM
	nrImhEavFg6GLLNA81uYgryD1MoQb4hIq7v2ycKO2EcSn7nRn7Y/4KH3VWmWixF1w/VtPFdEvjg
	0
X-Google-Smtp-Source: AGHT+IGKnB+vT7CVi4By/GLx+bTRMvc1e5+gtoUi7GwOYI5F1T2KEszf8E6t/kYh+ZTayqRuqrr3uw==
X-Received: by 2002:a05:600c:4895:b0:431:5043:87c3 with SMTP id 5b1f17b1804b1-43150438cffmr44075595e9.22.1729153872608;
        Thu, 17 Oct 2024 01:31:12 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9bb:752a:967d:580d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a04asm6522192f8f.8.2024.10.17.01.31.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:31:12 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster/tests/functional: Improve project creation tests
Date: Thu, 17 Oct 2024 09:31:11 +0100
Message-ID: <20241017083111.2130049-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Oct 2024 08:31:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16690

Mixing database access and access via a running server is fraught with
danger and problems. The "django_db" marker means the transactions are
dropped at the end of the test but the transactions made via the webapi
remain so the database ends up confused at best.

Drop the database accesses and use the server API. This means slightly
abusing the typeahead to get lists of projects in the database.

Add code to delete a project if it already exists. This allows tests
to re-run against an existing database. Deletion is done using the
server API but this means handling CSRF tokens.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../functional/test_create_new_project.py     | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index f7d17847ae..f3eb28b22a 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -6,17 +6,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import re
+import json
 import pytest
+import re
+import requests
 from django.urls import reverse
 from selenium.webdriver.support.select import Select
 from tests.functional.functional_helpers import SeleniumFunctionalTestCase
 from orm.models import Project
 from selenium.webdriver.common.by import By
 
-
-@pytest.mark.django_db
-@pytest.mark.order("last")
 class TestCreateNewProject(SeleniumFunctionalTestCase):
 
     def _create_test_new_project(
@@ -31,6 +30,20 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
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
@@ -59,10 +72,11 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
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

