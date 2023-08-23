Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B94DC3DA6F
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 21:38:59 +0000 (UTC)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by mx.groups.io with SMTP id smtpd.web10.507.1692826735115677402
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Aug 2023 14:38:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=ti-com-17Q1 header.b=Gx+erDvM;
 spf=pass (domain: ti.com, ip: 198.47.19.141, mailfrom: rs@ti.com)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NLcr2G117159;
	Wed, 23 Aug 2023 16:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692826733;
	bh=gC5bsnGK8G1XYlh4m4a+PPhyEPjlonmFaX7thW63IJc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Gx+erDvM9KmDDqYxlp8NqxJsvPfBCXrEJe+2ziJIaeggZCwFs0tf959a+GuyZYr5X
	 gZKwOzifGGis4g5Mp5JPiLieq9RGxX+PvRACZIWK/u8yhobvFJEylsl0lIHOS1oPCH
	 /wi2xmBTXS/SqJIcDLRhaXTkloDbDGB5jGltKuTE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NLcr5v101611
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Aug 2023 16:38:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 16:38:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 16:38:53 -0500
Received: from [128.247.81.144] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NLcrdG116381;
	Wed, 23 Aug 2023 16:38:53 -0500
Message-ID: <bb78cd5e-8df9-49a4-be07-20a84f0b8ecd@ti.com>
Date: Wed, 23 Aug 2023 16:38:53 -0500
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
 <177E20AFE73C2B6B.11498@lists.openembedded.org>
From: Randolph Sapp <rs@ti.com>
In-Reply-To: <177E20AFE73C2B6B.11498@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by fllv0015.ext.ti.com id 37NLcr2G117159
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 21:38:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14964

On 8/23/23 16:34, Randolph Sapp via lists.openembedded.org wrote:
> On 8/23/23 16:25, Richard Purdie wrote:
>> On Wed, 2023-08-23 at 23:20 +0200, Alexander Kanavin wrote:
>>> Something doesn=E2=80=99t compute here. How did it work all this time=
 in
>>> tasks like fetch?
>>
>> Before we had network isolation, we did ensure we only set the network
>> proxy information before network access code. This meant the things
>> would break for "unknown" network access outside of the points in the
>> code where we expected it on systems that used a proxy.
>>
>> I've mixed feelings on "simplifying" things like this as we'd lose tha=
t
>> markup of the code and a second level of checking, even if that check
>> does need a proxy setup.
>>
>> Was there a specific place where the proxy information was needed but
>> not present?
>=20
> Rust, Go, Flutter, Matter, and all of the other new frameworks and=20
> languages that decided to be special and make their own build systems=20
> that reach out during the do_compile phase.
>=20
> Though, it could be argued that this is just a cover-up for the real=20
> issue, which is lack of proper integration of these build systems into=20
> bitbake. I still believe this is useful for compilations behind a=20
> corporate proxy for those few recipes still *cheating*.

Also, any custom tasks people add that have network dependencies. I just=20
think it's a little rough having to play whack-a-mole with task and=20
proxy oddities.

