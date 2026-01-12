Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E473ACF45B4
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 16:36:44 +0000 (UTC)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37250.1768235797405782280
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 08:36:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqdLW4fb6zkv4;
	Mon, 12 Jan 2026 17:36:35 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqdLW1vrFzdmX;
	Mon, 12 Jan 2026 17:36:35 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 12 Jan 2026 17:36:06 +0100
Subject: [PATCH 2/8] doc: bitbake-user-manual-metadata: highlight
 configuration fragment differently
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-doc-directives-v1-2-b23923cfce89@cherry.de>
References: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
In-Reply-To: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Robert P. J. Day" <rpjday@crashcourse.ca>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 16:36:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18736

From: Quentin Schulz <quentin.schulz@cherry.de>

We typically reserve the monospace font (used when highlighting with two
tick quotes) for inline code examples or non-English words, but
"configuration fragments" is neither. Instead, let's assume the intended
style effect was to highlight the term as a two-word term and only use
single tick quotes to make the text look italic.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 0c5466943..3ac2cb755 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -760,7 +760,7 @@ include :ref:`inherit<ref-bitbake-user-manual-metadata-inherit>`,
 :ref:`require<require-inclusion>` and
 :ref:`INHERIT<bitbake-user-manual/bitbake-user-manual-metadata:\`\`INHERIT\`\` configuration directive>`
 directives. There is also a higher-level abstraction called
-``configuration fragments`` that is enabled with ``addfragments``
+`configuration fragments` that is enabled with ``addfragments``
 directive.
 
 .. _ref-bitbake-user-manual-metadata-inherit:

-- 
2.52.0


