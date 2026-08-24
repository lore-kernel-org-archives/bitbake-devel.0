Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A512C5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 13:40:27 +0000 (UTC)
Received: from prod-mta-13-02.swg-srv.net (prod-mta-13-02.swg-srv.net [185.255.28.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16833.1787578822130256771
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2026 06:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=guHopzDk;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.35, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a034001c5f000c4f3@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=8OHnZDsWrhsadY8MOpPRCAE07FUZ7PC44hyqMKv5otg=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=guHopzDkFbkIMr9V/76ksDoCUS5JSIz4DqNLVn/MyxOftVOslMkkOCkvAwSrzGzj9Ut0dxIr/
 ADQbMPpWfjD9HPLngVivjQSNc/O1Qsih+KVtG5SZPatKeVbhhRn0a4c37G3s3eDPymTQOe/+e7s
 LzEBFAPZ2+tVW6CnAjztWvJVtUdwcJ/5c0LdcGwvZsIl2bGdmkBVRMu9aZSPm56XriwB1Ki9GNP
 bJyOYO3Ak4fOUi5HK7qm/VONsrVyQkVY5BWjK1Q+xNO9NTprT4OYeqxGD/giGdTtaeb98pFZ9Xj
 8yQIFLTM+rrq6S//56J8D4VCilzrvThBwdMM2XQX8vXw==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-02.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a034001c5f000c4f3.002
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 24 Aug 2026 13:40:17 +0000
X-Zone-Loop: 86b5f8a7ed10b0ab6d7b278d3adc4efc92ae29d9f5b0
x-campaign-type: default
x-transaction-id: 319d5d48-dfe5-4bbf-828e-aa2900931bad
x-swg-uid: 01-2adc71ea-f454-4acc-ac85-1ec363130946
X-Mailer: Sweego
Message-ID: 
 <1787578817.8631fc262581453bbf619ec5b2062170.1a034001c5f000c4f3@vates.tech>
x-swg-bid: 1787578817.8631fc262581453bbf619ec5b2062170.1a034001c5f000c4f3
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from [10.137.0.41] (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id DD2FC81B40;
	Mon, 24 Aug 2026 15:40:16 +0200 (CEST)
Date: Mon, 24 Aug 2026 15:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc/bitbake-user-manual-ref-variables:
 document PREFERRED_RPROVIDER
To: Quentin Schulz <quentin.schulz@cherry.de>,
 bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <1787566358.8631fc262581453bbf619ec5b2062170.1a033420133000c4f3@vates.tech>
 <ac19f181-f193-4a84-8ec3-94a374c9ee56@cherry.de>
Content-Language: en-US
From: Yann Dirson <yann.dirson@vates.tech>
Organization: Vates
In-Reply-To: <ac19f181-f193-4a84-8ec3-94a374c9ee56@cherry.de>
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.2a1b.a9ae521c6ad4fa05.1a0340019d5.3f9832cdd34cd36d=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1787578816982
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 13:40:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20026

---=Part.2a1b.a9ae521c6ad4fa05.1a0340019d5.3f9832cdd34cd36d=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/24/26 12:26 PM, Quentin Schulz wrote:
> Hi Yann,
>=20
> On 8/24/26 12:12 PM, Yann Dirson via lists=2Eopenembedded=2Eorg wrote:
>> [You don't often get email from=20
>> yann=2Edirson=3Dvates=2Etech@lists=2Eopenembedded=2Eorg=2E Learn why th=
is is=20
>> important at https://aka=2Ems/LearnAboutSenderIdentification ]
>>
>> Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
>> ---
>> =C2=A0 =2E=2E=2E/bitbake-user-manual-ref-variables=2Erst=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 9 +++++++++
>> =C2=A0 1 file changed, 9 insertions(+)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-=20
>> variables=2Erst b/doc/bitbake-user-manual/bitbake-user-manual-ref-=20
>> variables=2Erst
>> index 5395ce5e3=2E=2E2756fc0c4 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=2Erst
>> @@ -1558,6 +1558,15 @@ overview of their function and contents=2E
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PREFERRED_=
PROVIDER_xxx =3D "yyy"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PREFERRED_=
PROVIDER_aaa =3D "bbb"
>>
>> +=C2=A0=C2=A0 :term:`PREFERRED_RPROVIDER` Determines which recipe shoul=
d be given
>=20
> Please be consistent with the rest of the=20
> file=2E :term:`PREFERRED_RPROVIDER` should be on its own on the first li=
ne=2E
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 preference when multiple packages rprov=
ide the same item=2E Beware
>=20
> rprovide is not an English term so all readers won't necessarily know=20
> what this means=2E I can suggest:
>=20
> """
> Determines which *recipe* generating a package runtime-providing=20
> (:term:`RPROVIDES`) the same item as other packages should be given=20
> preference=2E Some examples::
> [=2E=2E=2E]

Good points=2E

>=20
> """
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this should contain the name of the *re=
cipe* producing the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 package that rprovides the item, not th=
at of the package=2E Some
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 examples::
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PREFERRED_RPROVIDER_i=
nitd-functions ?=3D "initscripts"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PREFERRED_RPROVIDER_v=
irtual-libegl-icd ?=3D "mesa"
>=20
> Are you sure this is still valid? I don't see an RPROVIDES for virtual-=
=20
> libegl-icd so maybe this is not doing anything?

Those examples are literally taken from oe-core's=20
meta/conf/distro/include/default-providers=2Einc=2E  Digging a bit, they=
=20
seem to be dynamically-generated values from an anonymous python block=20
in =2E/meta/recipes-graphics/mesa/mesa=2Einc



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.2a1b.a9ae521c6ad4fa05.1a0340019d5.3f9832cdd34cd36d=---

