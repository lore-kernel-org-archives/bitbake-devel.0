Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148E2C52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 10:06:43 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.16406.1724234796244166878
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Aug 2024 03:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=X7dSr8H5;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5119F9C5C67;
	Wed, 21 Aug 2024 06:06:34 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id AkksDl9LaZIZ; Wed, 21 Aug 2024 06:06:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5E41F9C5F20;
	Wed, 21 Aug 2024 06:06:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5E41F9C5F20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724234793; bh=rwCVDQEuFNzJcGAyjraRwDZHvangmH/zti8yP1Du708=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=X7dSr8H5Bj/kYRRAdyCPstB/QgCKC9agBzOxaKIw5F0RYqLKrwegBdKChQo2yWy/D
	 7NkSzbKz7yppldpqawCtFwCs+T11nCU49cbGReJp0mjAX/q8rvEDA8VLdHLSDUJDRh
	 nYUbbTd3GYDFUDOYjT3zT5HWYl4r9MkyPcjz/eM2tstD0GaobK5fXwsPIbg3ibcVYr
	 Rh096cPxwK3c7LSqvI9ldtaPEviFIfz6P0+vf8QQFIRg8nuiV/7EXNriTvtkR1k4ry
	 Pw/ppSthnyH93XcsAMTKW9M+d98UvQdgtCHXVEWPlkDlpyhsspgaFVxrrY345KXqvd
	 3M5a0Zn0zuIXg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id oTgJRfmWw0k7; Wed, 21 Aug 2024 06:06:33 -0400 (EDT)
