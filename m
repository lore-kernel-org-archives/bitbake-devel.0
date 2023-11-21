Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D745AC61D92
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:49:29 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.40817.1700574569212488566
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:49:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=vI6Wt7Nr;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 819559C36C5
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:49:28 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id d5FWeZ1thSWR; Tue, 21 Nov 2023 08:49:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 093C99C36BF;
	Tue, 21 Nov 2023 08:49:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 093C99C36BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574568; bh=1CQSAyBgPZFbf/VdNEYjkbsOotD85Wdh9JdRNPVv5bo=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=vI6Wt7Nr1JpUNFiig3c3xCC9yybjCULLo4+lYNqagU6pjF4qD5NYVY+p60SHkHTTq
	 Mz/jaDmjDA6I+mMI71u3t6hZW6CDO/OsARCqJWzCC30BF1DewUH1Im0NkvYvmwf28H
	 jyvhdMPHiBfTsdFGQqSR3QbPcA85j9a4LNqiVfBF0vMSbJ+71kVPiFBEAKV0Syrr8Y
	 1nyRRw4wezs7tZV5HKrffQYFKArKJ4wggPFDy/vEGkUwu9X4t3g6DykKx2yupj1PUu
	 A6oJ0+oHMAOEvBdk49/5p/MBV9+zLbb3PghpJsmzKWfd9YGezUs6hzvl8vpNeI+8Wo
	 0+ntGryqp50og==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id wrttxelq3FOX; Tue, 21 Nov 2023 08:49:27 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 28EBD9C3500;
	Tue, 21 Nov 2023 08:49:26 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/4] Toaster: Bug-fix
Date: Tue, 21 Nov 2023 14:49:15 +0100
Message-Id: <20231121134918.101006-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:49:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15548

Fixed
- Select import,
- Remove trailing whitespace,
- Set excepted 2lines after imports

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/functional/test_create_new_project.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index 051709b4..dc7d1fc2 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -9,11 +9,12 @@
 import re
 import pytest
 from django.urls import reverse
-from selenium.webdriver.support.ui import Select
+from selenium.webdriver.support.select import Select
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from orm.models import Project
 from selenium.webdriver.common.by import By
=20
+
 @pytest.mark.django_db
 class TestCreateNewProject(SeleniumFunctionalTestCase):
=20
--=20
2.34.1


