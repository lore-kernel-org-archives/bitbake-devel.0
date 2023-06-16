Return-Path: <peter.hoyes@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F44EB64D7
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 12:38:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.7353.1686919101542541866
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jun 2023 05:38:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: peter.hoyes@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E67E1FB;
	Fri, 16 Jun 2023 05:39:05 -0700 (PDT)
Received: from e125920.arm.com (unknown [10.57.86.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 843003F71E;
	Fri, 16 Jun 2023 05:38:20 -0700 (PDT)
From: Peter Hoyes <peter.hoyes@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH 1/5] bitbake: tests/fetch: Mark TestTimeout as not a test suite
Date: Fri, 16 Jun 2023 13:36:47 +0100
Message-Id: <20230616123651.915234-2-peter.hoyes@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616123651.915234-1-peter.hoyes@arm.com>
References: <20230616123651.915234-1-peter.hoyes@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 12:38:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14839

From: Peter Hoyes <Peter.Hoyes@arm.com>

pytest test collection attempts to collect all classes containing
"Test". TestTimeout is not a test class so add the __test__ =3D False
attribute to indicate this.

Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
---
 bitbake/lib/bb/tests/fetch.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index d230120271..ba7be048a8 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -24,7 +24,8 @@ def skipIfNoNetwork():
     return lambda f: f
=20
 class TestTimeout(Exception):
-    pass
+    # Indicate to pytest that this is not a test suite
+    __test__ =3D False
=20
 class Timeout():
=20
--=20
2.34.1


