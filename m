Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CAAE77188
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 13:59:39 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.8504.1735826375003473485
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 05:59:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IJUBq3eP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso74848195e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735826373; x=1736431173; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ioNdWPFtOG3xhuF+ZxL5FVRefDK4j66BW+gZu9HeKQU=;
        b=IJUBq3ePYGCi1JLJcB6Nh7qY6sG5jDLHXswhfpRyMgV9VEJKZjl75shCvCjKCcbvip
         5QgwXXLV1CHw4UOdkfQjjmJGoUMzV8nhPn/CB10y06CcWuIsH75um0NGdFYNAE33OSFf
         ZvE+VIpT74zH3fGZSoPi2LNZEaxJnajzaka1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735826373; x=1736431173;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioNdWPFtOG3xhuF+ZxL5FVRefDK4j66BW+gZu9HeKQU=;
        b=UKk9bSsJwnpmb1MoEzasSZcDS8wLjmDuqzMCaa1F45Os27Xvj5OnQx894shrTz0ns5
         XgfH6Am4/g3Wr7V1TXf5Q/bzm/5uJlHG4dwZFEZd5OU0ZJPDTduK06cEjYk0Rq2ewbBK
         rmuGSQDjfbhYsVWR1EuPyjmkywnfiXm3vaLN42UBdL25iR91CgqF8dRwdWhseMDayWex
         +YBamIAdOdPICIa51y5jfREQVCpCcfS4dIOpCDfKxAv8h7YqAxB9EHcNRvrI0V85wXEb
         HRLA6PBFMpjuZ1jYeJfQLnefXqkCxkAIsUSUKHB8ciMBdAU30o3fRHwzsM4gzlxLd0gO
         ldjg==
X-Forwarded-Encrypted: i=1; AJvYcCVcFiigFkOY7Zbw9KrKd0dPZC16eXY+ZykCnHMweLIo6Vo7Ozy1X8XAbB76dZ8iAadZXMkSaVy4YYBeZpuA@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywx5Kvu4rZzK+qlo9zXOysvywrnhebk9yQl9ehX6S2NbGw/cYqj
	VHETBAtbP4VOTBah1g4UCwnX8TlB26yUvb9iyRKIc0qP6B6fSqAyBVm70H0rg8A=
X-Gm-Gg: ASbGnctPkn5CxA+lng6INJg6w3KbYoXCIMyP+AW27Oh6WUsYu+jVPxNCWDbrA+nwutU
	9UcF/IaOjFqOgm+Pah46XHhfwM+/bFFyDlh2ofOLgBDMXdzojN88ct8Wb3KL1wqLIUMsmSui2LB
	5hnFsfyf28yH1mvwkN5iJwoCtxmm/EgY+n9qZOMiy9bk5gHCr1y1JkxdHn7PTIiWnVBuclU9Yla
	X+PV8WvwmlGGH2eSSRv+xdyUP0sVnWhRJYn4H3KrBtgxZnjtYkHlDdK6AWwOncs+z9XV72HLbHC
	S5m50Yrs2WS25+siCYeuMHZU1Fy19Fo/B6EPLmObdgZcFg==
X-Google-Smtp-Source: AGHT+IElKwLUwjfm7uqFyh/1PeaClHPzlGn0YMqU2Ufhr3NUfCAY2OzyTRzyYOLWMTqiSeYvBC3+bg==
X-Received: by 2002:a05:600c:138d:b0:434:a4fe:cd71 with SMTP id 5b1f17b1804b1-436686439e6mr411868375e9.12.1735826373287;
        Thu, 02 Jan 2025 05:59:33 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ae2e:9f02:55c2:739d? ([2001:8b0:aba:5f3c:ae2e:9f02:55c2:739d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea487sm451202215e9.8.2025.01.02.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 05:59:32 -0800 (PST)
Message-ID: <bd07e0878612dde78c083d888a3f9f7db0eba8e0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 07/21] fetch2: add unpack support
 for npm archives
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Thu, 02 Jan 2025 13:59:31 +0000
In-Reply-To: <f30a04bf-96f2-458d-9ceb-94fc39895dc8@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <20241220112613.22647-8-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <f9b92d30b08d5177de4941bc31c17add5ee2f8f4.camel@linuxfoundation.org>
	 <f30a04bf-96f2-458d-9ceb-94fc39895dc8@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 13:59:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16960

On Thu, 2025-01-02 at 13:39 +0100, Stefan Herbrechtsmeier wrote:
> =C2=A0
> Am 23.12.2024 um 12:56 schrieb Richard Purdie:
> =C2=A0
> =C2=A0
> > =C2=A0
> > On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via
> > lists.openembedded.org wrote:
> > =C2=A0
> > > =C2=A0
> > > From: Stefan Herbrechtsmeier
> > > <stefan.herbrechtsmeier@weidmueller.com>
> > >=20
> > > Add unpack support for npm archives with unusual member ordering
> > > and
> > > disable warnings for unknown extended header keywords.
> > >=20
> > > Signed-off-by: Stefan Herbrechtsmeier
> > > <stefan.herbrechtsmeier@weidmueller.com>
> > > ---
> > >=20
> > > =C2=A0lib/bb/fetch2/__init__.py | 1 +
> > > =C2=A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/lib/bb/fetch2/__init__.py
> > > b/lib/bb/fetch2/__init__.py
> > > index 4b7c01d6a..7d8f71b20 100644
> > > --- a/lib/bb/fetch2/__init__.py
> > > +++ b/lib/bb/fetch2/__init__.py
> > > @@ -1535,6 +1535,7 @@ class FetchMethod(object):
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if unpack:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 tar_cmd =3D 'tar --extract --no-same-owner'
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
ar_cmd +=3D ' --delay-directory-restore --warning=3Dno-
> > > unknown-keyword'
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if 'striplevel' in urldata.parm:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 tar_cmd +=3D ' --strip-components=3D%s' %=C2=A0
> > > urldata.parm['striplevel']
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if file.endswith('.tar'):
> > > =C2=A0
> > =C2=A0
> > I think I'd be happier if this option was only added for the npm
> > fetcher...
>=20
> Can I check the ud.type to add the args or should I move the args to
> an optional argument for the unpack method or an FetchMethod
> variable?

I suspect a FetchMethod variable would be most in keeping with the rest
of the code. We've tried very hard not to fill the code with "if
ud.type" conditionals as we did that in fetch v1 and it became
unreadable and unmaintainable. This way it forces us to have some kind
of thought and methods/variables to document things.

Cheers,

Richard

