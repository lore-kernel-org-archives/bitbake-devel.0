Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A55C4167B
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 14:17:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.2657.1702390646286856978
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Dec 2023 06:17:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=YsYThc9Q;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A65359C3279
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 09:17:25 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 7fZnbQhQh9Hs; Tue, 12 Dec 2023 09:17:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 54AD19C354B;
	Tue, 12 Dec 2023 09:17:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 54AD19C354B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702390645; bh=AKgTKPe7cA8EeJlipgtHGjBCMwnl/F+pjphzlMfYSsc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YsYThc9QXUekvFUgqLuX/BoGyX62MiFieq4pKwHFV+u8ZpHUfVD9/lHC+Yb957CIH
	 Ysx2XAQjYd2c8iIVmPUzO3LF6PmGkM3U2N4TDBxTJRNg7Vzztcmz8axnaS9oEI3Ilq
	 shdzzY8jnScS2W/oQhDA7VAc4dKrGbtvDwCKR8SoQVIcgjH8jL1AGnXlFFnkV4Xc5T
	 bwaV60fYm0j3Ct7QZuB5WWqvFFN7YExQ/G8/2nq6ZuwKW3wwg4gOH+MkbBuMqCjQuX
	 8wFxOojGM4ZMsXKUvKeKN/LCRaakfV6IOJjRz5HASPnbgI8n0l5xkDqJJwlU9Jjiot
	 IUXlTDCID+EYQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id sYNSX0-u5bEB; Tue, 12 Dec 2023 09:17:25 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 74EA79C3279;
	Tue, 12 Dec 2023 09:17:24 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/4] toaster/test: fix Copyright
Date: Tue, 12 Dec 2023 15:17:07 +0100
Message-Id: <20231212141708.19395-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com>
References: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 14:17:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15653

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/utils.py b/lib/toaster/tests/fu=
nctional/utils.py
index bde1146e..7269fa18 100644
--- a/lib/toaster/tests/functional/utils.py
+++ b/lib/toaster/tests/functional/utils.py
@@ -2,7 +2,7 @@
 # -*- coding: utf-8 -*-
 # BitBake Toaster UI tests implementation
 #
-# Copyright (C) 2023 Savoir-faire Linux Inc
+# Copyright (C) 2023 Savoir-faire Linux
 #
 # SPDX-License-Identifier: GPL-2.0-only
=20
--=20
2.34.1


