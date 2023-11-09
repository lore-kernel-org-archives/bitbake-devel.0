Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2231C04E85
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:15:33 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.1088.1699550126793172939
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 09:15:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=yR/qsVDp;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 796379C34D2
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 12:15:25 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0TYpyUYXQDnZ; Thu,  9 Nov 2023 12:15:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7CF819C34CB;
	Thu,  9 Nov 2023 12:15:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7CF819C34CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699550124; bh=9ZmjA4jVXRKl7D0tU2mh3T4CRmbXyy0ig+56aOGFxaw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=yR/qsVDpNfH/LGJRMEpPK6yeWeZmWmoZBc/Ma66XmYwdxmsRxXttOA2vf0if2sqL6
	 L1KEGEsF5h6GAZDxYa30xKtEKKQq4w1A8UJRvJCR2qeshZ5bxqcwcv6+1Xv2GWrrgl
	 8z40Ju+Mw5vuoC30u1TNu0ml3I2pwaXskBrV1eZyG7ccbIhaaRlqoz2r8AHNeiXVgt
	 stRTQZU5YmMubhLuSOkMiMg36UEnz9GWEfxPvcVtTv+jjBsY5YMzahVuKCX/iezGDl
	 biT1sDJG9y5emDl0XXBR+OxY13s0sM6PD9wuackQ7SyCDC75+4illRiQWVEGdqIxmF
	 e0DBGW/JHMFRw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GvIB4Xaqxg9p; Thu,  9 Nov 2023 12:15:24 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9BB7B9C326C;
	Thu,  9 Nov 2023 12:15:23 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v4 6/7] Toaster: Move toaster tests requirements in bitbake/lib/toaster/toaster-tests-requirements
Date: Thu,  9 Nov 2023 18:15:01 +0100
Message-Id: <20231109171502.205787-6-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109171502.205787-1-alassane.yattara@savoirfairelinux.com>
References: <20231109171502.205787-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 17:15:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15476

To make difference between bitbake and toaster python requirements,
a dedicated requirements file is created for toaster in root of toaster d=
ir.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/toaster-tests-requirements.txt | 5 +++++
 toaster-requirements.txt                         | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toast=
er/tests/toaster-tests-requirements.txt
index f30ac070..7109c625 100644
--- a/lib/toaster/tests/toaster-tests-requirements.txt
+++ b/lib/toaster/tests/toaster-tests-requirements.txt
@@ -1 +1,6 @@
 selenium>=3D4.13.0
+pytest=3D=3D7.4.2
+pytest-django=3D=3D4.5.2
+pytest-env=3D=3D1.1.0
+pytest-html=3D=3D4.0.2
+pytest-metadata=3D=3D3.0.0
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index 19bf6fd2..d8e48b7f 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -2,8 +2,3 @@ Django>4.2,<4.3
 beautifulsoup4>=3D4.4.0
 pytz
 django-log-viewer=3D=3D1.1.7
-pytest=3D=3D7.4.2
-pytest-django=3D=3D4.5.2
-pytest-env=3D=3D1.1.0
-pytest-html=3D=3D4.0.2
-pytest-metadata=3D=3D3.0.0
--=20
2.34.1


