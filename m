Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178AC55162
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 14:48:18 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13401.1785422888819400111
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 07:48:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=iRohy4D7;
 spf=pass (domain: 0leil.net, ip: 185.125.25.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h9sWV3fTqz2GQ;
	Thu, 30 Jul 2026 16:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1785422886;
	bh=pOcH+4CFRw29DKswXHQ9Q5PRqpr03oC7PI6zvW68OKI=;
	h=From:Date:Subject:To:Cc:From;
	b=iRohy4D7goKEx5buzxLL7CG1hoSI7T5fuxN54AhvXvUC0dL7p35MfA3dd36PlqgUF
	 K7Bb+tHh840XTmA7n54nlbk1YVhVVdEkfQHv+gc/ZzlLase7AuGfbB/Hlkw6/hfpPJ
	 r8XXnpT6ePNAs5hZu+dLZK/nnfP1/aMKW3Azoar49lF/vmRqcEB4ylB6NcS0c81JvW
	 NSFpOlq7BqF+8Wgmu7eNGmJjxAnxnDHLr93BTqfMsLS12RspMjtq0uBZvFEtXqz8Fm
	 tJ3Ns38l3nGWrKvTUnrIVaX1JAURD3KW6EdaMTk491ozarL70NWn7Txxvtk5pRESe0
	 GlI/mab0L1G6w==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h9sWT5GD6zvM2;
	Thu, 30 Jul 2026 16:48:05 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 30 Jul 2026 16:47:58 +0200
Subject: [PATCH] doc: bitbake-user-manual-metadata: fix missing whitespace
 around '=' operator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-doc-space-v1-1-90ccb2357b2b@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDWp/+EqYkE7GAukg0jE3RXLL
 3l5Fwg5JoEquMDRwcLL7BGFAZixnQdSbL0h1nGui0Qruxgla2tIIeZpiTZD0gi+Xx31fH6vuvk
 tezeR2d4B3PcDsRC/UG0AAAA=
X-Change-ID: 20260730-doc-space-886498d58e08
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 14:48:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19875

From: Quentin Schulz <quentin.schulz@cherry.de>

Since Whinlatter (5.3) BitBake will warn if the assignment operator (=)
isn't surrounded by spaces, so let's fix the only occurrence in the docs
where it was not already the case.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Inspired by https://lore.kernel.org/yocto-docs/20260728090746.27793-4-niko.mauno@vaisala.com/
for yocto-docs.
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 0c7c3ff99..068ea2afb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -617,8 +617,8 @@ variable.
    ``KERNEL_FEATURES`` variable based on the architecture::
 
       KERNEL_FEATURES:append = " ${KERNEL_EXTRA_FEATURES}"
-      KERNEL_FEATURES:append:qemux86=" cfg/sound.scc cfg/paravirt_kvm.scc"
-      KERNEL_FEATURES:append:qemux86-64=" cfg/sound.scc cfg/paravirt_kvm.scc"
+      KERNEL_FEATURES:append:qemux86 = " cfg/sound.scc cfg/paravirt_kvm.scc"
+      KERNEL_FEATURES:append:qemux86-64 = " cfg/sound.scc cfg/paravirt_kvm.scc"
 
 -  *Setting a Variable for a Single Task:* BitBake supports setting a
    variable just for the duration of a single task. Here is an example::

---
base-commit: d1886335f0d7fa86e87c6001d5be306a8e90586b
change-id: 20260730-doc-space-886498d58e08

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


