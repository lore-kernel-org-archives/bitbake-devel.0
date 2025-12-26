Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BD1E8FDAF
	for <webhook@archiver.kernel.org>; Fri, 26 Dec 2025 17:21:38 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.156679.1766769689878045240
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Dec 2025 09:21:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=Haqok3P6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-202512261721260549eb667a0002070e-ggwjfq@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202512261721260549eb667a0002070e
        for <bitbake-devel@lists.openembedded.org>;
        Fri, 26 Dec 2025 18:21:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=yQNVd4I9kc0t0J7viFJzuz0lbP8fA15+5XRlrphA2cw=;
 b=Haqok3P6qJLq6CxsD7VXNLLJHAw1IBMMVQfiH6R55ZTqQLEJNF1F9vGS1Im4qMW+bq2iet
 ltp6W/J75y6l6MGiU/vakmmpby4Gz4DHxM5dviquJtl71kLp0OmhUs1Xd/Pt/CO/yyNno8R3
 UkV9cBFzxkL5TSBk/ZbPUElVOUqVUkhw/2CdajytEjuWf4j5H8rdhB68JN63xrvornKOGcv3
 rx+SMWtxtf1O6eP1wR9t/1VjRFJ9Y3lC4Szjv4HKOW4qBNb9GLhq7eiTYAhLIShZNW/xCgLy
 ccifdprOJuLDc2sDoOVCsFxuEUeXLu59aMj8lVpqdIfiIXpY8gSohXAQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 0/1] bitbake-setup: Initialize build environment after setup/update
Date: Fri, 26 Dec 2025 18:19:04 +0100
Message-ID: <20251226172034.1091465-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Dec 2025 17:21:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18653

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Changes in comparison to v1:
ERROR: test_setup (bb.tests.setup.BitbakeSetupTest)

This is related to https://lists.openembedded.org/g/openembedded-core/message/228541

It does not have a hard dependency on the oe-core change, but this bitbake change
does not make sense without it.

Adrian Freihofer (1):
  bitbake-setup: Initialize build environment after setup/update

 bin/bitbake-setup | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

-- 
2.52.0


