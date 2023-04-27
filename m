Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B73CC77B7E
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 07:02:41 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.14455.1682578956761784769
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Apr 2023 00:02:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=CqemiVMF;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 625B95C0096;
	Thu, 27 Apr 2023 09:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1682578952; x=1684393353; bh=R5
	SW/twq/M23gZeSyQzniTWTmSCdymAeFN2jJWn6hlI=; b=CqemiVMF5qDQ05urpP
	xX4okCzN9oEGy7jN7wgjoQ4IlFWQ0zjGwf/0mCco2kI1pi+2UckzWosYFQXLokcM
	+Q0yuETS72Gm51DzRo0un1rI/yY9FjSn5nwoboisLzxd2jCCSNGGQKlIcvjGigd3
	aq7/giRGgE5pHPbZ7bQgHZ+Lc=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u2-fjThp8S3F; Thu, 27 Apr 2023 09:02:32 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id B5CD15C0095;
	Thu, 27 Apr 2023 09:02:32 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 27 Apr 2023 09:02:32 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: data collection
 (patch 2/3)
In-Reply-To: <CAMKF1srdkydixmdbW4dm8egyNYHOxJ5kGoDtTt-WPB_zyWefig@mail.gmail.com>
References: <20230420062113.134546-1-alberto@pianon.eu>
 <CAMKF1sre46PCJrhPcuHzYu8_uLHabY4S_+up5vwvyWnjmSeooA@mail.gmail.com>
 <8dfce9c36a557f67be4dc6d37417ac63@pianon.eu>
 <afcd01000f265238360efcdaecd16a4e@pianon.eu>
 <CAMKF1srdkydixmdbW4dm8egyNYHOxJ5kGoDtTt-WPB_zyWefig@mail.gmail.com>
Message-ID: <023e253cd33ad1c75337c1641dc548fe@pianon.eu>
X-Sender: alberto@pianon.eu
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Apr 2023 07:02:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14751

Il 2023-04-27 08:56 Khem Raj ha scritto:
> On Wed, Apr 26, 2023 at 10:19=E2=80=AFPM Alberto Pianon <alberto@pianon=
.eu>=20
> wrote:
>>=20
>> Il 2023-04-27 07:14 Alberto Pianon ha scritto:
>> > Could you please check if this is really the case in your case?
>> > You'd need to go to meta/recipes-sato/matchbox-panel-2/files
>> > (check where the layer is located in your filesystem) and do
>>=20
>> Of course it is located at
>> /mnt/b/yoe/master/sources/poky/meta/recipes-sato/m
>> atchbox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smaller.p=
atch
>>=20
>> :)
>>=20
>> Please check also the other two files for which you get the warnings
>=20
> My distro uses git submodules at top level and poky is a submodule see
> https://github.com/yoedistro/yoe-distro
>=20
> git rev-parse --is-inside-work-tree
> true
>=20
> % git status
> HEAD detached at 5a944d32a1
> nothing to commit, working tree clean
>=20
>=20

so something's wrong... I'll build your distro and try to find the=20
problem
thanks

Alberto

