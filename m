Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D185AC636CC
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 11:10:50 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.81093.1675768248316178895
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Feb 2023 03:10:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=SYqRHSEE;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E92C8C0003;
	Tue,  7 Feb 2023 11:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1675768246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEF3brG27PalWeGAMefO+VpvKoNZQVgyZUF+9/lfCk4=;
	b=SYqRHSEEaTvs3ckmH0nBsuVnlh1yNXUH1DDm6eZkPIMGVakyp93M/TiJ/NBIU7WKBa+zui
	PuHyowjSrNuVClrtQcbV96d872YWW9gfFld4ak+n2upvSYwsjnVHXUyPY1Wpo2ewCUY4aN
	hOuPTFRJEZIUbM9OfCgsHCeTeB9r/8krYk02QYOe9P352JrcE5ojccWhwZVsiAfniRE3vK
	cIfQFYn81lH9NonOabrW/iXqmuFys/Wbxnw3jn0jqpZxXz958vLJu6pTMKuKbpYKhOcKUu
	CiXiF1bhvzxrq8Uk4NlYGcyKa9GUf8/ypN9rvNySJyE2M58n8Bw1Q6KaVw7fvA==
Date: Tue, 7 Feb 2023 12:10:44 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Anders =?UTF-8?Q?J=C3=B8rgensen?= via lists.openembedded.org"
 <anders.joergensen=advent.energy@lists.openembedded.org>
Cc: anders.joergensen@advent.energy, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v2] fetch2: Add path control to
 BB_ALLOWED_NETWORKS #bitbake
Message-ID: <20230207121044.7fc70c48@booty>
In-Reply-To: <tRzV.1675761464866849302.d3iU@lists.openembedded.org>
References: <tRzV.1675761464866849302.d3iU@lists.openembedded.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 11:10:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14376

Hello Anders,

On Tue, 07 Feb 2023 01:17:44 -0800
Anders J=C3=B8rgensen via lists.openembedded.org
<anders.joergensen=3Dadvent.energy@lists.openembedded.org> wrote:

> From d08ab52c29cda8969b9f9e198d1ef2fd11d06ca4 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Anders=3D20J=3DC3=3DB8rgensen?=3D <anders.joergensen@ad=
vent.energy>
> Date: Wed, 1 Feb 2023 13:08:11 +0100
> Subject: [PATCH] fetch2: Add path control to BB_ALLOWED_NETWORKS

I'm afraid also this v2 does not apply. The few lines quoted above
suggest you did not use git send-email to send it but maybe you
forwarded another email.

I recommend you to read the guidelines at
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
in order to prepare a good commit message and to send your patch
in a way that makes it more easily reviewed, applied and tested.

Before sending it again to the list I suggest you try to send it to
yourself and check whether it looks correct, or to send it to a
colleague or friend who can try to apply it on  a local tree.

...

> @@ -1071,12 +1071,27 @@ def trusted_network(d, url):
>=20
> network =3D network.split(':')[0]
> network =3D network.lower()
> +=C2=A0 =C2=A0 path =3D path.lower()
> +
> +=C2=A0 =C2=A0 for host_path in trusted_hosts.split(" "):
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_path =3D host_path.lower()
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_trusted =3D False
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 split_data =3D host_path.split("/", 1)
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D split_data[0]
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trusted_path =3D None
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(split_data) =3D=3D 2:
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trusted_path =3D "/" + split_d=
ata[1]
>=20
> -=C2=A0 =C2=A0 for host in trusted_hosts.split(" "):
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D host.lower()
> if host.startswith("*.") and ("." + network).endswith(host[1:]):

The lines here without a leading space character clearly show that this
is not a correctly formatted patch.

Best regards,
--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

