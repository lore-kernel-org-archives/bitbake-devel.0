Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35889C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 19:08:48 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.5455.1740078526990500664
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 11:08:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Sf+W1ltR;
 spf=pass (domain: gmail.com, ip: 209.85.166.174, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d1a428471fso9803415ab.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 11:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740078526; x=1740683326; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mRl0X5VuAQiOnCxuaGFNB9LEZzAbi8JueLk8dCrBoAA=;
        b=Sf+W1ltRx7O0DKBQ257Zm6HLkIyUxoRJBI2hCrNNpS3XaXUhnlwasTvpCbhRwZCZyW
         Nw3q+n2wjGOPKmCIgYE7sFPZORaeOQB68S8FzqzMCKbmH6TEMWvOyhvSQ9xRnX7oVMSX
         ahZ6vaDI/FBrlPzkevxOa6ORU8T9FeDTfxbLNxd2NtYK3MawsZByuullO7lkQzBBZTKr
         wXVf3vmSvOO5lcHn/Xn3bFB25srVfQZKH7w7qahJ14p4dJR/clxj0jCopCTl2Qr4welr
         9TyAQ0vzpZMjF1+VnD+JHe+hx0B3UtygnnfplCz9/mJKnrxIxg8kc/E7GJBvKrsobRt/
         R43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078526; x=1740683326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRl0X5VuAQiOnCxuaGFNB9LEZzAbi8JueLk8dCrBoAA=;
        b=vWZyPaqqhgjL9lNFFRF8XoR0/LGHluybDodWGGBuku/gcI6Hc+Xuwqk7mPB2MVTXTL
         a+xl8cMfHZv4o9xAlST1LbpsS9CI/cm8ZI1OImHtPx1ymS4h6VpGiW8nCaqUWYKJqQhE
         e6FDQyrbL9Bw/tFiNXe/1zyV9wsTSstkOcAKSKyz5uNXgQpI2hcnNvHhAxwTRfWD/2VY
         NX8qwJgT+Fx1Uml9ow2CXVx2wOb9qwdwIMX78m8JhiTXRHOpK6a4+cE/GVV2aMJeogNN
         7r30kQSO8ajIXJKkBDh3OiYcY7V1Fm+VBe+qQ9a7EqO7FWAk2t62izPQ/A4ZTg7EWr1D
         pUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYrf6MTunoZoIV2dRUMUQ/sJkuF4MWOZP70poidYaoEafxw6sC1lkjLNaM7kpF446dksSdMijQhc51KLjF@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz16Ff41uDMksG/Mw9XIEBOjCIRDMY6LiFaYj5zZWamb/JPrnHq
	jR+Vahh5pVsbPoD+kUIQy0Fqrah58awTQAOi+BMSgx452t9SaQQ3xAIH4ORQM8L348mUnBlmMX0
	JoZkO2NTceXxvRk3IqcdU7xrEb8A=
X-Gm-Gg: ASbGnctSPQWp9QXPSlm3CxWSUpKZSlwzR+LBrVq2njk205O42mbWMF7IZWvzKC35dCR
	5CYlp82DwlLV/MlcoY9LeuBYJIOd2pc4xgi2OisyknQTr74eA6PHaUib0HCY6dOcQB97b3eimxD
	7319mP592rHbUjLBfUSwVUOUzUiTEYnA==
X-Google-Smtp-Source: AGHT+IEby9G01tbGo3XX8GhHa0ABUMjUzUKWQj0qu1m5C4prUdABEQxUrtcv9i97tF9jaPQDro8Wop8xDlf22zkMMHQ=
X-Received: by 2002:a05:6e02:3891:b0:3d2:b3d0:dbba with SMTP id
 e9e14a558f8ab-3d2cae50974mr3688215ab.5.1740078526147; Thu, 20 Feb 2025
 11:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20250220143030.12982-1-eric.meyers@arthrex.com>
 <20250220143030.12982-2-eric.meyers@arthrex.com> <CANNYZj_d1vuPc9M6+6WBnrQ-RRDRArngsDxSi_8ghjeK=pDO4A@mail.gmail.com>
 <CA+cKJ+Gvb8FjFwTnjT4EFDhU-c-gQYA8G34-wAEmcYMYSyBQMA@mail.gmail.com>
In-Reply-To: <CA+cKJ+Gvb8FjFwTnjT4EFDhU-c-gQYA8G34-wAEmcYMYSyBQMA@mail.gmail.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Thu, 20 Feb 2025 11:08:29 -0800
X-Gm-Features: AWEUYZnVWckpPuMYi89A4FC1-vE_Wv75cVjTpVCC2D33yiB1WpBWYHgG4xkUig0
Message-ID: <CAB=6tBSOFHMAja1JyhiXW2jMctsLfNFjA_1kXXDe2PTh4a5u5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fetch2/npm: Adding npmrc support for private
 registry authentication
To: Eric Meyers <eric.meyers15310@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: multipart/alternative; boundary="0000000000006eb5a6062e979a59"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 19:08:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17267

--0000000000006eb5a6062e979a59
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 8:33=E2=80=AFAM Eric Meyers <eric.meyers15310@gmail=
.com>
wrote:

> On Thu, Feb 20, 2025 at 9:48=E2=80=AFAM Alexander Kanavin <alex.kanavin@g=
mail.com>
> wrote:
> >
> > I'm broadly ok with this (except the question below), but it needs to
> > be lgtm'd by real npm fetcher users.
> >
> > Does npmrc contain secrets? Would copying it to some tmpdir put the
> > secrets at risk?
>

If the secrets are already in $HOME, copying them into a build is not going
to
expose things any more than they already are.

That being said, as a general rule I would prefer that we be more explicit
when elements found in $HOME are being used in a build.

I say this from a build consistency standpoint more than anything else. As
someone
who is responsible for consistent results across a wide range of developers
and
platforms, environment creep is a huge time-sink.

Can we disable this behavior by default and allow it to be enabled in the
distro
or local config with a flag?



> The only reason I copied the .npmrc file into the tmp directory was to
> avoid losing any user-provided configs passed into the environment
>

I think this is very problematic from a build consistency standpoint. As I
noted above, I see no problem with reusing credentials. But I have
significant
concerns with reusing anything else.

I believe it is possible to configure an .npmrc in a way that can trigger
behavior variations that affect build results. Build variation should be
controlled by the distro level configs and the recipe. All other sources
of variation should be disallowed or, at the very least, disabled by
default with the option to enable if you are willing to accept the
consequences.



> (I could have taken the opposite approach and modified the user's .npmrc
> file instead, but didn't think that was desirable)
>

Correct, it is definitely undesirable. Can you simply grab the credentials
from a
user's npmrc if they happen to be available? Or does that fall into the
"easier
said than done" bucket?



> FWIW, the wget fetcher relies on a netrc file in a user's home directory
> in a similar fashion, which uses username/password in plaintext to insert=
 a
> basic auth header to a URL
>

I am unaware of any netrc behavior that could introduce uncontrolled build
variation. But I learn something new every day, so maybe it is possible?

..Ch:W..


--=20



*  Opinions expressed are my own. | --------------------------------|------
"Perfection must be reached by degrees              she requires the slow
hand of time."                                 |       -Voltaire*

--0000000000006eb5a6062e979a59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace">On Thu, Feb 20, 2025 at 8:33=E2=80=AFAM Eric Meyers &lt=
;<a href=3D"mailto:eric.meyers15310@gmail.com">eric.meyers15310@gmail.com</=
a>&gt; wrote:</div></div><div class=3D"gmail_quote gmail_quote_container"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">On Thu, Feb 20, 2025 at 9:48=E2=
=80=AFAM Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" ta=
rget=3D"_blank">alex.kanavin@gmail.com</a>&gt; wrote:<br>&gt;<br>&gt; I&#39=
;m broadly ok with this (except the question below), but it needs to<br>&gt=
; be lgtm&#39;d by real npm fetcher users.<br>&gt;<br>&gt; Does npmrc conta=
in secrets? Would copying it to some tmpdir put the<br>&gt; secrets at risk=
?<br></div></div></div></div></blockquote><div><div style=3D"font-family:mo=
nospace" class=3D"gmail_default"><br>If the secrets are already in $HOME, c=
opying them into a build is not going to</div><div style=3D"font-family:mon=
ospace" class=3D"gmail_default">expose things any more than they already ar=
e.<br><br></div><div style=3D"font-family:monospace" class=3D"gmail_default=
">That being said, as a general rule I would prefer that we be more explici=
t</div><div style=3D"font-family:monospace" class=3D"gmail_default">when el=
ements found in $HOME are being used in a build.</div><div style=3D"font-fa=
mily:monospace" class=3D"gmail_default"><br></div><div style=3D"font-family=
:monospace" class=3D"gmail_default">I say this from a build consistency sta=
ndpoint more than anything else. As someone</div><div style=3D"font-family:=
monospace" class=3D"gmail_default">who is responsible for consistent result=
s across a wide range of developers and</div><div style=3D"font-family:mono=
space" class=3D"gmail_default">platforms, environment creep is a huge time-=
sink.</div><div style=3D"font-family:monospace" class=3D"gmail_default"><br=
></div><div style=3D"font-family:monospace" class=3D"gmail_default">Can we =
disable this behavior by default and allow it to be enabled in the distro</=
div><div style=3D"font-family:monospace" class=3D"gmail_default">or local c=
onfig with a flag?</div><div style=3D"font-family:monospace" class=3D"gmail=
_default"> <br></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div =
dir=3D"ltr">The only reason I copied the .npmrc file into the tmp directory=
 was to avoid losing any user-provided configs passed into the environment<=
/div></div></div></div></blockquote><div><br></div><div><div style=3D"font-=
family:monospace" class=3D"gmail_default">I think this is very problematic =
from a build consistency standpoint. As I</div><div style=3D"font-family:mo=
nospace" class=3D"gmail_default">noted above, I see no problem with reusing=
 credentials. But I have significant</div><div style=3D"font-family:monospa=
ce" class=3D"gmail_default">concerns with reusing anything else.<br><br><di=
v style=3D"font-family:monospace" class=3D"gmail_default">I believe it is p=
ossible to configure an .npmrc in a way that can trigger<br></div><div styl=
e=3D"font-family:monospace" class=3D"gmail_default">behavior variations tha=
t affect build results. Build variation should be</div><div style=3D"font-f=
amily:monospace" class=3D"gmail_default">controlled by the distro level con=
figs and the recipe. All other sources</div><div style=3D"font-family:monos=
pace" class=3D"gmail_default">of variation should be disallowed or, at the =
very least, disabled by</div><div style=3D"font-family:monospace" class=3D"=
gmail_default">default with the option to enable if you are willing to acce=
pt the</div><div style=3D"font-family:monospace" class=3D"gmail_default">co=
nsequences.</div><br>=C2=A0</div></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"> (I could have taken the opposite approach and modified the user&#=
39;s .npmrc file instead, but didn&#39;t think that was desirable)</div></d=
iv></div></div></blockquote><div><br></div><div><div style=3D"font-family:m=
onospace" class=3D"gmail_default">Correct, it is definitely undesirable. Ca=
n you simply grab the credentials from a</div><div style=3D"font-family:mon=
ospace" class=3D"gmail_default">user&#39;s npmrc if they happen to be avail=
able? Or does that fall into the &quot;easier</div><div style=3D"font-famil=
y:monospace" class=3D"gmail_default">said than done&quot; bucket?</div><br>=
</div><div>=C2=A0 <br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">FWIW=
, the wget fetcher relies on a netrc file in a user&#39;s home directory in=
 a similar fashion, which uses username/password in plaintext to insert a b=
asic auth header to a URL</div></div></div></div>
</blockquote></div><div><br><div style=3D"font-family:monospace" class=3D"g=
mail_default">I am unaware of any netrc behavior that could introduce uncon=
trolled build</div><div style=3D"font-family:monospace" class=3D"gmail_defa=
ult">variation. But I learn something new every day, so maybe it is possibl=
e?<br><br></div><div style=3D"font-family:monospace" class=3D"gmail_default=
">..Ch:W..</div><div style=3D"font-family:monospace" class=3D"gmail_default=
"><br></div></div><br><span class=3D"gmail_signature_prefix">-- </span><br>=
<div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><b><span s=
tyle=3D"font-family:monospace">=C2=A0 Opinions expressed are my own. |<br>=
=C2=A0--------------------------------|------ &quot;Perfection must be reac=
hed by degrees<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 she requires the slow hand of time.&quot;<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
-Voltaire</span></b></div></div></div></div>

--0000000000006eb5a6062e979a59--

