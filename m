Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD4CC47077
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 15:10:57 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.150609.1703862651248127095
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Dec 2023 07:10:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=I2YQzrZC;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 746089C354C
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 10:10:50 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id mbPQXA7v2rfT; Fri, 29 Dec 2023 10:10:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3533E9C14F4;
	Fri, 29 Dec 2023 10:10:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3533E9C14F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1703862650; bh=Da4MFoe7vd+BTMJ1kjy5jagz4edPKUMS0oWTBlizi7A=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=I2YQzrZC7PaVDmpzGl6O6okFmxCY50NlSEl6hYVSe9M2gNXCoNyVR8nfe/dHu0cSV
	 Jm+qAEDVWbUSH/vJepf8s8ZTmVswfkBSirOgmpRZiYPHFAhuyvP/2TzclDwFWysRvQ
	 wAfubNJ6nRyzxPnde5VtbkG16WTh0uzDte6AS1m6xJL1VgPs5Kvc58RRGhzsA4FMz0
	 lo/Va9HvuNcO/NQGbKvs3ko/DVFM7x+GLl3PjNcFnnyggI+EWO5EVMoftj8EOkS+ae
	 Z6ZSwm/okrA92O+IqQee/DEzhesDIFI+LTRkl0Zg5zcF6XNBzMBXTr3WsHuqxzwTZM
	 SK0nc/5miZF5A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id KTprohvF5BwS; Fri, 29 Dec 2023 10:10:50 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5323E9C27A2;
	Fri, 29 Dec 2023 10:10:49 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/4] toaster/test: Bug-fix "#project-created-notification" should be visible
Date: Fri, 29 Dec 2023 16:10:24 +0100
Message-Id: <20231229151024.43476-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229151024.43476-1-alassane.yattara@savoirfairelinux.com>
References: <20231229151024.43476-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 15:10:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15723

Added more delay between click on create project but and when notificatio=
n is displayed

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/test_create_new_project.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index bbda0cf4..9f880107 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -49,7 +49,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
=20
         self.driver.find_element(By.ID, "create-project-button").click()
=20
-        element =3D self.wait_until_visible('#project-created-notificati=
on')
+        element =3D self.wait_until_visible('#project-created-notificati=
on', poll=3D3)
         self.assertTrue(
             self.element_exists('#project-created-notification'),
             f"Project:{project_name} creation notification not shown"
--=20
2.34.1


