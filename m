Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477C1C61D94
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:51:40 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.40878.1700574699422018670
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:51:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=LmeHB7JT;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BE6229C3496
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:51:38 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Dyv3bEMFDqBr; Tue, 21 Nov 2023 08:51:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 910089C3373;
	Tue, 21 Nov 2023 08:51:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 910089C3373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574697; bh=smYsRYDmGroscLsgoB50jQXDpPzWwHjEawH7+FclPsM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=LmeHB7JTIbjw3nTg56DySnbQHw8hPRhIJV9aM30+5TkwnH9098a0jkIlYT8F3wsbs
	 3SN1CnFvgb+YndrMHNadGpXlnjH0uOEqoImsTSP9GBKRnT0MOIlzImph7VS3z0mEEA
	 rWD89SIRSARVsR7QIxthQbQdcBZqZvhQeBsVan79YQEYcyJRDRIzckzRMQzDB0abLY
	 +BQAZgZKEYM6knx2ovNeGWEWqwXtCrHIB1HryGC+G99tbhu2kBayauIFRFUk6y98j6
	 7yGz690QF86l/PzE8kfTmSOpMjxA3MzN7FRZdH8NpMLqjsIodQWJiIKpqrE3xNjzdy
	 1e/r6YOdBld9w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Cx0cpbtbYIBr; Tue, 21 Nov 2023 08:51:37 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 870609C2B49;
	Tue, 21 Nov 2023 08:51:36 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/7] Toaster: Write UI TestCase -> Test project config tab
Date: Tue, 21 Nov 2023 14:51:26 +0100
Message-Id: <20231121135131.107330-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
References: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:51:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15553

Check if project config tab right section contains five blocks:
    - Machine:
        - check 'Machine' is displayed
        - check can change Machine
    - Distro:
        - check 'Distro' is displayed
        - check can change Distro
    - Most built recipes:
        - check 'Most built recipes' is displayed
        - check can select a recipe and build it
    - Project release:
        - check 'Project release' is displayed
        - check project has right release displayed
    - Layers:
        - check can add a layer if exists
        - check at least three layers are displayed
            - openembedded-core
            - meta-poky
            - meta-yocto-bsp

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../test_project_page_tab_config.py           | 132 ++++++++++++++++++
 .../toastergui/templates/mrb_section.html     |   2 +-
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index f0c6aacf..ca3b88d2 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -9,6 +9,7 @@
 from time import sleep
 import pytest
 from django.urls import reverse
+from selenium.webdriver import Keys
 from selenium.webdriver.support.select import Select
 from selenium.common.exceptions import NoSuchElementException
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
@@ -174,3 +175,134 @@ class TestProjectConfigTab(SeleniumFunctionalTestCa=
se):
             if item.get_attribute('class') !=3D 'active':
                 item.click()
             check_config_nav_item(index, item_name, url)