Received: from [192.168.216.123] (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A01829C5C67;
	Wed, 21 Aug 2024 06:06:32 -0400 (EDT)
Message-ID: <a094a466-f8d5-46b0-adfe-e515e927b16a@savoirfairelinux.com>
Date: Wed, 21 Aug 2024 12:06:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept unspecified versions
 in package.json
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com, alexandre.belloni@bootlin.com,
 stefan.herbrechtsmeier@weidmueller.com
References: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
 <c2136d36-fac4-401d-9220-0f227260ef2d@savoirfairelinux.com>
 <b89f6243322fc0e72ae6a9773c437ee598d773e4.camel@linuxfoundation.org>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <b89f6243322fc0e72ae6a9773c437ee598d773e4.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 10:06:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16504



On 20/08/2024 18:00, Richard Purdie wrote:
> On Mon, 2024-08-19 at 09:58 +0200, Enguerrand de Ribaucourt wrote:
>> On 15/08/2024 16:12, Richard Purdie wrote:
>>> On Mon, 2024-08-12 at 14:25 +0200, Enguerrand de Ribaucourt wrote:
>>>> Our current emulation mandates that the package.json contains a vers=
ion
>>>> field. Some packages may not provide it when they are not published =
to
>>>> the registry. The actual `npm pack` would allow such packages, so
>>>> should we.
>>>>
>>>> A first commit was required in the npm class.
>>>>
>>>> For the shrinkwrap part , we can actually use the resolved field whi=
ch
>>>> contains the exact source, including the revision, to pass integrity
>>>> tests.
>>>>
>>>> v3:
>>>>  =C2=A0=C2=A0- Split bitbake npmsw.py modification in another commit
>>>>
>>>> Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.co=
m>
>>>> Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com=
>
>>>> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@sa=
voirfairelinux.com>
>>>> ---
>>>>  =C2=A0=C2=A0bitbake/lib/bb/fetch2/npmsw.py | 2 +-
>>>>  =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/=
npmsw.py
>>>> index d8ed9df327..a5fa598deb 100644
>>>> --- a/bitbake/lib/bb/fetch2/npmsw.py
>>>> +++ b/bitbake/lib/bb/fetch2/npmsw.py
>>>> @@ -97,7 +97,7 @@ class NpmShrinkWrap(FetchMethod):
>>>>   =20
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 integrity =3D params.get("integrity", None)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 resolved =3D params.get("resolved", None)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
version =3D params.get("version", None)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
version =3D params.get("version", resolved)
>>>>   =20
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # Handle registry sources
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if is_semver(version) and integrity:
>>>
>>> I'm not convinced by this reasoning. The whole point of our SRC_URI i=
s
>>> to precisely define something that is being built. I think this allow=
s
>>> floating versions of dependencies and hence makes this non-
>>> reproducible?
>>
>> The version declared in package.json is purely declarative for the NPM
>> package registry. The basic Yocto fetchers will still be used for
>> downloading the SRC_URI (https, git, ...), with the same version
>> reproducibility mechanisms like git hash or md5sum.
>>
>> In the npm.bbclass, we have a second fetch stage (actually during
>> do_configure) to fetch all the dependencies. The npm class here behave=
s
>> wildly differently than regular frameworks where each dependency is a
>> separate recipe. But since there are myriads of dependencies in the NP=
M
>> world and it would be rare to share them, the current recipe class is
>> intended to package an application with all its dependencies using the
>> NPM registry.
>>
>> To fetch all those dependencies, we rely on the NPM dependencies
>> mechanism of package.json which lists packages with their declarative
>> version. However this is not reproducible. NPM provides two additional
>> files that NPM developers should include in their repositories to pin
>> the whole dependency tree: package-lock.json and npm-shrinkwrap.json.
>> The npm recipetool will fetch the dependencies the first time with
>> package.json information, and produce an npm-shrinkwrap.json file that
>> pins all versions.
>=20
> Are you saying that the codepath in question is only used to generate
> the npm-shrinkwrap.json file and that a normal do_fetch and a normal
> build will not fetch any floating version?
This codepath is used when fetching the dependencies listed in a=20
npm-shrinkwrap.json. It will imitate what `npm install` does. It=20
converts all the dependencies from the json format into SRC_URIs to pass=20
to traditional bitbake fetchers like git, file and https. The `version`=20
variable which is being modified here is taken from the optional=20
"version" field in the dependency's json block. Before this commit, if a=20
dependency didn't have a version field, we would throw an error and=20
could not build this package although it was technically valid.

Our modification allows to fallback to the "resolved" field which is=20
always present in the generated npm-shrinkwrap.json files and contains=20
similar information. As illustrated in the example bellow=20
(cockpit-repo), if it is a git URL, it contains the commit hash which=20
will be passed to the git fetcher. If it is an http URL, then the=20
integrity field is mandatory and checksums the archive. If it's a local=20
file URL, I could not see an integrity mechanism in npmsw.py, but it is=20
not part of the scope of this modification. It looks like "file version"=20
packages are not check-summed in this script but it is independent from=20
my modification.
>=20
> I appreciate the npm build itself might not be deterministic but the
> point of our SRC_URI is to make it deterministic.
>=20
> I'm also worried that you implied fetching is happening during
> do_configure. That should not be the case and if that is happening, it
> needs to be changed so that all fetching happens during do_fetch.
I checked the responsibilities of each fetching task in npm.bbclass:

  - node modules are properly downloaded in do_fetch actually,
    they are individually placed in DL_DIR
  - do_unpack puts them into the workdir/sources-unpack/node_modules
  - do_configure will then put them in a local npm registry cache in the=20
workdir/npm-cache
  - finally, do_compile will `npm install` them from the cache into the=20
output node_modules directory of workdir/npm-build/node_modules

So fetching is properly done is do_fetch :p
>=20
>> Back to our commit, we do not change the aforementioned behavior, we
>> only make it compatible with packages which do not declare a version i=
n
>> their package.json. The npmsw.py code wants to have a version to
>> validate what's being downloaded, so we pass a dummy version. But the
>> npm-shrinkwrap.json file, generated by npm native, still contains the
>> reproducible metadata. Example here with a package that doesn't declar=
e
>> a version field: NPM still added integrity and resolved fields which
>> will ensure reproducibility:
>>
>> ```
>>  =C2=A0=C2=A0=C2=A0=C2=A0 "node_modules/cockpit-repo": {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name": "CockpitDevelopmentDepen=
dencies",
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "resolved":
>> "git+ssh://git@github.com/cockpit-project/cockpit.git#d34cabacb8e5e1e0=
28c7eea3d6e3b606d862b8ac",
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "integrity":
>> "sha512-4nBWhDtVLwF++ZPY/67QtpsXc9y/Jpa/jj1LW/gScSafDKoHmtg1BwAQ7sqpN/=
fdyi1xrkysM9hxLq3Q16ofaw=3D=3D",
>> ```
>>>
>>> We should probably error if a version cannot be found and force the
>>> user to add one?
>> An NPM project can typically pull hundreds of dependencies with some n=
ot
>> declaring a version, the user would need to submit patches to all of
>> their upstreams to fix that which is challenging. Meanwhile, the real
>> NPM tool is perfectly fine with accepting that, as illustrated above. =
I
>> believe we should hence behave like the official NPM tool.
>=20
> I'm not asking for the upstream NPM projects to be locked down. I'm
> asking that our recipes always have versions specified. This is similar
> to what we do in other places like crates with carg under rust, which
> probably is the best example of how we can lock down situations like
> this.
This patch doesn't introduce nondeterministic fetching because the=20
resolved and integrity field contain checksums/srcrev that will be=20
handled just as before to ensure reproducibility. This is true for https=20
and git dependencies.

However from my analysis, it looks like if a npm-shrinkwrap.json is=20
pointing to a local "file" version as a dependency, there is no checksum=20
mechanism, but it may very well be a limitation of the=20
npm-shrinkwrap.json format. This will only concern users who rely on=20
local files which shouldn't be the norm. But this was the pre-existing=20
behavior and is not caused by this patch. Specific npm-shrinkwrap.json=20
pointing to local files without a version field couldn't be built=20
without this modification. With this patch, they will now be accepted=20
but inherit this lack of an existing integrity mechanism for local=20
tarballs as it would have been even with a version field (which would=20
not be used).

I haven't played with `file` dependencies but maybe this is something we=20
can improve in a distinct patchset. If the integrity field is always=20
generated in npm-shrinkwrap.json, then we could add the integrity check=20
for this kind of dependency.

TLDR: Even if the version field is not specified, the fallback=20
resolved/integrity fields contain the git commit SHA, or the HTTP=20
tarball's checksum. However local file tarballs do not have an integrity=20
mechanism, but it was already the case even if they declared a "version"=20
field.
>=20
> Cheers,
>=20
> Richard
>=20

--=20
Enguerrand de Ribaucourt
Savoir-faire Linux



