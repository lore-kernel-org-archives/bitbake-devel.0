Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947ECC433FE
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 19:20:21 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by mx.groups.io with SMTP id smtpd.web08.4459.1636658420508301666
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 11:20:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lmh9AFjP;
 spf=pass (domain: gmail.com, ip: 209.85.222.42,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f42.google.com with SMTP id e10so14098482uab.3;
        Thu, 11 Nov 2021 11:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKC8Kh1ajafubHHeZ9/9PODH2lX7MWX7Fb6ysrZMlZ0=;
        b=lmh9AFjPl7i2/rTy9MMC0kz9rSeSPWQjvkKTHz1hFI8MsP3QISbzpSI4RWHGe78KfL
         Fo82WhCzHbAoTjtor6RBB6BMc1JORSxvuMe/EeLFIjP6Mu/9QpGWTzpv5s6FGJ2nW3T+
         PjNDtRttwmyaz0KgPZ6Pg63WBmP1q/tkjY35dSTrIxRk8ZS8tZTpyK4FsKfAugQdAFRJ
         7n/5vTtCJgfrF8GG3u3C/KDP2kJJ1ztbq2RciHML78QSzp2sE2TJ0NrDi4tq0DMdKHyV
         gpiXtC242jN6rmsPwJuNRUYqNnyRMMg9rUp2OqRlzFeg7Wjhllgt+pTd3j7CR+s7pyl2
         nTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKC8Kh1ajafubHHeZ9/9PODH2lX7MWX7Fb6ysrZMlZ0=;
        b=cRenCIdLMCvIqW7mVPfO5i4PheDAHFzzLRY9Xtr09D4fEkHWhjRMdtWTwjdqg4sshP
         nI1pj0GRjb7Wy6PKGsUSmg3v2kAYr5+ph3mZRmtHd7GLKq+f6Fy8DnE7W761PMglGi0C
         BUNM1cobeRi63GUf2mb+6LuLDopcZ0Ix0QAfr/l2r4fsUiHs7KRJfmB2R9O/AliM0YuZ
         5Ar5UvRnugySbVYt8o6PVyMin1RxwGaOMJiFaeRkUKqOgSeUJHJ86XYR78ito7oD/Qc6
         py59zoyv0oKlfuGW5/0WK13qTmadYYtEKa7BBWw10jwPbS1e5cXfsynm/3XH4EsI/9BG
         oGQw==
X-Gm-Message-State: AOAM5309lxKAkjSVf8LzGZVBPlS+0HVtj7r+Yl/2X++zLiO2Yn8WdfH8
	hf0UYndqlQqgu7RSYmfbPcS6vGziXzAP74fC7L0=
X-Google-Smtp-Source: 
 ABdhPJxR4bN79y77OIT+q2FF3Iusi6VUtEXFk5JhgthkMJmH7IA3QnSJUGdAs/tt3qxtqSxlYi+0g/1gZOfapoFu5LE=
X-Received: by 2002:a67:ca8f:: with SMTP id a15mr1408196vsl.18.1636658419547;
 Thu, 11 Nov 2021 11:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20211105133104.19895-1-jasper@fancydomain.eu>
 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
 <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
 <029d18fa589265e32476c7cc45c9977f7b4bb9aa.camel@linuxfoundation.org>
 <3101a847508371b09b2949434f9ca09c672a7097.camel@iris-sensing.com>
 <dd07e5137044429f805caf23114a2e72@axis.com>
 <c1b45d484d3f55f9522cfa85c58e2acfa7d0e3f1.camel@iris-sensing.com>
 <83886954b53b47eb93b6ab8a7feebf19@axis.com>
 <e0ac884bc63e94e0c01a020ef178b7358779776b.camel@iris-sensing.com>
 <64e41080db7642d0b54818bdcf916dac@axis.com>
 <699b2927411dbdfdfd01e64ffb16dc057d5bb320.camel@iris-sensing.com>
In-Reply-To: <699b2927411dbdfdfd01e64ffb16dc057d5bb320.camel@iris-sensing.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 11 Nov 2021 20:20:08 +0100
Message-ID: 
 <CANNYZj9LXZjLq9mTxJ7g0T1Zz0XzZHhjiNud9o_kAbuyVb76UA@mail.gmail.com>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Cc: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"openembedded-core@lists.openembedded.org"
 <openembedded-core@lists.openembedded.org>,
	"kweihmann@outlook.com" <kweihmann@outlook.com>,
	"peter.kjellerstedt@axis.com" <peter.kjellerstedt@axis.com>,
	"jasper@fancydomain.eu" <jasper@fancydomain.eu>,
 "martin@mko.dev" <martin@mko.dev>,
	Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000b7488a05d0883b1c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 19:20:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13026

--000000000000b7488a05d0883b1c
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Nov 2021 at 16:08, Jasper Orschulko <
Jasper.Orschulko@iris-sensing.com> wrote:

> So if you have done this initial fetch of your sources and stash your
> working dir away, you can do an offline build.
>

But can you do an offline build without a prepopulated working dir? That's
the crucial point: offline build should work in a freshly set up build
directory, without sstate cache, and with prepopulated DL_DIR only.

Alex

--000000000000b7488a05d0883b1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, 11 Nov 2021 at 16:08, Jasper Orschulko &lt;<a href=3D"mailto=
:Jasper.Orschulko@iris-sensing.com">Jasper.Orschulko@iris-sensing.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
So if you have done this initial fetch of your sources and stash your<br>
working dir away, you can do an offline build.<br></blockquote></div><div c=
lass=3D"gmail_quote"><br></div><div class=3D"gmail_quote">But can you do an=
 offline build without a prepopulated working dir? That&#39;s the crucial p=
oint: offline build should work in a freshly set up build directory, withou=
t sstate cache, and with prepopulated DL_DIR only.</div><div class=3D"gmail=
_quote"><br></div><div class=3D"gmail_quote">Alex<br></div></div>

--000000000000b7488a05d0883b1c--

