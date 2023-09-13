Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A342DEDEC6A
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 14:53:19 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.613.1694616795117569784
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 07:53:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=jUli1GYk;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so78438905e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694616793; x=1695221593; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tlVhAFOtr74nRz8G2uqtZido7kD1c+MmjiM2+lwQu9s=;
        b=jUli1GYkG2RHxKPE4wYlZoqa2lyal+waNk4dEA+i4tOESoumJbdMJmQq33IbvlPfCP
         boETXEdOE+NJ9yzoBWuES0erYf3R7pe/WOzlOaPmECQS/9WGpNOBRHBgxTS4oOpOTK3N
         SXp5YP5JjjFd5Sh2VGt+z97EhVsKAi8n1/HnBgE9Eb5W+82P4+nuILi3bZT6q4gz0e2b
         Ol2pj8hdoQezsnA9hggRLfs3BYWNXTvaDJADa/PFb0Psputb16C0rwhj/jpwkt215t6L
         uoNUxCT/a7eAiJh1GN7EhwfwMrDWADFcnmT50d5vm8xOELm/PiXg14r3JBq4OQj3L5jA
         YGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616793; x=1695221593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlVhAFOtr74nRz8G2uqtZido7kD1c+MmjiM2+lwQu9s=;
        b=awlfJcTlrlQkTvfeRewGUgLrnWIJq0wNHHwijA0lD6tf6Q5fgGcXBc3AX4sX3IlFZX
         wUmXyh/o+ofLbA5hM+PbIMsSpcbZ5h3GPrrJ3SGtpfHVLtNJD3uDEwSq+dcgP+Z35ALr
         E5JtoZG/ULxkNISWali544HDVFk4PKmRT13P6peIgT+q4LI4kcZlhC6uB0IRLdA5VJx4
         odXR3WesTRk0XSmYf+x74sn41Hegt0qvj5dh+FiT5mhQnAk3L/qH+DzMwYGV5y6CFZcW
         VMUS4NJZYZgG9CzMOu/qfUfKpPusRHPTDlVuUpY+/YCau054xXKzJS3zb1zcPFKOdlDl
         FYKg==
X-Gm-Message-State: AOJu0YwujycjMF5xkRkA+JaAhY6FpvEOx3SuJvWD9xv7fIS24wScTUKp
	teX3KxYix9FPKQa4URLYvMloQjPB/rzJ23pg448=
X-Google-Smtp-Source: AGHT+IGurU8UVPWYcwd5MN4BkKHstf0Yr78B9K5pnApIQOPxSI58UBWf5bxELAk/BllfHEc8hZEc1ffiKSLOG+XTliU=
X-Received: by 2002:adf:e548:0:b0:313:e953:65d0 with SMTP id
 z8-20020adfe548000000b00313e95365d0mr2421376wrm.28.1694616793195; Wed, 13 Sep
 2023 07:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230913084344.29928-1-mikko.rapeli@linaro.org>
 <969bbf65ba6459eedd8df5a3b2cc3f378fdf05d2.camel@linuxfoundation.org>
 <ZQF7NWTYQQvVX3JE@nuoska> <ee62b58ba8e8b1bd085631b8fdd55d0dad698b2e.camel@linuxfoundation.org>
 <CA+chaQdO_cYPxeT1Ss1GhYdcWRenBy+1eYUH4675YdChqeTY4Q@mail.gmail.com> <CAJdd5GbJh2YPppw-irio8NVmiMjhcb9XfX44LDw-+MUr5MSTvg@mail.gmail.com>
In-Reply-To: <CAJdd5GbJh2YPppw-irio8NVmiMjhcb9XfX44LDw-+MUr5MSTvg@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 13 Sep 2023 16:53:01 +0200
Message-ID: <CA+chaQf9TbgA_d62573A4v4Dr4zhuEv=524LLUnfadVPB5bdNQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: revert path checks
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000fd305c06053eb78b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 14:53:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15052

--000000000000fd305c06053eb78b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> not related to Mikkos problem.
> I think I have a fix for Mikkos symlink problem though

Maybe it is related in the end, to my surprise /mnt/mirror-write/downloads
is on some servers a symlink to /data001/work/downloads and then this
/mnt/mirror-write/download
is used as DL_DIR there (not /data001/work/downloads directly).

On Wed, Sep 13, 2023 at 4:45=E2=80=AFPM Joshua Watt <jpewhacker@gmail.com> =
wrote:

