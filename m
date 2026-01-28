Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4810D46BEC
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 18:26:53 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1679.1769624810738177185
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 10:26:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=m0xUMY8q;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.181, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79430ef54c3so1276397b3.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 10:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769624810; cv=none;
        d=google.com; s=arc-20240605;
        b=A4cXLg9R46EnBMP4vWMtMzyJW2UkvMc6r0ilz1OK7J5TuKR5D1soA+nZKor4/ySO2n
         ufc3r95VaEg4Vi0k6f85vBlN+fXSxeO1mSUsRSs7gUalGrqOZlJY8btWX7Nj7dS29oSq
         Um31aPe4yqhphkPxkCd+HWZSPhch6hcIbgHE0kXuJ42t51Vk7e7GDfFghEHVgK1pe1BH
         sTjWcVu66RyBcsPT0DLDo5K96/MA1OtFhlfwzis07IezjpIcC8jzZgZCINjbbTdFe1Mc
         Ku0oIBktsi/X8ALTZj/pflg2zhAbusQbPBc+uNEibeYaoaNPBejrOjyucfPdFWlAwUQb
         PBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jopfUoDACct7WTHTbkxqcbRcUwv1dTAwI9ut9RdKock=;
        fh=mTvk0ClZ29uesmJabIEbRmIpV977vTZfZOCj00+Avuo=;
        b=Caj//m0NFDaNbbERTmYLhun9DPzHLFssSqAxyquosU2mvlNL8F/84gX1ESRhGh/rsD
         yY2WbFxtB8IS3qBiRJxgfLcJxZ/fI4KKlcRjl5K1xHOJqZYMqRnVOItxcJMQcdDLbLao
         cpEa9Amd0e01NgqHx0XsBe8lOGr1IY8OyiK34JsUBoRpL7JdM8psYKnoSZibOzMlQobJ
         oeNGJ/phiqWCNq1rySxcL6cxKxeIECskpiq8QhdzQNL0TfxR8maXEk27+sYPzr4XccWA
         Pbn3WFxUWCcvvTXbOIOyoEiqeVZIVNHrkigsfXmjUteaBta2N/rZFAHdwrT706t0Zv10
         OPFA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1769624810; x=1770229610; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jopfUoDACct7WTHTbkxqcbRcUwv1dTAwI9ut9RdKock=;
        b=m0xUMY8qJCZoZby8i5rxWUL9StcT1YIkcS55dVYqWXc/d2Z7a26T7UsB70BVxDKak/
         54OMwy7hYs9gVtSuHVv5Vw2LYwypOX94ZrvzC3KDsTmahWj1dVZ4hDI4qSW0XEBllCAB
         2p7uDYnRNTXfiEYC7PIYIARvwJKJgZRyOmmSgGinWIuRfuUhBIfDQfB2r7ITfIHGk+Ox
         laS/LnJP8LwUyhj7yWb2j2b7WsMv8uEJKOIYgEqnbV72YRIMkcY0MB/Q662uH66LAPoi
         vg2HHp0z+BYIukfFwrtkYa1ISUMvK43HcHUpxWPT8COvBRZcqC+rjt4akVDsK5a9XNa0
         ChJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769624810; x=1770229610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jopfUoDACct7WTHTbkxqcbRcUwv1dTAwI9ut9RdKock=;
        b=vKN8WHQKc6xZ+oCRPTHUmSLvNUYas3gRo9V2U0IYlokmMmLA70Jm8tHEkF2sNTSvhr
         46aepg5mcDwdTzRIg9P3DH/L7fhNRYMQq21SkGh+93VkxwhMZLnNjiMZmu3Mt7SBOeBI
         AYBHV66h9cPBYae+P4b90rdsdPyiZs/wn4qXuxcFkLArTie66h4BpxD/1d/d5Tw2xKug
         090C9v5jsXd3+R5zdmDo5hYUZBXeWkcIblxC1JbpFohZIhqBEy7QC+QNwMYSNga4SP+r
         gSbihU/R3sDqflDVP3gmV76SZSIIhw32jb9remZNSNprZwW++QEdgYcbYp/tQKNV9nwr
         09bQ==
X-Gm-Message-State: AOJu0Ywdq4NFwBhO0sDvRlwLk2cRp5artqNhGhIwdLWQmy+PxT+hrUC0
	CZgLgf0qSqJGj3gCaIxC5Sh8nVly8M3nUm9AozfnJBT7y7X54GNSxhZteCiA40humZqpCWZHtrZ
	pSXi/yHzIMg/qdMBou6ZQwI50qb75PP1anoNNTfTDVw==
