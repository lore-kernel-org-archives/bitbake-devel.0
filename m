Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A20C5516D
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 15:19:48 +0000 (UTC)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14127.1785424780955713643
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 08:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=dXPquPqJ;
 spf=pass (domain: 0leil.net, ip: 45.157.188.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h9tCv0VrWzkD6;
	Thu, 30 Jul 2026 17:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1785424778;
	bh=XNXA1NfRczEO43Us6/+P5flvEhPTVnj+oN2MiUZnjH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dXPquPqJ7X2wkd4GbZPeXNsXONzYVLZtBuXHKKSs3P4FNGxDTW5Q5wDw0ODIbpWA+
	 fBG++yBvuY1wpfXcfA/bP03g41CVwD+5vnvLwKiluZgSB31AMYXQGEoMohRU7XF0y4
	 A/uJ5sGWDf2GZ336ImMMMlfzcCbeE2CyxeH9HlF3qwa2e+s5IKuYRdZD8PPHEymc+U
	 cO8uw3ZGBRpSOvra6KZssyHDYwCRbzQAcHJyG9ugV+uOxu+7ryICO/1dqQ8LS+7GD1
	 GlIOKd/eQ4CFyzAcv35WFyiG9RYhCONNK1SI/UNuvgekuLOqK8Ln82rFRmoNln++Fm
	 9HZQrXP+IrXEw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h9tCt49T6z7T2;
	Thu, 30 Jul 2026 17:19:38 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 30 Jul 2026 17:19:32 +0200
Subject: [PATCH 3/3] doc/bitbake-user-manual-environment-setup:
 cross-reference DL_DIR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-doc-fix-build-v1-3-f79ae06a270b@cherry.de>
References: <20260730-doc-fix-build-v1-0-f79ae06a270b@cherry.de>
In-Reply-To: <20260730-doc-fix-build-v1-0-f79ae06a270b@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 15:19:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19879

From: Quentin Schulz <quentin.schulz@cherry.de>

DL_DIR is a term defined in the glossary so we should refer to it
whenever possible instead of simply highlighting it with double
tick-quotes.

Fixes: e8d531cec676 ("bitbake-setup: use bb.fetch for buildtools installer download")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index b31ab443c..c32a6964a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -667,7 +667,7 @@ In addition, the command can take the following arguments:
    value from the configuration file.
 
 When ``url`` and ``sha256sum`` are set in the configuration file,
-the installer is downloaded via ``bb.fetch`` (cached in ``DL_DIR``) and its
+the installer is downloaded via ``bb.fetch`` (cached in :term:`DL_DIR`) and its
 checksum is enforced. If no configuration is present, the script falls back
 to its built-in defaults::
 

-- 
2.55.0


