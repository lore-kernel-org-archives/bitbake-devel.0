Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0DAC83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:55:53 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.22877.1752850543608908912
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 07:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O6TCbLIL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455b00339c8so16706285e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752850542; x=1753455342; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qY7mRPpsu4sMsY97RgInl3XwoEU0QjyZJ2dn3zYn8Po=;
        b=O6TCbLIL3bx1gxNMEw4ICPg8L4Ytsjeq6O5z70+Sq24Ep0wApdaWyh7AbeqUsnr8hT
         qrRcLDRrow4h3XASKl0m0q3CPtY+uVKrCfeO/rbRrIz9vGZt7QxoFpbLhpdO8jFJFwt4
         PD/7AyzpiPV7eAZuS9324iwNP+Rf00Go64YM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752850542; x=1753455342;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qY7mRPpsu4sMsY97RgInl3XwoEU0QjyZJ2dn3zYn8Po=;
        b=qx191f6KksvEIhFxZhMcQCmeHpqoxZWXPCDeXup4wK2dJZEkix19CgoiqbhF5D8Zm0
         rt7w0R9XykHZQ+ONfzuTB6Tg5pLmmwQF3HRRZe9ydauu/wlIuFMt+7mfjApyANuqX3ih
         udT05HWIiK2Ia+pMEFQt0wiB2JGicRbfwf/CM8i2MS75hdEm7b4Qc/C4kbh+iBiWPQEL
         vxQ+H3BOMVik+8j95oBjBe1ISovfuma3qMaGTotT8m/c5nW2lCoo0nAqqVBBr/75YmXQ
         aMzzClGgWfuen2uEqAGseK4qAz1l3A04jVzTV1miHD+gvQeoiXlMIj7gFZzpulEn/sBh
         EmSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsGSvAx6/PxmcjXjQKo0DEk8piDXhoT6PcbTU6rp3Ftdbypf0pcElksBNwgKXRrcVi5VWgrd8Qmkkdc3va@lists.openembedded.org
X-Gm-Message-State: AOJu0YwQoVyLWB6qMTZf7hHWg17qSdefWCeOtzQE5THn6WyZwUDU3MVi
	Al/L4pQqrUsHKT7uEY+KYXdYOcJ5sxHDlIhM1BTBUHdP5rdQl+wzNQMDBrhJDFc2NTLoetIK1JT
	zO/CG
X-Gm-Gg: ASbGncsl4YP7Ugr1O4Gc+pVidii0VTLIK/J2um6EaRZJ0rKf8Z1j7Ob2zDalXGI8qEv
	TBRX6vqc3DPeClsUm0cYHfvKUefbYbgVSVQguA4kvnxZao9cUjXJ6eLATLcOhUoLmwGPCybhEAG
	7hL0G80DNKONCsvS3sJWse1RbnoTctInIgUhGYOAglc1EEHrN5bpXXmOO0W9wonrhh2vYFrDlU9
	FtFDi+WOK++uG60GI9ta852b/haLRTO3lNQoeHHuhtJ8YUmErfhJ7gujOP7GdQyUFIR5/c2PZqV
	i4bWk8EwQA9FzaCxdl9QxwQ2Fnyujoqns1WMiMV9vIZnCWUo2q9/syjUX29Gco9Xe8zinBgXK5K
	dzb7GIrYdOqk0hmPN6sSBlGmun26szOjIYXBxX3NW8v6UsQKQaY0jIwoF5j0HE/iLQTQ+uBX5RA
	9vAWM6sA==
X-Google-Smtp-Source: AGHT+IGMy7ecaC8Fb4hrUSVmBGZJO909CPAVYJBL+NxSMSq4Q3pGyuHX8Xx0qO4ew2+OrPFjm88IwA==
X-Received: by 2002:a05:600c:621b:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-4562ec0f9b0mr101639395e9.1.1752850541885;
        Fri, 18 Jul 2025 07:55:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b19:5c6:27ed:a530? ([2001:8b0:aba:5f3c:b19:5c6:27ed:a530])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74029bsm21960655e9.22.2025.07.18.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:55:41 -0700 (PDT)
Message-ID: <8a6c6953149101703e160e7cbffb237698fef98b.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH v2 1/2] doc/bitbake-user-manual-fetching: update
 the Git fetcher tag description
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	docs@lists.yoctoproject.org
Date: Fri, 18 Jul 2025 15:55:40 +0100
In-Reply-To: <20250718-new-tag-git-fetcher-v2-1-11240d481a05@bootlin.com>
References: <20250718-new-tag-git-fetcher-v2-0-11240d481a05@bootlin.com>
	 <20250718-new-tag-git-fetcher-v2-1-11240d481a05@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 14:55:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17798

On Fri, 2025-07-18 at 11:06 +0200, Antonin Godard via lists.yoctoproject.or=
g wrote:
> After commit d591d7633fe8 ("fetch/git: Rework tag parameter handling"),
> update the description of the tag=3D parameter for the Git fetcher.
>=20
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> =C2=A0doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 9 +++++-=
---
> =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index a2c2432db1..51c9a81e03 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -439,10 +439,11 @@ This fetcher supports the following parameters:
> =C2=A0-=C2=A0 *"rev":* The revision to use for the checkout. The default =
is
> =C2=A0=C2=A0=C2=A0 "master".
> =C2=A0
> --=C2=A0 *"tag":* Specifies a tag to use for the checkout. To correctly
> -=C2=A0=C2=A0 resolve tags, BitBake must access the network. For that rea=
son, tags
> -=C2=A0=C2=A0 are often not used. As far as Git is concerned, the "tag" p=
arameter
> -=C2=A0=C2=A0 behaves effectively the same as the "rev" parameter.
> +-=C2=A0 *"tag":* Specifies a tag to match against the supplied revision =
(``rev=3D``).
> +=C2=A0=C2=A0 This does not replace the ``rev`` parameter: the ``tag`` pa=
rameter should
> +=C2=A0=C2=A0 only be specified if you want to verify that the tag commit=
 SHA matches the
> +=C2=A0=C2=A0 supplied ``rev`` SHA. The ``tag`` parameter is optional, bu=
t strongly
> +=C2=A0=C2=A0 recommended if the checked out revision is a tag.

This isn't quite right since the behaviour of "tag" alone didn't
change, we just altered the behaviour allowing it to be specified with
rev, which makes it much more useful.

It should probably say:

'''
*"tag":* Specifies a tag to use when fetching. To correctly resolve
tags, BitBake must access the network. If a ``rev`` parameter or SRCREV
is also specified, network access is not necessary to resolve the tag
and instead, it is verified that they both resolve to the same commit
SHA at unpack time.  The ``tag`` parameter is optional, but strongly
recommended if the checked out revision is a tag.
'''

Cheers,

Richard


