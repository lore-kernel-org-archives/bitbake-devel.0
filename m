Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442B9C77B73
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 14:10:53 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.21482.1682604643468045588
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Apr 2023 07:10:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=0v7udtgq;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 084465C0096;
	Thu, 27 Apr 2023 16:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1682604639; x=1684419040; bh=27
	xrDKiKT4HYsFB/W4JMcKuUF09SqTRISonfzu4MCSQ=; b=0v7udtgqMCkDh6ft/M
	sYoyS3GvUOQ4n8lD9TmDBfW2uvtg7tWl8AgnB5HJnND8ZFuzb6BzD4sKzNsXMKvf
	WoLeDpdvJnphq9/tWqO8zJB+DMKopgjuveVwwYaHSq3EbiNwOV92/vZeBAF5EV1u
	L6GTOjHyyy8WnzUNF9yy4q6HI=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8zTtoCwf20Fn; Thu, 27 Apr 2023 16:10:39 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 735985C0095;
	Thu, 27 Apr 2023 16:10:39 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 27 Apr 2023 16:10:39 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: data collection
 (patch 2/3)
In-Reply-To: <1759B8A6082B56AB.32698@lists.openembedded.org>
References: <20230420062113.134546-1-alberto@pianon.eu>
 <CAMKF1sre46PCJrhPcuHzYu8_uLHabY4S_+up5vwvyWnjmSeooA@mail.gmail.com>
 <8dfce9c36a557f67be4dc6d37417ac63@pianon.eu>
 <afcd01000f265238360efcdaecd16a4e@pianon.eu>
 <CAMKF1srdkydixmdbW4dm8egyNYHOxJ5kGoDtTt-WPB_zyWefig@mail.gmail.com>
 <1759B8A6082B56AB.32698@lists.openembedded.org>
Message-ID: <eb69f0d13d5ff7dc8acc987a5344c3fe@pianon.eu>
X-Sender: alberto@pianon.eu
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Apr 2023 14:10:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14753

Hi Khem,

Il 2023-04-27 09:02 Alberto Pianon ha scritto:

     Il 2023-04-27 08:56 Khem Raj ha scritto:

         On Wed, Apr 26, 2023 at 10:19=E2=80=AFPM Alberto Pianon=20
<alberto@pianon.eu> wrote:


             Il 2023-04-27 07:14 Alberto Pianon ha scritto:

                 Could you please check if this is really the case in=20
your case?
                 You'd need to go to=20
meta/recipes-sato/matchbox-panel-2/files
                 (check where the layer is located in your filesystem)=20
and do


             Of course it is located at
             /mnt/b/yoe/master/sources/poky/meta/recipes-sato/m
            =20
atchbox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smaller.patc=
h

             :)

             Please check also the other two files for which you get the=20
warnings


         My distro uses git submodules at top level and poky is a=20
submodule see
         https://github.com/yoedistro/yoe-distro

         git rev-parse --is-inside-work-tree
         true

         % git status
         HEAD detached at 5a944d32a1
         nothing to commit, working tree clean



     so something's wrong... I'll build your distro and try to find the=20
problem
     thanks


first of all kudos for Yoe, it's one of the simpler-to-build distros I=20
ever tried, it seems you did a very good job there :)

BTW, I couldn't reproduce the problem, since I don't get any warning=20
message, and the upstream sources are correctly identified, eg. in=20
build/tmp/work/cortexa72-yoe-linux/matchbox-keyboard/0.1.1-r0/temp/matchb=
ox-keyboard-0.1.1.unpack.trace.json.zst=20
I find:

  =20
"git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec094421a=
7a8773#meta/recipes-sato/m
atchbox-keyboard/files/0001-desktop-file-Hide-the-keyboard-from-app-list.=
patch":=20
{
     "download_location":=20
"git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec094421a=
7a8773#meta/recipes-sato/matchbox-keyboard/files/0001-desktop-file-Hide-t=
he-keyboard-from-app-list.patch",
     "src_uri":=20
"file://0001-desktop-file-Hide-the-keyboard-from-app-list.patch",
     "layer": "meta",
     "files": {
       "": {
         "sha1": "856c3f6bf74a1b11e90b0ade0b4aeecbb3babfff",
         "paths_in_workdir": [
           "0001-desktop-file-Hide-the-keyboard-from-app-list.patch"
         ]
       }
     }
   },

... which is the expected result (while on the same file you get a=20
warning that the download_location has not been identified).

Could you please double-check the output of git commands in=20
/mnt/b/yoe/master/sources/poky/meta/recipes-sato/matchbox-keyboard/files/=
=20
and in other dirs?

Thanks

Alberto

