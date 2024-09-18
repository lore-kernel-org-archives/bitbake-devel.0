Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE52CCD184
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 07:30:26 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.9927.1726644624371978705
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Sep 2024 00:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V5T9GB80;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374b9761eecso5206166f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726644622; x=1727249422; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QcCaGFJ8qgOeyfViflWSbrlQpH3N4RL8viEpj9f45+c=;
        b=V5T9GB80wWyD+KubJ2y4lPwfWn58KiElTmlxFtC5VOBEIMZvNG3OppzBqwtWH3SnYn
         l8RHAVHCnye+qbYhnWEfXInZ7qQUijpqQ8PW2msDd6emHHBVAa6dUqD/ecWzoAfqQHCu
         4iK/ObPmCL2Zu8Nsn3SP8Mv2+8pR5nNDf6yGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726644622; x=1727249422;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcCaGFJ8qgOeyfViflWSbrlQpH3N4RL8viEpj9f45+c=;
        b=pJmHe0DQFUp5eOg8k/iujRlHDzAwPX0KOY9oAC9HTQHk69zGBFavP2Yov23blWTAn/
         KKPPBKAiScmdylWt9FXyKmWppBMlSq/vYJMS77OaS6X07mO/7N4m2El2fNRmuXLb/fGw
         cUDdZnDhP7UFkCr6uZulURu/HkTgZzIKDhNPH3VmnT9iFa+k0qx+xhBYmU2kT+JuG3QK
         4nqs6dKo3/kPLv2+B7I0+pOArFbZraekDNXuu3Es5BAfJL4LOb/m/gC6SQfW8VFsqAfp
         dII/r1Crt6PTiQ7/iFVLhq7859FTq5C9ssUEZ+2MqOpASjV4oPtxfWnDUsHg/hlk8AYE
         /0HQ==
X-Gm-Message-State: AOJu0YzHMDiEfoed/mlLW/eBF7VxeC4FZDE27BrfYl+AfxHYl5BuAzyk
	il1O2w9EmP8zHwOIq95rxFvM81YIxFZ3CV3doCtoBbhAAmNmMkAPuf6n9wOFJL8=
X-Google-Smtp-Source: AGHT+IEKeSbrc4GjBvdZO49WpJf07WVqwzIG/0DiHsA0mjVdjOSTia5wlYfzG5CrE6A85HEKGZzlHg==
X-Received: by 2002:a5d:6788:0:b0:371:a844:d326 with SMTP id ffacd0b85a97d-378c2d4c9bbmr13307363f8f.43.1726644622299;
        Wed, 18 Sep 2024 00:30:22 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:84e0:f160:18f9:5089? ([2001:8b0:aba:5f3c:84e0:f160:18f9:5089])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7804476sm11597254f8f.90.2024.09.18.00.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 00:30:21 -0700 (PDT)
Message-ID: <6a74952e25ddc9b0aaf90571851b4802c574369f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: add documentation for
 "bitbake -S lockedsigs"
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Sep 2024 08:30:21 +0100
In-Reply-To: <CAEHHSvZigPQTmPwHP-vom2ybOXoXQm3NhCsUyFLW0n9H2t3VxA@mail.gmail.com>
References: <20240917151157.780068-1-jstephan@baylibre.com>
	 <b911e5bef3e661b976d6a5822e9fa2941d2e90d7.camel@linuxfoundation.org>
	 <CAEHHSvZigPQTmPwHP-vom2ybOXoXQm3NhCsUyFLW0n9H2t3VxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 07:30:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16569

On Wed, 2024-09-18 at 09:05 +0200, Julien Stephan wrote:
> Le mar. 17 sept. 2024 =C3=A0 22:55, Richard Purdie
> <richard.purdie@linuxfoundation.org> a =C3=A9crit :
> >=20
> > On Tue, 2024-09-17 at 17:11 +0200, Julien Stephan via
> > lists.openembedded.org wrote:
> > > The following commit added "lockedsigs" as new signature handler
> > > for the
> > > -S option of bitbake:
> > > =C2=A0=C2=A0=C2=A0 2cf13f25139 - lib/oe/sstatesig.py: dump locked.sig=
s.inc only
> > > when explicitly asked via -S lockedsigs
> > >=20
> > > But it was not documented anywhere, so add some basic
> > > documentation for
> > > it in both the .rst documentation files and the help message of
> > > bitbake
> > >=20
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > > =C2=A0.../bitbake-user-manual-execution.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++=
++
> > > =C2=A0.../bitbake-user-manual-intro.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 13
> > > +++++++++----
> > > =C2=A0bitbake/lib/bb/main.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12
> > > +++++++-----
> > > =C2=A03 files changed, 22 insertions(+), 9 deletions(-)
> >=20
> > Unfortunately I don't think this is quite so simple. The lockedsigs
> > support is implemented in OE-Core and BitBake doesn't contain that
> > code. This makes it very hard to accurately document since it is
> > metadata dependent.
> >=20
> > I do agree we need to improve this somehow, I just don't know how.
>=20
> Hi Richard,
>=20
> Maybe we should remove this from bitbake and implement it using
> bblock? :)
> Let me know if I can help on this!

That is a direction I've been wondering about and I think it would make
sense. It is one of the reasons I wanted to see the lock/unlock
commands become separate tools!

Cheers,

Richard



