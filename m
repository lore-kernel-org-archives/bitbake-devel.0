Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5FCC3600C
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 10:16:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.9976.1743675391805291534
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Apr 2025 03:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZXPp+TcV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso6549385e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Apr 2025 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743675390; x=1744280190; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjmtjLVEmEwHkZ3OvV+5l+0icHPfDtRyf90t8mJ/4+A=;
        b=ZXPp+TcVU179TIo+1DVB9iir75KJ8FHb2s/01VT+8YA1YuONL+1QPLtRWzAZdAuGxc
         rrfCVJiN9JaLvGo7AW0/Ae9+KnNxRfMuz0xjFh7rWpisDZSqjDrlaf/wpYu42mIwzp9b
         2q9NI6gCfZg4xPrGhSG3tyMAGzuTApoIR184U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743675390; x=1744280190;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EjmtjLVEmEwHkZ3OvV+5l+0icHPfDtRyf90t8mJ/4+A=;
        b=uFu5RPvbYYGwQYhyRnTn821AG+pEa9+nfFbJPANGqODoyhT8ELBJTY5vBwKVnD1eRg
         wHspzyOYPTdHIby38+PNNDUJrawPpk/jDA1J90Vp7DQCluA0pA0jNlNJ/C7iCJQEWs9M
         3kErv7IfCNdAPzo4/Y2/EmJ8nZZrSlQmMfr05/DerMMHHO5YrLDqeGfToQsdkqJtzM3B
         f3e3ufHNShX6jJZ2Jc7D5GPiXKJn9z4UWAybcPZvsifHkU9uzTkFpt7dIoNPVJyb76pv
         UNFDo3w1g+xS6B+7jVrQtNsHt5wrNuTVWp7dB/EmX6dbt4hD7lSlar3Pd5OCfKACBTIS
         enNg==
X-Forwarded-Encrypted: i=1; AJvYcCWJhUw3+w79mroGNUOz4vzhlIr/SvWQQ6UkKetnMp2hnBq9nvWeSxrDnOVrrUbnwWWzIuBmshTyyMc/3Gkh@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz8qYkoecbUnwtPEz5ZJl5zBGQKbGcnWNF7VurfYw7otyL3H5gf
	FQ9bHeV825uDrYjh/1ZHDA58nAqUQJXtVctTtEo0AjvdN0Tc2bFWsqR+2Bd19jGT1kxffV1vK3z
	w
X-Gm-Gg: ASbGncuODWp2en7Yt2bDeYAAFgZCaQaMBfNj+NDJ+z1EUAq3JjYNNEmquuayvr8pSWu
	AHkqkqpKl8/bcm0P4SfwzfswPZlcgOvxal+X7AXlCZ+KwxSW/sV2Q8Uiu5ALaJKh0ud5yx4Didl
	RM9XxlhQtRjaUqfdtEtckOPlTueNQmrm7t/WDw5Pv0aSt2jE0i7aoMSqwhOfkzWyPSa8KxSiY2T
	oqPUl1RI7uDTdgwGNKxyekNEDbcFZeHfqV48+7Wr6Pf6zbK4BsY/X2J7RghuQTlFHD47Uqv8qAB
	pWx7RH+hw5T8zI5dFqnFnA6CQoLUWjaI3UXH/xOs9tW+euCk0ij7H+qNn/U0RZhTcbQcFvMi3bP
	JDjbj0c3suyLq0yy07V/oaE9kdV4BjY1C2g==
X-Google-Smtp-Source: AGHT+IGEQUGvXCfCtVKmu9NQ6feZbYnhGbQ+ltLgjuRUdWz8Cz3bRm57K3NVumd7NON6Ll6B2mztYw==
X-Received: by 2002:a05:600c:5251:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-43db6248b91mr166786645e9.13.1743675390042;
        Thu, 03 Apr 2025 03:16:30 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4b5f:9de5:8de7:7270? ([2001:8b0:aba:5f3c:4b5f:9de5:8de7:7270])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea978378esm47864395e9.1.2025.04.03.03.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 03:16:28 -0700 (PDT)
Message-ID: <099af6f13b52e04d21e09ecf3e22c78671e9be4c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: fetch: Fix
 BB_FETCH_PREMIRRORONLY for git mirror tarballs
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: jhaller.oss@gmail.com, bitbake-devel@lists.openembedded.org
Date: Thu, 03 Apr 2025 11:16:28 +0100
In-Reply-To: <20250331102726.1965866-1-jhaller.oss@gmail.com>
References: <20250331102726.1965866-1-jhaller.oss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Apr 2025 10:16:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17512

On Mon, 2025-03-31 at 12:27 +0200, Julian Haller via lists.openembedded.org=
 wrote:
> From: Julian Haller <julian.haller@philips.com>
>=20
> When invoking the original git fetcher after downloading a mirror
> tarball, BB_FETCH_PREMIRRORONLY is ignored. This leads to git fetch
> commands targeting the upstream source being executed silently. Ensure
> setting BB_NO_NETWORK before invoking the original fetcher. While this
> was only observed for git, setting this in general for all fetcher
> types makes sense at this location.
> ---
> =C2=A0bitbake/lib/bb/fetch2/__init__.py | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
> index fed296097f..76f1440026 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1092,6 +1092,9 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D=
 False):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If that tarball is a l=
ocal file:// we need to provide a symlink to it
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dldir =3D ld.getVar("DL_=
DIR")
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if bb.utils.to_boolean(ld.get=
Var("BB_FETCH_PREMIRRORONLY")):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ld.se=
tVar("BB_NO_NETWORK", "1")
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if origud.mirrortarballs=
 and os.path.basename(ud.localpath) in origud.mirrortarballs and os.path.ba=
sename(ud.localpath) !=3D os.path.basename(origud.localpath):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
# Create donestamp in old format to avoid triggering a re-download
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if ud.donestamp:


This is nearly right but not quite. You need to ensure BB_NO_NETWORK
doesn't leak back into the parent datastore. If you had multiple urls
in SRC_URI, you'd see the network was potentially completely disabled
after the first url.

You'll see that in the try_mirrors() function which calls
try_mirror_url, there is a:

    ld =3D d.createCopy()

which is effectively how we can isolate datastores.

You code probably needs to look like:

        if bb.utils.to_boolean(ld.getVar("BB_FETCH_PREMIRRORONLY")):
            ld =3D ld.createCopy()
            ld.setVar("BB_NO_NETWORK", "1")

Cheers,

Richard


