Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1A4C46CA2
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 22:12:13 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.41457.1702591930951283151
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 14:12:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=TYoxJkn0;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5276B9C3381
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 17:12:10 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id xbvRkg15673P; Thu, 14 Dec 2023 17:12:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F3D499C40F9;
	Thu, 14 Dec 2023 17:12:09 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com F3D499C40F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702591929; bh=01D7FKS+vlZSr9dFZ84Jx9JOQvnfj3jQ0z4nKWN7YMw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=TYoxJkn0T7f8LSyCUQqydbmkap3nUFZOM/pCXu6ZSNmwniHIcCzKZvZ3DGpIfsKyA
	 uZh6FLFtCEoSndNynkFsgMXIV4X8vC9lfCZ1vYIf7JP+SWp6jyh90KTBGL8hv58lgZ
	 TN1aJN5o45vCChuGrN8taac6HZzBJmWx7vqIMBj/SFBr0Jql5+5if52+F2w97e/JQR
	 NF2SYjAStO4ZcXQwuPsA9L3if1SULVyn8NXFoc0jiuSEJ0E2sJrNB+3fzeiztm8/4u
	 HSpqbm8PtLD0LFdKZVQe7MZ29HWxSD/UBaNj+Q+9tDn4yCeQfWNDIUaapNL9svDQPr
	 FB6vx8nSQT57A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LWV9fsU59KTI; Thu, 14 Dec 2023 17:12:09 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E24379C36B1;
	Thu, 14 Dec 2023 17:12:08 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 5/6] toaster/test: Handle case when SSTATE_DIR and DL_DIR not visible in the page project/BitBake variables
Date: Thu, 14 Dec 2023 23:11:56 +0100
Message-Id: <20231214221157.604253-5-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214221157.604253-1-alassane.yattara@savoirfairelinux.com>
References: <20231214221157.604253-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 22:12:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15680

Skip continu runing testcase if SSTATE_DIR or DL_DIR no set in page
Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/test_project_config.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_config.py b/lib/to=
aster/tests/functional/test_project_config.py
index 2d162d81..c70936e1 100644
--- a/lib/toaster/tests/functional/test_project_config.py
+++ b/lib/toaster/tests/functional/test_project_config.py
@@ -162,8 +162,9 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
         try:
             change_dl_dir_btn =3D self.wait_until_visible('#change-dl_di=
r-icon', poll=3D2)
         except TimeoutException:
-            # If download dir is not displayed, test is skipped
-            return True
+            # skip test if becase variable DL_DIR is not set/visible in =
page
+            self.skipTest('DL_DIR is not set/visible in the page project=
/BitBake variables')
+
         change_dl_dir_btn =3D self.wait_until_visible('#change-dl_dir-ic=
on', poll=3D2)
         change_dl_dir_btn.click()
=20
@@ -220,8 +221,8 @@ class TestProjectConfig(SeleniumFunctionalTestCase):
             self.wait_until_visible('#change-sstate_dir-icon', poll=3D2)
             self.click('#change-sstate_dir-icon')
         except TimeoutException:
-            # If sstate_dir is not displayed, test is skipped
-            return True
+            # skip test if becase variable SSTATE_DIR is not set/visible=
 in page
+            self.skipTest('SSTATE_DIR is not set/visible in the page pro=
ject/BitBake variables')
=20
         # path doesn't start with / or ${...}
         input_field =3D self.wait_until_visible('#new-sstate_dir', poll=3D=
2)
--=20
2.34.1


