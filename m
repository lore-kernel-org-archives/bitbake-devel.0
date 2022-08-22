Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF2C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 16:39:26 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web12.20349.1661186358684718503
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 09:39:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de
 header.s=phobos-20191101 header.b=jMrzBYQV;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 17EE4844AC;
	Mon, 22 Aug 2022 18:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1661186355;
	bh=g8pFLexOefKuwhNOHwXpoA70ouIVwVJNUMme3814ugI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jMrzBYQV2pa+xJUKm1SpQjXK2U5j+Fo+yZMDsi65cfM8SAHsuUk4a0jbfSbRJynzO
	 Fapi0nUI180WcxEM8UkHtageDENE1vlSsG5QZA1c4LA5Px1nS9OjDQkHKqrlB2RVH8
	 Mv5SCURroZ1/sX7x1xovZwiBljakPltwS21zIQ3u74XwcQ7zsglOlynREzOw+5uJaQ
	 5jz/DGL0K5A9lWKO5KFzHyQzPkiOCNpyX6bC/1o6DB9jAFSBO/HbK65YGMGwWMiYlM
	 dTQHPOxbVzHsAJ5DxPv5ThE2oSZAXROhzsHfGAKq2GqxasV2GYSho1q/BLqRK9sgDP
	 FXPr7YBvb3n5w==
Message-ID: <3bd32832-e3fa-deaa-bf42-07b2d0534552@denx.de>
Date: Mon, 22 Aug 2022 18:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Content-Language: en-US
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
From: Marek Vasut <marex@denx.de>
In-Reply-To: <a96c3947126b49089b0f91e050dd0d3f@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 16:39:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13927

On 8/22/22 17:21, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>> Sent: den 22 augusti 2022 16:17
>> To: Marek Vasut <marex@denx.de>; Quentin Schulz <quentin.schulz@theobr=
oma-
>> systems.com>; Alexander Kanavin <alex.kanavin@gmail.com>
>> Cc: Mikko Rapeli <Mikko.Rapeli@bmw.de>; Martin Jansa
>> <Martin.Jansa@gmail.com>; bitbake-devel <bitbake-
>> devel@lists.openembedded.org>; Peter Kjellerstedt
>> <peter.kjellerstedt@axis.com>
>> Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fet=
cher
>> from fetching gitlab repository metadata
>>
>> On Mon, 2022-08-22 at 13:55 +0200, Marek Vasut wrote:
>>> On 8/22/22 12:57, Quentin Schulz wrote:
>>>> Hi Marek,
>>>>
>>>> On 8/22/22 12:35, Marek Vasut wrote:
>>>>> On 8/22/22 10:41, Alexander Kanavin wrote:
>>>>>> On Mon, 22 Aug 2022 at 10:37, Marek Vasut <marex@denx.de> wrote:
>>>>>>
>>>>>>>> So maybe the easy way out is, if nobranch=3D1 then fetch
>> everything,
>>>>>>>> else
>>>>>>>> just heads and tags ?
>>>>>>>
>>>>>>> No, this won't do, nobranch expects the commit to be in a tag.
>>>>>>
>>>>>> I don't think it expects that.
>>>>>
>>>>> Documentation says it does:
>>>>>
>>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
>> 3A__git.openembedded.org_bitbake_tree_lib_bb_fetch2_git.py-
>> 23n45&d=3DDwICaQ&c=3D_sEr5x9kUWhuk4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5y=
mA1XTSqHGq
>> 8yBP6m6qZZ4njZguQhZhkI_-
>> 172IIy1t&m=3DuZNWVMGEowy_ntO8q5fjINXu3LIe9haqbSTYjwWiqO6Q5sEPsUIx5nw28=
YTBw6o
>> I&s=3D_AJ3mkGnnM8peSNP8k6MePZ0RtEkQLo7yS1Cll2yjmc&e=3D "
>>>>> - nobranch
>>>>>  =C2=A0=C2=A0=C2=A0 Don't check the SHA validation for branch. set =
this option for
>> the
>>>>> recipe
>>>>>  =C2=A0=C2=A0=C2=A0 referring to commit which is valid in tag inste=
ad of branch.
>>>>
>>>> I assume this was meant to give the example of tags which aren't
>>>> necessarily in a branch (annotated tags or tags of commits not belon=
g
>> to
>>>> any branch anymore (force-push for example, or branch deletion).
>>>>
>>>> The git fetcher does a git log --pretty=3Doneline -n 1 <hash> when
>>>> nobranch is set, otherwise git branch --contains <hash> --list
>> <branch>
>>>> to check whether a commit exists and can be used by bitbake.
>>>>
>>>> Considering this check, I assume nobranch=3D1 is working for any com=
mit
>>>> that was fetched by the git fetcher?
>>>>
>>>> (We need to update the docs to reflect that in that case).
>>>
>>> In that case, 'git fetch refs/*' in case nobranch is set and 'refs/he=
ad
>>> refs/tags' otherwise ?
>>
>> This does get a bit more complex though since you now need two
>> different mirror tarballs, one for each option. The code can do that i=
f
>> setup correctly but we do need to cover that issue.
>>
>> Cheers,
>>
>> Richard
>=20
> I made some testing, and for Gerrit to continue to work it would be
> enough to use:
>=20
>              fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/hea=
ds/*:refs/heads/* refs/tags/*:refs/tags/* refs/changes/*:refs/changes/*" =
% (ud.basecmd, shlex.quote(repourl))
>=20
> This should not affect other Git servers and should avoid using
> different fetch commands depending on the URL. The drawback is of
> course that for Gerrit, there would be only marginal benefits to
> this change since the majority of its metadata is in the
> refs/changes space.
>=20
> However, I wonder if the suggested change actually has any significant
> effect, given that the initial clone is done using --mirror, which mean=
s
> all refs/ spaces are fetched. If I remove the --mirror option from the
> clone command the change works as expected, but I have no idea if that
> has any other significant impact...

With this change, I am able to actually fetch mesa from=20
gitlab.freedesktop.org without local CI proxy terminating the connection=20
in the process. So yes, it does have effect.

