Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3DCC433EF
	for <webhook@archiver.kernel.org>; Tue,  4 Jan 2022 09:04:58 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web08.4427.1641287093935396501
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jan 2022 01:04:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=XLsntpqz;
 spf=pass (domain: gmail.com, ip: 209.85.222.54,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f54.google.com with SMTP id v12so50187897uar.7
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jan 2022 01:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZ0kPyS27Ip6FBNnrrKEiEdVfWr8ZsXnQVYG2bQvMIc=;
        b=XLsntpqzX09VfH9q1nhJhCvspi8EkT/lTzCVuUMad7mIW23VpNSaZToFHoGp3qYkHp
         XEp01t6lwHeftgOm6vHMQN2C3QNApex9PcL4PRodsNnr64HLzkDynFLWxML08IOlOpB5
         kd64nQ/6uMom6rf/skit1Bs6ZsdqTZMCTNp1dDTBvg1xH3bUwUZH1aQWRWsHRJRkkV19
         pjXn65TH4TYkEH0RFmhYmdl5hssuiBTjKeyEqWSTw0sM006bhktnph2hwr0MCNPBQuew
         Z1BdSpdyQJ+a4aa4BTbFuWLzryzoQfx8QEtjje81gaTfcLbkVWDS1Qq08ldwbXcb/w2I
         MPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZ0kPyS27Ip6FBNnrrKEiEdVfWr8ZsXnQVYG2bQvMIc=;
        b=BlU8PZvkYLlM+nOO2qDsogtY1LVNyulaVkx23iBKdBNFJ8BbVWtlsvBqQZ2MCW95w+
         7hi4Es2f/x3u3/+3yQGIn4r65v32DunAo+eoJcBL1dTOeIc5EdJVy8DN1QlZPbS5uDTf
         JIE2b7z5T27lnoSUSpst8+VaQ2ivMTgD6Pm3yuFHvnfpp0+hZLE/w7KpAhbi8vH6VePN
         hO8U7mhajXV69VARiCn3x+0IW1YeXnzpN9mkGbZluacmuqdrDIXXBwuFeGeYZbnlbCNF
         Kwy0hkHwUhXdDFC/mzNLskc6udhiiRZxW/qrJlIHVFkeIvS6ZL/IAUa/36/oxHgx5Kbt
         CDjA==
X-Gm-Message-State: AOAM530nixY0DSVLes2287fEwuw5CrMf/XZ6DSZy8fDrbhooXFue9Z8M
	IuZ9vIL7PBKziKLwzumMdGwZHSn8yfmwzeJPADQ=
X-Google-Smtp-Source: 
 ABdhPJzZhoLtZPkShseCUTEZ/Vn2rTnUOw+0xab29s8/PfalEeFDA0TIJ3Ogl8szXY8GwxF/riCWLP81aUrkh39VABw=
X-Received: by 2002:a05:6102:3667:: with SMTP id
 bg7mr5989892vsb.81.1641287092876;
 Tue, 04 Jan 2022 01:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20220101112911.1866500-1-alex@linutronix.de>
 <2ec888840075cdb4a9d9883492b3ebf62654c085.camel@linuxfoundation.org>
 <16C7017F7DB92566.4600@lists.openembedded.org>
In-Reply-To: <16C7017F7DB92566.4600@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 4 Jan 2022 10:04:41 +0100
Message-ID: 
 <CANNYZj_pwXgDaMgF4+6Ed-6uzE8aP=V3c1e8F7nraVk3a11H3w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] providers.py: do not skip recipes
 providing 'virtual/x' in world builds
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="0000000000002538bb05d4bdeed4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jan 2022 09:04:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13216

--0000000000002538bb05d4bdeed4
Content-Type: text/plain; charset="UTF-8"

