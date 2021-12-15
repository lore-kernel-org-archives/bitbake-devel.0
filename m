Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5373AC433F5
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 14:00:53 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web08.40591.1639576852491684179
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Dec 2021 06:00:52 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DBC421BF20E;
	Wed, 15 Dec 2021 14:00:49 +0000 (UTC)
Cc: YP docs mailing list <docs@lists.yoctoproject.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [docs] Can BB_HASHSERVE still take a 'host:port'
 value?
To: Joshua Watt <JPEWhacker@gmail.com>
References: <9234471a-8cb1-429a-0dd9-6820cdf62616@bootlin.com>
 <CAJdd5GbRMTVhm9rZHOEmX3a-14cZsby_RuAX2SRjhv6cvvAq9w@mail.gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <d19f9e73-929f-d32e-ef57-6e48950c1b20@bootlin.com>
Date: Wed, 15 Dec 2021 15:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: 
 <CAJdd5GbRMTVhm9rZHOEmX3a-14cZsby_RuAX2SRjhv6cvvAq9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Dec 2021 14:00:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13164

Hi Joshua,

On 12/14/21 11:11 PM, Joshua Watt wrote:
> On Tue, Dec 14, 2021 at 2:54 PM Michael Opdenacker
> <michael.opdenacker@bootlin.com> wrote:
>> Greetings,
>>
>> I'm trying to propose more details and updates to the documentation
>> about the Hash Equivalence topic.
>>
>> Looking at the code, especially at
>> https://git.openembedded.org/bitbake/tree/lib/bb/cooker.py#n387, I'm
>> wondering whether BB_HASHSERVE can still take a 'host:port' value as the
>> current BitBake documentation says.
>>
>> From what I've read so far, it seems to me that if BB_HASHSERVE ==
>> "auto", a local server is started using a UNIX socket, possibly tied to
>> a remote upstream server specified through BB_HASHSERVE_UPSTREAM.
>>
>> The other pieces of code where I found BB_HASHSERVE don't seem to show
>> any use of a 'host:port' value either.
> BB_HASHSERVE can be one of:
>  1) "auto" to automatically start a local hash server, optionally
> using BB_HASHSERVE_UPSTREAM as the upstream
>  2) HOST:PORT to connect to an existing hash server over TCP
>  3) unix://PATH to connect to an existing hash server over a UNIX domain socket


Thanks for confirming this.
However, when BB_HASHSERVE is set to "HOST:PORT", may I ask you were
this is implemented in the code?
Thanks again
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


