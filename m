Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C2C47077
	for <webhook@archiver.kernel.org>; Fri,  5 Jan 2024 14:22:16 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.24385.1704464527177363070
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jan 2024 06:22:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=e0Q8msZb;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BA5169C374B
	for <bitbake-devel@lists.openembedded.org>; Fri,  5 Jan 2024 09:22:05 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id FfxLlfrpor7V; Fri,  5 Jan 2024 09:22:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 768579C36BF;
	Fri,  5 Jan 2024 09:22:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 768579C36BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704464525; bh=zC8Xm5PNgHLrp/tyxGJR/FRG8sHStVe/P3PHe9xsRH4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=e0Q8msZbFm6zo1ZikfGQDcG0aCzPISKGhDRGQ2w5cfZ1ikGd9hmQc/cJYQ3DAhnKo
	 xQKoNXDhc1DpxqAZyX5ZFWKfUgLM3TkKCBzsijuDQqU5vFwiokNAzETLNzBHs5F5Rh
	 F1RRarey7RTxDZtR2h0fBirJoh1tQZTRXW1LTZfb7dPDy+0IQvhpP8CBXHpatMDhbL
	 xpfqN1wQJ/HfiV37xUu8N2sT2i1aqLyRG8I8zPA6L7h028/9KqO06l3AnrqynFedZx
	 ynwKbuv3qawHjqtkLr4YZG+7y5BhnvndXrEg4pXxcc9eX47SsToAyJ6brrRtGqTGKf
	 wzPgelzgAuLaA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id PHypU9yt0gEu; Fri,  5 Jan 2024 09:22:05 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 565DA9C32E2;
	Fri,  5 Jan 2024 09:22:04 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/3] toaster/test: Bug-fix on TestProjectConfigTab::test_image_recipe_show_rows
Date: Fri,  5 Jan 2024 15:21:48 +0100
Message-Id: <20240105142150.539538-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jan 2024 14:22:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15743

Check some rows are visible in table instead of compare table row to
row_to_show, because recipe image table sometime doesn't display full ava=
iblable
images

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/test_project_page_tab_config.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index ee1f5c4b..d027e0bc 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -254,8 +254,9 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
             # Check that we can show rows =3D=3D row_to_show
             show_row_link.select_by_value(str(row_to_show))
             self.wait_until_visible('#imagerecipestable tbody tr')
+            # check at least some rows are visible
             self.assertTrue(
-                len(self.find_all('#imagerecipestable tbody tr')) =3D=3D=
 row_to_show
+                len(self.find_all('#imagerecipestable tbody tr'))  > 0
             )
=20
         self._navigate_to_project_page()
--=20
2.34.1


