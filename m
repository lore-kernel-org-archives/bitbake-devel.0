Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0053BCCFA13
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 17:44:57 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15715.1762364695646484887
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 09:44:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=RCVlEDQA;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-421851bca51so84148f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 09:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1762364694; x=1762969494; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AgHfKntNlLThV9CqOLGSKA6GyQAIjwTllB+La4U/xhE=;
        b=RCVlEDQAPuXCcDVw/C+99RnnaRKiXe5v4IwTyGKP0PQtD5twim5Sm56P0O1wBpZqqh
         aKbxt3XMfd5as8Gid85t4AM/tmJGDZswhUglL+ME0WJK7VxdFZPQFw0XsmT7BD+epwQN
         vmSk4FzapbM7bOAYIRW9/JfKvSYDwKq1D86Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762364694; x=1762969494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgHfKntNlLThV9CqOLGSKA6GyQAIjwTllB+La4U/xhE=;
        b=dPH7I597VFSNKe6VwQG6o0VozUnOwqs838VHFgJ8qZYsNrw25UrQwaMMTzOGDmK3qJ
         C4KFoJPBRqhLnWQR24RknHGwBYyaKM641sBczDCffokpxVRB7iy6uxslRv9LTluOZQHe
         JE/o3M/hXe9naLC63ENJizJQyMwgwXuCMP5yXKeQxtfKjy9JZhljANbE1GtJFSRZR8qA
         Q61qwiMu22KAUuGLFaBmCtGqF4NPp1xhtHrKvi2IkDNj8EPJaMgx6uczgtf4dV4bmOly
         ZCMkULRW5e7JtJbX7TRi5aqkbiaMxU2FuuMspgjZlpPwFYsaNjcOP90K0uBjvg5ACudG
         pfqw==
X-Forwarded-Encrypted: i=1; AJvYcCU10wphlFs/tt0BDMTfBvSBWnYT3gkYc7atSg6EGygXuJIGMiyZBZHLlpkwsgEb/LUYJZI+Io7iHJc/DEWa@lists.openembedded.org
X-Gm-Message-State: AOJu0YympR1HJf2L59e2OLXbgAT05Fk0H7rXwCGFb2M/hNbR4mCD6zxi
	kzZP77iuJFqE8gfMgnsgYuD+Ne5ROi3R/bEhtUb8FyEBlVgZKJZpQK6SyakPC+Gn51sm2WjuMuD
	3SE6mlrqY4OlvkUpVop3OuC5queYXwDEgjFJldCOZyA==
X-Gm-Gg: ASbGnct22c7HUxCwhPRooAtJCQVqX0cuhUuJQpG8i2YGAWiNoq7BVejL0Of+K7N2VOL
	I1elaj8adFP09KWfTEEj4cWmNEkYg99efGNWKyaKtzmG5xAWDhRFH2V9Mu8mAvFFZbCN7NIG0jW
	DNlNBI72PUgE8C5DMvlQVf9cwZ9fW5MA0KnpYe8Fq0hCLHqFMX6dU2P8hIK4+q/OE78tnR0CzUH
	So4NC2MZF9/C4x/wXpndmMMMx6p/uuqzEQnG65FDW983o8/8TVkycAyhQKWbsBsBmDq+6Yn39Im
	EYqy07aZKGJe/Qhtsiw=
X-Google-Smtp-Source: AGHT+IHWH9amKacgvPB2cJo1hdvNVHIAdzyIUPR0mL8d1VVjVziCBeBRQ4nmbRUiS3eGD0PZZ9Cveuzc7RGwMiDaat4=
X-Received: by 2002:a05:6000:2482:b0:429:cacf:107e with SMTP id
 ffacd0b85a97d-429e32e48camr3628303f8f.19.1762364693963; Wed, 05 Nov 2025
 09:44:53 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj8p5zTnzo3AO88_c7Q=qDtO1-QWaFNh+z37xLX4Y1H8Bw@mail.gmail.com>
 <20251104151156.3125937-1-johannes.schneider@leica-geosystems.com>
 <DE0USKLW9WXP.3MKV2P4AI36E1@bootlin.com> <CANNYZj_bTNkWmDLe=wmDOXfL1xWxSTx6yP2yqAbjLVaomXoVaQ@mail.gmail.com>
In-Reply-To: <CANNYZj_bTNkWmDLe=wmDOXfL1xWxSTx6yP2yqAbjLVaomXoVaQ@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Wed, 5 Nov 2025 18:44:27 +0100
X-Gm-Features: AWmQ_bmkmGKF8_ueaps5-QqM31CuBWDKuuAah3eSEdP0i_m9IYhqO5kVTSHkN84
Message-ID: <CAMSfU+5SOfNvM-ynzLRzthh-7=mAyFs4aAYrTM9+=e94ahrsQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add bitbake-setup documentation
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Antonin Godard <antonin.godard@bootlin.com>, 
	Johannes Schneider <johannes.schneider@leica-geosystems.com>, 
	bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	thomas.petazzoni@bootlin.com
Content-Type: multipart/alternative; boundary="0000000000008c788a0642dc81fb"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 17:44:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18268

--0000000000008c788a0642dc81fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 5 nov. 2025 =C3=A0 16:20, Alexander Kanavin <alex.kanavin@gmail.com=
> a
=C3=A9crit :

> On Wed, 5 Nov 2025 at 16:07, Antonin Godard <antonin.godard@bootlin.com>
> wrote:
>
> > Thanks Alex and Johannes for the suggestions and corrections. A v2
> should be out
> > soon!
>
> Before I forget, THISDIR in bb-layers should be also documented:
>
> https://git.openembedded.org/bitbake/commit/?id=3Db3153be29de8b8570b0c184=
369bd41f4c646cf92
>
> Sadly it isn't part of the formal schema definition, in hindsight it
> probably should have.
>

I can do that:
* documenting "{THISDIR}/..."
* Integrating "{THISDIR}" into the formal schema definition


>
> Alex
>


--=20
Yoann Congal
Smile ECS

--0000000000008c788a0642dc81fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mer. 5 =
nov. 2025 =C3=A0=C2=A016:20, Alexander Kanavin &lt;<a href=3D"mailto:alex.k=
anavin@gmail.com">alex.kanavin@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 5 Nov 2025 at =
16:07, Antonin Godard &lt;<a href=3D"mailto:antonin.godard@bootlin.com" tar=
get=3D"_blank">antonin.godard@bootlin.com</a>&gt; wrote:<br>
<br>
&gt; Thanks Alex and Johannes for the suggestions and corrections. A v2 sho=
uld be out<br>
&gt; soon!<br>
<br>
Before I forget, THISDIR in bb-layers should be also documented:<br>
<a href=3D"https://git.openembedded.org/bitbake/commit/?id=3Db3153be29de8b8=
570b0c184369bd41f4c646cf92" rel=3D"noreferrer" target=3D"_blank">https://gi=
t.openembedded.org/bitbake/commit/?id=3Db3153be29de8b8570b0c184369bd41f4c64=
6cf92</a><br>
<br>
Sadly it isn&#39;t part of the formal schema definition, in hindsight it<br=
>
probably should have.<br></blockquote><div><br></div><div>I can do that:</d=
iv><div>* documenting &quot;{THISDIR}/...&quot;</div><div>* Integrating &qu=
ot;{THISDIR}&quot; into the formal schema definition</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000008c788a0642dc81fb--

