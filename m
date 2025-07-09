Return-Path: <ejo@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C9C83F09
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 12:11:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web11.14263.1752063064874799871
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Jul 2025 05:11:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: ejo@pengutronix.de)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <ejo@pengutronix.de>)
	id 1uZTdc-0003aK-Qq; Wed, 09 Jul 2025 14:11:00 +0200
Message-ID: <7c99cad786c37dc3da9cbd73d671ff61eb03171d.camel@pengutronix.de>
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-getvar: skip info output of
 bitbake for quiet
From: Enrico =?ISO-8859-1?Q?J=F6rns?= <ejo@pengutronix.de>
To: alex.kanavin@gmail.com, hongxu.jia@eng.windriver.com
Cc: bitbake-devel@lists.openembedded.org, alex@linutronix.de, PTX-Internal
	Yocto List <yocto@pengutronix.de>
Date: Wed, 09 Jul 2025 14:10:59 +0200
In-Reply-To: <CANNYZj9rw2nb4wVrESvMn+txhfpZk9SOwC3FXyvv49x2CziQEQ@mail.gmail.com>
References: <20250612093206.168888-1-hongxu.jia@windriver.com>
	 <CANNYZj9rw2nb4wVrESvMn+txhfpZk9SOwC3FXyvv49x2CziQEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: ejo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Jul 2025 12:11:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17765

Am Donnerstag, dem 12.06.2025 um 12:15 +0200 schrieb Alexander Kanavin via =
lists.openembedded.org:
> On Thu, 12 Jun 2025 at 11:32, hongxu via lists.openembedded.org
> <hongxu.jia=3Deng.windriver.com@lists.openembedded.org> wrote:
> > +=C2=A0=C2=A0=C2=A0 if quiet:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger =3D logging.getLogge=
r("BitBake")
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger.setLevel(logging.WAR=
NING)
> > +
>=20
> Thanks, this should be the correct fix :)

So my findings in the bug report https://bugzilla.yoctoproject.org/show_bug=
.cgi?id=3D15881 are
obsolete by this fix/workaround and we should close it?

Regards, Enrico

> Alex
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17699): https://lists.openembedded.org/g/bitbake-deve=
l/message/17699
> Mute This Topic: https://lists.openembedded.org/mt/113603580/3616721
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[e=
jo@pengutronix.de]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

--=20
Pengutronix e.K.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| Enrico J=C3=B6rns=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
Embedded Linux Consulting & Support=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| https://www.pengutronix.de/ |
Steuerwalder Str. 21=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| Phone: +49-5121-206917-180=C2=A0=C2=A0|
31137 Hildesheim, Germany=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| Fax:=C2=A0=C2=
=A0=C2=A0+49-5121-206917-9=C2=A0=C2=A0=C2=A0=C2=A0|

