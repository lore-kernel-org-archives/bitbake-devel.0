Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A43AC282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 21:08:07 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.928.1741900084556299470
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Mar 2025 14:08:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C0lS1al5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0618746bso10009755e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Mar 2025 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741900083; x=1742504883; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yybpRblugzplkcQ3FfPtGEwNsYAIfXuh/7Cru1BIOXQ=;
        b=C0lS1al5Qfu8n8vwc40Bb08ib68qLQ5EafWdikiAmEvzdzg+PJakHZMda90GtXLFJ/
         6HqgLf4DVYDcxb1ENHANKAHNtRuIji7seEueS4U86T1r3OLsBaet2DE3Q28pMZMVSoWT
         +BKbRuKSp835mqjYsBJwYSeBFOrPhDFautPxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900083; x=1742504883;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yybpRblugzplkcQ3FfPtGEwNsYAIfXuh/7Cru1BIOXQ=;
        b=lBOSL5CewF09xlku/JYNlXek7f8zkHwxSs5hjcu8AxSjQntnw4d3/4uHXbzkM1xgex
         TSVDJ6j+g2SHi4F5+Bzn/4Fv0QA4Yt05UPA7a9FFRc/n2by8rP8PFQBtcxYKUfD6qw7Y
         r781ihrtzQC3FCuaLY8ATu75rVrHJ6UbYGOUafdVOF2tK2QHCEtH+GRtA3JMoOKC4FOq
         nbZ4gT4uNc9ibaOCi0vNxp4BkR8jWSWCdxbTkdqt0I7g06QhblcWArdogqjKzmvk2mHB
         VFHsEWaemQsfwqkMGoC7NtycxGbQwtvPhAsW7Evi51MAToD0jWU2mLBHmUPOQ6DLbbaz
         gbNA==
X-Forwarded-Encrypted: i=1; AJvYcCUW4IjLFumnLnkFlKNoIkVaXwdc1EX1mZeDYLQhNf3OaQzaqcxA7IdGPQGLnFG0O2YIZLN1K42SynIQyobr@lists.openembedded.org
X-Gm-Message-State: AOJu0YzgD+Rb6Hb2ktexX/2JAmQOmtJLlAlEHjYXVrf3H3HluFQ06rnC
	JroXBYX/0KHyMcKd52UbHDq4I0qzogposs2Vkj5LB7GmQNxNd3UwvIlCMxItjEg=
X-Gm-Gg: ASbGncvWQkvF8IuPubH49lEO0XHLHKROYCi8BhHe4+bC9LgKYafarb2+KWm9qMgCBeM
	XcBmVpGwf80jsd/I4D7bXIS3TakpGApqK1fhMQT6bw0CkEhg66vqVlydqCe2k29CXqG6gutET9j
	fWMDlvBB8S2dAtfVeUGzeeS0M59eUKenpiNuUBoEUZLqN4+hLD6myenMpiscvZpTgDzyUuWeAXC
	ukNi08p8tUmzNAOlA6GGsBgYWiZdSeEb6DiPdfkC0nefJFE+qDbQgj/zWu8bZsDULZQJazIS4+L
	tHwYj8+CEukh/xd+84EUacfdegJvIK2+qIgnwY37cAEydgJtHc7oQzC4qLUpD5Y2vNVMgLhvNQp
	Ujyy2MQqKXIzLp6j+D+Y+Z+kgcSU8Mxaqlg==
X-Google-Smtp-Source: AGHT+IFwYiEj9Z42DnIkeG02UdqIDrDgseQXdTqPHlXiRFv6akM0uD4q9/RsSrwVrpnUGbZ+83dEHg==
X-Received: by 2002:a5d:59ae:0:b0:390:d6ab:6c49 with SMTP id ffacd0b85a97d-396c326e366mr1291549f8f.35.1741900082688;
        Thu, 13 Mar 2025 14:08:02 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2e4e:7963:5ae2:c405? ([2001:8b0:aba:5f3c:2e4e:7963:5ae2:c405])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c255bsm3237871f8f.23.2025.03.13.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:08:01 -0700 (PDT)
Message-ID: <b0f7694992b86e8035175a0bbb0e2de731dd1b94.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Restore escape quoting for
 the git url when used
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: patrik.nordvall95@gmail.com, bitbake-devel@lists.openembedded.org
Date: Thu, 13 Mar 2025 21:08:00 +0000
In-Reply-To: <20250313155850.2924491-1-patrik.nordvall95@gmail.com>
References: <20250313155850.2924491-1-patrik.nordvall95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Mar 2025 21:08:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17442

On Thu, 2025-03-13 at 16:58 +0100, Patrik Nordvall via lists.openembedded.o=
rg wrote:
> This fixes a bug where escapes in the url path would not be properly
> restored for the git commands in the git fetcher. For example, a
> space which is encoded as '%20' was not properly encoded before the
> clone command.
>=20
> e.g.
>=20
> SRC_URI=3D"git://git.openembedded.org/bitbake%20example/bitbake;protocol=
=3Dhttps"
>=20
> resulted in
> git clone 'https://git.openembedded.org/bitbake=C2=A0example/bitbake'
>=20
> instead of
> git clone 'https://git.openembedded.org/bitbake%20example/bitbake'
>=20
> Signed-off-by: Patrik Nordvall <patrik.nordvall95@gmail.com>
> ---
> =C2=A0lib/bb/fetch2/git.py | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 5b678827e..aaf571eb6 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -81,6 +81,7 @@ import shlex
> =C2=A0import shutil
> =C2=A0import subprocess
> =C2=A0import tempfile
> +import urllib
> =C2=A0import bb
> =C2=A0import bb.progress
> =C2=A0from contextlib import contextmanager
> @@ -828,7 +829,7 @@ class Git(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
username =3D ud.user + '@'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
username =3D ""
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "%s://%s%s%s" % (ud.pr=
oto, username, ud.host, ud.path)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "%s://%s%s%s" % (ud.pr=
oto, username, ud.host, urllib.parse.quote(ud.path))
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def _revision_key(self, ud, d, name):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """

Thanks for the patch. Could I convince you to add a test case to
lib/bb/tests/fetch.py (run with bitbake-selftest) please? This is to
try and ensure we don't regress this again!

Cheers,

Richard

