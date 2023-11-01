Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEE4C4167D
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 22:13:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.1293.1698876816615951476
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 15:13:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Yobs/PZc;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3D4279C33C8
	for <bitbake-devel@lists.openembedded.org>; Wed,  1 Nov 2023 18:13:34 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id xwxiPyvBAOkj; Wed,  1 Nov 2023 18:13:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8C4BD9C3369;
	Wed,  1 Nov 2023 18:13:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8C4BD9C3369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698876809; bh=QfAutchq3OXSpFpcnwEuqM/AVOsnC0WyTeiyzaGwJjs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Yobs/PZc4d6WqqpW5xbziVYkKEWggE+bmt2RW2p4uwS8bVRG+6fmyAkmpOmaRfwly
	 qE3/FSW1i+8wQ8KsMdoVu8AoYg/YzGSMaw0TDMYZKj3jL5sJPQDdAZFI9kYQZxBrkQ
	 KWlFbjOgdixRDyL194xtkQPlmeISm3tWtH7sWxQ6w75MDfSfGU3lisiFI4Pd31okYA
	 xqel7WwnStYKojcynLkHrq0qTOfeJnPHP3gxnmrkzEYIRtW9A9lE7dGnR7BAWRkZgH
	 KrXZx8k2CnEf5zLmPbhEhcFdczaGe3hQWm3DcnvjVOytb5P7FxxDG8JnZyUdyolAbp
	 eeINVapnAfbxg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id e0Rced-aqntS; Wed,  1 Nov 2023 18:13:29 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 82A709C314F;
	Wed,  1 Nov 2023 18:13:28 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 5/8] Toaster: Write UI TestCase create new Dunfell project
Date: Wed,  1 Nov 2023 23:13:11 +0100
Message-Id: <20231101221314.236173-5-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
References: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 22:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15409

Test create new project using:
  - Project Name: Any string
  - Release: Yocto Project 3.1 "Dunfell" (option value: 5)
  - Merge Toaster settings: False

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../functional/test_create_new_project.py     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index c6345e5b..cd690e1a 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -132,3 +132,41 @@ class TestCreateNewProject(SeleniumFunctionalTestCas=
e):
                                      "//span[@id=3D'project-release-titl=
e']"
                                      ).text),
                         'The project release is not defined')
+
+    def test_create_new_project_dunfull(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project 3.1 "Dunfell" (option value: 5)
+          - Merge Toaster settings: False
+        """
+        release =3D 'Yocto Project 3.1 "Dunfell"'
+        project_name =3D 'projectdunfull'
+        self.get(reverse('newproject'))
+        self.driver.find_element(By.ID,
+                                 "new-project-name").send_keys(project_n=
ame)
+
+        select =3D Select(self.find('#projectversion'))
+        select.select_by_value(str(5))
+
+        # check merge toaster settings
+        checkbox =3D self.find('.checkbox-mergeattr')
+        if checkbox.is_selected():
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
--=20
2.34.1


