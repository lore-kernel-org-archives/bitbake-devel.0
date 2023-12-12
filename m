Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4051C41535
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 14:17:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.2658.1702390649170810303
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Dec 2023 06:17:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=B23S1oLa;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7583F9C3279
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 09:17:28 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id sXvPTfLkNCwW; Tue, 12 Dec 2023 09:17:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8A2389C3672;
	Tue, 12 Dec 2023 09:17:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8A2389C3672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702390646; bh=8Ki5GrCQZ3KBQPZZM6sfbXpKH1jrTwhrBdCjwg3VWm8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=B23S1oLaPu01woKWpJJkKil5KaPJql4McgauJZFb221R3LFK2wu286SJ0IdtQtkA7
	 GC3Mx2MHbWUFQscHyte8qyJArC0JOk/+iTT4U6km/ht7glkS/wRmzF94WkHYlexIqw
	 8DC7//ItS/V9dx+IphUhTMRWhgw2QuuM4GXAB+QRbhPc8ma3nfk4O6DXbciHYZIsNH
	 qy0sV6yn8IX4V2d5cbAArCl0FobqHw7WAdd23gj2B2sd13cleZzPHoBD8Hjpl+De3A
	 Aw2KguDhuDFePmg45juyIYaS8iEj4qaWyWfoPU8/CoUqhdE6wYFGJ4DV0grnid9ahs
	 8+bZqKtZO/i8w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id G4sKEcDxYq3g; Tue, 12 Dec 2023 09:17:26 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AD01A9C354B;
	Tue, 12 Dec 2023 09:17:25 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/4] toaster/test: Fixes functional tests warning on autobuilder
Date: Tue, 12 Dec 2023 15:17:08 +0100
Message-Id: <20231212141708.19395-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com>
References: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 14:17:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15654

tests/functional/test_project_config.py::TestProjectConfig::test_set_down=
load_dir
  /home/pokybuild/yocto-worker/toaster/build/buildtools/sysroots/x86_64-p=
okysdk-linux/usr/lib/python3.11/unittest/case.py:678: DeprecationWarning:=
 It is deprecated to return a value that is not None from a test case (<b=
ound method TestProjectConfig.test_set_download_dir of <toaster.tests.fun=
ctional.test_project_config.TestProjectConfig testMethod=3Dtest_set_downl=
oad_dir>>)
    return self.run(*args, **kwds)

tests/functional/test_project_config.py::TestProjectConfig::test_set_ssta=
te_dir
  /home/pokybuild/yocto-worker/toaster/build/buildtools/sysroots/x86_64-p=
okysdk-linux/usr/lib/python3.11/unittest/case.py:678: DeprecationWarning:=
 It is deprecated to return a value that is not None from a test case (<b=
ound method TestProjectConfig.test_set_sstate_dir of <toaster.tests.funct=
ional.test_project_config.TestProjectConfig testMethod=3Dtest_set_sstate_=
dir>>)
    return self.run(*args, **kwds)

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_config.py   | 164 +++++++++---------
 1 file changed, 85 insertions(+), 79 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_config.py b/lib/to=
