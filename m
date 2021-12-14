Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0B1C433EF
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 20:54:27 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.31481.1639515265972571568
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Dec 2021 12:54:26 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1AA974000C;
	Tue, 14 Dec 2021 20:54:23 +0000 (UTC)
To: YP docs mailing list <docs@lists.yoctoproject.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: Can BB_HASHSERVE still take a 'host:port' value?
Organization: Bootlin
Message-ID: <9234471a-8cb1-429a-0dd9-6820cdf62616@bootlin.com>
Date: Tue, 14 Dec 2021 21:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Dec 2021 20:54:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13157

Greetings,

I'm trying to propose more details and updates to the documentation
about the Hash Equivalence topic.

Looking at the code, especially at
https://git.openembedded.org/bitbake/tree/lib/bb/cooker.py#n387, I'm
wondering whether BB_HASHSERVE can still take a 'host:port' value as the
current BitBake documentation says.

From what I've read so far, it seems to me that if BB_HASHSERVE ==
"auto", a local server is started using a UNIX socket, possibly tied to
a remote upstream server specified through BB_HASHSERVE_UPSTREAM.

The other pieces of code where I found BB_HASHSERVE don't seem to show
any use of a 'host:port' value either.

Am I right?

Thanks in advance,

Michael.


-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


