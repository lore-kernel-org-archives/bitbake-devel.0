Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D95EEAA45
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 14:25:10 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.13738.1694701501958231405
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Sep 2023 07:25:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VR4yTCL+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-31c7912416bso903208f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694701500; x=1695306300; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LI1Z+7A1soGFcC0CjsQZIU/jweL/lrshUw5nqWH/PRs=;
        b=VR4yTCL+39aNCihl1GywTH/P41nAUq8VkXabdstKfWGXR85QE9Ly+V6Ff4FDx8eJ3M
         rgwsFlshi6q4OTl6bqlf1vW4MEtBKwN9+y97rl5hvS7mYX4JawXZQkyT0ZwjpjgPP21j
         UQP4ACPE4cHyYnri117eHQLKN+W4eoe5Njhag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701500; x=1695306300;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LI1Z+7A1soGFcC0CjsQZIU/jweL/lrshUw5nqWH/PRs=;
        b=i8FbIODU73Y4YeUjjc+H4M45o7tWdcu1PResrn8CI6rU+3pSOZS3+exnfTfgq+Ks91
         JV71OT5pO5OBc+2RoVzssscv7cJfmA9mOVQPfb9Yzep8PI80z4vz8fRh/MdCFTCbCMts
         gTSmG66NmYkqc8X8kN0lu6DM8gc2MYEktavFig+o5PCfoTywg5ZBdxih+aIYLBv1du//
         STBJlSl1aHGJcoO+I4xXpveI5JAoWH3CUazycbDmq+9FtjCOc4ZLnnE9o4EFEiKVqVjl
         rtetUKyc+jb4GV88bdVjaJZ0+Y+txailC6j59sqLTKldVnb+igSmM0te/Pr5J8CJPOfd
         ukMQ==
X-Gm-Message-State: AOJu0Yw/U6S36rb0unqTx4T7m+l/cX0SoltEjW2hSdbbxfS5eLHx6YkY
	FkL58cUdd936kO4ABX6D/3sV+A==
X-Google-Smtp-Source: AGHT+IGReL2qhyxDfKHLMzlebmoOvwhZJoWb3u+IqE9dowdAwzcI4pOPId/FvqFGQWsTpFzbKf0/0A==
X-Received: by 2002:adf:f3c2:0:b0:31f:a4fa:130a with SMTP id g2-20020adff3c2000000b0031fa4fa130amr5368576wrp.14.1694701500078;
        Thu, 14 Sep 2023 07:25:00 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a6e7:41e3:896b:6b97? ([2001:8b0:aba:5f3c:a6e7:41e3:896b:6b97])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d5444000000b0031f3b04e7cdsm1875499wrv.109.2023.09.14.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:24:59 -0700 (PDT)
Message-ID: <0c45e56e8957704c267300b32143082dd7b3d44a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] prserver: add self-tests
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jose Quaresma <quaresma.jose@gmail.com>, Rusty Howell
	 <rustyhowell@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Sep 2023 15:24:59 +0100
In-Reply-To: <CANPvuRnb4XRK4A=YDXdS5cXjsNxPj_k1S4acfzFYHsKtUSs-Lw@mail.gmail.com>
References: <20230913050824.13599-1-rustyhowell@gmail.com>
	 <CANPvuRnb4XRK4A=YDXdS5cXjsNxPj_k1S4acfzFYHsKtUSs-Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 14:25:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15061

On Thu, 2023-09-14 at 09:51 +0100, Jose Quaresma wrote:
>=20
>=20
> Rusty Howell <rustyhowell@gmail.com> escreveu no dia quarta,
> 13/09/2023 =C3=A0(s) 06:09:
> > Add some self tests for the prserver. As changes are made to the
> > prserver, the tests will
> > help ensure that any behavioral changes are known, or that changes
> > do not affect behavior.
> >=20
> > Signed-off-by: Rusty Howell <rustyhowell@gmail.com>
> > ---
> > =C2=A0.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +
> > =C2=A0bitbake/bin/bitbake-selftest=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A05 +-
> > =C2=A0bitbake/lib/prserv/db.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A02 +-
> > =C2=A0bitbake/lib/prserv/tests/.gitignore=C2=A0 |=C2=A0 =C2=A02 +
> > =C2=A0bitbake/lib/prserv/tests/__init__.py |=C2=A0 =C2=A00
> > =C2=A0bitbake/lib/prserv/tests/prserver.py | 213
> > +++++++++++++++++++++++++++
> > =C2=A06 files changed, 221 insertions(+), 2 deletions(-)
> > =C2=A0create mode 100644 bitbake/lib/prserv/tests/.gitignore
> > =C2=A0create mode 100644 bitbake/lib/prserv/tests/__init__.py
> > =C2=A0create mode 100644 bitbake/lib/prserv/tests/prserver.py
> >=20
> > diff --git a/.gitignore b/.gitignore
> > index 8f48d452da..c227363e3c 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -36,3 +36,4 @@ _toaster_clones/
> > =C2=A0downloads/
> > =C2=A0sstate-cache/
> > =C2=A0toaster.sqlite
> > +.idea
> > diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-
> > selftest
> > index f25f23b1ae..8b601aa2b8 100755
> > --- a/bitbake/bin/bitbake-selftest
> > +++ b/bitbake/bin/bitbake-selftest
> > @@ -16,6 +16,7 @@ try:
> > =C2=A0 =C2=A0 =C2=A0import bb
> > =C2=A0 =C2=A0 =C2=A0import hashserv
> > =C2=A0 =C2=A0 =C2=A0import layerindexlib
> > +=C2=A0 =C2=A0 import prserv
> > =C2=A0except RuntimeError as exc:
> > =C2=A0 =C2=A0 =C2=A0sys.exit(str(exc))
> >=20
> > @@ -35,7 +36,9 @@ tests =3D ["bb.tests.codeparser",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "hashserv.tests",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "layerindexlib.tests.layerindexobj",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "layerindexlib.tests.restapi",
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"layerindexlib.tests.cooker"]
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"layerindexlib.tests.cooker",
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"prserv.tests.prserver",
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]
> >=20
> > =C2=A0for t in tests:
> > =C2=A0 =C2=A0 =C2=A0t =3D '.'.join(t.split('.')[:3])
> > diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
> > index b4bda7078c..8cefb28f16 100644
> > --- a/bitbake/lib/prserv/db.py
> > +++ b/bitbake/lib/prserv/db.py
> > @@ -71,7 +71,7 @@ class PRTable(object):
> > =C2=A0 =C2=A0 =C2=A0def sync(self):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.read_only:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.conn.commit()
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._execute("BEGIN EXCLUSI=
VE TRANSACTION")
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #self._execute("BEGIN EXCLUS=
IVE TRANSACTION")
> >=20
>=20
>=20
> Is this change intentional? imo they should be on another commit
> since it doesn't seem related.

I was wondering that too, it certainly needs explaining if it should be
there...

Cheers,

Richard

