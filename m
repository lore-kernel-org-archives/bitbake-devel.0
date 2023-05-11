Return-Path: <peter@berginkonsult.se>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602D9C7EE22
	for <webhook@archiver.kernel.org>; Thu, 11 May 2023 20:27:38 +0000 (UTC)
Received: from mailrelay4-2.pub.mailoutpod2-cph3.one.com (mailrelay4-2.pub.mailoutpod2-cph3.one.com [46.30.211.185])
 by mx.groups.io with SMTP id smtpd.web10.7451.1683836852056954757
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 May 2023 13:27:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@berginkonsult.se header.s=rsa2 header.b=bJrJm+Y1;
 spf=none, err=permanent DNS error (domain: berginkonsult.se, ip: 46.30.211.185, mailfrom: peter@berginkonsult.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=berginkonsult.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=r2WMjIfxUln3gTxBpGkmVVit/272CqUjKXa+PNwLios=;
	b=bJrJm+Y1Ga2SjYVvvXasXQ8Ltgiywdyg3+an65aWdOTwSexx8tiVF49OBKRATkMLoTopI52GrFg5G
	 JARF/IOIVBHAIrfJcJzc1Cvr4Kbo5T4PwGLBL9+NGgc40TXJVKBEVJh1NwV3ps2oVFXeJc7wLv1BdG
	 IhLIvKOoK9+e/vve2YUxs4S6Lyc87KcCCaRfP2d4Nr1zU21UkFr8t3BYinEkogqkeYi14skOqH8PGO
	 SQkBCObNuVfOb/riYn8ASx/yL+rV4FNwdJoxDHPPZ+RN2PQKh9VnwHal879+qQzz2L0P5EErUmVEnP
	 ehLT7ggFrPeMzxTkVDZqYY+fi6MhvPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=berginkonsult.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=r2WMjIfxUln3gTxBpGkmVVit/272CqUjKXa+PNwLios=;
	b=42Dscw4Oz9lKy04XHQbjb2sC93R+8TOFhVjOMvUe2mYAlD3mtArs6dOT19NNDFGKgIxslOJ6Ibp3L
	 7kHwqscAg==
X-HalOne-ID: 3f8ec32e-f03a-11ed-9290-592bb1efe9dc
Received: from [192.168.100.35] (c-799071d5.44006-0-69747578.bbcust.telenor.se [213.113.144.121])
	by mailrelay4 (Halon) with ESMTPSA
	id 3f8ec32e-f03a-11ed-9290-592bb1efe9dc;
	Thu, 11 May 2023 20:27:28 +0000 (UTC)
Message-ID: <0b7eed30-97aa-92ff-732d-c2e78012b9b4@berginkonsult.se>
Date: Thu, 11 May 2023 22:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bitbake-devel] [PATCH] lib/bb/tests/fetch.py: set initial branch
Content-Language: en-US
To: alexandre.belloni@bootlin.com
Cc: bitbake-devel@lists.openembedded.org,
 "Bergin, Peter" <Peter.Bergin@windriver.com>
References: <20230509121717.1862519-1-peter@berginkonsult.se>
 <20230511155540e3a38c60@mail.local>
From: Peter Bergin <peter@berginkonsult.se>
In-Reply-To: <20230511155540e3a38c60@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 May 2023 20:27:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14785

Hi,

On 2023-05-11 17:55, Alexandre Belloni via lists.openembedded.org wrote:
> Hello,
>
> This fails on the autobuilders:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1397/steps/11/logs/stdio
>
> error: unknown option `initial-branch=master'
> usage: git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [<directory>]
>
Host is Ubuntu 20.04 and from what I found it is running git version 
2.25. The argument '--initial-branch' to 'git-init' was added in version 
2.28, some time mid 2020. That is most probably the root cause of the 
failure. My verification was done on Ubuntu 22.04 using git version 2.34.

The solution I can come up with at the moment is to do:

'git init'
'git checkout -b master'

Is it worth sending a v2 on that? Or do you see a better solution?

/Peter


> On 09/05/2023 14:17:17+0200, Peter Bergin wrote:
>> From: "Bergin, Peter" <Peter.Bergin@windriver.com>
>>
>> If you have a host where the git config for initial branch
>> name is something else than 'master' the unittest will fail
>> as they assume the default branch name is 'master'. Fix this
>> by explicitly set the intial branch name at 'git init'.
>>
>> Signed-off-by: Peter Bergin <peter.bergin@windriver.com>
>> Signed-off-by: Peter Bergin <peter@berginkonsult.se>
>> ---
>>   lib/bb/tests/fetch.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
>> index 532adb941..f71d0d10c 100644
>> --- a/lib/bb/tests/fetch.py
>> +++ b/lib/bb/tests/fetch.py
>> @@ -423,7 +423,7 @@ class FetcherTest(unittest.TestCase):
>>           return bb.process.run(cmd, cwd=cwd)[0]
>>   
>>       def git_init(self, cwd=None):
>> -        self.git('init', cwd=cwd)
>> +        self.git(['init', '--initial-branch=master'], cwd=cwd)
>>           if not self.git(['config', 'user.email'], cwd=cwd):
>>               self.git(['config', 'user.email', 'you@example.com'], cwd=cwd)
>>           if not self.git(['config', 'user.name'], cwd=cwd):
>> -- 
>> 2.34.1
>>
>>
>>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14784): https://lists.openembedded.org/g/bitbake-devel/message/14784
> Mute This Topic: https://lists.openembedded.org/mt/98782276/3617552
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [peter@berginkonsult.se]
> -=-=-=-=-=-=-=-=-=-=-=-
>

