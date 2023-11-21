Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2549C61D94
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:48:19 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.40785.1700574496132152008
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:48:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=fekBbDSL;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 74D6D9C36CD
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:48:15 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id KjP0ErIOrN1m; Tue, 21 Nov 2023 08:48:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 046579C36BF;
	Tue, 21 Nov 2023 08:48:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 046579C36BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574495; bh=gMAwcRDu6dn+fvWsoJukwtIYa0PqX6nF7Ewp49cvZWY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=fekBbDSLzpXFTDkrA1V6nU2strdA1YCA5l8tpoVxmT/67BeHgvi+hU8je8UFMUHxC
	 ku2DGmPCZfTc2PpIRomXtPu1A7FQ8o1RR0jNXQKRMVUYM2Iz84z+G5rgZNqRCwg3b7
	 3csxML2BPKgqRrxeGY/4M/M9u6wKl+qZGXWxdmwNtWPVFObaAI99U1aks/xqxsqdFu
	 HM9oGUwppRtpCsw0N7nsgvF/UncHWnP4CPcQQYjqK8cygmL4V6XoGiFTDgirB4m5De
	 bHSAzzmpNlQMLlQWcFPP9j6aGq5GpEhktzfVVpVHvZI1HAEwPYX/aJWQdEo9wG8AfC
	 S2rtnjpX53u0w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id mrRl5DltrMF1; Tue, 21 Nov 2023 08:48:14 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2465C9C2B49;
	Tue, 21 Nov 2023 08:48:13 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/3] Toaster: Toaster: Write UI TestCase -> Visualize all projects
Date: Tue, 21 Nov 2023 14:48:01 +0100
Message-Id: <20231121134801.97718-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121134801.97718-1-alassane.yattara@savoirfairelinux.com>
References: <20231121134801.97718-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:48:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15547

Test the show rows feature in the projects table on the all projects page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_projects_page.py   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/to=
aster/tests/browser/test_all_projects_page.py
index 2b1d8cc1..a880dbcc 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -297,3 +297,37 @@ class TestAllProjectsPage(SeleniumTestCase):
         test_edit_column('checkbox-last_build_outcome')
         test_edit_column('checkbox-recipe_name')
         test_edit_column('checkbox-warnings')
+
+    def test_allProject_table_show_rows(self):
+        """ Test the show rows feature in the projects table on the all =
projects page """
+        self._create_projects(nb_project=3D200)
+
+        def test_show_rows(row_to_show, show_row_link):
+            # Check that we can show rows =3D=3D row_to_show
+            show_row_link.select_by_value(str(row_to_show))
+            self.wait_until_present('#projectstable tbody tr')
+            sleep_time =3D 1
+            if row_to_show =3D=3D 150:
+                # wait more time for 150 rows
+                sleep_time =3D 2
+            time.sleep(sleep_time)
+            self.assertTrue(
+                len(self.find_all('#projectstable tbody tr')) =3D=3D row=
_to_show
+            )
+
+        url =3D reverse('all-projects')
+        self.get(url)
+        self.wait_until_present('#projectstable tbody tr')
+
+        show_rows =3D self.driver.find_elements(
+            By.XPATH,
+            '//select[@class=3D"form-control pagesize-projectstable"]'
+        )
+        # Check show rows
+        for show_row_link in show_rows:
+            show_row_link =3D Select(show_row_link)
+            test_show_rows(10, show_row_link)
+            test_show_rows(25, show_row_link)
+            test_show_rows(50, show_row_link)
+            test_show_rows(100, show_row_link)
+            test_show_rows(150, show_row_link)
--=20
2.34.1


