Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5973DC00142
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:42:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.2213.1698774136613706751
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:42:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=XnMZ1ucH;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 01E969C2BF6
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 13:42:16 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id YqFXr_6h4Abi; Tue, 31 Oct 2023 13:42:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3749D9C279F;
	Tue, 31 Oct 2023 13:42:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3749D9C279F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698774135; bh=GesLj5+Tfp6+cElUD4N1oiRTqPVAwnFMvCqk+qYl7BU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=XnMZ1ucHcaiH9jdA9PlBvIKkrD/j2U23yfsgjBuD400Cbe/Bs9Fda4SCOS8c2GCV4
	 XZTtNbwHoelWKI73zvngHF6OXlzsPFJvpNZ5XKWiYJbaT3bIR2q38RWJI/+XN8KQcu
	 4w7OFrUVEPuw7f8G33vxoOUWZYqRFBdi8wCMqOPqkLy1nwD2Lfc6oQLzFMm5//CGHJ
	 1L5zNnljlOuV7eY5pbMd8pN2NRguS96pPwYY6wri8/5x9LPX79E1WaVzbLH6af9T7J
	 acM2qAKPoLYoY0yhuIHaqF3Srl5NWpuFMfb17znxB6yreoIcIHTzSJENtOrmuhUWVS
	 QRsNKP1auq8bw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Dbl_4fymVjn2; Tue, 31 Oct 2023 13:42:15 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 54AF29C2BE3;
	Tue, 31 Oct 2023 13:42:14 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 3/8] Toaster: Bug-fix pytest and Failed: Database access not allowed
Date: Tue, 31 Oct 2023 18:41:58 +0100
Message-Id: <20231031174159.696667-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031174159.696667-1-alassane.yattara@savoirfairelinux.com>
References: <20231031174159.696667-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:42:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15375

Remove load and create build environment from tests/functional/functional=
_helpers
- Testcases in the FunctionalTestCase do not require a build process,
- Also marked setUpClass or class with pytest django_db, db ... not
  working, as declared above of file functional_helpers.py, The database =
access
  process runs as an external process, separate from the test case proces=
s
  and outside the context of pytest.

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


