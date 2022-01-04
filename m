Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89019C433EF
	for <webhook@archiver.kernel.org>; Tue,  4 Jan 2022 09:46:08 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by mx.groups.io with SMTP id smtpd.web08.4687.1641289567567743305
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jan 2022 01:46:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Ur9L0ceR;
 spf=pass (domain: gmail.com, ip: 209.85.222.47,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f47.google.com with SMTP id o1so62179888uap.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jan 2022 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sd/sBu5ZXdk2ouX7kxnpBslY5D9QS5iN2rQcMgj7gUQ=;
        b=Ur9L0ceRWRzWeqrxQ/D8MNXckkEqa5gssYtcptUW63ivmveFGvgpr9j4FtbYaRFbui
         IxrosTqgooevZt1KR22L50xlKYsMSaSRPiTCvD0Kqsy1RavInF3CShDUBN86tQr+84z3
         c5dInNSuyLQJglnGvenVJhz+klUUckywMwhn/jveV1IKm9ffTXJ9pIO2nFPEw8TE7FeK
         irNaUxVLfQYfZE7ORHZErHqqx+jnLXTrDf3kR5IzWrC3eTBirGqd798rObb2T8pl0af9
         xM/G6Gcj6Pecy3gFFc6lYtNyvIz2mJf16BC1RTpYCM/4BgBc3kEf4ZJws5+5l4c8F25f
         xHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sd/sBu5ZXdk2ouX7kxnpBslY5D9QS5iN2rQcMgj7gUQ=;
        b=EgvaLHxFFae0rvufDNIWfPrb+Lt3P6X6d9A9K/E1kkkJ1E1RsJhn+LTbkwwW6ZCnIk
         s2xoUfli7f2bIP/73J5BhGICKmoCdpq3e6Gs4elaZMU5f4J8Jgcm/rsboCLUOp6yuEDC
         GZw6og3aSq337eycmA5MMyX6a7so7Ww3SCPA0Jty73vTfdSP6palwGgkMOOq95hvyV1h
         w38rB3DhL3pu4TYlnPJfba3Svhcjcc4xofVbTduvnqY1uhyciQXVopVtoq1XzG/d88H5
         tip4Tjfwm0PZg24OcxiYqOUCFFx1Vk44Em9CMsSr5/sxXZhlrh5Py7+zVLMkOcexmqzJ
         cX+w==
X-Gm-Message-State: AOAM532abhbnRikiEQFs+iK+5p6mVZdZvYE+WzLgmj1CIAy2Xdgd/qTA
	kxjtQxpJw8zy8bTurbGMTJ3XufqGCzfjsIaMgq0=
X-Google-Smtp-Source: 
 ABdhPJxJoK/tDWkYk4A3ksOPRELA/dnLuc46q95i1irspJ9nUN6GSYZnrRajLLCk+k6XzK8Wi9JL141Tb6Inu0wf6rs=
X-Received: by 2002:ab0:26d2:: with SMTP id
 b18mr13957438uap.100.1641289566662;
 Tue, 04 Jan 2022 01:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20220101112911.1866500-1-alex@linutronix.de>
 <2ec888840075cdb4a9d9883492b3ebf62654c085.camel@linuxfoundation.org>
 <CANNYZj9eAay6ka5o=LMOPNPAdQ7a=vv7PyoxvrEoo36w==mBuA@mail.gmail.com>
 <f80391bccd5070fed6d7d7196bba726459ff9146.camel@linuxfoundation.org>
In-Reply-To: 
 <f80391bccd5070fed6d7d7196bba726459ff9146.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 4 Jan 2022 10:45:55 +0100
Message-ID: 
 <CANNYZj_hckmd54iRWoEc478E5A5t01TsgC=U-V4nhrkJme-3vA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] providers.py: do not skip recipes
 providing 'virtual/x' in world builds
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="00000000000098329705d4be8193"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jan 2022 09:46:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13218

--00000000000098329705d4be8193
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jan 2022 at 10:29, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

>
> Building musl on a glibc configured system is pointless. Similarly,
> building
> clang when you're targeting things with gcc is pointless too.
>

As mentioned, musl and clang and systemd are all excluded earlier by
skipping them via base.bbclass. So this code only ends up excluding the
sole remaining options (preferred alternatives set via PREFERRED_PROVIDER),
which are both valid and useful in world builds.


