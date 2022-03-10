Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C30C433EF
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 17:57:55 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web08.12644.1646935074614828554
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 09:57:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=N0vt583B;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BA10840005;
	Thu, 10 Mar 2022 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646935072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWYDtnzUcumwE3bzFkhgwhBdPN5pzhy+kxXAIiazaFc=;
	b=N0vt583Bq5KHfKrDfNsQong6wnH32AsMzmEAZOmWQ37wn81vhIwFkdsMIovIyOHFG86rx5
	/Tw3ClxEZDEtFuBmPIkOovaJ93Lp5Bkmz3fNgwU+XdYMwzSpgXWdvAO89JGu/bmnI/0puf
	1N4QQgxd32VH3WrMTUkjM4ZC5/B5lOKLEUDaPwMExvvnobJ21uvwWmYdu5PTl36GSm+Qtj
	yVM+ogh8dVbQEw42ac5TNFFbdmCiwp7Fr6uD3FfsnJC32EQFNaM5RbG1LmwO57n62GLnU4
	clOgxSfabEJbD1vWTfIS8KQiCrdU4kqHCOnnmZ3G7Q/UwrSr+aw9oKH+edXN6w==
Message-ID: <2e0c1d15-62d5-353d-7948-a7aec3a86dcb@bootlin.com>
Date: Thu, 10 Mar 2022 18:57:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] lib/bb/tests/fetch.py still in use?
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <f24b08c0-d638-280f-30a9-a5483222a310@bootlin.com>
 <5964d48ebd56efb9c7071fde98c852c069d507c1.camel@linuxfoundation.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: 
 <5964d48ebd56efb9c7071fde98c852c069d507c1.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 17:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13474

Hi Richard,

On 3/10/22 18:45, Richard Purdie wrote:
> On Thu, 2022-03-10 at 18:04 +0100, Michael Opdenacker via lists.openembedded.org
> wrote:
>> lib/bb/tests/fetch.py still refers to cvs.handhelds.org which doesn't
>> exist any more, though it brings back fond memories.
>>
>> Should the corresponding entries be removed or updated with working CVS
>> hosts?
>>
>> Or can lib/bb/tests/fetch.py be removed if it's not used any more?
> I suspect you didn't look at what those test actually do. They're unittests
> which test whether certain input to functions generates the expected output.
>
> Those tests never actually access the urls, they just test the data out is
> expected for given input data.
>
> The tests in that file are very much definitely run on the autobuilder and are
> some of the most comprehensive tests we have of any bitbake module so no, they
> shouldn't be removed!


Thanks for the clarification. I lost my desire to remove stuff :)
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


