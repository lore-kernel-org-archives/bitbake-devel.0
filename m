Return-Path: <amikan@ilbers.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192FAD13588
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 07:57:39 +0000 (UTC)
Received: from shymkent.ilbers.de (shymkent.ilbers.de [85.214.156.166])
 by mx.groups.io with SMTP id smtpd.web11.46337.1730102255514236717
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Oct 2024 00:57:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: ilbers.de, ip: 85.214.156.166, mailfrom: amikan@ilbers.de)
Received: from [127.0.0.1] (host-80-81-17-52.static.customer.m-online.net [80.81.17.52])
	(authenticated bits=0)
	by shymkent.ilbers.de (8.15.2/8.15.2/Debian-8+deb9u1) with ESMTPSA id 49S7vVHB005119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:57:32 +0100
Message-ID: <e189adfe-65b7-4d04-a2a2-0aed0ddeedae@ilbers.de>
Date: Mon, 28 Oct 2024 09:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, ru-RU
To: bitbake-devel@lists.openembedded.org
Cc: Baurzhan Ismagulov <ibr@ilbers.de>
From: Anton Mikanovich <amikan@ilbers.de>
Subject: Why bb.warning output goes to stdout?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 07:57:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16733

Hello all,

I've just noticed that bb.warning() API (and also bbwarn FIFO API) output
messages to stdout, while warnings are usually goes to stderr.
Having warnings in stderr can be useful if using pipes to inform the user
about any issues without hiding them. Python logger is also output warnings
to stderr.
Is there any reason of bitbake to output warnings to stdout?


