Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD975CCD19A
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 09:09:28 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8431.1763456961526989909
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Nov 2025 01:09:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=jnKmK/Qy;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5CB684E41761;
	Tue, 18 Nov 2025 09:09:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2DAFD606FE;
	Tue, 18 Nov 2025 09:09:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44B7A10371CE4;
	Tue, 18 Nov 2025 10:09:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763456958; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ezwbP46SQhiwrJgJ4ELxj/vXOg+LS4NUwUkHHnhtA9A=;
	b=jnKmK/QyGnaz3Q5OmkaRqQjq945LBt9wa7TeweQGlk9k/+yR1vvzx3xD3sL6PpOogF4nUh
	ncft2OreefmDVVQ0ravmuGTtViMTV9FLcqlg8vJ84AsCrq7/TBRQhqK40YxCkXePGvnRrn
	y4tUfrZn8yW4RSAe7SNN/fX9dMtG1WsWwK49QJtZoNMO4sd6eACmrryT11P42oA4D6olkj
	mOostp+r783KaKzq16Y4mp9xxHHTu55k4r/qM98ZuC1P4w6dEH+MAWa7Xix96WmBAroXTv
	NJFZJOz0Y4DS21BK3NrYoqzQ45AAuXyZedAi+eAZeqkW7CBA2SyMYsWWhRnjrw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Nov 2025 10:09:15 +0100
Message-Id: <DEBPBHJQP5KR.H9185WOHSOX4@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <david.reyna@windriver.com>, "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: remove styhead
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <IA1PR11MB76771BF4DF707E156B0504C5EAC9A@IA1PR11MB7677.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB76771BF4DF707E156B0504C5EAC9A@IA1PR11MB7677.namprd11.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 09:09:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18446

On Mon Nov 17, 2025 at 7:01 PM CET, David via lists.openembedded.org Reyna =
wrote:
> From d977e6eca7d6fb094b862b9a78472191f31d182a Mon Sep 17 00:00:00 2001
> From: David Reyna David.Reyna@windriver.com<mailto:David.Reyna@windriver.=
com>
> Date: Mon, 17 Nov 2025 09:51:35 -0800
> Subject: [PATCH] toaster: remove styhead
>
> Remove the now-unsupported Styhead release, move 'Kirkstone' into its pla=
ce in the table.
>
> [YOCTO #16065]
>
> Signed-off-by: David Reyna David.Reyna@windriver.com<mailto:David.Reyna@w=
indriver.com>
> ---

Hi David,

Thanks for your patch.

It looks like it got somehow corrupt as you sent it. Particularly, lines
like this:

> @@ -80,16 +75,9 @@
>      <field type=3D"TextField" name=3D"helptext">Toaster will run your bu=
ilds using the tip of the &lt;a href=3D\https://cgit.openembedded.org/opene=
mbedded-core/log/?h=3Dwalnascar\&gt;OpenEmbedded Walnascar&lt;/a&gt; branch=
.</field>

The quotes around the URL have somehow been dropped, as it should be
something like:

     <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D\https://cgit.openembedded.org/openemb=
edded-core/log/?h=3Dwalnascar\&gt;OpenEmbedded Walnascar&lt;/a&gt; branch.<=
/field>

Anyway, I took the liberty of fixing your patch. As long as you are OK
with the version in my branch, there is no need to resend.

https://git.openembedded.org/bitbake-contrib/commit/?h=3Dmathieu/master-nex=
t&id=3Dd1257f1025531ad2776052215752bfd4c6c951c6

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


