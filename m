Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DEBC3DA6F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 19:54:21 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.1187.1692906856768777302
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 12:54:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=CUzxESdI;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bcc331f942so3486531fa.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692906855; x=1693511655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7dCeaZkkCCeu7PU/G+WAk/iFTiDLqOmiRAj1U7rBc8=;
        b=CUzxESdIteolrwFQxdClUz2+umkY8qDnwEvVS96B6ziEluwnS0DtMoEQimXdxgUbRe
         1uPXPr898tbuaiqmzprda/4bYYKZHwPwLbp4ZVPXoVTcpUJGUSc0VMxP3zCdaAMcZZll
         Fi6fLxQWRwvBVYThm9dt2NF7EY/gN+QCYjsAV7st+xCTNLvGkY5onn5cc/xGRpN1NJDj
         RSEZYX8nA9atTl5m8qt5DhVjhOa6KSMKnnajzdZUfcRStJL3Hu/f1m03AyJmkfVB1Z4G
         Udj2uVg1lgJb4cTEmdqucl7yArwlf3/q+oBF2IYKwjgUAAm5vkZJSTZjEBuFeRgMLRQO
         zYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692906855; x=1693511655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7dCeaZkkCCeu7PU/G+WAk/iFTiDLqOmiRAj1U7rBc8=;
        b=HWeXgIuY+ksZVyOWt0bobBZemhtFyqq0uNujYySbcsp1AkKHGJagDK2z4voMtoNcqz
         vqMUsqJrU0f5qjqpYP5UpTTBsKvwow9qiWB/Dyjzf95zz3NJuwEo5tEX0RjUFNnuqNMX
         Qidl9pCAZcLqA5jCJtaNR+qRhfUqz9eXuTOr4CMGUPz1epuDdphXQSmaG7pfde0CyuHN
         UrAHXCHxM/qUF/HRI4tTCfldZJm5FtZ2d0k1f0zhNSGNiESZBMHVGg8lNOYBDo2RCLhn
         jtx3RVJZ9jss8YYSdp5Gth4Qyuw9xFmnhauyjxEpAsN2MPL0Vd/r9aEBdpt+gMvGsSTb
         cuqg==
X-Gm-Message-State: AOJu0YxnK7D9HLgP0o7qtgvKRW+ohCwk+1UB+DscWIFHiXYAGW/mIoz3
	8lhlDdZ+crEcgtjQWnC7Q4MElxQacrrcYBG5X80=
X-Google-Smtp-Source: AGHT+IHlwRjCRlXXP8MGXIA8vFYNol9R5gvxRmlxaYSZ3zS2YHmNCOrBp0CKX4S5k+mErPdXCMMoTqWswhMzS7c9iZ4=
X-Received: by 2002:a05:651c:11c5:b0:2bc:e94e:fda0 with SMTP id
 z5-20020a05651c11c500b002bce94efda0mr952385ljo.5.1692906854562; Thu, 24 Aug
 2023 12:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230804155424.1502010-1-JPEWhacker@gmail.com>
 <2023080901520013144e1b@mail.local> <CAJdd5GYK-dr6vf3a_O_hgQ-gLt1WkHwcwwyH5fD4+d423MzAcg@mail.gmail.com>
 <177C44DDA5F18A0D.21730@lists.openembedded.org> <202308191221252f22058b@mail.local>
In-Reply-To: <202308191221252f22058b@mail.local>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 24 Aug 2023 13:54:02 -0600
Message-ID: <CAJdd5GZtW8hpXgnKq3=X_ZS4F0UuSbaMT+=+0v+iDzOmxK306A@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] fetch2: git: Check if directory is a bare
 git repo
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 19:54:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14980

On Sat, Aug 19, 2023 at 6:21=E2=80=AFAM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> This was because I didn't point to the correct build error:

Yep, fixed in V2 (and I validated that the tests pass locally also)

>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ERROR: test_mirror_commit_exists (bb.tests.fetch.FetchPremirroronlyLocalT=
est.test_mirror_commit_exists)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib=
/bb/tests/fetch.py", line 3075, in test_mirror_commit_exists
>     fetcher.download()
>   File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib=
/bb/fetch2/__init__.py", line 1746, in download
>     done =3D m.try_mirrors(self, ud, self.d, mirrors)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib=
/bb/fetch2/__init__.py", line 1612, in try_mirrors
>     return bool(try_mirrors(fetch, d, urldata, mirrors, check))
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib=
/bb/fetch2/__init__.py", line 1136, in try_mirrors
>     ret =3D try_mirror_url(fetch, origud, uds[index], ld, check)
>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib=
/bb/fetch2/__init__.py", line 1065, in try_mirror_url
>     origud.method.download(origud, ld)
>   File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib=
/bb/fetch2/git.py", line 401, in download
>     bb.fetch2.check_network_access(d, clone_cmd, ud.url)
>   File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib=
/bb/fetch2/__init__.py", line 944, in check_network_access
>     raise NetworkAccess(url, info)
> bb.fetch2.NetworkAccess: Network access disabled through BB_NO_NETWORK (o=
r set indirectly due to use of BB_FETCH_PREMIRRORONLY) but access requested=
 with command LANG=3DC git -c gc.autoDetach=3Dfalse -c core.pager=3Dcat clo=
