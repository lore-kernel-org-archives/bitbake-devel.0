Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C5C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 12:22:08 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.128378.1680697326256703140
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 05:22:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=JUP75Cbw;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id t14so37108703ljd.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680697324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NzaEi5+8bQPDEAOKZdJsOsN4dF/o+BBwpM3a7kGxG0k=;
        b=JUP75CbwiWJDK9puwRPeW6drZSqbnQ1e3tmWbDCloBtZOQM2ZTd+El4tbOhfF1L1Px
         P3807588OTvyy3WokrEqn5jnudSM2ZdKq/KtfNOTXAKSU48kdcv1S6geRdR+fzADmQed
         VFgt4/vGPRik8oeDvM+QfGzrVANaVG/BKQIgAvPDp380d/UiWTidmVhwNXIqzrKojXn0
         /szoH063oHjiqgJheaXbMCdilcR93zojSG8N+KJrlyLCKkZsx6HDPodel/AtjkzrFDxO
         9eMf4yhFJ6sg1DOmXQg3Fmrg8BC08pkHt8F/tmqFFJP7mh6qo+5phIuWSLlL1ML+dKP+
         M8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680697324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzaEi5+8bQPDEAOKZdJsOsN4dF/o+BBwpM3a7kGxG0k=;
        b=Kuv4jDe63v2dBS9z8F12kmiAnF7R+jFqXUliKBRkM4Y66qHe7vaeLEBsY+kLXpb47F
         i8A+NW8v5hWbm3hgrUx0eFQzOx4GoFy2lxGX83Ooj8xwcF+EVce2kM4JmnPvPPX88rsn
         sehCGgYUru9XQva7n9+6eg3wppO1hBbb6EJo4ShBm+6kxcwJjco6lCsgejK2DuvBrjTv
         umpmTYVJyXqhSaNXNvUJC30kPwzs6OCclE0jK3nbTostZriRmL7kMfDPlpPJFaZAzA1O
         WerrFON5FrHn+IQxgJsKcautBb+U82FKXOUx77QBElYGtLn1VeR+a5z+sWR1Weo7OvBN
         gclQ==
X-Gm-Message-State: AAQBX9fPaPHQ1Ad5Hs5r3i3x9Drx1QTmb+YFN4YIj0eg2lyhfEJ9UYm9
	XiQf1u0MYVmZtNIuTU8yu7SbdSla3wcje5uY9bY=
X-Google-Smtp-Source: AKy350YOs2w6wjWyeQq/meZTMmnQt91Mzitab6qI8XiLN8rZ/YgMR1Bt7sbzba9Ftv36Nux2EsuEI4H6wFY9R/SNBuw=
X-Received: by 2002:a05:651c:546:b0:2a2:35dd:4b30 with SMTP id
 q6-20020a05651c054600b002a235dd4b30mr1010994ljp.3.1680697324107; Wed, 05 Apr
 2023 05:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com> <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de>
In-Reply-To: <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 5 Apr 2023 14:21:52 +0200
Message-ID: <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name' entries
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000fa7bee05f895d698"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 12:22:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14653

--000000000000fa7bee05f895d698
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Apr 2023 at 14:09, Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
wrote:

> > To bootstrap a cargo base recipe which have not this checksum list, below
> > are
> > the steps to make:
> >   - make the recipe inherit cargo-update-recipe-crates
> >   - remove all crate:// from your recipe
> >   - create an empty ${BPN}-crates.inc file and make your recipe requires
> it
> >   - execute "bitbake -c update_crates your_recipe"
>
> This does not work.  This class requires Cargo.lock, but to have
> Cargo.lock, do_compile() must be executed.  This fails when required
> crates are not available yet.
>
>
> Enrico
>

A rust project must have a Cargo.lock in its source (
https://doc.rust-lang.org/cargo/faq.html#why-do-binaries-have-cargolock-in-version-control-but-not-libraries
)
unless it is a pure library but I don't see the use case of building a rust
library that wouldn't be a simple
crate on crates.io.

--000000000000fa7bee05f895d698
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, 5 Apr 2023 at 14:09, Enrico Schol=
z &lt;<a href=3D"mailto:enrico.scholz@sigma-chemnitz.de">enrico.scholz@sigm=
a-chemnitz.de</a>&gt; wrote:</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; To bootstrap a cargo base recipe which have not this checksum list, be=
low<br>
&gt; are<br>
&gt; the steps to make:<br>
&gt;=C2=A0 =C2=A0- make the recipe inherit cargo-update-recipe-crates<br>
&gt;=C2=A0 =C2=A0- remove all crate:// from your recipe<br>
&gt;=C2=A0 =C2=A0- create an empty ${BPN}-crates.inc file and make your rec=
ipe requires it<br>
&gt;=C2=A0 =C2=A0- execute &quot;bitbake -c update_crates your_recipe&quot;=
<br>
<br>
This does not work.=C2=A0 This class requires Cargo.lock, but to have<br>
Cargo.lock, do_compile() must be executed.=C2=A0 This fails when required<b=
r>
crates are not available yet.<br>
<br>
<br>
Enrico<br></blockquote><div>=C2=A0</div><div>A rust project must have a Car=
go.lock in its source (<a href=3D"https://doc.rust-lang.org/cargo/faq.html#=
why-do-binaries-have-cargolock-in-version-control-but-not-libraries">https:=
//doc.rust-lang.org/cargo/faq.html#why-do-binaries-have-cargolock-in-versio=
n-control-but-not-libraries</a>)</div><div>unless it is a pure library but =
I don&#39;t see the use case of building a rust library that wouldn&#39;t b=
e a simple</div><div>crate on <a href=3D"http://crates.io">crates.io</a>.</=
div><div><br></div></div></div>

--000000000000fa7bee05f895d698--