To follow this up, if there are indeed multiple providers, they are
excluded even earlier in base.bbclass:
=====
            provs = (d.getVar("PROVIDES") or "").split()
            multiwhitelist = (d.getVar("MULTI_PROVIDER_WHITELIST") or
"").split()
            for p in provs:
                if p.startswith("virtual/") and p not in multiwhitelist:
                    profprov = d.getVar("PREFERRED_PROVIDER_" + p)
                    if profprov and pn != profprov:
                        raise bb.parse.SkipRecipe("PREFERRED_PROVIDER_%s
set to %s, not %s" % (p, profprov, pn))
=====

So the bitbake code only excludes the sole remaining option from world,
which makes even less sense.

Alex

On Tue, 4 Jan 2022 at 08:43, Alexander Kanavin via lists.openembedded.org
<alex.kanavin=gmail.com@lists.openembedded.org> wrote:

> On Mon, 3 Jan 2022 at 23:38, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> The principle is that virtual/XXX should only be built if something
>> actually
>> depends upon them as they're usually used to denote things which can be
>> provided
>> from multiple sources.
>
>
> I'm not sure I follow. The 'world' set is aiming to have the fullest
> amount of target items in it. If there are items which have the same
> 'virtual/x' provides in their recipes, why should the recipes be all
> excluded from the set?  They're not going to clash in package deploy, or in
> sysroots (since sysroots became recipe-specific). Note that it's not
> 'virtual/x' being excluded, but the parent recipes themselves.
>
>
>> I'd argue that the code is correct and wonder whether:
>>
>> a) go-runtime should be providing a virtual
>> b) that OE-Core should have something depending on go-runtime for test
>> purposes
>>
>
> go-runtime is how I spotted the issue, but there are actually a fair bit
> more items with the same problem, some of them major.
>
> DEBUG: collating packages for "world"
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-graphics/libsdl2/
> libsdl2_2.0.18.bb due to virtual/libsdl2 provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/make/make_4.3.bb due to
> virtual/make provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-extended/libtirpc/
> libtirpc_1.3.2.bb due to virtual/librpc provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/go/go-runtime_1.17.5.bb
> due to virtual/x86_64-poky-linux-go-runtime provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-core/libxcrypt/
> libxcrypt_4.4.26.bb due to virtual/crypt provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-graphics/xorg-xserver/
> xserver-xorg_21.1.1.bb due to virtual/xserver-xf86 provider starting with
> virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-kernel/linux/linux-yocto_5.10.bb
> due to virtual/kernel provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-sato/rxvt-unicode/
> rxvt-unicode_9.30.bb due to virtual/x-terminal-emulator provider starting
> with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-core/gettext/gettext_0.21.bb due
> to virtual/libintl provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-core/glibc/glibc-locale_2.34.bb
> due to virtual/libc-locale provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-multimedia/libomxil/
> libomxil_0.9.3.bb due to virtual/libomxil provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/gcc/
> libgcc-initial_11.2.bb as task do_build doesn't exist
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-core/glibc/glibc_2.34.bb due to
> virtual/libc provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-kernel/perf/perf.bb due to
> virtual/perf provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-bsp/u-boot/u-boot_2021.10.bb due
> to virtual/bootloader provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-graphics/mesa/mesa_21.3.1.bb due
> to virtual/libgl provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-kernel/linux/linux-yocto_5.15.bb
> due to virtual/kernel provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/dpkg/dpkg_1.21.1.bb due
> to virtual/update-alternatives provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-graphics/xorg-lib/
> libx11_1.7.3.1.bb due to virtual/libx11 provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-kernel/linux/linux-yocto_5.14.bb
> due to virtual/kernel provider starting with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/opkg-utils/
> opkg-utils_0.5.0.bb due to virtual/update-alternatives provider starting
> with virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/gcc/gcc-runtime_11.2.bb
> due to virtual/x86_64-poky-linux-compilerlibs provider starting with
> virtual/
> DEBUG: World build skipping
> /home/alex/development/poky/meta/recipes-devtools/pseudo/pseudo_git.bb
> due to virtual/fakeroot provider starting with virtual/
>
> Alex
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13215):
> https://lists.openembedded.org/g/bitbake-devel/message/13215
> Mute This Topic: https://lists.openembedded.org/mt/88071309/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000002538bb05d4bdeed4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>To follow this up, if there are indeed multiple provi=
ders, they are excluded even earlier in base.bbclass:</div><div>=3D=3D=3D=
=3D=3D<br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 provs =3D (d=
.getVar(&quot;PROVIDES&quot;) or &quot;&quot;).split()<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 multiwhitelist =3D (d.getVar(&quot;MULTI_PROVIDER_=
WHITELIST&quot;) or &quot;&quot;).split()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 for p in provs:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if p.startswith(&quot;virtual/&quot;) and p not in multiwhite=
list:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 profprov =3D d.getVar(&quot;PREFERRED_PROVIDER_&quot; + p)<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if profprov =
and pn !=3D profprov:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise bb.parse.SkipRecipe(&quot;PREFERRE=
D_PROVIDER_%s set to %s, not %s&quot; % (p, profprov, pn))</div><div>=3D=3D=
=3D=3D=3D</div><div><br></div><div>So the bitbake code only excludes the so=
le remaining option from world, which makes even less sense.</div><div><br>=
</div><div>Alex<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, 4 Jan 2022 at 08:43, Alexander Kanavin via=
 <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;a=
