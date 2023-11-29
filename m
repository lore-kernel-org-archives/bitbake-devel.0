Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777EAC10DC2
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.57336.1701298465149356549
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 14:54:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=lfgNhy32;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 853F79C3DF2
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 17:54:24 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id t5AgbRQ4lB5W; Wed, 29 Nov 2023 17:54:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 17AD09C3D7A;
	Wed, 29 Nov 2023 17:54:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 17AD09C3D7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701298464; bh=UBHIQSeMCXE/g1/tLElVuwbXk2tZJpfRPygFGoBUXqA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=lfgNhy32qmx0PBhVWyh3Jqu83xy3D9YfpJwCODVFRqXlLKArVBCfwCtWN1wgyuwyl
	 JefXwNjqavHC/0+GgOWsZgWO4QUFQhQuZmIdWaST8c72fO62naAOnRoa3BAPKEExw3
	 znJubwJbKoXO+RrSvpaEEwR6ZHHDtZyJfqIQmvhfg96Uwe9Xh/Tyh+0hoWkTQZQ/Bx
	 Y50IEMN2PGKn8l9KL1jJ3j7Gc5wnfQWnez/due5SEwmk3+4FC4dvqqPonjY/tjw+SP
	 lca8moNArmgWM9TwHJmE4mqAdHfRXArYPaOvQLNQ6p8yJr7SIO29HE8WVkqfmSsIiO
	 kiJBFIF1fC6wA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id iywIfOGB8rFm; Wed, 29 Nov 2023 17:54:24 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 78CFB9C3679;
	Wed, 29 Nov 2023 17:54:23 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 6/9] toaster/test: Added distro page TestCase
Date: Wed, 29 Nov 2023 23:54:13 +0100
Message-Id: <20231129225416.479526-6-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
References: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 22:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15585

Test distros page
    - Check if title "Compatible distros" is displayed
    - Check search input
    - Check "Add layer" button works
    - Check distro table feature(show/hide column, pagination)

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 47dec1d9..dd33e802 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -644,3 +644,54 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self._navigate_to_config_nav('layerstable', 6)
         # check show rows(pagination)
         self._mixin_test_table_show_rows(table_selector=3D'layerstable')
+
+    def test_distro_page(self):
+        """ Test distros page
+            - Check if title "Compatible distros" is displayed
+            - Check search input
+            - Check "Add layer" button works
+            - Check distro table feature(show/hide column, pagination)
+        """
+        self._navigate_to_config_nav('distrostable', 7)
+        # check title "Compatible distros" is displayed
+        self.assertTrue("Compatible Distros" in self.get_page_source())
+        # Test search input
+        input_text=3D'poky-altcfg'
+        self._mixin_test_table_search_input(
+            input_selector=3D'search-input-distrostable',
+            input_text=3Dinput_text,
+            searchBtn_selector=3D'search-submit-distrostable',
+            table_selector=3D'distrostable'
+        )
+        # check "Add distro" button works
+        rows =3D self.find_all('#distrostable tbody tr')
+        distro_to_add =3D rows[0]
+        add_btn =3D distro_to_add.find_element(
+            By.XPATH,
+            '//td[@class=3D"add-del-layers"]'
+        )
+        add_btn.click()
+        self.wait_until_visible('#change-notification', poll=3D2)
+        change_notification =3D self.find('#change-notification')
+        self.assertTrue(
+            f'You have changed the distro to: {input_text}' in change_no=
tification.text
+        )
+        # check distro table feature(show/hide column, pagination)
+        self._navigate_to_config_nav('distrostable', 7)
+        column_list =3D [
+            'description',
+            'templatefile',
+            'layer_version__get_vcs_reference',
+            'layer_version__layer__name',
+        ]
+        self._mixin_test_table_edit_column(
+            'distrostable',
+            'edit-columns-button',
+            [f'checkbox-{column}' for column in column_list]
+        )
+        self._navigate_to_config_nav('distrostable', 7)
+        # check show rows(pagination)
+        self._mixin_test_table_show_rows(
+            table_selector=3D'distrostable',
+            to_skip=3D[150]
+        )
--=20
2.34.1


