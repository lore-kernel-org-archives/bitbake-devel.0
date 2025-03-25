Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84286C35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 10:14:51 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.62009.1742897688225077254
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Mar 2025 03:14:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UxHNCHH+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso34641445e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742897686; x=1743502486; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u9426ZiFlxzwMy4ZOWhJMoDksptDGP1VPky3K+xtLZ8=;
        b=UxHNCHH+3EfdftvC9iAUE1lYN7UdfyXuka9/6uyvsEnQLCN5wXiJXdiZoX5fGELsDI
         QeJ2oy7lxzd5S96Rh0W0DmmvHfsjgxvnUI2MuTlpY9Qz9ZUSdKvQAGj6ZWtX7oZHqtcg
         IrQYQqD0WQDHwuuQY5hruXi1ohxGmQMs05hKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897686; x=1743502486;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9426ZiFlxzwMy4ZOWhJMoDksptDGP1VPky3K+xtLZ8=;
        b=oDOc0NQQ7xwHXAdKh4QPc7oCMtRfBlUwcaNr9cJZ2ZSFhQIZ/s8EveOFk9wLlaojuj
         7Fl15dsjxfGs1IOWWggVIygj+U7JW5UrmJZQCjYXil8RnloQcTDmjULA8TlJ9FfWi3z6
         Vjhd7gBbYxwYGFLcZ5LAm1AXf3HWlNO6vmpgNeqrFjKI6vaLzm4fbhCJl9rTNPzVVNzN
         TxjbBD14hyij+UQmpT2hAfIMkb8J6wS087Zg0ad8xL0x8PRSjiDG87Ub2OeYluhFfGDp
         7f1JpOxfNV5r0I9n0aHZy68GmBtycotCUMrzhyvJOjWZHymfTBzyKqcGKbtC+lJ3wN5a
         wrUg==
X-Forwarded-Encrypted: i=1; AJvYcCVmt9Hwxsm2nrSWDT10o5pdiFvzApUPnBgfihLUIjDshC1OHRZuDNQwUAWUU8HEYNRI8TC3OB6fqqhhwLY8@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx1bValGI9mNzfRB/zBEGD2eaYcsLd+7LGmEESoRcAl4ImZiZqu
	xbSrsPGsfra5A377nG8bmYXFNwUlI/gd7MS9SBHMpzslZiqjHYtQOGOtMkqze/k=
X-Gm-Gg: ASbGncuoqgvtTKQsWW5C7BGBfb8AnHW0qVycNxos7WohkR6+5Tms0XA1t3B4PqpitnX
	YeBu9bYCSGzESNlmC5G62XELQnywGNn3BzLNpRxtH1qqg6WRJgDYc5yO0+QAAumvwizq+GhGr4f
	H3xRpusRAhTWyHk0PTFGBeaOipc1zVgrq9kFD+W3WfP94UTLqxcPRhp6h7hQ19hqlaIKrU0wtxj
	xFfY4/xnGYSnWkCwsvyayljGM6TcGnbzexa691upwHlwH++V4sCfFVn9IfQu45yAhBrPUi2n5N9
	JebRHnpoID7yNUE3LZbT7RWNirhASwT9OKJB3NRtu+UWOmzxAdCsUirVOzzXk/6x2+l7xZKKTyh
	pKCuilCQPVcSHf7r29xThoql50tddH2JUPg==
X-Google-Smtp-Source: AGHT+IGH+gIzkU3vw9fYPXsJISeicn8zRoatMiUC6xLDsoSqE6aqBGwSArxmLB/KL80FX/WkGHhO/g==
X-Received: by 2002:a05:600c:1989:b0:43c:fc04:6d34 with SMTP id 5b1f17b1804b1-43d50a318aamr129964685e9.20.1742897686533;
        Tue, 25 Mar 2025 03:14:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:bd49:ef6e:5ada:f0b5? ([2001:8b0:aba:5f3c:bd49:ef6e:5ada:f0b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd187fasm148218085e9.14.2025.03.25.03.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:14:45 -0700 (PDT)
Message-ID: <7275d5d500666f6278ec7937ab15ceb10cdf4f58.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH] doc: Mention `if [[
 somecondition ]]` is not supported
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: quentin.schulz@cherry.de, javier.tia@linaro.org, 
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Mikko Rapeli <mikko.rapeli@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 25 Mar 2025 10:14:43 +0000
In-Reply-To: <0531cca3-683c-4ec3-853c-59da9492c8b6@cherry.de>
References: <20250320003358.977774-1-javier.tia@linaro.org>
	 <0531cca3-683c-4ec3-853c-59da9492c8b6@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 10:14:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17485

On Tue, 2025-03-25 at 11:04 +0100, Quentin Schulz via lists.yoctoproject.or=
g wrote:
>=20
>=20
> On 3/20/25 1:33 AM, Javier Tia via lists.openembedded.org wrote:
> > I keep forgetting using `if [[ somecondition ]]` is not supported.
> >=20
> > Signed-off-by: Javier Tia <javier.tia@linaro.org>
> > ---
> > =C2=A0 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 +++=
+
> > =C2=A0 1 file changed, 4 insertions(+)
> >=20
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b=
/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > index 415fbf6d6..5474e154f 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > @@ -1381,6 +1381,10 @@ To make use of this technique, you need the foll=
owing things in place:
> > =C2=A0=C2=A0=C2=A0=C2=A0 To call your modified version of the function =
as defined in your recipe,
> > =C2=A0=C2=A0=C2=A0=C2=A0 call it as ``do_foo``.
> > =C2=A0=20
> > +=C2=A0=C2=A0 .. note::
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Conditional expression using ``[[ somec=
ondition ]]`` is not supported.
> > +
>=20
> Do you know what the reason is for that limitation?
>=20
> The example above this git context is not really implying `[[=20
> somecondition ]]` would be valid though.
>=20
> If I remember correctly, the shell functions are run by /bin/sh=20
> interpreter, so it depends on which shell you have configured by default=
=20
> in your system. Is it possible this is due to you being used to develop=
=20
> with bash where this is possible and having your Yocto build run with a=
=20
> different shell (e.g. dash, which doesn't seem to support that? c.f.=20
> https://manned.org/dash.1)?
>=20
> I think we should recommend people write POSIX-compliant shell functions=
=20
> and tasks rather no?

Bitbake parses the shell functions and our shell parser can't cope with
certain syntax unfortunately.

Cheers,

Richard

