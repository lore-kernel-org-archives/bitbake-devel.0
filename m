Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA747C61D92
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:48:19 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.40782.1700574494929030740
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:48:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Piv4/J0/;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 477E99C3500
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:48:14 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5CX-Fg7z15z6; Tue, 21 Nov 2023 08:48:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C0D109C36BF;
	Tue, 21 Nov 2023 08:48:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C0D109C36BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574493; bh=JjqD5HKixp7hLeuqqEY/8qQk6P82Ru05ECeGDvQjuPE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Piv4/J0/LiL4ceCw3k4xa3HMbxFc3sK5whRI/kweo4ceJCDKFyHxMtlWK6Taa+JXZ
	 uPgI8FqbpPrr6cjBRxleJHMKR3Se1inz17/HeAfGIPOpwGPw17AUfmWCCEHrBGvdsN
	 by5U6kQHacDUguzr7x//Y6WaQIxLHqkCDlLDbSrnHNLR3/s9+gCTuam63i9m4lZ3hf
	 YyxjHDLFmlgG+ecx8xZGkr90mCM57PrK4PykL/jBct2FIKmoUSzPgAED0Kgwr8MzEZ
	 ShfSmS81ViXj36a/oM8qbIO6GCaPCmyt1yV/U74gnaZozDDAa1I0503UOSui2C4ABm
	 CMmYnaW9wgqXA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LM29WSIfDlv9; Tue, 21 Nov 2023 08:48:13 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E0B229C2B49;
	Tue, 21 Nov 2023 08:48:12 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/3] Toaster: Toaster: Write UI TestCase -> Visualize all projects
Date: Tue, 21 Nov 2023 14:48:00 +0100
Message-Id: <20231121134801.97718-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121134801.97718-1-alassane.yattara@savoirfairelinux.com>
References: <20231121134801.97718-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:48:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15546

Test the edit column feature in the projects table on the all projects pa=
ge

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_projects_page.py   | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/to=
aster/tests/browser/test_all_projects_page.py
index db25e723..2b1d8cc1 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -239,3 +239,61 @@ class TestAllProjectsPage(SeleniumTestCase):
         time.sleep(1)
         rows =3D self.find_all('#projectstable tbody tr')
         self.assertTrue(len(rows) =3D=3D 1)
+
+    def test_allProject_table_editColumn(self):
+        """ Test the edit column feature in the projects table on the al=
l projects page """
+        self._create_projects()
+
+        def test_edit_column(check_box_id):
+            # Check that we can hide/show table column
+            check_box =3D self.find(f'#{check_box_id}')
+            th_class =3D str(check_box_id).replace('checkbox-', '')
+            if check_box.is_selected():
+                # check if column is visible in table
+                self.assertTrue(
+                    self.find(
+                        f'#projectstable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+                check_box.click()
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#projectstable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+            else:
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#projectstable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+                check_box.click()
+                # check if column is visible in table
+                self.assertTrue(
+                    self.find(
+                        f'#projectstable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+        url =3D reverse('all-projects')
+        self.get(url)
+        self.wait_until_present('#projectstable tbody tr')
+
+        # Check edit column
+        edit_column =3D self.find('#edit-columns-button')
+        self.assertTrue(edit_column.is_displayed())
+        edit_column.click()
+        # Check dropdown is visible
+        self.wait_until_visible('ul.dropdown-menu.editcol')
+
+        # Check that we can hide the edit column
+        test_edit_column('checkbox-errors')
+        test_edit_column('checkbox-image_files')
+        test_edit_column('checkbox-last_build_outcome')
+        test_edit_column('checkbox-recipe_name')
+        test_edit_column('checkbox-warnings')
--=20
2.34.1


