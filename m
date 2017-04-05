Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
	[209.85.218.47])
	by mail.openembedded.org (Postfix) with ESMTP id EBF5271DAE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Apr 2017 17:04:36 +0000 (UTC)
Received: by mail-oi0-f47.google.com with SMTP id b187so22946481oif.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Apr 2017 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=g67ii/22lKcrxf7zzTUqpgkXAciVWkjFn8HGNu+eeGA=;
	b=uyKg/EgN+JhY+dh6xFNb2LHGyNbi2dYXXuO5pR3praFDeqpThU8DVul7vDJGKmzjZN
	8rF9vwmMbUfHZm9x5HN2H9uvx9cbTWBoMnODOaj0X5Kb5np/63K1uK4MaUEnSuuwbJlQ
	h7sR1kxk8JpYVMls6qhQ5Az+CGm4W3W1OYgfWZQOb6gxH9ogeM8/vAkHhE9SO4//dIc2
	EvahFlJyjAvg36BQzvjqwOqanHyiDxZGrCjtuLfXPxLLZMZdOKzhV7Kxxe1JCbsDuLMu
	aQAvqdJluUMMwipe2G2UIPW6m0WEuGeqozcJg15BJtHDI9Qd18aYMzW7iHLUK4Tm2vgb
	JqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=g67ii/22lKcrxf7zzTUqpgkXAciVWkjFn8HGNu+eeGA=;
	b=TfxgmX0GU/HogHd31qPH/Xbwp4sMwU+AxtisAsrIP4U9vuWyni9Gg8z9hb+Y9wnl+H
	FSVxtE/mMpjqwiDaTtJZtQoKXHhDdzcZyMpKhPRyiNxsFaQCeHPrVfDYyj58wRP45Ixu
	U5dHJkuf63F0VjD1SifoHFwAn5fKnyrSV+LV4KCAubKYwbQdKXUVINUbAC6j6PQnJ6SB
	PC/079GccCMcd6atepKUYa56NGrX1gV0sCHr9msZuYAnAQqj6Rugc6MOOQ5sA2zbN5wk
	htoVTZ2BQUTjJmXQzFCgu+wgAOKGBiM0GOfT3RmXg5tN9lqntGqKAQK6NP68Ex0juD3D
	d2Hw==
X-Gm-Message-State: AFeK/H1YFnp+7ocKe32JbtIRUCHCBVYiMoDpEnckVgVb1uJ8n8JZO+H9o3+Tn2KLuuYQDE1FQldU+2SsLvrrGQ==
X-Received: by 10.157.25.35 with SMTP id j35mr13127260ota.248.1491411877909;
	Wed, 05 Apr 2017 10:04:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.33.197 with HTTP; Wed, 5 Apr 2017 10:04:17 -0700 (PDT)
In-Reply-To: <1491381542-15132-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1491381542-15132-1-git-send-email-richard.purdie@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 5 Apr 2017 10:04:17 -0700
Message-ID: <CABcZANkkv_Y1Ym-tserv7Ctj3T7CBQWUPhEbzgOm85g2SXKjHw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/local: Drop FILESDIR
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 05 Apr 2017 17:04:37 -0000
Content-Type: multipart/alternative; boundary=f4030435a68c325bbf054c6e6368

--f4030435a68c325bbf054c6e6368
Content-Type: text/plain; charset=UTF-8

On Wed, Apr 5, 2017 at 1:39 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> This has long since been deprecated and is no longer used anywhere,
> FILESPATH
> is the commonly used varaible which offers much more flexibility. Remove
> the FILESDIR code and references from bitbake.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Good riddance :)
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--f4030435a68c325bbf054c6e6368
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Apr 5, 2017 at 1:39 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div id=3D":1i1" class=3D"a3s aXjCH m15b3d5e4e9c0c61a">This has long=
 since been deprecated and is no longer used anywhere, FILESPATH<br>
is the commonly used varaible which offers much more flexibility. Remove<br=
>
the FILESDIR code and references from <span class=3D"il">bitbake</span>.<br=
>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@<wbr>linuxfoundation.org</a>&gt;</div></blockqu=
ote></div><br>Good riddance :)<br>-- <br><div class=3D"gmail_signature" dat=
a-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Chri=
stopher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedd=
ed, OpenZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></di=
v></div>
</div></div>

--f4030435a68c325bbf054c6e6368--
