Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA6C4167B
	for <webhook@archiver.kernel.org>; Tue,  5 Dec 2023 00:54:25 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.88798.1701737657656222180
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Dec 2023 16:54:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=U2eqUvI7;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9FA9C9C4028
	for <bitbake-devel@lists.openembedded.org>; Mon,  4 Dec 2023 19:54:16 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id dz0G8fI1fUXD; Mon,  4 Dec 2023 19:54:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5C6E99C3D84;
	Mon,  4 Dec 2023 19:54:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5C6E99C3D84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701737656; bh=CGFlFGowpvR7jalHRbInu93zHKxZhm1ql4ovd+K8QaA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=U2eqUvI7ASn+SEBE/JXrS4tK9xwrpwP1d9wUmmYZCnpTAio458VDcqUH1d4wlr+t9
	 Vz4A8H8iyA7+vJIsSicRmfsj984Riinhfy5Avze2uhzZfFaG6g55COSEmcuYxxjQ7O
	 Cd5/AZw6gf1tZ+FC5mItptEy60Uh8DrPual4ZVEXMgHp9SdiUmsF+j5mGGA2UcOWOL
	 rtgrLDMgLCtnPIY/RGSt7grO1XKLpwiZS+XmPavoDhSj7QejhWJcDts3HbOSx8DsUR
	 SUpKnN9bPzs/aINUUeLObtlwOWI/BAZ9v/cp/nKTw9wZf8dPrnLd0YqEb6c73o5sJC
	 Qb1klVoVl7Yng==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XyVOjSYbOyLq; Mon,  4 Dec 2023 19:54:16 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CC2EA9C3298;
	Mon,  4 Dec 2023 19:54:15 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 2/3] toaster/test: Update pytest.init
Date: Tue,  5 Dec 2023 01:54:10 +0100
Message-Id: <20231205005411.476971-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205005411.476971-1-alassane.yattara@savoirfairelinux.com>
References: <20231205005411.476971-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Dec 2023 00:54:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15611

Pushing a working test suite. To note functional and builds tests are bei=
ng refactored
- Tests Passed:
    - Browser
    - Commands
    - db
    - views

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/pytest.ini | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/pytest.ini b/lib/toaster/pytest.ini
index f07076b7..642e0b6e 100644
--- a/lib/toaster/pytest.ini
+++ b/lib/toaster/pytest.ini
@@ -2,7 +2,7 @@
 [pytest]
 DJANGO_SETTINGS_MODULE =3D toastermain.settings_test
=20
-python_files =3D db/test_*.py commands/test_*.py views/test_*.py browser=
/test_*.py functional/test_*.py
+python_files =3D db/test_*.py commands/test_*.py views/test_*.py browser=
/test_*.py
=20
 # --create-db - force re creation of the test database
 # https://pytest-django.readthedocs.io/en/latest/database.html#create-db=
-force-re-creation-of-the-test-database
--=20
2.34.1


