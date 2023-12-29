Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA6AC47072
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 15:10:57 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.150100.1703862648983324946
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Dec 2023 07:10:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=j0x7Frfc;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1CE369C14F4
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 10:10:48 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id aXH0_oQzYSja; Fri, 29 Dec 2023 10:10:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D23689C27A2;
	Fri, 29 Dec 2023 10:10:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D23689C27A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1703862647; bh=PNefWm70TeQUuBTaSpanlS7nZTFnOQyVpG8UDE0cUW4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=j0x7Frfc1yAV3tYOs64tAhGqtUHQNJa9OxYOBrPWl0gBdXGB2ry8v30NCoJipclrE
	 cFR2TYTw3wg+66AyU5iaow2KE7hCXEtjS76N6QeoKeCTII1hrs8UQ5SfxTguZ12cYF
	 6gH4sEP5xojSgaTbPtLD7jSeFgD1Dy92cVL3aCaltJufwhIzgXcD8JCIZetqYHOwwx
	 59cqvsrHuUiaH0BWT6BMwqPUfHXhytFHEK83vVEHj25sgHhDfaheDPioHNlwUaPyY4
	 cBo9Rhlqu0n5OTFEr8sx07tuZIo61rBROMgPksUISKbLGAVs1EvRhPahbmoYn1SOkF
	 TZPFtJUiUfn9A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YlaJm7w3pUnr; Fri, 29 Dec 2023 10:10:47 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 212FA9C14F4;
	Fri, 29 Dec 2023 10:10:47 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/4] toaster/test: bug-fix An element matching "#lastest_builds" should be on the page
Date: Fri, 29 Dec 2023 16:10:22 +0100
Message-Id: <20231229151024.43476-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229151024.43476-1-alassane.yattara@savoirfairelinux.com>
References: <20231229151024.43476-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 15:10:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15720

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/test_project_page_tab_config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index 4dbf5aeb..ee1f5c4b 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -376,7 +376,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
             checkbox.click()
             build_btn =3D self.find('#freq-build-btn')
             build_btn.click()
-            self.wait_until_present('#latest-builds')
+            self.wait_until_visible('#latest-builds')
             wait_until_build(self, 'queued cloning starting parsing fail=
ed')
             lastest_builds =3D self.driver.find_elements(
                 By.XPATH,
--=20
2.34.1


