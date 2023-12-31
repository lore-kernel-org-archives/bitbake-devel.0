Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7A3C3DA6E
	for <webhook@archiver.kernel.org>; Sun, 31 Dec 2023 10:55:43 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.217898.1704020140989324376
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 Dec 2023 02:55:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iTTThOlA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d87ecf579so1605435e9.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 02:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704020139; x=1704624939; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TImjjmi387IDH9/R9zyinJ2ysNkNsetF/wZTL8+7fvI=;
        b=iTTThOlAgRhPlJhTFSkTpzfppuLrMvWU3okQTcJmEwCqX0ifY9TAmQOtwu9tFLc4a8
         m3R2B6NgsNmwkOo5QcaxkS8fo5V7N/+xu9taddvW7JuLu+e83Nnipu9snAYCB0DXz5na
         Kwg+qh/ZvBn8kn6zWprUjl8GlOV1ZsK13Q/Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704020139; x=1704624939;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TImjjmi387IDH9/R9zyinJ2ysNkNsetF/wZTL8+7fvI=;
        b=hHM2GEcoKEemAh+tnFTmJVbVvpYzNaqXHJhUgWT749HJ0gCY3ur5U5hMBXWmRsyxog
         imEVmd3/iFdCQFLgLSfIn+Apd2Vd6aBPZTAhcOV5+Zk+tuc0YYL7HKsLUEvHUbJ2J/DG
         bALquc6OCV0vhz4cC2SA3+ye+UMFH4f4ZX1WFnLc/i/JVf4VKQp+lc+dQB497E9zb68W
         qrNRKgarHAegEq2V+MqAWsF5FN6crQ3+4VrBQyOCt6nMHCT7/k/GVLCWjI4eJEXRzziS
         tN2oApx0MIn4nn5oAQvORCslweN078dv7PCQbpskS2KcMngE2LNotcZTlXx6XUNfERFT
         ggxw==
X-Gm-Message-State: AOJu0Yy1TQQKjYt4ZOD/DOL7cMd5ChcW13TaL3rnWjogqlFjz4pjr953
	AbBNGEojYGmVIgeZD419TLXVleWeoszFQw==
X-Google-Smtp-Source: AGHT+IE5HOjsf/i0kz4ND3wbLFyL056J/mrB/1s9Rpkh5L3u9l7LEXdjT7pXYLsej8gxHXbnRhfv5g==
X-Received: by 2002:a05:600c:1f17:b0:40d:87d0:a309 with SMTP id bd23-20020a05600c1f1700b0040d87d0a309mr161968wmb.154.1704020138977;
        Sun, 31 Dec 2023 02:55:38 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:c5f8:2676:155:a895? ([2001:8b0:aba:5f3c:c5f8:2676:155:a895])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b0040d724896cbsm9319732wmo.18.2023.12.31.02.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 02:55:38 -0800 (PST)
Message-ID: <367694c117d8ee8e0f253d592bd36122e0b4e47d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] fetch2/crate: Unpack into
 CARGO_VENDORING_DIRECTORY
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex Kiernan <alex.kiernan@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 31 Dec 2023 10:55:37 +0000
In-Reply-To: <20231230154843.8086-1-alex.kiernan@gmail.com>
References: <20231230154843.8086-1-alex.kiernan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 10:55:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15734

On Sat, 2023-12-30 at 15:48 +0000, Alex Kiernan wrote:
> The vendor directory is set in cargo_common, to work with rust 1.75.0 we
> need to change the location, so use CARGO_VENDORING_DIRECTORY here.
> Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
> ---
> Is this change allowed, or am I coupling repos in a bad way and should
> hardcode `registry/src` (which is what I need it to be) here instead?
>=20
>  bitbake/lib/bb/fetch2/crate.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/crate.py b/bitbake/lib/bb/fetch2/crate=
.py
> index 01d49435c3e8..06963294ef35 100644
> --- a/bitbake/lib/bb/fetch2/crate.py
> +++ b/bitbake/lib/bb/fetch2/crate.py
> @@ -23,8 +23,8 @@ class Crate(Wget):
> =20
>      """Class to fetch crates via wget"""
> =20
> -    def _cargo_bitbake_path(self, rootdir):
> -        return os.path.join(rootdir, "cargo_home", "bitbake")
> +    def _cargo_bitbake_path(self, d):
> +        return d.getVar('CARGO_VENDORING_DIRECTORY')
> =20
>      def supports(self, ud, d):
>          """
> @@ -103,7 +103,7 @@ class Crate(Wget):
>              cmd =3D "tar -xz --no-same-owner -f %s" % thefile
>              ud.unpack_tracer.unpack("crate-extract", rootdir)
>          else:
> -            cargo_bitbake =3D self._cargo_bitbake_path(rootdir)
> +            cargo_bitbake =3D self._cargo_bitbake_path(d)
>              ud.unpack_tracer.unpack("cargo-extract", cargo_bitbake)
> =20
>              cmd =3D "tar -xz --no-same-owner -f %s -C %s" % (thefile, ca=
rgo_bitbake)
> @@ -134,7 +134,7 @@ class Crate(Wget):
>          # if we have metadata to write out..
>          if len(metadata) > 0:
>              cratepath =3D os.path.splitext(os.path.basename(thefile))[0]
> -            bbpath =3D self._cargo_bitbake_path(rootdir)
> +            bbpath =3D self._cargo_bitbake_path(d)
>              mdfile =3D '.cargo-checksum.json'
>              mdpath =3D os.path.join(bbpath, cratepath, mdfile)
>              with open(mdpath, "w") as f:

FWIW this also breaks bitbake-selftest:

https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/6261/step=
s/11/logs/stdio

Cheers,

Richard

