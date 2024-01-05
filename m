Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD636C4707B
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 14:22:16 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.24449.1704464528450028408
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jan 2024 06:22:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=QOd+zrcX;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BFEF19C32E2
	for <bitbake-devel@lists.openembedded.org>; Fri,  5 Jan 2024 09:22:07 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CRURm740AcJn; Fri,  5 Jan 2024 09:22:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 756FD9C36BF;
	Fri,  5 Jan 2024 09:22:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 756FD9C36BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704464527; bh=aRvGit+uCsedASZQbwgQKoVmmSUwBtAEJlW9TaYMzjw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=QOd+zrcXWEu3gtVS+XUBoQj+pGafTx/A3s1BZ3whJqHofLNvCownF1R8QEbR+/qoV
	 IqCnRkyid3aYeJWdmEih39PBzSXXvSTXPlIZKBt+bFkyvP/n+59RzqBwctJiEVxpW2
	 RspIkuPuJ2ucTnIpE/idMChCDMfS2n2L7IG1qEGySSg0QZ3kKtz23h4NFF+SsfTIWN
	 QvFUWIdEkwu3yiFc+fqEh5ck6XP1uNMRDM4vp2jPh8DecL1aJHujJPRtx3B5ZknMLw
	 qAhhB27GDRSu6qazPWMQAb4EBDM9R2euCM1gq5P5XQmwh5OzFRer9FbGp2MhsZsjtk
	 G7+j+DmfxvI+g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8LS1YPgWvGRG; Fri,  5 Jan 2024 09:22:07 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 92DBC9C32E2;
	Fri,  5 Jan 2024 09:22:06 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/3] toaster/test: Delay driver first action on create new project page
Date: Fri,  5 Jan 2024 15:21:50 +0100
Message-Id: <20240105142150.539538-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105142150.539538-1-alassane.yattara@savoirfairelinux.com>
References: <20240105142150.539538-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jan 2024 14:22:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15745

Wait for element visible on create new project page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_new_project_page.py      | 1 +
 lib/toaster/tests/functional/test_create_new_project.py | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toa=
ster/tests/browser/test_new_project_page.py
index 0c33c44f..70b55f3c 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -47,6 +47,7 @@ class TestNewProjectPage(SeleniumTestCase):
=20
         url =3D reverse('newproject')
         self.get(url)
+        self.wait_until_visible('#new-project-name', poll=3D3)
         self.enter_text('#new-project-name', project_name)
=20
         select =3D Select(self.find('#projectversion'))
diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index 9f880107..94d90459 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -32,6 +32,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
           - Merge Toaster settings: True or False
         """
         self.get(reverse('newproject'))
+        self.wait_until_visible('#new-project-name', poll=3D3)
         self.driver.find_element(By.ID,
                                  "new-project-name").send_keys(project_n=
ame)
=20
@@ -111,7 +112,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase=
):
         """
         release =3D '5'
         release_title =3D 'Yocto Project 3.1 "Dunfell"'
-        project_name =3D 'projectdunfull'
+        project_name =3D 'projectdunfell'
         self._create_test_new_project(
             project_name,
             release,
--=20
2.34.1


