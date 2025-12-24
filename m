Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ACBE776C1
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 15:13:12 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.122288.1766589184372252742
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Dec 2025 07:13:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=DkvCLqos;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-20251224151302b344f0cbeb00020754-jbe4gr@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251224151302b344f0cbeb00020754
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 24 Dec 2025 16:13:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZRYKFUGK+ZLukyVOVisXh9oayq+RssshAkELHJo0Suk=;
 b=DkvCLqosSvcaI2VRwXhqArxf8gbk2YR/x6MycHWJgD1iPb2h+/cGXrjEMYulT1wPIRi68A
 LQDGUOZ+dcaG7Zds8LZVxYyU6nKxcmWZ08oQLC627X6bsfSRrh6sKIh6IXh8w8N/7M9csVMf
 0XIOmjBNV9GdxLaXb3T4lIWTwirUD8QkE650UVdYPeSpyY7wb7rk0NvvLnSfZdQiKRg/2nd4
 nZGqwSoThQCY9QoSpwxZqhzudgtcPD+1FUEcZQMNPJfLNZnqemUsOC0gb00odpEap0kLF5tt
 xl1M9fsm/PZ3Ug/Vyey4i5Kk4HYALVdlYGQ7JMbwXJG7ou02WgBv3zQQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 0/1] bitbake-setup: Initialize build environment after setup/update
Date: Wed, 24 Dec 2025 16:12:14 +0100
Message-ID: <20251224151248.3313463-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Dec 2025 15:13:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18648

From: Adrian Freihofer <adrian.freihofer@siemens.com>

This is related to https://lists.openembedded.org/g/openembedded-core/message/228541

It does not have a hard dependency on the oe-core change, but this bitbake change
does not make sense without it.

Adrian Freihofer (1):
  bitbake-setup: Initialize build environment after setup/update

 bin/bitbake-setup | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.52.0


