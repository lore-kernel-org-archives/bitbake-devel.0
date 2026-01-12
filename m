Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074AECF45BF
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 16:36:45 +0000 (UTC)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37247.1768235796999192654
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 08:36:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqdLW22cNzlXV;
	Mon, 12 Jan 2026 17:36:35 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqdLV67fqzg9p;
	Mon, 12 Jan 2026 17:36:34 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 12 Jan 2026 17:36:05 +0100
Subject: [PATCH 1/8] doc: bitbake-user-manual-metadata: list (in order) all
 sharing directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-doc-directives-v1-1-b23923cfce89@cherry.de>
References: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
In-Reply-To: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 16:36:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18734

From: Quentin Schulz <quentin.schulz@cherry.de>

The Sharing Functionality section has multiple subsections each
representing a way to share code.

Let's list all directives listed in the subsections (we were missing
inherit_defer and include_all) and provide a link for each subsection.

This also fixes the link to INHERIT to point to the subsection where it
is explained instead of to the variable glossary.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index ef401d4ab..0c5466943 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -753,7 +753,12 @@ share the task.
 
 This section presents the mechanisms BitBake provides to allow you to
 share functionality between recipes. Specifically, the mechanisms
-include ``include``, ``inherit``, :term:`INHERIT`, and ``require``
+include :ref:`inherit<ref-bitbake-user-manual-metadata-inherit>`,
+:ref:`inherit_defer<ref-bitbake-user-manual-metadata-inherit-defer>`,
+:ref:`include<ref-include-directive>`,
+:ref:`include_all<ref-include-all-directive>`,
+:ref:`require<require-inclusion>` and
+:ref:`INHERIT<bitbake-user-manual/bitbake-user-manual-metadata:\`\`INHERIT\`\` configuration directive>`
 directives. There is also a higher-level abstraction called
 ``configuration fragments`` that is enabled with ``addfragments``
 directive.

-- 
2.52.0


