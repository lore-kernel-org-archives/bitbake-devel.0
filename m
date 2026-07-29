Return-Path: <amery@apptly.co>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637CBC54F51
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 00:28:55 +0000 (UTC)
Received: from v523.v5ed9ac7d.euw1.send.eu.mailgun.net (v523.v5ed9ac7d.euw1.send.eu.mailgun.net [141.193.32.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1002.1785284934674356733
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Jul 2026 17:28:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@e.apptly.co header.s=mta header.b=cA9zi9lT;
 spf=pass (domain: e.apptly.co, ip: 141.193.32.23, mailfrom: bounce+ec7242.b6604b-bitbake-devel=lists.openembedded.org@e.apptly.co)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=e.apptly.co; q=dns/txt; s=mta; t=1785284932; x=1785292132;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From: References: To: To: Subject: Subject: MIME-Version: Date: Message-ID: Sender: Sender;
 bh=WFgYxyH4KXqdEiD725zKB97bVEb8FtXUgMs66aKArso=;
 b=cA9zi9lTJR+2rCP7ylTwAibxMpJ3Nw1fy9WAdAuIafCsljSeb2pK9MYVtEtRpA+FiuEqymTW0KwnR4VBCMTe6NfzP78/Rl2vsuzHsUqilAYoAHMd+t/AAwHiKORa5Rw+m8P90t0Q/A06poC2LI1uraW8U6dAQJvtp1WXLKTDQg8=
X-Mailgun-Sid: WyI5YTJmMyIsImJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyIsImI2NjA0YiJd
Received: from [192.168.52.36] (brig-22-b2-v4wan-169287-cust1029.vm14.cable.virginm.net
 [81.97.100.6]) by
 4448f204f6bb6ceca80cb5349ca678edc67a8f368e2b3c6fd0bbe75749d955fa with SMTP id
 6a6949448927fc5a1c5ded18 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 29 Jul 2026 00:28:52 GMT
X-Mailgun-Sending-Ip: 141.193.32.23
Sender: amery=apptly.co@e.apptly.co
Message-ID: <45e074c4-c23e-4416-9f18-e9198de17c7b@apptly.co>
Date: Wed, 29 Jul 2026 01:28:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-worker: Evaluate
 exported_vars() before emptying the environment
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20260727172856.2304118-1-amery@apptly.co>
 <8b324e07c0501a6e613fe197aa6e462422360d93.camel@linuxfoundation.org>
Content-Language: en-GB
From: Alejandro Mery <amery@apptly.co>
Organization: Apptly Software Ltd
In-Reply-To: <8b324e07c0501a6e613fe197aa6e462422360d93.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 00:28:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19868


On 28/07/2026 22:15, Richard Purdie wrote:
> On Mon, 2026-07-27 at 17:28 +0000, Alejandro Mery via lists.openembedded.org wrote:
>> exported_vars() returns a lazy generator. It was bound before
>> empty_environment() cleared the process environment and only iterated
>> afterwards, so any datastore expansion deferred until iteration ran
>> against the wiped environment rather than the one bitbake started with.
>>
>> The corruption is not uniform. The loop writes each variable into
>> os.environ as it goes, so only the first value expands against a fully
>> empty environment and the rest see it partially rebuilt, in
>> exported_keys() order.
>>
>> Recipes whose exported variables expand a command during that loop hit
>> this. A gitver-style PV such as "${@get_git_pv(d, ...)}" runs git while
>> PATH is empty, so the git wrapper on PATH is bypassed and the real git
>> runs directly. Under pseudo this fakes uid 0 against a repository owned
>> by the real user, and git aborts with "detected dubious ownership",
>> failing do_package intermittently (only on reparse, when the value is
>> re-expanded rather than served from cache).
>>
>> Materialise the generator into a list before emptying the environment so
>> every expansion happens while that environment is still intact. Add
>> tests for the expansion timing this relies on: values materialised
>> before empty_environment() survive it, a generator consumed after it
>> does not.
>>
>> - v2: comment the ordering at the call site, and add the tests.
>> - v1: the list() wrap alone.
>>
>> Signed-off-by: Alejandro Mery <amery@apptly.co>
>> ---
>>   bin/bitbake-worker   |  5 ++++-
>>   lib/bb/tests/data.py | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 46 insertions(+), 1 deletion(-)
> Thanks for the changes.
>
> I'm worried that the test case doesn't cover what I'd ideally like it
> to, specifically that bitbake-worker's environment can't get corrupted.
> The code in bitbake-worker can be changed independently of the test
> case and break things, which means the test isn't protecting against
> what I most fear happening.

true


>
> I did a bit more research and thinking about this and I think I might
> suggest a new approach. I've noticed that this is the only user of
> exported_vars() in the codebase, so perhaps we just stop returning a
> generator?
>
> It does appear to be causing a lot more problems than it solves,
> particularly if we just turn it into a list anyway!
>
> If we change things that way, it seems much more unlikely we can break
> it in future and the need for the comments is removed.
>
> Does that seem reasonable? Sorry about the change in direction but this
> patch just doesn't look/feel right now I realise there is only one user
> of the function.

absolutely. I blindly assumed you wanted it to be a generator.

so, for v3 exported_vars() returns a materialised list. what would you 
want the tests t do?