aster/tests/functional/test_project_config.py
index 2d162d81..dbee36aa 100644
--- a/lib/toaster/tests/functional/test_project_config.py
+++ b/lib/toaster/tests/functional/test_project_config.py
@@ -163,51 +163,53 @@ class TestProjectConfig(SeleniumFunctionalTestCase)=
:
             change_dl_dir_btn =3D self.wait_until_visible('#change-dl_di=
r-icon', poll=3D2)
         except TimeoutException:
             # If download dir is not displayed, test is skipped
-            return True
-        change_dl_dir_btn =3D self.wait_until_visible('#change-dl_dir-ic=
on', poll=3D2)
-        change_dl_dir_btn.click()
+            change_dl_dir_btn =3D None
=20
-        # downloads dir path doesn't start with / or ${...}
-        input_field =3D self.wait_until_visible('#new-dl_dir', poll=3D2)
-        input_field.clear()
-        self.enter_text('#new-dl_dir', 'home/foo')
-        element =3D self.wait_until_visible('#hintError-initialChar-dl_d=
ir', poll=3D2)
+        if change_dl_dir_btn:
+            change_dl_dir_btn =3D self.wait_until_visible('#change-dl_di=
r-icon', poll=3D2)
+            change_dl_dir_btn.click()
+
+            # downloads dir path doesn't start with / or ${...}
+            input_field =3D self.wait_until_visible('#new-dl_dir', poll=3D=
2)
+            input_field.clear()
+            self.enter_text('#new-dl_dir', 'home/foo')
+            element =3D self.wait_until_visible('#hintError-initialChar-=
dl_dir', poll=3D2)
=20
-        msg =3D 'downloads directory path starts with invalid character =
but ' \
-            'treated as valid'
-        self.assertTrue((self.INVALID_PATH_START_TEXT in element.text), =
msg)
+            msg =3D 'downloads directory path starts with invalid charac=
ter but ' \
+                'treated as valid'
+            self.assertTrue((self.INVALID_PATH_START_TEXT in element.tex=
t), msg)
=20
-        # downloads dir path has a space
-        self.driver.find_element(By.ID, 'new-dl_dir').clear()
-        self.enter_text('#new-dl_dir', '/foo/bar a')
+            # downloads dir path has a space
+            self.driver.find_element(By.ID, 'new-dl_dir').clear()
+            self.enter_text('#new-dl_dir', '/foo/bar a')
=20
-        element =3D self.wait_until_visible('#hintError-dl_dir', poll=3D=
2)
-        msg =3D 'downloads directory path characters invalid but treated=
 as valid'
-        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
+            element =3D self.wait_until_visible('#hintError-dl_dir', pol=
l=3D2)
+            msg =3D 'downloads directory path characters invalid but tre=
ated as valid'
+            self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text=
), msg)
=20
-        # downloads dir path starts with ${...} but has a space
-        self.driver.find_element(By.ID,'new-dl_dir').clear()
-        self.enter_text('#new-dl_dir', '${TOPDIR}/down foo')
+            # downloads dir path starts with ${...} but has a space
+            self.driver.find_element(By.ID,'new-dl_dir').clear()
+            self.enter_text('#new-dl_dir', '${TOPDIR}/down foo')
=20
-        element =3D self.wait_until_visible('#hintError-dl_dir', poll=3D=
2)
-        msg =3D 'downloads directory path characters invalid but treated=
 as valid'
-        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
+            element =3D self.wait_until_visible('#hintError-dl_dir', pol=
l=3D2)
+            msg =3D 'downloads directory path characters invalid but tre=
ated as valid'
+            self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text=
), msg)
=20
-        # downloads dir path starts with /
-        self.driver.find_element(By.ID,'new-dl_dir').clear()
-        self.enter_text('#new-dl_dir', '/bar/foo')
+            # downloads dir path starts with /
+            self.driver.find_element(By.ID,'new-dl_dir').clear()
+            self.enter_text('#new-dl_dir', '/bar/foo')
=20
-        hidden_element =3D self.driver.find_element(By.ID,'hintError-dl_=
dir')
-        self.assertEqual(hidden_element.is_displayed(), False,
-            'downloads directory path valid but treated as invalid')
+            hidden_element =3D self.driver.find_element(By.ID,'hintError=
-dl_dir')
+            self.assertEqual(hidden_element.is_displayed(), False,
+                'downloads directory path valid but treated as invalid')
=20
-        # downloads dir path starts with ${...}
-        self.driver.find_element(By.ID,'new-dl_dir').clear()
-        self.enter_text('#new-dl_dir', '${TOPDIR}/down')
+            # downloads dir path starts with ${...}
+            self.driver.find_element(By.ID,'new-dl_dir').clear()
+            self.enter_text('#new-dl_dir', '${TOPDIR}/down')
=20
-        hidden_element =3D self.driver.find_element(By.ID,'hintError-dl_=
dir')
-        self.assertEqual(hidden_element.is_displayed(), False,
-            'downloads directory path valid but treated as invalid')
+            hidden_element =3D self.driver.find_element(By.ID,'hintError=
-dl_dir')
+            self.assertEqual(hidden_element.is_displayed(), False,
+                'downloads directory path valid but treated as invalid')
=20
     def test_set_sstate_dir(self):
         """
@@ -217,53 +219,57 @@ class TestProjectConfig(SeleniumFunctionalTestCase)=
:
         self._navigate_bbv_page()
=20
         try:
-            self.wait_until_visible('#change-sstate_dir-icon', poll=3D2)
+            btn_chg_sstate_dir =3D self.wait_until_visible(
+                '#change-sstate_dir-icon',
+                poll=3D2
+            )
             self.click('#change-sstate_dir-icon')
         except TimeoutException:
             # If sstate_dir is not displayed, test is skipped
-            return True
-
-        # path doesn't start with / or ${...}
-        input_field =3D self.wait_until_visible('#new-sstate_dir', poll=3D=
2)
-        input_field.clear()
-        self.enter_text('#new-sstate_dir', 'home/foo')
-        element =3D self.wait_until_visible('#hintError-initialChar-ssta=
te_dir', poll=3D2)
-
-        msg =3D 'sstate directory path starts with invalid character but=
 ' \
-            'treated as valid'
-        self.assertTrue((self.INVALID_PATH_START_TEXT in element.text), =
msg)
-
-        # path has a space
-        self.driver.find_element(By.ID, 'new-sstate_dir').clear()
-        self.enter_text('#new-sstate_dir', '/foo/bar a')
-
-        element =3D self.wait_until_visible('#hintError-sstate_dir', pol=
l=3D2)
-        msg =3D 'sstate directory path characters invalid but treated as=
 valid'
-        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
-
-        # path starts with ${...} but has a space
-        self.driver.find_element(By.ID,'new-sstate_dir').clear()
-        self.enter_text('#new-sstate_dir', '${TOPDIR}/down foo')
-
-        element =3D self.wait_until_visible('#hintError-sstate_dir', pol=
l=3D2)
-        msg =3D 'sstate directory path characters invalid but treated as=
 valid'
-        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
-
-        # path starts with /
-        self.driver.find_element(By.ID,'new-sstate_dir').clear()
-        self.enter_text('#new-sstate_dir', '/bar/foo')
-
-        hidden_element =3D self.driver.find_element(By.ID, 'hintError-ss=
tate_dir')
-        self.assertEqual(hidden_element.is_displayed(), False,
-            'sstate directory path valid but treated as invalid')
-
-        # paths starts with ${...}
-        self.driver.find_element(By.ID, 'new-sstate_dir').clear()
-        self.enter_text('#new-sstate_dir', '${TOPDIR}/down')
-
-        hidden_element =3D self.driver.find_element(By.ID, 'hintError-ss=
tate_dir')
-        self.assertEqual(hidden_element.is_displayed(), False,
-            'sstate directory path valid but treated as invalid')
+            btn_chg_sstate_dir =3D None
+
+        if btn_chg_sstate_dir:  # Skip continuation if sstate_dir is not=
 displayed
+            # path doesn't start with / or ${...}
+            input_field =3D self.wait_until_visible('#new-sstate_dir', p=
oll=3D2)
+            input_field.clear()
+            self.enter_text('#new-sstate_dir', 'home/foo')
+            element =3D self.wait_until_visible('#hintError-initialChar-=
sstate_dir', poll=3D2)
+
+            msg =3D 'sstate directory path starts with invalid character=
 but ' \
+                'treated as valid'
+            self.assertTrue((self.INVALID_PATH_START_TEXT in element.tex=
t), msg)
+
+            # path has a space
+            self.driver.find_element(By.ID, 'new-sstate_dir').clear()
+            self.enter_text('#new-sstate_dir', '/foo/bar a')
+
+            element =3D self.wait_until_visible('#hintError-sstate_dir',=
 poll=3D2)
+            msg =3D 'sstate directory path characters invalid but treate=
d as valid'
+            self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text=
), msg)
+
+            # path starts with ${...} but has a space
+            self.driver.find_element(By.ID,'new-sstate_dir').clear()
+            self.enter_text('#new-sstate_dir', '${TOPDIR}/down foo')
+
+            element =3D self.wait_until_visible('#hintError-sstate_dir',=
 poll=3D2)
+            msg =3D 'sstate directory path characters invalid but treate=
d as valid'
+            self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text=
), msg)
+
+            # path starts with /
+            self.driver.find_element(By.ID,'new-sstate_dir').clear()
+            self.enter_text('#new-sstate_dir', '/bar/foo')
+
+            hidden_element =3D self.driver.find_element(By.ID, 'hintErro=
r-sstate_dir')
+            self.assertEqual(hidden_element.is_displayed(), False,
+                'sstate directory path valid but treated as invalid')
+
+            # paths starts with ${...}
+            self.driver.find_element(By.ID, 'new-sstate_dir').clear()
+            self.enter_text('#new-sstate_dir', '${TOPDIR}/down')
+
+            hidden_element =3D self.driver.find_element(By.ID, 'hintErro=
r-sstate_dir')
+            self.assertEqual(hidden_element.is_displayed(), False,
+                'sstate directory path valid but treated as invalid')
=20
     def _change_bbv_value(self, **kwargs):
         var_name, field, btn_id, input_id, value, save_btn, *_ =3D kwarg=
s.values()
--=20
2.34.1


