Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BCFC77B7E
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 10:44:19 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web10.125645.1683024253568410490
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 May 2023 03:44:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=0PKkFz4J;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 152E45C0096;
	Tue,  2 May 2023 12:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1683024248; x=1684838649; bh=6k
	sxamwCxV1m1qDd5WPK8aZdeLcgUDqRvcbuVZe97NA=; b=0PKkFz4JJ4+6q8e9hg
	gxogIlbx4aJ24LnsGfDk9rI/Y8xkgrG+mNJqjS+7rcahw0TAI+OCBhBv1i203Vg7
	lkh7texexuThVL08pPQWw2xu8IFqYnds1UDVRHakoTb6TiWtFcOQjie9KksuQxBO
	0NJDfO6cW1STvBTf/K+HDK6JM=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PI_GTm0fSpZx; Tue,  2 May 2023 12:44:08 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 1D7685C0095;
	Tue,  2 May 2023 12:44:08 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 02 May 2023 12:44:07 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: data collection
 (patch 2/3)
In-Reply-To: <CAMKF1sqwNtQj0c7MhQWzrn+Kkiv5zptf52kktUUqENUUS1sKmg@mail.gmail.com>
References: <20230420062113.134546-1-alberto@pianon.eu>
 <CAMKF1sre46PCJrhPcuHzYu8_uLHabY4S_+up5vwvyWnjmSeooA@mail.gmail.com>
 <8dfce9c36a557f67be4dc6d37417ac63@pianon.eu>
 <afcd01000f265238360efcdaecd16a4e@pianon.eu>
 <CAMKF1srdkydixmdbW4dm8egyNYHOxJ5kGoDtTt-WPB_zyWefig@mail.gmail.com>
 <1759B8A6082B56AB.32698@lists.openembedded.org>
 <eb69f0d13d5ff7dc8acc987a5344c3fe@pianon.eu>
 <CAMKF1srvD2ZUcfhYbtMUX=t-p0NjE9nA4mdS1bASwWo3v6yrfQ@mail.gmail.com>
 <f831364c9b14ac92d527b04fe82713dc@pianon.eu>
 <CAMKF1sqwNtQj0c7MhQWzrn+Kkiv5zptf52kktUUqENUUS1sKmg@mail.gmail.com>
Message-ID: <0ebebbaf89c2770326e0d26d12a5179e@pianon.eu>
X-Sender: alberto@pianon.eu
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 May 2023 10:44:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14765

