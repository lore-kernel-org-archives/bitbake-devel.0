Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8A4C282EC
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 11:19:32 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.10676.1741259967546441272
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Mar 2025 03:19:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UB1Gm3Pn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bcf9612f4so4362435e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741259966; x=1741864766; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rrAvXzm/dVfmrFiIe/GAniPie2g9whI7ec1pEbaxh8o=;
        b=UB1Gm3PnVGytVanzomcBgBQXfxc5hKjfehLSJzd3Eha0xvKVu79dvOYGym2s22d3mJ
         UB4wuojWhAQJOoEq8OOkaIA+Kcdy9qk5LfnqYEzjIFtX43bAmZQ54sc7ftaf1RjkL3e6
         MxHlS86U1fDOcufLyX+BL9rLBDfxbgjTD6qmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259966; x=1741864766;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrAvXzm/dVfmrFiIe/GAniPie2g9whI7ec1pEbaxh8o=;
        b=XlPaUTScnR0L60yhOma4crsGFNPwWvBheQt2kibAteXbimVP/CmHXMqpNQMUpUDWEC
         h1KbG3wHfnlLYcmTXDFexmtKZnMLqEN0Eaw0hPe2hoZIV0f4ijQOClt4x45qEQv3ZtXQ
         nGsSZQW3297LmV/rwXA1c6LBN+rzxK27dciquBo9H5qkGmitVeQe4EOQLWTmp7+CZVgj
         GiVk5aY0NHlVxFZz50NryzaTHoPEfrIrsFRvVnDkDDOt65n059WhSD0lvyLSHZZd5D7o
         3Mz1H+JQ805+3KrNK8+DeTsYLJL7ur1+HB8+V62gAFRct4/rf1H1PnjEqKTI0VLIF+o4
         yJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQPwizq13QqFTuYKrfDtdJ120msiUo7ke2GAjoEPcRy8fqoy/ZSbYvxhFbozAiE8/n0jrJkPoiiuYqT72b@lists.openembedded.org
X-Gm-Message-State: AOJu0YwWYZX6MOydb/Mdw8OIrS4FLnXyAdeCg/lSDXJ7aI56Wwmbv/ej
	sPJRmcQJ2GkwG91v31VGak6yp6S1r191H8slAX6Wae7YZLOHxmUPCOMhDU0VVvU=
X-Gm-Gg: ASbGncsEjFmSBOS0becXred/BxeOVL5NsrLKkFUJJpASSAElJmDLrBkhQGx5efcWe6R
	Gdnb5lx3PBRBovW+OiMEtsIgbXbu6UHUPvrMkymsnZ2W7liIyAThySy0N4NA/5DgFBzLRGIsQt2
	8QbqM0FbsCZnPgTMIFNkDKTBKk4cXrlVfasmY8pOwxHls5YL8fOSHCrUGAqxBJCJeYMfoGOONp0
	9stKKV8L/W2UkJ2BaYWrobmKx+k0dYFPAKOYz6xnoclfLXpXo7VpX9UokoHu2KCt4LFs/FubKTa
	YEoutedO3hNtoJReIqhc1j1lK0oXuIl4Kqnl0anF9owtXwBa7xkMsfJhluuwcRRASueKniFcuJS
	P+v6Th8H8+8oexICkxn2TBg8dT+1ZJ6E8rQ==
X-Google-Smtp-Source: AGHT+IGx5+KSqrwu5VPEmnKKXIIr5YLQoWWjzSJztZK0OAMND/euD9T651OjU4JzT3mn7bhnm1En5A==
X-Received: by 2002:a05:600c:3ba8:b0:43b:c0fa:f9dc with SMTP id 5b1f17b1804b1-43bd298f98fmr62561845e9.10.1741259965961;
        Thu, 06 Mar 2025 03:19:25 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e869:4c46:3bba:1ea9? ([2001:8b0:aba:5f3c:e869:4c46:3bba:1ea9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b03cesm17019455e9.7.2025.03.06.03.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:19:25 -0800 (PST)
Message-ID: <1cf2c489262d042eb0a4bde50b3fce44ba464f87.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/5] fetch2/wget: enable classes
 derived from Wget to set custom http headers
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: l.goehrs@pengutronix.de, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, yocto@pengutronix.de
Date: Thu, 06 Mar 2025 11:19:24 +0000
In-Reply-To: <20250227090853.1632280-2-l.goehrs@pengutronix.de>
References: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
	 <20250227090853.1632280-2-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 11:19:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17393

On Thu, 2025-02-27 at 10:08 +0100, Leonard G=C3=B6hrs via lists.openembedde=
d.org wrote:
> This allows derived fetchers to e.g. set a `Authorization: Bearer ...`
> header for token based authentication, or `Accept:` headers to restrict
> which file type the fetcher expects.
>=20
> Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> ---
> =C2=A0lib/bb/fetch2/__init__.py | 1 +
> =C2=A0lib/bb/fetch2/wget.py=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++++++
> =C2=A02 files changed, 9 insertions(+)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 93fe012ec..06d4fd011 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1272,6 +1272,7 @@ class FetchData(object):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.basename =3D None
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.basepath =3D None
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (self.type, self.host, s=
elf.path, self.user, self.pswd, self.parm) =3D decodeurl(d.expand(url))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.headers =3D None
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.date =3D self.getSR=
CDate(d)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.url =3D url
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not self.user and "us=
er" in self.parm:

I think I'd prefer to call this http_headers and not set a default as
it is specific to the wget fetcher only.

> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index 6cb728ab4..fdf1f2860 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -121,6 +121,10 @@ class Wget(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # Authorization header.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd +=3D " --user=3D%s --password=3D%s" % (ud=
.user, ud.pswd)
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.headers:

If use hasattr() here you don't need the default above.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for k=
ey, value in ud.headers.items():
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fetchcmd +=3D " --header=3D'%s: %s'" % (key, value)
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uri =3D ud.url.split(";"=
)[0]

Cheers,

Richard

