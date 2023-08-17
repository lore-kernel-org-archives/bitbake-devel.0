Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF2C531DF
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 19:20:17 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.2649.1692300010320581280
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Aug 2023 12:20:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=M4+MRdKt;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso1975331fa.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Aug 2023 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692300008; x=1692904808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbHNoLXU9sB25zjVyFt0LiRNZ9ldcacaODiUjZj+O9M=;
        b=M4+MRdKtU3EtfFVAxkUSAeo7QWe4z25pbWZIudjSrQjODjzluoetot2MM9FqQFqpBT
         L373MUTPqSZbge/+uaX+CtfraquZ7nK/3/ZZ+l6BKvAyNx3qNySEEIUPWwzlXq7aiTH7
         BK92vZ4kcqMsKFVJZbcyRmJ3AAToI8rM6X+4h882/fNzw3tLimx6HWRyeH9HIP91DhqZ
         Cnoy7ExuhM2rxbbt5DeAJNK7PdIvzbxyFoHWv6vJMzWJNHT2pt3eoKaRp2mkfpOfRIad
         ub/ESnZF8m/0ze+vRmRaHtTWvF1aY2PXAFA8aom7R9ipDnDvqvSgcnSjwTdoef1lG116
         7RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692300008; x=1692904808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbHNoLXU9sB25zjVyFt0LiRNZ9ldcacaODiUjZj+O9M=;
        b=l1AOkeT0L0oWkY53A7YmwrRZJb+uA80gln9wRV2IeWBobW0Rr03yzT8r0Onb49yfL7
         5RSw7gtdCNqp115AxCHlnFE+BQSUDvu2+MqH1PtzmvtoLFKdIsfqVi2P78a/qcMx14gS
         pafVUJL1AN7UBFIyKdh3lxG8bI1xji0jmPH98QHD06KNibqTfKVDLX1YqwDEEoSQvxLW
         Kk46m811xB8+fejx3db70Irk1NThFB2qVDHjIifTJsIPMtlW+/jlN1cXZsr16rzjKMFP
         QsDWyt9u1IaV52YFN4dHLm1pypJjt785BplrvCCdk76yG0RiE/B7hXNfHas4EA6HHaeQ
         MT8A==
X-Gm-Message-State: AOJu0YxfNCk1LltTegBQ09M9FKqxMOdd7ctD5Xf7PZitKOrsWD1CUcVV
	vfb0Med+wAGviLrh1tjG0pG5b9HDZa4xfZdygyE=
X-Google-Smtp-Source: AGHT+IF+EL1RCVQAKWNgN3KlHtnGj8Zy2QggWrNTUPPk2NhWyKsVLrNVMpsS25WdMGyJgcJdHFDcG9HkatTsMD/br7A=
X-Received: by 2002:a2e:b781:0:b0:2bb:9822:cad8 with SMTP id
 n1-20020a2eb781000000b002bb9822cad8mr204090ljo.51.1692300007912; Thu, 17 Aug
 2023 12:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230804155424.1502010-1-JPEWhacker@gmail.com> <2023080901520013144e1b@mail.local>
In-Reply-To: <2023080901520013144e1b@mail.local>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 17 Aug 2023 13:19:56 -0600
Message-ID: <CAJdd5GYK-dr6vf3a_O_hgQ-gLt1WkHwcwwyH5fD4+d423MzAcg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] fetch2: git: Check if directory is a bare
 git repo
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Aug 2023 19:20:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14951

Alexandre,

I'm not sure that's quite correct; I was able to run the test fine
locally, and that failure looks like a 502 error from the server,
which really shouldn't have anything to do with this patch?

On Tue, Aug 8, 2023 at 7:52=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello Joshua,
>
> I'm fairly sure this causes the following bitbake-selftest failure:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/56/builds/2307/st=
eps/11/logs/stdio
>
> On 04/08/2023 09:54:24-0600, Joshua Watt wrote:
> > If the clone target directory exists, but isn't the valid top level of =
a
> > bare git repo, it needs to be erased and re-cloned. One example of how
> > this can happen is if a clone creates the directory, but then fails to
> > actual clone and make it a git repository. This left-over directory can
> > be particularly problematic if the download directory is a descent of
> > some top layer git repo (e.g. the default with poky), as the commands
> > that operate on the remote later will then mangle the layers git
> > repository instead of the download git repo.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >  bitbake/lib/bb/fetch2/git.py | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.p=
y
> > index 2a3c06fe4e9..112bed294f0 100644
> > --- a/bitbake/lib/bb/fetch2/git.py
> > +++ b/bitbake/lib/bb/fetch2/git.py
> > @@ -65,6 +65,7 @@ import fnmatch
> >  import os
> >  import re
> >  import shlex
> > +import shutil
> >  import subprocess
> >  import tempfile
> >  import bb
> > @@ -365,8 +366,29 @@ class Git(FetchMethod):
> >                  runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
> >          repourl =3D self._get_repo_url(ud)
> >
> > +        needs_clone =3D False
> > +        if os.path.exists(ud.clonedir):
> > +            # The directory may exist, but not be the top level of a b=
are git
> > +            # repository in which case it needs to be deleted and re-c=
loned.
> > +            try:
> > +                # Since clones are bare, use --absolute-git-dir instea=
d of --show-toplevel
> > +                output =3D runfetchcmd("LANG=3DC %s rev-parse --absolu=
te-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> > +            except bb.fetch2.FetchError as e:
> > +                logger.warning("Unable to get top level for %s (not a =
git directory?): %s", ud.clonedir, e)
> > +                needs_clone =3D True
> > +            else:
> > +                toplevel =3D output.rstrip()
> > +                if os.path.abspath(toplevel) !=3D os.path.abspath(ud.c=
lonedir):
> > +                    logger.warning("Top level directory '%s' doesn't m=
atch expected '%s'. Re-cloning", toplevel, ud.clonedir)
> > +                    needs_clone =3D True
> > +
> > +            if needs_clone:
> > +                shutil.rmtree(ud.clonedir)
> > +        else:
> > +            needs_clone =3D True
> > +
> >          # If the repo still doesn't exist, fallback to cloning it
> > -        if not os.path.exists(ud.clonedir):
> > +        if needs_clone:
> >              # We do this since git will use a "-l" option automaticall=
y for local urls where possible,
> >              # but it doesn't work when git/objects is a symlink, only =
works when it is a directory.
> >              if repourl.startswith("file://"):
> > --
> > 2.33.0
> >
>
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14915): https://lists.openembedded.org/g/bitbake-de=
vel/message/14915
> > Mute This Topic: https://lists.openembedded.org/mt/100548945/3617179
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex=
andre.belloni@bootlin.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

