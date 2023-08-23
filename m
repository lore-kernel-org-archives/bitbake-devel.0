Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1209CC3DA6F
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 21:44:29 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by mx.groups.io with SMTP id smtpd.web11.663.1692827058781232060
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Aug 2023 14:44:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=ti-com-17Q1 header.b=Kqotq9os;
 spf=pass (domain: ti.com, ip: 198.47.23.249, mailfrom: rs@ti.com)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NLiHEk085921;
	Wed, 23 Aug 2023 16:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692827057;
	bh=Onv2wJfREOYN9etq1oFqY6xqUqDTIf38YLXJHXMk/nk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Kqotq9osEeatiJIqn1W+kRdZLASgDaniNuRQEkaRjn3lxnBXPTYHnTzfS6DkbsjCG
	 V+mVfltAm9um1+50uspT5ySLqkBzNB6hRuIKqRHwDfiC/flIZDXu4ATME8xeZl3Opd
	 HXkt7/SmBwWMms4sfsS7yOl+iz/FWSNR0pwPPckY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NLiHXO006335
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Aug 2023 16:44:17 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 16:44:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 16:44:15 -0500
Received: from [128.247.81.144] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NLiFcP120003;
	Wed, 23 Aug 2023 16:44:15 -0500
Message-ID: <8d927140-8642-41a7-a18c-63d0e00e4170@ti.com>
Date: Wed, 23 Aug 2023 16:44:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [bitbake-devel] [PATCH] bitbake-worker:
 export_proxies if network flag = 1
Content-Language: en-US, en-US-large
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Alexander Kanavin
	<alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>
References: <20230823210438.2172797-1-rs@ti.com>
 <CANNYZj9BH9i8z9XhHxX_bGSRkZBM+Bateb-i8jxqZXCFThGphg@mail.gmail.com>
 <b79ef56133cb5c2275560936527d822a32bd80a2.camel@linuxfoundation.org>
 <76f9f90f-5a76-426b-b425-5484655b21a9@ti.com>
 <151825c6950a24bd1614cdbbdb24c021ff664768.camel@linuxfoundation.org>
From: Randolph Sapp <rs@ti.com>
In-Reply-To: <151825c6950a24bd1614cdbbdb24c021ff664768.camel@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by lelv0142.ext.ti.com id 37NLiHEk085921
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 21:44:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14967

On 8/23/23 16:40, Richard Purdie wrote:
> On Wed, 2023-08-23 at 16:34 -0500, Randolph Sapp wrote:
>> On 8/23/23 16:25, Richard Purdie wrote:
>>> On Wed, 2023-08-23 at 23:20 +0200, Alexander Kanavin wrote:
>>>> Something doesn=E2=80=99t compute here. How did it work all this tim=
e in
>>>> tasks like fetch?
>>>
>>> Before we had network isolation, we did ensure we only set the networ=
k
>>> proxy information before network access code. This meant the things
>>> would break for "unknown" network access outside of the points in the
>>> code where we expected it on systems that used a proxy.
>>>
>>> I've mixed feelings on "simplifying" things like this as we'd lose th=
at
>>> markup of the code and a second level of checking, even if that check
>>> does need a proxy setup.
>>>
>>> Was there a specific place where the proxy information was needed but
>>> not present?
>>
>> Rust, Go, Flutter, Matter, and all of the other new frameworks and
>> languages that decided to be special and make their own build systems
>> that reach out during the do_compile phase.
>>
>> Though, it could be argued that this is just a cover-up for the real
>> issue, which is lack of proper integration of these build systems into
>> bitbake. I still believe this is useful for compilations behind a
>> corporate proxy for those few recipes still *cheating*.
>=20
> Do we really want to make it easier for people to ignore that set of
> problems? :/

I suppose not. Though it is a little rough to add a fetcher and class=20
for every one-off build system that Google introduces for their shinny=20
new product :P

Feel free to drop this patch. Just figured I would test the waters.

