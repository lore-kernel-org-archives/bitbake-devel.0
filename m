Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595FDC3DA66
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 22:03:09 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by mx.groups.io with SMTP id smtpd.web10.1149.1692828179351827201
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Aug 2023 15:02:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=ti-com-17Q1 header.b=Jbu76tV8;
 spf=pass (domain: ti.com, ip: 198.47.19.142, mailfrom: rs@ti.com)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NM2vCY013925;
	Wed, 23 Aug 2023 17:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692828177;
	bh=nouRb2dJBaRxYxzxCr2EcPUTRlDgl+ngHySn6c0hjA0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Jbu76tV8b6I1SVqo3MFth67SgsnqC4oZ3P+3UNB/aNIcoPnQrahgkLr/ia6sse1T2
	 4B9xh8sUV1YWIOEHlkL3JIe/+K3X2DjT9yLM8XWvhEspy+r5E4ABoi47ziTwETriBy
	 NZ34wXpk0JLugt1sNxzZ1Z20T2ZF7ozwCYR8+cYs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NM2vsY075529
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Aug 2023 17:02:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 17:02:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 17:02:57 -0500
Received: from [128.247.81.144] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NM2uj6007997;
	Wed, 23 Aug 2023 17:02:57 -0500
Message-ID: <0a74ac84-2855-4f9d-8552-a4c4fe12261a@ti.com>
Date: Wed, 23 Aug 2023 17:02:56 -0500
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
X-MIME-Autoconverted: from 8bit to quoted-printable by fllv0016.ext.ti.com id 37NM2vCY013925
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 22:03:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14968

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
>=20
> People seem very very reluctant to try and fix any of these issues
> properly and with the kinds of regulations coming in, this is a serious
> issue whether people like it or not...

I would argue that as long as the 'network' flag exists people will just=20
continue to ignore the real issue.

The current proxy problem just makes it slightly more annoying for a=20
small percentage of the people currently circumventing the issue.

