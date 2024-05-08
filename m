Return-Path: <sschuberth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2A9C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 10:20:02 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web10.8745.1715163595949244669
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 May 2024 03:19:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SLb54hh4;
 spf=pass (domain: gmail.com, ip: 209.85.218.43, mailfrom: sschuberth@gmail.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a554cf23c3eso34685966b.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 May 2024 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715163594; x=1715768394; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezqB+wZsU6vYb6rIwbcsBrNNJzLWDfYuqlCpv30SSUU=;
        b=SLb54hh4qxQnnQKwsXGG+N0DmenqZLFGzy5m7ozXUV4hpPS/ebNd+yBfmXVWY4Hh8K
         aqDpu8d8scjfOVptyg7hKqtw6yqk6OzuLkKSJelablHQxELd1GXclmrIaQPcGVy2CPcV
         gbA4d1Kvr2L90h/rBETXLurbfNgCbchXULBI0C0PoTf1oblIYSCpSScEwoJ9GHiONU+O
         dx3SGy4mZCIbxtRVCmmDz8TLzU2JLnoj3CGRrweRetDIPz/2qfqdmX/QdMRgbQKQwfwc
         nHlilqbdz8dJHQ0bJIkSBP3fSFwGijNt2ilC5wfKlM0tqoLXJoSQt4rztYNvjUppqiqw
         ynNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715163594; x=1715768394;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezqB+wZsU6vYb6rIwbcsBrNNJzLWDfYuqlCpv30SSUU=;
        b=U+Lbmwa1ELOTmGLaNwFqMfRR45IAk4lci6WyiZoEvi7/Rt2ThpHlf8tdvG4LPpEMPT
         6fOJponUWYTJTzfDLKTacunf7DkYUyX4lr6Q1G3PaGMwprt+rkZhI+o0oDZFGG9lF2bt
         4YpNpu9cmjyMkTBhr6YhAQsUNAo3imOaZnIhUvcMgZ1T64D/gv9iU1B9Yje+xgW8SuUA
         DKFZvKcfs3biN+aNhDz48qsdXlhU8vFTjOUyVOsGXveIZkotePXZuUu9TKOEhF4hhLiY
         RaStaRcp2wGJ6yaIztcMmhcGgXmrEp3iCD/k/+r7S3V94EuXJA6YT4xDbaGCCbVtOeFS
         YpgA==
X-Gm-Message-State: AOJu0Yzc0GOH+gtrIjMT/rG/o/WVM5BjifXt6+dAsVyjVnhU5Eb4NjwT
	Ttt5MPJ9lFrWq7hZIl/sqDtC5/n2LOCcQtYhPzM8P2HoWvTL52xUaAxNWRuYX2SAHaAv+JZNn0V
	Nxn4vB3r5+zbwKWgo24Q2DXGQLVdlBw==
X-Google-Smtp-Source: AGHT+IHy0MBqiyZZwBCOh+7FNoiaju0SqXuX3oCe3OdGn8GWQ7eE/OmRFdqzHhVEJGNZ1UWNbcB5zGHP+iYjNCnmCtg=
X-Received: by 2002:a05:6402:5408:b0:572:5dcd:a68 with SMTP id
 4fb4d7f45d1cf-5731da901e5mr1243618a12.4.1715163593674; Wed, 08 May 2024
 03:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHGBnuOn-i=R0cxfWqGgQUsDnKjcrP3ERhX1jnZhgVRsWz=fhg@mail.gmail.com>
In-Reply-To: <CAHGBnuOn-i=R0cxfWqGgQUsDnKjcrP3ERhX1jnZhgVRsWz=fhg@mail.gmail.com>
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Wed, 8 May 2024 12:19:42 +0200
Message-ID: <CAHGBnuO27AaCCfxGyk9wzi0A1F9DKQQTgg7YQUJDnBVkuOSDDg@mail.gmail.com>
Subject: Re: Generating SPDX documents without actually building
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000bb989d0617eea424"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 May 2024 10:20:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16187

--000000000000bb989d0617eea424
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for bumping this thread, but just to double-check: Is this the
right place to ask this kind of question? I realize it's a "devel" mailing
list, but I couldn't find "bitbake-user" mailing list or so...

--=20
Sebastian Schuberth


On Thu, May 2, 2024 at 6:01=E2=80=AFPM Sebastian Schuberth <sschuberth@gmai=
l.com>
wrote:

> Hi all,
>
> to start with a disclaimer, I'm a total noob when it comes to Open
> Embedded / Embedded Linux / Yocto / BitBake stuff. That said, I'm in need
> of creating SPDX documents for Yocto projects in the context of [1]. I'm
> already quite far in that I work with Poky and programmatically run
> something like
>
> bitbake -r
> /home/sebastian/Development/GitHub/doubleopen-project/ort/plugins/package=
-managers/bitbake/src/main/resources/spdx.conf
> -c create_spdx xmlto
>
> However, I continuously run into various build problems on my Fedora 40
> machine (one of which has been recently addressed by [2]), let alone the
> time it takes to build something from scratch, even something as small as
> e.g. the "xmlto" target. So, ideally, I would be able to create SPDX
> documents without really building any binaries at all. I probably want al=
l
> the source download and patching to happen, in order to archive the patch=
ed
> code that goes into the binaries, but skip the actual compiler / linker
> invocations to save time, and just create the SPDX documents.
>
> Is something like this already possible somehow, maybe by setting from
> compiler / linker variables to fake scripts that just do nothing?
>
> Thanks for any insights!
>
> [1]: https://github.com/oss-review-toolkit/ort/issues/722
> [2]:
> https://github.com/openembedded/bitbake/commit/f10e630fd7561746d835a4378e=
8777e78f56e44a
>
> --
> Sebastian Schuberth
>

--000000000000bb989d0617eea424
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Apologies for bumping this thread, but just to double-check: I=
s this the right place to ask this kind of question? I realize it&#39;s a &=
quot;devel&quot; mailing list, but I couldn&#39;t find &quot;bitbake-user&q=
uot; mailing list or so...</div><div class=3D"gmail_default" style=3D"font-=
family:monospace,monospace"><br clear=3D"all"></div><div><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
"><div>-- <br></div><div>Sebastian Schuberth</div></div></div></div><br></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Thu, May 2, 2024 at 6:01=E2=80=AFPM Sebastian Schuberth &lt;<a href=3D"mail=
to:sschuberth@gmail.com">sschuberth@gmail.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D=
"gmail_default" style=3D"font-family:monospace,monospace">Hi all,</div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></di=
v><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">to=
 start with a disclaimer, I&#39;m a total noob when it comes to Open Embedd=
ed / Embedded Linux / Yocto / BitBake stuff. That said, I&#39;m in need of =
creating SPDX documents for Yocto projects in the context of [1]. I&#39;m a=
lready quite far in that I work with Poky and programmatically run somethin=
g like</div><div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace"><br></div><div class=3D"gmail_default" style=3D"font-family:monospa=
ce,monospace"><span style=3D"font-family:monospace"><span style=3D"color:rg=
b(0,0,0);background-color:rgb(255,255,255)">bitbake -r /home/sebastian/Deve=
lopment/GitHub/doubleopen-project/ort/plugins/package-manager</span>s/bitba=
ke/src/main/resources/spdx.conf -c create_spdx xmlto<br></span></div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace,monospace"><span styl=
e=3D"font-family:monospace"><br></span></div><div class=3D"gmail_default" s=
tyle=3D"font-family:monospace,monospace"><span>However, I continuously run =
into various build problems on my Fedora 40 machine (one of which has been =
recently addressed by [2]), let alone the time it takes to build something =
from scratch, even something as small as e.g. the &quot;xmlto&quot; target.=
 So, ideally, I would be able to create SPDX documents without really build=
ing any binaries at all. I probably want all the source download and patchi=
ng to happen, in order to archive the patched code that goes into the binar=
ies, but skip the actual compiler / linker invocations to save time, and ju=
st create the SPDX documents.</span></div><div class=3D"gmail_default" styl=
e=3D"font-family:monospace,monospace"><span><br></span></div><div class=3D"=
gmail_default" style=3D"font-family:monospace,monospace"><span>Is something=
 like this already possible somehow, maybe by setting from compiler / linke=
r variables to fake scripts that just do nothing?</span></div><div class=3D=
"gmail_default" style=3D"font-family:monospace,monospace"><span><br></span>=
</div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace=
"><span>Thanks for any insights!<br></span></div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_=
default" style=3D"font-family:monospace,monospace">[1]: <a href=3D"https://=
github.com/oss-review-toolkit/ort/issues/722" target=3D"_blank">https://git=
hub.com/oss-review-toolkit/ort/issues/722</a></div><div class=3D"gmail_defa=
ult" style=3D"font-family:monospace,monospace">[2]: <a href=3D"https://gith=
ub.com/openembedded/bitbake/commit/f10e630fd7561746d835a4378e8777e78f56e44a=
" target=3D"_blank">https://github.com/openembedded/bitbake/commit/f10e630f=
d7561746d835a4378e8777e78f56e44a</a></div><div class=3D"gmail_default" styl=
e=3D"font-family:monospace,monospace"><br clear=3D"all"></div><div><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>-- <br></div><div>=
Sebastian Schuberth</div></div></div></div></div>
</blockquote></div>

--000000000000bb989d0617eea424--

