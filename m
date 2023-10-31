Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F6BC4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 14:21:21 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.187618.1698762073208219108
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 07:21:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=vgVym3g/;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 09B3D9C0C3C
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:21:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id t2qbAweOaZat; Tue, 31 Oct 2023 10:21:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 940F99C2CD7;
	Tue, 31 Oct 2023 10:21:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 940F99C2CD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698762071; bh=gmS2e99uSFtaRy9I2G+NYeA+4vIX0S9QbGRU2AKkkc8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=vgVym3g/JGTYH7bLg71y+7HMDLTI0M2BDxQJ+HWgBUmIICtZHo2CM8G6YPKWIpeDM
	 l+vLyMzGgENcSd7EDQnMaPaIZx9XdCyewnQqwqbkRArUl/mYCJJO5Ho3Sj6CSWdo0x
	 PYR3OJEoHU12pVm+GKHRmolJv90n5K6JMKOXMOebSqNCVBwn1++bxeNradPmXYl1R7
	 ivx8lsEz8WHIp+DBTclx6YDGVJWLL2IAesiF/eofZ5R34HOli7UiG2pXQ5/ZG46psJ
	 t4vGvYzgPDfB5uWbWXc0kawVFs5J47K/zPwz7aQ0aV+usMqsNYdR3q+svw8fBOopY2
	 c6UW1e9xaL2gg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Zv1NCxJ__0_4; Tue, 31 Oct 2023 10:21:11 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BE0009C0C3C;
	Tue, 31 Oct 2023 10:21:10 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/4] Toaster: Remove unused sleep import from time
Date: Tue, 31 Oct 2023 15:20:36 +0100
Message-Id: <20231031142036.498320-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 14:21:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15336

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_landing_page.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index ecbc0af3..53934fd2 100644
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


