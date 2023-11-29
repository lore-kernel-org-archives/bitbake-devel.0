Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF93C10DCE
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.57334.1701298463050144844
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 14:54:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=JU3/BZ2u;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6B76F9C3679
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 17:54:22 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id q1knb2_ki-QO; Wed, 29 Nov 2023 17:54:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BBA8A9C341E;
	Wed, 29 Nov 2023 17:54:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com BBA8A9C341E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701298461; bh=Gu7LSjTMRIutt2pVoYpNGcgYEgMPM5NyOuXX8kEY7oA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=JU3/BZ2uZb3VUW+vv/3WgOXuiRZD34XZC/JJqyHEekzCSwWJbZpqCSSW6HPkyJav6
	 drkmOfZOuoQqFpY6wQXOsFrSlaAEg5ZW6XhKHKmQ5rS+KaQAsBAViQvHzWg0J/Bp1u
	 lucoddLIpkC1FE8ToT5dOuG/Zpl6NO08D8vs2kUhDSZQN7pVcl+7e/ogTwBMKbuFX6
	 mwkXjzOpnSq4yIVRf5ZD/VodMhJmBfumoVVj1nFCyjm+C8S06y7kRJM0eA+poV4fjl
	 39iG6OuvkeMChRPrQP45PmN1E3hC9VPKA9rVR03d52568lZXB9kB7Wp5GmfEqN6UxE
	 2gIsxQfRC69Nw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id VFfVALhe5pDF; Wed, 29 Nov 2023 17:54:21 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 367149C279F;
	Wed, 29 Nov 2023 17:54:21 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/9] toaster/test: Test software recipe page
Date: Wed, 29 Nov 2023 23:54:10 +0100
Message-Id: <20231129225416.479526-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
References: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 22:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15582

Test software recipe page
    - Check title "Compatible software recipes" is displayed
    - Check search input
    - Check "build recipe" button works
    - Check software recipe table feature(show/hide column, pagination)

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index f1eb9cfa..28f1fcb6 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -7,9 +7,11 @@
 #
=20
 import pytest
+from time import sleep
 from django.urls import reverse
 from django.utils import timezone
 from selenium.webdriver.support.select import Select
+from selenium.common.exceptions import NoSuchElementException
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from orm.models import Build, Project, Target
 from selenium.webdriver.common.by import By
@@ -164,6 +166,70 @@ class TestProjectPage(SeleniumFunctionalTestCase):
                     f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
                 )
