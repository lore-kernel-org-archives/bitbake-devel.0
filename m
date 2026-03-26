Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C88510AB81D
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 19:23:59 +0000 (UTC)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.56232.1774553029561822677
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 12:23:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=BBuzvcgu;
 spf=pass (domain: 0leil.net, ip: 84.16.66.172, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fhYbl6zsHzJBZ;
	Thu, 26 Mar 2026 20:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1774553027;
	bh=c3eKtAlZbcMTUtsrMKkKOCk55tYS9VfQsXZ7Ccdtguo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BBuzvcguXAmh5jSGXLUKnnjptTNOKVZBAkS50WYgZgS3hb/W9k+x6wT99mZvyTPv6
	 kowjTVMoCnoGR85HBOGYXzqKMEDPwFCWgoq2wuvrFtd+jP32H5i/3ztDXbaDCT5kui
	 zg7apodB5jNggWZ1IbcFNWPj3wzqZK9FCuUZmnZ6yYwp3/8YN7tOxMok5FQcoOX9es
	 aWxpfA0EotaXAuYNly1mw9aUeGpIdm9wqIKIJBiu6pZEfg57iLSn9e72MVY+MOUKpk
	 bbcBXqmj9PCBTxETTm2f4GocNZlKfIYVy/FG2D5MWkUbUdKIZO+e32LqWpYOWfd8h5
	 9beH0OZInEshw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fhYbk3vKnzP3c;
	Thu, 26 Mar 2026 20:23:46 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 26 Mar 2026 20:23:32 +0100
Subject: [PATCH 2/3] doc: bitbake-user-manual-metadata: fix indentation
 consistency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-metadata-code-blk-v1-2-051530f9a051@cherry.de>
References: <20260326-metadata-code-blk-v1-0-051530f9a051@cherry.de>
In-Reply-To: <20260326-metadata-code-blk-v1-0-051530f9a051@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 19:23:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19259

From: Quentin Schulz <quentin.schulz@cherry.de>

We've decided code-blocks should be indented by three whitespaces
compared to the parent block and this only had two, so let's add the
missing whitespace. This is cosmetic in the sources only, it doesn't
change the output.

Fixes: 3b9d7bea915d ("parse/ast: add support for 'built-in' fragments")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 56604e0dd..4909b0d75 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1054,11 +1054,11 @@ The variable containing a built-in fragment definitions could look like this::
 and then if 'someprefix/somevalue' is added to the variable that holds the list
 of enabled fragments::
 
-  OE_FRAGMENTS = "... someprefix/somevalue"
+   OE_FRAGMENTS = "... someprefix/somevalue"
 
 bitbake will treat that as direct value assignment in its configuration::
 
-  SOMEVARIABLE = "somevalue"
+   SOMEVARIABLE = "somevalue"
 
 Locating Include Files
 ----------------------

-- 
2.53.0