> On Wed, Sep 13, 2023 at 3:42=E2=80=AFAM Martin Jansa <martin.jansa@gmail.=
com>
> wrote:
> >
> > FWIW: I'm also seeing warnings like:
> >
> > WARNING: Top level directory
> '/data001/work/downloads/git2/git.libssh.org.projects.libssh.git' doesn't
> match expected
> '/mnt/mirror-write/downloads/git2/git.libssh.org.projects.libssh.git'.
> Re-cloning
> >
> > Where /mnt/mirror-write/downloads/ is configured DL_DIR and
> /data001/work/downloads/ was probably the DL_DIR of the jenkins jobs whic=
h
> originally fetched the libssh and created the tarball with it for premirr=
or.
>
> Ya, that /data001 path is _really_ weird. That path comes from running
> `git rev-parse --absolute-git-dir` in the extracted directory
> (ud.clonedir,
> '/mnt/mirror-write/downloads/git2/git.libssh.org.projects.libssh.git').
> The should be no absolute paths encoded in the mirror tarballs, so
> this seems like it's some sort of misconfiguration(?), and not related
> to Mikkos problem.
>
>
> I think I have a fix for Mikkos symlink problem though
>
> >
> > Cheers,
> >
> > On Wed, Sep 13, 2023 at 11:22=E2=80=AFAM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
> >>
> >> On Wed, 2023-09-13 at 12:04 +0300, Mikko Rapeli wrote:
> >> > Hi,
> >> >
> >> > On Wed, Sep 13, 2023 at 09:51:39AM +0100, Richard Purdie wrote:
> >> > > On Wed, 2023-09-13 at 11:43 +0300, Mikko Rapeli wrote:
> >> > > > Commit 10f38157a069cb6938323cadd5e523037a29ace9
> >> > > > triggers re-clones of uptodate repositories when their
> >> > > > access path changes. This is wrong. It is enough that
> >> > > > needed commits are found from the git repo. For example
> >> > > > when same DL_DIR is accessed using two different paths
> >> > > > due to a symlink, then the resulting absolute paths will
> >> > > > differ but the content is the same. Trust the content.
> >> > > >
> >> > > > Avoids extra downloads of large repositories like linux-yocto
> >> > > > for kernel when the local cache was already uptodate.
> >> > > >
> >> > > > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> >> > > > ---
> >> > > >  bitbake/lib/bb/fetch2/git.py | 14 +-------------
> >> > > >  1 file changed, 1 insertion(+), 13 deletions(-)
> >> > > >
> >> > > > diff --git a/bitbake/lib/bb/fetch2/git.py
> b/bitbake/lib/bb/fetch2/git.py
> >> > > > index e11271b757..0c547ea303 100644
> >> > > > --- a/bitbake/lib/bb/fetch2/git.py
> >> > > > +++ b/bitbake/lib/bb/fetch2/git.py
> >> > > > @@ -371,19 +371,7 @@ class Git(FetchMethod):
> >> > > >              # The directory may exist, but not be the top level
> of a bare git
> >> > > >              # repository in which case it needs to be deleted
> and re-cloned.
> >> > > >              try:
> >> > > > -                # Since clones can be bare, use
> --absolute-git-dir instead of --show-toplevel
> >> > > > -                output =3D runfetchcmd("LANG=3DC %s rev-parse
> --absolute-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> >> > > > -
> >> > > > -                toplevel =3D os.path.abspath(output.rstrip())
> >> > > > -                abs_clonedir =3D
> os.path.abspath(ud.clonedir).rstrip('/')
> >> > > > -                # The top level Git directory must either be th=
e
> clone directory
> >> > > > -                # or a child of the clone directory. Any
> ancestor directory of
> >> > > > -                # the clone directory is not valid as the Git
> directory (and
> >> > > > -                # probably belongs to some other unrelated
> repository), so a
> >> > > > -                # clone is required
> >> > > > -                if os.path.commonprefix([abs_clonedir,
> toplevel]) !=3D abs_clonedir:
> >> > > > -                    logger.warning("Top level directory '%s'
> doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> >> > > > -                    needs_clone =3D True
> >> > > > +                runfetchcmd("LANG=3DC %s rev-parse
> --absolute-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> >> > > >              except bb.fetch2.FetchError as e:
> >> > > >                  logger.warning("Unable to get top level for %s
> (not a git directory?): %s", ud.clonedir, e)
> >> > > >                  needs_clone =3D True
> >> > >
> >> > > Doesn't this give rise to some of the original issues (it could
> find a
> >> > > parent git repo instead of the one being cloned)?
> >> >
> >> > Yes, but this has not been a problem for me. Re-cloning existing
> fully cached
> >> > repositories is the effect I see.
> >> >
> >> > I think the git commit id and branch should decide if fetch or
> re-clone steps are needed.
> >> > The path of the repository should not matter. The git remotes also
> not. Both of those can
> >> > and do change.
> >>
> >> In that case you're effectively sending a revert and we should probabl=
y
> >> be clear about that...
> >>
> >> We really need to find a way to resolve things for everyone.
> >>
> >> Cheers,
> >>
> >> Richard
> >>
> >> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >> Links: You receive all messages sent to this group.
> >> View/Reply Online (#15045):
> https://lists.openembedded.org/g/bitbake-devel/message/15045
> >> Mute This Topic: https://lists.openembedded.org/mt/101333074/3617156
> >> Group Owner: bitbake-devel+owner@lists.openembedded.org
> >> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/leave/8021546/3617156/1661=
570722/xyzzy
> [martin.jansa@gmail.com]
> >> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >>
>

--000000000000fd305c06053eb78b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; not related=C2=A0to Mikkos problem.<br>&gt; I think I=
 have a fix for Mikkos symlink problem though<div><br></div><div>Maybe it i=
s related in the end, to my surprise=C2=A0/mnt/mirror-write/downloads is on=
 some servers a symlink to=C2=A0<span style=3D"color:rgb(80,0,80)">/data001=
/work/downloads and then this=C2=A0</span>/mnt/mirror-write/download is use=
d as DL_DIR there (not=C2=A0/data001/work/downloads directly).</div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed,=
 Sep 13, 2023 at 4:45=E2=80=AFPM Joshua Watt &lt;<a href=3D"mailto:jpewhack=
er@gmail.com">jpewhacker@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Wed, Sep 13, 2023 at 3:42=E2=80=AFAM M=
artin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com" target=3D"_blank"=
>martin.jansa@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; FWIW: I&#39;m also seeing warnings like:<br>
&gt;<br>
&gt; WARNING: Top level directory &#39;/data001/work/downloads/git2/git.lib=
ssh.org.projects.libssh.git&#39; doesn&#39;t match expected &#39;/mnt/mirro=
r-write/downloads/git2/git.libssh.org.projects.libssh.git&#39;. Re-cloning<=
br>
&gt;<br>
&gt; Where /mnt/mirror-write/downloads/ is configured DL_DIR and /data001/w=
ork/downloads/ was probably the DL_DIR of the jenkins jobs which originally=
 fetched the libssh and created the tarball with it for premirror.<br>
<br>
Ya, that /data001 path is _really_ weird. That path comes from running<br>
`git rev-parse --absolute-git-dir` in the extracted directory<br>
(ud.clonedir, &#39;/mnt/mirror-write/downloads/git2/git.libssh.org.projects=
.libssh.git&#39;).<br>
The should be no absolute paths encoded in the mirror tarballs, so<br>
this seems like it&#39;s some sort of misconfiguration(?), and not related<=
br>
to Mikkos problem.<br>
<br>
<br>
I think I have a fix for Mikkos symlink problem though<br>
<br>
&gt;<br>
&gt; Cheers,<br>
&gt;<br>
&gt; On Wed, Sep 13, 2023 at 11:22=E2=80=AFAM Richard Purdie &lt;<a href=3D=
"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdi=
e@linuxfoundation.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, 2023-09-13 at 12:04 +0300, Mikko Rapeli wrote:<br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Wed, Sep 13, 2023 at 09:51:39AM +0100, Richard Purdie wrot=
e:<br>
&gt;&gt; &gt; &gt; On Wed, 2023-09-13 at 11:43 +0300, Mikko Rapeli wrote:<b=
r>
&gt;&gt; &gt; &gt; &gt; Commit 10f38157a069cb6938323cadd5e523037a29ace9<br>
&gt;&gt; &gt; &gt; &gt; triggers re-clones of uptodate repositories when th=
eir<br>
&gt;&gt; &gt; &gt; &gt; access path changes. This is wrong. It is enough th=
at<br>
&gt;&gt; &gt; &gt; &gt; needed commits are found from the git repo. For exa=
mple<br>
&gt;&gt; &gt; &gt; &gt; when same DL_DIR is accessed using two different pa=
ths<br>
&gt;&gt; &gt; &gt; &gt; due to a symlink, then the resulting absolute paths=
 will<br>
&gt;&gt; &gt; &gt; &gt; differ but the content is the same. Trust the conte=
nt.<br>
&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; Avoids extra downloads of large repositories like l=
inux-yocto<br>
&gt;&gt; &gt; &gt; &gt; for kernel when the local cache was already uptodat=
e.<br>
&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; Signed-off-by: Mikko Rapeli &lt;<a href=3D"mailto:m=
ikko.rapeli@linaro.org" target=3D"_blank">mikko.rapeli@linaro.org</a>&gt;<b=
r>
&gt;&gt; &gt; &gt; &gt; ---<br>
&gt;&gt; &gt; &gt; &gt;=C2=A0 bitbake/lib/bb/fetch2/git.py | 14 +----------=
---<br>
&gt;&gt; &gt; &gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 13 deletions(=
-)<br>
&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; &gt; diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake=
/lib/bb/fetch2/git.py<br>
&gt;&gt; &gt; &gt; &gt; index e11271b757..0c547ea303 100644<br>
&gt;&gt; &gt; &gt; &gt; --- a/bitbake/lib/bb/fetch2/git.py<br>
&gt;&gt; &gt; &gt; &gt; +++ b/bitbake/lib/bb/fetch2/git.py<br>
&gt;&gt; &gt; &gt; &gt; @@ -371,19 +371,7 @@ class Git(FetchMethod):<br>
&gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # T=
he directory may exist, but not be the top level of a bare git<br>
&gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # r=
epository in which case it needs to be deleted and re-cloned.<br>
&gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try=
:<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # Since clones can be bare, use --absolute-git-dir instead of --show=
-toplevel<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 output =3D runfetchcmd(&quot;LANG=3DC %s rev-parse --absolute-git-di=
r&quot; % ud.basecmd, d, workdir=3Dud.clonedir)<br>
&gt;&gt; &gt; &gt; &gt; -<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 toplevel =3D os.path.abspath(output.rstrip())<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 abs_clonedir =3D os.path.abspath(ud.clonedir).rstrip(&#39;/&#39;)<br=
>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # The top level Git directory must either be the clone directory<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # or a child of the clone directory. Any ancestor directory of<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # the clone directory is not valid as the Git directory (and<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # probably belongs to some other unrelated repository), so a<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # clone is required<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if os.path.commonprefix([abs_clonedir, toplevel]) !=3D abs_clonedir:=
<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 logger.warning(&quot;Top level directory &#39;%s&#39; =
doesn&#39;t match expected &#39;%s&#39;. Re-cloning&quot;, toplevel, ud.clo=
nedir)<br>
&gt;&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 needs_clone =3D True<br>
&gt;&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 runfetchcmd(&quot;LANG=3DC %s rev-parse --absolute-git-dir&quot; % u=
d.basecmd, d, workdir=3Dud.clonedir)<br>
&gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exc=
ept bb.fetch2.FetchError as e:<br>
&gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 logger.warning(&quot;Unable to get top level for %s (not a git d=
irectory?): %s&quot;, ud.clonedir, e)<br>
&gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 needs_clone =3D True<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Doesn&#39;t this give rise to some of the original issue=
s (it could find a<br>
&gt;&gt; &gt; &gt; parent git repo instead of the one being cloned)?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Yes, but this has not been a problem for me. Re-cloning exist=
ing fully cached<br>
&gt;&gt; &gt; repositories is the effect I see.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I think the git commit id and branch should decide if fetch o=
r re-clone steps are needed.<br>
&gt;&gt; &gt; The path of the repository should not matter. The git remotes=
 also not. Both of those can<br>
&gt;&gt; &gt; and do change.<br>
&gt;&gt;<br>
&gt;&gt; In that case you&#39;re effectively sending a revert and we should=
 probably<br>
&gt;&gt; be clear about that...<br>
&gt;&gt;<br>
&gt;&gt; We really need to find a way to resolve things for everyone.<br>
&gt;&gt;<br>
&gt;&gt; Cheers,<br>
&gt;&gt;<br>
&gt;&gt; Richard<br>
&gt;&gt;<br>
&gt;&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;&gt; Links: You receive all messages sent to this group.<br>
&gt;&gt; View/Reply Online (#15045): <a href=3D"https://lists.openembedded.=
org/g/bitbake-devel/message/15045" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lists.openembedded.org/g/bitbake-devel/message/15045</a><br>
&gt;&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/1013=
33074/3617156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembed=
ded.org/mt/101333074/3617156</a><br>
&gt;&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openemb=
edded.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a>=
<br>
&gt;&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-d=
evel/leave/8021546/3617156/1661570722/xyzzy" rel=3D"noreferrer" target=3D"_=
blank">https://lists.openembedded.org/g/bitbake-devel/leave/8021546/3617156=
/1661570722/xyzzy</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=3D"=
_blank">martin.jansa@gmail.com</a>]<br>
&gt;&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;&gt;<br>
</blockquote></div>

--000000000000fd305c06053eb78b--

