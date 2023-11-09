Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1401EC4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 22:15:30 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.14838.1699568126832216777
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 14:15:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=HOn0RwIq;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E95FB9C2BAF
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 17:15:24 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IQSjNrwIumPo; Thu,  9 Nov 2023 17:15:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6775A9C2D22;
	Thu,  9 Nov 2023 17:15:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 6775A9C2D22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699568124; bh=ezpjEXnjiQKCtwj2CGI7D0OG2QdsCg2pOXMh7/sOttI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=HOn0RwIqZAaa6on6hIw+739pwJeG/Lns9/wBxycnsH7RgCvPm//bK6AZ4MJzJnpQ2
	 33hZL1VtwkbY+BSy6Lu0X7/jtJXQTQ2nrN2cAZvL8eopwwJCR4Neb1089Q74NZ5ALG
	 bMOahY2HeHbRyJFCJMSB9dFzlZkkTWGBg3tDpirLgMGJ+VlxhYC1u0kk/XLzFcrDG+
	 WY4zVJTjBmVZ359oD5m3NgdtQ2fhLzZnMPAlh6lCniXosy/UrTAXhm7nreVRh4LMji
	 9MmzUGDnHjntVWX49po9w1eJKrWNfQuu6xsT9QCmdNrI69wkZlRO4kbF2xQ/a2Iw9a
	 v4+qi81Wtge/Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id m0eKJt21J1vp; Thu,  9 Nov 2023 17:15:24 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9BB249C2BAF;
	Thu,  9 Nov 2023 17:15:23 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 3/3] Toaster: Write UI TestCase import new project using
Date: Thu,  9 Nov 2023 23:15:17 +0100
Message-Id: <20231109221517.110357-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109221517.110357-1-alassane.yattara@savoirfairelinux.com>
References: <20231109221517.110357-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 22:15:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15489

* Test import new project using:
  - Project Name: Any string
  - Project type: select (Import command line project)
  - Import existing project directory: Wrong Path

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../functional/test_create_new_project.py     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index f33eb16d..a211d8b7 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -149,3 +149,28 @@ class TestCreateNewProject(SeleniumFunctionalTestCas=
e):
         create_btn =3D self.driver.find_element(By.ID, "create-project-b=
utton")
         self.assertIsNotNone(create_btn.get_attribute('disabled'),
                         'Create button is not disabled')
+
+    def test_import_new_project(self):
+        """ Test import new project using:
+          - Project Name: Any string
+          - Project type: select (Import command line project)
+          - Import existing project directory: Wrong Path
+        """
+        project_name =3D 'projectimport'
+        self.get(reverse('newproject'))
+        self.driver.find_element(By.ID,
+                                 "new-project-name").send_keys(project_n=
ame)
+        # select import project
+        self.find('#type-import').click()
+
+        # set wrong path
+        wrong_path =3D '/wrongpath'
+        self.driver.find_element(By.ID,
+                                 "import-project-dir").send_keys(wrong_p=
ath)
+        self.driver.find_element(By.ID, "create-project-button").click()
+
+        # check error message
+        self.assertTrue(self.element_exists('.alert-danger'),
+                        'Allert message not shown')
+        self.assertTrue(wrong_path in self.find('.alert-danger').text,
+                        "Wrong path not in alert message")
--=20
2.34.1


