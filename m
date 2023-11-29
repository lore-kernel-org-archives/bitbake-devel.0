Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D403C46CA3
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.57333.1701298462641327759
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 14:54:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=SXdkelqY;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B21079C3636
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 17:54:21 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 7eZgxhS2w0Fw; Wed, 29 Nov 2023 17:54:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0BB489C341E;
	Wed, 29 Nov 2023 17:54:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0BB489C341E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701298461; bh=Rk8R1jfsrUChGeKCrKr2VlgUcgp3bK1yIrRvD/OUsvU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=SXdkelqYmOUDsun621YNkizyq/+q0G2HK2hAUVMGBfqmDZOEEK4yj2vjIEoWt/pe6
	 8iCxJ3M6CRfOqlCM74XjWTq+CxoND7OPXy6mYRjBWTwr0QhyAPwbxLPrGz0WS8w/Le
	 TUyXGwYHm8ATB6s/RinKbVR6DokjdpZ+y1kqKusvzpxWpJQT0GCgDx+TBBVlv9tPg3
	 GaeBUw75OybJWFTnJQm96vnqOoF2IYoN0b7UosladhEymuzyGk+g5lgjSaDRxwhrnK
	 l/D4MMnYfb5fs0zqcSsdSqh0cJSyKbTU5wH4Fl1I0AIbVEfF3dgBjqO5fyAhDdiuz0
	 82N8VaGuZz3Rw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id aV1QkeoMT6f2; Wed, 29 Nov 2023 17:54:20 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 71C5E9C279F;
	Wed, 29 Nov 2023 17:54:20 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/9] toaster/test: Override table edit columns TestCase from image recipe page
Date: Wed, 29 Nov 2023 23:54:09 +0100
Message-Id: <20231129225416.479526-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
References: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 22:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15581

Better handle TestCase of table  edit column feature
Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 3edf967a..f1eb9cfa 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -8,8 +8,10 @@
=20
 import pytest
 from django.urls import reverse
+from django.utils import timezone
 from selenium.webdriver.support.select import Select
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
+from orm.models import Build, Project, Target
 from selenium.webdriver.common.by import By
=20
=20
@@ -55,6 +57,134 @@ class TestProjectPage(SeleniumFunctionalTestCase):
=20
         self.driver.find_element(By.ID, "create-project-button").click()
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
+    def _mixin_test_table_edit_column(
+            self,
+            table_id,
+            edit_btn_id,
+            list_check_box_id: list
+    ):
+        # Check edit column
+        edit_column =3D self.find(f'#{edit_btn_id}')
+        self.assertTrue(edit_column.is_displayed())
+        edit_column.click()
+        # Check dropdown is visible
+        self.wait_until_visible('ul.dropdown-menu.editcol')
+        for check_box_id in list_check_box_id:
+            # Check that we can hide/show table column
+            check_box =3D self.find(f'#{check_box_id}')
+            th_class =3D str(check_box_id).replace('checkbox-', '')
+            if check_box.is_selected():
+                # check if column is visible in table
+                self.assertTrue(
+                    self.find(
+                        f'#{table_id} thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+                check_box.click()
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#{table_id} thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+            else:
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#{table_id} thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+                check_box.click()
+                # check if column is visible in table
+                self.assertTrue(
+                    self.find(
+                        f'#{table_id} thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+
+    def test_image_recipe_editColumn(self):
+        """ Test the edit column feature in image recipe table on projec=
t page """
+        self._get_create_builds(success=3D10, failure=3D10)
+
+        url =3D reverse('projectimagerecipes', args=3D(1,))
+        self.get(url)
+        self.wait_until_present('#imagerecipestable tbody tr')
+
+        column_list =3D [
+            'get_description_or_summary', 'layer_version__get_vcs_refere=
nce',
+            'layer_version__layer__name', 'license', 'recipe-file', 'sec=
tion',
+            'version'
+        ]
+
+        # Check that we can hide the edit column
+        self._mixin_test_table_edit_column(
+            'imagerecipestable',
+            'edit-columns-button',
+            [f'checkbox-{column}' for column in column_list]
+        )
+
     def test_page_header_on_project_page(self):
         """ Check page header in project page:
           - AT LEFT -> Logo of Yocto project, displayed, clickable
--=20
2.34.1


