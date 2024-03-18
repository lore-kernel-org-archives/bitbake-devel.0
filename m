Return-Path: <u.oelmann@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDFAC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 15:56:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web10.48515.1710777379485215984
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Mar 2024 08:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: u.oelmann@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <u.oelmann@pengutronix.de>)
	id 1rmFLV-0007ai-MJ; Mon, 18 Mar 2024 16:56:17 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <u.oelmann@pengutronix.de>)
	id 1rmFLV-0076cs-6q; Mon, 18 Mar 2024 16:56:17 +0100
Received: from uol by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <u.oelmann@pengutronix.de>)
	id 1rmFLV-005Y1B-0O;
	Mon, 18 Mar 2024 16:56:17 +0100
From: =?utf-8?Q?Ulrich_=C3=96lmann?= <u.oelmann@pengutronix.de>
To: michael.opdenacker@bootlin.com
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] How to turn a poky patch into a bitbake one?
In-Reply-To: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com> (Michael
	Opdenacker via lists openembedded org's message of "Mon, 18 Mar 2024
	15:41:11 +0100")
References: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Mon, 18 Mar 2024 16:56:17 +0100
Message-ID: <6rv85jh6u6.fsf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: u.oelmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 15:56:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16007

Hi Michael,

On Mon, Mar 18 2024 at 15:41 +0100, "Michael Opdenacker via lists.openembed=
ded.org" <michael.opdenacker=3Dbootlin.com@lists.openembedded.org> wrote:
> Greetings,
>
> For testing convenience, I made BitBake changes directly in the Poky tree.
>
> Before I re-apply my changes to a BitBake tree before submitting them, in=
 a very
> manual way (like removing "bitbake/"=C2=A0 in the paths in my generated p=
atches),
> would you have a nicer way to turn my changes under Poky's "bitbake/"
> subdirectory into a proper pathset for BitBake?
>
> Git tips appreciated. I guess I'm not the first one to do this :-}

there is the option "--relative" to 'git format-patch' (see [1]) that
you could use to have the "bitbake/" prefix removed automatically:

  $ git -C <PATH_TO_POKY_WC> format-patch --relative=3Dbitbake -k --stdout =
<REVISION_RANGE> |
        git -C <PATH_TO_BITBAKE_WC> am -k -p 1

If you ever need to do it the other way round then just use the option
"--directory" (see [2]) which 'git am' inherits from 'git apply' that
automatically prefixes what you need

  $ git -C <PATH_TO_BITBAKE_WC> format-patch -k --stdout <REVISION_RANGE> |
        git -C <PATH_TO_POKY_WC> am -k --directory=3Dbitbake

Best regards
Ulrich


[1] https://git-scm.com/docs/git-format-patch#Documentation/git-format-patc=
h.txt---relativeltpathgt
[2] https://git-scm.com/docs/git-apply#Documentation/git-apply.txt---direct=
oryltrootgt

> Cheers
> Michael.
--=20
Pengutronix e.K.                           | Ulrich =C3=96lmann            =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

