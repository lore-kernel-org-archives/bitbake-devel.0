Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DBDC4167B
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:15:33 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.1002.1699550123948453454
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 09:15:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=LhhtwrBV;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 899349C34C9
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 12:15:22 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id BM_oj3I88g0d; Thu,  9 Nov 2023 12:15:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0CF539C3290;
	Thu,  9 Nov 2023 12:15:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0CF539C3290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699550122; bh=wIHbE11BWKitYZkfAFNEA6bXcaZDEe9cTiCXpyD4qwk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=LhhtwrBVo6+xhnzzWxI0nGp+MyzdRi6hGSeWA7z9C9SbfiZAfpe3QgXV+Nf2i+u3I
	 xw6H2Us6HbtQVBAJWuIrdsmcbxNrRoGAmeXEo5UYa35n0UgYB4kRgRBcV+7V012zZL
	 tibMDNNXT3cw0wwG6lRfnVOmrHSzImPPOd6BJKgxA5fQ1f2rpEQvHxhi26zeQN9Cy6
	 +1tQ2FNZy8wAooHS0MZMx4DHGUZvd5pyPm99FczZwyWtcI9g6m0Z0jq6YV21DUsWcP
	 GH9wdV4T7sla9Hn0NidJ8l1VbSBgrEsbuly7G/xWBerHU7yjPEdofrARxJAWVVzTCX
	 gQOMScmcjpptg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id aZQwWRP1v-IR; Thu,  9 Nov 2023 12:15:22 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2BCF89C326C;
	Thu,  9 Nov 2023 12:15:20 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v4 4/7] Toaster: fixed pytest error: Database access not allowed, use the "django_db"
Date: Thu,  9 Nov 2023 18:14:59 +0100
Message-Id: <20231109171502.205787-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109171502.205787-1-alassane.yattara@savoirfairelinux.com>
References: <20231109171502.205787-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 17:15:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15474

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


