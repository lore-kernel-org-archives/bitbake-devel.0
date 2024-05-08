Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2437CC04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 10:24:52 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.8824.1715163887282058121
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 May 2024 03:24:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KYOYj6I6;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f0602bc58so671698e87.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 May 2024 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715163885; x=1715768685; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx9+M/WvOnZhAu1Z2mBHu17wqeusS1E+obAnmkg62UA=;
        b=KYOYj6I6uwcoY1VJFZN8PmdHKQ6ptDntx6sKpNwo3/BvWXwFTvG6F4o77XdSjTc4rR
         lkLMYSuZrzHaXC3zqSEyXXyS3O9ef4Vv4qYUvjQdEcwvzub3FvX69D4Ljb8a8v5WQVEL
         C6eK4B/3pAZMuNbWUnpDjcN4kFL41WuLPFiv+gdsd6MeU0+jrPeDrKtFnWAalM9URywb
         tGKectUtHNrclD1U6HDTH4giT4rTapvdnSVkY+ym8Q6yEJdXpWWnLyMqJapk2XBrjyRp
         C2d/dUPkctZ+KNoMLXoT5Iwo+osFvZYxh8FKjUgukhGYIy0+0Q/HdWwqyqUlAGnPAL4U
         IY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715163885; x=1715768685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx9+M/WvOnZhAu1Z2mBHu17wqeusS1E+obAnmkg62UA=;
        b=fUTPSswIw3UsNML7M9TNtYi/GDhdLUBYiaBCXGn7y9+tYQvq/qRd7lwuvAudKOfzzX
         OuhqzN4AXv8hD1Rg+JYNH1+irmEJ6i/uoPEvanpM1a66q0Fexl17xGbUkyL8T/4G+RqP
         PkTmWgxGs5b3P/UwAouvI5RpTBhUgp1X5b561kO7nIFezKK5NVs6ktQCG4zyr6xPFq12
         0wCneqLJ0YlDnfwh/kYeP2n+8ATlWfc4P8OrMVTRHwcqo39gObPuv0NHCu1p6/UYJRTZ
         1kLDt6AzzIgHDRWkX8kQksom978vs4bduwVtu9x35SBcFmFDzudUgq8v1XFs+ok4wocP
         cfrA==
X-Gm-Message-State: AOJu0Yy9CmKUNma7exJoeEoOKYLRLiJrhYmeh93xBga2haWz+5xYF9zZ
	Lpv8ja1rIhH6SmNqcOalhlSNHxEvBVqo6V+OXmz3gYSQFrkpur8dX+uVcCbeAuMvnPjxFZQPBCn
	PNI0LCQLyjdR8YVhwvjkbEKMXIbw=
X-Google-Smtp-Source: AGHT+IE+OJdgDYX3Ct+epZm47E0YxB1e44p8CQarXGJkkHGYDs5JaK1Ba2wWdMOU6N1fdpCOywrdHpBJVqRh4MLSWxg=
X-Received: by 2002:ac2:54bb:0:b0:518:f4e9:201c with SMTP id
 2adb3069b0e04-52110289c19mr1528396e87.16.1715163885127; Wed, 08 May 2024
 03:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHGBnuOn-i=R0cxfWqGgQUsDnKjcrP3ERhX1jnZhgVRsWz=fhg@mail.gmail.com>
 <CAHGBnuO27AaCCfxGyk9wzi0A1F9DKQQTgg7YQUJDnBVkuOSDDg@mail.gmail.com>
In-Reply-To: <CAHGBnuO27AaCCfxGyk9wzi0A1F9DKQQTgg7YQUJDnBVkuOSDDg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 8 May 2024 12:24:33 +0200
Message-ID: <CANNYZj_bodmBROAZdwRsW6htamiDVx3M=gWjS6rP9W=rX4h9JQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Generating SPDX documents without actually building
To: sschuberth@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000001acf550617eeb6b9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 May 2024 10:24:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16188

--0000000000001acf550617eeb6b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The correct forum is the yocto list.

Alex

On Wed 8. May 2024 at 12.19, Sebastian Schuberth via lists.openembedded.org
<sschuberth=3Dgmail.com@lists.openembedded.org> wrote:

