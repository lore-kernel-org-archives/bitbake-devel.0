Return-Path: <zach@mandolincreek.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE9CC87FCB
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 23:12:25 +0000 (UTC)
Received: from abbott.mandolincreekfarm.com (abbott.mandolincreekfarm.com [192.173.156.27])
 by mx.groups.io with SMTP id smtpd.web11.48998.1753917141976382762
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Jul 2025 16:12:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: mandolincreek.net, ip: 192.173.156.27, mailfrom: zach@mandolincreek.net)
Received: from [10.0.0.246] (fluffy.mandolincreekfarm.com [192.173.156.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(No client certificate requested)
	by abbott.mandolincreekfarm.com (Postfix) with ESMTPSA id 6DAAAE230C0;
	Wed, 30 Jul 2025 16:12:20 -0700 (PDT)
Message-ID: <c39d2766-2e7d-4061-9e59-70ceec022b01@mandolincreek.net>
Date: Wed, 30 Jul 2025 16:12:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: JPEWhacker@gmail.com, Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
 <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
 <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
Content-Language: en-US
From: Zach Welch <zach@mandolincreek.net>
Organization: Mandolin Creek Systems
In-Reply-To: <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Jul 2025 23:12:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17829

On 7/29/25 07:59, Joshua Watt via lists.openembedded.org wrote:
>=20
>=20
> On Tue, Jul 29, 2025 at 8:57=E2=80=AFAM Alexander Kanavin=20
> <alex.kanavin@gmail.com <mailto:alex.kanavin@gmail.com>> wrote:
>=20
>     On Tue, 29 Jul 2025 at 16:49, Joshua Watt via lists.openembedded.or=
g
>     <http://lists.openembedded.org>
>     <JPEWhacker=3Dgmail.com@lists.openembedded.org
>     <mailto:gmail.com@lists.openembedded.org>> wrote:
>      > Our setup is that we have a "disto" layer that we need to mainta=
in
>      > against several version of Yocto at once. In this disto layer, w=
e
>     make
>      > policy choices that sometimes are tied to a specific version of =
a
>     recipe
>      > found in a specific version of Yocto using a bbappend; and often=
 that
>      > version is only in one or two Yocto versions, which means that t=
he
>      > bbappend will be dangling in the others.
>=20
>     This is where the weak point of the argument is. Yocto does not mak=
e
>     concessions to layers that attempt to be compatible across yocto
>     releases, patches that help such layers had been previously rejecte=
d,
>     and this would create a precedent to the contrary.
>=20
>     It's always possible to make a branch.
>=20
>=20
> Branching isn't an option for us; we are unwilling to add the=20
> maintenance overhead of dealing with that.

I have resorted to some dirty tricks to solve problems like this in the=20
past with great success.

If you move the incompatible bbappends into their own '$branch'=20
directories in your distro layer, then you can add lines like this to=20
your `layer.conf`:

   BBFILES +=3D "${@ "${LAYERDIR}/$branch/recipes-*/*/*.bbappend" if=20
d.getVar("DISTRO_CODENAME") =3D=3D "$branch" else "" }"

I just tested that this trick does appear to work.  But as no one has=20
jumped in to offer this solution before now, I suspect that this=20
actually might be a bad idea for... reasons?

Cheers,
Zach

