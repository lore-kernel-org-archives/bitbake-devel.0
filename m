Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5088C4167B
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 21:55:09 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.14132.1699566904205916298
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 13:55:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Sw5baC02;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8C9729C2CD7
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 16:55:01 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id vKTgDCyi0MXF; Thu,  9 Nov 2023 16:54:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 63B8F9C3279;
	Thu,  9 Nov 2023 16:54:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 63B8F9C3279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699566899; bh=UMsqjOmiwQ/x6Qa/Lv5LWs5O4pYWi2OTxYYh7ViM1d8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Sw5baC020aCe0l47pAdNjA7bQJ1muk7QHR446iYO6y1ewPlwRjvOQ4+G1gel/u1+2
	 JnFnOk5leLX6bKVR0wYy8MwxRTFjOcLcL8yrhmh9izkYdPB73jmb8GmJmMWvRcCK/h
	 85eM7BTp7QeUZnn6alcjsXlmKyw/e7pXXDMqIX/gJp2aR/3SfIdXRKydFxGnojO7in
	 73P2ArfQg+N6884bma8nr2PWJzvm1dWrJu5iydIGRWL8zcHdg/sAtqQk6ZqDEUuJ1d
	 z4i9688yo0rITxWGh7MIuo3Ajl9Teq7wZeO6zDVqkH6qmy2acZbhhyeRDGMfdkmy37
	 nocgxSGdw0QgA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ZxuJKc6A6m4B; Thu,  9 Nov 2023 16:54:59 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 63CC49C2CD7;
	Thu,  9 Nov 2023 16:54:58 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 3/3] Toaster: Write UI TestCase import new project using
Date: Thu,  9 Nov 2023 22:54:51 +0100
Message-Id: <20231109215451.90799-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109215451.90799-1-alassane.yattara@savoirfairelinux.com>
References: <20231109215451.90799-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 21:55:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15486

* Test import new project using:
  - Project Name: Any string
  - Project type: select (Import command line project)
  - Import existing project directory: Wrong Path
* Update copyright, remove "Inc"

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


