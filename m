Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71BFEDE9B0
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 19:57:48 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by mx.groups.io with SMTP id smtpd.web10.5710.1725998265353081740
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Sep 2024 12:57:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=ti-com-17Q1 header.b=BSZUUdS/;
 spf=pass (domain: ti.com, ip: 198.47.19.142, mailfrom: reatmon@ti.com)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48AJvWQT001681;
	Tue, 10 Sep 2024 14:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725998252;
	bh=qIm1W0WahTBZTjU8Yk+8HxI6RJ1vXXEEmA0+W1Vfpn8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BSZUUdS/y+urlnqxMfmGs+I6GK0LP6c/gvLAOSkCfSC8ORR7zLOJFNPEaT97SA8a7
	 8pNz5ytb0qITqgHar/871upi04Kox5+hR4Jv2KJvzAj7dxWUd+9TNIinXnpzEkmln8
	 BPaYLFJUxTDyqny9uWW2ii7Gzm5BWV4V9CXPSe2s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48AJvWbT008552
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Sep 2024 14:57:32 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 14:57:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 14:57:32 -0500
Received: from [10.249.34.164] ([10.249.34.164])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48AJvWSM026782;
	Tue, 10 Sep 2024 14:57:32 -0500
Message-ID: <2b656c4f-0f8f-4144-9ae6-b3f18b8143de@ti.com>
Date: Tue, 10 Sep 2024 14:57:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: add the proof of
 concept implementation
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>, <yocto@lists.yoctoproject.org>,
        <openembedded-architecture@lists.openembedded.org>,
        Alexander Kanavin
	<alex@linutronix.de>
References: <20240502105745.3073153-1-alex.kanavin@gmail.com>
 <8ddf5dac-2cb8-4c6a-b4e9-b8b281058cb1@ti.com>
 <CANNYZj8THxZ6y8sv3Y7A9br3zfh4GMpec4g4Y-+gMzGMJf5CAA@mail.gmail.com>
 <17F3EA3357E17FAE.2628@lists.openembedded.org>
Content-Language: en-US
From: Ryan Eatmon <reatmon@ti.com>
In-Reply-To: <17F3EA3357E17FAE.2628@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by fllv0016.ext.ti.com id 48AJvWQT001681
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Sep 2024 19:57:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16553



On 9/10/2024 10:02 AM, Ryan Eatmon via lists.openembedded.org wrote:
>=20
>=20
> On 9/9/2024 4:33 AM, Alexander Kanavin wrote:
>> On Thu, 5 Sept 2024 at 23:10, Ryan Eatmon <reatmon@ti.com> wrote:
>=20

>>> 7) I'm getting an error when running the setup-build script:
>>>
>>> =C2=A0=C2=A0=C2=A0 File "/scratch/builds/bitbake-setup-test/layers/se=
tup-build", line
>>> 107, in setup_build_env
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subprocess.run(cmd, shell=3DTrue, exec=
utable=3Dos.environ['SHELL'])
>>> =C2=A0=C2=A0=C2=A0 File "/usr/lib/python3.10/os.py", line 679, in __g=
etitem__
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise KeyError(key) from None
>>> KeyError: 'SHELL'
>>>
>>>
>>> SHELL is set to /bin/sh so I'm at a loss to see why this would be
>>> failing.=C2=A0 But because of this I never get a build.sh script.
>>
>> For this I would really appreciate if you can get to the bottom of.
>=20
> I'll take a look today and try to track it down.


Ok...  I run this:

yoctouser@uda0214219:/workdir$ echo $SHELL
/bin/sh

It *looks* like SHELL is set...  but:

yoctouser@uda0214219:/workdir$ env | grep SHELL
yoctouser@uda0214219:/workdir$

which means it is, in fact, not set.  Thus does not get passed through=20
to the bitbake-setup code to be read and processed.

So the issue is, why does my docker container not have it set?  No idea.


I can see in scripts/combo-layer that the command:

     shell =3D os.environ.get('SHELL', 'bash')

passes a default if SHELL is not set.  I'll send a patch for this in the=20
scripts/oe-setup-build as well.  But there is a line in this patch for=20
bitbake-setup that also needs to be tweaked if you send out another versi=
on.

Might be worth changing it from:

     shell =3D os.environ["SHELL"]
     with open(build_script,'w') as f:
         f.write("#!{}\n. {} && {}\n".format(shell, init_script, targets)=
)


To:

     shell =3D os.environ.get("SHELL","bash")
     with open(build_script,'w') as f:
         f.write("#!/usr/bin/env {}\n. {} && {}\n".format(shell,=20
init_script, targets))

Note the change to using /usr/bin/env in case the shell variable just=20
gets set to "bash".

>=20
>> Thanks,
>> Alex
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16550): https://lists.openembedded.org/g/bitbake-de=
vel/message/16550
> Mute This Topic: https://lists.openembedded.org/mt/105860308/6551054
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [reat=
mon@ti.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

--=20
Ryan Eatmon                reatmon@ti.com
-----------------------------------------
Texas Instruments, Inc.  -  LCPD  -  MGTS

