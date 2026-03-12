Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF7105A58C
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 11:34:09 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19155.1773315243915941207
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Mar 2026 04:34:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fnLtCL49;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so8774945e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773315242; x=1773920042; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FAOnkanBa7lgItfJCp/PPNCAfZETKl7JRNcbqjfj6GM=;
        b=fnLtCL49RHphmEokjoOWegyVnK+FOKtk55nUmblYLbIndmL7O2hYxlzYwh+6iJe427
         kE2V/nvTU9Ke+gaQLcKDQYMfefZWC2FiB7yUVP0Dq0uCrcEgSTj0rN9Q4+WVvAXfEl3s
         ABr/y4Lbb8aYF1nIfGxpOQ3d7dUo6Nv919KK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773315242; x=1773920042;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAOnkanBa7lgItfJCp/PPNCAfZETKl7JRNcbqjfj6GM=;
        b=MroGxLwVuP1bB5fgqJvgxaH2rSl3zLOaMMCPmetYvEgXil6Du0/oup9ecpqgZV30OV
         Ob8OsAtu1Ea3s250Gpgq11jP194cwmaDnHmHYGYLXjoBUVLR70Qw76iXehCsig/paD3W
         X8hBbZUpQ4iJu3dCmnxec133B2woGfNqPL3mFjEAVvZTRG3e4j7UVQhB7KzMk09FjAI6
         SYur5oyPNtQAChS+FMWBz+zeQ74z0EOMbQlOuilvIxsZJA2yC3tNlowGSl6TW1kRdYJw
         POTc4R6/q0bXfO0aXlQYMyNfJzNZ6EcnBvvZTZEjjoLjKN2k8LqEuwujbtmmLAnaFizx
         gf4g==
X-Forwarded-Encrypted: i=1; AJvYcCWgucyrrmP5d9hC0OtMyWwVC1a5FGgSQyMvyo0oFUeOoc/k9xJr2Gy3ApVT7sUKbZwUNGPa4Yq+/k3RkxdW@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywb8V/iPs6BMz6DXVC2Uo9HflTUFCDXhB37+yuZODA5w11RZJ6w
	05LOECcLx/eYT4kl/mupH/gSRVCZxXHzrAQ6L/YbaYTCf9YeZOpKbBxF0LhDpiEsl4o=
X-Gm-Gg: ATEYQzxguG+q5dwyPLoftT/TjWXsI3qK5kTQusiG5o7L7jx6O42YcFOJDHHPF4+GmFW
	g/qamasP4DMT9XNPxb/CkJhYPblpY/F/DV6UGNKvas6b6o6N2qRZdO/YMJJ6MLojQa9AyXTYl7l
	eFvVEbmz8CmfDE7bqOZshse1BaI/DbtKllGyPAS+SJvwpobqkdebrr+3hDYDm3dHQvLRyP3/GAF
	X0BnZn1U9B76psMQK8H7sz0TeMVRuG5/IShPXyUQl974Zai13VylOm0WD55zEmrUa/+1SoN0GHd
	AHMkFSET0Za/rQRn/FlfJFO4Nb2tooKTwthRhpVygyLIdSufz50neHw6KFYOnyAAqySoG8kUzLg
	UPDyya9y25FY9dcTjSKQ/7jsKz1JEULjAZrjfqKbrMSRXhuftpJChZmpaRyquS8EknANMZbdKl1
	8QVeuJ8sZWV9AOCw4pfqhhaLQOaMUX8omlIodiJpemCNIgHjGTzkMcEQtVx2m7CoJK6B3iwq5lm
	C3SLLFNCYPx
