Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F2CEEAA47
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 14:30:10 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.13755.1694701810170105858
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Sep 2023 07:30:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CTmkbv2H;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso7558025e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694701808; x=1695306608; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/4DHM3cieOP+zhSYEMhydAsCTen+dCh71uAxviJY968=;
        b=CTmkbv2HcdE0YIfPwnpNMY+XGLQxkczCL6Pjj/PWyFpA1OAquwYy32SZEBMAc9n3M3
         dk7snPvFVBfi9yVNW32rnbIp7adRIi9XD5Y3RS6qE0iY+ABwmdwjhVHZqqS37rSTmNv/
         epCUC3iLgWT5Xi/Oqe8UMYrr2DJ7bT/M+f6xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701808; x=1695306608;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4DHM3cieOP+zhSYEMhydAsCTen+dCh71uAxviJY968=;
        b=f5JUSlVoCCZ08KeuHI0NvHxGo2KnN7HeBVpDZHMLX7oKQiUicPRhXkMHJZ7yBRNu6F
         b6Osd48DDDISdb/ZnyFA2xXJvXwb9v3TL6RkvGm7rU1VM438ZCkTpgj1SV/ctfdSkFMk
         /X4ilTYOPo2pVH2YnALWjkUZIgi1FdA+Rl8DCwY2fC21pJd3kL3jkpVHO/UkDBhxdcNq
         S9PTdZttRi1VLQpmDAYqCaVtCC0rqk5thj7iAQOPk0oAO3TQ8zj1LplYFf7vm9+bCQwO
         qZAf1EqhY1/zzFu7YlrYJeOkb4IBFROawRJnTZeCdy4CzqM4H/lrmXOykL5FNJuVPMCP
         gcjQ==
X-Gm-Message-State: AOJu0YwROzac2OaKEcN3mGQ1Q9+ansZvrNb66b+2iq6AiMJSJpg0q6X8
	oWdXMnTNSGmeOBNPX/4PoMhkbtAIQmAb+wZ8eO0=
X-Google-Smtp-Source: AGHT+IGSDvkYqkhLfnmYycRO83blS5oM+0GyLzOwYOPCavmeB04shmkwezjUBDg1jQH/egzdzlfAPw==
X-Received: by 2002:a05:600c:290:b0:3fe:2011:a7ce with SMTP id 16-20020a05600c029000b003fe2011a7cemr5031321wmk.6.1694701808503;
        Thu, 14 Sep 2023 07:30:08 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a6e7:41e3:896b:6b97? ([2001:8b0:aba:5f3c:a6e7:41e3:896b:6b97])
        by smtp.gmail.com with ESMTPSA id d20-20020a1c7314000000b003feef82bbefsm2112948wmb.29.2023.09.14.07.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:30:08 -0700 (PDT)
Message-ID: <c5e1e8071e10f795996eef5efdc03d3a674e1863.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] prserver: add self-tests
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jose Quaresma <quaresma.jose@gmail.com>, Rusty Howell
	 <rustyhowell@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Sep 2023 15:30:03 +0100
In-Reply-To: <1784CA099B7C177E.28514@lists.openembedded.org>
References: <20230913050824.13599-1-rustyhowell@gmail.com>
	 <CANPvuRnb4XRK4A=YDXdS5cXjsNxPj_k1S4acfzFYHsKtUSs-Lw@mail.gmail.com>
	 <1784CA099B7C177E.28514@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 14:30:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15062

On Thu, 2023-09-14 at 15:24 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Thu, 2023-09-14 at 09:51 +0100, Jose Quaresma wrote:
> >=20
> >=20
> > Rusty Howell <rustyhowell@gmail.com> escreveu no dia quarta,
> > 13/09/2023 =C3=A0(s) 06:09:
> > > Add some self tests for the prserver. As changes are made to the
> > > prserver, the tests will
> > > help ensure that any behavioral changes are known, or that changes
> > > do not affect behavior.
> > >=20
> > > Signed-off-by: Rusty Howell <rustyhowell@gmail.com>
> > > ---
> > > =C2=A0.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +
> > > =C2=A0bitbake/bin/bitbake-selftest=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A05 +-
> > > =C2=A0bitbake/lib/prserv/db.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +-
> > > =C2=A0bitbake/lib/prserv/tests/.gitignore=C2=A0 |=C2=A0 =C2=A02 +
> > > =C2=A0bitbake/lib/prserv/tests/__init__.py |=C2=A0 =C2=A00
> > > =C2=A0bitbake/lib/prserv/tests/prserver.py | 213
> > > +++++++++++++++++++++++++++
> > > =C2=A06 files changed, 221 insertions(+), 2 deletions(-)
> > > =C2=A0create mode 100644 bitbake/lib/prserv/tests/.gitignore
> > > =C2=A0create mode 100644 bitbake/lib/prserv/tests/__init__.py
> > > =C2=A0create mode 100644 bitbake/lib/prserv/tests/prserver.py
> > >=20
> > > diff --git a/.gitignore b/.gitignore
> > > index 8f48d452da..c227363e3c 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -36,3 +36,4 @@ _toaster_clones/
> > > =C2=A0downloads/
> > > =C2=A0sstate-cache/
> > > =C2=A0toaster.sqlite
> > > +.idea
> > > diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-
> > > selftest
> > > index f25f23b1ae..8b601aa2b8 100755
> > > --- a/bitbake/bin/bitbake-selftest
> > > +++ b/bitbake/bin/bitbake-selftest
> > > @@ -16,6 +16,7 @@ try:
> > > =C2=A0 =C2=A0 =C2=A0import bb
> > > =C2=A0 =C2=A0 =C2=A0import hashserv
> > > =C2=A0 =C2=A0 =C2=A0import layerindexlib
> > > +=C2=A0 =C2=A0 import prserv
> > > =C2=A0except RuntimeError as exc:
> > > =C2=A0 =C2=A0 =C2=A0sys.exit(str(exc))
> > >=20
> > > @@ -35,7 +36,9 @@ tests =3D ["bb.tests.codeparser",
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "hashserv.tests",
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "layerindexlib.tests.layerindexobj=
",
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "layerindexlib.tests.restapi",
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"layerindexlib.tests.cooker"]
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"layerindexlib.tests.cooker",
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"prserv.tests.prserver",
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]
> > >=20
> > > =C2=A0for t in tests:
> > > =C2=A0 =C2=A0 =C2=A0t =3D '.'.join(t.split('.')[:3])
> > > diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
> > > index b4bda7078c..8cefb28f16 100644
> > > --- a/bitbake/lib/prserv/db.py
> > > +++ b/bitbake/lib/prserv/db.py
> > > @@ -71,7 +71,7 @@ class PRTable(object):
> > > =C2=A0 =C2=A0 =C2=A0def sync(self):
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.read_only:
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.conn.commit()
> > > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._execute("BEGIN EXCLU=
SIVE TRANSACTION")
> > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #self._execute("BEGIN EXCL=
USIVE TRANSACTION")
> > >=20
> >=20
> >=20
> > Is this change intentional? imo they should be on another commit
> > since it doesn't seem related.
>=20
> I was wondering that too, it certainly needs explaining if it should be
> there...

It does look like the tests only pass with that change. I also noticed
a .idea file being added to gitignore which looked a little
questionable.

Cheers,

Richard

