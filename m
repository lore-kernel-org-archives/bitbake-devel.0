Return-Path: <louis.rannou@syslinbit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7910BC021A0
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 17:02:08 +0000 (UTC)
Received: from 13.mo550.mail-out.ovh.net (13.mo550.mail-out.ovh.net [178.33.253.128])
 by mx.groups.io with SMTP id smtpd.web10.21273.1739379722543696081
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 09:02:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=VNEtq57B;
 spf=softfail (domain: syslinbit.com, ip: 178.33.253.128, mailfrom: louis.rannou@syslinbit.com)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.17.245])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4YtPk05ZFCz1R8W
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 17:02:00 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-4grr2 (unknown [10.110.164.243])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id F35711FD3D;
	Wed, 12 Feb 2025 17:01:59 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.103])
	by ghost-submission-5b5ff79f4f-4grr2 with ESMTPSA
	id jA7kMwfUrGdEKwUAiaPQ3A
	(envelope-from <louis.rannou@syslinbit.com>); Wed, 12 Feb 2025 17:01:59 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-103G00564706cb8-f017-4f56-b36f-83fc7dab2c21,
                    74B36F6499D71BB1255966C6406869B815799905) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
Message-ID: <2e44bc41-77e8-4c8f-bf2d-bcec9dcda49d@syslinbit.com>
Date: Wed, 12 Feb 2025 18:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: data_smart: fix ??= operator
 for getVarFlags
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: louis.rannou@non.se.com, pascal.eberhard@se.com, yoann.congal@smile.fr
References: <20250212-varflags-v1-0-3a756c7aa95c@syslinbit.com>
 <20250212-varflags-v1-1-3a756c7aa95c@syslinbit.com>
 <1f5455e336cd35e8ffadcad1abd1b0daf782764e.camel@linuxfoundation.org>
Content-Language: en-US
From: Louis Rannou <louis.rannou@syslinbit.com>
In-Reply-To: <1f5455e336cd35e8ffadcad1abd1b0daf782764e.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Ovh-Tracer-Id: 15278461736453070260
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepnfhouhhishcutfgrnhhnohhuuceolhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmqeenucggtffrrghtthgvrhhnpeevhefffeehkeehveekvdefhedvjefhgeeuheehuedviedviedtieegtdejteekvdenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgnecukfhppeduvdejrddtrddtrddupdeghedrkedurdeivddrledpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheplhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdfovfetjfhoshhtpehmohehhedtmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=jPxA6pvWofEW0DuVGemTVmz82dyijUcnXn9SM7hHGcY=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1739379720; v=1;
 b=VNEtq57BrPKwfMhERNK8mVJcQ6VkkXIaOkCDeHQ7ZH5lyMSLPnnR3hZtXHf/CUUCQ1v4Fyr9
 lbMEYdS2TwVXFqhuyUvT3iqdtDb7Ka7T0Ewrq6FurMxcHY0e2NU1LVLcxtIks+ZWLUVjv6SyL3U
 4+0fjiy/38Qs6t17yzbNrFhWeggIsA6GBleLB+yb4/RoPptZYaUbFuBtNJcIWfi1x55upXyTfxR
 gYY2ECXB9sX+AR2HLDfYzvIH9R88atxGWfXxSD4/QxO6amU0QnIvKxU29Z/iNQhsKkHwOhqgCwZ
 pRy0DBy7AEKHExGgQEYT+g4ue/av909w0j/tl8K9bUTNA==
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 17:02:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17208

Hello,

Ok for the solution which is indeed prettier. I'll add a test with=20
internalflags.

I also agree the test is not exactly at the right place as it does not=20
test parsing but the result of getVarFlags. Perhaps it would fit better=20
in tests/data.py ? (if that's ok to make a call to bb.parse there)

Thanks,
Louis

On 12/02/2025 15:13, Richard Purdie wrote:
> On Wed, 2025-02-12 at 13:16 +0100, Louis Rannou via lists.openembedded.=
org wrote:
>> From: Louis Rannou <louis.rannou@non.se.com>
>>
>> Variable flags have been fixed in commit
>> 0329a7e3ac694737f2d2c1861f65492551360663 which introduces the
>> "_defaultval_flag_" prefix for default values. This must not be ignore=
d as
>> others "_"-prefixed flags names.
>>
>> Split the processing of default values to be sure they are overwritted=
 by the
>> others operators disregarding of their order.
>>
>> Fixes [YOCTO #15685]
>>
>> Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
>> ---
>>  =C2=A0lib/bb/data_smart.py | 16 +++++++++++++---
>>  =C2=A01 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>> index 897ceeb32c7ce0acb8ed44c25e1bf2f2f28aa9dc..7663f28c5071a77c8452c1=
016e5ee0d969c84bec 100644
>> --- a/lib/bb/data_smart.py
>> +++ b/lib/bb/data_smart.py
>> @@ -952,12 +952,22 @@ class DataSmart(MutableMapping):
>>  =C2=A0=C2=A0=C2=A0=C2=A0 def getVarFlags(self, var, expand =3D False,=
 internalflags=3DFalse):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_var =3D self._=
findVar(var)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D {}
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags_set =3D {}
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if local_var:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
r i in local_var:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if i.startswith(("_", ":")) and not internalflags:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
r i, val in local_var.items():
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if i.startswith("_defaultval_flag_"):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i =3D i[len("_defaultval_fl=
ag_"):]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags[i] =3D val
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 elif i.startswith(("_", ":")) and not internalflags=
:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 flags[i] =3D local_var[i]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags_set[i] =3D val
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # =
Flags sets take over defaults
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fl=
ags.update(flags_set)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
r i in flags:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if expand and i in expand:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags[i] =3D self.exp=
and(flags[i], var + "[" + i + "]")
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(flags) =3D=3D=
 0:
>=20
> I did spend more time looking at this and I had misunderstood the
> problem. I think this can still be simplified though and I also suspect
> the internalflags handling above isn't correct. If internalflags is
> set, I think it probably should return _defaultval_flag_ values
> unchanged. The code would therefore look more like:
>=20
>=20
> for i, val in local_var.items():
>      if i.startswith("_defaultval_flag_") and not internalflags:
>          i =3D i[len("_defaultval_flag_"):]
>          if i not in local_var:
>              flags[i] =3D val
>      elif i.startswith(("_", ":")) and not internalflags:
>          continue
>      else:
>          flags_set[i] =3D val
>=20
> I'd also add a comment to the test case explaining that we're testing
> weak default make it to the getVarFlags output.
>=20
> Cheers,
>=20
> Richard