On 2023-04-28 15:47, Khem Raj wrote:
> On Fri, Apr 28, 2023 at 12:47=E2=80=AFAM Alberto Pianon <alberto@pianon=
.eu>=20
> wrote:
>>=20
>>=20
>> On 2023-04-27 21:40, Khem Raj wrote:
>> > On Thu, Apr 27, 2023 at 7:10=E2=80=AFAM Alberto Pianon <alberto@pian=
on.eu>
>> > wrote:
>> >>
>> >> Hi Khem,
>> >>
>> >> Il 2023-04-27 09:02 Alberto Pianon ha scritto:
>> >>
>> >>      Il 2023-04-27 08:56 Khem Raj ha scritto:
>> >>
>> >>          On Wed, Apr 26, 2023 at 10:19=E2=80=AFPM Alberto Pianon
>> >> <alberto@pianon.eu> wrote:
>> >>
>> >>
>> >>              Il 2023-04-27 07:14 Alberto Pianon ha scritto:
>> >>
>> >>                  Could you please check if this is really the case =
in
>> >> your case?
>> >>                  You'd need to go to
>> >> meta/recipes-sato/matchbox-panel-2/files
>> >>                  (check where the layer is located in your filesyst=
em)
>> >> and do
>> >>
>> >>
>> >>              Of course it is located at
>> >>              /mnt/b/yoe/master/sources/poky/meta/recipes-sato/m
>> >>
>> >> atchbox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smalle=
r.patch
>> >>
>> >>              :)
>> >>
>> >>              Please check also the other two files for which you ge=
t
>> >> the
>> >> warnings
>> >>
>> >>
>> >>          My distro uses git submodules at top level and poky is a
>> >> submodule see
>> >>          https://github.com/yoedistro/yoe-distro
>> >>
>> >>          git rev-parse --is-inside-work-tree
>> >>          true
>> >>
>> >>          % git status
>> >>          HEAD detached at 5a944d32a1
>> >>          nothing to commit, working tree clean
>> >>
>> >>
>> >>
>> >>      so something's wrong... I'll build your distro and try to find
>> >> the
>> >> problem
>> >>      thanks
>> >>
>> >>
>> >> first of all kudos for Yoe, it's one of the simpler-to-build distro=
s I
>> >> ever tried, it seems you did a very good job there :)
>> >>
>> >> BTW, I couldn't reproduce the problem, since I don't get any warnin=
g
>> >> message, and the upstream sources are correctly identified, eg. in
>> >> build/tmp/work/cortexa72-yoe-linux/matchbox-keyboard/0.1.1-r0/temp/=
matchbox-keyboard-0.1.1.unpack.trace.json.zst
>> >> I find:
>> >>
>> >>
>> >> "git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec0=
94421a7a8773#meta/recipes-sato/m
>> >> atchbox-keyboard/files/0001-desktop-file-Hide-the-keyboard-from-app=
-list.patch":
>> >> {
>> >>      "download_location":
>> >> "git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec0=
94421a7a8773#meta/recipes-sato/matchbox-keyboard/files/0001-desktop-file-=
Hide-the-keyboard-from-app-list.patch",
>> >>      "src_uri":
>> >> "file://0001-desktop-file-Hide-the-keyboard-from-app-list.patch",
>> >>      "layer": "meta",
>> >>      "files": {
>> >>        "": {
>> >>          "sha1": "856c3f6bf74a1b11e90b0ade0b4aeecbb3babfff",
>> >>          "paths_in_workdir": [
>> >>            "0001-desktop-file-Hide-the-keyboard-from-app-list.patch=
"
>> >>          ]
>> >>        }
>> >>      }
>> >>    },
>> >>
>> >> ... which is the expected result (while on the same file you get a
>> >> warning that the download_location has not been identified).
>> >>
>> >> Could you please double-check the output of git commands in
>> >> /mnt/b/yoe/master/sources/poky/meta/recipes-sato/matchbox-keyboard/=
files/
>> >> and in other dirs?
>> >
>> > [kraj@apollo
>> > /mnt/b/yoe/master/sources/poky/meta/recipes-sato/matchbox-keyboard/f=
iles]
>> > % git rev-parse --is-inside-work-tree
>> >
>> > true
>> >
>> > Secondly, I am building on archlinux which is uptodate as of
>> > yesterday, Default yoe builds in a debian bullseye container
>> > so I wonder if thats what is mattering here. in order to not use
>> > container with yoe add
>> >
>> > cp local.sh.example local.sh
>> >
>> > and add below line to local.sh
>> >
>> > export DOCKER_REPO=3Dnone
>> >
>> > Then source envsetup again and build.
>> >
>>=20
>> I tried that, but I got the same (good) results, I get none of the
>> warnings you are getting. I'm on Ubuntu 22.04 though... which=20
>> archlinux
>> version are you on?
>=20
> arch is a rolling distro i am uptodate as of today
>=20

yep, you're right :blush:

I set up a build machine with archlinux, updated as of today, installed=20
required packages (base-devel chrpath cpio diffstat gawk gcc git=20
inetutils iputils mesa lz4 python-pylint python3 python-gitpython=20
python-jinja python-pexpect python-pip python-subunit rpcsvc-proto socat=20
texinfo unzip wget xterm xz zstd) and built Yoe without docker (to be=20
sure, I didn't event install it, and set `export DOCKER_REPO=3Dnone`).

I still get none of the warning messages you are getting, everything=20
works, and trace json files are correctly generated.

Could you please try again from a fresh Yoe git clone?

