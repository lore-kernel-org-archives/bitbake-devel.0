Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF0C636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 16:26:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.13626.1677083203610602109
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Feb 2023 08:26:43 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B484E4B3;
	Wed, 22 Feb 2023 08:27:25 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508753F703;
	Wed, 22 Feb 2023 08:26:42 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: nd@arm.com
Subject: [PATCH] lib/bb/siggen: fix debug() call
Date: Wed, 22 Feb 2023 16:26:40 +0000
Message-Id: <20230222162640.2043487-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 16:26:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14481

Bitbake f68682 changed the logger's debug() method to be compatible with
logging.debug(), but this caller was still using the old API where you
can pass an integer as the first argument:

WARNING: Invalid arguments in bbdebug: (1, 1, 'Found unihash[...]')

Instead, call bbdebug() which has the priority argument.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/siggen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 26e0243b006..c4ff9d8de16 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -598,7 +598,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 # A unique hash equal to the taskhash is not very intere=
sting,
                 # so it is reported it at debug level 2. If they differ,=
 that
                 # is much more interesting, so it is reported at debug l=
evel 1
-                hashequiv_logger.debug((1, 2)[unihash =3D=3D taskhash], =
'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, ti=
d, self.server))
+                hashequiv_logger.bbdebug((1, 2)[unihash =3D=3D taskhash]=
, 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, =
tid, self.server))
             else:
                 hashequiv_logger.debug2('No reported unihash for %s:%s f=
rom %s' % (tid, taskhash, self.server))
         except ConnectionError as e:
--=20
2.34.1


