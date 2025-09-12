Return-Path: <patrick.vogelaar.dev@mailbox.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C2ECAC582
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 16:23:07 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.21043.1757694178272921474
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Sep 2025 09:22:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mailbox.org header.s=mail20150812 header.b=Svg7DR/n;
 spf=pass (domain: mailbox.org, ip: 80.241.56.151, mailfrom: patrick.vogelaar.dev@mailbox.org)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cNfq112skz9tKg;
	Fri, 12 Sep 2025 18:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757694173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESYQmI0dJ0mn+xhq7B9jVSyDvk0SvcnH81TRoZ1zqug=;
	b=Svg7DR/nh3/G2f8OltBoheZiR0K8RQxCcU2YmHGqP530yMQKpQLAUwGAyIGrR+hCba84td
	nBgmpDUDUQq7OktyAZl2fg4N//RBZnfxDiS5Npc5bbkSodZWqk4kBG73BnGlQ8gxAVVUqo
	YzoaTQsYuSracQAG/y7LtHeGyzwLCNQhEbeg1/CZvxd3OsBm+IW/D017WkMmT8aI46YTZK
	TRFSEdrxDXeQxJ0RZtuz9Yr/MxzQs0Qj+sVafuraw+dnmnJte2CXKWGo5LEgbwuU7kuQe1
	MhoDXxzlPGdqZiPzayvHOYn4dq1R5BB+qPp58VPvVe0P+TPlztmTKPuLCd0mjg==
Date: Fri, 12 Sep 2025 18:22:51 +0200 (CEST)
From: patrick.vogelaar.dev@mailbox.org
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Message-ID: <668556816.154276.1757694172007@office-sso.mailbox.org>
In-Reply-To: <DCQWVNMF7OTP.2YR0N4S0VTCCE@bootlin.com>
References: <20250910145400.232143-1-patrick.vogelaar.dev@mailbox.org>
 <DCQWVNMF7OTP.2YR0N4S0VTCCE@bootlin.com>
Subject: Re: [bitbake-devel] [docs][PATCH] doc: enhance SRCREV_FORMAT
 description
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: f7433e68feaf61ae571
X-MBO-RS-META: oahw5ae55b78g6rfcj8gy4scx8aw5xj7
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 16:23:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18013


> Antonin Godard via lists.openembedded.org <antonin.godard=3Dbootlin.com@l=
ists.openembedded.org> hat am 12.09.2025 17:02 CEST geschrieben:
>=20
> =20
> On Wed Sep 10, 2025 at 4:54 PM CEST, Patrick Vogelaar via lists.yoctoproj=
ect.org wrote:
> > Adding documentation for having an empty first component for the
> > SRCREV_FORMAT.
> >
> > Signed-off-by: Patrick Vogelaar <patrick.vogelaar.dev@mailbox.org>
> > ---
> >  .../bitbake-user-manual-ref-variables.rst                   | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.=
rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > index 810f88689..07e754096 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > @@ -1670,6 +1670,12 @@ overview of their function and contents.
> >        ``AUTOINC`` placeholder is added and if needed. And, this placeh=
older
> >        is placed at the start of the returned string.
> > =20
> > +      The :term:`SRCREV_FORMAT` can also take the form "_component2".
> > +      This assumes that there is a component in the :term:`SRC_URI` th=
at does not
> > +      have a name assigned. While this is not considered good practice=
, it can be
> > +      usefull if a ``.bbappend`` file needs to extend the :term:`SRC_U=
RI` with
>=20
> s/usefull/useful/
>=20
> > +      an additional repository.
> > +
> >     :term:`STAMP`
> >        Specifies the base path used to create recipe stamp files. The p=
ath
> >        to an actual stamp file is constructed by evaluating this string=
 and
>=20
> This is not a good practice, albeit useful. So what is the good practice,=
 in the
> case where I _do_ want an additional git remote source to be fetched? Mod=
ify
> the original SRC_URI to include a name for the first component, and do=20
>=20
> SRCREV_FORMAT =3D "component1_component2"
>=20
> as usual?
>=20
> This doesn't sound practical so I'm leaning towards your solution. But if=
 this
> is something we should really never do, then I'm wondering if we should d=
ocument
> it here=E2=80=A6

Thanks for the feedback Antonin. When going back to the code and checking w=
hat is commonly used and what isn't, I stumbled over a few interesting thin=
gs. I might need to change it a bit more to reflect it correctly (The propo=
sal now might not be correct). I will do an update of the patch and conside=
r your input.

Patrick=20

>=20
> Antonin
>=20
> --=20
> Antonin Godard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18012): https://lists.openembedded.org/g/bitbake-deve=
l/message/18012
> Mute This Topic: https://lists.openembedded.org/mt/115170994/10013339
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [patric=
k.vogelaar.dev@mailbox.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