=20
+    def _get_config_nav_item(self, index):
+        config_nav =3D self.find('#config-nav')
+        return config_nav.find_elements(By.TAG_NAME, 'li')[index]
+
+    def _navigate_to_config_nav(self, nav_id, nav_index):
+        # navigate to the project page
+        url =3D reverse("project", args=3D(1,))
+        self.get(url)
+        self.wait_until_visible('#config-nav')
+        # click on "Software recipe" tab
+        soft_recipe =3D self._get_config_nav_item(nav_index)
+        soft_recipe.click()
+        self.wait_until_visible(f'#{nav_id}')
+
+    def _mixin_test_table_show_rows(self, table_selector, **kwargs):
+        """ Test the show rows feature in the builds table on the all bu=
ilds page """
+        def test_show_rows(row_to_show, show_row_link):
+            # Check that we can show rows =3D=3D row_to_show
+            show_row_link.select_by_value(str(row_to_show))
+            self.wait_until_visible(f'#{table_selector} tbody tr', poll=3D=
2)
+            self.assertTrue(
+                len(self.find_all(f'#{table_selector} tbody tr')) =3D=3D=
 row_to_show
+            )
+        self.wait_until_present(f'#{table_selector} tbody tr')
+        show_rows =3D self.driver.find_elements(
+            By.XPATH,
+            f'//select[@class=3D"form-control pagesize-{table_selector}"=
]'
+        )
+        rows_to_show =3D [10, 25, 50, 100, 150]
+        to_skip =3D kwargs.get('to_skip', [])
+        # Check show rows
+        for show_row_link in show_rows:
+            show_row_link =3D Select(show_row_link)
+            for row_to_show in rows_to_show:
+                if row_to_show not in to_skip:
+                    test_show_rows(row_to_show, show_row_link)
+
+    def _wait_until_build(self, state):
+        while True:
+            try:
+                last_build_state =3D self.driver.find_element(
+                    By.XPATH,
+                    '//*[@id=3D"latest-builds"]/div[1]//div[@class=3D"bu=
ild-state"]',
+                )
+                build_state =3D last_build_state.get_attribute(
+                    'data-build-state')
+                state_text =3D state.lower().split()
+                if any(x in str(build_state).lower() for x in state_text=
):
+                    break
+            except NoSuchElementException:
+                continue
+            sleep(1)
+
+    def _mixin_test_table_search_input(self, **kwargs):
+        input_selector, input_text, searchBtn_selector, table_selector, =
*_ =3D kwargs.values()
+        # Test search input
+        self.wait_until_visible(f'#{input_selector}')
+        recipe_input =3D self.find(f'#{input_selector}')
+        recipe_input.send_keys(input_text)
+        self.find(f'#{searchBtn_selector}').click()
+        self.wait_until_visible(f'#{table_selector} tbody tr')
+        rows =3D self.find_all(f'#{table_selector} tbody tr')
+        self.assertTrue(len(rows) > 0)
+
     def test_image_recipe_editColumn(self):
         """ Test the edit column feature in image recipe table on projec=
t page """
         self._get_create_builds(success=3D10, failure=3D10)
@@ -375,3 +441,55 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertTrue(
             'core-image-minimal' in str(last_build.text)
         )
+
+    def test_softwareRecipe_page(self):
+        """ Test software recipe page
+            - Check title "Compatible software recipes" is displayed
+            - Check search input
+            - Check "build recipe" button works
+            - Check software recipe table feature(show/hide column, pagi=
nation)
+        """
+        self._navigate_to_config_nav('softwarerecipestable', 4)
+        # check title "Compatible software recipes" is displayed
+        self.assertTrue("Compatible software recipes" in self.get_page_s=
ource())
+        # Test search input
+        self._mixin_test_table_search_input(
+            input_selector=3D'search-input-softwarerecipestable',
+            input_text=3D'busybox',
+            searchBtn_selector=3D'search-submit-softwarerecipestable',
+            table_selector=3D'softwarerecipestable'
+        )
+        # check "build recipe" button works
+        rows =3D self.find_all('#softwarerecipestable tbody tr')
+        image_to_build =3D rows[0]
+        build_btn =3D image_to_build.find_element(
+            By.XPATH,
+            '//td[@class=3D"add-del-layers"]'
+        )
+        build_btn.click()
+        self._wait_until_build('parsing starting cloning')
+        lastest_builds =3D self.driver.find_elements(
+            By.XPATH,
+            '//div[@id=3D"latest-builds"]/div'
+        )
+        self.assertTrue(len(lastest_builds) > 0)
+
+        # check software recipe table feature(show/hide column, paginati=
on)
+        self._navigate_to_config_nav('softwarerecipestable', 4)
+        column_list =3D [
+            'get_description_or_summary',
+            'layer_version__get_vcs_reference',
+            'layer_version__layer__name',
+            'license',
+            'recipe-file',
+            'section',
+            'version',
+        ]
+        self._mixin_test_table_edit_column(
+            'softwarerecipestable',
+            'edit-columns-button',
+            [f'checkbox-{column}' for column in column_list]
+        )
+        self._navigate_to_config_nav('softwarerecipestable', 4)
+        # check show rows(pagination)
+        self._mixin_test_table_show_rows(table_selector=3D'softwarerecip=
estable')
--=20
2.34.1


