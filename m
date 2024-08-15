Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDABC3DA7F
	for <webhook@archiver.kernel.org>; Thu, 15 Aug 2024 14:14:30 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.124125.1723731263061121094
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Aug 2024 07:14:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WUaOzR+z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428101fa30aso6514255e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Aug 2024 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723731261; x=1724336061; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fy0wRxHG0n0B74aU0ZQerSVhQ/w9aH6LxnvGm0fqEvE=;
        b=WUaOzR+z+qCb0n4MM4XnC2aQYAvzeH1wE9DhohsZJZYg8EiBTTKW7S8uqKIAmGRoVB
         rSG6J7k0wa3vBcoCPCFGaZiAvcr7dvOy2YApPMnIp/M3t4HTs4jSDitwq15kFL1VSjIt
         Lenhv+hynM/+jSpIxwIfrt7nuE8/QYSWkl87c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723731261; x=1724336061;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fy0wRxHG0n0B74aU0ZQerSVhQ/w9aH6LxnvGm0fqEvE=;
        b=u4EQatHCHkPWFDDXUdR3SvqPPa97MF6T5OKkAbFhAh5I88BhmdnVyg57PKD8ONxKPm
         /Ag57dbiVXKZSd0NqlA+reESyGVy97M4chKtS6moHR3qkxkUJgUpPVRFKXgHdPyAw5gA
         H3FdPXxL2VIo9sK6CTvlCMHi7JFksCTgsRgMAMylQ+hOsF+4sCb7zohynimGPFghIvqZ
         rexrYW95zqalyMMbkO3vhjas0oDnH9MVqKsVGdFLuLPlPWyc5TB7uKuDip9/E+gNv/wA
         SBY9FnVxPuZ+J9qELvLbbpOUgNM7LrbODMHHwJJohWHOht+cewn+DvBsjbM/x5U0qlXe
         rjdg==
X-Forwarded-Encrypted: i=1; AJvYcCX1DgwD/d+LYRoGAxjRAiNU3R+aZYr7G5Y43/de546iwUqjDAKBxC+uxT/mPUxIzO8xCRxJECZLG6t5K3nIwpSRM37iypTr3q6WAJ5aUQCzOny+uu0=
X-Gm-Message-State: AOJu0YwWXCR015C2lMLFta7ejArK1N19vzpnqaJoYa9YNNLj591gtQF1
	+AqvnCIUb2V1Sd9MyrKdPBG39cEYjlCdC/IN+p9mbfqIRVy5/Bf/6jPkvFQOf4s=
X-Google-Smtp-Source: AGHT+IHk1EnpDiHz+AGfh4fxSu9TJv/zdUWXHJceHHfcF2zcjrnMYRtuGDyQwf294TLB07Yy8McDzw==
X-Received: by 2002:a05:600c:4445:b0:425:7884:6b29 with SMTP id 5b1f17b1804b1-429dd23d181mr43640175e9.19.1723731261325;
        Thu, 15 Aug 2024 07:14:21 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2bbd:6430:deb7:a333? ([2001:8b0:aba:5f3c:2bbd:6430:deb7:a333])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7c03b71sm20755825e9.14.2024.08.15.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 07:14:20 -0700 (PDT)
Message-ID: <20cc37c9d00ac3cca4d6bbc9f45c6aeb6468acfd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v4 1/2] bitbake: fetch2: npmsw: fix
 fetching git revisions not on master
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enguerrand de Ribaucourt
 <enguerrand.de-ribaucourt@savoirfairelinux.com>, 
 bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com, alexandre.belloni@bootlin.com, 
	stefan.herbrechtsmeier@weidmueller.com
Date: Thu, 15 Aug 2024 15:14:20 +0100
In-Reply-To: <20240812122539.573337-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: 
	<20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240812122539.573337-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Aug 2024 14:14:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16490

On Mon, 2024-08-12 at 14:25 +0200, Enguerrand de Ribaucourt wrote:
> The NPM package.json documentation[1] states that git URLs may contain
> a commit-ish suffix to specify a specific revision. When running
> `npm install`, this revision will be looked for on any branch of the
> repository.
>=20
> The bitbake implementation however translates the URL stored in
> package.json into a git URL to be fetch by the bitbake git fetcher. The
> bitbake fetcher git.py, enforces the branch to be master by default. If
> the revision specified in the package.json is not on the master branch,
> the fetch will fail while the package.json is valid.
>=20
> To fix this, append the ";nobranch=3D1" suffix to the revision in the git
> URL to be fetched. This will make the bitbake git fetcher ignore the
> branch and respect the behavior of `npm install``.
>=20
> This can be tested with the following command:
> =C2=A0$ devtool add --npm-dev https://github.com/seapath/cockpit-cluster-=
dashboard.git=C2=A0-B version
> Which points to a project which has a package.json with a git URL:
> ```json
> =C2=A0 "devDependencies": {
> =C2=A0=C2=A0=C2=A0 "cockpit-repo": "git+https://github.com/cockpit-projec=
t/cockpit.git#d34cabacb8e5e1e028c7eea3d6e3b606d862b8ac"
> =C2=A0 }
> ```
> In this repo, the specified revision is on the "main" branch, which
> would fail without this fix.
>=20
> [1] https://docs.npmjs.com/cli/v10/configuring-npm/package-json#git-urls-=
as-dependencies
>=20
> Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
> Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/npmsw.py | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw=
.py
> index b55e885d7b..d8ed9df327 100644
> --- a/bitbake/lib/bb/fetch2/npmsw.py
> +++ b/bitbake/lib/bb/fetch2/npmsw.py
> @@ -184,6 +184,7 @@ class NpmShrinkWrap(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uri =3D URI("git://" + str(groups["url"]))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uri.params["protocol"] =3D str(groups["protocol"])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uri.params["rev"] =3D str(groups["rev"])
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uri.params["nobranch"] =3D "1"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uri.params["destsuffix"] =3D destsuffix
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 url =3D str(uri)

Is it possible to determine and add the branch name where needed?=C2=A0

I'd prefer to try and keep the behaviours similar in more cases if we
can and avoid disabling checks we added for good reasons...

Cheers,

Richard


