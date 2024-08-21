Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CB0C52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 10:08:53 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.16579.1724234926204404047
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Aug 2024 03:08:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Y8Cd9HqW;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 80E4C9C59F2;
	Wed, 21 Aug 2024 06:08:45 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 7Xe4CVEoWkZp; Wed, 21 Aug 2024 06:08:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9AC2B9C5F20;
	Wed, 21 Aug 2024 06:08:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 9AC2B9C5F20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724234924; bh=N7Li36rbkutuCb84P5H9IAaSQKyZtXk1w2KEVhcxCqQ=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=Y8Cd9HqWzy2nV708XEUkNn/pXuMpSdAn7hjb/YqcszsnHa1R4KJ06tKUY6TtNE4uO
	 x6hVHlSwOzHsLWkSTmFViTmMauPMO/Pc1/IuppgG+1tJUpme4I8DEMSgsJy9lJPNpU
	 KMZj/UYoLWFPsBSzCV3S2uE9Zb34vzkGI+YQk92JkdJf/f9qJcBG0h4gFTDvJWOC64
	 yFolsu4v8thZsgrRHKIfQYcKIX+MeDJChIPE83PJnJK/v+HS+NejTpZ3aVv7ChiQuS
	 b1EovmBnUpNfH5Q1OtSvLGO6Tyz5SEpt9jDwYtGHr7OzPTWcf0790vsO7pAgnvXm/h
	 E2VD8i6C+wEEw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5FvUMGCCljS0; Wed, 21 Aug 2024 06:08:44 -0400 (EDT)
