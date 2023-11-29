Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C8DC10F04
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.57413.1701298463876518886
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 14:54:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=EqlTfH7O;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4209B9C3636
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 17:54:23 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id L06U3lPaN_kd; Wed, 29 Nov 2023 17:54:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 88A719C341E;
	Wed, 29 Nov 2023 17:54:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 88A719C341E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701298462; bh=dvn3UAp0zH9504gmNCBCWZpEbo9JYr/dKpmCghmFYXw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=EqlTfH7O1VLNKrAs9D8jRyEhmBR5MawyJ1kHtRJUag/4vSsSLkjyoKEgxbRD626So
	 LhPOhQU3h27SNnf31hNcBfREmzpPTKxeXJTGyG0svFGAAMRsXodq+w00qKSQDbMKUQ
	 JqSe58Eslm5bHErQuDkHUoGFP3JNL7M4uc+Iasn8oqbuzSFnhm86AlnGw+IE6sMQIa
	 2zXqbm5Qdxr4JbzQ4YWkaZyubxa3vLflo5KuzQsLO0CSMi/4eH6BE463aqSWUAP3vX
	 zSlOuYkzQxv9K4yfXs3mjxhxfPfBnNdnyUdKcmJSNjrhpJx1p2herbgTyX6+4gE15h
	 zBCzz+CaPaiEg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id EcHFGJ4niFfD; Wed, 29 Nov 2023 17:54:22 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id EF4219C279F;
	Wed, 29 Nov 2023 17:54:21 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/9] toaster/test: Added Machine page TestCase
Date: Wed, 29 Nov 2023 23:54:11 +0100
Message-Id: <20231129225416.479526-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
References: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 22:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15583

Test Machine page
    - Check if title "Compatible machines" is displayed
    - Check search input
    - Check "Select machine" button works
    - Check "Add layer" button works
    - Check Machine table feature(show/hide column, pagination)

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 28f1fcb6..46a60c01 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -493,3 +493,82 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self._navigate_to_config_nav('softwarerecipestable', 4)
         # check show rows(pagination)
         self._mixin_test_table_show_rows(table_selector=3D'softwarerecip=
estable')
+
+    def test_machines_page(self):
+        """ Test Machine page
+            - Check if title "Compatible machines" is displayed
+            - Check search input
+            - Check "Select machine" button works
+            - Check "Add layer" button works
+            - Check Machine table feature(show/hide column, pagination)
+        """
+        self._navigate_to_config_nav('machinestable', 5)
+        # check title "Compatible software recipes" is displayed
+        self.assertTrue("Compatible machines" in self.get_page_source())
+        # Test search input
+        self._mixin_test_table_search_input(
+            input_selector=3D'search-input-machinestable',
+            input_text=3D'qemux86-64',
+            searchBtn_selector=3D'search-submit-machinestable',
+            table_selector=3D'machinestable'
+        )
+        # check "Select machine" button works
+        rows =3D self.find_all('#machinestable tbody tr')
+        machine_to_select =3D rows[0]
+        select_btn =3D machine_to_select.find_element(
+            By.XPATH,
+            '//td[@class=3D"add-del-layers"]'
+        )
+        select_btn.click()
+        self.wait_until_visible('#config-nav')
+        project_machine_name =3D self.find('#project-machine-name')
+        self.assertTrue(
+            'qemux86-64' in project_machine_name.text
+        )
+        # check "Add layer" button works
+        self._navigate_to_config_nav('machinestable', 5)
+        # Search for a machine whit layer not in project
+        self._mixin_test_table_search_input(
+            input_selector=3D'search-input-machinestable',
+            input_text=3D'qemux86-64-screen',
+            searchBtn_selector=3D'search-submit-machinestable',
+            table_selector=3D'machinestable'
+        )
+        rows =3D self.find_all('#machinestable tbody tr')
+        machine_to_add =3D rows[0]
+        add_btn =3D machine_to_add.find_element(
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
roject: meta-tanowrt and its dependencies' in change_notification.text
+        )
+
+        # check Machine table feature(show/hide column, pagination)
+        self._navigate_to_config_nav('machinestable', 5)
+        column_list =3D [
+            'description',
+            'layer_version__get_vcs_reference',
+            'layer_version__layer__name',
+            'machinefile',
+        ]
+        self._mixin_test_table_edit_column(
+            'machinestable',
+            'edit-columns-button',
+            [f'checkbox-{column}' for column in column_list]
+        )
+        self._navigate_to_config_nav('machinestable', 5)
+        # check show rows(pagination)
+        self._mixin_test_table_show_rows(table_selector=3D'machinestable=
')
--=20
2.34.1


