Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F2C4708E
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 22:13:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.1291.1698876814163174734
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 15:13:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=M9dx439g;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D1EDD9C314F
	for <bitbake-devel@lists.openembedded.org>; Wed,  1 Nov 2023 18:13:31 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id AqIIB8PDkV09; Wed,  1 Nov 2023 18:13:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 28EC59C33BA;
	Wed,  1 Nov 2023 18:13:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 28EC59C33BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698876807; bh=vxB9oLD5A8xHGBMUg7J2yIrhOux9Grm13PosrGcRPbE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=M9dx439gVBPr3hTQiIQXSOfIsKAylO2kwvMzZrR5wt7VTl4qSWwNjleKYj60NCbcL
	 byOI2fNwAmXwKzs4rNlva5lQ8Tj4J/Rh3jbJw3QHhCy2/hWlElzu9Q6/zjoLnwdtZl
	 jG7CmtYa/sMe07b9bHcmd5udqoAf+e9M9MEVZJedY/eoyAd/zNUM1UJKXfJs7u2Rq/
	 J6+KhWKsBCaefahSDz/C6RRNmkO61q1QJhVIEyReXX+1DiRd9PiqPpdq0zA2ovAniv
	 9dhbO4fHqSQ9wS6vYH/SoUY+G25gactcwxe9qxCwey6vOnmkZPG2DZ81/x3tBxVArH
	 O/fLLi/Z6iOiQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id QTUFa8_I4Wio; Wed,  1 Nov 2023 18:13:27 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9026A9C314F;
	Wed,  1 Nov 2023 18:13:26 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/8] Toaster: Write UI TestCase create new Mickledore project
Date: Wed,  1 Nov 2023 23:13:09 +0100
Message-Id: <20231101221314.236173-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
References: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 22:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15408

Test create new project using:
  - Project Name: Any string
  - Release: Yocto Project 4.2 "Mickledore" (option value: 4)
  - Merge Toaster settings: True

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../functional/test_create_new_project.py     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index 2b3c98ac..61a470cf 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -55,3 +55,41 @@ class TestCreateNewProject(SeleniumFunctionalTestCase)=
:
                                      "//span[@id=3D'project-release-titl=
e']"
                                      ).text),
                         'The project release is not defined')
+
+    def test_create_new_project_mickledore(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project 4.2 "Mickledore" (option value: 4)
+          - Merge Toaster settings: True
+        """
+        release =3D 'Yocto Project 4.2 "Mickledore"'
+        project_name =3D 'projectmickledore'
+        self.get(reverse('newproject'))
+        self.driver.find_element(By.ID,
+                                 "new-project-name").send_keys(project_n=
ame)
+
+        select =3D Select(self.find('#projectversion'))
+        select.select_by_value(str(4))
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
--=20
2.34.1