lex.kanavin=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gmail.com=
@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, 3 Jan 2022 at 23:38, Richard Purdie &=
lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">=
richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
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
t/poky/meta/recipes-graphics/libsdl2/<a href=3D"http://libsdl2_2.0.18.bb" t=
arget=3D"_blank">libsdl2_2.0.18.bb</a> due to virtual/libsdl2 provider star=
ting with virtual/<br>DEBUG: World build skipping /home/alex/development/po=
ky/meta/recipes-devtools/make/<a href=3D"http://make_4.3.bb" target=3D"_bla=
nk">make_4.3.bb</a> due to virtual/make provider starting with virtual/<br>=
DEBUG: World build skipping /home/alex/development/poky/meta/recipes-extend=
ed/libtirpc/<a href=3D"http://libtirpc_1.3.2.bb" target=3D"_blank">libtirpc=
_1.3.2.bb</a> due to virtual/librpc provider starting with virtual/<br>DEBU=
G: World build skipping /home/alex/development/poky/meta/recipes-devtools/g=
o/<a href=3D"http://go-runtime_1.17.5.bb" target=3D"_blank">go-runtime_1.17=
.5.bb</a> due to virtual/x86_64-poky-linux-go-runtime provider starting wit=
h virtual/<br>DEBUG: World build skipping /home/alex/development/poky/meta/=
recipes-core/libxcrypt/<a href=3D"http://libxcrypt_4.4.26.bb" target=3D"_bl=
ank">libxcrypt_4.4.26.bb</a> due to virtual/crypt provider starting with vi=
rtual/<br>DEBUG: World build skipping /home/alex/development/poky/meta/reci=
pes-graphics/xorg-xserver/<a href=3D"http://xserver-xorg_21.1.1.bb" target=
=3D"_blank">xserver-xorg_21.1.1.bb</a> due to virtual/xserver-xf86 provider=
 starting with virtual/<br>DEBUG: World build skipping /home/alex/developme=
nt/poky/meta/recipes-kernel/linux/<a href=3D"http://linux-yocto_5.10.bb" ta=
rget=3D"_blank">linux-yocto_5.10.bb</a> due to virtual/kernel provider star=
ting with virtual/<br>DEBUG: World build skipping /home/alex/development/po=
ky/meta/recipes-sato/rxvt-unicode/<a href=3D"http://rxvt-unicode_9.30.bb" t=
arget=3D"_blank">rxvt-unicode_9.30.bb</a> due to virtual/x-terminal-emulato=
r provider starting with virtual/<br>DEBUG: World build skipping /home/alex=
/development/poky/meta/recipes-core/gettext/<a href=3D"http://gettext_0.21.=
bb" target=3D"_blank">gettext_0.21.bb</a> due to virtual/libintl provider s=
tarting with virtual/<br>DEBUG: World build skipping /home/alex/development=
/poky/meta/recipes-core/glibc/<a href=3D"http://glibc-locale_2.34.bb" targe=
t=3D"_blank">glibc-locale_2.34.bb</a> due to virtual/libc-locale provider s=
tarting with virtual/<br>DEBUG: World build skipping /home/alex/development=
/poky/meta/recipes-multimedia/libomxil/<a href=3D"http://libomxil_0.9.3.bb"=
 target=3D"_blank">libomxil_0.9.3.bb</a> due to virtual/libomxil provider s=
