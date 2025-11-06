Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF58CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 12:11:17 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13935.1762431066984326049
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 04:11:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=U8P/WnGT;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8668B4E41567;
	Thu,  6 Nov 2025 12:11:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D2ED6068C;
	Thu,  6 Nov 2025 12:11:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFC4511850FCD;
	Thu,  6 Nov 2025 13:11:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762431063; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jnACU/gM58Ie05X1g1r5slzV1WARTuvmNkS+SDo00Jk=;
	b=U8P/WnGTpchQAQsvJ6lrTBd174i7uqDSjtnXTyO+WMC2EwmE4xAC5rteDpPDAUXel5rPLg
	rI0/j3BIqk9qGJfH6yOSLX9Us0nvWTw/y5hch4KrkXcxpMhtPbGQilUNQSdvNqIDEDsA4W
	uvU6LFWv9mjUXMezMwYCyQtBTKBelADXmABS+WZ0CDKeuDU/ng6+E48b2Qz0lEJQr0+dCL
	UmJYG9Orl25Sm9ggySRMv0MpWx4AZClOeiEfwwI5R/CufEb0pkYUKZxWIsTsLuTRp/XoiE
	5gD87Y9vkZh0kif5N6jqN57ZMdAKU2Tx5PePya/IVuTqLFTOnwvsrp/mk2GDxQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 13:11:01 +0100
Message-Id: <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
In-Reply-To: <20251106114714.918370-1-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 12:11:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18287

Hi,

On Thu Nov 6, 2025 at 12:47 PM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> {THISDIR} is a special value token that can be used in the list of enable=
d
> layers to specify the layer location relative to the confguration file:
> https://git.openembedded.org/bitbake/commit/?id=3Db3153be29de8b8570b0c184=
369bd41f4c646cf92
>
> This replaces the token with an explicit separate keyword for such layers=
:
> so that special processing to determine the final value can be avoided, a=
nd
> the feature can be formalized in the json schema:
>
> instead of
>    "bb-layers": [
>         "{THISDIR}/meta-my-project"
>     ]
>
> this allows
>    "bb-layers-relative-to-this-file": [

Can I suggest naming it "bb-layers-local"? "bb-layers-relative-to-this-file=
"
feels bit overwhelming, I think with associated documentation users will be
able to figure what "local" stands for in this case.

I can't help but wonder: why is there a need to have a separate keyword? Ca=
n't
bitbake-setup do:

  for <layer> in bb-layers; do
    if <layer> is not in <sources>; then=20
      if <layer> is found next to the .conf.json; then=20
        use this local layer
      else
        error
      fi
    else
      use setup/layers/<layer>
    fi
  done

?

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


