Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5F8C433EF
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 16:40:29 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.11730.1646930428679547584
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 08:40:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CX0W/T1A;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id AE2941C000D;
	Thu, 10 Mar 2022 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646930427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxJZBn+0lLgAAZSc3rgDqaCujlETyXSWyq8q9CW4+Fo=;
	b=CX0W/T1AYieHa0EzX0YDSWR6m6KVyshEMk8gE0vpufjqcn5C9dvZrqk95LJflm3ogPCHhW
	aMjEn8NRk4NtkVy0XINFkU40qPKD5KxgRCyJzgIrKOZTwhJg3QwOEmLwC4JPDJror+7kcK
	+3/KSDCzqrHVwEms0LSWuFrUiEMJrR/bjwBcQ5y6PryeAs9e8IVaHTYb8G3cliZGS6m2bQ
	Yy+p1vZoJ0g7coG3N3PPU2rtAI9CsjROKn3Yogn7U3cRGYC2qMHyQpaSEyU0ThLb+jNTsW
	PzwIY7w6GnFo31d9lFfBwFt9xtOuEsyjr9qWUWIfT7WR1o8/mqIgxlRUEPvvZg==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH v2 0/2] branch parameter now mandatory in git SRC_URIs
Date: Thu, 10 Mar 2022 17:40:17 +0100
Message-Id: <20220310164019.24515-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <16DB126739A33B35.20222@lists.yoctoproject.org>
References: <16DB126739A33B35.20222@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 16:40:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13469

Changes since V1:
- Mesa now has a "main" branch
- Pick dummy or real examples with a "main" branch
- "branch=" is mandatory unless "nobranch=1"

Michael Opdenacker (2):
  doc: bitbake-user-manual: add branch parameter to git SRC_URI examples
  doc: bitbake-user-manual: branch parameter now mandatory in git
    SRC_URIs

 .../bitbake-user-manual-fetching.rst               | 14 +++++++-------
 .../bitbake-user-manual-ref-variables.rst          |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.25.1


