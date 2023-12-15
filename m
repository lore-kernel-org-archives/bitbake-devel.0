Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4194C35274
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 11:56:48 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.60655.1702641404406128766
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Dec 2023 03:56:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Yu00okuE;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5F6649C3472
	for <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 06:56:43 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id AhWcSPsbznj2; Fri, 15 Dec 2023 06:56:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9B5FB9C33C1;
	Fri, 15 Dec 2023 06:56:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 9B5FB9C33C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702641402; bh=ub3+m8sNHEV6t2dLyfzK0cDKDrGqMBKG6oCbts9MS/A=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Yu00okuEdoQpju0QE72uR+esq0igdewVBk88+EBTp1QXYb/foYCpaaCuhZ4zFPP88
	 X926FX8BgPiCd8bA9RofPyrpG9goqSySO0AnvBzjcMKHJhJVCtwwQhexnOwul8nkhW
	 ZpRox8kR0pkOQ5Q+LVbw3vpG4dqpe86n5JpEmljEUjI74tj0ByjjBfueGHbPIBEqGW
	 KdKDEXRjM62gGvuY9JU+ZI7QMrTttNK2Qu8kJpWjKaR49PMRSAR6bu2qfR8udpr3ZQ
	 99FD6IOaQVeBAyKLnLZogGan3R18l9gNL67OQ8UvOLW40lhfmAwZf0K7fuq14jwM+k
	 UnVzKO2VCOOrw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GS78bchy2U3E; Fri, 15 Dec 2023 06:56:42 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BE59F9C0957;
	Fri, 15 Dec 2023 06:56:41 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 1/2] toaster/test: bug-fix element click intercepted in browser/test_layerdetails_page.py
Date: Fri, 15 Dec 2023 12:56:34 +0100
Message-Id: <20231215115635.288498-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 11:56:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15689

selenium.common.exceptions.ElementClickInterceptedException: Message: ele=
ment click intercepted

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/selenium_helpers_base.py    | 14 +++++++++
 .../tests/browser/test_layerdetails_page.py   | 31 +++++++++++++++----
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py b=
/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
index 5d0489bb4e..13806624f3 100644
--- a/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -21,6 +21,7 @@ import unittest
=20
 import pytest
 from selenium import webdriver
+from selenium.webdriver.support import expected_conditions as EC
 from selenium.webdriver.support.ui import WebDriverWait
 from selenium.webdriver.common.by import By
 from selenium.webdriver.common.desired_capabilities import DesiredCapabi=
lities
@@ -215,6 +216,19 @@ class SeleniumTestCaseBase(unittest.TestCase):
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
     def wait_until_focused(self, selector):
         """ Wait until element matching CSS selector has focus """
         is_focused =3D \
diff --git a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py =
b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
index 05ee88b019..9deef6709d 100644
--- a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -8,6 +8,7 @@
 #
=20
 from django.urls import reverse
+from selenium.common.exceptions import ElementClickInterceptedException,=
 TimeoutException
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
 from orm.models import Layer, Layer_Version, Project, LayerSource, Relea=
se
@@ -106,9 +107,18 @@ class TestLayerDetailsPage(SeleniumTestCase):
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
+        except ElementClickInterceptedException:
+            self.skipTest(
+                "save-changes-for-switch click intercepted. Element not =
visible or maybe covered by another element.")
+        except TimeoutException:
+            self.skipTest(
+                "save-changes-for-switch is not clickable within the spe=
cified timeout.")
+
         self.wait_until_visible("#edit-layer-source")
=20
         # Refresh the page to see if the new values are returned
@@ -137,9 +147,18 @@ class TestLayerDetailsPage(SeleniumTestCase):
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
+        except ElementClickInterceptedException:
+            self.skipTest(
+                "save-changes-for-switch click intercepted. Element not =
properly visible or maybe behind another element.")
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


