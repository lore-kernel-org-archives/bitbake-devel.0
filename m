Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A09EC61D92
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:51:50 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.40883.1700574703874305353
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:51:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=s8v9/AhG;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 325729C36BA
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:51:43 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id qNV0aPry82I9; Tue, 21 Nov 2023 08:51:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5C56C9C3756;
	Tue, 21 Nov 2023 08:51:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5C56C9C3756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574702; bh=XFp2Aw4VEZK5wuJU830kvVCbytU6doqvSFaKcSnUNrY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=s8v9/AhGQTH6Ts27HSaH4lZM5xay6m33MRo8pHghpLmEFEukLWqyl3LDrnHS613WH
	 mwBYPUkhymVlHjLAkacLAlV/xryJDRA4lle0Gq2frOPS+VeR18JBy4XKAQLxGIT4H/
	 X1jklAK7nAS///0xhtFavyKTvFs3dov59+SdwWit/uqbyzfus6yFvudRCU3Oe2ZPSy
	 JeNoQOPviLfdH14TNSGaNB1sBG5q08XIO9pBKQlO9rqUHi/jY3Tpwso6yD3SsRGGbf
	 7zfkJFlGnuWM8Q1Fx2nCXdY0Py6N8AsOYc0xOtxcHaEXKO6YwHrc5b0pm67Xhs63o2
	 p4FK/Af3PEDZA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0QRi6-swYRuk; Tue, 21 Nov 2023 08:51:42 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 966409C36B9;
	Tue, 21 Nov 2023 08:51:41 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 6/7] Toaster: Write UI TestCase -> the edit column feature in image recipe
Date: Tue, 21 Nov 2023 14:51:30 +0100
Message-Id: <20231121135131.107330-6-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
References: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:51:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15557

BUILD IMAGE RECIPES: toastergui/project/{id}/images/
Test the edit column feature in image recipe table on project page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../test_project_page_tab_config.py           | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index 598a8055..2dfc120d 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -8,10 +8,12 @@
=20
 from time import sleep
 import pytest
+from django.utils import timezone
 from django.urls import reverse
 from selenium.webdriver import Keys
 from selenium.webdriver.support.select import Select
 from selenium.common.exceptions import NoSuchElementException
+from orm.models import Build, Project, Target
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from selenium.webdriver.common.by import By
=20
@@ -112,6 +114,64 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
         config_nav =3D self.find('#config-nav')
         return config_nav.find_elements(By.TAG_NAME, 'li')[index]
=20
+    def _get_create_builds(self, **kwargs):
+        """ Create a build and return the build object """
+        # parameters for builds to associate with the projects
+        now =3D timezone.now()
+        release =3D '3'
+        project_name =3D 'projectmaster'
+        self._create_test_new_project(
+            project_name+"2",
+            release,
+            False,
+        )
+
+        self.project1_build_success =3D {
+            'project': Project.objects.get(id=3D1),
+            'started_on': now,
+            'completed_on': now,
+            'outcome': Build.SUCCEEDED
+        }
+
+        self.project1_build_failure =3D {
+            'project': Project.objects.get(id=3D1),
+            'started_on': now,
+            'completed_on': now,
+            'outcome': Build.FAILED
+        }
+        build1 =3D Build.objects.create(**self.project1_build_success)
+        build2 =3D Build.objects.create(**self.project1_build_failure)
+
+        # add some targets to these builds so they have recipe links
+        # (and so we can find the row in the ToasterTable corresponding =
to
+        # a particular build)
+        Target.objects.create(build=3Dbuild1, target=3D'foo')
+        Target.objects.create(build=3Dbuild2, target=3D'bar')
+
+        if kwargs:
+            # Create kwargs.get('success') builds with success status wi=
th target
+            # and kwargs.get('failure') builds with failure status with =
target
+            for i in range(kwargs.get('success', 0)):
+                now =3D timezone.now()
+                self.project1_build_success['started_on'] =3D now
+                self.project1_build_success[
+                    'completed_on'] =3D now - timezone.timedelta(days=3D=
i)
+                build =3D Build.objects.create(**self.project1_build_suc=
cess)
+                Target.objects.create(build=3Dbuild,
+                                      target=3Df'{i}_success_recipe',
+                                      task=3Df'{i}_success_task')
+
+            for i in range(kwargs.get('failure', 0)):
+                now =3D timezone.now()
+                self.project1_build_failure['started_on'] =3D now
+                self.project1_build_failure[
+                    'completed_on'] =3D now - timezone.timedelta(days=3D=
i)
+                build =3D Build.objects.create(**self.project1_build_fai=
lure)
+                Target.objects.create(build=3Dbuild,
+                                      target=3Df'{i}_fail_recipe',
+                                      task=3Df'{i}_fail_task')
+        return build1, build2
+
     def test_project_config_nav(self):
         """ Test project config tab navigation:
         - Check if the menu is displayed and contains the right elements=
:
@@ -421,3 +481,64 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
             '//div[@id=3D"latest-builds"]/div'
         )
         self.assertTrue(len(lastest_builds) > 0)
+
+    def test_image_recipe_editColumn(self):
+        """ Test the edit column feature in image recipe table on projec=
t page """
+        self._get_create_builds(success=3D10, failure=3D10)
+
+        def test_edit_column(check_box_id):
+            # Check that we can hide/show table column
+            check_box =3D self.find(f'#{check_box_id}')
+            th_class =3D str(check_box_id).replace('checkbox-', '')
+            if check_box.is_selected():
+                # check if column is visible in table
+                self.assertTrue(
+                    self.find(
+                        f'#imagerecipestable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+                check_box.click()
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#imagerecipestable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+            else:
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#imagerecipestable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+                check_box.click()
+                # check if column is visible in table
+                self.assertTrue(
+                    self.find(
+                        f'#imagerecipestable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+
+        url =3D reverse('projectimagerecipes', args=3D(1,))
+        self.get(url)
+        self.wait_until_present('#imagerecipestable tbody tr')
+
+        # Check edit column
+        edit_column =3D self.find('#edit-columns-button')
+        self.assertTrue(edit_column.is_displayed())
+        edit_column.click()
+        # Check dropdown is visible
+        self.wait_until_visible('ul.dropdown-menu.editcol')
+
+        # Check that we can hide the edit column
+        test_edit_column('checkbox-get_description_or_summary')
+        test_edit_column('checkbox-layer_version__get_vcs_reference')
+        test_edit_column('checkbox-layer_version__layer__name')
+        test_edit_column('checkbox-license')
+        test_edit_column('checkbox-recipe-file')
+        test_edit_column('checkbox-section')
+        test_edit_column('checkbox-version')
--=20
2.34.1


