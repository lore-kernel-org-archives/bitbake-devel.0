Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C49CF45B2
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 16:36:44 +0000 (UTC)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37251.1768235797691815048
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 08:36:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqdLX0fFtzlyf;
	Mon, 12 Jan 2026 17:36:36 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqdLW4YZfzfVB;
	Mon, 12 Jan 2026 17:36:35 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 12 Jan 2026 17:36:07 +0100
Subject: [PATCH 3/8] doc: bitbake-user-manual-metadata: use a
 cross-reference for addfragments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-doc-directives-v1-3-b23923cfce89@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18737

From: Quentin Schulz <quentin.schulz@cherry.de>

We use cross-reference links for all but addfragments so let's fix that
inconsistency.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 3ac2cb755..9233c4555 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -760,8 +760,8 @@ include :ref:`inherit<ref-bitbake-user-manual-metadata-inherit>`,
 :ref:`require<require-inclusion>` and
 :ref:`INHERIT<bitbake-user-manual/bitbake-user-manual-metadata:\`\`INHERIT\`\` configuration directive>`
 directives. There is also a higher-level abstraction called
-`configuration fragments` that is enabled with ``addfragments``
-directive.
+`configuration fragments` that is enabled with the
+:ref:`bitbake-user-manual/bitbake-user-manual-metadata:\`\`addfragments\`\` directive`.
 
 .. _ref-bitbake-user-manual-metadata-inherit:
 

-- 
2.52.0


