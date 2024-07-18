Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A979CC3DA70
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 13:52:21 +0000 (UTC)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
 by mx.groups.io with SMTP id smtpd.web11.15614.1721310740454793353
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jul 2024 06:52:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPvPb04Qqz7xK;
	Thu, 18 Jul 2024 15:52:19 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPvPZ4Z6HzQH;
	Thu, 18 Jul 2024 15:52:18 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 18 Jul 2024 15:51:59 +0200
Subject: [PATCH 1/3] doc: releases: mark mickledore as outdated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-yocto-releases-v1-1-204f3e3dade4@cherry.de>
References: <20240718-yocto-releases-v1-0-204f3e3dade4@cherry.de>
In-Reply-To: <20240718-yocto-releases-v1-0-204f3e3dade4@cherry.de>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 bitbake-devel@lists.openembedded.org, foss+yocto@0leil.net, 
 docs@lists.yoctoproject.org
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jul 2024 13:52:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16426

From: Quentin Schulz <quentin.schulz@cherry.de>

Mickledore isn't maintained anymore, so let's move it to the outdated
release manuals section.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/releases.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/releases.rst b/doc/releases.rst
index b38b1c065..1e2563de0 100644
--- a/doc/releases.rst
+++ b/doc/releases.rst
@@ -4,12 +4,6 @@
 BitBake Supported Release Manuals
 =================================
 
-*******************************
-Release Series 4.2 (mickledore)
-*******************************
-
-- :yocto_docs:`BitBake 2.4 User Manual </bitbake/2.4/>`
-
 ******************************
 Release Series 4.0 (kirkstone)
 ******************************
@@ -26,6 +20,12 @@ Release Series 3.1 (dunfell)
 BitBake Outdated Release Manuals
 ================================
 
+*******************************
+Release Series 4.2 (mickledore)
+*******************************
+
+- :yocto_docs:`BitBake 2.4 User Manual </bitbake/2.4/>`
+
 *****************************
 Release Series 4.1 (langdale)
 *****************************

-- 
2.45.2


