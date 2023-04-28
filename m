Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BEC77B7E
	for <webhook@archiver.kernel.org>; Fri, 28 Apr 2023 07:47:46 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web10.14105.1682668056455086344
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Apr 2023 00:47:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=m+tvEUmp;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 2694D5C0096;
	Fri, 28 Apr 2023 09:47:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1682668050; x=1684482451; bh=lh
	lcGvbNdhMZ5Ad/X8ZwwbK7LHhNXDg447fBR3Xe+2E=; b=m+tvEUmpnjQ+Z1tMrW
	2HShTLHktLZSvtwogbtvzX5YiuyXBluv04C27mvmd5puK3EXXkk2FnNw7ci/6OVu
	niymY+ARrLfB9rGjNFdVUjrIQ6pO7Y6SerOaqm8hwvont0WQO1YdumR7V2MA+r5U
	7aHh1MSWAN6fWlyvbWy39MYXo=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1cBl5y1Hh3-i; Fri, 28 Apr 2023 09:47:30 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 244195C0095;
	Fri, 28 Apr 2023 09:47:30 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 28 Apr 2023 09:47:30 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: data collection
 (patch 2/3)
In-Reply-To: <CAMKF1srvD2ZUcfhYbtMUX=t-p0NjE9nA4mdS1bASwWo3v6yrfQ@mail.gmail.com>
References: <20230420062113.134546-1-alberto@pianon.eu>
 <CAMKF1sre46PCJrhPcuHzYu8_uLHabY4S_+up5vwvyWnjmSeooA@mail.gmail.com>
 <8dfce9c36a557f67be4dc6d37417ac63@pianon.eu>
 <afcd01000f265238360efcdaecd16a4e@pianon.eu>
 <CAMKF1srdkydixmdbW4dm8egyNYHOxJ5kGoDtTt-WPB_zyWefig@mail.gmail.com>
 <1759B8A6082B56AB.32698@lists.openembedded.org>
 <eb69f0d13d5ff7dc8acc987a5344c3fe@pianon.eu>
 <CAMKF1srvD2ZUcfhYbtMUX=t-p0NjE9nA4mdS1bASwWo3v6yrfQ@mail.gmail.com>
Message-ID: <f831364c9b14ac92d527b04fe82713dc@pianon.eu>
X-Sender: alberto@pianon.eu
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Apr 2023 07:47:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14756


On 2023-04-27 21:40, Khem Raj wrote:
> On Thu, Apr 27, 2023 at 7:10=E2=80=AFAM Alberto Pianon <alberto@pianon.=
eu>=20
> wrote:
>>=20
>> Hi Khem,
>>=20
>> Il 2023-04-27 09:02 Alberto Pianon ha scritto:
>>=20
>>      Il 2023-04-27 08:56 Khem Raj ha scritto:
>>=20
>>          On Wed, Apr 26, 2023 at 10:19=E2=80=AFPM Alberto Pianon
>> <alberto@pianon.eu> wrote:
>>=20
>>=20
>>              Il 2023-04-27 07:14 Alberto Pianon ha scritto:
>>=20
>>                  Could you please check if this is really the case in
>> your case?
>>                  You'd need to go to
>> meta/recipes-sato/matchbox-panel-2/files
>>                  (check where the layer is located in your filesystem)
>> and do
>>=20
>>=20
>>              Of course it is located at
>>              /mnt/b/yoe/master/sources/poky/meta/recipes-sato/m
>>=20
>> atchbox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smaller.p=
atch
>>=20
>>              :)
>>=20
>>              Please check also the other two files for which you get=20
>> the
>> warnings
>>=20
>>=20
>>          My distro uses git submodules at top level and poky is a
>> submodule see
>>          https://github.com/yoedistro/yoe-distro
>>=20
>>          git rev-parse --is-inside-work-tree
>>          true
>>=20
>>          % git status
>>          HEAD detached at 5a944d32a1
>>          nothing to commit, working tree clean
>>=20
>>=20
>>=20
>>      so something's wrong... I'll build your distro and try to find=20
>> the
>> problem
>>      thanks
>>=20
>>=20
>> first of all kudos for Yoe, it's one of the simpler-to-build distros I
>> ever tried, it seems you did a very good job there :)
>>=20
>> BTW, I couldn't reproduce the problem, since I don't get any warning
>> message, and the upstream sources are correctly identified, eg. in
>> build/tmp/work/cortexa72-yoe-linux/matchbox-keyboard/0.1.1-r0/temp/mat=
chbox-keyboard-0.1.1.unpack.trace.json.zst
>> I find:
>>=20
>>=20
>> "git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec0944=
21a7a8773#meta/recipes-sato/m
>> atchbox-keyboard/files/0001-desktop-file-Hide-the-keyboard-from-app-li=
st.patch":
>> {
>>      "download_location":
>> "git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec0944=
21a7a8773#meta/recipes-sato/matchbox-keyboard/files/0001-desktop-file-Hid=
e-the-keyboard-from-app-list.patch",
>>      "src_uri":
>> "file://0001-desktop-file-Hide-the-keyboard-from-app-list.patch",
>>      "layer": "meta",
>>      "files": {
>>        "": {
>>          "sha1": "856c3f6bf74a1b11e90b0ade0b4aeecbb3babfff",
>>          "paths_in_workdir": [
>>            "0001-desktop-file-Hide-the-keyboard-from-app-list.patch"
>>          ]
>>        }
>>      }
>>    },
>>=20
>> ... which is the expected result (while on the same file you get a
>> warning that the download_location has not been identified).
>>=20
>> Could you please double-check the output of git commands in
>> /mnt/b/yoe/master/sources/poky/meta/recipes-sato/matchbox-keyboard/fil=
es/
>> and in other dirs?
>=20
> [kraj@apollo=20
> /mnt/b/yoe/master/sources/poky/meta/recipes-sato/matchbox-keyboard/file=
s]
> % git rev-parse --is-inside-work-tree
>=20
> true
>=20
> Secondly, I am building on archlinux which is uptodate as of
> yesterday, Default yoe builds in a debian bullseye container
> so I wonder if thats what is mattering here. in order to not use
> container with yoe add
>=20
> cp local.sh.example local.sh
>=20
> and add below line to local.sh
>=20
> export DOCKER_REPO=3Dnone
>=20
> Then source envsetup again and build.
>=20

I tried that, but I got the same (good) results, I get none of the=20
warnings you are getting. I'm on Ubuntu 22.04 though... which archlinux=20
version are you on?

