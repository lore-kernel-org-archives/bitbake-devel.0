Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3D4D1BDC7
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 17:07:08 +0000 (UTC)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20769.1764781622116670252
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 09:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dM3w40cchzNf9;
	Wed,  3 Dec 2025 18:07:00 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dM3w32MbGzHfw;
	Wed,  3 Dec 2025 18:06:59 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH 0/3] doc: bitbake-user-manual: few fixes related to
 locating include files
Date: Wed, 03 Dec 2025 18:06:49 +0100
Message-Id: <20251203-doc-file-include-require-v1-0-fc708832b475@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W+im7uBXxINsnRZkaociiH93e
 EwgeSCzCmfoqweUL8mypQKmrsAvU5oZJRQGS7YzlhoMm8coa/HJr2dgVD5OUcZoHbWOArXGQcl
 35Sj3vx7G9/0AemolYmoAAAA=
X-Change-ID: 20251203-doc-file-include-require-f260460d0416
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 17:07:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18533

This fixes a few oversight, reorder paragraph about the file location
search paths and specify inherit_defer can be used for classes too.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      doc: fix a few typos
      doc: bitbake-user-manual-intro: specify inherit_defer directive for recipe classes
      doc: bitbake-user-manual-metadata: reorder introduction on how to locate include files

 doc/bitbake-user-manual/bitbake-user-manual-intro.rst    | 11 ++++++-----
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 11 ++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)
---
base-commit: 720df1a53452983c1c832f624490e255cf389204
change-id: 20251203-doc-file-include-require-f260460d0416

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


