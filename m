Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19124C5B549
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 13:22:23 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.16340.1749043340810219575
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Jun 2025 06:22:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=aDaS5BX4;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06C034398F;
	Wed,  4 Jun 2025 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749043339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZxRHwf66DEd2qvGuoIkdfw74VGRZ4mzb26jvov7n0U=;
	b=aDaS5BX4acu37YYbvzwrzNRkEfyiKjJOkMQz+TSjMq1kkdGTthS/T3dxIZbSXiigQUVX0k
	zpTscNWgrOxWWqsqVEPR/Z+l/oR4QYHJDVx1LGNiWYtI5Qzf04dfyzcjBF6bMTcTTILBID
	u63SbkuDrCIcg/NFdKoAlaRgSY10gF2UuL8q2z5ERi7CL9WKsL1uq/GRSHPa0uCnnVM20T
	lARKeKgSGgmz6hayTw85RixN4lFczF7yuxiMWLhSKsWyS155Qt6jdQMCBbU7VfID5tiuoK
	JAXqLG6v7TcbPHE4pyvIv0R62FGF8TYSXX5tp9y4ARbLAEGs3xJ6PgZ3KmlYiw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Jun 2025 15:22:18 +0200
Message-Id: <DADS498BWPCJ.MOJL7B6014R7@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] doc: update releases.rst
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>,
 <bitbake-devel@lists.openembedded.org>
References: <20250528-walnascar-update-v1-1-9c6750e87e65@bootlin.com>
 <1951797c-49e0-418b-9907-fa94647f9b6d@cherry.de>
In-Reply-To: <1951797c-49e0-418b-9907-fa94647f9b6d@cherry.de>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvfhgjsehtqhertddttdejnecuhfhrohhmpedftehnthhonhhinhcuifhouggrrhgufdcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffekhedtfedvueevgeeffffhvdegveeguefggeduhffhfeekvdehkeefueejveelnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdduvddruddthedrudehtddrvdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvuddvrddutdehrdduhedtrddvhedvpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghrrhihrdguvgdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhin
 hdrtghomhdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 13:22:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17679

On Mon Jun 2, 2025 at 11:06 AM CEST, Quentin Schulz wrote:
> Hi Antonin,
>
> On 5/28/25 7:45 PM, Antonin Godard via lists.openembedded.org wrote:
>> Add Walnascar as a supported release manual, and move Styhead to the
>> outdated release manuals.
>>=20
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>>   doc/releases.rst | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/doc/releases.rst b/doc/releases.rst
>> index 3e8014074..676db66ec 100644
>> --- a/doc/releases.rst
>> +++ b/doc/releases.rst
>> @@ -4,11 +4,11 @@
>>   BitBake Supported Release Manuals
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  =20
>> -****************************
>> -Release Series 5.1 (styhead)
>> -****************************
>> +******************************
>> +Release Series 5.2 (walnascar)
>> +******************************
>>  =20
>> -- :yocto_docs:`BitBake 2.10 User Manual </bitbake/2.10/>`
>> +- :yocto_docs:`BitBake 2.12 User Manual </bitbake/2.12/>`
>>  =20
>>   *******************************
>>   Release Series 5.0 (scarthgap)
>> @@ -26,6 +26,12 @@ Release Series 4.0 (kirkstone)
>>   BitBake Outdated Release Manuals
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  =20
>> +****************************
>> +Release Series 5.1 (styhead)
>> +****************************
>> +
>> +- :yocto_docs:`BitBake 2.10 User Manual </bitbake/2.10/>`
>> +
>>   *******************************
>>   Release Series 4.3 (nanbield)
>>   *******************************
>>=20
>
> I believe this is handled by the set_versions.py script in yocto-docs?=20
> Should we have something similar in bitbake docs as well?

Actually no, this file is not covered by the script (see the website that i=
s
currently out-of-date). I started working on a set_versions.py for BitBake =
some
time ago, I'll keep that in mind and automatically generate this document h=
ere
as well.

> This seems like a decent idea considering that it also handles updating=
=20
> switchers.js and that last time we updated it was almost 5 years ago :)

And that is also something I've reworked but not finished yet!

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


