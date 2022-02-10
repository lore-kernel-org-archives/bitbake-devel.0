Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB376C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 13:36:23 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.web08.9955.1644500182323238119
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 05:36:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=CqGdkvLh;
 spf=pass (domain: gmail.com, ip: 209.85.217.49,
 mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-vs1-f49.google.com with SMTP id r13so1858990vsg.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 05:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aq/C+KSjyeTm8A6smyEOV8z4Dw2BcJbIQ2ENRqOTB1g=;
        b=CqGdkvLhNUeIcotb0+43YXMTqXVwYWUa8rsd5T43RDagNTnqC7piFqrmJ/rxsyPF5m
         6JEMxUPBcfysxOw1qBUdSrWXoSLHCY2AUI6023L7g3Vv1ddl1CrzUE4rcrXqorMw8So6
         P3wsTbxRlgtOVpjVF81eCMYYtaCJRSQjlNzAPqxQHaVLCc9WE+CV15W8RQe+Ynz6VCj1
         0kJ170bOdZA1Y6ZjAccvBQtspU29JEVdwEv7vEoE1fmzrxg3dnU2MgF9wqq9XzbzKqy4
         zZOnqZZwLOqJwBSsrlcZV6iSkCeyeCEFS+sd+gR+PHNvsBcTZlvtvUNQxWmVPHpBqiZs
         5+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aq/C+KSjyeTm8A6smyEOV8z4Dw2BcJbIQ2ENRqOTB1g=;
        b=67wWAYFY57FhUW/jIrZ6mRi5wFH7oSN7aPvfzCO0+Yj6ozN/JVgkyL6vAQi14UAPH9
         H3XkbKcy3AW7nbcMQtlqhAXovAgsdOK5wBBOhy89vTmkFSKXLKFgo5e6h3DouuIwm0L/
         oL/F3I00EmYSLmfxSDdA/mJ8G/wQoSyiijp/AfAgVgjJK402NUOueoarNHKcQeOqJwom
         43t61tjL9a1XnJp27ouvxl/G2Phw6duWSRmxryj/lvpZQKVzR2ZlhsyX6nLU3udAZt+v
         1NIRvD7KrrdMdICfR/Rm99w2Ah1YIzfUZTLXLYNQUnvOdJzFWISeyTxbeFV3HVguQ3nw
         MzEA==
X-Gm-Message-State: AOAM531mlqOJvFVUCX97fxm1q6UUdgioiq10GmTOfAGESxQ4Ku1f1hvq
	r6mHZFrZBOlf71VV+1BId/sgR6VVdXGlRVZTFhM=
X-Google-Smtp-Source: 
 ABdhPJxKDh/uSCK1Sddp4kw8RmCDBf1+s5HplMJ2BFU10sdaDgcviyc+hL+SgknGhQcftWMpyW+Py9ejV12P1+r4BUE=
X-Received: by 2002:a05:6102:e85:: with SMTP id
 l5mr2357752vst.72.1644500181350;
 Thu, 10 Feb 2022 05:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20220210132714.22921-1-tomasz.dziendzielski@gmail.com>
 <CANNYZj86ijf96uT3umpXywktF3X27vjeS1PAUULeNGP9neVrJA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj86ijf96uT3umpXywktF3X27vjeS1PAUULeNGP9neVrJA@mail.gmail.com>
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Date: Thu, 10 Feb 2022 14:39:31 +0100
Message-ID: 
 <CAJkqNs1Ko1Jmvbw2hKcEsmn6FwZy8vw34qXthbMHKo2=_ymHXA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/git.py: Check if clonedir is
 correct after shallow tarball clone
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Pavel Zhukov <pavel@zhukoff.net>,
	Jan Brzezanski <jan.brzezanski@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000247cd205d7aa09cf"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 13:36:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13330

--000000000000247cd205d7aa09cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
right now code accepts failing tar and just runs fallback (which is git
clone). If there is any tar failure then it also needs to be fixed but even
so we don't want bitbake to override our git remote.

Best regards,
Tomasz Dziendzielski

czw., 10 lut 2022 o 14:31 Alexander Kanavin <alex.kanavin@gmail.com>
napisa=C5=82(a):

> Wait, doesn't this mask the real issue? Is it ok that the tarball
> unpacking failed 'for any reason'?
>
> Alex
>
> On Thu, 10 Feb 2022 at 14:27, Tomasz Dziendzielski
> <tomasz.dziendzielski@gmail.com> wrote:
> >
> > If shallow tarball clone is used and if tar unpacking fails for any
> > reason it might end up with empty directory created. Since runfetchcmd
> > does not check any return code we might not detect the issue and we wil=
l
> > not clone from git. Then due to missing hash it will replace main
> > repository's git remote with the remote of failing recipe.
> >
> > To fix this behaviour we'll check if clonedir is not empty and if git
> > dir is the same as clonedir.
> >
> > Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> > Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
> > ---
> >  lib/bb/fetch2/git.py | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index 30da8e95..ed6ecb64 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -356,8 +356,15 @@ class Git(FetchMethod):
> >
> >          repourl =3D self._get_repo_url(ud)
> >
> > -        # If the repo still doesn't exist, fallback to cloning it
> > -        if not os.path.exists(ud.clonedir):
> > +        # Clean repo if git dir is different than ud.clonedir, which
> means tar unpacking failed
> > +        if os.path.exists(ud.clonedir):
> > +            if ud.clonedir !=3D runfetchcmd("%s -C %s rev-parse
> --git-dir" % (ud.basecmd, ud.clonedir), d):
> > +                bb.utils.remove(ud.clonedir, recurse=3DTrue)
> > +                bb.utils.mkdirhier(ud.clonedir)
> > +                os.chdir(ud.clonedir)
> > +
> > +        # If the repo still doesn't exist or is empty, fallback to
> cloning it
> > +        if not os.path.exists(ud.clonedir) or not
> os.listdir(ud.clonedir):
> >              # We do this since git will use a "-l" option automaticall=
y
> for local urls where possible
> >              if repourl.startswith("file://"):
> >                  repourl =3D repourl[7:]
> > --
> > 2.34.1
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#13328):
> https://lists.openembedded.org/g/bitbake-devel/message/13328
> > Mute This Topic: https://lists.openembedded.org/mt/89045076/1686489
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>

--000000000000247cd205d7aa09cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><div>right now code accepts failing tar =
and just runs fallback (which is git clone). If there is any tar failure th=
en it also needs to be fixed but even so we don&#39;t want bitbake to overr=
ide our git remote.</div><div><br></div><div>Best regards,</div><div>Tomasz=
 Dziendzielski<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">czw., 10 lut 2022 o 14:31=C2=A0Alexander Kanavin &l=
t;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt; =
napisa=C5=82(a):<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Wait, doesn&#39;t this mask the real issue? Is it ok that the tarball<br>
unpacking failed &#39;for any reason&#39;?<br>
<br>
Alex<br>
<br>
On Thu, 10 Feb 2022 at 14:27, Tomasz Dziendzielski<br>
&lt;<a href=3D"mailto:tomasz.dziendzielski@gmail.com" target=3D"_blank">tom=
asz.dziendzielski@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; If shallow tarball clone is used and if tar unpacking fails for any<br=
>
&gt; reason it might end up with empty directory created. Since runfetchcmd=
<br>
&gt; does not check any return code we might not detect the issue and we wi=
ll<br>
&gt; not clone from git. Then due to missing hash it will replace main<br>
&gt; repository&#39;s git remote with the remote of failing recipe.<br>
&gt;<br>
&gt; To fix this behaviour we&#39;ll check if clonedir is not empty and if =
git<br>
&gt; dir is the same as clonedir.<br>
&gt;<br>
&gt; Signed-off-by: Tomasz Dziendzielski &lt;<a href=3D"mailto:tomasz.dzien=
dzielski@gmail.com" target=3D"_blank">tomasz.dziendzielski@gmail.com</a>&gt=
;<br>
&gt; Signed-off-by: Jan Brzezanski &lt;<a href=3D"mailto:jan.brzezanski@gma=
il.com" target=3D"_blank">jan.brzezanski@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/git.py | 11 +++++++++--<br>
&gt;=C2=A0 1 file changed, 9 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
&gt; index 30da8e95..ed6ecb64 100644<br>
&gt; --- a/lib/bb/fetch2/git.py<br>
&gt; +++ b/lib/bb/fetch2/git.py<br>
&gt; @@ -356,8 +356,15 @@ class Git(FetchMethod):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repourl =3D self._get_repo_url(ud)<b=
r>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If the repo still doesn&#39;t exist, fa=
llback to cloning it<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(ud.clonedir):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Clean repo if git dir is different than=
 ud.clonedir, which means tar unpacking failed<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(ud.clonedir):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.clonedir !=3D runfetc=
hcmd(&quot;%s -C %s rev-parse --git-dir&quot; % (ud.basecmd, ud.clonedir), =
d):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.remo=
ve(ud.clonedir, recurse=3DTrue)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.mkdi=
rhier(ud.clonedir)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(ud.c=
lonedir)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If the repo still doesn&#39;t exist or =
is empty, fallback to cloning it<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(ud.clonedir) or not=
 os.listdir(ud.clonedir):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # We do this since git=
 will use a &quot;-l&quot; option automatically for local urls where possib=
le<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if repourl.startswith(=
&quot;file://&quot;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repourl =
=3D repourl[7:]<br>
&gt; --<br>
&gt; 2.34.1<br>
&gt;<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#13328): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/13328" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.openembedded.org/g/bitbake-devel/message/13328</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/89045076=
/1686489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.o=
rg/mt/89045076/1686489</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org=
/g/bitbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" targe=
t=3D"_blank">alex.kanavin@gmail.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
</blockquote></div>

--000000000000247cd205d7aa09cf--

