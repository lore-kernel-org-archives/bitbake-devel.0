Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF61C47079
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 15:10:57 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.150102.1703862649935396871
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Dec 2023 07:10:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=qeKAo4n7;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 45B3E9C2794
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 10:10:49 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 54beg3WFOvzB; Fri, 29 Dec 2023 10:10:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F1A4D9C27A2;
	Fri, 29 Dec 2023 10:10:48 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com F1A4D9C27A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1703862648; bh=cfRHpMo0k4RFgs4sMaYVSct7WqcJtTig6qWeGlsX5U0=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=qeKAo4n7+JfVuAnokY0OJyKR5KFoZOUKTV4EGnFbl/23rUYG19NHDMUFIVEyPbnnG
	 i5Pb9hVj0JkIQfgho9I2hwgaouhwFxUewfWCIxSWCDqNfRhiqk1sYOsOxkQpX9dy0l
	 vLovTFVuGWkWR6GhmYZNN0zZ7zd2ijEBh6QVS8LdnqmBefXbpgHCUakIIJRJTmE1/X
	 A+IHJ8vsVNNiN8wf4NbpBu9tqmOOYpT0MD5NGsTpu6qMEG2qWgdNvOfjIOXYZYg6du
	 Q9lbzb6wByDvvJylUTUCHuH+Vsm0/aaShtfgamGiHMEat5n2sfTfeFbi9PjRbGzwcm
	 AK2C2IcMyd3rg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id z6QNaCV7qQjD; Fri, 29 Dec 2023 10:10:48 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 33FF59C2794;
	Fri, 29 Dec 2023 10:10:48 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/4] toaster/test: Skip to show more then 100 item in ToasterTable
Date: Fri, 29 Dec 2023 16:10:23 +0100
Message-Id: <20231229151024.43476-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229151024.43476-1-alassane.yattara@savoirfairelinux.com>
References: <20231229151024.43476-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 15:10:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15722

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py       | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 82dca442..31177cc1 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -494,7 +494,10 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         )
         self._navigate_to_config_nav('softwarerecipestable', 4)
         # check show rows(pagination)
-        self._mixin_test_table_show_rows(table_selector=3D'softwarerecip=
estable')
+        self._mixin_test_table_show_rows(
+            table_selector=3D'softwarerecipestable',
+            to_skip=3D[150],
+        )
=20
     def test_machines_page(self):
         """ Test Machine page
@@ -561,7 +564,10 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         )
         self._navigate_to_config_nav('machinestable', 5)
         # check show rows(pagination)
-        self._mixin_test_table_show_rows(table_selector=3D'machinestable=
')
+        self._mixin_test_table_show_rows(
+            table_selector=3D'machinestable',
+            to_skip=3D[150],
+        )
=20
     def test_layers_page(self):
         """ Test layers page
@@ -635,7 +641,10 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         )
         self._navigate_to_config_nav('layerstable', 6)
         # check show rows(pagination)
-        self._mixin_test_table_show_rows(table_selector=3D'layerstable')
+        self._mixin_test_table_show_rows(
+            table_selector=3D'layerstable',
+            to_skip=3D[150],
+        )
=20
     def test_distro_page(self):
         """ Test distros page
@@ -685,7 +694,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         # check show rows(pagination)
         self._mixin_test_table_show_rows(
             table_selector=3D'distrostable',
-            to_skip=3D[150]
+            to_skip=3D[150],
         )
=20
     def test_single_layer_page(self):
--=20
2.34.1


