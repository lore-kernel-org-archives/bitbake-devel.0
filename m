Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE79C433F5
	for <webhook@archiver.kernel.org>; Wed,  2 Feb 2022 14:59:24 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.65404.1643813963651892155
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Feb 2022 06:59:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=bo86pslc;
 spf=pass (domain: gmail.com, ip: 209.85.167.54,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id bu18so41239795lfb.5
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Feb 2022 06:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1xgvorG0n18oiMCPQvHaasnpAq4znWthe+9ZLXA+ao=;
        b=bo86pslceEpxaES7jEVpx8kTppUSCWtYfB3ZpyRXhplvu33GheSDWXoKK1Dwzxu0fk
         whmth85TdFtbSyqysRyKIUaVxq9m+WpZLNLsySL4PIsF77Prqir3OHDPM7dbJVUU7BEt
         XGgf0tevF9jGx8bpf2FtnTmsf8PcHQrihbI0XHAzcHg+IbGIhqORcBkq8cgG0pbMxw97
         Wy74s2MPf4qblS8TkGPGK1XiP/PvvpHSkCky4J9gKHGNgC/0gSd/tZaFB2WhLR7nBTgV
         qENfc6je1e1H7Ww6H50N2cV9f9ps0aI+LUQo5yKR8Ae1lNXkYa+8+ZjBYvo9bE8yqVBb
         ArJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1xgvorG0n18oiMCPQvHaasnpAq4znWthe+9ZLXA+ao=;
        b=CzOwIGX48fiftuF0KqkD6oGLe7QZX9sp44rumApyIGPaRP4fFI5rg7qgYLA2EiqARL
         KstDufTjoHQkpqnCepURd8DA4wOzS/phLGFslla5+2w4i7v2cbLLmHPIWy8r1U2PlW+R
         yigZ7B/tgDBvcCg4tsG4p4WwUNedaWLh93OtacuUklr7UaztfE/utZfGfWzzfbXkxKAX
         QwlyjbkCwMFsJdt5TRSuaK+S84R90gnExwNxyPFl56RNx9MQsuiHiJEplpdHq6C10NI0
         YuYKWGoNe29fc0bqEHXlJsegsUhzNqsgtYdx6XKKFFIpMVVTCatDIY+Ylj0AFAI/Dw7p
         zCOw==
X-Gm-Message-State: AOAM5324iX3GVx0Uzc+eNYYGvNEoUMcedcsR+9koNqPSfoyQiwK3OiW9
	Y0i8noKvqwJ37pDXtekcbS/QSrXbOgdp0khXepA=
X-Google-Smtp-Source: 
 ABdhPJx6Y7kixbyxIY7r2BWYOhXYDXRJi4rsyl6NKp1YIpFppEgp3W5djCb9rv/rhOVSLSf5mipvQA7+gBTuI4/dG78=
X-Received: by 2002:a05:6512:368f:: with SMTP id
 d15mr22344998lfs.447.1643813961795;
 Wed, 02 Feb 2022 06:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
 <CANPvuR=EyqMnkSG-niP8GAOnT2jEun63iz4Fpa4RU8isTc-ezg@mail.gmail.com>
 <3a672c37d4cd375fed43b59d887c9dcd17c60ee8.camel@linuxfoundation.org>
 <CANPvuRk3=Hd7tiEy4WFE+GK7x55rKsvrR+yE1NSbSgVUYQUJnw@mail.gmail.com>
 <1699ebd54f3414641b7ff78e1cec2bc546b658cf.camel@linuxfoundation.org>
In-Reply-To: 
 <1699ebd54f3414641b7ff78e1cec2bc546b658cf.camel@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 2 Feb 2022 14:59:10 +0000
Message-ID: 
 <CANPvuRn14mNkP4PG6mDi_AiDWgVOu9MSVxD6PAHe8a_92GhPmQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] utils: Add disable_network function
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000450d0305d70a43d0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Feb 2022 14:59:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13308

