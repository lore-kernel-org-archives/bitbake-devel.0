Return-Path: <ross@burtonini.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C3FC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Oct 2021 14:50:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web09.1510.1633445406165565637
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Oct 2021 07:50:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C8EF1FB;
	Tue,  5 Oct 2021 07:50:04 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BFFB3F70D;
	Tue,  5 Oct 2021 07:50:04 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: mark.hatle@kernel.crashing.org
Subject: [PATCH 1/4] tests/utils: mark a regex as a raw string
Date: Tue,  5 Oct 2021 15:49:58 +0100
Message-Id: <20211005145001.2717748-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Oct 2021 14:50:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12723

Avoids a warning from Python as \s isn't a valid escape.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/tests/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/utils.py b/bitbake/lib/bb/tests/utils.p=
y
index 4d5e21b99e..c363f62d7d 100644
--- a/bitbake/lib/bb/tests/utils.py
+++ b/bitbake/lib/bb/tests/utils.py
@@ -418,7 +418,7 @@ MULTILINE =3D "  stuff \\
                                ['MULTILINE'],
                                handle_var)
=20
-        testvalue =3D re.sub('\s+', ' ', value_in_callback.strip())
+        testvalue =3D re.sub(r'\s+', ' ', value_in_callback.strip())
         self.assertEqual(expected_value, testvalue)
=20
 class EditBbLayersConf(unittest.TestCase):
--=20
2.25.1


