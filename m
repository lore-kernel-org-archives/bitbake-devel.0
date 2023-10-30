Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD610C4167B
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:51:14 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.159369.1698695471897144561
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=WE2OMUnI;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C7C499C2A91
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 15:51:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id weXqdv0XqFJJ; Mon, 30 Oct 2023 15:51:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 23C2D9C3231;
	Mon, 30 Oct 2023 15:51:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 23C2D9C3231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698695470; bh=SN/3n4SflF+dxPR7+x95Wn5UYFxlw/gh2fXVVpRUu14=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=WE2OMUnIfiM183bFYCdnxhWC0LhdjqX4DtqIYEgMfyIQzd3DzAjF11iMccUKQg/FW
	 f8VyjgxjwBRx7Zj2hmYYgxU61o28Z7JC/gQUG7nV4kGG0t9Kw+lzG/CPVHexq7Pp6w
	 S1pnIBdb/VmisjvI5Pek1Enix2Tq+o8baNg8tbvoPnGZ7hmBSkOjTxXm5PTWLEOmJY
	 L5fWop/Dk5hqj6Yx8W9Xp0K4zKxnYrqvYSWO2cD95CbtRPzPQRLkFmFuyiEyOz36T8
	 eFIz2rpTDQwDGJ8K6k4JccXr/H4w74W1CZ53GxOHSlqIxWbXp6pblqMK0lpHBncxgL
	 iE8ZHWdmiXdyQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GXKGAUgZsxQ8; Mon, 30 Oct 2023 15:51:10 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 405929C2848;
	Mon, 30 Oct 2023 15:51:09 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/8] Toaster: Bug-fix pytest and Failed: Database access not allowed
Date: Mon, 30 Oct 2023 20:50:32 +0100
Message-Id: <20231030195037.232912-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:51:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15327

Remove load and create build environment from tests/functional/functional=
_helpers

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/functional_helpers.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toa=
ster/tests/functional/functional_helpers.py
index c3191f66..b80d403b 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -15,8 +15,6 @@ import time
 import re
=20
 from tests.browser.selenium_helpers_base import SeleniumTestCaseBase
-from tests.builds.buildtest import load_build_environment
-from bldcontrol.models import BuildEnvironment
 from selenium.webdriver.common.by import By
 from selenium.common.exceptions import NoSuchElementException
=20
@@ -33,10 +31,6 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase)=
:
             raise RuntimeError("Please initialise django with the tests =
settings:  " \
                 "DJANGO_SETTINGS_MODULE=3D'toastermain.settings_test'")
=20
-        if BuildEnvironment.objects.count() =3D=3D 0:
-            BuildEnvironment.objects.create(betype=3DBuildEnvironment.TY=
PE_LOCAL)
-        load_build_environment()
-
         # start toaster
         cmd =3D "bash -c 'source toaster start'"
         p =3D subprocess.Popen(
--=20
2.34.1


