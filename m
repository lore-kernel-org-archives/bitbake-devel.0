Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B503DC4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 21:55:09 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.14131.1699566902600490532
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 13:55:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=MzuqogcO;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 81E5B9C3361
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 16:54:58 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 971XcfVbtccw; Thu,  9 Nov 2023 16:54:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0D9AC9C3279;
	Thu,  9 Nov 2023 16:54:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0D9AC9C3279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699566898; bh=PwLzQk6tNo/0wOagfMqwlwu6q8x6/om/Xt3pF54+ydw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=MzuqogcOPWDl0fmFmR/2Dl4xN7wLfxvjdTRIPj8jnGsBsFlm6Gu6USGgVXsfkcM3I
	 Ir7sql5rKDUxJf0CmFdAuHsHCeCTd5f6C7VzstZMdprYADbmObApw1joYtPplEBfll
	 fZsqV4JWBExCMJXSY3/7a8EDtBaSmfStu38O66BCGX8mKGnYdz5Vh8tPAo2fyhPcxR
	 e1MOAo3afMRKjpvX7h+aASzvdih7XiUQ5zH95dkrTduzPon8vVwoADgLsORqs4LCZS
	 q636MivSDX7Y1Rdn7EDE+p1aJPp19Jh2RH5cpsn5RruMG3lwKIwho7qIRt3CAm5osB
	 MyW+VbCgRb3Qg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ovU6ai1Xv6Jq; Thu,  9 Nov 2023 16:54:58 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2C1DC9C2CD7;
	Thu,  9 Nov 2023 16:54:56 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 2/3] Toaster: Test create new project without project name
Date: Thu,  9 Nov 2023 22:54:50 +0100
Message-Id: <20231109215451.90799-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109215451.90799-1-alassane.yattara@savoirfairelinux.com>
References: <20231109215451.90799-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 21:55:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15484

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


