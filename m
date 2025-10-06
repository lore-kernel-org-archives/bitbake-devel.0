Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE0ACAC5B8
	for <webhook@archiver.kernel.org>; Mon,  6 Oct 2025 14:47:29 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.35672.1759762044016591626
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Oct 2025 07:47:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=rzhgw3U2;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2E9274E40EDE
	for <bitbake-devel@lists.openembedded.org>; Mon,  6 Oct 2025 14:47:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D5E86606B7;
	Mon,  6 Oct 2025 14:47:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A65B102F1C6D;
	Mon,  6 Oct 2025 16:47:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759762041; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=++xb2PACwbWOaj9nE2YGKnZGlexcEN2+wLuyse/bzMA=;
	b=rzhgw3U2EI623nUTEpHZ5miIatMopVulj37OX2LyFwhxuNwL6E286mkays1jx1Klh2auUF
	1x9bAa8Zx2rai/1TX4JL/vpjbT5ovqMhubyszUH09V/c0euAig48NHUAdEjanHp65Pyycy
	ERPfnfv5aJr0aPCQr4ev18m2/M8/pxFMchuDxga/5RQsS2VRTA+cajDx/Yg53opMDAB/Xn
	2/0xm/OOAsNfStTeXxMl09bTLiYGCtNsqChCnmaqMtqD77TjM0Tvw9CAlnlRCXDStAmRqr
	BGrd4cKWt5Cxl827Ky8n0u5aJpyH+ySDEbBTuCEoVXdK4cWqIEl8dzn5OYSxCw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 16:47:18 +0200
Message-Id: <DDBBKVV1MKQF.9MZYXJCT79K@bootlin.com>
Cc: <bitbake-devel@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Adam Blank" <adam.blank.g@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc/bitbake-user-manual-ref-variables:
 improve INHERIT
References: <20251001093743.26710-1-adam.blank.g@gmail.com>
 <DD8O1G6S52MQ.2RRPD9QVIHT6O@bootlin.com>
 <CAFAffzwZqKTTX6GebYfAWU5dA_gFqmpGAwz8HPRR1S6VGs13xQ@mail.gmail.com>
In-Reply-To: <CAFAffzwZqKTTX6GebYfAWU5dA_gFqmpGAwz8HPRR1S6VGs13xQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 14:47:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18138

On Fri Oct 3, 2025 at 2:06 PM CEST, Adam Blank wrote:
> Anonymous Python functions are called either when a recipe is finalised, =
or
> when
> Bitbake is called to show just the base configuration, i.e. 'bitbake -e'.
> In a normal build those two cases don't coincide, so your proposal is ful=
ly
> correct,
> but perhaps it would be good to hint on why their execution can be observ=
ed
> in
> the 'show environment' case?

Ha you are correct, I did not think of trying bitbake -e! I guess I was jus=
t
confused by what base configuration meant here. This could probably be impr=
oved
to provide a reference to the "Parsing the Base Configuration Metadata" sec=
tion
with:

:ref:`base configuration <bitbake-user-manual/bitbake-user-manual-execution=
:Parsing the Base Configuration Metadata>`

But out-of-context for your patch.

I would insist on the fact that the two cannot coincide then, but your patc=
h is
already an improvement.

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


