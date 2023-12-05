Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9908C10F05
	for <webhook@archiver.kernel.org>; Tue,  5 Dec 2023 16:40:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.104661.1701794428051884052
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Dec 2023 08:40:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=rfixJQ1J;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 701CE9C3D7B
	for <bitbake-devel@lists.openembedded.org>; Tue,  5 Dec 2023 11:40:27 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id J31yyuqtAv_C; Tue,  5 Dec 2023 11:40:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2D73C9C3644;
	Tue,  5 Dec 2023 11:40:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 2D73C9C3644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701794427; bh=GjC795xdK9XjTeJjAXE6lqtLuP5vdj5E3H16oWUIFvY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=rfixJQ1JPPpoY6mJSg/abQT5fYKFblXW4pJZ+BHxp/7juw5w0R02CXmsuNayNtM1H
	 hSPsVyWZJxLYzP03t2juc+zh7p3Dl1vTf+HEn7WLOilfy76cEAq7htiuHrCJ0NmR7g
	 HRsZHFLdKqvoo8t2zMHnTb5bj9ikxcbVO90e+edT50GnaXW0xkypLO+dR9AYrLwXJm
	 oPGgYslpf5zMXs0nIc8lkHBrLDst0RPFqNKBZxurwfRaEtWOJ5yeCJYO4YDewwxYMw
	 mkDfIti4idc+T6EDZOSe3UF+yLXjymJc4LuvFy0++GW6JQqr5rc287NKd2mLJL6QyF
	 3suS8OMbIYo3A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id t54XTxK5ixO9; Tue,  5 Dec 2023 11:40:27 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9261D9C339D;
	Tue,  5 Dec 2023 11:40:26 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 2/4] toaster/test: Update pytest.init
Date: Tue,  5 Dec 2023 17:40:20 +0100
Message-Id: <20231205164022.151951-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205164022.151951-1-alassane.yattara@savoirfairelinux.com>
References: <20231205164022.151951-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Dec 2023 16:40:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15614

Pushing a working tests suite. To note functional and builds tests are be=
ing refactored
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


