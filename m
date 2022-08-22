Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DC3C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 06:57:33 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.14937.1661151444282098920
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Aug 2022 23:57:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Q3tmCE9S;
 spf=pass (domain: gmail.com, ip: 209.85.167.53,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id q7so10263829lfu.5
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Aug 2022 23:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LGiLQrjqG4rBtL8vri99/BkBQBID4Etcfp57rmfc5oo=;
        b=Q3tmCE9SWzKa3imKLxk9HViNgZ9jg1bCAsg5TbVPFf/vhne1dMEWp9FTsBVY00N5SK
         aiWwg7eNZFwxULHW7Rq341zACvUY/bRjctCq+vOlG97RiR35eEREe/r0ZR3fPpcWmUGc
         CmsdhcIMjuXxXZ244ZEtuRay4zXxpEAdYsdaLeH/bhHf2v89Wq1a4UwFsqXlWuYPeTWF
         yoAdDItoK6Pm7H1M9XRo4xMUuIH8wNjd5P/e9SaNPor52S59zyryvYVpXm99gKriTjJ+
         ZG534GYYXK4D5SXUhh4tIPC2f99eUsb2bmF4bZwUqH1Ts90Nw4/fzHdyEZaGGw3od73M
         QFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LGiLQrjqG4rBtL8vri99/BkBQBID4Etcfp57rmfc5oo=;
        b=cjLS801bflwBgWBNx0Lhqfw6cKcvyCAETmhgtpqXm0I56Or/ttITlDNIhZG3ITfx4Y
         eIIAdHiXdZfmvTUxHz3Oco0Oawp68wu4aQqd6K43Mum1tZyAx9o2ApxiCUIhWTLHGy2i
         MiYGNnoiXaDDhD5zq1mSbdmhdV3E0/HBhm6C/z/1Qu7HJOpOWr8GDjUPpldChf97WPlc
         ulfEZE1wERZZYm3dQWu03vvg/xDyLiayRDTGMH8hWIBYiHW2LIopoaGjxuiGkB7Bijer
         UwOJl1sK6uiYBsyVXZZtVsVaqFrXxQmAjmrSyBZMVY2W8wKY5Dp8mXIYRBMeEGDKEU0n
         Ljyw==
X-Gm-Message-State: ACgBeo0pldubFA95PJgWDdwiBCT7a8IJnwBxrLyeIgCKFrxL+aDYrmfA
	OfXXwjbjYFrOwoVwuXuH4YNUjX0GpU8T2aeHc0M=
X-Google-Smtp-Source: 
 AA6agR4igYRmR2jnr1tXdWIR6uJfukRK0/NmYyJEO76Yc1Afid4W6HUukK3zLm2VT+7Z3S/gxB9ADpuVYGBqrJ8RFRg=
X-Received: by 2002:a05:6512:33d4:b0:48b:3a5f:e6e7 with SMTP id
 d20-20020a05651233d400b0048b3a5fe6e7mr6299249lfg.665.1661151442135; Sun, 21
 Aug 2022 23:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com>
 <YwMR+H8KWePvpJtn@korppu>
In-Reply-To: <YwMR+H8KWePvpJtn@korppu>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 22 Aug 2022 08:57:11 +0200
Message-ID: 
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
To: Mikko Rapeli <mikko.rapeli@bmw.de>
Cc: Martin.Jansa@gmail.com, bitbake-devel@lists.openembedded.org,
	marex@denx.de, peter.kjellerstedt@axis.com,
	richard.purdie@linuxfoundation.org
Content-Type: multipart/alternative; boundary="000000000000a06e7705e6cef516"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 06:57:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13911

--000000000000a06e7705e6cef516
Content-Type: text/plain; charset="UTF-8"

Can be solved with a parameter to a fetcher perhaps?

Alex

On Mon 22. Aug 2022 at 7.20, Mikko Rapeli <mikko.rapeli@bmw.de> wrote:

> Hi,
>
> On Sat, Aug 20, 2022 at 12:06:55PM +0000, Peter Kjellerstedt wrote:
> > > -----Original Message-----
> > > From: Marek Vasut <marex@denx.de>
> > > Sent: den 19 augusti 2022 18:55
> > > To: bitbake-devel@lists.openembedded.org
> > > Cc: Marek Vasut <marex@denx.de>; Martin Jansa <Martin.Jansa@gmail.com>;
> Peter Kjellerstedt <peter.kjellerstedt@axis.com>; Richard Purdie <
> richard.purdie@linuxfoundation.org>
> > > Subject: [PATCH] [RFC] fetch2/git: Prevent git fetcher from fetching
> gitlab repository metadata
> > >
> > > The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
> > > single object in the remote repository. This works poorly with gitlab
> > > and github, which use the remote git repository to track its metadata
> > > like merge requests, CI pipelines and such.
> > >
> > > Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
> > > and refs/keep-around/* and they all contain massive amount of data that
> > > are useless for the bitbake build purposes. The amount of useless data
> > > can in fact be so massive (e.g. with FDO mesa.git repository) that some
> > > proxies may outright terminate the 'git fetch' connection, and make it
> > > appear as if bitbake got stuck on 'git fetch' with no output.
> > >
> > > To avoid fetching all these useless metadata, tweak the git fetcher
> such
> > > that it only fetches refs/heads/* and refs/tags/* . Avoid using
> negative
> > > refspecs as those are only available in new git versions.
> > >
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: Martin Jansa <Martin.Jansa@gmail.com>
> > > Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > > Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > ---
> > >  lib/bb/fetch2/git.py | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > > index 4534bd75..b5fc0a51 100644
> > > --- a/lib/bb/fetch2/git.py
> > > +++ b/lib/bb/fetch2/git.py
> > > @@ -382,7 +382,7 @@ class Git(FetchMethod):
> > >                runfetchcmd("%s remote rm origin" % ud.basecmd, d,
> workdir=ud.clonedir)
> > >
> > >              runfetchcmd("%s remote add --mirror=fetch origin %s" %
> (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
> > > -            fetch_cmd = "LANG=C %s fetch -f --progress %s
> refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
> > > +            fetch_cmd = "LANG=C %s fetch -f --progress %s
> refs/heads/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd,
> shlex.quote(repourl))
> > >              if ud.proto.lower() != 'file':
> > >                  bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
> > >              progresshandler = GitProgressHandler(d)
> > > --
> > > 2.35.1
> >
> > Seems like the right thing to do. We use Gerrit, which also has its
> > metadata in special refs/ spaces. One repository I tested with grew
> > from 3 MB to 35 MB when I fetched using refs/* while another grew
> > from 20 MB to 120 MB, so there is definitely space and time to be
> > saved by only fetching the refs/heads and refs/tags spaces....
>
> As user of Gerrit, I fear this will cause problems. In my case developers
> are used to creating test topics and using git hashes in recipes which
> are not yet released, e.g. not yet in release branches or tags. This can of
> course create problems when such changes end up in real releases.
>
> Workaround is that developers can create throw away testing branches
> and refer to them in recipes.
>
> From one side this is an improvement to have less data in caches, but on
> the other side this adds extra actions to developers who want to test
> changes to their recipes. Can't decide which one is more important though
> :/
>
> Cheers,
>
> -Mikko
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13910):
> https://lists.openembedded.org/g/bitbake-devel/message/13910
> Mute This Topic: https://lists.openembedded.org/mt/93128921/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000a06e7705e6cef516
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Can be solved with a parameter to a fetcher perhaps?</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon 22. Aug 2022=
 at 7.20, Mikko Rapeli &lt;<a href=3D"mailto:mikko.rapeli@bmw.de">mikko.rap=
eli@bmw.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
padding-left:1ex;border-left-color:rgb(204,204,204)">Hi,<br>
<br>
On Sat, Aug 20, 2022 at 12:06:55PM +0000, Peter Kjellerstedt wrote:<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Marek Vasut &lt;<a href=3D"mailto:marex@denx.de" target=3D"=
_blank">marex@denx.de</a>&gt;<br>
&gt; &gt; Sent: den 19 augusti 2022 18:55<br>
&gt; &gt; To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" targe=
t=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
&gt; &gt; Cc: Marek Vasut &lt;<a href=3D"mailto:marex@denx.de" target=3D"_b=
lank">marex@denx.de</a>&gt;; Martin Jansa &lt;<a href=3D"mailto:Martin.Jans=
a@gmail.com" target=3D"_blank">Martin.Jansa@gmail.com</a>&gt;; Peter Kjelle=
rstedt &lt;<a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blank"=
>peter.kjellerstedt@axis.com</a>&gt;; Richard Purdie &lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxf=
oundation.org</a>&gt;<br>
&gt; &gt; Subject: [PATCH] [RFC] fetch2/git: Prevent git fetcher from fetch=
ing gitlab repository metadata<br>
&gt; &gt; <br>
&gt; &gt; The bitbake git fetcher currently fetches &#39;refs/*:refs/*&#39;=
, i.e. every<br>
&gt; &gt; single object in the remote repository. This works poorly with gi=
tlab<br>
&gt; &gt; and github, which use the remote git repository to track its meta=
data<br>
&gt; &gt; like merge requests, CI pipelines and such.<br>
&gt; &gt; <br>
&gt; &gt; Specifically, gitlab generates refs/merge-requests/*, refs/pipeli=
nes/*<br>
&gt; &gt; and refs/keep-around/* and they all contain massive amount of dat=
a that<br>
&gt; &gt; are useless for the bitbake build purposes. The amount of useless=
 data<br>
&gt; &gt; can in fact be so massive (e.g. with FDO mesa.git repository) tha=
t some<br>
&gt; &gt; proxies may outright terminate the &#39;git fetch&#39; connection=
, and make it<br>
&gt; &gt; appear as if bitbake got stuck on &#39;git fetch&#39; with no out=
put.<br>
&gt; &gt; <br>
&gt; &gt; To avoid fetching all these useless metadata, tweak the git fetch=
er such<br>
&gt; &gt; that it only fetches refs/heads/* and refs/tags/* . Avoid using n=
egative<br>
&gt; &gt; refspecs as those are only available in new git versions.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Marek Vasut &lt;<a href=3D"mailto:marex@denx.de" t=
arget=3D"_blank">marex@denx.de</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; Cc: Martin Jansa &lt;<a href=3D"mailto:Martin.Jansa@gmail.com" ta=
rget=3D"_blank">Martin.Jansa@gmail.com</a>&gt;<br>
&gt; &gt; Cc: Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@a=
xis.com" target=3D"_blank">peter.kjellerstedt@axis.com</a>&gt;<br>
&gt; &gt; Cc: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoun=
dation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<br=
>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 lib/bb/fetch2/git.py | 2 +-<br>
&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
&gt; &gt; index 4534bd75..b5fc0a51 100644<br>
&gt; &gt; --- a/lib/bb/fetch2/git.py<br>
&gt; &gt; +++ b/lib/bb/fetch2/git.py<br>
&gt; &gt; @@ -382,7 +382,7 @@ class Git(FetchMethod):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcm=
d(&quot;%s remote rm origin&quot; % ud.basecmd, d, workdir=3Dud.clonedir)<b=
r>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot=
;%s remote add --mirror=3Dfetch origin %s&quot; % (ud.basecmd, shlex.quote(=
repourl)), d, workdir=3Dud.clonedir)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch_cmd =3D &quot;LA=
NG=3DC %s fetch -f --progress %s refs/*:refs/*&quot; % (ud.basecmd, shlex.q=
uote(repourl))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetch_cmd =3D &quot;LA=
NG=3DC %s fetch -f --progress %s refs/heads/*:refs/heads/* refs/tags/*:refs=
/tags/*&quot; % (ud.basecmd, shlex.quote(repourl))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.proto.lower=
() !=3D &#39;file&#39;:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.=
fetch2.check_network_access(d, fetch_cmd, ud.url)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 progresshandler =
=3D GitProgressHandler(d)<br>
&gt; &gt; --<br>
&gt; &gt; 2.35.1<br>
&gt; <br>
&gt; Seems like the right thing to do. We use Gerrit, which also has its <b=
r>
&gt; metadata in special refs/ spaces. One repository I tested with grew <b=
r>
&gt; from 3 MB to 35 MB when I fetched using refs/* while another grew <br>
&gt; from 20 MB to 120 MB, so there is definitely space and time to be <br>
&gt; saved by only fetching the refs/heads and refs/tags spaces....<br>
<br>
As user of Gerrit, I fear this will cause problems. In my case developers<b=
r>
are used to creating test topics and using git hashes in recipes which<br>
are not yet released, e.g. not yet in release branches or tags. This can of=
<br>
course create problems when such changes end up in real releases.<br>
<br>
Workaround is that developers can create throw away testing branches<br>
and refer to them in recipes.<br>
<br>
From one side this is an improvement to have less data in caches, but on<br=
>
the other side this adds extra actions to developers who want to test<br>
changes to their recipes. Can&#39;t decide which one is more important thou=
gh :/<br>
<br>
Cheers,<br>
<br>
-Mikko<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13910): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13910" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13910</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/93128921/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/93128921/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000a06e7705e6cef516--

