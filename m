Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D2CF45AF
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 16:36:44 +0000 (UTC)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37253.1768235798187499800
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 08:36:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqdLX3C5Gzlk2;
	Mon, 12 Jan 2026 17:36:36 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqdLX0Y2pzdWY;
	Mon, 12 Jan 2026 17:36:36 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 12 Jan 2026 17:36:08 +0100
Subject: [PATCH 4/8] doc: bitbake-user-manual-metadata: specify that
 current dir won't be searched for include_all
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-doc-directives-v1-4-b23923cfce89@cherry.de>
References: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
In-Reply-To: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 16:36:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18738

From: Quentin Schulz <quentin.schulz@cherry.de>

We've forgotten to make it explicit that include_all differs from the
include directive also by the fact it doesn't look for the file
relatively to the file with the include_all directive, so let's make
that clear.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 9233c4555..d7335f29e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -910,6 +910,10 @@ The ``include_all`` directive works like the :ref:`include
 directive but will include *all* of the files that match the specified path in
 the enabled layers (layers part of :term:`BBLAYERS`).
 
+Note that only :term:`BBPATH` will be searched, the parent directory of the file
+with the ``include_all`` directive will not be searched (unlike for the
+``include`` directive).
+
 .. note::
 
    This behaviour is rarely what you want in normal operation, and should

-- 
2.52.0


