Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C18CCF9E0
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 09:59:33 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.28455.1761559171425212162
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Oct 2025 02:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NLXns2xr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4270a3464caso2079901f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761559169; x=1762163969; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV5A7iXXxs+DpRsSaqoaS1g0M8ZNwm4KFZTC0SbMZ7g=;
        b=NLXns2xrJuohOO6DKVLgBxP2x0TslWd951tI490Xue0P1F+pm81HBkvP21bCTBuRUO
         Bek3SFDW/yf2rB7+Tl9Io63IBekYB1yfqtWw7l8lFD9tjJDdtxTpRUaypAGHMLypCjTT
         u0Cb7ZGt8aKoUcyRWmM6RbcznUyxpkhfePCro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761559169; x=1762163969;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JV5A7iXXxs+DpRsSaqoaS1g0M8ZNwm4KFZTC0SbMZ7g=;
        b=xEAveqa1oUMrcwxoDj8QlcmeUQjAMwHyWWBuSmpG5CgFg9zV5MpM6ZiS8YgN9lbc64
         cd0gS/4opvKsW0rpyAV5+kDEMdXBI+KaSWFdiq6IjgJuI3gPJLlGyI95eCrRChjXmdil
         bKvCXIUue1lRovzVebes6oCBng4Qx3NvjbQiz2QKamGwxXaMUuIV9G5WgvcuSostQwGB
         Ri0MZRy1Ljc4WZYAK0duAexpynGu4i5jJYZUpW8I9xmLGC9srM2q2OMrDKbysQmFKFEU
         tJ4RaASfUTTjOYslVkzIlxI6u8CcXAD9JX3ZS2ZT8Io99u4Y9WelKZqlLjKTQzgqQg5H
         ACzw==
X-Forwarded-Encrypted: i=1; AJvYcCUb9l7tX9o3lPDIfAFrIPvuCDwtdN3bVOQmgQZi9oHuzde81p63GPEVcAl3XD+wlzx/Gs61OwLwwpDfMFEB@lists.openembedded.org
X-Gm-Message-State: AOJu0YzRaTUHyhzF1Prl/zsbb/4an3Rx4AHH+wLO5yMbjcZIfTT26J96
	ACycEd5pblcBDTyxiQVq6bk1OmooMDUbOmgqoIu0l5CO4/89LsHdFwlKJ1PhEHrTwQo=
X-Gm-Gg: ASbGncs80sckVE7bx0QH7ufnbNiNO3/7F86DVM1hOWPpA5p1rcqWB6mFxqB2LN8IbP/
	pFpU3ciherjJ7fkmd4YG6y3ko5tiRQcXUIuOQjkPoexxMoqaOYsUHgASOBwoHjlJu2isa2zBjlD
	EyrUJM/XUpa5XvpGF0Lpr9f2lePHU+CjW6tiEIUJ6diGasRgU4rSwUNH9l6XvcnyVR2HoYrGtyC
	atCKV3iovQmquXhDh+6uQRhCVFYPcohJlkGmT/10ug5L5Ooot6qCQ9CUO0SawaGDuZc/TrsbZN6
	s0rp5CvVNwdiCIDvlTuEwzAa82qAEgeKGgdf4sxXcauznw1Re5/oag1IAiJTuP3zp1uWqWnJNXV
	qvMr97I7VpLPEoUnX36I8a55nsrg+pRH+snWMhLKpChjYrlGnqbXRcagJ0q5P4Wo1LmgcMdH1ZY
	UZYgKQMWzvFnSiINrYJQRONc3jamEjdZaBj7Sb9fqT8A0f4U5dHBp5TISXthV9aiss5jsRXzJJP
	XQ=
X-Google-Smtp-Source: AGHT+IHvtJRS6ylDxsT/8vIOKy6ybRLWnpUqvysXjjaH+9cJIMeAlKdaLXvki+nhm3GNXxFwYHyFVQ==
X-Received: by 2002:a05:6000:428a:b0:427:2e8:fe5e with SMTP id ffacd0b85a97d-4298a0405ecmr12796993f8f.13.1761559169567;
        Mon, 27 Oct 2025 02:59:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:16c5:d0d6:9af3:2bd2? ([2001:8b0:aba:5f3c:16c5:d0d6:9af3:2bd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5768sm13579714f8f.24.2025.10.27.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:59:28 -0700 (PDT)
Message-ID: <de0bd5430a12374f5fa438306a7cad2d0746a571.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] siggen: Fix dump of non-runtime sigdata
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Barker <paul@pbarker.dev>, bitbake-devel@lists.openembedded.org
Date: Mon, 27 Oct 2025 09:59:27 +0000
In-Reply-To: <c12740b7bc4ad5f7ddbb56f4ce57dc665892051e.camel@pbarker.dev>
References: <20251027-fix-dumpsig-v1-1-465674c4fac3@pbarker.dev>
		 <fd1e8c06aa46063af275cebef8aa42eb897c55e0.camel@linuxfoundation.org>
	 <c12740b7bc4ad5f7ddbb56f4ce57dc665892051e.camel@pbarker.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 09:59:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18220

On Mon, 2025-10-27 at 09:16 +0000, Paul Barker wrote:
> On Mon, 2025-10-27 at 08:58 +0000, Richard Purdie wrote:
> > On Mon, 2025-10-27 at 08:25 +0000, Paul Barker wrote:
> > > If the debug code is uncommented in SignatureGeneratorBasic.finalise(=
),
> > > sigtask stamp file are created without runtime data such as
> > > 'runtaskdeps' and 'file_checksum_values'. If we then try to run
> > > bitbake-dumpsig on one of these files, we will see a traceback as the
> > > expected keys are not present in the sigdata dictionary:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 Traceback (most recent call last):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File ".../bitbake/bin/bitbake-dumpsig"=
, line 195, in <module>
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output =3D bb.siggen.dump_=
sigfile(options.sigdatafile1)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File ".../bitbake/lib/bb/siggen.py", l=
ine 1266, in dump_sigfile
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 computed_taskhash =3D calc=
_taskhash(a_data)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File ".../bitbake/lib/bb/siggen.py", l=
ine 1199, in calc_taskhash
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for dep in sigdata['runtas=
kdeps']:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~^^^^^^^^^^^^^^^
> > > =C2=A0=C2=A0=C2=A0 KeyError: 'runtaskdeps'
> > >=20
> > > To fix this, treat these entries as empty lists if they are not prese=
nt.
> > >=20
> > > Signed-off-by: Paul Barker <paul@pbarker.dev>
> > > ---
> > > Richard,
> > >=20
> > > This patch attempts to fix an issue reported on IRC last week [1]. It
> > > prevents the traceback, but I'll have to defer to you on whether the
> > > taskhash calculated without 'runtimedeps' and 'file_checksum_values' =
is
> > > meaningful.
> > >=20
> > > I guess an alternative approach would be to call calc_taskhash in a t=
ry
> > > block and not print out a task hash if the call fails.
> >=20
> > Rather than compute a hash which will never work, we should just skip
> > calculating/printing it or print something indicating it can't be
> > calculated. I've not looked into the details yet but I will at some
> > point unless someone beats me to it with a different patch.
>=20
> Is calc_taskhash likely to change in the forseeable future to depend on
> additional keys in sigdata? If not, we could just check for 'runtimedeps'=
 and
> 'file_checksum_values' in dump_sigfile before calling calc_taskhash and s=
ay
> "unable to compute task hash" if they're missing.
>=20
> I can send a v2 implementing that.

Potentially it can change but it wouldn't lose the runtimedeps so
keying off that is probably safe enough.

Cheers,

Richard