tarting with virtual/<br>DEBUG: World build skipping /home/alex/development=
/poky/meta/recipes-devtools/gcc/<a href=3D"http://libgcc-initial_11.2.bb" t=
arget=3D"_blank">libgcc-initial_11.2.bb</a> as task do_build doesn&#39;t ex=
ist<br>DEBUG: World build skipping /home/alex/development/poky/meta/recipes=
-core/glibc/<a href=3D"http://glibc_2.34.bb" target=3D"_blank">glibc_2.34.b=
b</a> due to virtual/libc provider starting with virtual/<br>DEBUG: World b=
uild skipping /home/alex/development/poky/meta/recipes-kernel/perf/<a href=
=3D"http://perf.bb" target=3D"_blank">perf.bb</a> due to virtual/perf provi=
der starting with virtual/<br>DEBUG: World build skipping /home/alex/develo=
pment/poky/meta/recipes-bsp/u-boot/<a href=3D"http://u-boot_2021.10.bb" tar=
get=3D"_blank">u-boot_2021.10.bb</a> due to virtual/bootloader provider sta=
rting with virtual/<br>DEBUG: World build skipping /home/alex/development/p=
oky/meta/recipes-graphics/mesa/<a href=3D"http://mesa_21.3.1.bb" target=3D"=
_blank">mesa_21.3.1.bb</a> due to virtual/libgl provider starting with virt=
ual/<br>DEBUG: World build skipping /home/alex/development/poky/meta/recipe=
s-kernel/linux/<a href=3D"http://linux-yocto_5.15.bb" target=3D"_blank">lin=
ux-yocto_5.15.bb</a> due to virtual/kernel provider starting with virtual/<=
br>DEBUG: World build skipping /home/alex/development/poky/meta/recipes-dev=
tools/dpkg/<a href=3D"http://dpkg_1.21.1.bb" target=3D"_blank">dpkg_1.21.1.=
bb</a> due to virtual/update-alternatives provider starting with virtual/<b=
r>DEBUG: World build skipping /home/alex/development/poky/meta/recipes-grap=
hics/xorg-lib/<a href=3D"http://libx11_1.7.3.1.bb" target=3D"_blank">libx11=
_1.7.3.1.bb</a> due to virtual/libx11 provider starting with virtual/<br>DE=
BUG: World build skipping /home/alex/development/poky/meta/recipes-kernel/l=
inux/<a href=3D"http://linux-yocto_5.14.bb" target=3D"_blank">linux-yocto_5=
.14.bb</a> due to virtual/kernel provider starting with virtual/<br>DEBUG: =
World build skipping /home/alex/development/poky/meta/recipes-devtools/opkg=
-utils/<a href=3D"http://opkg-utils_0.5.0.bb" target=3D"_blank">opkg-utils_=
0.5.0.bb</a> due to virtual/update-alternatives provider starting with virt=
ual/<br>DEBUG: World build skipping /home/alex/development/poky/meta/recipe=
s-devtools/gcc/<a href=3D"http://gcc-runtime_11.2.bb" target=3D"_blank">gcc=
-runtime_11.2.bb</a> due to virtual/x86_64-poky-linux-compilerlibs provider=
 starting with virtual/<br>DEBUG: World build skipping /home/alex/developme=
nt/poky/meta/recipes-devtools/pseudo/<a href=3D"http://pseudo_git.bb" targe=
t=3D"_blank">pseudo_git.bb</a> due to virtual/fakeroot provider starting wi=
th virtual/<br></div><div><br></div></div><div class=3D"gmail_quote">Alex<b=
r></div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13215): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13215" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13215</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/88071309/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/88071309/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000002538bb05d4bdeed4--