> > DEBUG: collating packages for "world"
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-graphics/libsdl2/
> libsdl2_2.0.18.bb due to virtual/libsdl2 provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/make/make_4.3.bb due to
> virtual/make provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-extended/libtirpc/
> libtirpc_1.3.2.bb due to virtual/librpc provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/go/go-runtime_1.17.5.bb
> due to virtual/x86_64-poky-linux-go-runtime provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-core/libxcrypt/
> libxcrypt_4.4.26.bb due to virtual/crypt provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-graphics/xorg-xserver/
> xserver-xorg_21.1.1.bb due to virtual/xserver-xf86 provider starting with
> virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-kernel/linux/linux-yocto_5.10.bb
> due to virtual/kernel provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-sato/rxvt-unicode/
> rxvt-unicode_9.30.bb due to virtual/x-terminal-emulator provider starting
> with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-core/gettext/gettext_0.21.bb due
> to virtual/libintl provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-core/glibc/glibc-locale_2.34.bb
> due to virtual/libc-locale provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-multimedia/libomxil/
> libomxil_0.9.3.bb due to virtual/libomxil provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/gcc/
> libgcc-initial_11.2.bb as task do_build doesn't exist
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-core/glibc/glibc_2.34.bb due to
> virtual/libc provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-kernel/perf/perf.bb due to
> virtual/perf provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-bsp/u-boot/u-boot_2021.10.bb due
> to virtual/bootloader provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-graphics/mesa/mesa_21.3.1.bb due
> to virtual/libgl provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-kernel/linux/linux-yocto_5.15.bb
> due to virtual/kernel provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/dpkg/dpkg_1.21.1.bb due
> to virtual/update-alternatives provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-graphics/xorg-lib/
> libx11_1.7.3.1.bb due to virtual/libx11 provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-kernel/linux/linux-yocto_5.14.bb
> due to virtual/kernel provider starting with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/opkg-utils/
> opkg-utils_0.5.0.bb due to virtual/update-alternatives provider starting
> with virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/gcc/gcc-runtime_11.2.bb
> due to virtual/x86_64-poky-linux-compilerlibs provider starting with
> virtual/
> > DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/pseudo/pseudo_git.bb
> due to virtual/fakeroot provider starting with virtual/
>
> Most of these would be have things depending on them and therefore would
> get
> built anyway. If they don't, they're probably not "useful" in the world
> build
> context so I still think the code is actually doing what was intended?
>

The issue here is not a build for purposes of populating another sysroot
(without packaging for target), the issue is that there's no guarantee
anything here would end up in package deploy and thus be tested for
reproducibility. How should we solve this? I'd still want to drop the world
skipping (given that it does not actually exclude non-useful alternatives).
I would reluctantly agree to '-k universe' too in the repro test.

Alex

--00000000000098329705d4be8193
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, 4 Jan 2022 at 10:29, Richard Purdie &lt;<a href=3D"mailto:ri=
chard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Building musl on a glibc configured system is pointless. Similarly, buildin=
g<br>
clang when you&#39;re targeting things with gcc is pointless too.<br></bloc=
kquote><div><br></div><div>As mentioned, musl and clang and systemd are all=
 excluded earlier by skipping them via base.bbclass. So this code only ends=
 up excluding the sole remaining options (preferred alternatives set via PR=
EFERRED_PROVIDER), which are both valid and useful in world builds.<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; DEBUG: collating packages for &quot;world&quot;<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-g=
raphics/libsdl2/<a href=3D"http://libsdl2_2.0.18.bb" rel=3D"noreferrer" tar=
get=3D"_blank">libsdl2_2.0.18.bb</a> due to virtual/libsdl2 provider starti=
ng with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-d=
evtools/make/<a href=3D"http://make_4.3.bb" rel=3D"noreferrer" target=3D"_b=
lank">make_4.3.bb</a> due to virtual/make provider starting with virtual/<b=
r>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-e=
xtended/libtirpc/<a href=3D"http://libtirpc_1.3.2.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">libtirpc_1.3.2.bb</a> due to virtual/librpc provider starti=
ng with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-d=
evtools/go/<a href=3D"http://go-runtime_1.17.5.bb" rel=3D"noreferrer" targe=
t=3D"_blank">go-runtime_1.17.5.bb</a> due to virtual/x86_64-poky-linux-go-r=
untime provider starting with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-c=
ore/libxcrypt/<a href=3D"http://libxcrypt_4.4.26.bb" rel=3D"noreferrer" tar=
get=3D"_blank">libxcrypt_4.4.26.bb</a> due to virtual/crypt provider starti=
ng with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-g=
raphics/xorg-xserver/<a href=3D"http://xserver-xorg_21.1.1.bb" rel=3D"noref=
errer" target=3D"_blank">xserver-xorg_21.1.1.bb</a> due to virtual/xserver-=
xf86 provider starting with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-k=
ernel/linux/<a href=3D"http://linux-yocto_5.10.bb" rel=3D"noreferrer" targe=
t=3D"_blank">linux-yocto_5.10.bb</a> due to virtual/kernel provider startin=
g with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-s=
ato/rxvt-unicode/<a href=3D"http://rxvt-unicode_9.30.bb" rel=3D"noreferrer"=
 target=3D"_blank">rxvt-unicode_9.30.bb</a> due to virtual/x-terminal-emula=
