Return-Path: <peter.hoyes@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24D7EB64D7
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 12:38:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.7354.1686919103594966248
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jun 2023 05:38:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: peter.hoyes@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37AFE1FB;
	Fri, 16 Jun 2023 05:39:07 -0700 (PDT)
Received: from e125920.arm.com (unknown [10.57.86.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76E823F71E;
	Fri, 16 Jun 2023 05:38:22 -0700 (PDT)
From: Peter Hoyes <peter.hoyes@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH 2/5] bitbake: tests/fetch: Rename assertRaisesRegexp to assertRaisesRegex
Date: Fri, 16 Jun 2023 13:36:48 +0100
Message-Id: <20230616123651.915234-3-peter.hoyes@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616123651.915234-1-peter.hoyes@arm.com>
References: <20230616123651.915234-1-peter.hoyes@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 12:38:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14840

From: Peter Hoyes <Peter.Hoyes@arm.com>

TestCase.assertRaisesRegexp was renamed to assertRaisesRegex in Python
3.2, so rename to fix a warning during test execution.

Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
---
 bitbake/lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
index ba7be048a8..871c174e82 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2486,7 +2486,7 @@ class CrateTest(FetcherTest):
         uris =3D self.d.getVar('SRC_URI').split()
=20
         fetcher =3D bb.fetch2.Fetch(uris, self.d)
-        with self.assertRaisesRegexp(bb.fetch2.FetchError, "Fetcher fail=
ure for URL"):
+        with self.assertRaisesRegex(bb.fetch2.FetchError, "Fetcher failu=
re for URL"):
             fetcher.download()
=20
 class NPMTest(FetcherTest):
--=20
2.34.1


