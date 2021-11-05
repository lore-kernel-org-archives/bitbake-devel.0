Return-Path: <martin@mko.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655A4C433EF
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 11:12:34 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web08.4063.1636110752417667346
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 04:12:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@mko.dev header.s=mail
 header.b=rGVkGsxa;
 spf=pass (domain: mko.dev, ip: 116.202.209.171, mailfrom: martin@mko.dev)
Message-ID: <f6217969-632b-ee22-4fe8-5d47b5f32612@mko.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mko.dev; s=mail;
	t=1636110750; bh=ZWoiBwLNPi4cO8mY//pASfd+4eh1VMndvM02yTcBdZ0=;
	h=Subject:References:To:From:In-Reply-To;
	b=rGVkGsxavLmdeWJmDBwn63pSeSKz9A0kFRHlUvj7f2XMLiuJIAwbfMjAmzq7F72kN
	 uJNkHcsDLGXW27MwN33i+uG58AvVmgN41a3H2FGGw/TrYHvIeeBG3M5uaUG69oOt4E
	 Oc6Dpwv4+HFieCTJPt/pb6mnuBzB+tu89gb77w8SfMMChR7nTqTi6T7Zh8FW2wTc+X
	 bca2FbfeW5c9WafYMvp28zneKQZUcNmQyF0khg+MEc53lspgX+Q+vif2NM4DYfySO8
	 DJzDaORBJeuFN7BnJw2mj0yqr1Wfu8KYDQstFbwyRo2tyi3F2H//P8lwucpaexWg6O
	 KrYgLDp4CUMqQ==
Date: Fri, 5 Nov 2021 12:12:29 +0100
Mime-Version: 1.0
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
Content-Language: en-US-large
References: <4106f9ef-5b2e-5276-f1bb-c80a989d7fdf@mko.dev>
To: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
From: Martin Koppehel <martin@mko.dev>
In-Reply-To: <4106f9ef-5b2e-5276-f1bb-c80a989d7fdf@mko.dev>
X-Forwarded-Message-Id: <4106f9ef-5b2e-5276-f1bb-c80a989d7fdf@mko.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 11:12:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12888

Hi Stefan and Richard,

first of all, thanks for sharing your thoughts on this. I'm working with=20
Jasper to improve this and want to share my view on the topic.

On 11/5/21 10:07, Stefan Herbrechtsmeier wrote:
> Hi Jasper and Richard,
>
> Am 05.11.2021 um 00:15 schrieb Richard Purdie via lists.openembedded.or=
g:
>> On Thu, 2021-11-04 at 12:29 +0000, Jasper Orschulko wrote:
>>> Dear Bitbake developers,
>>>
>>> recently we have been looking at the npmsw fetcher and discovered som=
e
>>> challenges regarding the integration into the developer workflow as
>>> well as the build times within Bitbake. We believe that we found a
>>> mechanism which would integrate well into Bitbake's existing project
>>> structure and drastically improve the situation.
>>>
>>>
>>> But first, what are the issues with the current npmsw fetcher?
>>>
>>> 1. Let's have a look at a typical npm-based project. You'd typically
>>> have your package-lock.json (aka shrinkwrap file) stored within the g=
it
>>> repository containing your source code. Developers will rely on this
>>> package-lock file on a daily basis during the development cycle.
>>> Unfortunately, the current npmsw fetcher only supports shrinkwrap fil=
es
>>> stored within the meta layer or within an npm registry. This is not
>>> ideal, as changes to the file might be made within the project repo,
>>> which then need to be manually applied to the lock file within the me=
ta
>>> repo. An ideal npmsw fetcher therefore would support using the lock
>>> file directly from the source code repo.
>
> The package-lock.json and npm-shrinkwrap.json are identical. The only=20
> difference is that the npm-shrinkwrap.json could be published with the=20
> package.
>
>>> 2. The current implementation of the npm class uses multiple shellout=
s
>>> per npm module in order to add these to the npm cache. This is done, =
as
>>> the `npm install` command is not called within the do_fetch, but at t=
he
>>> end of the do_configure step. This drastically increases the time
>>> Bitbake spends in the do_configure step for a npm based recipe. In ou=
r
>>> case (we have a relatively small project with approx. 600 npm package=
s
>>> in total, including recursive packages) this takes ~100 minutes to
>>> complete. What makes things worse, every change to the recipe and/or
>>> lock file will cause a complete rerun of the do_configure job.
>
> This is a problem of the sequential setup of the cache. I have a=20
> prototype to do this in a special bb task and use multiple parallel=20
> process task inside the bb task. But I have also a prototype which=20
> remove the complete cache and speed up the build significant.
I do agree with the things Stefan wrote here, especially that most of=20
the build-duration issues come from the fact that the npmsw fetcher and=20
the npm bbclass work sequentially on all packages, which takes up=20
~100minutes in the do_configure step for our case.
Our general idea too was to remove the complete cache population step=20
which should drop the build time significantly.
>
>>> As a result, the npm fetcher currently is not really usable for
>>> production workloads.
>
> Ack.
>
>>> So how can we address these issues?
>>>
>>> We plan to implement a "sub-fetcher" for npmsw (a concept which might
>>> also be recyclable for similar use-cases). This would take the
>>> form of e.g.:
>>>
>>> SRC_URI =3D "npmsw+git://git-uri.git;npm-topdir=3Dpath_to_npm_project=
;..."
>>>
>>> The idea is, that the npsw fetcher would then call an arbitrary sub-
>>> fetcher (in this case git, however any fetcher will be supported) and
>>> after the sub-fetcher has extracted the source code into the DL_DIR,
>>> the npm fetcher will create a secondary download folder as a copy of
>>> the sub-fetchers download folder. Within this copy, the npm fetcher
>>> will call `npm ci`, effectively downloading the npm packages by doing=
 a
