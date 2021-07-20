Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web09.1879.1626808869597277106
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jul 2021 12:21:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=cJCimJX5;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: raj.khem@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id k9so336408qtx.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jul 2021 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8dNpBwuyyfkzJP+wwUnvt5Lu6Qm5xBSre5l3z4iY+IE=;
        b=cJCimJX5y0P9iBlbk4NM4tHbCNpC7x573kiN6YCAOyijtiGtXHYeABJfmIM+cBDTuz
         qaexRtQ/Suz42OWjdwZBKMxxaXDwQGUrqObygcSEw9frHOW+0wJtSCFjvr4l76qWu+O+
         8Kq/FkFbt+GUMpy96Wc0bTwpHbcq45FZ8VDGgC/+nsgnqjNkIvD75mRK41vfbSx/QmCE
         zooWB1Uu1DChkdfj/jIAVzwy0WD2jhXsinw/F40tzaH4WF3nX9kxlCyYwGbyIIpZbTsk
         SF0V4ZRaJPz0Xu2seDy5QGoRtOzFUXXuqAWR0+AbZJr5MeXW93yulDZS7Orkqo2jFzyv
         A+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8dNpBwuyyfkzJP+wwUnvt5Lu6Qm5xBSre5l3z4iY+IE=;
        b=ZdZ5FAlXca7F2I0jD009XMWV1yfgzeh9VyylVWuhf0P6Rx3HKwMHE8xoPAWHxjNPgQ
         NvraRPlyaDhT1iLgI2AFA/otvyC4TNG5hHgNg0KPL+aEBLg19cMmRZniAGdwypbF/8/3
         GGsU3pEvUklJ+y0SF+k7F14FZN+GNxwgRHOiw3r3vBCEm7s6/XCcQpyzB52hrNt8xpF7
         61/K+makwZQHX6PnYx0kW+Tsui8QR/zFpYtEQSVB/wtkVyYgqRx2QxjtH4xe7heGv6tT
         qtunZm2moTek/VEL/HBGEFsPpxMtEoh11ozHw6doMrOmF76XOF3+kOBuVdSj464ZRu9k
         oqhw==
X-Gm-Message-State: AOAM533FNyBb9+f7g3FA2d5d75i7P3u0BG8NRNZQml5D8XTsA66URp67
	GA6VVvQbO78rTvaKeTDtRRF7Ge5qvuJZzvONK7M=
X-Google-Smtp-Source: ABdhPJwYGFDR8gEBMOYKz0OhX90wld1nJ/Dvf2r+EHuAdRsWoonKGXRfLAV+rXTZzRnSO+HmTuperaaokZk6Jv3L/Wc=
X-Received: by 2002:ac8:544:: with SMTP id c4mr27759150qth.299.1626808868720;
 Tue, 20 Jul 2021 12:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <AS8PR10MB490146E348FA167DA01C2471E1E29@AS8PR10MB4901.EURPRD10.PROD.OUTLOOK.COM>
 <YPayYZn1bvwrM4Ye@piout.net>
In-Reply-To: <YPayYZn1bvwrM4Ye@piout.net>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Tue, 20 Jul 2021 12:20:42 -0700
Message-ID: <CAMKF1spwawxLT-r-urAsyeCiGju=9VcXEw-2LDdxS1vD75qEaw@mail.gmail.com>
Subject: Re: [bitbake-devel] recipe-sysroot doesn't contain kernel patch
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: eduardo.sousa2@pt.bosch.com, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 20, 2021 at 4:24 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> On 20/07/2021 11:17:52+0000, Sousa Eduardo (XC-CI2/ESD52) via lists.open=
embedded.org wrote:
> > Hello,
> >
> > I=E2=80=99m currently developing a custom yocto layer in AGL and did a=
 kernel patch to contain IFLA_CAN_TERMINATION macro in the linux/can/netlin=
k.h file since the kernel I=E2=80=99m using doesn=E2=80=99t contain it.
> > The problem is that in the output of the kernel compilation the patch =
was applied, but when bitbake compiles systemd it raises an error saying th=
ere is no IFLA_CAN_TERMINATION declared. Checked recipe-sysroot and it isn=
=E2=80=99t patched.
> > What can be the source of the problem?
> >
>
> The recipe providing the kernel headers to the libc is
> linux-libc-headers, not the kernel recipe.
>

right and you want to really take a hard look at why your userspace
depends on customized UAPIs

> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>=20
>
