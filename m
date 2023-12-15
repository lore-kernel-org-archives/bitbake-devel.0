Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD762C41535
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 11:24:38 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.60214.1702639475913698507
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Dec 2023 03:24:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=C83mpsIT;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4E04E9C374B
	for <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 06:24:35 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id pLUCJ4wWgto3; Fri, 15 Dec 2023 06:24:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DF4F49C3A2F;
	Fri, 15 Dec 2023 06:24:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com DF4F49C3A2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702639474; bh=SGtttB+55Wge/WosFL8R6rPs4VMhDobvj13hlTAf6bg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=C83mpsITHvZ+1zkXlqN4NMsZMQ4jpwSjL/+fI7kg353g2W1brdmRGnIGsx8VqnntJ
	 HqEmRlBorYsHiXlfQieSopR0HaboY4P3lkIyzUdGC/+1DfKknL6gpPsoEbBWrOg8/a
	 dhyWrguB1D9PENvfdLX7DL9+LuhB4fm7Ix2nyR2FsBE/4dQL9Cabgq5px+Y57q0P8K
	 ToLWSsrDjA838HYrJFoTwvcoH/WVwJ1RiqL7uJlbJ2fIKk4rX0/qqUpafECLYtXPZQ
	 86dAyDob1pRIHcpGaLi3AwZiiTSXAL0FcSMsG+ioo0aR3pCyJ9IrsQWjLNc7W0Tkn0
	 3pppKuEoifRzw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xTVEwh5k3DFh; Fri, 15 Dec 2023 06:24:34 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4522A9C374B;
	Fri, 15 Dec 2023 06:24:34 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/2] toaster/test: Update tests/functional/functional_helpers test_functional_basic
Date: Fri, 15 Dec 2023 12:24:24 +0100
Message-Id: <20231215112424.232168-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215112424.232168-1-alassane.yattara@savoirfairelinux.com>
References: <20231215112424.232168-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 11:24:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15688

- Remove unused import time functional_helpers
- Delay driver actions from test_functional_basic
---
 bitbake/lib/toaster/tests/functional/functional_helpers.py  | 1 -
 .../lib/toaster/tests/functional/test_functional_basic.py   | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/tests/functional/functional_helpers.py b=
/bitbake/lib/toaster/tests/functional/functional_helpers.py
index 6039d736e9..7c20437d14 100644
--- a/bitbake/lib/toaster/tests/functional/functional_helpers.py
+++ b/bitbake/lib/toaster/tests/functional/functional_helpers.py
@@ -11,7 +11,6 @@ import os
 import logging
 import subprocess
 import signal
-import time
 import re
=20
 from tests.browser.selenium_helpers_base import SeleniumTestCaseBase
diff --git a/bitbake/lib/toaster/tests/functional/test_functional_basic.p=
y b/bitbake/lib/toaster/tests/functional/test_functional_basic.py
index 5d7a86bb9b..e48f13b003 100644
--- a/bitbake/lib/toaster/tests/functional/test_functional_basic.py
+++ b/bitbake/lib/toaster/tests/functional/test_functional_basic.py
@@ -89,6 +89,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1516)
     def test_review_configuration_information(self):
         self.get('')
+        self.wait_until_visible('#global-nav')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
@@ -134,6 +135,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1517)
     def test_verify_machine_information(self):
         self.get('')
+        self.wait_until_visible('#global-nav')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
@@ -152,6 +154,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1518)
     def test_verify_most_built_recipes_information(self):
         self.get('')
+        self.wait_until_visible('#global-nav')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
@@ -168,6 +171,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1519)
     def test_verify_project_release_information(self):
         self.get('')
+        self.wait_until_visible('#global-nav')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
@@ -181,6 +185,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1520)
     def test_verify_layer_information(self):
         self.get('')
+        self.wait_until_visible('#global-nav')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
@@ -212,6 +217,7 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
 #   testcase (1521)
     def test_verify_project_detail_links(self):
         self.get('')
+        self.wait_until_visible('#global-nav')
         self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
--=20
2.34.1


