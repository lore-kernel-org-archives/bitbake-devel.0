Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FEDC19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 13:59:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.11047.1740664762136239383
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 05:59:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44B182BCA
	for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 05:59:37 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 510E03F673
	for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 05:59:21 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] lib/bb/build: remove mention of OE_EXTRA_IMPORTS
Date: Thu, 27 Feb 2025 13:59:19 +0000
Message-ID: <20250227135919.3440918-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 13:59:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17346

This is an OpenEmbedded-specific variable that is no longer used[1].

[1] oe-core 1f56155e ("base: Switch to use addpylib directive and
    BB_GLOBAL_PYMODULES")

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 6e0459d87ab..40839a81b5b 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -397,7 +397,7 @@ def create_progress_handler(func, progress, logfile, =
d):
         # Use specified regex
         return bb.progress.OutOfProgressHandler(d, regex=3Dprogress.spli=
t(':', 1)[1], outfile=3Dlogfile)
     elif progress.startswith("custom:"):
-        # Use a custom progress handler that was injected via OE_EXTRA_I=
MPORTS or __builtins__
+        # Use a custom progress handler that was injected via other mean=
s
         import functools
         from types import ModuleType
=20
--=20
2.43.0


