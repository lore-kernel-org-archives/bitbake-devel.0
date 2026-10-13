Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4522ECC6B08
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 14:06:06 +0000 (UTC)
Received: from prod-mta-13-02.swg-srv.net (prod-mta-13-02.swg-srv.net [185.255.28.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8066.1791900361223923718
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2026 07:06:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=ciMaJeC+;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.35, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a1359595720008425@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=4BLdIf6slA05W9F9F/y3SEUin0yYVo8IijaLINJo1dQ=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=ciMaJeC+ae0hL138yBILbJPTXxhx/eJt9fCy7lvbQj3MSebpGh7ifJzjyuow7M8r11adj5caX
 3l72AcLYc71MR92+SE0zgjyU7jRnLVRXblAthJxBMW2qVXAnVayNrEgiGCXuy/GRtkQ12wrYK+W
 cDk0EnXe2ULao2LYViZzkfYfwR0Au9Hy45S23sJpB/wgl3ARkyE7fz4iNus+slrV/vQEVtDfmtg
 2PJJ0DDegF6GDXOyei6x/zM3NSTdK4lVHNJjSDwcbXo5T4WsKx1K3SedGAhwPMEO5KmezErk3is
 mBBWcZh3wWNuY2YHOlW6EMuIYr81GFk/DPZiuQrGJlYg==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13-02.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a1359595720008425.003
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 13 Oct 2026 14:05:58 +0000
X-Zone-Loop: f6bf24f5dc9c5aeb9cc788482d4c837240fb0ea5f8b0
x-campaign-type: default
x-transaction-id: 7a270068-5ac3-40c9-89b7-99c7ab0fab40
x-swg-uid: 01-f8dbc6a5-f76b-4e70-9012-9b6b265063a6
X-Mailer: Sweego
Message-ID: 
 <1791900358.8631fc262581453bbf619ec5b2062170.1a1359595720008425@vates.tech>
x-swg-bid: 1791900358.8631fc262581453bbf619ec5b2062170.1a1359595720008425
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from [10.137.0.41] (ip-185-175-148-127.naitways.net [185.175.148.127])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id 6953082A40;
	Tue, 13 Oct 2026 16:05:57 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc: document dependency tracking
 associated with addpylib
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech>
 <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
 <DM2W2QFSWNBT.2A6RT11K7VMT1@bootlin.com>
 <1791885365.8631fc262581453bbf619ec5b2062170.1a134b0cf0a0008425@vates.tech>
 <DM3P6R5ZRVPM.3PW3QYG9BZOEI@bootlin.com>
 <b709283077dfbd7b34bcca2ebb38c38edb8b94af.camel@linuxfoundation.org>
Content-Language: en-US
From: Yann Dirson <yann.dirson@vates.tech>
Organization: Vates
In-Reply-To: <b709283077dfbd7b34bcca2ebb38c38edb8b94af.camel@linuxfoundation.org>
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.171.22c456f22685f026.1a13595937a.7f52c6f7c21e0e1a=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791900357499
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 14:06:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20336

---=Part.171.22c456f22685f026.1a13595937a.7f52c6f7c21e0e1a=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/13/26 3:10 PM, Richard Purdie wrote:
> On Tue, 2026-10-13 at 14:09 +0200, Antonin Godard wrote:
>> On Tue Oct 13, 2026 at 11:56 AM CEST, Yann Dirson via lists=2Eopenembed=
ded=2Eorg wrote:
>>>
>>>
>>> On 10/12/26 3:20 PM, Antonin Godard wrote:
>>>> On Mon Oct 12, 2026 at 3:08 PM CEST, Antonin Godard via lists=2Eopene=
mbedded=2Eorg wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon Oct 12, 2026 at 10:25 AM CEST, Yann Dirson via lists=2Eopenem=
bedded=2Eorg wrote:
>>>>>> Reported-by: Claude Opus 5=2E5
>>>>>> Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
>>>>>> ---
>>>>>>  =C2=A0 doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst =
| 8 ++++++++
>>>>>>  =C2=A0 1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata=
=2Erst b/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
>>>>>> index 621aab253=2E=2Eeef1f9624 100644
>>>>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
>>>>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata=2Erst
>>>>>> @@ -2264,6 +2264,14 @@ The specified <namespace> is imported automa=
tically, and if the imported
>>>>>>  =C2=A0 module specifies an attribute named ``BBIMPORTS``, that lis=
t of
>>>>>>  =C2=A0 sub-modules is iterated and imported too=2E
>>>>>>   =20
>>>>>> +Additionally, Bitbake will detect usage of functions from such a
>>>>>> +library and include them in task hashes, so changes in those funct=
ions
>>>>>> +trigger task rebuilds=2E=C2=A0 Note that only functions inside mod=
ules
>>>>>> +declared using ``BBIMPORTS`` benefit from this dependency tracking=
,
>>>>>> +any name defined directly in the specified namespace (e=2Eg=2E in
>>>>>> +`<namespace>/__init__=2Epy`, or in a library hat would be defined =
as
>>>>>
>>>>> s/hat/that/
>>>>>
>>>>>> +`<namespace>=2Epy`) would *not* benefit from this tracking=2E
>>>>>
>>>>> Otherwise, this is clear to me=2E I did not know about this limitati=
on/feature,
>>>>> and this is definitely important to document, thanks!
>>>>
>>>> Reading the code[1], it seems that functions prefixed with _ are not =
included
>>>> in the task checksums - if I understood correctly=2E I think it would=
 be also
>>>> important to mention that=2E Could you add it in a v2?
>>>
>>> It could be asked why we would want to exclude them=2E=C2=A0 Usually t=
hat would
>>> be internal functions, to be called by the exported ones, so they woul=
d
>>> equally matter - but then they are actually not included in the task
>>> hash, so it rather looks like a bug rather than something to document?
>>
>> You're right, it seems strange to exclude them entirely=2E You may want=
 to send a
>> patch to remove this then? At least it will kick-off the discussion on =
this
>> list=2E
>=20
> I suspect there are two levels of issues here=2E Funcitons with a single
> "_" prefix are internal functions and those were the ones we likely
> wanted to exclude=2E __init__ is probably an oversight=2E I do think peo=
ple
> are getting too focused on the detail of the taskhashes though=2E There
> comes a point in our code when something becomes API rather than "data"
> and the taskhashes really are meant to reflect more data than absolute
> every detail=2E Before function library hashing that boundary was cleare=
r
> but it still exists (e=2Eg=2E bitbake itself isn't hashed, nor should it
> be, nor the host system python version)=2E

OK, there has to be a boundary=2E  We likely want to describe it more=20
precisely - but where to do that is not obvious, the information is a=20
bit spread out in the docs, even more with where I inserted this=20
paragraph=2E  Maybe it should be moved to another place, with just an xref=
=20
here?  Or would it be better to keep the behavior description here, and=20
xref all such details from a central place about hashing?

About this particular question, do you have an opinion whether internal=20
functions should be included in the task hash, or if we should continue=20
to leave them out and document it?  I'd think intuitively the impact=20
would mostly be a bit more CPU cycles used, and some hashes invalidated=20
for people with such functions (who are likely not aware of those=20
functions not being hashed today)=2E



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.171.22c456f22685f026.1a13595937a.7f52c6f7c21e0e1a=---

