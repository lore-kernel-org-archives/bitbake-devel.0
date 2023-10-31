Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531FFC4167B
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:42:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.2215.1698774137444010833
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:42:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=qyYqXSHF;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CE6EC9C2BE3
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 13:42:16 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id E5Ve5wkdc4d6; Tue, 31 Oct 2023 13:42:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 56EB99C279F;
	Tue, 31 Oct 2023 13:42:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 56EB99C279F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698774136; bh=wIHbE11BWKitYZkfAFNEA6bXcaZDEe9cTiCXpyD4qwk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=qyYqXSHFC0MMe26a76KVO6cgBq8o8d/ckREQMxVivYWlUX4hUAMajSKAGI3Wl1y78
	 vBDHH4TbDT1PxZjGA38Drtla40rKQwCVD3P7yvk3hzZlRjDyQuH4KSem+Mw8nTsyqi
	 moT8UPJ337x3U31KV75ExEQfd57AIPZfYzUAwtsNJb/4thaF/WZmI8Is0hsKdkFzAZ
	 8dJ0otIwJ8tyHXlk19864AdutwjlrJLd2tMlLwrY2aCP6AtsTOydEcfcyvROZ0aciA
	 e+Z11CgiTRMBd3DZh4JbiTlZ7AzWM1hXiGNEONE9FYqX1NLaaNgSqk5y4maaHrmfNw
	 RA3qeNbZ3vpxw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id mApAPMWBVFHC; Tue, 31 Oct 2023 13:42:16 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 8C9699C2BE3;
	Tue, 31 Oct 2023 13:42:15 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 4/8] Toaster: fixed pytest error: Database access not allowed, use the "django_db"
Date: Tue, 31 Oct 2023 18:41:59 +0100
Message-Id: <20231031174159.696667-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031174159.696667-1-alassane.yattara@savoirfairelinux.com>
References: <20231031174159.696667-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:42:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15376

Pytest failed on functional/test_functional_basic because database access=
 not allowed
- we should use "django_db" fixture to allowed db access

Note: Pytest-django takes a conservative approach to enabling database ac=
cess.
By default your tests will fail if they try to access the database.
Only if you explicitly request database access will this be allowed.

https://pytest-django.readthedocs.io/en/latest/helpers.html#pytest-mark-d=
jango-db-request-database-access

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


