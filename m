Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6E2C001B5
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 22:13:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.1275.1698876813802639349
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 15:13:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=QSskaK7A;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B57099C33C2
	for <bitbake-devel@lists.openembedded.org>; Wed,  1 Nov 2023 18:13:32 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id XBUaulJSGH2Y; Wed,  1 Nov 2023 18:13:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 13CF79C33C3;
	Wed,  1 Nov 2023 18:13:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 13CF79C33C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698876808; bh=3hh0RG7v4lHUwo8O+xRyvs+aVFQkFVJgsvnNgnjOZAE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=QSskaK7A2EZqdlMFDLLmfCVzRkMAEQWOYktltsCfyjh0bsZJ7hn7T3BHY2pCbyF0T
	 nySqEpOWLv0XkkRUNxhbR5Glg0FYqNtWn3tBsXLzId3N4vUHhlZd3ugYcuCtdOS/L+
	 /S+eUofsYtdO39SZiH76QaSD+VeL34lUW2SqgMkUZXjAvioRICGw+lIqgFFF7i2eNX
	 FUQnKyS4ZYFvOErYBloIfVbe5UfkrjAzHSUkxAsB7lni3AyrXM5itvogGz915nK4Vy
	 prE2UXMBFw/FC0DFvl0HAB5GaoPAx4/jWSKwyId0IXeXQFcw3lHaXls4r8PX0no1T5
	 +FbrwaU5+oZdw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GRzx1FZAweZN; Wed,  1 Nov 2023 18:13:28 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 701CD9C314F;
	Wed,  1 Nov 2023 18:13:27 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/8] Toaster: Write UI TestCase create new Kirkstone project
Date: Wed,  1 Nov 2023 23:13:10 +0100
Message-Id: <20231101221314.236173-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
References: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 22:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15406

Test create new project using:
  - Project Name: Any string
  - Release: Yocto Project 4.0 "Kirkstone" (option value: 1)
  - Merge Toaster settings: True

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../functional/test_create_new_project.py     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index 61a470cf..c6345e5b 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -93,3 +93,42 @@ class TestCreateNewProject(SeleniumFunctionalTestCase)=
:
                                      "//span[@id=3D'project-release-titl=
e']"
                                      ).text),
                         'The project release is not defined')
+
+    def test_create_new_project_kirkstone(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project 4.0 "Kirkstone" (option value: 1)
+          - Merge Toaster settings: True
+        """
+        release =3D 'Yocto Project 4.0 "Kirkstone"'
+        project_name =3D 'projectkirkstone'
+        self.get(reverse('newproject'))
+        self.driver.find_element(By.ID,
+                                 "new-project-name").send_keys(project_n=
ame)
+
+        select =3D Select(self.find('#projectversion'))
+        select.select_by_value(str(1))
+
+        # check merge toaster settings
+        checkbox =3D self.find('.checkbox-mergeattr')
+        if not checkbox.is_selected():
+            checkbox.click()
+
+        self.driver.find_element(By.ID,
+                                 "create-project-button").click()
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
--=20
2.34.1