ne --bare --mirror https://git.fake.repo/bitbake /tmp/bitbake-fetch-xeon98f=
f/download/git2/git.fake.repo.bitbake --progress (for url git://git.fake.re=
po/bitbake;branch=3Dmaster;protocol=3Dhttps)
>
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/5619/st=
eps/11/logs/stdio
> https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5577/st=
eps/11/logs/stdio
> https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1935/s=
teps/11/logs/stdio
> https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/5653/st=
eps/11/logs/stdio
>
>
> On 17/08/2023 22:14:34+0200, Alexandre Belloni via lists.openembedded.org=
 wrote:
> > On 17/08/2023 13:19:56-0600, Joshua Watt wrote:
> > > Alexandre,
> > >
> > > I'm not sure that's quite correct; I was able to run the test fine
> > > locally, and that failure looks like a 502 error from the server,
> > > which really shouldn't have anything to do with this patch?
> > >
> >
> > I'm pretty sure you are right...
> >
> > > On Tue, Aug 8, 2023 at 7:52=E2=80=AFPM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > >
> > > > Hello Joshua,
> > > >
> > > > I'm fairly sure this causes the following bitbake-selftest failure:
> > > >
> > > > https://autobuilder.yoctoproject.org/typhoon/#/builders/56/builds/2=
307/steps/11/logs/stdio
> > > >
> > > > On 04/08/2023 09:54:24-0600, Joshua Watt wrote:
> > > > > If the clone target directory exists, but isn't the valid top lev=
el of a
> > > > > bare git repo, it needs to be erased and re-cloned. One example o=
f how
> > > > > this can happen is if a clone creates the directory, but then fai=
ls to
> > > > > actual clone and make it a git repository. This left-over directo=
ry can
> > > > > be particularly problematic if the download directory is a descen=
t of
> > > > > some top layer git repo (e.g. the default with poky), as the comm=
ands
> > > > > that operate on the remote later will then mangle the layers git
> > > > > repository instead of the download git repo.
> > > > >
> > > > > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > > > > ---
> > > > >  bitbake/lib/bb/fetch2/git.py | 24 +++++++++++++++++++++++-
> > > > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2=
/git.py
> > > > > index 2a3c06fe4e9..112bed294f0 100644
> > > > > --- a/bitbake/lib/bb/fetch2/git.py
> > > > > +++ b/bitbake/lib/bb/fetch2/git.py
> > > > > @@ -65,6 +65,7 @@ import fnmatch
> > > > >  import os
> > > > >  import re
> > > > >  import shlex
> > > > > +import shutil
> > > > >  import subprocess
> > > > >  import tempfile
> > > > >  import bb
> > > > > @@ -365,8 +366,29 @@ class Git(FetchMethod):
> > > > >                  runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
> > > > >          repourl =3D self._get_repo_url(ud)
> > > > >
> > > > > +        needs_clone =3D False
> > > > > +        if os.path.exists(ud.clonedir):
> > > > > +            # The directory may exist, but not be the top level =
of a bare git
> > > > > +            # repository in which case it needs to be deleted an=
d re-cloned.
> > > > > +            try:
> > > > > +                # Since clones are bare, use --absolute-git-dir =
instead of --show-toplevel
> > > > > +                output =3D runfetchcmd("LANG=3DC %s rev-parse --=
absolute-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> > > > > +            except bb.fetch2.FetchError as e:
> > > > > +                logger.warning("Unable to get top level for %s (=
not a git directory?): %s", ud.clonedir, e)
> > > > > +                needs_clone =3D True
> > > > > +            else:
> > > > > +                toplevel =3D output.rstrip()
> > > > > +                if os.path.abspath(toplevel) !=3D os.path.abspat=
h(ud.clonedir):
> > > > > +                    logger.warning("Top level directory '%s' doe=
sn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> > > > > +                    needs_clone =3D True
> > > > > +
> > > > > +            if needs_clone:
> > > > > +                shutil.rmtree(ud.clonedir)
> > > > > +        else:
> > > > > +            needs_clone =3D True
> > > > > +
> > > > >          # If the repo still doesn't exist, fallback to cloning i=
t
> > > > > -        if not os.path.exists(ud.clonedir):
> > > > > +        if needs_clone:
> > > > >              # We do this since git will use a "-l" option automa=
tically for local urls where possible,
> > > > >              # but it doesn't work when git/objects is a symlink,=
 only works when it is a directory.
> > > > >              if repourl.startswith("file://"):
> > > > > --
> > > > > 2.33.0
> > > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > >
> > > >
> > > > --
> > > > Alexandre Belloni, co-owner and COO, Bootlin
> > > > Embedded Linux and Kernel engineering
> > > > https://bootlin.com
> >
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
>
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14952): https://lists.openembedded.org/g/bitbake-de=
vel/message/14952
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