--000000000000450d0305d70a43d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia quarta,
2/02/2022 =C3=A0(s) 13:43:

> On Wed, 2022-02-02 at 12:38 +0000, Jose Quaresma wrote:
> > Hi Richard,
> >
> > I think that the usage of the unshare system call can replace the use o=
f
> > pseudo on bitbake.
> > If we map the new user namespace to the superuser we can do what is
> bean done
> > nowadays
> > inside the pseudo or not ?
> >        -r, --map-root-user
> >            Run the program only after the current effective user and
> >            group IDs have been mapped to the superuser UID and GID in
> >            the newly created user namespace. This makes it possible to
> >            conveniently gain capabilities needed to manage various
> >            aspects of the newly created namespaces (such as configuring
> >            interfaces in the network namespace or mounting filesystems
> >            in the mount namespace) even when run unprivileged. As a mer=
e
> >            convenience feature, it does not support more sophisticated
> >            use cases, such as mapping multiple ranges of UIDs and GIDs.
> >            This option implies --setgroups=3Ddeny and --user. This opti=
on
> >            is equivalent to --map-user=3D0 --map-group=3D0.
> > https://man7.org/linux/man-pages/man1/unshare.1.html
> >
>
> I wondered about that and I would love for it to be true however it isn't
> that
> simple.
>
> With pseudo we emulate multiple different users and a separate
> passwd/group file
> with those users in it. The unshare call would map the current user to
> root but
> it doesn't give us other user IDs or groups to chown/chgrp files to, at
> least as
> I understand it.
>

It was also sounding too simple to be true.
I will try to better understand this part of the chown/chgrp usage on
pseudo.
Thank you for the clarification.


>
> Cheers,
>
> Richard
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000450d0305d70a43d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&=
gt; escreveu no dia quarta, 2/02/2022 =C3=A0(s) 13:43:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Wed, 2022-02-02 at 12:38 +0000, J=
ose Quaresma wrote:<br>
&gt; Hi Richard,<br>
&gt; <br>
&gt; I think that the=C2=A0usage=C2=A0of the unshare system call can replac=
e the use of<br>
&gt; pseudo on bitbake.<br>
&gt; If we map the new user namespace to the superuser we can do what is be=
an=C2=A0done<br>
&gt; nowadays=C2=A0<br>
&gt; inside the=C2=A0pseudo=C2=A0or not ?<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-r, --map-root-user<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Run =
the program only after the current effective user and<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0grou=
p IDs have been mapped to the superuser UID and GID in<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the =
newly created user namespace. This makes it possible to<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0conv=
eniently gain capabilities needed to manage various<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aspe=
cts of the newly created namespaces (such as configuring<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inte=
rfaces in the network namespace or mounting filesystems<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0in t=
he mount namespace) even when run unprivileged. As a mere<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0conv=
enience feature, it does not support more sophisticated<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0use =
cases, such as mapping multiple ranges of UIDs and GIDs.<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This=
 option implies --setgroups=3Ddeny and --user. This option<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0is e=
quivalent to --map-user=3D0 --map-group=3D0.<br>
&gt; <a href=3D"https://man7.org/linux/man-pages/man1/unshare.1.html" rel=
=3D"noreferrer" target=3D"_blank">https://man7.org/linux/man-pages/man1/uns=
hare.1.html</a><br>
&gt; <br>
<br>
I wondered about that and I would love for it to be true however it isn&#39=
;t that<br>
simple.<br>
<br>
With pseudo we emulate multiple different users and a separate passwd/group=
 file<br>
with those users in it. The unshare call would map the current user to root=
 but<br>
it doesn&#39;t give us other user IDs or groups to chown/chgrp files to, at=
 least as<br>
I understand it.<br></blockquote><div><br></div><div>It was also sounding t=
oo simple to be true.<br></div><div>I will try to better understand this pa=
rt of the chown/chgrp usage on pseudo.<br></div><div>Thank you for the clar=
ification.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div>

--000000000000450d0305d70a43d0--

