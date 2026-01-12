Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814CCF45C0
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 16:36:45 +0000 (UTC)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37248.1768235796999535432
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 08:36:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.8, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqdLV6CyhzlFF;
	Mon, 12 Jan 2026 17:36:34 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqdLS4d2Rzg2T;
	Mon, 12 Jan 2026 17:36:32 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH 0/8] doc: bitbake-user-manual-metadata: misc improvements
 on sharing functionality
Date: Mon, 12 Jan 2026 17:36:04 +0100
Message-Id: <20260112-doc-directives-v1-0-b23923cfce89@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBN0UIOuEi1Kp5qNhoYE0t2Tl
 m/xf4NCmanAJBpkqlw4xQ49CPDnGg+SHLoBFTqlNcqQvAycyd9cqUhHBjevzGjRQo+uTDs//3B
 e3vcDK1UC+WAAAAA=
X-Change-ID: 20260112-doc-directives-6e42bc047525
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Robert P. J. Day" <rpjday@crashcourse.ca>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 16:36:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18735

This expands on the include_all directive by providing an example and
highlighting the difference with the include directive.

It fixes some highlighting and cross-referencing inconsistencies as well
as the wrong path in the examples.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (8):
      doc: bitbake-user-manual-metadata: list (in order) all sharing directives
      doc: bitbake-user-manual-metadata: highlight configuration fragment differently
      doc: bitbake-user-manual-metadata: use a cross-reference for addfragments
      doc: bitbake-user-manual-metadata: specify that current dir won't be searched for include_all
      doc: bitbake-user-manual-metadata: add missing highlight for BBPATH and PATH
      doc: bitbake-user-manual-metadata: fix incorrect path in example for locating files
      doc: bitbake-user-manual-metadata: expand on search paths for include directive
      doc: bitbake-user-manual-metadata: expand locating files example for include_all directive

 .../bitbake-user-manual-metadata.rst               | 65 ++++++++++++++++++----
 1 file changed, 54 insertions(+), 11 deletions(-)
---
base-commit: f23e186a75e71ba885b9b53a1dfda99af29c67b0
change-id: 20260112-doc-directives-6e42bc047525

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


