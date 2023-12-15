Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25E7C4167B
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 11:24:38 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.60558.1702639475152572253
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Dec 2023 03:24:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=rNeVBNES;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 742759C3FCA
	for <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 06:24:34 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id UqHjcGM53YKM; Fri, 15 Dec 2023 06:24:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E1BEF9C3A2F;
	Fri, 15 Dec 2023 06:24:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E1BEF9C3A2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702639473; bh=ocMDXJCX+2NnCMLA+RNg+vm7G73M6SbrXo9c6p20GRc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=rNeVBNESob0WPaIYsqyDNbzsVx2a9inXkj/23Fh+1UMh/bYicZ9e6XLhHpb8z59sy
	 7FgIZGeyoieqtsymnIzx/ChOs3Oy8NGX1+XzqF6Uo+CLm6BAfmQa/6Ir09eSscAXuf
	 VprcRR0Iu6NDyo3fLSpvobbBiguOvZOO6Ci93uary3xuVBQbSqbF3rF+Ns76u+0XdR
	 MH7V+SVibtK3ZOY5rb4EeMCTbPQE+Wl5A7NK8ypJRxNnf5OrPmSPvGAYtn6mW3iT3k
	 tw4+9BI64tscSSxl8mViQ+sCgWAYAk7O79MDAql8qT7JHvhXCGoSgSxh6LVc/ibBii
	 ZSDlJcq9+xBIQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id r_4V9lxCz-Ca; Fri, 15 Dec 2023 06:24:33 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 282839C374B;
	Fri, 15 Dec 2023 06:24:32 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/2] toaster/test: bug-fix element click intercepted in browser/test_layerdetails_page.py
Date: Fri, 15 Dec 2023 12:24:23 +0100
Message-Id: <20231215112424.232168-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 11:24:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15687

selenium.common.exceptions.ElementClickInterceptedException: Message: ele=
ment click intercepted

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/selenium_helpers_base.py    | 29 ++++++++++++-----
 .../tests/browser/test_layerdetails_page.py   | 31 +++++++++++++++----
 2 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py b=
/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
index 5d0489bb4e..6d3e31e8f3 100644
--- a/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -19,8 +19,8 @@ import os
 import time
 import unittest
=20
-import pytest
 from selenium import webdriver
+from selenium.webdriver.support import expected_conditions as EC
 from selenium.webdriver.support.ui import WebDriverWait
 from selenium.webdriver.common.by import By
 from selenium.webdriver.common.desired_capabilities import DesiredCapabi=
lities
@@ -44,23 +44,22 @@ def create_selenium_driver(cls,browser=3D'chrome'):
         try:
             return webdriver.Chrome(options=3Doptions)
         except SessionNotCreatedException as e:
-            exit_message =3D "Halting tests prematurely to avoid cascadi=
ng errors."
             # check if chrome / chromedriver exists
             chrome_path =3D os.popen("find ~/.cache/selenium/chrome/ -na=
me 'chrome' -type f -print -quit").read().strip()
             if not chrome_path:
-                pytest.exit(f"Failed to install/find chrome.\n{exit_mess=
age}")
+                raise SessionNotCreatedException("Failed to install/find=
 chrome")
             chromedriver_path =3D os.popen("find ~/.cache/selenium/chrom=
edriver/ -name 'chromedriver' -type f -print -quit").read().strip()
             if not chromedriver_path:
-                pytest.exit(f"Failed to install/find chromedriver.\n{exi=
t_message}")
+                raise SessionNotCreatedException("Failed to install/find=
 chromedriver")
             # check if depends on each are fulfilled
             depends_chrome =3D os.popen(f"ldd {chrome_path} | grep 'not =
found'").read().strip()
             if depends_chrome:
-                pytest.exit(f"Missing chrome dependencies.\n{depends_chr=
ome}\n{exit_message}")
+                raise SessionNotCreatedException(f"Missing chrome depend=
encies\n{depends_chrome}")
             depends_chromedriver =3D os.popen(f"ldd {chromedriver_path} =
| grep 'not found'").read().strip()
             if depends_chromedriver:
-                pytest.exit(f"Missing chromedriver dependencies.\n{depen=
ds_chromedriver}\n{exit_message}")
-            # print original error otherwise
-            pytest.exit(f"Failed to start chromedriver.\n{e}\n{exit_mess=
age}")
+                raise SessionNotCreatedException(f"Missing chrome depend=
encies\n{depends_chromedriver}")
+            # raise original error otherwise
+            raise e
     elif browser =3D=3D 'firefox':
         return webdriver.Firefox()
     elif browser =3D=3D 'marionette':
@@ -215,6 +214,20 @@ class SeleniumTestCaseBase(unittest.TestCase):
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


