Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03478C433F5
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 13:06:02 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by mx.groups.io with SMTP id smtpd.web09.22082.1636981561012980657
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 05:06:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=XVuIw6D+;
 spf=pass (domain: gmail.com, ip: 209.85.222.50,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f50.google.com with SMTP id y5so16747853ual.7;
        Mon, 15 Nov 2021 05:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bi39+cI6apzPc8O+Ogr8L4zewT3F7+isNXvRVyU3Myw=;
        b=XVuIw6D+6fwqq7PbHeBApQw+CpmOcLTz6BTef0ZuTV/ErSzGq7mjPX41E0N5q7qUoL
         +vZRcUQGN/BWKCyd1n1roWIntjPPPxm6ISjNYZhXoAFLLrvIs2ZF8NfZU3FZYTUPnH0A
         yJ3YzOTLxNLoM/z2RCs61JZfJVWZ02WJbr77mSQITmzhmpJQ25r/jHmMQbb9Iy8giJ3W
         6JOWxwoIo/bepN/anqbozLYWVzFcsj+E1tWZAqJ3jO95rkdVI8+PQaeMS/IuRZV3J+l1
         tqiYbytMz+UdQbAE3EjP7aBR8nWJBrMvcS/0whYww6DDcfFDSpM+iV3r+P4etl8H9n6A
         TttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bi39+cI6apzPc8O+Ogr8L4zewT3F7+isNXvRVyU3Myw=;
        b=WRINyAqhnAr4wYAkbf7psEGZVe6kCBGr5LamtxEM/j5iCVc3LC0NBuChSnAaguMpmS
         ZPFuieUyuOMvDU8Jiu4OAdXjxbYKO2B7ReQt+8HL0vtoquDCqtPMxMF0vWeeT3/Enw7h
         7+oTqTBo4N3zh+Vpz3EGNA1q+crW3sFjkLnqRZiisNXGCQ7GzRZ55tnigFLZWQNNT2gn
         NBA7/WW1Kt8bOSte0yA5/exlIRfprLLs8TPngVguyf6XXFLwBHRfifTwhgKNE8rLZOhl
         ZGtTnivwiGIN6GplgD7BgZYpR7UAu04HdZaHJOzpBm6SJPgz70vPqGLA9lXBOZXAz1w6
         KGXg==
X-Gm-Message-State: AOAM531kVlHKW6jmVE23DpdcG1ZhbFB7P8lnK1Ft5+vi3VvR6W9lMW7p
	GegGKtrkV72p9+hDvn1HMqkyIL0rF3pbafXDgg0=
X-Google-Smtp-Source: 
 ABdhPJxaV+o/dT2XPwOEnqHYnnSB80I6FAdkk3F1yP3byDRFQCLtu2i9thhjnRw+NJPD3XO5u8OMl5fY1Dn6bl6Y6MM=
X-Received: by 2002:ab0:6f14:: with SMTP id r20mr40743669uah.22.1636981560026;
 Mon, 15 Nov 2021 05:06:00 -0800 (PST)
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
 <CANNYZj9LXZjLq9mTxJ7g0T1Zz0XzZHhjiNud9o_kAbuyVb76UA@mail.gmail.com>
 <2a8ac0a3f85436df2651d4388569dda36a7bfca8.camel@iris-sensing.com>
In-Reply-To: <2a8ac0a3f85436df2651d4388569dda36a7bfca8.camel@iris-sensing.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 15 Nov 2021 14:05:47 +0100
Message-ID: 
 <CANNYZj_J1XaShxLv1d3vsjMV7qdy=L-6a4KvZ0RXDF0A8xRqKg@mail.gmail.com>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Cc: "jasper@fancydomain.eu" <jasper@fancydomain.eu>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"peter.kjellerstedt@axis.com" <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
	"kweihmann@outlook.com" <kweihmann@outlook.com>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>,
	"openembedded-core@lists.openembedded.org"
 <openembedded-core@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000063aa4c05d0d37821"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Nov 2021 13:06:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13046

--00000000000063aa4c05d0d37821
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, maybe you should write a test for offline builds as well then :)

Alex

