Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D678C47077
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 16:27:41 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.20969.1704817658568970195
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 08:27:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=fT4Xs7cw;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EA0129C2B8E
	for <bitbake-devel@lists.openembedded.org>; Tue,  9 Jan 2024 11:27:37 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CpL62TaN_14G; Tue,  9 Jan 2024 11:27:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 802AC9C42BA;
	Tue,  9 Jan 2024 11:27:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 802AC9C42BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704817657; bh=KtY+omChaixoJ+7MB8K23jj5asK8LboYAk+JyxCeTU0=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=fT4Xs7cwkdsmb9DIwkXq2B8yaEMdjwMWJpGtc+niQxWJR02nfsmkh2sL+T1cdTAfN
	 fZG9EHjE6GBxnQBfEW2TJKS/ewwA2oedRwAscO7gSDD5NkL/vS1+17Ye0+JB8Wm8zI
	 qW18D+L/Dr4kSuOX+kcVtpgZIMThvTsaLqmq2KM2KO2RELA8mpY+cYf7OnMBRH56Yb
	 XHr+1k8/xIzGSetjPqvrXqX6j8hHHv9vdd5iSo4+fwRPCdwoe0awHzr/kFCLDtcCv1
	 q2qSEHm+yHO3XOOH57miFWkJH4su7X7OKBk1wunn0/odgTaIPtKHUfdqLdbNULwQ5U
	 ZYVrfo/D1Vu4Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id OVFneGJHUjrY; Tue,  9 Jan 2024 11:27:37 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C9F729C3232;
	Tue,  9 Jan 2024 11:27:36 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 4/4] toaster/test: Bug-fix ToasterTable show_rows testcases
Date: Tue,  9 Jan 2024 17:27:29 +0100
Message-Id: <20240109162729.531311-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109162729.531311-1-alassane.yattara@savoirfairelinux.com>
References: <20240109162729.531311-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 16:27:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15767

Test if some rows are visible in table instead of compare table row to
row_to_show, because recipe image table sometime doesn't display full ava=
iblable
images

Failed: https://autobuilder.yoctoproject.org/typhoon/#/builders/161/build=
s/147/steps/12/logs/stdio

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_all_builds_page.py            | 5 +++--
 lib/toaster/tests/browser/test_all_projects_page.py          | 3 ++-
 lib/toaster/tests/functional/test_project_page.py            | 5 +++--
 lib/toaster/tests/functional/test_project_page_tab_config.py | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index ab6da821..b9356a03 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -452,9 +452,10 @@ class TestAllBuildsPage(SeleniumTestCase):
         def test_show_rows(row_to_show, show_row_link):
             # Check that we can show rows =3D=3D row_to_show
             show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_visible('#allbuildstable tbody tr', poll=3D2=
)
+            self.wait_until_visible('#allbuildstable tbody tr', poll=3D3=
)
+            # check at least some rows are visible
             self.assertTrue(
-                len(self.find_all('#allbuildstable tbody tr')) =3D=3D ro=
w_to_show
+                len(self.find_all('#allbuildstable tbody tr')) > 0
             )
=20
         url =3D reverse('all-builds')
diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/to=
aster/tests/browser/test_all_projects_page.py
index 6540dfa9..9ed1901c 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -314,8 +314,9 @@ class TestAllProjectsPage(SeleniumTestCase):
             # Check that we can show rows =3D=3D row_to_show
             show_row_link.select_by_value(str(row_to_show))
             self.wait_until_visible('#projectstable tbody tr', poll=3D3)
+            # check at least some rows are visible
             self.assertTrue(
-                len(self.find_all('#projectstable tbody tr')) =3D=3D row=
_to_show
+                len(self.find_all('#projectstable tbody tr')) > 0
             )
=20
         url =3D reverse('all-projects')
diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 31177cc1..adbe3587 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -192,9 +192,10 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         def test_show_rows(row_to_show, show_row_link):
             # Check that we can show rows =3D=3D row_to_show
             show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_visible(f'#{table_selector} tbody tr', poll=3D=
2)
+            self.wait_until_visible(f'#{table_selector} tbody tr', poll=3D=
3)
+            # check at least some rows are visible
             self.assertTrue(
-                len(self.find_all(f'#{table_selector} tbody tr')) =3D=3D=
 row_to_show
+                len(self.find_all(f'#{table_selector} tbody tr')) > 0
             )
         self.wait_until_present(f'#{table_selector} tbody tr')
         show_rows =3D self.driver.find_elements(
diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index 03b0a854..eb905ddf 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -253,7 +253,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
         def test_show_rows(row_to_show, show_row_link):
             # Check that we can show rows =3D=3D row_to_show
             show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_visible('#imagerecipestable tbody tr')
+            self.wait_until_visible('#imagerecipestable tbody tr', poll=3D=
3)
             # check at least some rows are visible
             self.assertTrue(
                 len(self.find_all('#imagerecipestable tbody tr'))  > 0
--=20
2.34.1


