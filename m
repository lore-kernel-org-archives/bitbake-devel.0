Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB584C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 11:56:04 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web08.17216.1661169356241911778
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 04:55:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de
 header.s=phobos-20191101 header.b=baxFgKJH;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AB2C984189;
	Mon, 22 Aug 2022 13:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1661169353;
	bh=JaNmel+l2W0rye8fz2aAYW39RfKlSiApBvlLKdOudLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=baxFgKJHkXHUqRRICOPgU1URDC5IMewTAnjZvz5NAUsLPXQJ3JWiqBSta3fFbu7mp
	 FRFq+8vd9+HMYQv2YvfmEvlN6wfZW6DewkjbGcnIqSP1AdQjD/Kl6io8SqWDDXFaTY
	 nx8sR2BO20OjjS/VADCOAm1+fXrKbK/cK8MA+zTSCwJCqG9PcpabHIed8CJtZMpAXi
	 Rpig4d+xO/uPiqEfDdUHs8ecA3Hf1HGjRbBfPN8GmYd5cs7rqqi4NNnzUqLcWNTJhU
	 nwAVWzMivwxyasB5tQNWZePYuhC2tWcQfkj0KB6aiep3SJzLgJaL1FRGlJGWMhXQQx
	 NmnWYzTk56wBg==
Message-ID: <fbf40e09-ff85-42c0-54d0-0bb8fc833e58@denx.de>
Date: Mon, 22 Aug 2022 13:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Mikko Rapeli <Mikko.Rapeli@bmw.de>, Martin Jansa
 <Martin.Jansa@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
 <CANNYZj_LPwamXHBTj=g8_+ZGaL2WF+s0EOcGKf5VJYfxUyOq6g@mail.gmail.com>
 <438756a1-efb1-cd7e-2c80-af60f8b2fcdc@denx.de>
 <0761a8c9-78b4-0794-6bc3-14afd248ac16@theobroma-systems.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <0761a8c9-78b4-0794-6bc3-14afd248ac16@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 11:56:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13921

On 8/22/22 12:57, Quentin Schulz wrote:
> Hi Marek,
>=20
> On 8/22/22 12:35, Marek Vasut wrote:
>> On 8/22/22 10:41, Alexander Kanavin wrote:
>>> On Mon, 22 Aug 2022 at 10:37, Marek Vasut <marex@denx.de> wrote:
>>>
>>>>> So maybe the easy way out is, if nobranch=3D1 then fetch everything=
,=20
>>>>> else
>>>>> just heads and tags ?
>>>>
>>>> No, this won't do, nobranch expects the commit to be in a tag.
>>>
>>> I don't think it expects that.
>>
>> Documentation says it does:
>>
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.openembedde=
d.org_bitbake_tree_lib_bb_fetch2_git.py-23n45&d=3DDwICaQ&c=3D_sEr5x9kUWhu=
k4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-17=
2IIy1t&m=3DuZNWVMGEowy_ntO8q5fjINXu3LIe9haqbSTYjwWiqO6Q5sEPsUIx5nw28YTBw6=
oI&s=3D_AJ3mkGnnM8peSNP8k6MePZ0RtEkQLo7yS1Cll2yjmc&e=3D "
>> - nobranch
>> =C2=A0=C2=A0=C2=A0 Don't check the SHA validation for branch. set this=
 option for the=20
>> recipe
>> =C2=A0=C2=A0=C2=A0 referring to commit which is valid in tag instead o=
f branch.
>=20
> I assume this was meant to give the example of tags which aren't=20
> necessarily in a branch (annotated tags or tags of commits not belong t=
o=20
> any branch anymore (force-push for example, or branch deletion).
>=20
> The git fetcher does a git log --pretty=3Doneline -n 1 <hash> when=20
> nobranch is set, otherwise git branch --contains <hash> --list <branch>=
=20
> to check whether a commit exists and can be used by bitbake.
>=20
> Considering this check, I assume nobranch=3D1 is working for any commit=
=20
> that was fetched by the git fetcher?
>=20
> (We need to update the docs to reflect that in that case).

In that case, 'git fetch refs/*' in case nobranch is set and 'refs/head=20
refs/tags' otherwise ?

