Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1042C55165
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 15:19:47 +0000 (UTC)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14121.1785424780215540724
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 08:19:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=Rr1Kv3sS;
 spf=pass (domain: 0leil.net, ip: 185.125.25.11, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h9tCt1lMtzjqN;
	Thu, 30 Jul 2026 17:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1785424778;
	bh=B3xZSqYRNKp3aYS45BKUO56fKPsVFbk+gEj9zZbx3Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rr1Kv3sS2ebFfTrCZ0qu9tD/bV4qPZVpcZHcpj4g9cQZz80FcysgWRP1UuNG3Oqsc
	 LaU5IzR/ceZP+57/paNSO5qdZDSej8yzhmnNXx1dL8oWR0M+sCOT3dqFg7x8HUrh84
	 15vBp2fWnpWeaMXN3WKJNKDRdYKkstoNy90KpxwCd6zEOWnzQxeABnD6cBVRB/p2E8
	 6xQhwQO7l8BnIDEkfNACDMUh/KJt+oElmVaoBPpEkDgeSLyUkTlBEk3iXh06poi03w
	 sYnC2msgCn6KRE6Du5MIKWjJPZCEtMwfPt+QagFJdp29zEIZgqWf2GU4xcFoTEBlel
	 d1FnFjhguVfHQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h9tCs5jPyz7pR;
	Thu, 30 Jul 2026 17:19:37 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 30 Jul 2026 17:19:30 +0200
Subject: [PATCH 1/3] doc/bitbake-user-manual-environment-setup: fix
 reference to non-existing term
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-doc-fix-build-v1-1-f79ae06a270b@cherry.de>
References: <20260730-doc-fix-build-v1-0-f79ae06a270b@cherry.de>
In-Reply-To: <20260730-doc-fix-build-v1-0-f79ae06a270b@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 15:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19876

From: Quentin Schulz <quentin.schulz@cherry.de>

Configuration File is not a term that exists in our doc so this triggers
a warning, and because we have -W set for Sphinx, eventually fails the
build.

Remove the non-existing reference and make it plaintext.

Fixes: e8d531cec676 ("bitbake-setup: use bb.fetch for buildtools installer download")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index e1701555e..b31ab443c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -666,7 +666,7 @@ In addition, the command can take the following arguments:
 -  ``--sha256``: SHA256 checksum of the buildtools installer. Overrides the
    value from the configuration file.
 
-When ``url`` and ``sha256sum`` are set in the :term:`Configuration File`,
+When ``url`` and ``sha256sum`` are set in the configuration file,
 the installer is downloaded via ``bb.fetch`` (cached in ``DL_DIR``) and its
 checksum is enforced. If no configuration is present, the script falls back
 to its built-in defaults::

-- 
2.55.0