>>> clean-install on the basis of the package.json and the package-
>>> lock.json files within the npmsw download dir. This results in a much
>>> faster build, as it removes the need for seperate handling of the
>>> individual node packages, as well as streamlining the developers
>>> workflow with the build process within Bitbake.
>
> How should this support the download proxy? The npm ci command need a=20
> repository or a cache to work.
The npm ci command can utilize a private registry and/or http proxy if=20
that's required. We didn't consider that case yet, but I think we could=20
add a call to npm to configure a proxy according to e.g. a set of=20
environment variables.
>
> Furthermore you need a patch step in between the fetch steps to=20
> support tuning / fixing of the configuration before the second fetch st=
ep.
Our idea was to build a completely checked out and installed repository=20
and archive this in the DL_DIR, which then can be used in the do_patch=20
phase.
Are we missing some important use-case here? Whenever it is necessary to=20
patch the package.json/package-lock.json this should ideally be done in=20
your upstream repository.

Our primary motivation behind leaving the package-lock within the source=20
repository was to have a single source of truth for the dependency versio=
ns.

>
>>> As this fetcher would be implemented separately from the current npms=
w
>>> fetcher, this will not cause any breaking changes for existing setups=
.
>>>
>>> Additionally, we plan on writing a separate npmsw.bbclass, which will
>>> parse the package.json for each node module for an automated Bitbake
>>> license manifest generation, which will resolve the current challenge
>>> of having to maintain these manually, as currently described at
>>> https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html=
#npm-using-the-registry-modules-method=20
>>>
>>> .
>
> This licenses will be generated by the recipetool and you could=20
> provide checksums to detect the correct licenses.
>
> The license inside the package.json is only a hint and you need a=20
> license file to fulfill the license compliance. Because of this I=20
> remove the package.json from LIC_FILES_CHKSUM because it is useless=20
> for the license compliance.
You're right here that there's a need to have the full license file. In=20
this case, a license crawler would need to traverse node_modules and=20
scan for LICENSE[.md,.txt,] files and then generate the checksums.
>
>>> If this is something you see as a worthwhile goal, we will provide a
>>> set of patch files within the coming weeks.
>
> I think you mixed the unusable npm implementation with your special=20
> use case.
>
> The problem is that the current npm implementation isn't really=20
> usable. I'm working on this and have already a prototype that could=20
> install, build and *test* a proprietary angular project and node-red=20
> as well as koa/examples from github.
You make a very interesting point here, primarily because you cover two=20
very different use-cases. I think we have to distinguish between=20
something like a webinterface that only uses nodejs and npm at=20
compile-time for dependency management and bundling, where NodeJS itself=20
is not even required on the target (this is our use case). The second=20
class of use cases is running software like node-red directly on the=20
target, where the current approach of the npm fetcher works quite well.=20
Our thoughts primarily focused on the webinterface use case, but I agree=20
with you that we should keep an eye on supporting all use cases.
>
> If I understand you correct you like to build a npm recipe that could=20
> change it dependencies without update the recipe except the SRCREV of=20
> the repositories.

That is true, and I believe keeping the package-lock file directly in=20
the source repository is something worth pursuing not only for us.
Do you have a strong preference for keeping the dependencies outside of=20
the source repository?

>
>> At a first read it sounds reasonable but I don't know the answers to=20
>> a few
>> questions which make or break things from an OE/bitbake perspective.=20
>> Those
>> questions are:
>>
>> a) Once DL_DIR has been populated by this fetch mechanism, can a=20
>> subsequent
>> build run with just the data from there without accessing the network?
This does hold for well-built packages that only use code out of=20
node_modules.
We can not guarantee this because the package could execute arbitrary JS=20
code during its build time, including fetching content from the internet.
>>
>> b) Is the information encoded into SRC_URI enough to give a=20
>> deterministic build
>> result, i.e. if we run this build at some later date, will we get the=20
>> same
>> result?
The package-lock.json should be checked into the source repository, so=20
pinning down SRCREV guarantees a 100% reproducible dependency installatio=
n.
>>
>> c) Is fetching only happening during the do_fetch task and not in any=20
>> subsequent
>> step?
Yes, we want to perform a full fetch directly in do_fetch and then=20
archive the result of this operation within the DL_DIR, so subsequent=20
builds can be done directly from the DL_DIR.
>>
>> I'd love for some of the other people who're worked on this code to=20
>> jump in as I
>> don't use it or understand it in detail. I am worried about how we=20
>> maintain this
>> longer term as different people seem to have different use cases=20
>> which sees the
>> code changing in different directions and we're starting to look like=20
>> we may end
>> up with multiple ways of doing things which I really dislike.
>
> This leads to the questions what is the desired way to integrate a=20
> package / dependency manager. Nowadays any language (even C/C++) has a=20
> package manager available and more and more build systems (ex. Meson,=20
> CMake) support automatic download of dependencies. The common=20
> integration into OE is a script (recipetool) that generate a recipe=20
> from the foreign configuration. The current npm implementation is=20
> special because it reuse a foreign configuration and translate it into=20
> fetch commands on-the-fly. This leads to the problem that common=20
> tweaks like override a dependency or share configuration between=20
> recipes via include file isn't possible. We could fix it by removing=20
> the foreign configuration and do the translation during recipe=20
> creation. But this means you have to recreate the recipe after every=20
> dependency change.
>
> Is it a valid use case for OE to support foreign dependency=20
> configurations like npm-shrinkwrap.json, go.sum or conan.lock?
Agreed. Especially for cases like Javascript/Go/Rust where the=20
dependency management is a core part of the language and ecosystem, we=20
should support these.

>
> Regards
> =C2=A0 Stefan

Regards,
Martin

