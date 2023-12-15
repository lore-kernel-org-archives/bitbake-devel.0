Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A13C46CC5
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 09:39:18 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.58983.1702633149965723331
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Dec 2023 01:39:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=kVrbHYYg;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 54CA29C3636
	for <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 04:39:09 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 4Z4vox02gWlj; Fri, 15 Dec 2023 04:39:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E81349C117B;
	Fri, 15 Dec 2023 04:39:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E81349C117B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702633148; bh=yzpYLDWp8OgVhkGJY/xD+3sUXtT8iO2OfLWiEJH/TzA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=kVrbHYYgG/AUH/RJ1T3U+fIcNRPZc7D9zN+YWHZn0JLAxPunzlWUlim5g+8aCIKNQ
	 Eotq1uYHz5hyO/jGhd0TwEDIsAmpZAaUVdU80kwZZWfoF3Z98psn0FxUvstW+jQJA6
	 kcuMGyjjjaVh3jw3fdyrc8nlcpGNqrRanNJ6YWhlXYvXbrhjuCP1tP5Dvne2PVFarQ
	 IG22/p12mJVU0ZSQgcuoTBA1uQ6ptvLfZp1Sp3GZLbJhanfMMmLxUnY48CqeJ7Jh5a
	 JTn87Fmj9MdzMSHmNkc0j4BXFT8DlB2Lt2j2zvhm9uN1b+lZvMv0tnVMhvRoDAB43x
	 29nY21XKZ9tYg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xkAQ3-xgb0Lv; Fri, 15 Dec 2023 04:39:08 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1179B9C3636;
	Fri, 15 Dec 2023 04:39:07 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 4/5] toaster/test: Handle case when SSTATE_DIR and DL_DIR not visible in the page project/BitBake variables
Date: Fri, 15 Dec 2023 10:38:38 +0100
Message-Id: <20231215093839.99358-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215093839.99358-1-alassane.yattara@savoirfairelinux.com>
References: <20231215093839.99358-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 09:39:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15685

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


