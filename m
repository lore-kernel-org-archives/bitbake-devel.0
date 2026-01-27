Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD9FD2D8E8
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:28:58 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7452.1769509736241386565
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:28:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=g5Nn1U0z;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8FC1E1A2A6F;
	Tue, 27 Jan 2026 10:28:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67916606F5;
	Tue, 27 Jan 2026 10:28:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACB24119A8687;
	Tue, 27 Jan 2026 11:28:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769509734; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FZzSPxYpo8o95zajx27xkKCGlt/in/bKLvEXh5bnlqI=;
	b=g5Nn1U0zjw88NecuV0dJ6m0Gt88IdCcIwLYHHg8u1Zf4kVKK8mFYPcks/ETgwOyCvDlXAR
	fo/QZaJPvfcLZyer/aKNGQH0CFCyFgiYqA2t5bASpsY2HuYpgYqcdZhaDJeP1x1mPzRMg2
	zEzzMI/7QutS4b8QGU61j7wQ0EXEs/INoAs3/yJoC94lPYrcOdBaK8Tp70OBSLEE2eEU+0
	MyswdbKhTaEDgr0UOLwu8w1q5/FVLxXpEAW6vl90QIBpmOa65odt4/wb192CXwrWcv+8IG
	lsd8Y8M8pJKzog8yioduqc1nbjXvpx8Mm6dOU22MOjGPSvpCDGl+sGVLXjtXVg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 11:28:53 +0100
Message-Id: <DFZAULAJWR0S.1RQ0LXOE4BSUR@bootlin.com>
Subject: Re: [bitbake-devel] [docs][PATCH 5/5] docs: Fix sources as required
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <daiane.angolini@foundries.io>, <bitbake-devel@lists.openembedded.org>
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-5-daiane.angolini@foundries.io>
In-Reply-To: <20260126222743.411405-5-daiane.angolini@foundries.io>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:28:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18878

Hi,

On Mon Jan 26, 2026 at 11:27 PM CET, Daiane Angolini via lists.openembedded=
.org wrote:
> If sources is empty, nothing happens. So let's just not say it's
> optional, and let's say the minimum is bitbake source code.
>
> Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
> ---
>  .../bitbake-user-manual-environment-setup.rst               | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 700e02216..5d6bcbea1 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -671,8 +671,10 @@ They contain the following sections:
>            "description": "OpenEmbedded - 'nodistro' basic configuration"
>        }
> =20
> --  ``sources`` (*optional*): sources, such as git repositories that shou=
ld be provided
> -   under ``layers/`` directory of a :term:`Setup`.
> +-  ``sources``: sources, such as git repositories that should be provide=
d

To align with the rest, this should contain "(**required**)" then

> +   under ``layers/`` directory of a :term:`Setup`. Although the list of =
sources
> +   can be very flexible, at least BitBake should be cloned to generate a
> +   :term:`Setup`.
> =20
>     Example:
> =20


Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