Received: from [192.168.216.123] (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E0E379C5C15;
	Wed, 21 Aug 2024 06:08:43 -0400 (EDT)
Message-ID: <028bd9ca-a8ca-4d8d-87a9-00d19232855b@savoirfairelinux.com>
Date: Wed, 21 Aug 2024 12:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [EXTERNAL] Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept
 unspecified versions in package.json
To: "Herbrechtsmeier, Stefan" <Stefan.Herbrechtsmeier@weidmueller.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Cc: "tanguy.raufflet@savoirfairelinux.com"
 <tanguy.raufflet@savoirfairelinux.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
References: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
 <c2136d36-fac4-401d-9220-0f227260ef2d@savoirfairelinux.com>
 <b89f6243322fc0e72ae6a9773c437ee598d773e4.camel@linuxfoundation.org>
 <AS4PR08MB8046E1B791A39B4751C4D732958E2@AS4PR08MB8046.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <AS4PR08MB8046E1B791A39B4751C4D732958E2@AS4PR08MB8046.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 10:08:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16505



On 21/08/2024 10:42, Herbrechtsmeier, Stefan wrote:
> Hi,
>=20
> I'm not that deep into the topic anymore, but I can hopefully explain s=
ome implementation details.
>=20
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Richard Purdie <richard.purdie@linuxfoundation.org>
>> Gesendet: Dienstag, 20. August 2024 18:00
>> An: Enguerrand de Ribaucourt <enguerrand.de-
>> ribaucourt@savoirfairelinux.com>; bitbake-devel@lists.openembedded.org
>> Cc: tanguy.raufflet@savoirfairelinux.com; alexandre.belloni@bootlin.co=
m;
>> Herbrechtsmeier, Stefan <Stefan.Herbrechtsmeier@weidmueller.com>
>> Betreff: [EXTERNAL] Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept
>> unspecified versions in package.json
>>
>> CAUTION: This email originated from outside the organization. Do not c=
lick
>> links or open attachments unless you recognize the sender and know the
>> content is safe.
>>
>>
>>
>> On Mon, 2024-08-19 at 09:58 +0200, Enguerrand de Ribaucourt wrote:
>>> On 15/08/2024 16:12, Richard Purdie wrote:
>>>> On Mon, 2024-08-12 at 14:25 +0200, Enguerrand de Ribaucourt wrote:
>>>>> Our current emulation mandates that the package.json contains a
>>>>> version field. Some packages may not provide it when they are not
>>>>> published to the registry. The actual `npm pack` would allow such
>>>>> packages, so should we.
>>>>>
>>>>> A first commit was required in the npm class.
>>>>>
>>>>> For the shrinkwrap part , we can actually use the resolved field
>>>>> which contains the exact source, including the revision, to pass
>>>>> integrity tests.
>>>>>
>>>>> v3:
>>>>>    - Split bitbake npmsw.py modification in another commit
>>>>>
>>>>> Co-authored-by: Tanguy Raufflet
>>>>> <tanguy.raufflet@savoirfairelinux.com>
>>>>> Signed-off-by: Tanguy Raufflet
>>>>> <tanguy.raufflet@savoirfairelinux.com>
>>>>> Signed-off-by: Enguerrand de Ribaucourt
>>>>> <enguerrand.de-ribaucourt@savoirfairelinux.com>
>>>>> ---
>>>>>    bitbake/lib/bb/fetch2/npmsw.py | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/bitbake/lib/bb/fetch2/npmsw.py
>>>>> b/bitbake/lib/bb/fetch2/npmsw.py index d8ed9df327..a5fa598deb
>>>>> 100644
>>>>> --- a/bitbake/lib/bb/fetch2/npmsw.py
>>>>> +++ b/bitbake/lib/bb/fetch2/npmsw.py
>>>>> @@ -97,7 +97,7 @@ class NpmShrinkWrap(FetchMethod):
>>>>>
>>>>>                integrity =3D params.get("integrity", None)
>>>>>                resolved =3D params.get("resolved", None)
>>>>> -            version =3D params.get("version", None)
>>>>> +            version =3D params.get("version", resolved)
>>>>>
>>>>>                # Handle registry sources
>>>>>                if is_semver(version) and integrity:
>>>>
>>>> I'm not convinced by this reasoning. The whole point of our SRC_URI
>>>> is to precisely define something that is being built. I think this
>>>> allows floating versions of dependencies and hence makes this non-
>>>> reproducible?
>>>
>>> The version declared in package.json is purely declarative for the NP=
M
>>> package registry. The basic Yocto fetchers will still be used for
>>> downloading the SRC_URI (https, git, ...), with the same version
>>> reproducibility mechanisms like git hash or md5sum.
>>>
>>> In the npm.bbclass, we have a second fetch stage (actually during
>>> do_configure) to fetch all the dependencies. The npm class here
>>> behaves wildly differently than regular frameworks where each
>>> dependency is a separate recipe. But since there are myriads of
>>> dependencies in the NPM world and it would be rare to share them, the
>>> current recipe class is intended to package an application with all
>>> its dependencies using the NPM registry.
>>>
>>> To fetch all those dependencies, we rely on the NPM dependencies
>>> mechanism of package.json which lists packages with their declarative
>>> version. However this is not reproducible. NPM provides two additiona=
l
>>> files that NPM developers should include in their repositories to pin
>>> the whole dependency tree: package-lock.json and npm-shrinkwrap.json.
>>> The npm recipetool will fetch the dependencies the first time with
>>> package.json information, and produce an npm-shrinkwrap.json file tha=
t
>>> pins all versions.
>>
>> Are you saying that the codepath in question is only used to generate =
the
>> npm-shrinkwrap.json file and that a normal do_fetch and a normal build=
 will
>> not fetch any floating version?
>=20
> The npm-shrinkwrap.json is generated by npm. In contrast to rust and go=
 the lock file isn't processed during recipe creation but during build. T=
his leads to the problem that the recipe author need to fix the npm-shrin=
kwrap.json.
>=20
> The npm-shrinkwrap.json is a common lock file and locks the download so=
urces. It contains the download source inside the `resolved` field [1]. I=
n case of git it contains the full git url with commit sha. This means th=
e fetch use an unspecified release version but not a floating version.
>=20
> [1] https://docs.npmjs.com/cli/v10/configuring-npm/package-lock-json#pa=
ckages
>=20
>=20
>> I appreciate the npm build itself might not be deterministic but the p=
oint of
>> our SRC_URI is to make it deterministic.
>>
>> I'm also worried that you implied fetching is happening during do_conf=
igure.
>> That should not be the case and if that is happening, it needs to be c=
hanged so
>> that all fetching happens during do_fetch.
>=20
> The npm command in do_configure fetches the packages from a local tempo=
rary repository. The local repository is filled by pre fetch packages. Th=
e packages are fetched during do_fetch. Therefore bitbake parses the npm-=
shrinkwrap.json during fetch and creates a list of fetch uris on-the-fly =
.
>=20
>=20
>>> Back to our commit, we do not change the aforementioned behavior, we
>>> only make it compatible with packages which do not declare a version
>>> in their package.json. The npmsw.py code wants to have a version to
>>> validate what's being downloaded, so we pass a dummy version. But the
>>> npm-shrinkwrap.json file, generated by npm native, still contains the
>>> reproducible metadata. Example here with a package that doesn't
>>> declare a version field: NPM still added integrity and resolved field=
s
>>> which will ensure reproducibility:
>>>
>>> ```
>>>       "node_modules/cockpit-repo": {
>>>         "name": "CockpitDevelopmentDependencies",
>>>         "resolved":
>>> "git+ssh://git@github.com/cockpit-
>> project/cockpit.git#d34cabacb8e5e1e028c7eea3d6e3b606d862b8ac",
>>>         "integrity":
>>> "sha512-
>> 4nBWhDtVLwF++ZPY/67QtpsXc9y/Jpa/jj1LW/gScSafDKoHmtg1BwAQ7sqpN/
>>> fdyi1xrkysM9hxLq3Q16ofaw=3D=3D",
>>> ```
>>>>
>>>> We should probably error if a version cannot be found and force the
>>>> user to add one?
>>> An NPM project can typically pull hundreds of dependencies with some
>>> not declaring a version, the user would need to submit patches to all
>>> of their upstreams to fix that which is challenging. Meanwhile, the
>>> real NPM tool is perfectly fine with accepting that, as illustrated
>>> above. I believe we should hence behave like the official NPM tool.
>>
>> I'm not asking for the upstream NPM projects to be locked down. I'm as=
king
>> that our recipes always have versions specified. This is similar to wh=
at we do in
>> other places like crates with carg under rust, which probably is the b=
est
>> example of how we can lock down situations like this.
>=20
> The rust solution has the advantage, that the lock is parsed during rec=
ipe creation and the recipe author can rework the result.
>=20
> But the real problem is that the project wasn't published to the regist=
ry and has no release. Both cargo and npm support git repositories withou=
t a version. Maybe the parser should set the version to `0-git<short git =
commit sha>` and extract the hash from the `resolved` field.
We do declare a dummy version in another patchset somewhere else indeed=20
to pass some checks and allow building such packages. However in this=20
specific place, the version field is what's used to fetch the packages=20
and it needs a URL (git://, ...) which is conveniently provided by the=20
`resolved` field!
>=20
> Regards
>    Stefan
>=20
> ________________________________
> Kommanditgesellschaft - Sitz: Detmold - Amtsgericht Lemgo HRA 2790 -
> Komplement=C3=A4rin: Weidm=C3=BCller Interface F=C3=BChrungsgesellschaf=
t mbH -
> Sitz: Detmold - Amtsgericht Lemgo HRB 3924;
> Gesch=C3=A4ftsf=C3=BChrer: Dr. Timo Berger, Volker Bibelhausen, Dr. Seb=
astian Durst, Andr=C3=A9 Sombecki;
> USt-ID-Nr. DE124599660

--=20
Savoir-faire Linux
Enguerrand de Ribaucourt

