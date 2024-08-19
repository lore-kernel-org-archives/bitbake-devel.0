Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7261C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 07:58:25 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.205791.1724054298473251383
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Aug 2024 00:58:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=R6i8LQeB;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F3FF69C5E8C;
	Mon, 19 Aug 2024 03:58:16 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id otfn6KryA2VP; Mon, 19 Aug 2024 03:58:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 575EE9C5F4D;
	Mon, 19 Aug 2024 03:58:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 575EE9C5F4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724054296; bh=T3TSjJQP8qB7hy14VqG91zSFVDuc35OB6V7oN5sPbxo=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=R6i8LQeB802ilixqYv6LQgxontAiLAzLfuhgyJTKRXv8q0dNXtm6R+T9jVIl7hd5z
	 GAzM3zHVQTqe4N4E0bKGQrxSejjy1S+1OxHVSC3BbAfpVH8uvyC74NNFi94zxYpart
	 tK9VbYw5Gi4HJfhL2GV4NJzV+f6STz68GUBLmrkmFleOz3uv0f1K7Xg2uxW321kB7P
	 sZgXfzfMct9LshxGs9yBqZHZ2DiEgKDzvqdvanG4VF4wg5AugUxt1Nvi5849iNJ50P
	 vZF8IdUB6WcunLO5cKGJ/xi1z4oupGGdp/pZpGrfBANmjmgK98ox3M4ZyCJrzVQ+qQ
	 RDPyWuVLFphrA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GaORcpuCZeZh; Mon, 19 Aug 2024 03:58:16 -0400 (EDT)
Received: from [192.168.216.123] (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 97E679C5E8C;
	Mon, 19 Aug 2024 03:58:15 -0400 (EDT)
Message-ID: <c2136d36-fac4-401d-9220-0f227260ef2d@savoirfairelinux.com>
Date: Mon, 19 Aug 2024 09:58:14 +0200
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
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Aug 2024 07:58:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16493



On 15/08/2024 16:12, Richard Purdie wrote:
> On Mon, 2024-08-12 at 14:25 +0200, Enguerrand de Ribaucourt wrote:
>> Our current emulation mandates that the package.json contains a versio=
n
>> field. Some packages may not provide it when they are not published to
>> the registry. The actual `npm pack` would allow such packages, so
>> should we.
>>
>> A first commit was required in the npm class.
>>
>> For the shrinkwrap part , we can actually use the resolved field which
>> contains the exact source, including the revision, to pass integrity
>> tests.
>>
>> v3:
>>  =C2=A0- Split bitbake npmsw.py modification in another commit
>>
>> Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
>> Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
>> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savo=
irfairelinux.com>
>> ---
>>  =C2=A0bitbake/lib/bb/fetch2/npmsw.py | 2 +-
>>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/np=
msw.py
>> index d8ed9df327..a5fa598deb 100644
>> --- a/bitbake/lib/bb/fetch2/npmsw.py
>> +++ b/bitbake/lib/bb/fetch2/npmsw.py
>> @@ -97,7 +97,7 @@ class NpmShrinkWrap(FetchMethod):
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 integrity =3D params.get("integrity", None)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 resolved =3D params.get("resolved", None)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ve=
rsion =3D params.get("version", None)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ve=
rsion =3D params.get("version", resolved)
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 # Handle registry sources
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if is_semver(version) and integrity:
>=20
> I'm not convinced by this reasoning. The whole point of our SRC_URI is
> to precisely define something that is being built. I think this allows
> floating versions of dependencies and hence makes this non-
> reproducible?
Hi,

The version declared in package.json is purely declarative for the NPM=20
package registry. The basic Yocto fetchers will still be used for=20
downloading the SRC_URI (https, git, ...), with the same version=20
reproducibility mechanisms like git hash or md5sum.

In the npm.bbclass, we have a second fetch stage (actually during=20
do_configure) to fetch all the dependencies. The npm class here behaves=20
wildly differently than regular frameworks where each dependency is a=20
separate recipe. But since there are myriads of dependencies in the NPM=20
world and it would be rare to share them, the current recipe class is=20
intended to package an application with all its dependencies using the=20
NPM registry.

To fetch all those dependencies, we rely on the NPM dependencies=20
mechanism of package.json which lists packages with their declarative=20
version. However this is not reproducible. NPM provides two additional=20
files that NPM developers should include in their repositories to pin=20
the whole dependency tree: package-lock.json and npm-shrinkwrap.json.=20
The npm recipetool will fetch the dependencies the first time with=20
package.json information, and produce an npm-shrinkwrap.json file that=20
pins all versions.

Back to our commit, we do not change the aforementioned behavior, we=20
only make it compatible with packages which do not declare a version in=20
their package.json. The npmsw.py code wants to have a version to=20
validate what's being downloaded, so we pass a dummy version. But the=20
npm-shrinkwrap.json file, generated by npm native, still contains the=20
reproducible metadata. Example here with a package that doesn't declare=20
a version field: NPM still added integrity and resolved fields which=20
will ensure reproducibility:

```
     "node_modules/cockpit-repo": {
       "name": "CockpitDevelopmentDependencies",
       "resolved":=20
"git+ssh://git@github.com/cockpit-project/cockpit.git#d34cabacb8e5e1e028c=
7eea3d6e3b606d862b8ac",
       "integrity":=20
"sha512-4nBWhDtVLwF++ZPY/67QtpsXc9y/Jpa/jj1LW/gScSafDKoHmtg1BwAQ7sqpN/fdy=
i1xrkysM9hxLq3Q16ofaw=3D=3D",
```
>=20
> We should probably error if a version cannot be found and force the
> user to add one?
An NPM project can typically pull hundreds of dependencies with some not=20
declaring a version, the user would need to submit patches to all of=20
their upstreams to fix that which is challenging. Meanwhile, the real=20
NPM tool is perfectly fine with accepting that, as illustrated above. I=20
believe we should hence behave like the official NPM tool.
>=20
> I don't really know node well at all so if I'm incorrect about that
> feel free to explain. I do know our fetcher requirements which default
> to being fully specified and reproducible.
Let me know if something is still not clear in my answer,

Best regards,
>
> Cheers,
>=20
> Richard
>=20
>=20

--=20
Enguerrand de Ribaucourt
Savoir-faire Linux


