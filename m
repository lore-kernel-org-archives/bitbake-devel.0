Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1E3CD5BD1
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 07:05:30 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22883.1780297522518304015
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 00:05:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=HWH+n5q+;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5BA8D4E42DCE
	for <bitbake-devel@lists.openembedded.org>; Mon,  1 Jun 2026 07:05:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11E72602AB;
	Mon,  1 Jun 2026 07:05:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76F0010888CB7;
	Mon,  1 Jun 2026 09:05:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780297519; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6chGfYNLmyB5F6rEbyJLA0lDcRjEvgrhxD3D+QvKTVI=;
	b=HWH+n5q+krhzmr1/h8eNx5hAiANCy1xiUbOTJ+BtUxCkqUethERZAtzEn3QhhidE8Y8XdX
	ovLnB+ADPkXcpx8AnFARC4t8nc3l1S2IkWkr3+wUOizM7EOBnJuPu3KQ3RhfnVWQOGHOEm
	1K4iapPSPruMchUuNXHrMAT2PJmcQNBe8q4xMOeIymj2YZ7Lpyti6OGXj5osjBle+ZlhJT
	OS3rxgsHt2JJcERBzCIj7atO023OMDEkEbRjaeHEGJGtBLbulRJ/b3bSjuovOL8ua6o0v0
	HZWChQofCwDenN0CTYisBPwW7kcfiBjypFBs1ztJRw3vlcG/mrIz4fyHp3l0rw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 09:05:17 +0200
Message-Id: <DIXISSZ5047B.PSMH6SMC4CF8@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: write notes for
 generated build configs
Cc: "Alexander Kanavin" <alex@linutronix.de>, <docs@lists.yoctoproject.org>,
 "Ernest Van Hoecke" <ernest.vanhoecke@toradex.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <ernestvanhoecke@gmail.com>, <bitbake-devel@lists.openembedded.org>
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
 <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com>
In-Reply-To: <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 07:05:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19578

On Fri May 29, 2026 at 5:00 PM CEST, Ernest Van Hoecke via lists.openembedd=
ed.org wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>
> For bb-layers configurations, bitbake-setup currently writes an empty
> "conf-notes.txt". Configurations using "oe-template" get this file from
> the template.
>
> Add an optional field called "notes" to configurations that populates
> this field when "bb-layers" is used instead of "oe-template".

Suggestion: call the field "conf-notes" so it matches the resulting filenam=
e?

Also, I supposed newlines must be explicitly written in the string ("\n")? =
Are
those properly converted, or does it need escaping of some sorts?

Thanks,
Antonin

