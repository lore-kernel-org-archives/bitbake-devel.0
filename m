Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A603C61DA4
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 17:54:56 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.330.1678902887251013511
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 10:54:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=jBwcn+I/;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id j11so25291696lfg.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lyTFS04Ekp3FiaRZhGpyyril6LiNqzLgLSNrwdp/vSU=;
        b=jBwcn+I/EOdKenvcGHaTFCfQAcCa5iVQQ6pp6Tfleu0VW61tiRtqx0Zw4KUFFwErIo
         rCLZM0SjUoIOqk8rATVz4Yrdm9MNodkoGo4alJ4MtHDEn6lXJK9stj11Xa+BOykC5Jg3
         4u8r+HRFhTizOEE5FedS4h3Ce6Kzbz7NVBzf+xFIRAXoQtWe9E4TOLFqcVzMcf5USTLs
         tgBDwyHfW5RiTsXhsy8o31mFY6enVQ8llL3sfeoy+B5RhrTEJXEEnyTZhXamSNQJJTGd
         wDTdAM5kW9cK3R7yD1ZiJk2c2AD39XTi88Yq+8wGYYaNakVQ9p9WTtGjcnZurcI2JbFx
         zaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyTFS04Ekp3FiaRZhGpyyril6LiNqzLgLSNrwdp/vSU=;
        b=tiwpA5npDicL5DByfo7JY6kfZAjP9HRbAk57sm5FN9pz4uApVTdwmSR1VHMeooDyra
         Gdh2hIIDxFjGfqjFX3G0ECox+QWxqi8u4zmOSTkgcLQWLuyG+tijPwlyjfBBtvMd1e9K
         W5/kigvh0elnLkTdxnUWai5/sIhDTAueUWyMOyN/e7g3hPb8/HZ16xOUi447SBXPZSLY
         kvowR7EfdXhzz9Jh/Q3gsG+yLcqG6us4hD87hCj7fd8pXqp+gxrZ8bn8d6RGrfoaIbkH
         FwcLb6gh4PR9bZa6PBBaxt9Bgf5XZJgZLmFUgHsXSJkmM9/V39dX6Kx4PXJir+K9vTaP
         6Rkw==
X-Gm-Message-State: AO0yUKWR49LyCw+JK0Yu5UmJ5bCR5B/nzqVvHLtTuEuLzBNpp79UzZVt
	vR8einGnph6iBUj9oHAgx+g69UaGdu9Sx8/j94YVi/ez
X-Google-Smtp-Source: AK7set9JSVsD2gajYzN6g6AU6j43eW1ezewGuhPsLLw9nej8138/LwiMGiNGVXOc4ApnjCHxMzikd9kzp26BPR8K8Pg=
X-Received: by 2002:ac2:5102:0:b0:4e8:45d5:53cd with SMTP id
 q2-20020ac25102000000b004e845d553cdmr2197498lfb.12.1678902885176; Wed, 15 Mar
 2023 10:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
 <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
 <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com> <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com>
In-Reply-To: <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 15 Mar 2023 18:54:33 +0100
Message-ID: <CA+cAkepJt0FbV1Oq6ErCOA1qsa5DCmk=z9dACo+FrpCrj0vXvQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Alex Kiernan <alex.kiernan@gmail.com>
Cc: Martin Jansa <martin.jansa@gmail.com>, Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000155a9405f6f40a50"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 17:54:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14570

--000000000000155a9405f6f40a50
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just to tell that my concern was about making this checksum verification
not mandatory, if the recipe didn't specify any checksum for crates, my
modification will let it trough.

If we want to make it mandatory, we just have to make the method
"recommends_checksum" in crate.py return True instead of False.

Alex, when you talk about updating librsvg and cargo crate updater, do you
mind elaborate?

If there is some things to rework/add in my patches I'll be glad to do so
(if you tell me what is expected)

Le mer. 15 mars 2023, 18:43, Alex Kiernan <alex.kiernan@gmail.com> a =C3=A9=
crit :

