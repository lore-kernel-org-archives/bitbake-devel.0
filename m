Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD727C49EA1
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 13:52:21 +0000 (UTC)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
 by mx.groups.io with SMTP id smtpd.web11.15618.1721310741324448021
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jul 2024 06:52:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPvPb4hD1zJm7;
	Thu, 18 Jul 2024 15:52:19 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPvPb2M5tzhM;
	Thu, 18 Jul 2024 15:52:19 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 18 Jul 2024 15:52:01 +0200
Subject: [PATCH 3/3] doc: releases: add scarthgap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-yocto-releases-v1-3-204f3e3dade4@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16429

From: Quentin Schulz <quentin.schulz@cherry.de>

We missed on adding Scarthgap to the list of user manuals, so let's fix
this oversight.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/releases.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/releases.rst b/doc/releases.rst
index a595a83b6..b271e2ad3 100644
--- a/doc/releases.rst
+++ b/doc/releases.rst
@@ -4,6 +4,12 @@
 BitBake Supported Release Manuals
 =================================
 
+*******************************
+Release Series 5.0 (scarthgap)
+*******************************
+
+- :yocto_docs:`BitBake 2.8 User Manual </bitbake/2.8/>`
+
 ******************************
 Release Series 4.0 (kirkstone)
 ******************************

-- 
2.45.2


