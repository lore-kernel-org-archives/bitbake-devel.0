Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E27DD15DAD
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 17:07:08 +0000 (UTC)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20780.1764781623105491241
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 09:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dM3w53pCrzN4f;
	Wed,  3 Dec 2025 18:07:01 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dM3w50qrnzJ5n;
	Wed,  3 Dec 2025 18:07:01 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 03 Dec 2025 18:06:52 +0100
Subject: [PATCH 3/3] doc: bitbake-user-manual-metadata: reorder
 introduction on how to locate include files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-doc-file-include-require-v1-3-fc708832b475@cherry.de>
References: <20251203-doc-file-include-require-v1-0-fc708832b475@cherry.de>
In-Reply-To: <20251203-doc-file-include-require-v1-0-fc708832b475@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 17:07:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18535

From: Quentin Schulz <quentin.schulz@cherry.de>

BitBake first searches the relative to the local directory before going
through BBPATH.

Fixes: 7bd36f6c6d33 ("doc: extend classes and include/require documentation")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index ef8ab024d..ef401d4ab 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1054,9 +1054,10 @@ bitbake will treat that as direct value assignment in its configuration::
 Locating Include Files
 ----------------------
 
-BitBake uses the :term:`BBPATH` variable to locate needed include files.
-Additionally, BitBake searches the current directory for :ref:`include
-<ref-include-directive>` and :ref:`require <require-inclusion>` directives.
+BitBake first searches the current directory for needed include files for
+:ref:`include <ref-include-directive>` and :ref:`require <require-inclusion>`
+directives.
+BitBake also uses the :term:`BBPATH` variable.
 
 .. note::
 

-- 
2.52.0