tor provider starting with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-c=
ore/gettext/<a href=3D"http://gettext_0.21.bb" rel=3D"noreferrer" target=3D=
"_blank">gettext_0.21.bb</a> due to virtual/libintl provider starting with =
virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-c=
ore/glibc/<a href=3D"http://glibc-locale_2.34.bb" rel=3D"noreferrer" target=
=3D"_blank">glibc-locale_2.34.bb</a> due to virtual/libc-locale provider st=
arting with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-m=
ultimedia/libomxil/<a href=3D"http://libomxil_0.9.3.bb" rel=3D"noreferrer" =
target=3D"_blank">libomxil_0.9.3.bb</a> due to virtual/libomxil provider st=
arting with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-d=
evtools/gcc/<a href=3D"http://libgcc-initial_11.2.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">libgcc-initial_11.2.bb</a> as task do_build doesn&#39;t exi=
st<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-c=
ore/glibc/<a href=3D"http://glibc_2.34.bb" rel=3D"noreferrer" target=3D"_bl=
ank">glibc_2.34.bb</a> due to virtual/libc provider starting with virtual/<=
br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-k=
ernel/perf/<a href=3D"http://perf.bb" rel=3D"noreferrer" target=3D"_blank">=
perf.bb</a> due to virtual/perf provider starting with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-b=
sp/u-boot/<a href=3D"http://u-boot_2021.10.bb" rel=3D"noreferrer" target=3D=
"_blank">u-boot_2021.10.bb</a> due to virtual/bootloader provider starting =
with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-g=
raphics/mesa/<a href=3D"http://mesa_21.3.1.bb" rel=3D"noreferrer" target=3D=
"_blank">mesa_21.3.1.bb</a> due to virtual/libgl provider starting with vir=
tual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-k=
ernel/linux/<a href=3D"http://linux-yocto_5.15.bb" rel=3D"noreferrer" targe=
t=3D"_blank">linux-yocto_5.15.bb</a> due to virtual/kernel provider startin=
g with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-d=
evtools/dpkg/<a href=3D"http://dpkg_1.21.1.bb" rel=3D"noreferrer" target=3D=
"_blank">dpkg_1.21.1.bb</a> due to virtual/update-alternatives provider sta=
rting with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-g=
raphics/xorg-lib/<a href=3D"http://libx11_1.7.3.1.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">libx11_1.7.3.1.bb</a> due to virtual/libx11 provider starti=
ng with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-k=
ernel/linux/<a href=3D"http://linux-yocto_5.14.bb" rel=3D"noreferrer" targe=
t=3D"_blank">linux-yocto_5.14.bb</a> due to virtual/kernel provider startin=
g with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-d=
evtools/opkg-utils/<a href=3D"http://opkg-utils_0.5.0.bb" rel=3D"noreferrer=
" target=3D"_blank">opkg-utils_0.5.0.bb</a> due to virtual/update-alternati=
ves provider starting with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-d=
evtools/gcc/<a href=3D"http://gcc-runtime_11.2.bb" rel=3D"noreferrer" targe=
t=3D"_blank">gcc-runtime_11.2.bb</a> due to virtual/x86_64-poky-linux-compi=
lerlibs provider starting with virtual/<br>
&gt; DEBUG: World build skipping /home/alex/development/poky/meta/recipes-d=
evtools/pseudo/<a href=3D"http://pseudo_git.bb" rel=3D"noreferrer" target=
=3D"_blank">pseudo_git.bb</a> due to virtual/fakeroot provider starting wit=
h virtual/<br>
<br>
Most of these would be have things depending on them and therefore would ge=
t<br>
built anyway. If they don&#39;t, they&#39;re probably not &quot;useful&quot=
; in the world build<br>
context so I still think the code is actually doing what was intended?<br><=
/blockquote></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_=
quote">The issue here is not a build for purposes of populating another sys=
root (without packaging for target), the issue is that there&#39;s no guara=
ntee anything here would end up in package deploy and thus be tested for re=
producibility. How should we solve this? I&#39;d still want to drop the wor=
ld skipping (given that it does not actually exclude non-useful alternative=
s). I would reluctantly agree to &#39;-k universe&#39; too in the repro tes=
t.</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Ale=
x<br></div></div>

--00000000000098329705d4be8193--