> On Wed, Mar 15, 2023 at 5:08=E2=80=AFPM Martin Jansa <martin.jansa@gmail.=
com>
> wrote:
> >
> > On Wed, Mar 15, 2023 at 4:50=E2=80=AFPM Alexander Kanavin <
> alex.kanavin@gmail.com> wrote:
> >>
> >> On Wed, 15 Mar 2023 at 16:03, Alex Kiernan <alex.kiernan@gmail.com>
> wrote:
> >> > I really don't think this is the right direction, at least not by
> >> > default. If a crate is your primary build artefact then this is
> >> > useful:
> >> >
> >> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012
> >> >
> >> > But doing this for all the dependency crates we're just repeating
> >> > what's in the Cargo.lock which should always be part of the primary
> >> > artefact.
> >>
> >> Maybe cargo will verify (some) items against Cargo.lock. Maybe it
> >> won't. Upstream cargo isn't something we develop, and it may add and
> >> remove various exceptions and special cases.
> >>
> >> Anyway, we cannot actually trust cargo (unlike, say, git), and we need
> >> to do our own checks, and keep the checksums in files external to the
> >> source tree. This will free us from worrying about whether cargo
> >> protects us from supply chain attacks properly or not.
> >
> >
> > Also if bitbake fetcher detects unexpected checksum it can easily renam=
e
> the file in DL_DIR and try fetching it again, because that's what fetcher
> does for other downloads and fetcher "owns" DL_DIR.
> >
> > If cargo complains about unexpected checksum, than cargo fails and user
> will have to make sure that wrongly fetched crate is removed from DL_DIR.
> >
> > Regards,
>
> Okay, you're convincing me :) I've definitely tripped over that!
>
> I guess we need to update the cargo crate updater class and librsvg too.
>
> --
> Alex Kiernan
>

--000000000000155a9405f6f40a50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Just to tell that my concern was about making this c=
hecksum verification not mandatory, if the recipe didn&#39;t specify any ch=
ecksum for crates, my modification will let it trough.<div dir=3D"auto"><br=
></div><div dir=3D"auto">If we want to make it mandatory, we just have to m=
ake the method &quot;recommends_checksum&quot; in crate.py return True inst=
ead of False.</div><div dir=3D"auto"><br></div>Alex, when you talk about up=
dating librsvg and cargo crate updater, do you mind elaborate?=C2=A0</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">If there is some things to rew=
ork/add in my patches I&#39;ll be glad to do so (if you tell me what is exp=
ected)=C2=A0<br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr=
" class=3D"gmail_attr">Le mer. 15 mars 2023, 18:43, Alex Kiernan &lt;<a hre=
f=3D"mailto:alex.kiernan@gmail.com">alex.kiernan@gmail.com</a>&gt; a =C3=A9=
crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed, Mar 15, 2023 at=
 5:08=E2=80=AFPM Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">martin.jansa@gmail.com</a>&gt; wrote:=
<br>
&gt;<br>
&gt; On Wed, Mar 15, 2023 at 4:50=E2=80=AFPM Alexander Kanavin &lt;<a href=
=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank" rel=3D"noreferrer">ale=
x.kanavin@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, 15 Mar 2023 at 16:03, Alex Kiernan &lt;<a href=3D"mailto:a=
lex.kiernan@gmail.com" target=3D"_blank" rel=3D"noreferrer">alex.kiernan@gm=
ail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; I really don&#39;t think this is the right direction, at leas=
t not by<br>
&gt;&gt; &gt; default. If a crate is your primary build artefact then this =
is<br>
&gt;&gt; &gt; useful:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=
=3D15012" rel=3D"noreferrer noreferrer" target=3D"_blank">https://bugzilla.=
yoctoproject.org/show_bug.cgi?id=3D15012</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; But doing this for all the dependency crates we&#39;re just r=
epeating<br>
&gt;&gt; &gt; what&#39;s in the Cargo.lock which should always be part of t=
he primary<br>
&gt;&gt; &gt; artefact.<br>
&gt;&gt;<br>
&gt;&gt; Maybe cargo will verify (some) items against Cargo.lock. Maybe it<=
br>
&gt;&gt; won&#39;t. Upstream cargo isn&#39;t something we develop, and it m=
ay add and<br>
&gt;&gt; remove various exceptions and special cases.<br>
&gt;&gt;<br>
&gt;&gt; Anyway, we cannot actually trust cargo (unlike, say, git), and we =
need<br>
&gt;&gt; to do our own checks, and keep the checksums in files external to =
the<br>
&gt;&gt; source tree. This will free us from worrying about whether cargo<b=
r>
&gt;&gt; protects us from supply chain attacks properly or not.<br>
&gt;<br>
&gt;<br>
&gt; Also if bitbake fetcher detects unexpected checksum it can easily rena=
me the file in DL_DIR and try fetching it again, because that&#39;s what fe=
tcher does for other downloads and fetcher &quot;owns&quot; DL_DIR.<br>
&gt;<br>
&gt; If cargo complains about unexpected checksum, than cargo fails and use=
r will have to make sure that wrongly fetched crate is removed from DL_DIR.=
<br>
&gt;<br>
&gt; Regards,<br>
<br>
Okay, you&#39;re convincing me :) I&#39;ve definitely tripped over that!<br=
>
<br>
I guess we need to update the cargo crate updater class and librsvg too.<br=
>
<br>
-- <br>
Alex Kiernan<br>
</blockquote></div></div></div>

--000000000000155a9405f6f40a50--