On Mon, 15 Nov 2021 at 13:59, Jasper Orschulko <
Jasper.Orschulko@iris-sensing.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi Alexander,
>
> "[PATCH v3] fetch2/repo: Implement AUTOREV for repo fetcher" contains a
> fix for this issue. Reproducing a build offline with only the DL_DIR
> should work now.
>
> We are currently still lacking the appropriate tests for the fetcher.
> These will follow soon.
>
> - --
> With best regards
>
> Jasper Orschulko
> DevOps Engineer
>
> Tel. +49 30 58 58 14 265
> Fax +49 30 58 58 14 999
> Jasper.Orschulko@iris-sensing.com
>
> =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=
=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=
=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =
=E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2
>
> iris-GmbH
> infrared & intelligent sensors
> Schnellerstra=C3=9Fe 1-5 | 12439 Berlin
>
> https://iris-sensing.com/
>
>
>
>
>
> On Thu, 2021-11-11 at 20:20 +0100, Alexander Kanavin wrote:
> > On Thu, 11 Nov 2021 at 16:08, Jasper Orschulko
> > <Jasper.Orschulko@iris-sensing.com> wrote:
> > > So if you have done this initial fetch of your sources and stash
> > > your
> > > working dir away, you can do an offline build.
> >
> > But can you do an offline build without a prepopulated working dir?
> > That's the crucial point: offline build should work in a freshly set
> > up build directory, without sstate cache, and with prepopulated
> > DL_DIR only.
> >
> > Alex
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAEBCAAdFiEE4WyPMIC5Ap4+Ooo1Ygqew07VMNUFAmGSWb4ACgkQYgqew07V
> MNVUYQgAgA6+8XI+JxtA532FNNIMAZG5ZGZ12GKvVkjoJErnzRf0RZxUG3UyNYmm
> pSDcfbuodBmBbHxDBpN8VspToKZy8dKcm/jfe9UY7f9U39bZSNXSS3hNPqkqKP5J
> jCg1zQfxjbW1aVSHJkQB5MoY/EDeoQVv7RI6RmcVsLJZxozPeYaOQWSdTNG/7czg
> oFjKr6jtSOYO45teMGt3+2+AtAXhlzTgKZo33rX/tknS7f1+kkyNGLv0ssSP5Jcf
> Bd8YbcdG9lqXKUo0A7rn9Q83YBdpIyA6+By159zzPy7bP8j9aqMH8nNWauahhcFS
> sY39fiky57aEgMe7g1OZX8oRODowPA=3D=3D
> =3DhpAK
> -----END PGP SIGNATURE-----
>

--00000000000063aa4c05d0d37821
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks, maybe you should write a test for offline bui=
lds as well then :)</div><div><br></div><div>Alex<br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 15 Nov 2=
021 at 13:59, Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris-=
sensing.com">Jasper.Orschulko@iris-sensing.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE=
-----<br>
Hash: SHA256<br>
<br>
Hi Alexander,<br>
<br>
&quot;[PATCH v3] fetch2/repo: Implement AUTOREV for repo fetcher&quot; cont=
ains a<br>
fix for this issue. Reproducing a build offline with only the DL_DIR<br>
should work now.<br>
<br>
We are currently still lacking the appropriate tests for the fetcher.<br>
These will follow soon.<br>
<br>
- -- <br>
With best regards<br>
<br>
Jasper Orschulko<br>
DevOps Engineer<br>
<br>
Tel. +49 30 58 58 14 265<br>
Fax +49 30 58 58 14 999<br>
<a href=3D"mailto:Jasper.Orschulko@iris-sensing.com" target=3D"_blank">Jasp=
er.Orschulko@iris-sensing.com</a><br>
<br>
=E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=
=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=
=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =
=E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2<br>
<br>
iris-GmbH<br>
infrared &amp; intelligent sensors<br>
Schnellerstra=C3=9Fe 1-5 | 12439 Berlin<br>
<br>
<a href=3D"https://iris-sensing.com/" rel=3D"noreferrer" target=3D"_blank">=
https://iris-sensing.com/</a><br>
<br>
<br>
<br>
<br>
<br>
On Thu, 2021-11-11 at 20:20 +0100, Alexander Kanavin wrote:<br>
&gt; On Thu, 11 Nov 2021 at 16:08, Jasper Orschulko<br>
&gt; &lt;<a href=3D"mailto:Jasper.Orschulko@iris-sensing.com" target=3D"_bl=
ank">Jasper.Orschulko@iris-sensing.com</a>&gt; wrote:<br>
&gt; &gt; So if you have done this initial fetch of your sources and stash<=
br>
&gt; &gt; your<br>
&gt; &gt; working dir away, you can do an offline build.<br>
&gt; <br>
&gt; But can you do an offline build without a prepopulated working dir?<br=
>
&gt; That&#39;s the crucial point: offline build should work in a freshly s=
et<br>
&gt; up build directory, without sstate cache, and with prepopulated<br>
&gt; DL_DIR only.<br>
&gt; <br>
&gt; Alex<br>
-----BEGIN PGP SIGNATURE-----<br>
<br>
iQEzBAEBCAAdFiEE4WyPMIC5Ap4+Ooo1Ygqew07VMNUFAmGSWb4ACgkQYgqew07V<br>
MNVUYQgAgA6+8XI+JxtA532FNNIMAZG5ZGZ12GKvVkjoJErnzRf0RZxUG3UyNYmm<br>
pSDcfbuodBmBbHxDBpN8VspToKZy8dKcm/jfe9UY7f9U39bZSNXSS3hNPqkqKP5J<br>
jCg1zQfxjbW1aVSHJkQB5MoY/EDeoQVv7RI6RmcVsLJZxozPeYaOQWSdTNG/7czg<br>
oFjKr6jtSOYO45teMGt3+2+AtAXhlzTgKZo33rX/tknS7f1+kkyNGLv0ssSP5Jcf<br>
Bd8YbcdG9lqXKUo0A7rn9Q83YBdpIyA6+By159zzPy7bP8j9aqMH8nNWauahhcFS<br>
sY39fiky57aEgMe7g1OZX8oRODowPA=3D=3D<br>
=3DhpAK<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div>

--00000000000063aa4c05d0d37821--

