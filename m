Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B1C433F5
	for <webhook@archiver.kernel.org>; Tue,  4 Jan 2022 07:43:57 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web08.3878.1641282235881516338
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jan 2022 23:43:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Yo0pJjxl;
 spf=pass (domain: gmail.com, ip: 209.85.222.54,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f54.google.com with SMTP id i5so46693155uaq.10
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jan 2022 23:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zjwy4cssIM4agMB+D59jmJGYJSiM0Y8dhnjcEOoSgWQ=;
        b=Yo0pJjxlKeoNHzZCaFKUMflhgyD6siUllofrmZP2SDUI6kAOCogI72N0p2TPNJUOV7
         iVt3T7CFG+pTZG2F54DiKCvW3gJCUEHVTEbmLBsepuoc0eQrRoUSoehEK1ISdjeMDmLu
         xH+GVomej0Y7qTuPtr05lMCemBIkFNOfIpDFNn1a95k3RlgAIkJRuBawUlsu8pDqkIUN
         upM89o+GFYFlXaRzlek09vV9zP2fcifbB7CBIehXjOFFOBuLjmaRNwlNPVrH8GHo8keW
         XkY6T/cL0gVPeXWDLPfvPryAGChhQXycweNuHUmoESG49v+r5n+0h9oNKdbuqlZH2vNY
         KNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zjwy4cssIM4agMB+D59jmJGYJSiM0Y8dhnjcEOoSgWQ=;
        b=irdy+uPCl11baLOPBVP5DFOwPULIgW/2XMoGy139ilwirYrU9gY4EzRsl0hMVum79N
         pTQCtu2fGRKSEk2Jtd0fD1Eo+bJpDeWVOwwobUkvqic9zjvM4mJLcdVnthQeYrFViYhh
         g6GK5b/dNgBAmsjlapcbkOWknpMh102PFoj2if5oYHCb5ivNu77dnKkBSzLy3sTd3YUh
         3sWhkCAuT9GsDi4Fc40eHK4bbvc/w8tNxZH2ePL+agWr29TaDOq5LyZi7TikkFnkKj+A
         2VMlQ91oBilDMR9Foa4X4rl0WCRCM9+bU0GAf4IboF7OEaQ+rjK1Y7McfDIzdStPzizZ
         EPUA==
X-Gm-Message-State: AOAM533cIvk74fik5Ma466cv09WKTWsSCSCGrqG70ze3cXxyNxTy4ErW
	gzJEZIs26JSIqb+Pek78qNN8n3S8IbdyjJDoMWA=
X-Google-Smtp-Source: 
 ABdhPJxoBoCAnbzIZiOqsOebemkahEemHwd1FULSVmv9YjbhjqGW3gaEq0QiBgVPdMheOD0T/LNv4PhvOxA1KgewcS0=
X-Received: by 2002:ab0:6f4b:: with SMTP id r11mr10814541uat.93.1641282234976;
 Mon, 03 Jan 2022 23:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20220101112911.1866500-1-alex@linutronix.de>
 <2ec888840075cdb4a9d9883492b3ebf62654c085.camel@linuxfoundation.org>
In-Reply-To: 
 <2ec888840075cdb4a9d9883492b3ebf62654c085.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 4 Jan 2022 08:43:43 +0100
Message-ID: 
 <CANNYZj9eAay6ka5o=LMOPNPAdQ7a=vv7PyoxvrEoo36w==mBuA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] providers.py: do not skip recipes
 providing 'virtual/x' in world builds
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="000000000000978f5005d4bccc70"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jan 2022 07:43:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13215

--000000000000978f5005d4bccc70
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jan 2022 at 23:38, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> The principle is that virtual/XXX should only be built if something
> actually
> depends upon them as they're usually used to denote things which can be
> provided
> from multiple sources.


I'm not sure I follow. The 'world' set is aiming to have the fullest amount
of target items in it. If there are items which have the same 'virtual/x'
provides in their recipes, why should the recipes be all excluded from the
set?  They're not going to clash in package deploy, or in sysroots (since
sysroots became recipe-specific). Note that it's not 'virtual/x' being
excluded, but the parent recipes themselves.


> I'd argue that the code is correct and wonder whether:
>
> a) go-runtime should be providing a virtual
> b) that OE-Core should have something depending on go-runtime for test
> purposes
>

go-runtime is how I spotted the issue, but there are actually a fair bit
more items with the same problem, some of them major.