X-Gm-Gg: AZuq6aJEvk94mlv+gYEmCxwRFgQwMmYXzLLa3oj8q4lBCPP4pSAvP/UZTLnye1b1M++
	4kCa3KlT2c9M75uKdYvB9kgA8nyKd4q/dpMY9GI2lSq6fHekThFRgRL7qkBNCDBzsUgRquT6eQy
	gdil1oCxDCWXx6TLeQqeAfADdBNwi3IgVdqd10ipSU+bq64zt/RkYgLO7sS06Y+zjOvmTSORx93
	+JTw7VGBODz21ELlbjpdsiOnrp73sqtPya/8Q0vTWlS8E72IH7XDbLdU8f19Q8w3SGz5SpmmvQz
	Lxuf6kBacDRCgTsdYMQkOYwsZg4G9kqhY6115nJxJDCVnl3ixZGM0BuT3Q==
X-Received: by 2002:a05:690c:c513:b0:794:93e:d0f8 with SMTP id
 00721157ae682-7947a9ecb0bmr47838717b3.7.1769624809848; Wed, 28 Jan 2026
 10:26:49 -0800 (PST)
MIME-Version: 1.0
References: <20260128143336.1963432-1-anibal@limonsoftware.com> <CANNYZj9xAuhZK2+BfPdTJjmCoZBZ_1srxFUUrFRPi5d7zYi_GA@mail.gmail.com>
In-Reply-To: <CANNYZj9xAuhZK2+BfPdTJjmCoZBZ_1srxFUUrFRPi5d7zYi_GA@mail.gmail.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 28 Jan 2026 12:26:39 -0600
X-Gm-Features: AZwV_QiRi1JZ_6OzaCEDpDs9dOVmozCSdMbHn7FXyyvuTSTBHXY08eakYcmHvEA
Message-ID: <CAOU5ZMtxf68nirg+9znM=LskB=YCzGMz=To9TkGLs0ERRpjz+Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: _has_local_modifications
 fix layer add on existing project
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, alex@linutronix.de, 
	jonas@limonsoftware.com
Content-Type: multipart/alternative; boundary="0000000000002d4fa5064976e23f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 18:26:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18921

--0000000000002d4fa5064976e23f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 8:49=E2=80=AFAM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:

> On Wed, 28 Jan 2026 at 15:33, Anibal Limon via lists.openembedded.org
> <anibal=3Dlimonsoftware.com@lists.openembedded.org> wrote:
> > +
> > +        if not r_name in fixed_revisions['sources']:
> > +            return False
>
> I'm not sure False is a correct value to return? My understanding is
> that the scenario you have hit is as follows:
>
> - manually clone meta-freescale into layers/
> - add meta-freescale to a configuration
> - run bitbake-setup update


> At this point bitbake-setup sees that meta-freescale already exists,
> and it needs to decide whether to preserve it or not. As there is no
> record in fixed revisions of what the original revision was, should it
> default to preserving, so that any possible user modifications are
> saved?
>

Yes, so returning True and may be a different message to the user?.

Anibal


>
> Alex
>

--0000000000002d4fa5064976e23f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 28,=
 2026 at 8:49=E2=80=AFAM Alexander Kanavin &lt;<a href=3D"mailto:alex.kanav=
in@gmail.com">alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Wed, 28 Jan 2026 at 15:33, Anibal Li=
mon via <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=
=3D"_blank">lists.openembedded.org</a><br>
&lt;anibal=3D<a href=3D"mailto:limonsoftware.com@lists.openembedded.org" ta=
rget=3D"_blank">limonsoftware.com@lists.openembedded.org</a>&gt; wrote:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not r_name in fixed_revisions[&#39;sou=
rces&#39;]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
<br>
I&#39;m not sure False is a correct value to return? My understanding is<br=
>
that the scenario you have hit is as follows:<br>
<br>
- manually clone meta-freescale into layers/<br>
- add meta-freescale to a configuration<br>
- run bitbake-setup update</blockquote><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
At this point bitbake-setup sees that meta-freescale already exists,<br>
and it needs to decide whether to preserve it or not. As there is no<br>
record in fixed revisions of what the original revision was, should it<br>
default to preserving, so that any possible user modifications are<br>
saved?<br></blockquote><div><br></div><div>Yes, so returning True and may b=
e a different=C2=A0message to the user?.</div><div><br></div><div>Anibal</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div></div>

--0000000000002d4fa5064976e23f--

