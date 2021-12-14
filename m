Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BDBC433F5
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 21:42:04 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web12.32449.1639518120374885996
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Dec 2021 13:42:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 63F421BF203;
	Tue, 14 Dec 2021 21:41:58 +0000 (UTC)
To: YP docs mailing list <docs@lists.yoctoproject.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: How to start a read-only hash server?
Organization: Bootlin
Message-ID: <01318822-37b6-b1aa-6235-ce0f6e6e28c3@bootlin.com>
Date: Tue, 14 Dec 2021 22:41:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Dec 2021 21:42:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13159

Hello,

In
https://git.openembedded.org/bitbake/tree/lib/hashserv/server.py#n514, I
see that it's possible to have a read-only hash server.

Is running "bin/bitbake-hashserv --read-only" from the command-line the
only way? I expected this to be possible through a BitBake variable too.

Anyway, this should be documented, right?

Thanks in advance
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