DEBUG: collating packages for "world"
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-graphics/libsdl2/libsdl2_2.0.18.bb
due to virtual/libsdl2 provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-devtools/make/make_4.3.bb due to
virtual/make provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-extended/libtirpc/libtirpc_1.3.2.bb
due to virtual/librpc provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-devtools/go/go-runtime_1.17.5.bb
due to virtual/x86_64-poky-linux-go-runtime provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-core/libxcrypt/libxcrypt_4.4.26.bb
due to virtual/crypt provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-graphics/xorg-xserver/
xserver-xorg_21.1.1.bb due to virtual/xserver-xf86 provider starting with
virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-kernel/linux/linux-yocto_5.10.bb
due to virtual/kernel provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-sato/rxvt-unicode/
rxvt-unicode_9.30.bb due to virtual/x-terminal-emulator provider starting
with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-core/gettext/gettext_0.21.bb due
to virtual/libintl provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-core/glibc/glibc-locale_2.34.bb
due to virtual/libc-locale provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-multimedia/libomxil/
libomxil_0.9.3.bb due to virtual/libomxil provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-devtools/gcc/libgcc-initial_11.2.bb
as task do_build doesn't exist
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-core/glibc/glibc_2.34.bb due to
virtual/libc provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-kernel/perf/perf.bb due to
virtual/perf provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-bsp/u-boot/u-boot_2021.10.bb due
to virtual/bootloader provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-graphics/mesa/mesa_21.3.1.bb due
to virtual/libgl provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-kernel/linux/linux-yocto_5.15.bb
due to virtual/kernel provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-devtools/dpkg/dpkg_1.21.1.bb due
to virtual/update-alternatives provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-graphics/xorg-lib/libx11_1.7.3.1.bb
due to virtual/libx11 provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-kernel/linux/linux-yocto_5.14.bb
due to virtual/kernel provider starting with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-devtools/opkg-utils/
opkg-utils_0.5.0.bb due to virtual/update-alternatives provider starting
with virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-devtools/gcc/gcc-runtime_11.2.bb
due to virtual/x86_64-poky-linux-compilerlibs provider starting with
virtual/
DEBUG: World build skipping
/home/alex/development/poky/meta/recipes-devtools/pseudo/pseudo_git.bb due
to virtual/fakeroot provider starting with virtual/

Alex

--000000000000978f5005d4bccc70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, 3 Jan 2022 at 23:38, Richard Purdie &lt;<a href=3D"mailto:ri=
chard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
The principle is that virtual/XXX should only be built if something actuall=
y<br>
depends upon them as they&#39;re usually used to denote things which can be=
 provided<br>
from multiple sources.</blockquote><div><br></div><div>I&#39;m not sure I f=
ollow. The &#39;world&#39; set is aiming to have the fullest amount of targ=
et items in it. If there are items which have the same &#39;virtual/x&#39; =
provides in their recipes, why should the recipes be all excluded from the =
set?=C2=A0 They&#39;re not going to clash in package deploy, or in sysroots=
 (since sysroots became recipe-specific). Note that it&#39;s not &#39;virtu=
al/x&#39; being excluded, but the parent recipes themselves.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"> I&#39;d argue t=
hat the code is correct and wonder whether:<br>
<br>
a) go-runtime should be providing a virtual<br>
b) that OE-Core should have something depending on go-runtime for test purp=
oses<br></blockquote><div>=C2=A0</div><div>go-runtime is how I spotted the =
issue, but there are actually a fair bit more items with the same problem, =
some of them major. <br></div><div><br></div><div>DEBUG: collating packages=
 for &quot;world&quot;<br>DEBUG: World build skipping /home/alex/developmen=
t/poky/meta/recipes-graphics/libsdl2/<a href=3D"http://libsdl2_2.0.18.bb">l=
ibsdl2_2.0.18.bb</a> due to virtual/libsdl2 provider starting with virtual/=
<br>DEBUG: World build skipping /home/alex/development/poky/meta/recipes-de=
vtools/make/<a href=3D"http://make_4.3.bb">make_4.3.bb</a> due to virtual/m=
ake provider starting with virtual/<br>DEBUG: World build skipping /home/al=
ex/development/poky/meta/recipes-extended/libtirpc/<a href=3D"http://libtir=
pc_1.3.2.bb">libtirpc_1.3.2.bb</a> due to virtual/librpc provider starting =
with virtual/<br>DEBUG: World build skipping /home/alex/development/poky/me=
ta/recipes-devtools/go/<a href=3D"http://go-runtime_1.17.5.bb">go-runtime_1=
.17.5.bb</a> due to virtual/x86_64-poky-linux-go-runtime provider starting =
with virtual/<br>DEBUG: World build skipping /home/alex/development/poky/me=
ta/recipes-core/libxcrypt/<a href=3D"http://libxcrypt_4.4.26.bb">libxcrypt_=
4.4.26.bb</a> due to virtual/crypt provider starting with virtual/<br>DEBUG=
: World build skipping /home/alex/development/poky/meta/recipes-graphics/xo=
rg-xserver/<a href=3D"http://xserver-xorg_21.1.1.bb">xserver-xorg_21.1.1.bb=
</a> due to virtual/xserver-xf86 provider starting with virtual/<br>DEBUG: =
World build skipping /home/alex/development/poky/meta/recipes-kernel/linux/=
<a href=3D"http://linux-yocto_5.10.bb">linux-yocto_5.10.bb</a> due to virtu=
al/kernel provider starting with virtual/<br>DEBUG: World build skipping /h=
ome/alex/development/poky/meta/recipes-sato/rxvt-unicode/<a href=3D"http://=
rxvt-unicode_9.30.bb">rxvt-unicode_9.30.bb</a> due to virtual/x-terminal-em=
ulator provider starting with virtual/<br>DEBUG: World build skipping /home=
/alex/development/poky/meta/recipes-core/gettext/<a href=3D"http://gettext_=
0.21.bb">gettext_0.21.bb</a> due to virtual/libintl provider starting with =
virtual/<br>DEBUG: World build skipping /home/alex/development/poky/meta/re=
cipes-core/glibc/<a href=3D"http://glibc-locale_2.34.bb">glibc-locale_2.34.=
bb</a> due to virtual/libc-locale provider starting with virtual/<br>DEBUG:=
 World build skipping /home/alex/development/poky/meta/recipes-multimedia/l=
