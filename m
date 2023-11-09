Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E101C04E85
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 17:44:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.333.1699551862124316370
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 09:44:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Y+NwjNrQ;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 179099C34BF
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 12:44:21 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id BA_S5W9hNYv9; Thu,  9 Nov 2023 12:44:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7E5769C328E;
	Thu,  9 Nov 2023 12:44:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7E5769C328E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699551860; bh=wIHbE11BWKitYZkfAFNEA6bXcaZDEe9cTiCXpyD4qwk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Y+NwjNrQsM3KwNrbtOeIlfEItMq1YKGElGu4BLDdobw7xDs1kNbP01pX1tBh3wFr9
	 Oc1Hc2FF0BlB9I3HPxlRkDCTYr/Z9EyGpf/iTXi0kYHm1oglZ8j9oDwDJTir11lIbs
	 sQfV9thEKgkw1oM1nL6R9zC7H5r1D8CcQWUZRikV33r6deOUZegqKtDVn1WoMd48Iy
	 h9D43vvokBd3d/adRTqktMtYKhjdXkE9PKhE18aNLU/2wCzcAdcG2FVSDT/cOr+GjW
	 qks7o1cp9T1RTfRftGEfnbH/Ks4cTuHOOIAHEJVbqWawnKyT4B4gzYhIYLINTVJYgw
	 5MO6kjreKM0aw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 3TrpI1Wuby5K; Thu,  9 Nov 2023 12:44:20 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9ABFE9C327A;
	Thu,  9 Nov 2023 12:44:19 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v5 4/6] Toaster: fixed pytest error: Database access not allowed, use the "django_db"
Date: Thu,  9 Nov 2023 18:44:10 +0100
Message-Id: <20231109174412.257199-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109174412.257199-1-alassane.yattara@savoirfairelinux.com>
References: <20231109174412.257199-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 17:44:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15481

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


