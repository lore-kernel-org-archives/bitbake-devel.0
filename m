Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED712CA5530
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 09:42:43 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.7814.1694598154026319911
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 02:42:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=LRea7iDa;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-31fa666000dso3105838f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694598152; x=1695202952; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V2IX38637BgGm2WMTwvCzuE5ERo62K/+qP3/0lSOqEU=;
        b=LRea7iDari5JuyUqOfdWJ91Twn0iiH5aspRC11W0tad9RwhD76cENaKsnQJbxidlLq
         OlUyb0ZfzyM66NWr7OZY+L99GH3m9rQt0ldlYROTB+zZua1VjU2+bFOOi/4djuETqjSl
         8SDijdt4xK2qqGfxQNE8WBZzH3cEuO1Yn8QXPRiNf44ygblmafWlfFgZU2mfKlerST4t
         TDJDOn83/5BcPCFb611SvdZfuLVxvlHXzIGQsDbVfpUwu/UNEaSZag11JMDkpfXVXm/l
         J6jtV5dHbR3U3VgbaNTDJRfM2phXJ1ZYgD2aNz88PaDIAWrtmlsdFgcjbEUSM64w0NM1
         r4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694598152; x=1695202952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2IX38637BgGm2WMTwvCzuE5ERo62K/+qP3/0lSOqEU=;
        b=SEv5WGeeznOA3LW57ZNxNm9kR7ixycjp+ZyuAno0ziYGk/fy59hpFiYslgVzChfxMe
         BOgH/fmwArxRvTVCD2ABkFYTOEwUQwB3xefjdDzAYBMC4QyHyNBlE47UsmeOSuY7VBsk
         Y1xg6jpiLs3SeJrHvqMhPC7B9CoYTzqF7FrdTpYJpP9dHE9GIwo57q4zbgbBpXDnCl5U
         Y+oNqeeZVk/BD7ifUCHw0z+14dWd/thrJhH6ioNeHf6H9BJ4T7LaTVAbOqIBjIzKzeai
         +oZCgeiDWyxfTmmxwjgeHQNBHxpd2/aF01R0f48hwYkt1/ynGYGb08YZIM6hxZPy8JKo
         SW4g==
X-Gm-Message-State: AOJu0YxUqXbdIr8Z6k3ldXjhRfCt4plKXyyWAWB4GvDdQnxBHNqqGtLq
	u6gz4dfKXigVeuspdSBslOW9b3p4KRIKLjLaLRI=
X-Google-Smtp-Source: AGHT+IF6T+3koAk6G5rJTh4kmkxWCHOewoB8AnbQtOow5btMorkQ/EmgPx00feYMXnWKyEaOmoPMQtsP6XUaLbEdwUs=
X-Received: by 2002:adf:f80b:0:b0:316:fb57:26d1 with SMTP id
 s11-20020adff80b000000b00316fb5726d1mr1701137wrp.8.1694598151674; Wed, 13 Sep
 2023 02:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230913084344.29928-1-mikko.rapeli@linaro.org>
 <969bbf65ba6459eedd8df5a3b2cc3f378fdf05d2.camel@linuxfoundation.org>
 <ZQF7NWTYQQvVX3JE@nuoska> <ee62b58ba8e8b1bd085631b8fdd55d0dad698b2e.camel@linuxfoundation.org>
In-Reply-To: <ee62b58ba8e8b1bd085631b8fdd55d0dad698b2e.camel@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 13 Sep 2023 11:42:15 +0200
Message-ID: <CA+chaQdO_cYPxeT1Ss1GhYdcWRenBy+1eYUH4675YdChqeTY4Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: revert path checks
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, bitbake-devel@lists.openembedded.org, 
	Joshua Watt <JPEWhacker@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000de21c606053a60e1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 09:42:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15046

--000000000000de21c606053a60e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FWIW: I'm also seeing warnings like:

WARNING: Top level directory
'/data001/work/downloads/git2/git.libssh.org.projects.libssh.git' doesn't
match expected
'/mnt/mirror-write/downloads/git2/git.libssh.org.projects.libssh.git'.
Re-cloning

Where /mnt/mirror-write/downloads/ is configured DL_DIR and
/data001/work/downloads/ was probably the DL_DIR of the jenkins jobs which
originally fetched the libssh and created the tarball with it for premirror=
.

Cheers,

