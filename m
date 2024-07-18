Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8119C3DA7E
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 13:52:21 +0000 (UTC)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
 by mx.groups.io with SMTP id smtpd.web11.15616.1721310740502494980
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jul 2024 06:52:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.175, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPvPZ4fbHzChX;
	Thu, 18 Jul 2024 15:52:18 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPvPZ0B46znn;
	Thu, 18 Jul 2024 15:52:17 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH 0/3] doc: releases: fix missing releases and migrate
 mickledore to EOL section
Date: Thu, 18 Jul 2024 15:51:58 +0200
Message-Id: <20240718-yocto-releases-v1-0-204f3e3dade4@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP4dmWYC/3XMQQqDMBCF4avIrJuSCdFoV96juFAzbQaKKRORB
 vHuTd13+T943w6JhCnBrdpBaOPEcSmBlwrmMC5PUuxLg9HGaoetynFeoxJ60ZgoKeusR2OnDrG
 BcnoLPfhzgvehdOC0Rsmnv+Fv/UttqLSa2tohto3uatPPgUTy1RMMx3F8AfuW+7SsAAAA
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 bitbake-devel@lists.openembedded.org, foss+yocto@0leil.net, 
 docs@lists.yoctoproject.org
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jul 2024 13:52:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16427

We've missed on a couple of releases and mickeldore also needs to be
moved to the EOL section.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20240718-yocto-releases-v1-0-b85711860952@cherry.de

---
Quentin Schulz (3):
      doc: releases: mark mickledore as outdated
      doc: releases: add nanbield to the outdated manuals
      doc: releases: add scarthgap

 doc/releases.rst | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)
---
base-commit: 1d7360031164f04887c792fb0b2dd86c6ccfcc23
change-id: 20240718-yocto-releases-474d124b9116

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


