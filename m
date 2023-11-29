Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD5C46CA7
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.57414.1701298464446691616
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 14:54:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=bP6qjqnd;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CC4D09C3E05
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 17:54:23 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id V5X9Gny8ovpW; Wed, 29 Nov 2023 17:54:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4E07C9C341E;
	Wed, 29 Nov 2023 17:54:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4E07C9C341E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701298463; bh=DJjjmynIxSsqTWnVYlm6f+bQMdmPUpF+Kg4n0PZa8XI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=bP6qjqnd6jOFts54zS205N2hPIDrUozaqPaZHOeQKTdeI6NZfwFbY1ddRLhD6NI2x
	 kinoi7hXzL/PYKFVAoe/bOK36G5uJ+2U1vWuHFJCe/VoVzCp9ZOZsxz1dRbCDCcC+n
	 frUM67vyPKOXqQ+K3VIolyEH9ZvzasdHUZqgveqTyOJbU1WOTNRYWAhgvmlDhW3r02
	 8jIRV96jUY8Eid0qCwUNW9EJw0F+HvCeIofoeUJka5FjEI3SvhCadZ8/vTFAai44Qk
	 w7IYEuc4FlmwKz2W95EI7JMlrovByXVAGfa6RSjdxO3Mw6SL2Rc4OUdFxgO2XBKU16
	 odqLAoOypzTow==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LMNfMVzvAB4f; Wed, 29 Nov 2023 17:54:23 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B37539C3D7A;
	Wed, 29 Nov 2023 17:54:22 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 5/9] toaster/test: Added Layers page TestCase
Date: Wed, 29 Nov 2023 23:54:12 +0100
Message-Id: <20231129225416.479526-5-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
References: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 22:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15584

Test layers page
    - Check if title "Compatible layerss" is displayed
    - Check search input
    - Check "Add layer" button works
    - Check "Remove layer" button works
    - Check layers table feature(show/hide column, pagination)

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 46a60c01..47dec1d9 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -572,3 +572,75 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self._navigate_to_config_nav('machinestable', 5)
         # check show rows(pagination)
         self._mixin_test_table_show_rows(table_selector=3D'machinestable=
')
+
+    def test_layers_page(self):
+        """ Test layers page
+            - Check if title "Compatible layerss" is displayed
+            - Check search input
+            - Check "Add layer" button works
+            - Check "Remove layer" button works
+            - Check layers table feature(show/hide column, pagination)
+        """
+        self._navigate_to_config_nav('layerstable', 6)
+        # check title "Compatible layers" is displayed
+        self.assertTrue("Compatible layers" in self.get_page_source())
+        # Test search input
+        input_text=3D'meta-tanowrt'
+        self._mixin_test_table_search_input(
+            input_selector=3D'search-input-layerstable',
+            input_text=3Dinput_text,
+            searchBtn_selector=3D'search-submit-layerstable',
+            table_selector=3D'layerstable'
+        )
+        # check "Add layer" button works
+        rows =3D self.find_all('#layerstable tbody tr')
+        layer_to_add =3D rows[0]
+        add_btn =3D layer_to_add.find_element(
+            By.XPATH,
+            '//td[@class=3D"add-del-layers"]'
+        )
+        add_btn.click()
+        # check modal is displayed
+        self.wait_until_visible('#dependencies-modal')
+        list_dependencies =3D self.find_all('#dependencies-list li')
+        # click on add-layers button
+        add_layers_btn =3D self.driver.find_element(
+            By.XPATH,
+            '//form[@id=3D"dependencies-modal-form"]//button[@class=3D"b=
tn btn-primary"]'
+        )
+        add_layers_btn.click()
+        self.wait_until_visible('#change-notification')
+        change_notification =3D self.find('#change-notification')
+        self.assertTrue(
+            f'You have added {len(list_dependencies)+1} layers to your p=
roject: {input_text} and its dependencies' in change_notification.text
+        )
+        # check "Remove layer" button works
+        rows =3D self.find_all('#layerstable tbody tr')
+        layer_to_remove =3D rows[0]
+        remove_btn =3D layer_to_remove.find_element(
+            By.XPATH,
+            '//td[@class=3D"add-del-layers"]'
+        )
+        remove_btn.click()
+        self.wait_until_visible('#change-notification', poll=3D2)
+        change_notification =3D self.find('#change-notification')
+        self.assertTrue(
+            f'You have removed 1 layer from your project: {input_text}' =
in change_notification.text
+        )
+        # check layers table feature(show/hide column, pagination)
+        self._navigate_to_config_nav('layerstable', 6)
+        column_list =3D [
+            'dependencies',
+            'revision',
+            'layer__vcs_url',
+            'git_subdir',
+            'layer__summary',
+        ]
+        self._mixin_test_table_edit_column(
+            'layerstable',
+            'edit-columns-button',
+            [f'checkbox-{column}' for column in column_list]
+        )
+        self._navigate_to_config_nav('layerstable', 6)
+        # check show rows(pagination)
+        self._mixin_test_table_show_rows(table_selector=3D'layerstable')
--=20
2.34.1


