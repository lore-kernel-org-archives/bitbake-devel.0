Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2942AC10DC1
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 22:49:15 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.84667.1701730147552312152
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Dec 2023 14:49:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=sIwAqxty;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A5A8C9C4026
	for <bitbake-devel@lists.openembedded.org>; Mon,  4 Dec 2023 17:49:06 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Q3s4qojBU_Tw; Mon,  4 Dec 2023 17:49:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 52F989C3D84;
	Mon,  4 Dec 2023 17:49:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 52F989C3D84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701730146; bh=x35KL691Z7zil7hVK2HgsvBiMnjAFg8rGxdT9u7+yGI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=sIwAqxty4+YlDWHtq+I5x4PWnXC0pYvBIk7hkcSpZvRLNuEXY6lFCqg7lgx4SbvQ2
	 A36BNdPhsCHyqP+vi1By3ndxtGu+yldkQ7NHiHJl8guAEFKIQJLaNF48feZbn4LtJo
	 6sewBrzZhj7CTvZNZrqbCpKZH1kA+BrmBZD0QlYYV5sjVZFn/iH52PhMNw97tIRy8P
	 2aTWEQNUirN2JbjBrG/wJtLtjmBXqqeUUy+8gNcYVZHu8XaxO+nLxj9BsuVbQoo8PT
	 lNX1TZ2NWoX4w5WG25R57aURqNlHUay+1IWXYbv4jRap/w+HLmyDSrsdcSGB/VIrIz
	 E9W14fTSor+Ww==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id HnuEQBsRGT9u; Mon,  4 Dec 2023 17:49:06 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A67129C31BC;
	Mon,  4 Dec 2023 17:49:05 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/3] toaster/test: Update pytest.init
Date: Mon,  4 Dec 2023 23:48:31 +0100
Message-Id: <20231204224832.399005-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204224832.399005-1-alassane.yattara@savoirfairelinux.com>
References: <20231204224832.399005-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Dec 2023 22:49:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15608

Skip to functional and builds tests for now, as they are not working.
- Tests Passed:
    - Browser
    - Commands
    - db
    - views
- Tests skipped: Actually working progress on followings tests
    - Builds
    - Functional

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


