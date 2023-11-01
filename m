Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE884C41535
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 22:13:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.1277.1698876817028313624
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 15:13:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=oH3A+yLk;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2E0D09C314F
	for <bitbake-devel@lists.openembedded.org>; Wed,  1 Nov 2023 18:13:36 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id asq0b_3Oyjxs; Wed,  1 Nov 2023 18:13:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 80CDE9C33B7;
	Wed,  1 Nov 2023 18:13:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 80CDE9C33B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698876811; bh=94+amjyIgvInxUZ8H9cnNiXLx0xQVg4itWH/vUulgWw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=oH3A+yLkmRONyK8FbYTKKWg3WJ2hj9GmxoAEQTd0REayQRcAGgDfs8iQHKS70CS6I
	 7WQjpR2ANxLzSwgpsZmyxrZ3BK2xmFMnrIztGDc92iOdhDZ+91s/YUGbMlTD9uWBZI
	 rUe1ncyOWGNirotYE7vnQoRE2/+1yfBu8eJFl3wJSGkLEYMxYySY5NJFDQpIke5b82
	 bXUiYUNrjq8wZwZsgcJT5zdk9zQwuIJXYTUWW6vqD55VJUUhh4/ndmcsNwDmkYhgg9
	 5hgYsrfzbt2OI+nLnPzSS2fCi5nxB+aT1RWFKCyC4cKCUK8FsfYAXzHYe/IaD1QSpz
	 Yvm7903NxU3ow==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4bYgBWMCy1Fi; Wed,  1 Nov 2023 18:13:31 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0D8719C314F;
	Wed,  1 Nov 2023 18:13:29 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 6/8] Toaster: Write UI TestCase create new Local project
Date: Wed,  1 Nov 2023 23:13:12 +0100
Message-Id: <20231101221314.236173-6-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
References: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 22:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15410

Test create new project using:
  - Project Name: Any string
  - Release: Local Yocto Project (option value: 2)
  - Merge Toaster settings: True

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../functional/test_create_new_project.py     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index cd690e1a..809635bd 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -170,3 +170,43 @@ class TestCreateNewProject(SeleniumFunctionalTestCas=
e):
                                      "//span[@id=3D'project-release-titl=
e']"
                                      ).text),
                         'The project release is not defined')
+
+    def test_create_new_project_local(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Local Yocto Project (option value: 2)
+          - Merge Toaster settings: True
+        """
+        release =3D 'Local Yocto Project'
+        project_name =3D 'projectlocal'
+        self.get(reverse('newproject'))
+        self.driver.find_element(By.ID,
+                                 "new-project-name").send_keys(project_n=
ame)
+
+        select =3D Select(self.find('#projectversion'))
+        select.select_by_value(str(2))
+
+        # check merge toaster settings
+        checkbox =3D self.find('.checkbox-mergeattr')
+        if not checkbox.is_selected():
+            checkbox.click()
+
+        self.driver.find_element(By.ID, "create-project-button").click()
+
+        element =3D self.wait_until_visible('#project-created-notificati=
on')
+        self.assertTrue(self.element_exists('#project-created-notificati=
on'),
+                        'Project creation notification not shown')
+        self.assertTrue(project_name in element.text,
+                        "New project name not in new project notificatio=
n")
+        self.assertTrue(Project.objects.filter(name=3Dproject_name).coun=
t(),
+                        "New project not found in database")
+
+        # check release
+        self.assertTrue(re.search(
+            release,
+            self.driver.find_element(By.XPATH,
+                                     "//span[@id=3D'project-release-titl=
e']"
+                                     ).text),
+                        'The project release is not defined')
+
+
--=20
2.34.1


