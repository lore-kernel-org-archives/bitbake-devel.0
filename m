Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D2CC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 08:10:15 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.205941.1724055012532909666
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Aug 2024 01:10:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=vG1dvZ8r;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 86B5D9C5D3A;
	Mon, 19 Aug 2024 04:10:11 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id P6qadJgUId2I; Mon, 19 Aug 2024 04:10:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D1D829C5FD5;
	Mon, 19 Aug 2024 04:10:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D1D829C5FD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724055010; bh=qXErPQsh8nbqKOAYOt4CsFs+/pjz2c9msZb+LJba4DM=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=vG1dvZ8rmtIjENzL+dGPCFEOWjbKo6yILj0WnkXsDwA4OAZkH1NmEf4x42K/ByY1h
	 Zkg8RVEmMY033qHWG9NGRz1vLPXaycFjVjHq58ChwnSshUtLd7jS0CsQ+iqL8KUioh
	 D/zI5/jGDw3tCkCk60SLQYH4vOzYuML4pkMtJ+I7+rbSCRDf0g74eWjni2yakGasR3
	 MgGSo3Y8V87uperVoKrB2cOBFgXkA3ImSUwXUok3VBUdE3SG+/zn1Am90WOS2/rBSi
	 dkeKTxuXKnvHyGnC7QI6P8f3WYauhlXpJvPybC8j0TH7p5eyTmsdFD2XqE99TyIAnq
	 oqsLVR0hFRzbg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5z-hM4yOQVxQ; Mon, 19 Aug 2024 04:10:10 -0400 (EDT)
Received: from [192.168.216.123] (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2703C9C5D3A;
	Mon, 19 Aug 2024 04:10:10 -0400 (EDT)
Message-ID: <e18c8c56-9fe4-4feb-9257-3f64a01d307a@savoirfairelinux.com>
Date: Mon, 19 Aug 2024 10:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH v4 1/2] bitbake: fetch2: npmsw: fix
 fetching git revisions not on master
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com, alexandre.belloni@bootlin.com,
 stefan.herbrechtsmeier@weidmueller.com
References: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240812122539.573337-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20cc37c9d00ac3cca4d6bbc9f45c6aeb6468acfd.camel@linuxfoundation.org>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20cc37c9d00ac3cca4d6bbc9f45c6aeb6468acfd.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Aug 2024 08:10:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16494



On 15/08/2024 16:14, Richard Purdie wrote:
> On Mon, 2024-08-12 at 14:25 +0200, Enguerrand de Ribaucourt wrote:
>> The NPM package.json documentation[1] states that git URLs may contain
>> a commit-ish suffix to specify a specific revision. When running
>> `npm install`, this revision will be looked for on any branch of the
>> repository.
>>
>> The bitbake implementation however translates the URL stored in
>> package.json into a git URL to be fetch by the bitbake git fetcher. Th=
e
>> bitbake fetcher git.py, enforces the branch to be master by default. I=
f
>> the revision specified in the package.json is not on the master branch=
,
>> the fetch will fail while the package.json is valid.
>>
>> To fix this, append the ";nobranch=3D1" suffix to the revision in the =
git
>> URL to be fetched. This will make the bitbake git fetcher ignore the
>> branch and respect the behavior of `npm install``.
>>
>> This can be tested with the following command:
>>  =C2=A0$ devtool add --npm-dev https://github.com/seapath/cockpit-clus=
ter-dashboard.git=C2=A0-B version
>> Which points to a project which has a package.json with a git URL:
>> ```json
>>  =C2=A0 "devDependencies": {
>>  =C2=A0=C2=A0=C2=A0 "cockpit-repo": "git+https://github.com/cockpit-pr=
oject/cockpit.git#d34cabacb8e5e1e028c7eea3d6e3b606d862b8ac"
>>  =C2=A0 }
>> ```
>> In this repo, the specified revision is on the "main" branch, which
>> would fail without this fix.
>>
>> [1] https://docs.npmjs.com/cli/v10/configuring-npm/package-json#git-ur=
ls-as-dependencies
>>
>> Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
>> Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
>> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savo=
irfairelinux.com>
>> ---
>>  =C2=A0bitbake/lib/bb/fetch2/npmsw.py | 1 +
>>  =C2=A01 file changed, 1 insertion(+)
>>
>> diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/np=
msw.py
>> index b55e885d7b..d8ed9df327 100644
>> --- a/bitbake/lib/bb/fetch2/npmsw.py
>> +++ b/bitbake/lib/bb/fetch2/npmsw.py
>> @@ -184,6 +184,7 @@ class NpmShrinkWrap(FetchMethod):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uri =3D URI("git://" + str(groups["url"]))
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uri.params["protocol"] =3D str(groups["protoc=
ol"])
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uri.params["rev"] =3D str(groups["rev"])
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uri.params["nobranch"] =3D "1"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uri.params["destsuffix"] =3D destsuffix
>>  =20
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 url =3D str(uri)
>=20
> Is it possible to determine and add the branch name where needed?
>=20
> I'd prefer to try and keep the behaviours similar in more cases if we
> can and avoid disabling checks we added for good reasons...
The current npm.bbclass implementation is actually trying to reproduce=20
the behavior of the real `npm install` tool that reads=20
package.json/npm-shrinkwrap.json and installs all dependencies. The=20
package.json specification has a specific format which is frequently=20
used like above to explicit commit hashes to fetch but it doesn't allow=20
to specify the branch [1]. This form is usually written for dependencies=20
which do not declare a version like cockpit-repo here (discussed all=20
throughout this patch list).

So to behave similarly to the `npm install` tool, we should not specify=20
a branch. We would actually need to edit package.json into a diverging=20
format when we want to be compatible with as many package.json projects=20
as possible.

The alternative would be to pre-fetch to see which branch we want, then=20
pass that in the FetchMethod query here. But we would just displace the=20
problem? At its base, package.json git references cannot specify a branch=
.

Thank you very much for your review,

  [1]=20
https://docs.npmjs.com/cli/v10/configuring-npm/package-json#git-urls-as-d=
ependencies
>=20
> Cheers,
>=20
> Richard
>=20

--=20
Enguerrand de Ribaucourt
Savoir-faire Linux

