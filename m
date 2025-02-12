Return-Path: <louis.rannou@syslinbit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C5C021A0
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 12:17:16 +0000 (UTC)
Received: from 12.mo583.mail-out.ovh.net (12.mo583.mail-out.ovh.net [46.105.39.65])
 by mx.groups.io with SMTP id smtpd.web11.14393.1739362629927005475
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 04:17:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=rE44IUBv;
 spf=softfail (domain: syslinbit.com, ip: 46.105.39.65, mailfrom: louis.rannou@syslinbit.com)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.25.16])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4YtHP90BgRz1Wfn
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 12:17:01 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-fb9gf (unknown [10.110.96.146])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id CE7221FD7D;
	Wed, 12 Feb 2025 12:16:59 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.113])
	by ghost-submission-5b5ff79f4f-fb9gf with ESMTPSA
	id n0MkBzqRrGfDjQAAM+UVKg:T3
	(envelope-from <louis.rannou@syslinbit.com>); Wed, 12 Feb 2025 12:16:59 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-113S007ef6c2a76-d374-49f3-9e19-b369aad1a2dc,
                    74B36F6499D71BB1255966C6406869B815799905) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
From: Louis Rannou <louis.rannou@syslinbit.com>
Date: Wed, 12 Feb 2025 13:16:19 +0100
Subject: [PATCH 2/2] bitbake: tests/parse: add test for getVarFlags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-varflags-v1-2-3a756c7aa95c@syslinbit.com>
References: <20250212-varflags-v1-0-3a756c7aa95c@syslinbit.com>
In-Reply-To: <20250212-varflags-v1-0-3a756c7aa95c@syslinbit.com>
To: bitbake-devel@lists.openembedded.org
Cc: Louis Rannou <louis.rannou@syslinbit.com>, louis.rannou@non.se.com, 
 pascal.eberhard@se.com, yoann.congal@smile.fr
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739362618; l=1822;
 i=louis.rannou@syslinbit.com; s=20230614; h=from:subject:message-id;
 bh=fbpcn8AZFJy9XXkeGOy2u/XAzdpVFD/Xo8IiC5BwF+w=;
 b=6M0f5IYpJ1AewTo5sc1Bl9RH6X91TcbSe94BOGHtRO7HNDkALTrRjx0Di3S8DqI/dGUsF6S2D
 ieXSxoPzNUjCnV1g+jMypU0HtGV1NjHnyJif7PYcv3J3AY9xHIU4wqx
X-Developer-Key: i=louis.rannou@syslinbit.com; a=ed25519;
 pk=QLSK64UNeqThVe2CiH917a68zTpexYuA7iXw6WQ0bbI=
X-Ovh-Tracer-Id: 10465239637872336193
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucftrghnnhhouhcuoehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomheqnecuggftrfgrthhtvghrnhepudfhueeutdehffdvhfejleffudekieduffffteefiedutdeuhfehkeffueehfeevnecukfhppeduvdejrddtrddtrddupdeghedrkedurdeivddrledpfeejrdehledrudegvddruddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheplhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdfovfetjfhoshhtpehmohehkeefmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=nrUk0Ar9H68BoKPcA9PE0qv1jd/DnLxKu/zROGW8ioo=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1739362621; v=1;
 b=rE44IUBv49VCvpYBYPN1108V2RE5yAsaNaUIWYLZiRyNok4xOy64iHZlzC00c5ZSATtFttxp
 n2bqInzAD1pSQlhZ2JrYsWlwApWeVMwKoMyflXs4J11l+jTZCZ+t3OeZeKRZvNl41HHnBwmInij
 XPOYas/aI6JuiLtyeLEKbOV2HU5kyGKmi0SF8U1rmLZD5urWF8SB9v2OEDB+dYqNB55dPuNU7wK
 eXmXNtkBQo/Y3kNw2htlZaBJRwetS7K69byGtIqiXPca1QtPEXdMkj5NE1Dt/sEOgVjssnHNDua
 gIM5oXAfhuTEDyYjo1jpxh4wqx9f8L2eHU1UnAGXEF0pQ==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 12:17:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17204

From: Louis Rannou <louis.rannou@non.se.com>

Run the test with:
    $ bitbake-selftest bb.tests.parse.ParseTest.test_parse_defaulttest
    test_parse_defaulttest (bb.tests.parse.ParseTest.test_parse_defaulttest) ... ok

    ----------------------------------------------------------------------
    Ran 1 test in 0.001s

    OK

This is a test case for [YOCTO #15685]

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
---
 lib/bb/tests/parse.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index e3cba67ad448a491ee9c094e6725eb68eba14b32..74a6c54ad1908357b65c37c37c8b8c299fd5f3bc 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -127,6 +127,22 @@ A[flag_default_twice] ??= "default flag second"
         self.assertEqual(d.getVarFlag("A","flag_set_twice"), "set flag second")
         self.assertEqual(d.getVarFlag("A","flag_question_twice"), "question flag first")
         self.assertEqual(d.getVarFlag("A","flag_default_twice"), "default flag second")
+        self.assertDictEqual(
+            d.getVarFlags("A"),
+            {
+                "flag_set_vs_question": "set flag",
+                "flag_set_vs_default": "set flag",
+                "flag_question": "question flag",
+                "flag_default": "default flag",
+                "flag_question_vs_default": "question flag",
+                "flag_default_vs_question": "question flag",
+                "flag_set_question_default": "set flag",
+                "flag_set_default_question": "set flag",
+                "flag_set_twice": "set flag second",
+                "flag_question_twice": "question flag first",
+                "flag_default_twice": "default flag second",
+            }
+        )
 
     exporttest = """
 A = "a"

-- 
2.48.1


