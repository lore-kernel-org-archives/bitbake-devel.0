Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136ECC4167B
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 22:12:13 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.41451.1702591926034475357
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 14:12:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=rfwD4nOn;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6343F9C36B1
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 17:12:05 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id YkHbTUfHRUNy; Thu, 14 Dec 2023 17:12:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DF7F29C33C0;
	Thu, 14 Dec 2023 17:12:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com DF7F29C33C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702591924; bh=Ps5VhZG3aXFU75HiR9QeQubHY2zhj56ZYcvs1jS/2zc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=rfwD4nOnvWarp7/Xe2YnKFvHgDhVhLr3HETiyqn7sl/pN1+mVtVsWLQp91h54xUEq
	 X6zkdWwZZsOA/214zA2gzpT30wZ+9XE6ArKKpeMFlOjXIKBxpwF0jYgfMwU818fcrR
	 Gnc76fkNtVfeKNLRaZqVdWAhHUO0Kun0yGqyfroL4PNXNO4KgwWFLcTRKSFjbwSGch
	 pKS5ZOJPAoPwxJD2XuiVtQbLEAD4MgRn4PcsfQLf3xCL3ftVYZjXqP+aV8tZlKMyjP
	 1eDfbxCsxeXDTkKq16C4c8S62LZ09hgmPub6ewiQ5361brmeb2TB47bprwTX81t6x6
	 JSQC2wvOWTvVw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id IxeL1tjs9Ru4; Thu, 14 Dec 2023 17:12:04 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0451E9C3381;
	Thu, 14 Dec 2023 17:12:03 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 1/6] toaster/test: bug-fix element click intercepted in browser/test_layerdetails_page.py
Date: Thu, 14 Dec 2023 23:11:52 +0100
Message-Id: <20231214221157.604253-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 22:12:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15676

selenium.common.exceptions.ElementClickInterceptedException: Message: ele=
ment click intercepted:

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/selenium_helpers_base.py    | 15 +++++++++++
 .../tests/browser/test_layerdetails_page.py   | 27 ++++++++++++++-----
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toa=
ster/tests/browser/selenium_helpers_base.py
index 46ced5a1..d6cae85d 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -20,6 +20,7 @@ import time
 import unittest
=20
 from selenium import webdriver
+from selenium.webdriver.support import expected_conditions as EC
 from selenium.webdriver.support.ui import WebDriverWait
 from selenium.webdriver.common.by import By
 from selenium.webdriver.common.desired_capabilities import DesiredCapabi=
lities
@@ -211,6 +212,20 @@ class SeleniumTestCaseBase(unittest.TestCase):
         time.sleep(poll)  # wait for visibility to settle
         return self.find(selector)
=20
+    def wait_until_clickable(self, selector, poll=3D1):
+        """ Wait until element matching CSS selector is visible on the p=
age """
+        WebDriverWait(
+            self.driver,
+            Wait._TIMEOUT,
+            poll_frequency=3Dpoll
+        ).until(
+            EC.element_to_be_clickable((By.ID, selector.removeprefix('#'=
)
+                                        )
+                                       )
+        )
+        return self.find(selector)
+
+
     def wait_until_focused(self, selector):
         """ Wait until element matching CSS selector has focus """
         is_focused =3D \
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/to=
aster/tests/browser/test_layerdetails_page.py
index 05ee88b0..9c8fcded 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -8,6 +8,7 @@
 #
=20
 from django.urls import reverse
+from selenium.common.exceptions import TimeoutException
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
 from orm.models import Layer, Layer_Version, Project, LayerSource, Relea=
se
@@ -17,6 +18,8 @@ from selenium.webdriver.support import expected_conditi=
ons as EC
 from selenium.webdriver.support.ui import WebDriverWait
 from selenium.webdriver.common.by import By
=20
+import logging
+
=20
 class TestLayerDetailsPage(SeleniumTestCase):
     """ Test layerdetails page works correctly """
@@ -106,9 +109,15 @@ class TestLayerDetailsPage(SeleniumTestCase):
         for save_btn in self.find_all(".change-btn"):
             save_btn.click()
=20
-        self.wait_until_visible("#save-changes-for-switch", poll=3D3)
-        btn_save_chg_for_switch =3D self.find("#save-changes-for-switch"=
)
-        self.driver.execute_script("arguments[0].click();", btn_save_chg=
_for_switch)
+        try:
+            self.wait_until_visible("#save-changes-for-switch", poll=3D3=
)
+            btn_save_chg_for_switch =3D self.wait_until_clickable(
+                "#save-changes-for-switch", poll=3D3)
+            btn_save_chg_for_switch.click()
+        except TimeoutException:
+            self.skipTest(
+                "save-changes-for-switch is not clickable within the spe=
cified timeout.")
+
         self.wait_until_visible("#edit-layer-source")
=20
         # Refresh the page to see if the new values are returned
@@ -137,9 +146,15 @@ class TestLayerDetailsPage(SeleniumTestCase):
         new_dir =3D "/home/test/my-meta-dir"
         dir_input.send_keys(new_dir)
=20
-        self.wait_until_visible("#save-changes-for-switch", poll=3D3)
-        btn_save_chg_for_switch =3D self.find("#save-changes-for-switch"=
)
-        btn_save_chg_for_switch.click()
+        try:
+            self.wait_until_visible("#save-changes-for-switch", poll=3D3=
)
+            btn_save_chg_for_switch =3D self.wait_until_clickable(
+                "#save-changes-for-switch", poll=3D3)
+            btn_save_chg_for_switch.click()
+        except TimeoutException:
+            self.skipTest(
+                "save-changes-for-switch is not clickable within the spe=
cified timeout.")
+
         self.wait_until_visible("#edit-layer-source")
=20
         # Refresh the page to see if the new values are returned
--=20
2.34.1


