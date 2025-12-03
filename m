Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C198D15DBA
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 17:07:08 +0000 (UTC)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20779.1764781622690836491
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 09:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dM3w50nMJzNGV;
	Wed,  3 Dec 2025 18:07:01 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dM3w44lYtzHvP;
	Wed,  3 Dec 2025 18:07:00 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 03 Dec 2025 18:06:51 +0100
Subject: [PATCH 2/3] doc: bitbake-user-manual-intro: specify inherit_defer
 directive for recipe classes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-doc-file-include-require-v1-2-fc708832b475@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18532

From: Quentin Schulz <quentin.schulz@cherry.de>

We specify the recipe classes must be used with inherit but they can
actually also be used with inherit_defer directive so let's make that
clear.

Fixes: 7bd36f6c6d33 ("doc: extend classes and include/require documentation")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 2875e18f3..329b02829 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -220,9 +220,10 @@ BitBake supports class files installed in three different directories:
       INHERIT += "myclass"
 
 -  ``classes-recipe/``: these classes must be inherited from a recipe using the
-   :ref:`inherit <ref-bitbake-user-manual-metadata-inherit>` directive. They do
-   not support being inherited globally. For example, you would use the recipe
-   class named ``myclass`` like so::
+   :ref:`inherit <ref-bitbake-user-manual-metadata-inherit>` or
+   :ref:`inherit_defer <ref-bitbake-user-manual-metadata-inherit-defer>`
+   directive. They do not support being inherited globally. For example, you
+   would use the recipe class named ``myclass`` like so::
 
       inherit myclass
 

-- 
2.52.0


