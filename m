Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F5ECF45AE
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 16:36:44 +0000 (UTC)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37254.1768235798537411574
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 08:36:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqdLX5fQGzlFJ;
	Mon, 12 Jan 2026 17:36:36 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqdLX35LQzfRx;
	Mon, 12 Jan 2026 17:36:36 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 12 Jan 2026 17:36:09 +0100
Subject: [PATCH 5/8] doc: bitbake-user-manual-metadata: add missing
 highlight for BBPATH and PATH
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-doc-directives-v1-5-b23923cfce89@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18739

From: Quentin Schulz <quentin.schulz@cherry.de>

We typically highlight (via a :term: directive or with double tick
quotes if there's no entry in the glossary or it is inappropriate)
variables, and here it was missed so let's fix that oversight.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index d7335f29e..44a1e519b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1070,7 +1070,7 @@ BitBake also uses the :term:`BBPATH` variable.
 
 .. note::
 
-   The BBPATH variable is analogous to the environment variable PATH.
+   The :term:`BBPATH` variable is analogous to the environment variable ``PATH``.
 
 For these two directives, BitBake includes the first file it finds.
 

-- 
2.52.0


