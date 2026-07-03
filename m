Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE76C43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 12:30:51 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.92120.1783081850322171045
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jul 2026 05:30:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IzXl/GKa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47488efcf30so343661f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Jul 2026 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1783081848; x=1783686648; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JXXYpFnIudw5OFbb68bPzQEVasF7QUW2gbtXHBp9yXU=;
        b=IzXl/GKadTJX//hUE6K/pp3ZoLmkeJhAFRm1JFPw3pyh/qIEPFtlheWY2UEVMnQBUh
         O6/0zeU2ynuAy1NjvLeXcmsGJ2+gpyGNkep18u45IxxsIKMhtg+mMU6AYgPnoFKbVjH1
         FKAshSkfBpKyK4dPQzK3pLqwGtBvpVE3aBeZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081848; x=1783686648;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXXYpFnIudw5OFbb68bPzQEVasF7QUW2gbtXHBp9yXU=;
        b=WtnHEbciGObVCUSGd6fxhrLbpWBmCylQbwYkoGOXXp1SHQGNikt7AsVj4ZXTFbnmTa
         dHzvaQrAriew45IL6wDxq/Pv6KBgTRE06poTbjlhcQcxZByGWnvZErwc7BE5qAPwB5cJ
         U3BU/+rpfdytjytdfOOifieRc09lucwVqDEAy87uMhA6exJov73tQDpz5I9Fdmr8cSDC
         kZlGFK8zA9QJGoT6sv6m5Y2lUG++5N+5pnb8ahHeCIv2AXSqjOJJqBM27EKmT2pHxTSf
         PE/QDVgFi2SFAZELY1rROYhBddzrwILx3Y8r+rQju/oYfNwIY6h5LHbKOJNteI5YGehq
         xjig==
X-Forwarded-Encrypted: i=1; AHgh+RqRDYAdqbNttryd+Q4pgpfd5pWqZuZ1I/pMtxyo38F+mB4Jr5W3RHYE/jA+WmE3M5YJCvhga2FDDvBUJxKS@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz3pXrhOBmQk4qVekKmXb9591muyhcEz+GcMlyLGWMnEHToR9XU
	EVQkpzVaMJpryt77sr4FMNoVQ7LobP2e1FtGOVn738ByJAevCV1+/YswTHJL5a0c/Xo=
X-Gm-Gg: AfdE7clIoDMyUV1Cq32Yu91P+QXBQLlwfMe6ZDwSm5YD9rM6pHkv+sQ62wA0kPfhaLj
	tVC3hNI/r8PqCw5WyXa8o/rVtyh+VgGoZ65wGMdT+Q1OWY7k6oxOcZHlOtTI4I19kolD8MeCgDG
	dyLCKpxji+7Mkk7D71c6At4odw5aRzsvbmjq/M1dhvcvzAM3WFcePLIafNQNZU5zkFtfIWT+Hcw
	NzWiJzrb/rxlI9lWFfVyvHwTxaSidFVI1Evk29RbrDcyW8tRVuN2tMc+R3ewhLnunEVQkUiE+na
	O6xBOWad64kSGaTf/Lk3xywcz7mAdjsfTLRGiy1P2RRz3JP2Nzz82+U4YFxNsDZG/aUR7ZzIB+y
	Ho5o4xGPbnD1WFSGBN3NSClORsTCJebo4/8cO3fi1tgsOdV7+aQnBTZ/o5rPqUhP6/L11d0sgXX
	Fjklncr+2F5oSrVJvb3HXkdTnSRNpjk/XQJ07ALgN8iBr3tFei+2ZGnmT2y1jChRFXLhcQMXtyj
	ZnIww==
X-Received: by 2002:a05:6000:2887:b0:478:5710:4650 with SMTP id ffacd0b85a97d-47857104741mr10844500f8f.58.1783081848486;
        Fri, 03 Jul 2026 05:30:48 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ad8d:cf49:9149:eae0? ([2001:8b0:aba:5f3c:ad8d:cf49:9149:eae0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4b83sm19973596f8f.12.2026.07.03.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:30:47 -0700 (PDT)
Message-ID: <ced86d752a6d62c374f8d2db03adc1787b4c79fa.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] fetch2: give every FetchData a default
 unpack_tracer
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: sivakumar.bs@gmail.com, bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com, Oliver Feilner <oliver.feilner@yaskawa.eu>
Date: Fri, 03 Jul 2026 13:30:46 +0100
In-Reply-To: <20260703110612.294043-1-sivakumar.bs@gmail.com>
References: <20260703110612.294043-1-sivakumar.bs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Jul 2026 12:30:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19817

On Fri, 2026-07-03 at 16:36 +0530, Siva Balasubramanian via lists.openembed=
ded.org wrote:
> Fetch() sets an unpack_tracer attribute on the FetchData objects it
> manages, but the per-mirror FetchData objects created in
> build_mirroruris() are constructed directly and never get one. When a
> mirror is used for a git recipe that needs Git LFS, git.py's download()
> performs a checkout (via Git.unpack()) on the mirror's FetchData to
> materialise the LFS objects, and that unpack path dereferences
> ud.unpack_tracer, failing with:
>=20
> =C2=A0=C2=A0=C2=A0 AttributeError: 'FetchData' object has no attribute 'u=
npack_tracer'
>=20
> so PREMIRRORS/MIRRORS fetching is broken for git-lfs sources.
>=20
> Fix this at the source by initialising unpack_tracer to a
> DummyUnpackTracer in FetchData.__init__(), so the attribute always
> exists. Fetch() still overrides it with the real (possibly
> user-configured via BB_UNPACK_TRACER_CLASS) tracer for the URLs it
> manages; the mirror FetchData objects only perform an internal,
> throwaway checkout that should not be traced anyway.
>=20
> Add a MirrorUriTest regression test asserting the mirror FetchData
> objects carry an unpack_tracer.
>=20
> Reported-by: Oliver Feilner <oliver.feilner@yaskawa.eu>
>=20
> [YOCTO #15948]
>=20
> Signed-off-by: Siva Balasubramanian <sivakumar.bs@gmail.com>

Wasn't this already fixed by:

https://git.openembedded.org/bitbake/commit/?id=3Df0c9cf8d3885c5b1c2ba448f0=
64421dae476fcd0

?

We don't want to add a dummy one everywhere, only add one when needed
as the patch avove does...

Cheers,

Richard

