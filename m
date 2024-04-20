Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01224C4345F
	for <webhook@archiver.kernel.org>; Sat, 20 Apr 2024 20:45:49 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.20056.1713645948952375831
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Apr 2024 13:45:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IM3VGvgx;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ae315bb20so955196e87.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 20 Apr 2024 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713645947; x=1714250747; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weayKlo7CdxpbtGlahSH4LcSSTCRdPVgmqTyTPYcnUA=;
        b=IM3VGvgx9mUFhjO0WC4iGWbQCNQrOXQGOHeglk2fvLXLHIbHbg6OdP4r+K6MGULwon
         k90KlGGdVPXTkZylqVHsH1VvXaUv5W5oioJubkkXOeuNKmnY1RqIERpbpFtkBC3M5pHr
         HXBo6ytfQmiaMvRdfU4olXnTn9hkbKbwadCAmWOB6KOEpyrO/euth/RK6E/Lw9MpHEw+
         qSq2NmEMOi9XpU9NGUErSPriipyW8qvfc9L49u8/tijnNocjkyLaOcGqkg5uiFYuDRbP
         E1F4+hze4fs5RuHZEKwzB5HnYqzVPD/peOAv6UhmxrZ6IZvZuvMRbXwFQBpYThmTkQsG
         gf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713645947; x=1714250747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weayKlo7CdxpbtGlahSH4LcSSTCRdPVgmqTyTPYcnUA=;
        b=uvI+jV2FxGtEPrkiNnRRnt7WjZYRgdkAdvLFxg/Ri2Em/VDsjXYMjxqIoddBE+Iiji
         kd9gX6Oe45l55Q8wTZHfLTva0UrLmjOERVH78HoNNmDBJjhcorkU8OeYBd9BFn20gbdq
         hvnvm3nJttK9rxjHsBbKJTo+sQimpDFghbQWM24fkYwgKfF/R520nIMgUNDz1Wjvj6TO
         DiYnNPcDchCyY0vT08ZRIUjIb8TFynkrAL7OhLOqSz+b/3qAtSIhRhPfPsrRIE8zD+Bt
         MmZ9/V4XuzAA9Ycg8UHi5zrSgoy0aCgaPEfVruyIurTjrm1xpnWgMhSq+eauCNX6oieV
         lSCw==
X-Gm-Message-State: AOJu0Yzic2JrGFu1dxE1OBqTiR2kNjQtwDoWE6WNGIsrHD3dQu0frJwU
	HAwFZS7fpqLEsOTjGAYA8ThH9MZjKvuglmjdEgEmMmgyGT6s1wTECtHcQHGY/R27g1DFXQt/lTN
	RRd5ROD5mYV1gs9wVPdR4p18YZyc=
X-Google-Smtp-Source: AGHT+IGWGF9JuaFdtLDMMyOvh3HFRG7R/NoSXre3r/1YAPYaRQuRYvXpW/BRkgA8hUKOzRIuJXKe9z63yX8ssnCoxIA=
X-Received: by 2002:ac2:43ad:0:b0:515:cedb:a518 with SMTP id
 t13-20020ac243ad000000b00515cedba518mr3201525lfl.16.1713645946919; Sat, 20
 Apr 2024 13:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240416171945.3799445-1-michael.opdenacker@bootlin.com> <20240416171945.3799445-3-michael.opdenacker@bootlin.com>
In-Reply-To: <20240416171945.3799445-3-michael.opdenacker@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Sat, 20 Apr 2024 15:45:35 -0500
Message-ID: <CAJdd5GaYY4+jp34H+_BJ2gACA0eg5nog34JdDfy9nnhKVJRkGg@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] prserv: add "history" argument to "get-pr" request
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tim Orling <ticotimo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 20 Apr 2024 20:45:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16117

On Tue, Apr 16, 2024 at 12:20=E2=80=AFPM <michael.opdenacker@bootlin.com> w=
rote:
>
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> This makes it possible to test the "history" mode in the
> future bitbake selftests, to make sure that both "history"
> and "no history" modes work as expected.