X-Received: by 2002:a05:600c:3551:b0:485:2f6a:6ed with SMTP id 5b1f17b1804b1-4854b10cf6amr105212705e9.28.1773315242146;
        Thu, 12 Mar 2026 04:34:02 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:215f:5162:d0b:8f1d? ([2001:8b0:aba:5f3c:215f:5162:d0b:8f1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e2537c3sm108685325e9.15.2026.03.12.04.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:34:01 -0700 (PDT)
Message-ID: <e5911b86ad67a0341afa4e811fcb7dede1c8c9eb.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] fetch2: add alternative fetch
 method based on curl
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: pascal.eberhard@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
Date: Thu, 12 Mar 2026 11:34:00 +0000
In-Reply-To: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
References: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Mar 2026 11:34:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19150

Hi Pascal,

On Tue, 2026-03-10 at 00:29 +0100, Pascal Eberhard via B4 Relay via lists.o=
penembedded.org wrote:
> wget fetch method is used for web downloads with http, https, ftp, ftps
> protocols. wget cmdline tool is missing some features such as hostname
> resolution by the proxy when using SOCKS5 proxy. SSH tunnel provides
> this feature for example.
>=20
> This curl fetch method is based on curl cmdline tool and provides the
> same protocols as wget and supports SOCKS5 hostname resolution.
> This class inherits wget method in order to avoid code duplication as
> much as possible.
>=20
> wget remains the default download method. curl fetch method can be
> enabled by setting a new bitbake variable:
> =C2=A0 BB_FETCH_METHOD_HTTP =3D "curl"
>=20
> The hostname resolution by SOCKS5 proxy is activated by setting
> environment variable:
> =C2=A0 all_proxy=3D"socks5h://...""
>=20
> a patch on ce-core will be sent if this proposal is accepted to
> conditionnaly add curl to HOSTTOOLS variable in meta/conf/bitbake.conf:
> HOSTTOOLS +=3D "${@bb.utils.contains('BB_FETCH_METHOD_HTTP', 'curl', 'cur=
l','', d)}"
>=20
> Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
> ---
> Changes in v2:
> - removed type hint unions and tested with Python 3.9, thanks Mathieu
> =C2=A0 Dubois-Briand for reporting this.
> - curl tests are now skipped when curl cmdline tool is not found.
> - Link to v1: https://lore.kernel.org/r/20260305-add_alt_fetch_method_cur=
l-v1-0-0d0220e5fa59@se.com

We discussed this today a bit on the review call and we're all very
nervous about this change.

One of our guiding principles is not to have multiple ways of doing the
same thing. The reason is simple, so that we don't end up with two semi
functional things instead of one good one. Adding this "curl" mode to
the fetcher creates this scenario where one thing works for some and
the other works for everyone else. We'd then have to document when to
use one, when to use the other and potentially which functionalities
work in each different case.

The fetcher changes don't appear to change everything, they look like
you changed just enough to get your use cases to work.

The "wget" fetcher is already a hybrid where it uses wget for some
things and urllib for others. It does do that consistently though,
always using wget for certain operations and urllib for the status
tests.

We're not wedded to using wget, what we do want to do is provide a
strong stable and single API to enable fetching of http/https urls.

Given this, adding in the switch isn't an approach the project wants to
take. Equally, we've used wget reliably for a long time and it is the
thing we know. Swapping it for something else isn't something we'd
undertake lightly either. There are likely things that wget does better
than curl too for example. There are also factors like documentation to
consider if we were to switch to curl, our prerequisites would need
updating for all the distros, our autobuilder workers would need to be
reconfigured and so on.

I think we therefore need to have a wider discussion about how to move
forward here and work out what the best solution would be to aim for
long term, then come up with a plan to get there.

I'm conscious the LTS/feature freeze is looming but this isn't the kind
of change we can rush in before then unfortunately, we are simply too
late for that.

I'm also really aware of the limited bandwidth many of us have to
contribute to discussions like this. I personally find that really
frustrating as I want to try and help but there simply aren't enough
hours in the day :/.

So whilst I appreciate this isn't the answer you wanted to hear, I
don't think we can take these changes right now and we need to find a
different way to help you solve your issue.

Cheers,

Richard

