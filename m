Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2D4C4167B
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 15:56:36 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.125364.1699545387034909572
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 07:56:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=WzobM6SW;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 60F9C9C34B2
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 10:56:26 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id e85gA6b3vIuZ; Thu,  9 Nov 2023 10:56:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DF3139C2CF2;
	Thu,  9 Nov 2023 10:56:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com DF3139C2CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699545385; bh=wIHbE11BWKitYZkfAFNEA6bXcaZDEe9cTiCXpyD4qwk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=WzobM6SWqivxIR9DYsC8BVlg3wgPQpI/FmAug7vS1XgWQt9SIYELMS0VM8mQxNBZO
	 4JNIJcuKXaZ5eEyTrYwIeqcRZ/XeSkQCxnqME2pJRO34N/b1h5JIpHFrqju09HBarO
	 4BhstmqT8TqwOVUXssbe9RGN4NyIOYNd6PizKladw+hfV1mnO8p6G8h9lFDWE+eRYh
	 SWjsoAT0LTogWXNUcadWh33vBpPTvLeHGcPayN7znoUa8qGU4M4oB+CluVH2k+oxoJ
	 l63ofPprmopCy7Tl2Badf79vQqeEC45r2GLCi1yUzYTn6dfKzL3d4+jKd6AXLCap7c
	 rYiIhC7menJdg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id rdS0jzclFU0i; Thu,  9 Nov 2023 10:56:25 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 23A0B9C27A3;
	Thu,  9 Nov 2023 10:56:25 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 4/8] Toaster: fixed pytest error: Database access not allowed, use the "django_db"
Date: Thu,  9 Nov 2023 16:56:14 +0100
Message-Id: <20231109155618.133124-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109155618.133124-1-alassane.yattara@savoirfairelinux.com>
References: <20231109155618.133124-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 15:56:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15466

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


