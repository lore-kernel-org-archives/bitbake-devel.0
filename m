Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1103FE7718B
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 09:32:27 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.5106.1735810339769453038
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 01:32:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L2XdCOmY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4362f61757fso111497375e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 01:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735810337; x=1736415137; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ih0qyBFPIvxacAqbwBJF7sFrInYzVG90geMyN9wO6PU=;
        b=L2XdCOmYOZZSTrRDMYosC5Du1ohBqmdhpexb9vgsSn5+Pb98C4YKMlxMV3WHZEzHAQ
         1jHnA/onvEQGBWi4LH60KLS3rmy51lW+fZVhD1xfHhfXLLYWOA2WfYNIffOoWU1aOihk
         6aEch2/g70tMcWkcQeAa4ZSdtlFknw9HLT1Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735810337; x=1736415137;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ih0qyBFPIvxacAqbwBJF7sFrInYzVG90geMyN9wO6PU=;
        b=HFHvzwNPkG+M/7ZqopVDzrKWTWxFaQgkMyD4Oq+74jPd9PEw8XCjuJQYyrXTKiL8si
         PWXgHyp8GvPYQuc5BNTDd+4fD7SdrU11LfEgZpADTzb3r6bAzR9iabR+4L7gMp3qOn8a
         CK56+ZwTG5eB8mxKQN3Do/0O/UDaGvToDpuyv5I+T2MxTMla0HfSZGRPS4vHRDXiX4v9
         NTFfxUENytU8U99zIkAUQUhrX0tjvNUrt1pKCvKNN3+jlKyIx0/h0ItwpvUt6CkFe3BE
         PGuK/NveAxNX2QsUy0HZgb8H7RMyyW0Fh+z5CJV0iN0Hq5+ZcQ9RHJxZJBG2xbOW8OMZ
         RE3g==
X-Forwarded-Encrypted: i=1; AJvYcCVgkaGC4g811QrrnVxzipDwlyKNmDaM0bTA4qgmT0eDyAMdNau1Q4arINzA6cXmrkrYmfFIwT8QSOD/K0a9@lists.openembedded.org
X-Gm-Message-State: AOJu0YzDB3bQ4KrFnXLeqMbYmQxq4GpuIogZMbkwqk86Cw1YZQHHLIBd
	T24OYukWxxU1kLdIERJHDcAGeZuzLAi/Cg2UCwvkAj4lbGtdc5UcnQM17IICfDY=
X-Gm-Gg: ASbGncsfUQl/45B7ArrAQee0nQdN3+ZQt6c7QDX3U/A6fWTg9Y8pIxLrz6EQmPkPaJY
	ZUeoI32qd2R4iPC5yXiKGgwD/YvlMdFMmGSN3fGx9n708BCmVsLft21KrOYAozQRM9eI14b2qwZ
	jI0S/vkSL3SEeEMJRsbRyJjhBw0qnLSLCI/0vGIdRIFxdPyZ/w0rJQf448LZc4oar850foizim1
	8uB7JKP7Jcv/qZ9DELJVXm0ffcpZ0G7/rkKaqXyKPBFq+cL9DrDRg3k7ylN88kano0WR8dCuG5c
	iPL4HmIW0ogO+cF9J+MJf61JRkFUSis2Rb3hSAkcJydHcQ==
X-Google-Smtp-Source: AGHT+IG5afr2BnaYMJtcGZzEMKC9zXWRd1+IuityA0iCIPgSpuGmj9X0DiGbR2loFV2D70JDFYIHrA==
X-Received: by 2002:a05:600c:45c6:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-43668b4808fmr343991845e9.23.1735810337407;
        Thu, 02 Jan 2025 01:32:17 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ae2e:9f02:55c2:739d? ([2001:8b0:aba:5f3c:ae2e:9f02:55c2:739d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366120088esm444538075e9.13.2025.01.02.01.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 01:32:16 -0800 (PST)
Message-ID: <7fcc6a2d93e0535c8c79c60ae302ca92e322fd4a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Thu, 02 Jan 2025 09:32:14 +0000
In-Reply-To: <347682f4-d1ce-4f8b-9665-3a3490235d1e@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
	 <347682f4-d1ce-4f8b-9665-3a3490235d1e@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 09:32:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16956

On Thu, 2025-01-02 at 09:55 +0100, Stefan Herbrechtsmeier wrote:
> Am 23.12.2024 um 11:03 schrieb Richard Purdie via lists.openembedded.org:
> > On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.ope=
nembedded.org wrote:
> > > From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
> > >=20
> > > The patch series improves the fetcher support for tightly coupled
> > > package manager (npm, go and cargo). It adds support for embedded
> > > dependency fetcher via a common dependency mixin. The patch series
> > > reworks the npm-shrinkwrap.json (package-lock.json) support and adds =
a
> > > fetcher for go.sum and cargo.lock files. The dependency mixin contain=
s
> > > two stages. The first stage locates a local specification file or
> > > fetches an archive or git repository with a specification file. The
> > > second stage resolves the dependency URLs from the specification file
> > > and fetches the dependencies.
> > >=20
> > > SRC_URI =3D "<type>://npm-shrinkwrap.json"
> > > SRC_URI =3D "<type>+http://example.com/=C2=A0npm-shrinkwrap.json"
> > > SRC_URI =3D "<type>+http://example.com/${BP}.tar.gz;striplevel=3D1;su=
bdir=3D${BP}"
> > > SRC_URI =3D "<type>+git://example.com/${BPN}.git;protocol=3Dhttps"
> > >=20
> > > Additionally, the patch series reworks the npm fetcher to work withou=
t a
> > > npm binary and external package repository. It adds support for a com=
mon
> > > dependency name and version schema to integrate the dependencies into
> > > the SBOM.
> > This certainly sounds promising, thanks for working on it. It will take
> > me a bit of time to digest the changes.
> >=20
> > A while back I was asked to document the constraints the fetchers
> > operate within and I documented this here:
> >=20
> > https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/fetch2/README
> >=20
> > Would you be able to check if this work meets the criteria set out
> > there and if not, what the differences are?
>=20
> The fetchers inheritance existing fetchers and reuse existent=20
> functionality. The npm fetcher inheritance the wget fetcher and only=20
> override the urldata_init and latest_versionstring function. The=20
> reworked urldata_init=C2=A0 function preprocess the url and works without=
=20
> internet access. The dependency mixin is inspired by the gitsm fetcher.=
=20
> The cargolock, gosum and npmsw fetcher inherit the local, wget and git=
=20
> fetcher. They forward the function calls to the parent class, process
> the dependency specification file and handle the dependencies if needed.=
=20
> Thereby the content of the specification file is translated into source=
=20
> urls for existing fetchers and saved inside a proxy object. The user has=
=20
> to call the download function to download the main source with=20
> specification file and all dependencies. The dependencies are downloaded=
=20
> via existing fetchers.
>=20
> Because of the reuse of existing fetchers all criteria should be=20
> satisfied by the new fetcher or need to be fixed inside the existing=20
> fetchers.

Even if you forward everything to the parent API, there are ways you
could use it such that the parent class meets the criteria but the
dervived one does not. I'm trying to aid the review process by asking
those questions, it will just take longer if I have to work this out
myself.

The other question I'm wondering about is compatibility and how we
change the way urls are working. Do these changes need a flag day where
recipes need to be updated to match? If so, how do we best handle that?
Is the user going to get errors they can easily fix or how is that
going to work?

Cheers,

Richard


