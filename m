Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59625C074FD
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 14:28:22 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.13763.1699972096423730338
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Nov 2023 06:28:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Qm23DI5H;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B85069C32D6
	for <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 09:28:15 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id yhAWTOpH1ZWm; Tue, 14 Nov 2023 09:28:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 345169C0760;
	Tue, 14 Nov 2023 09:28:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 345169C0760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699972095; bh=47T7fC9y3szZG3LQCsBF9cLsv3Vr9K2AHE7gzCHsMPM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Qm23DI5HNqdvi5h85KAPHXYMhYKZ+D9xQOdR8EQi4RsNC3fv+yJ5G87NMiHdQm0XN
	 0Bsd0erTm2G+c+/LjJ55kEivVZMEN1NVxZjRMnl/L1gvAmmiHFEuzQBDpU0iIdeNs3
	 /heVMScXI5TF/O8e5tK6HubrIMEAsKbSeE2Sag+MRPOOCy8XjeoYUGUWzzL0ZBhds+
	 clVpLuviz6ihc7+pcVGOlILF6MrXbkBELatTRACIHML4r9nqJBNu0qDLEmji1IVgy4
	 T0X7BhYkKluJv3nWqlkzXua6tasHpw7luD22bXIWTLJXZn4YNxtCnS1IOzibKqAvW5
	 kO/u26RyhdJKQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lZaKbQwlRbqB; Tue, 14 Nov 2023 09:28:15 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4CEAB9C2C19;
	Tue, 14 Nov 2023 09:28:14 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 5/6] Toaster: Write UI TestCase -> Test "edit column" feature show/hide column
Date: Tue, 14 Nov 2023 15:28:05 +0100
Message-Id: <20231114142806.53894-5-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114142806.53894-1-alassane.yattara@savoirfairelinux.com>
References: <20231114142806.53894-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 14:28:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15524

Test the "edit column" feature in the builds table on the all builds page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_builds_page.py     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index 90dcdd91..bd2b4799 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -362,3 +362,62 @@ class TestAllBuildsPage(SeleniumTestCase):
         time.sleep(1)
         self.assertTrue(len(self.find_all('#allbuildstable tbody tr')) =3D=
=3D 6)
=20
+    def test_builds_table_editColumn(self):
+        """ Test the edit column feature in the builds table on the all =
builds page """
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
+                        f'#allbuildstable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+                check_box.click()
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#allbuildstable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+            else:
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#allbuildstable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+                check_box.click()
+                # check if column is visible in table
+                self.assertTrue(
+                    self.find(
+                        f'#allbuildstable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+        url =3D reverse('all-builds')
+        self.get(url)
+        self.wait_until_present('#allbuildstable tbody tr')
+
+        # Check edit column
+        edit_column =3D self.find('#edit-columns-button')
+        self.assertTrue(edit_column.is_displayed())
+        edit_column.click()
+        # Check dropdown is visible
+        self.wait_until_visible('ul.dropdown-menu.editcol')
+
+        # Check that we can hide the edit column
+        test_edit_column('checkbox-errors_no')
+        test_edit_column('checkbox-failed_tasks')
+        test_edit_column('checkbox-image_files')
+        test_edit_column('checkbox-project')
+        test_edit_column('checkbox-started_on')
+        test_edit_column('checkbox-time')
+        test_edit_column('checkbox-warnings_no')
--=20
2.34.1


