Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F32C4167B
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 22:15:30 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.14837.1699568124760222549
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 14:15:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=wAHVKJh5;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CD5B39C34B2
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 17:15:23 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Q31qvlLYkji7; Thu,  9 Nov 2023 17:15:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 43BB09C2D22;
	Thu,  9 Nov 2023 17:15:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 43BB09C2D22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699568123; bh=PwLzQk6tNo/0wOagfMqwlwu6q8x6/om/Xt3pF54+ydw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=wAHVKJh5nbMSOpoAim9xL/DsNjh9gyfNIyU0rXNtST/hbWetEMBrr1YQBN2DQOxaS
	 xqAHkRAB7z1ZlL05ZgQ8jHxJjYMIaGqjhveq7shCHCw9h/n0rDM5l8SLyv0J6RsHRt
	 s4iCxGDWWp2ZGvLVA0cMKRIHDO5IaepLL16zI/zmLnMC1/Ahfi2ogahnfbB86bN4QO
	 yWau20DzYhgGYR55LE2nGHplkdtK42rfoT0H1PgnYDg6acQZWpQoyzQZ8coxX76Ohp
	 Vzem8GAnZf7rL5QHpz3DaZe3ysN8RH+AZrqv+MSALng71TKYbNWZOnY8hB5A423bCy
	 FiWVmxGv6HGzQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lx6rulK4paaH; Thu,  9 Nov 2023 17:15:23 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 637339C2BAF;
	Thu,  9 Nov 2023 17:15:22 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 2/3] Toaster: Test create new project without project name
Date: Thu,  9 Nov 2023 23:15:16 +0100
Message-Id: <20231109221517.110357-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109221517.110357-1-alassane.yattara@savoirfairelinux.com>
References: <20231109221517.110357-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 22:15:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15488

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_create_new_project.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index 81355eaf..f33eb16d 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -132,3 +132,20 @@ class TestCreateNewProject(SeleniumFunctionalTestCas=
e):
             release_title,
             True,
         )
+
+    def test_create_new_project_without_name(self):
+        """ Test create new project without project name """
+        self.get(reverse('newproject'))
+
+        select =3D Select(self.find('#projectversion'))
+        select.select_by_value(str(3))
+
+        # Check input name has required attribute
+        input_name =3D self.driver.find_element(By.ID, "new-project-name=
")
+        self.assertIsNotNone(input_name.get_attribute('required'),
+                        'Input name has not required attribute')
+
+        # Check create button is disabled
+        create_btn =3D self.driver.find_element(By.ID, "create-project-b=
utton")
+        self.assertIsNotNone(create_btn.get_attribute('disabled'),
+                        'Create button is not disabled')
--=20
2.34.1


