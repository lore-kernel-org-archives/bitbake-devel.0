Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95C5ECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 17:50:48 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web08.15756.1662054646993076752
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Sep 2022 10:50:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de
 header.s=phobos-20191101 header.b=zNkZyroA;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 016B984047;
	Thu,  1 Sep 2022 19:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1662054644;
	bh=psKmfRklJjTKhRZCK5QJXRCOBxhQK2DWwWRDUrHDMT4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=zNkZyroAoZUGGRZxGjRdXEHAvZuPi/DTcQGydJyU9/OyfU3xRfn37kooWKD0sgF7A
	 rWY2mNki6nzXhzflshaZlJrzeVzHyx0qawhIy4Fs/Bt1a6ffQYtp2HcRl2IyJCxUfF
	 ofr3v/rhtY2WNAJ2bGIbkXeKO3+/TsgxV59HVFBdotgEwCIq5iipQ5jNQK9Ly0fS1k
	 hHPFa++lj14tR84gEHvO0G2uojhV+qrGoafiKxcPK9Rfr7qlgA3Kaw7/0E3syLMKT3
	 livwinBNa+Nn2HI8Xxk4tqv6GpkEX2Ql6xMpk0MXY4HaEGechKuTKv6+cq1S9doOxn
	 +FDTMoU1ihy3w==
Message-ID: <eee248e8-351e-be94-1096-c5483fb8f5e5@denx.de>
Date: Thu, 1 Sep 2022 19:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Mikko Rapeli <Mikko.Rapeli@bmw.de>, Martin Jansa
 <Martin.Jansa@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
 <CANNYZj_LPwamXHBTj=g8_+ZGaL2WF+s0EOcGKf5VJYfxUyOq6g@mail.gmail.com>
 <438756a1-efb1-cd7e-2c80-af60f8b2fcdc@denx.de>
 <0761a8c9-78b4-0794-6bc3-14afd248ac16@theobroma-systems.com>
 <fbf40e09-ff85-42c0-54d0-0bb8fc833e58@denx.de>
 <54100db12fc1f75f28ca1592d5debf1cf164f723.camel@linuxfoundation.org>
 <a96c3947126b49089b0f91e050dd0d3f@axis.com>
 <3bd32832-e3fa-deaa-bf42-07b2d0534552@denx.de>
In-Reply-To: <3bd32832-e3fa-deaa-bf42-07b2d0534552@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Sep 2022 17:50:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13951

On 8/22/22 18:39, Marek Vasut wrote:

Hi,

[...]

>> I made some testing, and for Gerrit to continue to work it would be
>> enough to use:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s=20
>> refs/heads/*:refs/heads/* refs/tags/*:refs/tags/*=20
>> refs/changes/*:refs/changes/*" % (ud.basecmd, shlex.quote(repourl))
>>
>> This should not affect other Git servers and should avoid using
>> different fetch commands depending on the URL. The drawback is of
>> course that for Gerrit, there would be only marginal benefits to
>> this change since the majority of its metadata is in the
>> refs/changes space.
>>
>> However, I wonder if the suggested change actually has any significant
>> effect, given that the initial clone is done using --mirror, which mea=
ns
>> all refs/ spaces are fetched. If I remove the --mirror option from the
>> clone command the change works as expected, but I have no idea if that
>> has any other significant impact...
>=20
> With this change, I am able to actually fetch mesa from=20
> gitlab.freedesktop.org without local CI proxy terminating the connectio=
n=20
> in the process. So yes, it does have effect.

I keep running into this problem with mesa, how can we proceed to fix it=20
upstream ?

