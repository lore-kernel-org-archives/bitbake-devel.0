Return-Path: <jlu@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF6CDB47E
	for <webhook@archiver.kernel.org>; Fri, 13 Oct 2023 08:22:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web11.33945.1697185350657850996
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Oct 2023 01:22:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: jlu@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <jlu@pengutronix.de>)
	id 1qrDRE-0005WF-7U; Fri, 13 Oct 2023 10:22:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jlu@pengutronix.de>)
	id 1qrDRD-001LvN-Fa; Fri, 13 Oct 2023 10:22:27 +0200
Received: from localhost ([127.0.0.1])
	by ptz.office.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <jlu@pengutronix.de>)
	id 1qrDRD-00FQRS-3y; Fri, 13 Oct 2023 10:22:27 +0200
Message-ID: <fa678fac78b8a5ca915b24bb22ae2ff9f8b8f546.camel@pengutronix.de>
Subject: Re: [bitbake-devel] [PATCH] Fix disk space monitoring on cephfs
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Marta Rybczynska <rybczynska@gmail.com>, Samantha Jalabert
	 <samantha.jalabert@syslinbit.com>, bitbake-devel@lists.openembedded.org
Cc: Enrico =?ISO-8859-1?Q?J=F6rns?= <ejo@pengutronix.de>
Date: Fri, 13 Oct 2023 10:22:26 +0200
In-Reply-To: <CAApg2=R2Opk75OqLRcLXBkaHv9WVFAXbnxS9t-PPi5AMywFwGw@mail.gmail.com>
References: <20230824081110.2851830-1-samantha.jalabert@syslinbit.com>
	 <CAApg2=R2Opk75OqLRcLXBkaHv9WVFAXbnxS9t-PPi5AMywFwGw@mail.gmail.com>
Autocrypt: addr=jlu@pengutronix.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (by Flathub.org) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Oct 2023 08:22:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15239

On Thu, 2023-08-24 at 11:42 +0200, Marta Rybczynska wrote:
> On Thu, Aug 24, 2023 at 10:11=E2=80=AFAM Samantha Jalabert <samantha.jala=
bert@syslinbit.com> wrote:
> > Error occured while running bitbake on cephfs:
> >=20
> > WARNING: The free inode of path is running low (-0.001K left)
> > ERROR: Immediately halt since the disk space monitor action is "HALT"!
>=20
> This was our small Ceph issue I've mentioned during the call on Tuesday.

We stumbled across this as well. Would this qualify for backporting? It che=
rry-
picks cleanly to mickledore, kirkstone and dunfell.

Regards,
Jan
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

