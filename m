Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5A8D37E56
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 15:41:45 +0000 (UTC)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13162.1768405300032412189
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 07:41:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.12, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4drr296QNzzxsF;
	Wed, 14 Jan 2026 16:41:37 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4drr2646LnzGy5;
	Wed, 14 Jan 2026 16:41:34 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 14 Jan 2026 16:41:20 +0100
Subject: [PATCH] doc: bitbake-user-manual-ref-variables: BB_ENV_PASSTHROUGH
 is not in default BB_ENV_PASSTHROUGH_ADDITIONS (anymore)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-env-passthru-v1-1-fd5ef76eab61@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0MT3dS8Mt2CxOLikoyiUl0TUzMLS8u0VNNEC2MloJaCotS0zAqwcdG
 xtbUAgX3srl4AAAA=
X-Change-ID: 20260114-env-passthru-456899fe5a83
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Robert P. J. Day" <rpjday@crashcourse.ca>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 15:41:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18757

From: Quentin Schulz <quentin.schulz@cherry.de>

BB_ENV_PASSTHROUGH_ADDITIONS variable doesn't contain BB_ENV_PASSTHROUGH
anymore since commit 0a33b560233b ("utils: remove BB_ENV_PASSTHROUGH
from preserved_envvars()") so let's fix this oversight.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Suggested-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index af911f306..345da647e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -286,8 +286,8 @@ overview of their function and contents.
       Specifies the internal list of variables to allow through from
       the external environment into BitBake's datastore. If the value of
       this variable is not specified (which is the default), the following
-      list is used: :term:`BBPATH`, :term:`BB_PRESERVE_ENV`,
-      :term:`BB_ENV_PASSTHROUGH`, and :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
+      list is used: :term:`BBPATH`, :term:`BB_PRESERVE_ENV`, and
+      :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
 
       .. note::
 

---
base-commit: f23e186a75e71ba885b9b53a1dfda99af29c67b0
change-id: 20260114-env-passthru-456899fe5a83

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


