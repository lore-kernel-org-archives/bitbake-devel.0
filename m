Return-Path: <amery@apptly.co>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1EEC531C9
	for <webhook@archiver.kernel.org>; Sat, 25 Jul 2026 18:01:52 +0000 (UTC)
Received: from v5234.v57ae4e16.euw1.send.eu.mailgun.net (v5234.v57ae4e16.euw1.send.eu.mailgun.net [161.38.204.234])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2113.1785002505990704445
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jul 2026 11:01:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@e.apptly.co header.s=mta header.b=CPpYxpRv;
 spf=pass (domain: e.apptly.co, ip: 161.38.204.234, mailfrom: bounce+ec7242.b6604b-bitbake-devel=lists.openembedded.org@e.apptly.co)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=e.apptly.co; q=dns/txt; s=mta; t=1785002504; x=1785009704;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From: References: To: To: Subject: Subject: MIME-Version: Date: Message-ID: Sender: Sender;
 bh=xXU9qozE2S2qKP0AbjVyAuye3YpSqVbzML4yLxnwwBc=;
 b=CPpYxpRvh9RBRsAAcNCCqzvUJ5nPN3n8V6S750WzKz2q2Ib6dMpqVma4ySWV4+baFceXjqp+jGAgNbLIuNouY9GJftK6bjpFdcO9ZDI3gDnb/gce1blRlBieoWypkWI0MbGKpC1ULNQspnBDqsdcYF1tLbFh/EQwmYMB+gavOcg=
X-Mailgun-Sid: WyI5YTJmMyIsImJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZyIsImI2NjA0YiJd
Received: from [192.168.52.36] (brig-22-b2-v4wan-169287-cust1029.vm14.cable.virginm.net
 [81.97.100.6]) by
 88e476566652c835c870029fa9cc541267c98436d6f97deb6be8d815d37cf5ca with SMTP id
 6a64fa08599bd22e95504bb5 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sat, 25 Jul 2026 18:01:44 GMT
X-Mailgun-Sending-Ip: 161.38.204.234
Sender: amery=apptly.co@e.apptly.co
Message-ID: <1d7573cc-035a-49d0-b978-d8bf06dbbfea@apptly.co>
Date: Sat, 25 Jul 2026 19:01:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [2.18][PATCH] bitbake-worker: Evaluate
 exported_vars() before emptying the environment
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20260720195834.2496647-1-amery@apptly.co>
 <859e14e2c6da1c914ae3ec7f2c2065424cde8f10.camel@linuxfoundation.org>
Content-Language: en-US
From: Alejandro Mery <amery@apptly.co>
Organization: Apptly Software Ltd
In-Reply-To: <859e14e2c6da1c914ae3ec7f2c2065424cde8f10.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jul 2026 18:01:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19859


On 23/07/2026 07:06, Richard Purdie wrote:
> On Mon, 2026-07-20 at 19:58 +0000, Alejandro Mery via lists.openembedded.org wrote:
>> exported_vars() returns a lazy generator. It was bound before
>> empty_environment() cleared the process environment and only iterated
>> afterwards, so any datastore expansion deferred until iteration ran with
>> PATH already wiped.
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
>> every expansion happens while PATH is still intact.
>>
>> Signed-off-by: Alejandro Mery <amery@apptly.co>
>> ---
>>   bin/bitbake-worker | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
>> index aa14ef191..0db1531e0 100755
>> --- a/bin/bitbake-worker
>> +++ b/bin/bitbake-worker
>> @@ -290,7 +290,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
>>   
>>                   # exported_vars() returns a generator which *cannot* be passed to os.environ.update()
>>                   # successfully. We also need to unset anything from the environment which shouldn't be there
>> -                exports = bb.data.exported_vars(the_data)
>> +                exports = list(bb.data.exported_vars(the_data))
>>   
>>                   bb.utils.empty_environment()
>>                   for e, v in exports:
> Thanks for this. Nice work in tracking it down!
>
> I think in this case we need a couple of things, firstly will be a bit
> more explination in the code with a comment about why we need a list
> there.
>
> The failure case is so unusual we should also probably write a test
> case to make sure we test for and don't regress that issue which we'd
> add to the existing tests in bitbake-selftest.
>
> Help with that would be welcome or we'll get to it when we can...


I'll send a v2 soon


