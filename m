Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02FDCCFA05
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 11:44:30 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9399.1762515863539938617
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 03:44:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Mv8IdxcE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so440655f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 03:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762515862; x=1763120662; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NfMy5ChJuMjMSoYOIogjZLv68f1dPevFnC0ivEDQEpw=;
        b=Mv8IdxcEZjatR5iuSAZKGbH+J+24KzUdNOzkGL3fTJmpokU+veOflGSiO39uIg2eo0
         FTPBI7TCPVwKL2u+qx7k4qXrGR9tSuqsS1GrRt3ogh6HE9IpEcHFf0YHUS/Xka2qadOb
         vf6z2oHGGfFJdE9phdnDWX/3GfXYS42SD5rxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515862; x=1763120662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfMy5ChJuMjMSoYOIogjZLv68f1dPevFnC0ivEDQEpw=;
        b=Y+FwyerCp7BJ3LZp8DZMBUWiIoOabC/rRF64eR2Rr6NvafwJTG3BkxvNMmIIriYPnr
         mfZvC78YynkDYnxjT/OHt23qsK2zoqPJAsUes7cxanZ4XGlNRv5Y8QsIQOK7twmlq++5
         6/DRegpiYuwJ/IqqFJ8UFFyFx1R9X8leNmUkI8lWd3xlfY4H/QoJMZcntwhLYlql+5vS
         nLGKLFYW41470inrmC5/zWCVyrclBP15cnePQppZSqQEE6Ng4urMn1gNQRCdUjIYPeal
         4awlX0UELLE3tL+RgDtYTNpUmeOT0ghQa6irvNj3oowKQxKidzK+KKLVxTr5xm6PKZJB
         5VwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj8M+s5wYsK4Ayg4K150KZ2ffwAJaujk/SARE9DmmNEj0B7hAdjPYU0+gPzTVNqGPVK36ZRUy0q8eAQjjn@lists.openembedded.org
X-Gm-Message-State: AOJu0YwCfbKJ6zVawLudqRI6UfXNRF0ew5HFxG2hGP+CILHQz+SWgKpJ
	MOjj3clsbxNUAdyOk89JW9yIYwyqyGNU4JkuTVQn/A8/90Xo/ikFlx4ebFl/HHUsZ3k=
X-Gm-Gg: ASbGncsRa6rq+ELRrutI45coEPa6vm48oL/MKq6qq5LkKac9QZglwdB0DICrVwofZfA
	0GIAKIrfNgef0NbiNEJr0eG2QwVXl+Vj2hCd3GhvR4nVMlavGdLV265W9s8SLq5OCp+pJOkHMac
	yMHoRn/F/pqkxEaKWtwf6flbILKFfw3iJfKb6+lW5P4MImi/9vMJU/9HRNNUVOw9lqEaUi2ME2v
	Z2r3/cM1UZyV0mv6bYciv6+KL5J6xw+QUkJHshgKamww90hYO1z4583u4ASaFtdiZchnlVn9xNt
	lCuw5FT25f2PduJrqUHXtU1aTECRJIccLjoUuI1V0+3/cLh4KMiYW0E+17iQ065gsW5jHOnAswQ
	Pgq3oR1x3fG/r9/XeoaH+fiD9UfzUqDi1R1ixnpbQ+jAhO7Iub1d1f8ahlVXn+mec4/6TNZ+wse
	iHwEx0qsiEVT2ozPINwPF3CXk7hbB4uG0NOfCugyBukxLMbsGVvgmMmtadhd5egT/y
X-Google-Smtp-Source: AGHT+IH4IttWG8pTKXAyUpfVeg5IgoJZqrAR8jc7Uu0+8Z0ZgJBWPtG5ZKU9skGGrUZtkywrKTFhcA==
X-Received: by 2002:a05:6000:4305:b0:429:bc93:9d8a with SMTP id ffacd0b85a97d-42ae5afbb0amr2190849f8f.37.1762515861897;
        Fri, 07 Nov 2025 03:44:21 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09? ([2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679030esm4681941f8f.37.2025.11.07.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:44:21 -0800 (PST)
Message-ID: <e12005baac32b9cc5ca13b79a66b54584060bb84.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack sources (e.g.
 layers and bitbake) into 'sources' rather than 'layers'
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 "alex.kanavin@gmail.com"
	 <alex.kanavin@gmail.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Fri, 07 Nov 2025 11:44:20 +0000
In-Reply-To: <DB5PR02MB1021360A5C5B050606199CD02EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20251107080026.2599821-1-alex.kanavin@gmail.com>
		 <20251107080026.2599821-2-alex.kanavin@gmail.com>
	 <13179deb9c814179d00e7bcd125c3999399c5819.camel@linuxfoundation.org>
	 <DB5PR02MB1021360A5C5B050606199CD02EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 11:44:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18310

On Fri, 2025-11-07 at 11:07 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org=C2=A0<bitbake-devel@lists.op=
enembedded.org> On Behalf Of Richard Purdie via lists.openembedded.org
> > Sent: den 7 november 2025 10:49
> > To: alex.kanavin@gmail.com; bitbake-devel@lists.openembedded.org
> > Cc: Alexander Kanavin <alex@linutronix.de>
> > Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: unpack sources =
(e.g. layers and bitbake) into 'sources' rather than 'layers'
> >=20
> > On Fri, 2025-11-07 at 09:00 +0100, Alexander Kanavin via lists.openembe=
dded.org wrote:
> > > From: Alexander Kanavin <alex@linutronix.de>
> > >=20
> > > 'layers' is not a good directory name, as it contains bitbake, or rep=
ositories
> > > that can contain multiple layers or no layers at all (e.g. yocto-docs=
).
> > >=20
> > > While there's a chance, let's name it right: 'sources'. This aligns n=
icely
> > > with both the 'sources' property in the json configs, and oe-core's u=
npack dir
> > > which also 'sources'.
> >=20
> > I'm afraid I strongly disagree with this change. Whilst "layers" isn't
> > ideal, to me "sources" is worse since it implies source code and the
> > general downloads. It is all too easy to think this is going to be a
> > downloads cache directory of some kind, or where S might get unpacked,
> > and so on.
> >=20
> > From that standpoint "repositories" would be a more fitting description
>=20
> In our setup, I have called the corresponding directory 'repos'.
>=20
> > but I think "layers" is reasonable.
>=20
> Please don't call it 'layers'.

It is already called layers and has been in the patches for months.


>  To me, a directory called 'layers' should=20
> be used for individual layers, e.g., meta, meta-oe, meta-virtualization,=
=20
> etc, whereas this directory contains full repositories, which may each be=
=20
> a single layer, a collection of layers, or may contain something not=20
> layer-related at all, e.g., documentation. I have some ideas for the=20
> future, and can see a use case for a 'layers' directory, which would then=
=20
> typically contain symbolic links to the individual layer directories=20
> somewhere within the 'repos' directory.

At this point that ship has sailed.

> > > Then the setup directory contains:
> > >=20
> > > - build (bitbake's build directory)
> > > - config (bitbake-setup's configuration data under version control)
> > > - sources (everything that was fetched and unpacked)
> >=20
> > so the linux kernel?
> >=20
> > I say that tongue in cheek but it illustrates my point, new users will
> > not understand that.
>=20
> And I think they will even less understand why a directory called 'layers=
'=20
> contains bitbake and the documentation. I believe 'repos' (or the longer=
=20
> 'repositories') would be the best option.

I disagree, quite strongly and I don't really want to open this for
discussion. That should have happened months ago.

Cheers,

Richard

