Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABED6C433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 09:40:36 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web08.26223.1658742031205200975
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 02:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de
 header.s=phobos-20191101 header.b=bEIi5pib;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 51E56840AD;
	Mon, 25 Jul 2022 11:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1658742027;
	bh=aCie2lzRHzA4P682yUYa0WpZJbHoPmorlcMozlR2Ebo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bEIi5pibZ7Er+YNDFXpledTOoZ3yd8a7IgY2NmDsc/VKBFwterNSK+V3A77ZpO6/0
	 XCpHjoPyEt4gnb+ICoXW/Vhk8RsoDwcF1GRkA13saSlQct7FFa+VMEfWIu26ru8hfL
	 md980lf5TXEMEa5dsKz0dKVf/D7fOCNO/y6/iFu78guROKCZzTesvHQ+srY8cK4hbE
	 Igd2F/DcI253JljRLONZbLb7VCXGsof2KieiB1PV0tH89n2j+qJBKmp3xgbYV606K9
	 C7t1eyAYhFU2amPWoYndJE3ml0Eqkw36tFAS9Z6SSQRVws0/4z/SbldDH23F1BhmTo
	 nyPwiVKGVJLWA==
Message-ID: <7349096f-f252-51d2-e12e-f9f21606892b@denx.de>
Date: Mon, 25 Jul 2022 11:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: Document override
 :append, :prepend, :remove order
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20220723011305.311655-1-marex@denx.de>
 <3839828d-f538-a865-8e87-64ce8d04ac21@theobroma-systems.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <3839828d-f538-a865-8e87-64ce8d04ac21@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 09:40:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13840

On 7/25/22 10:36, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 7/23/22 03:13, Marek Vasut wrote:
>> The application order of override syntax :append, :prepend, :remove is
>> inobvious and undocumented. The order does not match variable parse
>> history, i.e. output of "bitbake -e", either.
>>
>> Add note documenting the exact order in which :append, :prepend, :remo=
ve
>> are applied to variable in lib/bb/data_smart.py getVarFlag(). Add note
>> that this order does not match the variable parse history order. This
>> is mostly to prevent others from running into this and scratching thei=
r
>> heads, trying to find out what is going on.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
>> ---
>> =C2=A0 .../bitbake-user-manual-metadata.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
2 ++++++++++++
>> =C2=A0 1 file changed, 12 insertions(+)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst=20
>> b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> index 33782161..651116ce 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> @@ -351,6 +351,18 @@ The variable ``FOO`` becomes
>> =C2=A0 Like ":append" and ":prepend", ":remove" is applied at variable
>> =C2=A0 expansion time.
>> +.. note::
>> +
>> +=C2=A0=C2=A0 The overrides are applied in this order, ":append", ":pr=
epend",=20
>> ":remove".
>> +=C2=A0=C2=A0 This implies it is not possible to re-append previously =
removed=20
>> strings.
>> +
>> +.. note::
>> +
>> +=C2=A0=C2=A0 Override application order may not match variable parse =
history, i.e.
>> +=C2=A0=C2=A0 the output of ``bitbake -e`` may contain ":remove" befor=
e ":append",
>> +=C2=A0=C2=A0 but the result will be removed string, because ":remove"=
 is handled
>> +=C2=A0=C2=A0 last.
>> +
>=20
> I can suggest a more concise note, since I don't think we care about th=
e=20
> actual order of append and prepend:
> ```
> ``:remove`` is final. Any string appearing in ``:remove`` cannot be=20
> added back regardless of when ``:remove`` was parsed.
> ```
> Up to you :)

I'd argue it's better to keep the information full and complete, esp.=20
since its not easy to find within bitbake sources.


> Otherwise, welcome addition thanks :)
> Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>
>=20
> I'm surprised this was not mentioned in=20
> https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-=
manual-metadata.html#removal-override-style-syntax=20
> and=20
> https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-=
manual-metadata.html#appending-and-prepending-override-style-syntax,=20
> so adding a few words there would be great too :)

For appending and prepending, this makes little difference. It's the=20
remove which has this nasty catch.