+
+    def test_project_config_tab_right_section(self):
+        """ Test project config tab right section contains five blocks:
+            - Machine:
+                - check 'Machine' is displayed
+                - check can change Machine
+            - Distro:
+                - check 'Distro' is displayed
+                - check can change Distro
+            - Most built recipes:
+                - check 'Most built recipes' is displayed
+                - check can select a recipe and build it
+            - Project release:
+                - check 'Project release' is displayed
+                - check project has right release displayed
+            - Layers:
+                - check can add a layer if exists
+                - check at least three layers are displayed
+                    - openembedded-core
+                    - meta-poky
+                    - meta-yocto-bsp
+        """
+        # navigate to the project page
+        url =3D reverse("project", args=3D(1,))
+        self.get(url)
+
+        # check if the menu is displayed
+        self.wait_until_visible('#project-page')
+        block_l =3D self.driver.find_element(
+            By.XPATH, '//*[@id=3D"project-page"]/div[2]')
+        machine =3D self.find('#machine-section')
+        distro =3D self.find('#distro-section')
+        most_built_recipes =3D self.driver.find_element(
+            By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[3]')
+        project_release =3D self.driver.find_element(
+            By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[4]')
+        layers =3D block_l.find_element(By.ID, 'layer-container')
+
+        def check_machine_distro(self, item_name, new_item_name, block):
+            title =3D block.find_element(By.TAG_NAME, 'h3')
+            self.assertTrue(item_name.capitalize() in title.text)
+            edit_btn =3D block.find_element(By.ID, f'change-{item_name}-=
toggle')
+            edit_btn.click()
+            sleep(1)
+            name_input =3D block.find_element(By.ID, f'{item_name}-chang=
e-input')
+            name_input.clear()
+            name_input.send_keys(new_item_name)
+            change_btn =3D block.find_element(By.ID, f'{item_name}-chang=
e-btn')
+            change_btn.click()
+            sleep(1)
+            project_name =3D block.find_element(By.ID, f'project-{item_n=
ame}-name')
+            self.assertTrue(new_item_name in project_name.text)
+            # check change notificaiton is displayed
+            change_notification =3D self.find('#change-notification')
+            self.assertTrue(
+                f'You have changed the {item_name} to: {new_item_name}' =
in change_notification.text
+            )
+
+        # Machine
+        check_machine_distro(self, 'machine', 'qemux86-64', machine)
+        # Distro
+        check_machine_distro(self, 'distro', 'poky-altcfg', distro)
+
+        # Project release
+        title =3D project_release.find_element(By.TAG_NAME, 'h3')
+        self.assertTrue("Project release" in title.text)
+        self.assertTrue(
+            "Yocto Project master" in self.find('#project-release-title'=
).text
+        )
+
+        # Layers
+        title =3D layers.find_element(By.TAG_NAME, 'h3')
+        self.assertTrue("Layers" in title.text)
+        # check at least three layers are displayed
+        # openembedded-core
+        # meta-poky
+        # meta-yocto-bsp
+        layers_list =3D layers.find_element(By.ID, 'layers-in-project-li=
st')
+        layers_list_items =3D layers_list.find_elements(By.TAG_NAME, 'li=
')
+        self.assertTrue(len(layers_list_items) =3D=3D 3)
+        # check can add a layer if exists
+        add_layer_input =3D layers.find_element(By.ID, 'layer-add-input'=
)
+        add_layer_input.send_keys('meta-oe')
+        self.wait_until_visible('#layer-container > form > div > span > =
div')
+        dropdown_item =3D self.driver.find_element(
+            By.XPATH,
+            '//*[@id=3D"layer-container"]/form/div/span/div'
+        )
+        dropdown_item.click()
+        add_layer_btn =3D layers.find_element(By.ID, 'add-layer-btn')
+        add_layer_btn.click()
+        sleep(1)
+        # check layer is added
+        layers_list_items =3D layers_list.find_elements(By.TAG_NAME, 'li=
')
+        self.assertTrue(len(layers_list_items) =3D=3D 4)
+
+        # Most built recipes
+        title =3D most_built_recipes.find_element(By.TAG_NAME, 'h3')
+        self.assertTrue("Most built recipes" in title.text)
+        # Create a new builds 5
+        self._create_builds()
+
+        # Refresh the page
+        self.get(url)
+
+        sleep(1)  # wait for page to load
+        self.wait_until_visible('#project-page')
+        # check can select a recipe and build it
+        most_built_recipes =3D self.driver.find_element(
+            By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[3]')
+        recipe_list =3D most_built_recipes.find_element(By.ID, 'freq-bui=
ld-list')
+        recipe_list_items =3D recipe_list.find_elements(By.TAG_NAME, 'li=
')
+        self.assertTrue(len(recipe_list_items) > 0)
+        checkbox =3D recipe_list_items[0].find_element(By.TAG_NAME, 'inp=
ut')
+        checkbox.click()
+        build_btn =3D self.find('#freq-build-btn')
+        build_btn.click()
+        sleep(1)  # wait for page to load
+        self.wait_until_visible('#latest-builds')
+        self._wait_until_build('parsing starting cloning queueing')
+        lastest_builds =3D self.driver.find_elements(
+            By.XPATH,
+            '//div[@id=3D"latest-builds"]/div'
+        )
+        last_build =3D lastest_builds[0]
+        cancel_button =3D last_build.find_element(
+            By.XPATH,
+            '//span[@class=3D"cancel-build-btn pull-right alert-link"]',
+        )
+        cancel_button.click()
+        self.assertTrue(len(lastest_builds) =3D=3D 2)
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toas=
ter/toastergui/templates/mrb_section.html
index 98d9fac8..9fc7dfae 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -63,7 +63,7 @@
     <%/if%>
   </div>
=20
-  <div data-build-state=3D"<%:state%>">
+  <div class=3D"build-state" data-build-state=3D"<%:state%>">
     <%if state =3D=3D 'Cloning'%>
       <%include tmpl=3D'#cloning-repos-build-template'/%>
     <%else state =3D=3D 'Parsing'%>
--=20
2.34.1


