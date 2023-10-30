Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E6C41535
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:51:14 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.159176.1698695472665929342
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=GA9vUfWW;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E72089C334C
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 15:51:11 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 8JT4GPrCUOPf; Mon, 30 Oct 2023 15:51:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7D05A9C332D;
	Mon, 30 Oct 2023 15:51:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7D05A9C332D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698695471; bh=DRXCA7E2TGMUv0v25Wxw/oByR5RBeNsF5Xe+aiJyKEI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=GA9vUfWWz2tTyHVHL5HO1v8BJuiLYvNy+u2gYSBLjMm1yWSsv2HwJIKY+aC28U/q2
	 pQGPYug7IF8GQjok5mqBdwj+Pau8rFFrldfAWzhSSFS9DA+k2uzYLYOYcVYmZL7eBO
	 RyMrLhqkyMbGLDPjIFPZFo9LOSfytx+8RXwvEoNazEvSRT5UJ+KWwPUbZq/2jbXbab
	 jsGC9ozE0Lliuy+vTHQvQhMr097OLx7LNlYJrJFBY1ysUOF5pNunwwKdE2xKm54+Zr
	 tJby3DARUf9lt6vOhhgGJUbZJcu0ZjXudZ/Gqtn2ez3Sen1tOCRdhAWdpdR5MX9Sbn
	 adS8jDlIkLWFQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hx2XC9jjUKx8; Mon, 30 Oct 2023 15:51:11 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 787729C2848;
	Mon, 30 Oct 2023 15:51:10 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/8] Toaster: fixed pytest error: Database access not allowed, use the "django_db"
Date: Mon, 30 Oct 2023 20:50:33 +0100
Message-Id: <20231030195037.232912-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:51:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15328

Pytest failed on functional/test_functional_basic because database access=
 not allowed
- we should use "django_db" fixture to allowed db access

Note: Pytest-django takes a conservative approach to enabling database ac=
cess.
By default your tests will fail if they try to access the database.
Only if you explicitly request database access will this be allowed.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/test_functional_basic.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/=
toaster/tests/functional/test_functional_basic.py
index b0def544..7e9be91c 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -8,6 +8,7 @@
 #
=20
 import re, time
+import pytest
 from django.urls import reverse
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from orm.models import Project
@@ -16,6 +17,7 @@ from selenium.webdriver.common.by import By
 class FuntionalTestBasic(SeleniumFunctionalTestCase):
=20
 #   testcase (1514)
+    @pytest.mark.django_db
     def test_create_slenium_project(self):
         project_name =3D 'selenium-project'
         self.get(reverse('newproject'))
--=20
2.34.1


