Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0212CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 19:58:05 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18786.1763409482670497843
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 11:58:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MARc0yd/;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78802ac22abso45861067b3.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763409482; x=1764014282; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/wM9vztRYgl/29F/ftsAvXZAYOY6//ctjsP2+OEr6g=;
        b=MARc0yd/aZRqqoDJNi4xxxF3xN1kByd98A3UybmRsnofW/lRMx51k2C7qmwzK1eeeN
         mKXANNL/TYdrRX8N+HIYA89VJislEo38qgMUUG5BY+EdyfNSbSwOvahYsRjsqNxtDqE0
         JTwO56RNNsgVkgKLHWrKWrrbrKj2DdI08zzPQCS2GOMDaepvAy7MDtFTaIMSFBwVsWef
         4NFuxDKVUbtsDFuJRtU2NxCcxXDLl2x86z+85JSLqMMENXv2R+UT/UvkUnbKO7MkDEtY
         q1EwrNpHMk4cgDi2dFtZDyYdjgqJ+CGJ8Qr2WX78DEKTl/H0mRxojMmnSXaK22C3ofi7
         MEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763409482; x=1764014282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/wM9vztRYgl/29F/ftsAvXZAYOY6//ctjsP2+OEr6g=;
        b=XK2+CuTeed2CxEjzu01QLTi+SzFAM3LuUXPaUWhe0OuMx+B2ODDNKAmUlwwTJfVy9F
         2HFdlctkHK+fmZVWu39WAlLHvHHcOEa8Ksd7I47o3BX/0q5UqZ01v3qB6zAYe1p4pGIq
         2fuVXV5opANj+b4hsMRSKJDqaUV1TTjUf/uMKNg0h4tz6RBtkwkVGX35rwrxywzRiQHE
         aKZ4jEvrR2ibXteiZmBcWxsGhiLAHMaA4eewUtFJPdcj9ukEB3I8foLJOuJta1JHEP3t
         mG49NN544KnL7KhvBJzog6gQg/9gj6K43SPD/6MEeYQlkribqPEaM3CypTpsqnbve8T6
         wHSQ==
X-Gm-Message-State: AOJu0YzRerStk7NOwzqX3Yo9RCKztqeQbRTCtli61E+o3tQRjTZRwmI6
	V3t9pQVstw1bPLrmwkMsTZnhPxEYvYbjbe0cOeDn3bEkfiGcvhvDpmRA+WQU88ZaO9z5tpd9SwJ
	qok57qsqoN3kNgeDTcXE4DOnOnQ0NQqE=
X-Gm-Gg: ASbGnctYtrC3UXLyffuejBB6zk6wcDnkdTeARRZP6z9p7DbMHlMs8e4cG1/WWBdA+Rt
	Jttb2gL5IrbaDORFHwU4DxRZ872iQ6fr19DH7IhcdbZtwHb2El4WktVpeQ8HjVnHdhMlqOjmzai
	WTrhmnxzNB/qWsLwsCYKrTKR0ycvr4Evazn4GLDDf7k+xBP1WFC65T2Gvpu9thzg1kkyo1WOInX
	u7lD3DReXkfYgt/Idx+liZW9qSC2eOgo/N7X/e/+0qHrsVHRS865Wu6UWK+jMDrMKdjtPF+mpFb
	a6XJZ6ENXrVuEQhvY4gkji6Oe/c=
X-Google-Smtp-Source: AGHT+IEZpgY1sM4VwHRuZvfxD+u3t5IVjZMmt5mpeMmAlOLsxU2b9HuV8s1owKuVXsROuwz0m4YAbCgZ9nzaqtcPx/c=
X-Received: by 2002:a05:690e:2494:b0:641:f5bc:69a5 with SMTP id
 956f58d0204a3-641f5bc729emr6061832d50.83.1763409481693; Mon, 17 Nov 2025
 11:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20251117194840.2322115-1-JPEWhacker@gmail.com>
 <1878E35BD8113CE6.1265056@lists.openembedded.org> <CANNYZj8OMHqFdUcgWnE2_XEJKoR8=+NBVKbRf51m=rnXTGOVgg@mail.gmail.com>
In-Reply-To: <CANNYZj8OMHqFdUcgWnE2_XEJKoR8=+NBVKbRf51m=rnXTGOVgg@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 17 Nov 2025 12:57:51 -0700
X-Gm-Features: AWmQ_bl_vK-5HB7B8Sq9R6lUAYVf2jWRJmAxSKl9HWWcfMYAWfByn74inhkJYcI
Message-ID: <CAJdd5Gbkd=gHL8CMdXDoMv=ZpckQvdReB5OmOkF33K091V5mZg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 1/2] bitbake-setup: Allow setup-dir-name to
 be specified in JSON
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000bffe200643cfc3a1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 19:58:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18441

--000000000000bffe200643cfc3a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025, 12:55=E2=80=AFPM Alexander Kanavin <alex.kanavin@gmai=
l.com>
wrote:

> On Mon, 17 Nov 2025 at 20:53, Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
> wrote:
> > This (and the actual json tweaks) greatly increases the chances of
> > directory names clashing, so there should be a check for existence,
> > and a logic to deal with it (probably just fall back to the full
> > style)?
>
> Also see my proposal for a setting. There are pros and cons for either
> approach, I just would like you to read and consider it.
>

Ya this was more just to show how to do the template string per request,
not necessarily the complete solution. I probably should have sent it as an
RFC.




> Alex
>

--000000000000bffe200643cfc3a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 17, 2025, 12:55=E2=
=80=AFPM Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com">al=
ex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>On Mon, 17 Nov 2025 at 20:53, Alexander Kanavin via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">lists.openembedded.org</a> &lt;alex.kanavin=3D<a href=3D"mai=
lto:gmail.com@lists.openembedded.org" target=3D"_blank" rel=3D"noreferrer">=
gmail.com@lists.openembedded.org</a>&gt;<br>
wrote:<br>
&gt; This (and the actual json tweaks) greatly increases the chances of<br>
&gt; directory names clashing, so there should be a check for existence,<br=
>
&gt; and a logic to deal with it (probably just fall back to the full<br>
&gt; style)?<br>
<br>
Also see my proposal for a setting. There are pros and cons for either<br>
approach, I just would like you to read and consider it.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Ya this was more ju=
st to show how to do the template string per request, not necessarily the c=
omplete solution. I probably should have sent it as an RFC.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
Alex<br>
</blockquote></div></div></div>

--000000000000bffe200643cfc3a1--

