Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FCDC001DD
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 22:13:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.1279.1698876819852399146
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 15:13:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=b3arW6z2;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 34D569C33B7
	for <bitbake-devel@lists.openembedded.org>; Wed,  1 Nov 2023 18:13:38 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id GbRTyXzWW6Oi; Wed,  1 Nov 2023 18:13:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9094B9C33C3;
	Wed,  1 Nov 2023 18:13:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 9094B9C33C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698876813; bh=Rh/H/sqqHP3Eyr13bP2o8vSgpdS62ySBYxkSeJohA28=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=b3arW6z2gGjb9rHLfEE8HNgHQYlnob9xcGeUETuNZocX2J/xWW5tKAEtc/xTdVaNW
	 CaSPcml7mQcNwhLJCwlrFhthsg8HPqdr2JQ9uo80S32oyBLIqxxOSvY0yluVWXM8km
	 B7NLSokbeM+/BqmU5PfW2PGBQWm0yhxRNlFer+vUWq3/3QzIsn6raHK6NJ26KW1Mrq
	 rl07ccNIEoz1zCznyaOx66siJRm/aWZf9/XaPQPEAW+c4zfyUtCc3u0fa06nX3HfFA
	 4T/DzBxQjZbyWZ5LvI3ZV97SDxtndMQyEYJ0n2HyAGPtm+R+aiF0PczVZDhjPGghpc
	 ik1STN+INeKxw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 3rq0YZWsSmXr; Wed,  1 Nov 2023 18:13:33 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 650429C33BA;
	Wed,  1 Nov 2023 18:13:31 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 7/8] Toaster: Test create new project without project name
Date: Wed,  1 Nov 2023 23:13:13 +0100
Message-Id: <20231101221314.236173-7-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
References: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 22:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15411

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_create_new_project.py   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index 809635bd..54e6231e 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -209,4 +209,19 @@ class TestCreateNewProject(SeleniumFunctionalTestCas=
e):
                                      ).text),
                         'The project release is not defined')
=20
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
=20
+        # Check create button is disabled
+        create_btn =3D self.driver.find_element(By.ID, "create-project-b=
utton")
+        self.assertIsNotNone(create_btn.get_attribute('disabled'),
+                        'Create button is not disabled')
--=20
2.34.1