Is this useful in normal day-to-day usage? I don't generally like to
add functionality just for testing if it can be helped, as the closer
you can get to actual end user API calls, the better it covers the end
user experience.

It looks like PRData has an (unused) argument to enable history mode?
If this is unused do we even actually care about it at all? Maybe it
would be better to remove an unused feature than try to test it?

>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Tim Orling <ticotimo@gmail.com>
> ---
>  lib/prserv/client.py |  4 ++--
>  lib/prserv/db.py     | 16 ++++++++--------
>  lib/prserv/serv.py   |  5 +++--
>  3 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/lib/prserv/client.py b/lib/prserv/client.py
> index 89760b6f74..389172f055 100644
> --- a/lib/prserv/client.py
> +++ b/lib/prserv/client.py
> @@ -14,9 +14,9 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
>      def __init__(self):
>          super().__init__("PRSERVICE", "1.0", logger)
>
> -    async def getPR(self, version, pkgarch, checksum):
> +    async def getPR(self, version, pkgarch, checksum, history=3DFalse):
>          response =3D await self.invoke(
> -            {"get-pr": {"version": version, "pkgarch": pkgarch, "checksu=
m": checksum}}
> +            {"get-pr": {"version": version, "pkgarch": pkgarch, "checksu=
m": checksum, "history": history}}
>          )
>          if response:
>              return response["value"]
> diff --git a/lib/prserv/db.py b/lib/prserv/db.py
> index 8305238f7a..d41b781622 100644
> --- a/lib/prserv/db.py
> +++ b/lib/prserv/db.py
> @@ -163,7 +163,7 @@ class PRTable(object):
>
>          self.dirty =3D True
>
> -    def _get_value(self, version, pkgarch, checksum):
> +    def _get_value(self, version, pkgarch, checksum, history):
>
>          max_value =3D self.find_max_value(version, pkgarch)
>
> @@ -177,7 +177,11 @@ class PRTable(object):
>              # version, pkgarch found but not checksum. Create a new valu=
e from the maximum one
>              return increase_revision(max_value)
>
> -        if self.nohist:
> +        if history:
> +            # "history" mode: we found an existing value. We can return =
it
> +            # whether it's the maximum one or not.
> +            return value
> +        else:
>              # "no-history" mode: only return a value if that's the maxim=
um one for
>              # the version and architecture, otherwise create a new one.
>              # This means that the value cannot decrement.
> @@ -185,13 +189,9 @@ class PRTable(object):
>                  return value
>              else:
>                  return increase_revision(max_value)
> -        else:
> -            # "hist" mode: we found an existing value. We can return it
> -            # whether it's the maximum one or not.
> -            return value
>
> -    def get_value(self, version, pkgarch, checksum):
> -        value =3D self._get_value(version, pkgarch, checksum)
> +    def get_value(self, version, pkgarch, checksum, history):
> +        value =3D self._get_value(version, pkgarch, checksum, history)
>          self.store_value(version, pkgarch, checksum, value)
>          return value
>
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 9e07a34445..f692d050b8 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -76,9 +76,10 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection=
):
>          version =3D request["version"]
>          pkgarch =3D request["pkgarch"]
>          checksum =3D request["checksum"]
> +        history =3D request["history"]
>
>          if self.upstream_client is None:
> -            value =3D self.server.table.get_value(version, pkgarch, chec=
ksum)
> +            value =3D self.server.table.get_value(version, pkgarch, chec=
ksum, history)
>              return {"value": value}
>
>          # We have an upstream server.
> @@ -105,7 +106,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnectio=
n):
>              # The package is not known upstream, must be a local-only pa=
ckage
>              # Let's compute the PR number using the local-only method
>
> -            value =3D self.server.table.get_value(version, pkgarch, chec=
ksum)
> +            value =3D self.server.table.get_value(version, pkgarch, chec=
ksum, history)
>              return {"value": value}
>
>          # The package is known upstream, let's ask the upstream server
> --
> 2.34.1
>