On Wed, Sep 13, 2023 at 11:22=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2023-09-13 at 12:04 +0300, Mikko Rapeli wrote:
> > Hi,
> >
> > On Wed, Sep 13, 2023 at 09:51:39AM +0100, Richard Purdie wrote:
> > > On Wed, 2023-09-13 at 11:43 +0300, Mikko Rapeli wrote:
> > > > Commit 10f38157a069cb6938323cadd5e523037a29ace9
> > > > triggers re-clones of uptodate repositories when their
> > > > access path changes. This is wrong. It is enough that
> > > > needed commits are found from the git repo. For example
> > > > when same DL_DIR is accessed using two different paths
> > > > due to a symlink, then the resulting absolute paths will
> > > > differ but the content is the same. Trust the content.
> > > >
> > > > Avoids extra downloads of large repositories like linux-yocto
> > > > for kernel when the local cache was already uptodate.
> > > >
> > > > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> > > > ---
> > > >  bitbake/lib/bb/fetch2/git.py | 14 +-------------
> > > >  1 file changed, 1 insertion(+), 13 deletions(-)
> > > >
> > > > diff --git a/bitbake/lib/bb/fetch2/git.py
> b/bitbake/lib/bb/fetch2/git.py
> > > > index e11271b757..0c547ea303 100644
> > > > --- a/bitbake/lib/bb/fetch2/git.py
> > > > +++ b/bitbake/lib/bb/fetch2/git.py
> > > > @@ -371,19 +371,7 @@ class Git(FetchMethod):
> > > >              # The directory may exist, but not be the top level of
> a bare git
> > > >              # repository in which case it needs to be deleted and
> re-cloned.
> > > >              try:
> > > > -                # Since clones can be bare, use --absolute-git-dir
> instead of --show-toplevel
> > > > -                output =3D runfetchcmd("LANG=3DC %s rev-parse
> --absolute-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> > > > -
> > > > -                toplevel =3D os.path.abspath(output.rstrip())
> > > > -                abs_clonedir =3D
> os.path.abspath(ud.clonedir).rstrip('/')
> > > > -                # The top level Git directory must either be the
> clone directory
> > > > -                # or a child of the clone directory. Any ancestor
> directory of
> > > > -                # the clone directory is not valid as the Git
> directory (and
> > > > -                # probably belongs to some other unrelated
> repository), so a
> > > > -                # clone is required
> > > > -                if os.path.commonprefix([abs_clonedir, toplevel])
> !=3D abs_clonedir:
> > > > -                    logger.warning("Top level directory '%s'
> doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> > > > -                    needs_clone =3D True
> > > > +                runfetchcmd("LANG=3DC %s rev-parse
> --absolute-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> > > >              except bb.fetch2.FetchError as e:
> > > >                  logger.warning("Unable to get top level for %s (no=
t
> a git directory?): %s", ud.clonedir, e)
> > > >                  needs_clone =3D True
> > >
> > > Doesn't this give rise to some of the original issues (it could find =
a
> > > parent git repo instead of the one being cloned)?
> >
> > Yes, but this has not been a problem for me. Re-cloning existing fully
> cached
> > repositories is the effect I see.
> >
> > I think the git commit id and branch should decide if fetch or re-clone
> steps are needed.
> > The path of the repository should not matter. The git remotes also not.
> Both of those can
> > and do change.
>
> In that case you're effectively sending a revert and we should probably
> be clear about that...
>
> We really need to find a way to resolve things for everyone.
>
> Cheers,
>
> Richard
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15045):
> https://lists.openembedded.org/g/bitbake-devel/message/15045
> Mute This Topic: https://lists.openembedded.org/mt/101333074/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/leave/8021546/3617156/1661=
570722/xyzzy
> [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000de21c606053a60e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>FWIW: I&#39;m also seeing warnings like:</div><div><b=
r></div>WARNING: Top level directory &#39;/data001/work/downloads/git2/git.=
libssh.org.projects.libssh.git&#39; doesn&#39;t match expected &#39;/mnt/mi=
rror-write/downloads/git2/git.libssh.org.projects.libssh.git&#39;. Re-cloni=
ng<br><div><br></div><div>Where /mnt/mirror-write/downloads/ is configured=
=C2=A0DL_DIR and /data001/work/downloads/ was probably the DL_DIR of the je=
nkins jobs which originally fetched the libssh and created the tarball with=
 it for premirror.</div><div><br></div><div>Cheers,</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 13, 20=
23 at 11:22=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@=
linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 2023-09-13 a=
t 12:04 +0300, Mikko Rapeli wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Wed, Sep 13, 2023 at 09:51:39AM +0100, Richard Purdie wrote:<br>
&gt; &gt; On Wed, 2023-09-13 at 11:43 +0300, Mikko Rapeli wrote:<br>
&gt; &gt; &gt; Commit 10f38157a069cb6938323cadd5e523037a29ace9<br>
&gt; &gt; &gt; triggers re-clones of uptodate repositories when their<br>
&gt; &gt; &gt; access path changes. This is wrong. It is enough that<br>
&gt; &gt; &gt; needed commits are found from the git repo. For example<br>
&gt; &gt; &gt; when same DL_DIR is accessed using two different paths<br>
&gt; &gt; &gt; due to a symlink, then the resulting absolute paths will<br>
&gt; &gt; &gt; differ but the content is the same. Trust the content.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Avoids extra downloads of large repositories like linux-yoct=
o<br>
&gt; &gt; &gt; for kernel when the local cache was already uptodate.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Signed-off-by: Mikko Rapeli &lt;<a href=3D"mailto:mikko.rape=
li@linaro.org" target=3D"_blank">mikko.rapeli@linaro.org</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 bitbake/lib/bb/fetch2/git.py | 14 +-------------<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 13 deletions(-)<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/f=
etch2/git.py<br>
&gt; &gt; &gt; index e11271b757..0c547ea303 100644<br>
&gt; &gt; &gt; --- a/bitbake/lib/bb/fetch2/git.py<br>
&gt; &gt; &gt; +++ b/bitbake/lib/bb/fetch2/git.py<br>
&gt; &gt; &gt; @@ -371,19 +371,7 @@ class Git(FetchMethod):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # The direct=
ory may exist, but not be the top level of a bare git<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # repository=
 in which case it needs to be deleted and re-cloned.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # S=
ince clones can be bare, use --absolute-git-dir instead of --show-toplevel<=
br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out=
put =3D runfetchcmd(&quot;LANG=3DC %s rev-parse --absolute-git-dir&quot; % =
ud.basecmd, d, workdir=3Dud.clonedir)<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 top=
level =3D os.path.abspath(output.rstrip())<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abs=
_clonedir =3D os.path.abspath(ud.clonedir).rstrip(&#39;/&#39;)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # T=
he top level Git directory must either be the clone directory<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # o=
r a child of the clone directory. Any ancestor directory of<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # t=
he clone directory is not valid as the Git directory (and<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # p=
robably belongs to some other unrelated repository), so a<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # c=
lone is required<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
os.path.commonprefix([abs_clonedir, toplevel]) !=3D abs_clonedir:<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 logger.warning(&quot;Top level directory &#39;%s&#39; doesn&#39;=
t match expected &#39;%s&#39;. Re-cloning&quot;, toplevel, ud.clonedir)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 needs_clone =3D True<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run=
fetchcmd(&quot;LANG=3DC %s rev-parse --absolute-git-dir&quot; % ud.basecmd,=
 d, workdir=3Dud.clonedir)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except bb.fe=
tch2.FetchError as e:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 logger.warning(&quot;Unable to get top level for %s (not a git director=
y?): %s&quot;, ud.clonedir, e)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 needs_clone =3D True<br>
&gt; &gt; <br>
&gt; &gt; Doesn&#39;t this give rise to some of the original issues (it cou=
ld find a<br>
&gt; &gt; parent git repo instead of the one being cloned)?<br>
&gt; <br>
&gt; Yes, but this has not been a problem for me. Re-cloning existing fully=
 cached<br>
&gt; repositories is the effect I see.<br>
&gt; <br>
&gt; I think the git commit id and branch should decide if fetch or re-clon=
e steps are needed.<br>
&gt; The path of the repository should not matter. The git remotes also not=
. Both of those can<br>
&gt; and do change.<br>
<br>
In that case you&#39;re effectively sending a revert and we should probably=
<br>
be clear about that...<br>
<br>
We really need to find a way to resolve things for everyone.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15045): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15045" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15045</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/101333074/361=
7156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/101333074/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/leav=
e/8021546/3617156/1661570722/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.openembedded.org/g/bitbake-devel/leave/8021546/3617156/16615707=
22/xyzzy</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">m=
artin.jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000de21c606053a60e1--

