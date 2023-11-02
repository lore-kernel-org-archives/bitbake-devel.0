Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA5C41535
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 15:02:48 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.33216.1698937364502689540
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Nov 2023 08:02:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=QV8kQQ4W;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DA98C9C339D
	for <bitbake-devel@lists.openembedded.org>; Thu,  2 Nov 2023 11:02:43 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id TXCIK7zKOa4c; Thu,  2 Nov 2023 11:02:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2F0539C33EB;
	Thu,  2 Nov 2023 11:02:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 2F0539C33EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698937359; bh=dlpewRHaAdaiGlJWMnTxPU5YT6h5ECfRWk7umOt3qCY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=QV8kQQ4WJk7RAqYVmo/T5Ar5IM8ASrcvqg7M8Cn12TyG0zYeXecBrXNssHU6+/xK4
	 cISy2FWw39CePZidc+yeeF6g+Hk1HRAuK9dsz3jOqyKnJ2MRPnsK+h3bJnz+UUf0jW
	 mnE3eCZJIGI8J1EGM1hpKSJsj5naRqeIA8DNPmBPaRFrHH5fkzANcJ3PqbRCwvJsBM
	 3ZeW4IixoULupKA87otoDoff8L5ooBpqeL6mnxdixhaQvC2F3ljMeD6ZFfRAn1usup
	 oUQm0s/lrtXfsRrtjYqw4V3L1hZQQkS+oOrBH4LQaCY+tgV6dKdt7z6w8g6T8ZQU4g
	 FAC6+sytOx+bQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xc02qBxmHD-z; Thu,  2 Nov 2023 11:02:39 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 448AD9C2C1B;
	Thu,  2 Nov 2023 11:02:38 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 4/4] Toaster: Toaster: Remove unused sleep import from time
Date: Thu,  2 Nov 2023 16:02:27 +0100
Message-Id: <20231102150227.363289-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102150227.363289-1-alassane.yattara@savoirfairelinux.com>
References: <20231102150227.363289-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Nov 2023 15:02:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15418

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_landing_page.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index 756497bd..7b425344 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -7,7 +7,6 @@
 # Copyright (C) 2013-2016 Intel Corporation
 #
=20
-from time import sleep
 from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
--=20
2.34.1


