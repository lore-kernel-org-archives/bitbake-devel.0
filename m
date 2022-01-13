Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B4C433F5
	for <webhook@archiver.kernel.org>; Thu, 13 Jan 2022 16:54:03 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web09.11544.1642092841492720401
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jan 2022 08:54:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 150EF20008;
	Thu, 13 Jan 2022 16:53:58 +0000 (UTC)
Subject: Re: [bitbake-devel] [1.46][PATCH] hashserv: specify loop for asyncio
 in python < 3.7
To: Jate Sujjavanich <jatedev@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20220113010527.181-1-jatedev@gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <78ac1aea-db40-2a99-1668-dc3bfcb3a074@bootlin.com>
Date: Thu, 13 Jan 2022 17:53:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113010527.181-1-jatedev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Jan 2022 16:54:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13233

Hi Jate

On 1/13/22 2:05 AM, Jate Sujjavanich wrote:
> Detect python version 3.6 and below restoring loop argument where
> it is still required. In 3.7 auto loop detection is available.
>
> Bitbake 1.46 is used in dunfell which requires a minimum python version
> of 3.5. Omitting this argument leads to a regression and hang during
> "Initialising tasks" at 44%.


Thanks for the patch!
Weirdly, though, my host (Ubuntu 20.04) has Python 3.8 and still
regularly has the "Initializing task" step stuck at 44% for a several
minutes.

Here's what strace says while this happens:
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
{tv_sec=1642092729, tv_nsec=110486000}, FUTEX_BITSET_MATCH_ANY) = -1
ETIMEDOUT (Connection timed out)
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
{tv_sec=1642092729, tv_nsec=360665000}, FUTEX_BITSET_MATCH_ANY) = -1
ETIMEDOUT (Connection timed out)
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
{tv_sec=1642092729, tv_nsec=610862000}, FUTEX_BITSET_MATCH_ANY) = -1
ETIMEDOUT (Connection timed out)
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
{tv_sec=1642092729, tv_nsec=861086000}, FUTEX_BITSET_MATCH_ANY) = -1
ETIMEDOUT (Connection timed out)
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
{tv_sec=1642092730, tv_nsec=111295000}, FUTEX_BITSET_MATCH_ANY) = -1
ETIMEDOUT (Connection timed out)
...

Any clue why this can happen?

Thanks
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