ibomxil/<a href=3D"http://libomxil_0.9.3.bb">libomxil_0.9.3.bb</a> due to v=
irtual/libomxil provider starting with virtual/<br>DEBUG: World build skipp=
ing /home/alex/development/poky/meta/recipes-devtools/gcc/<a href=3D"http:/=
/libgcc-initial_11.2.bb">libgcc-initial_11.2.bb</a> as task do_build doesn&=
#39;t exist<br>DEBUG: World build skipping /home/alex/development/poky/meta=
/recipes-core/glibc/<a href=3D"http://glibc_2.34.bb">glibc_2.34.bb</a> due =
to virtual/libc provider starting with virtual/<br>DEBUG: World build skipp=
ing /home/alex/development/poky/meta/recipes-kernel/perf/<a href=3D"http://=
perf.bb">perf.bb</a> due to virtual/perf provider starting with virtual/<br=
>DEBUG: World build skipping /home/alex/development/poky/meta/recipes-bsp/u=
-boot/<a href=3D"http://u-boot_2021.10.bb">u-boot_2021.10.bb</a> due to vir=
tual/bootloader provider starting with virtual/<br>DEBUG: World build skipp=
ing /home/alex/development/poky/meta/recipes-graphics/mesa/<a href=3D"http:=
//mesa_21.3.1.bb">mesa_21.3.1.bb</a> due to virtual/libgl provider starting=
 with virtual/<br>DEBUG: World build skipping /home/alex/development/poky/m=
eta/recipes-kernel/linux/<a href=3D"http://linux-yocto_5.15.bb">linux-yocto=
_5.15.bb</a> due to virtual/kernel provider starting with virtual/<br>DEBUG=
: World build skipping /home/alex/development/poky/meta/recipes-devtools/dp=
kg/<a href=3D"http://dpkg_1.21.1.bb">dpkg_1.21.1.bb</a> due to virtual/upda=
te-alternatives provider starting with virtual/<br>DEBUG: World build skipp=
ing /home/alex/development/poky/meta/recipes-graphics/xorg-lib/<a href=3D"h=
ttp://libx11_1.7.3.1.bb">libx11_1.7.3.1.bb</a> due to virtual/libx11 provid=
er starting with virtual/<br>DEBUG: World build skipping /home/alex/develop=
ment/poky/meta/recipes-kernel/linux/<a href=3D"http://linux-yocto_5.14.bb">=
linux-yocto_5.14.bb</a> due to virtual/kernel provider starting with virtua=
l/<br>DEBUG: World build skipping /home/alex/development/poky/meta/recipes-=
devtools/opkg-utils/<a href=3D"http://opkg-utils_0.5.0.bb">opkg-utils_0.5.0=
.bb</a> due to virtual/update-alternatives provider starting with virtual/<=
br>DEBUG: World build skipping /home/alex/development/poky/meta/recipes-dev=
tools/gcc/<a href=3D"http://gcc-runtime_11.2.bb">gcc-runtime_11.2.bb</a> du=
e to virtual/x86_64-poky-linux-compilerlibs provider starting with virtual/=
<br>DEBUG: World build skipping /home/alex/development/poky/meta/recipes-de=
vtools/pseudo/<a href=3D"http://pseudo_git.bb">pseudo_git.bb</a> due to vir=
tual/fakeroot provider starting with virtual/<br></div><div><br></div></div=
><div class=3D"gmail_quote">Alex<br></div></div>

--000000000000978f5005d4bccc70--