> Apologies for bumping this thread, but just to double-check: Is this the
> right place to ask this kind of question? I realize it's a "devel" mailin=
g
> list, but I couldn't find "bitbake-user" mailing list or so...
>
> --
> Sebastian Schuberth
>
>
> On Thu, May 2, 2024 at 6:01=E2=80=AFPM Sebastian Schuberth <sschuberth@gm=
ail.com>
> wrote:
>
>> Hi all,
>>
>> to start with a disclaimer, I'm a total noob when it comes to Open
>> Embedded / Embedded Linux / Yocto / BitBake stuff. That said, I'm in nee=
d
>> of creating SPDX documents for Yocto projects in the context of [1]. I'm
>> already quite far in that I work with Poky and programmatically run
>> something like
>>
>> bitbake -r
>> /home/sebastian/Development/GitHub/doubleopen-project/ort/plugins/packag=
e-managers/bitbake/src/main/resources/spdx.conf
>> -c create_spdx xmlto
>>
>> However, I continuously run into various build problems on my Fedora 40
>> machine (one of which has been recently addressed by [2]), let alone the
>> time it takes to build something from scratch, even something as small a=
s
>> e.g. the "xmlto" target. So, ideally, I would be able to create SPDX
>> documents without really building any binaries at all. I probably want a=
ll
>> the source download and patching to happen, in order to archive the patc=
hed
>> code that goes into the binaries, but skip the actual compiler / linker
>> invocations to save time, and just create the SPDX documents.
>>
>> Is something like this already possible somehow, maybe by setting from
>> compiler / linker variables to fake scripts that just do nothing?
>>
>> Thanks for any insights!
>>
>> [1]: https://github.com/oss-review-toolkit/ort/issues/722
>> [2]:
>> https://github.com/openembedded/bitbake/commit/f10e630fd7561746d835a4378=
e8777e78f56e44a
>>
>> --
>> Sebastian Schuberth
>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16187):
> https://lists.openembedded.org/g/bitbake-devel/message/16187
> Mute This Topic: https://lists.openembedded.org/mt/105865802/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000001acf550617eeb6b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">The correct forum is the yocto list.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Alex</div><div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed 8. May 2024 at 12.19, Sebast=
ian Schuberth via <a href=3D"http://lists.openembedded.org">lists.openembed=
ded.org</a> &lt;sschuberth=3D<a href=3D"mailto:gmail.com@lists.openembedded=
.org">gmail.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,2=
04)"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace">Apologies for bumping this thread, but just to double-che=
ck: Is this the right place to ask this kind of question? I realize it&#39;=
s a &quot;devel&quot; mailing list, but I couldn&#39;t find &quot;bitbake-u=
ser&quot; mailing list or so...</div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace"><br clear=3D"all"></div><div><div dir=3D"l=
tr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div>-- <br></div><div>Sebastian Schuberth</div></div></div></div>=
<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, May 2, 2024 at 6:01=E2=80=AFPM Sebastian Schuberth &lt;<a href=
=3D"mailto:sschuberth@gmail.com" target=3D"_blank">sschuberth@gmail.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1e=
x;border-left-color:rgb(204,204,204)"><div dir=3D"ltr"><div class=3D"gmail_=
default" style=3D"font-family:monospace,monospace">Hi all,</div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace">to start=
 with a disclaimer, I&#39;m a total noob when it comes to Open Embedded / E=
mbedded Linux / Yocto / BitBake stuff. That said, I&#39;m in need of creati=
ng SPDX documents for Yocto projects in the context of [1]. I&#39;m already=
 quite far in that I work with Poky and programmatically run something like=
</div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace=
"><br></div><div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace"><span style=3D"font-family:monospace"><span style=3D"font-family:mo=
nospace;background-color:rgb(255,255,255);color:rgb(0,0,0)">bitbake -r /hom=
e/sebastian/Development/GitHub/doubleopen-project/ort/plugins/package-manag=
er</span>s/bitbake/src/main/resources/spdx.conf -c create_spdx xmlto<br></s=
pan></div><div class=3D"gmail_default" style=3D"font-family:monospace,monos=
pace"><span style=3D"font-family:monospace"><br></span></div><div class=3D"=
gmail_default" style=3D"font-family:monospace,monospace"><span style=3D"fon=
t-family:monospace,monospace">However, I continuously run into various buil=
d problems on my Fedora 40 machine (one of which has been recently addresse=
d by [2]), let alone the time it takes to build something from scratch, eve=
n something as small as e.g. the &quot;xmlto&quot; target. So, ideally, I w=
ould be able to create SPDX documents without really building any binaries =
at all. I probably want all the source download and patching to happen, in =
order to archive the patched code that goes into the binaries, but skip the=
 actual compiler / linker invocations to save time, and just create the SPD=
X documents.</span></div><div class=3D"gmail_default" style=3D"font-family:=
monospace,monospace"><span style=3D"font-family:monospace,monospace"><br></=
span></div><div class=3D"gmail_default" style=3D"font-family:monospace,mono=
space"><span style=3D"font-family:monospace,monospace">Is something like th=
is already possible somehow, maybe by setting from compiler / linker variab=
les to fake scripts that just do nothing?</span></div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace"><span style=3D"font-famil=
y:monospace,monospace"><br></span></div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><span style=3D"font-family:monospace,m=
onospace">Thanks for any insights!<br></span></div><div class=3D"gmail_defa=
ult" style=3D"font-family:monospace,monospace"><br></div><div class=3D"gmai=
l_default" style=3D"font-family:monospace,monospace">[1]: <a href=3D"https:=
//github.com/oss-review-toolkit/ort/issues/722" target=3D"_blank" style=3D"=
font-family:monospace,monospace">https://github.com/oss-review-toolkit/ort/=
issues/722</a></div><div class=3D"gmail_default" style=3D"font-family:monos=
pace,monospace">[2]: <a href=3D"https://github.com/openembedded/bitbake/com=
mit/f10e630fd7561746d835a4378e8777e78f56e44a" target=3D"_blank" style=3D"fo=
nt-family:monospace,monospace">https://github.com/openembedded/bitbake/comm=
it/f10e630fd7561746d835a4378e8777e78f56e44a</a></div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace"><br clear=3D"all"></div><d=
iv><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>-- <br>=
</div><div>Sebastian Schuberth</div></div></div></div></div>
</blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16187): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16187" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16187</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/105865802/168=
6489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/105865802/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--0000000000001acf550617eeb6b9--

