Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A97C02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 10:34:17 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.9092.1738751651035124893
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Feb 2025 02:34:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e9YhahlW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38daf1f5091so777981f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 02:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738751649; x=1739356449; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mTBW/GNutCoYnNV1GxTM1Wgs2xXGW5E8IL8kzi6u+oM=;
        b=e9YhahlWVYP7QQrMkgWVb+YT1vfzH/vw8k4dFUG8ki0B1UTeyJLhBrvV5Tj99L1T0s
         pv4+2isLuwuAZ8WU2AJFVD153iKHKYAjMtdOf0WwIi6ua/m4m6JvaeIWqclh1pKfHFTQ
         UI5oHC1LQwUnXUtjKNS8AdTK15Jo9Qq4RfhZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738751649; x=1739356449;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTBW/GNutCoYnNV1GxTM1Wgs2xXGW5E8IL8kzi6u+oM=;
        b=dpVQI5/KoV3DKQYdq1ZZRePksvVZPZ0mIuIthDZ76FxhqRIgjwIS8qxZlqijG0UkO+
         Aqyt0UT2sZUvu1E2w5hQ0Vbkep2G3mOOtspUxPeetwyMBiGnRL2TS7LDHo6bsLIcxyH3
         dXOSirs6NTX3WcfjrkPi0vBysBHLnmOmNUZkhAe3mTNAdagW8mTjhaDasH+KNkfcb2IT
         8B0JEOjtHE0bGMEMFEbaQbYXfh311/LipCtiB0iF6l9ei+J2CJ0buQQtGv5F6dwgQgUV
         RcPAM6UVLN+Z0yv+NT+QuMfEEZ39tBQsdNfB73cTBJxLMhZ5fiTMEImaBI8Ysteh12aS
         P5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV8ReqKtz5oqz/ulzvSRMZlzqXh2NnOS3RhAHAHCB5hSFkkH/d3sg/4cZzubKGUWCsjC+uSUr1laZZf7GKU@lists.openembedded.org
X-Gm-Message-State: AOJu0YwnnpCEXeOu4VEQ25qHHBy+YrBL0RQuOgLfjFHa+N9aCi9npmvl
	ZtjslUo+Ef6Qs6ddnoPuKd+SDTula/cptuPY9z2RGbep+qNFmzxu+m0ZSkf7Mcs=
X-Gm-Gg: ASbGnct1ERQkzNFMuVJyHooX6aoTE5rAU+J67CNVTxbZZWIxRo8DgBJNmqaLr4NkthY
	dPmffUmbFnOe8gQfhSv9MvsIyQNnRbMP8Uv3VMJq4rWhS/OIhGQWnph8R2JYnL4iLrQ5oewE2n2
	nOxWUX4lweI8Qn/M+5l52fX7EWZrmuyok0gVc5sOt4c88t+SWWLucxQyuaNzl4Ux6xPHukh96/s
	DKkNttjU4Rh3DGTauq0TaNQ902kFIJEo+TSfQJFC8S3zom0DTbFijwUFr6BdCNQKKgmNB3prT9Q
	WwtZV+sRr7dzECWJyRlKA1nHZt/0ChmPDSMk0oqRo/dbTlHE0Bx0Npvo698pUAMkb3Bak+KT9ct
	0EED1
X-Google-Smtp-Source: AGHT+IHWvkr6+94j/BzwHQdHiDqXTo3O/e+qVJaW9JLPTTlOXyXb8C4sTPhh3veIek+m8GTy300uoQ==
X-Received: by 2002:a05:6000:154f:b0:38a:a037:a517 with SMTP id ffacd0b85a97d-38db48bb409mr1519076f8f.19.1738751649305;
        Wed, 05 Feb 2025 02:34:09 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:be8c:5293:84c1:352a? ([2001:8b0:aba:5f3c:be8c:5293:84c1:352a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38db87a409csm326608f8f.99.2025.02.05.02.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 02:34:08 -0800 (PST)
Message-ID: <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/15] Make mirror replacement
 syntax explicit
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Wed, 05 Feb 2025 10:34:07 +0000
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
	<20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 10:34:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17149

On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via lists.openemb=
edded.org wrote:
> The mirror replacement syntax contains many implicit transformations.
> The path of the URI always contains the base name of the downloaded
> filename. This makes it impossible to rename or remove the base name of
> the original path. It prevents upstream mirror for SRC_URIS with a
> downloadfilename parameter. The base name of the downloaded filename
> makes it impossible to use the download mirror for SRC_URIs with
> subfolders in the downloadfilename parameter. Altogether the implicit
> transformation complicates the understanding of the replacements.
>=20
> This series adds an additional replacement named DOWNLOADFILENAME. This
> replacement contains the relative filename of the downloaded file or
> mirror archive for git and hg. This allows the user to explicitly define
> the behavior. The usage is equivalent to the PATH replacement for the
> sstate mirror from file to https scheme.
>=20
> git://.*/.*=C2=A0 http://downloads.yoctoproject.org/mirror/sources/DOWNLO=
ADFILENAME
> https?://.*/.*=C2=A0 http://downloads.yoctoproject.org/mirror/sources/DOW=
NLOADFILENAME
> file://.*=C2=A0 https://sstate.yoctoproject.org/all/PATH;downloadfilename=
=3DPATH
>=20
> Without a replacement variable the mirror will use the same base name as
> the origin SRC_URI. This allows the usage of private package manager
> registry together with a downloadfilename parameter or the rename of the
> base name.
>=20
> https://registry.npmjs.org/=C2=A0 https://example.com/npm/registry/
> https://example.com/example/1.0.0.tgz=C2=A0 https://example.com/example/e=
xample-1.0.0.tgz
>=20
> The series adds heuristics to keep a backward compatibility to common
> styles. Because of the ambiguity of the old style, it is advisable to
> remove this compatibility sooner or later to avoid unexpected behavior.

Thanks for the patches, these look interesting with some good
improvements in there. A lot of the series looks like cleanups and
those look like good fixes to have. It may make sense to split this
series into two, the cleanups/fixes and the behaviour changes.

I'm not entirely "sold" on the naming of DOWNLOADFILENAME. You have to
think about this from the perspective of someone writing a MIRROR or
PREMIRROR entry - would they understand what that means vs some of the
other names?

I'm also a bit nervous about breaking compatibility with the older
syntaxes. It is unclear to me how or when  we'd detect/deprecate older
formats. I do agree we probably do need to remove some support for some
syntax and move to something new though as what we have is turning into
some kind of nightmare. FWIW this is really old code that in many ways
predates my involvement so probably 20+ years old.

I'll continue to give this some thought. If you could confirm which
patches are "cleanup" that would help though, we can see if we can get
those in a bit faster.

Cheers,

Richard





