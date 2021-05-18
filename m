Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.7428.1621338963461136435
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 04:56:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20150623.gappssmtp.com header.s=20150623 header.b=kNmiEgKe;
 spf=pass (domain: burtonini.com, ip: 209.85.128.53, mailfrom: ross@burtonini.com)
Received: by mail-wm1-f53.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so1457269wmc.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 May 2021 04:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OMDwkWGazpgJ+F7r8FOQA4po9m/Cxbz11OaIztojnho=;
        b=kNmiEgKexdPvzj0+TzzYmEPybZFjWVURLGFsgSEzUzRv6sM6wWm24pNHUNrdFjPEJ4
         I4P/Z/TSxgYEMTpe5heOnwdVuXg50vgGXR34EtNBv4pOKO6C8trsXJXlDAIRbEzxRyEh
         oHjKCjOjSosVJn+1jjexN8ysasX+L+iW47LRnDZEOMaemvtMZEt7XUYminlFYJV8afV0
         lAvTncI/T9/sh2IiG15Wf0gyQhLk2D9cxhfUWvCh2YW8a/mlSKRp3tcjf3DrZDDD+NvD
         RMgXuEnEsyNwEVlimnX3+woIzU/VHKWNwoEU6ZHJJ9kIsF1nZ4hgnSeQuuAcguLOwkJ+
         8lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OMDwkWGazpgJ+F7r8FOQA4po9m/Cxbz11OaIztojnho=;
        b=o+zsUuppI0jTqZLZjjq2/mwkkjfQHalFH8Xh6VpFqI2wB9nDxrZ8jdUx87J26l6fpy
         +dbnDPBP7GQkCxMBzZ0GN01Kv25t1tUjxPO23A08eAS2l3nD0KxqrqVq9nPsRL9sDwmz
         DqTVy5XR32W7mfP4YSspwQ+XWmL64CDINbd0J5L4yuUD5ulRHEtQxmEE5vfkyP/aRLy5
         dUINubJ8VfIv2rnFbuxS2T34gKXqzmVkSEyfuD0Qroj9/RYHrQT8g35EQETyLysaJxYs
         1J/2KInvqSZOAzpnGOpc+zHnt+0R72jkvVUa9GPPiByb5Ykue2etPpAcoCRBA/JTpGQk
         5g8g==
X-Gm-Message-State: AOAM531fIHGLnVCbmXPW+466l7CL1UxyzWoSnyR4qKdToG/5nOnB0OAf
	HHGswNPtXHoQtczpgii0vOrlwAycKPHcizeSKcIkgg==
X-Google-Smtp-Source: ABdhPJxWklu12g7nO3ABAboU5qLrmGANSrbZ3U9rJvOLxdvgcAJkPwFKqlZfoQtCat9QbAW5IG9zbjLHm0sZ6l+DiTM=
X-Received: by 2002:a7b:cc83:: with SMTP id p3mr5185579wma.169.1621338961919;
 Tue, 18 May 2021 04:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <141358386.90607893.1621323974188.JavaMail.zimbra@jasmin-infotech.com>
 <1180155480.90839930.1621324248815.JavaMail.zimbra@jasmin-infotech.com>
 <AM9PR09MB46424A47140676C11DAD16D2A82C9@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <1263831117.91201115.1621324764469.JavaMail.zimbra@jasmin-infotech.com>
In-Reply-To: <1263831117.91201115.1621324764469.JavaMail.zimbra@jasmin-infotech.com>
From: "Ross Burton" <ross@burtonini.com>
Date: Tue, 18 May 2021 12:55:51 +0100
Message-ID: <CAAnfSTvHC0OjXmXoXVqewG_vvaS-6oLfshdOcgZu1L42YCMb4Q@mail.gmail.com>
Subject: Re: [bitbake-devel] Disable Reproducible Build - reg
To: Daniel Selvan <daniel.selvan@jasmin-infotech.com>
Cc: Konrad Weihmann <kweihmann@outlook.com>, poky <poky@lists.yoctoproject.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That error isn't caused by Yocto, so you'll have to work on the source
of the recipe that is failing.

Ross

On Tue, 18 May 2021 at 08:59, Daniel Selvan
<daniel.selvan@jasmin-infotech.com> wrote:
>
> Hi,
>
> I already added the line "BUILD_REPRODUCIBLE_BINARIES =3D '0'" in by loc=
al.conf yet if I try to add __DATE__ I get the following error: "error: mac=
ro "__DATE__" might prevent reproducible builds [-Werror=3Ddate-time]"
>
> Can you comment on this?
>
> Kind regards,
>
>
> Daniel Selvan D.
>
>
> --
>
>
> P Please consider the environment before printing this email.
>
> ----- Original Message -----
> From: "Konrad Weihmann" <kweihmann@outlook.com>
> To: "Daniel D" <daniel.selvan@jasmin-infotech.com>, "poky" <poky@lists.y=
octoproject.org>, "bitbake-devel" <bitbake-devel@lists.openembedded.org>
> Sent: Tuesday, 18 May, 2021 13:26:19
> Subject: Re: [bitbake-devel] Disable Reproducible Build - reg
>
> You could either create a distro configuration of your own (one that
> doesn't inherit the poky.conf) or set `BUILD_REPRODUCIBLE_BINARIES` to
> `0` to reduce the impact of the inherited reproducible_build class
>
> On 18.05.21 09:50, Daniel Selvan wrote:
> > Hi,
> >
> > I wonder how to disable the Yocto reproducible builds, since it is
> > enabled by default now
> > (https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#m=
igration-3.1-reproducible-builds
> > <https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#m=
igration-3.1-reproducible-builds>).
> >
> > Thanks in advance.
> >
> > Kind regards,
> >
> > Daniel Selvan D.
> >
> > Senior Systems Engineer*|* Jasmin Infotech
> > <http://www.jasmin-infotech.com/the-company/contact-us/>
> >
> > *+91 9445556596 <callto:9445556596>*
> >
> > =EF=BB=BF--
> >
> > P Please consider the environment before printing this email.
> >
> >
> >
> > Information in this email is proprietary and Confidential to Jasmin
> > Infotech Pvt. Ltd. Any use, copying or dissemination of the informatio=
n
> > in any manner without prior approval, is strictly prohibited. If you a=
re
> > not the intended recipient, please destroy the message and please info=
rm
> > to us..
> >
> >
> >
> >
>
>
>
>=20
>
