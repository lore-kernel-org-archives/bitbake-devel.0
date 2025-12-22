Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2629EE677ED
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:20:03 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83383.1766420396703722918
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 08:19:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=pEhTyKeh;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.172, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78c6a53187dso32462967b3.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1766420396; x=1767025196; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+SH9HaPYvEWestgUIGwQYvPXdT6e5U9p6pMq4q/Gkg=;
        b=pEhTyKehvq2MVEw8NbMmhTery/brUV4J8m5F0HaE/4UrYfSHa40PKHQ3JTaZ7LTQBd
         zNhduFSzzV5KPxiTDz2JKNDtpw+oefQgo7Qg5T+ZKhcuTGyrViqggQD0OK9nFMiu/G80
         QJk6oJqLOpacCRSNuHAxpixQzQ0DOsWbMbHW9HpdHYiib6wrdKtzjudqhnlZ+nN7PDlz
         PWxixvDDnvEahHhdcRF58TFOgautmP5cNEFwcNcHsuqwO1KZbnAvuyZnx15kTlGnzlXO
         VHvVM8VWWTDfLCaXXkkqVd90jjzM8lbOFqA2jgFO0aNZRSNubwSsGgNAwDjNQx/tVLeE
         ifbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766420396; x=1767025196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+SH9HaPYvEWestgUIGwQYvPXdT6e5U9p6pMq4q/Gkg=;
        b=DQ3cr+Z2dAYi9xMTpKmaxMslZh8vWY6iDoCxo25lMXvuCa9xrSoS4VTW7K2PAoqbm8
         9HZtK2ViOXQ4FboWGwbSPgipiYUfGIqO6nDKITY+tct2SzSyrBxLlY8jSNE5lbOdylO9
         f2iyLbHmHvZlcAWY0DyhAiQaLrZXef4Yn51H2phk6Q7UNXBWunxS9e+3kreJBuXodKwv
         LCuMPExPysNDpuA5OewkqsGgIcjOYm9gmhXz3GvQQoddluh5h3Iv5M+9LbuXfwG6I+Ne
         6/i55UMeEtSUdQEitMWMjgLDuNnn5BAY9CJ3TgVlNPpw+b3AXeCuTaVAv8TWWzddA+h2
         Xb9g==
X-Gm-Message-State: AOJu0YzLyVIxzbpP/aCXuEV8RKI5UMwkZfMaMwgcaE1VwEiJCAVr8iVQ
	fXaXrVUOGw9gI39u2HwbXhe9Y9ZFE1YFVyNhCbkbL9hmJUdaYbzTXwN2TdkkvHZ5wfh1s3+BnRP
	dJPnHEGmy0NJYcPIS1Blv4dWXzoiR/pts6WrA2IPb9g==
X-Gm-Gg: AY/fxX6dxAiQGsC5QcgXdSL+8RIGQAACnOZXp5TWkWzxdn2TDlCBlx8WlPGZc4cpaDJ
	KRaE/NlDehdrfN7fNkPuP0e11eZUIHEQBNWkdrExPpfdeu+iMZ3rj/eSaIv5g0jVnpH6Eb8ZP7M
	gwfI0XzIJChcg0PSgjIJixelLvIX8bjS1PwEv4PRrPJJiRGE8xqThCR14rsQMWt+Xk+WEJmjP1P
	qqakj2UQMPFXCLnpQjrVqUSV4O4CNC00axonx3RLCowUo8eurxqbjYNMMbsq0wBHJp6L13F2U7g
	2NdU53doED+alxIwDE10tXRVtqcmChtCYfqBlm30eIxv1cn4YvP4Xj/bGw==
X-Google-Smtp-Source: AGHT+IHZTiLeLGUg+0b95EC7+N1VZdviSsPnjxygF1ssbNKluJP9YKEja6pKP/cbAYw9o2VsUoOEiQgTR4jdG9iaFCg=
X-Received: by 2002:a05:690c:61ca:b0:787:e015:8538 with SMTP id
 00721157ae682-78fb3f0c43fmr95781407b3.18.1766420395805; Mon, 22 Dec 2025
 08:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20251221004750.35128-1-anibal@limonsoftware.com> <CANNYZj9iWkw6xJ1EpA8mRGV8=6kBJ1vYtLXcfsjy2xBVaYGj_Q@mail.gmail.com>
In-Reply-To: <CANNYZj9iWkw6xJ1EpA8mRGV8=6kBJ1vYtLXcfsjy2xBVaYGj_Q@mail.gmail.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Mon, 22 Dec 2025 10:19:44 -0600
X-Gm-Features: AQt7F2p4FANcgSCpn-BKfY2y_PbhxGyhDWxwd8qDucqZ9O0lpd6EJdUmYiffsg4
Message-ID: <CAOU5ZMvS578YZfpV1nDjjLmsTVa04+gxp2-4-6JQNWR0Ms6LPA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH][RFC] bitbake-setup: local sources add oe.path.expendvars
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, antonin.godard@bootlin.com, 
	richard.purdie@linuxfoundation.org
Content-Type: multipart/alternative; boundary="0000000000003759ed06468ccccb"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 16:20:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18639

--0000000000003759ed06468ccccb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for pointing out the -L option; it covers my use-case.

Anibal

On Mon, Dec 22, 2025 at 5:36=E2=80=AFAM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:

> On Sun, 21 Dec 2025 at 01:48, Anibal Limon via lists.openembedded.org
> <anibal=3Dlimonsoftware.com@lists.openembedded.org> wrote:
> > -            _symlink_local(os.path.expanduser(r_local["path"]),
> os.path.join(layerdir,repodir))
> > +
> _symlink_local(os.path.expandvars(os.path.expanduser(r_local["path"])),
> os.path.join(layerdir,repodir))
>
> What happens if the variable isn't set? This may introduce a usability
> problem when users forget to set the needed variable, or are oblivious
> to needing to set it, and get cryptic path-related fails.
>
> I'd rather use a -L command line switch to override the default value,
> and, if needed, place the environment variable into that:
>
> bitbake-setup init -L openembedded-core $SOME_CUSTOM_PATH/openembedded-co=
re
>
> Alex
>

--0000000000003759ed06468ccccb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Alex,</div><div><br></div><div>Thanks for pointing=
 out the -L option; it covers my use-case.</div><div><br></div><div>Anibal<=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Mon, Dec 22, 2025 at 5:36=E2=80=AFAM Alexande=
r Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Sun, 21 Dec 2025 at 01:48, Anibal Limon via <a href=3D"http://lists.o=
penembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.or=
g</a><br>
&lt;anibal=3D<a href=3D"mailto:limonsoftware.com@lists.openembedded.org" ta=
rget=3D"_blank">limonsoftware.com@lists.openembedded.org</a>&gt; wrote:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _symlink_local(os.path.expa=
nduser(r_local[&quot;path&quot;]), os.path.join(layerdir,repodir))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _symlink_local(os.path.expa=
ndvars(os.path.expanduser(r_local[&quot;path&quot;])), os.path.join(layerdi=
r,repodir))<br>
<br>
What happens if the variable isn&#39;t set? This may introduce a usability<=
br>
problem when users forget to set the needed variable, or are oblivious<br>
to needing to set it, and get cryptic path-related fails.<br>
<br>
I&#39;d rather use a -L command line switch to override the default value,<=
br>
and, if needed, place the environment variable into that:<br>
<br>
bitbake-setup init -L openembedded-core $SOME_CUSTOM_PATH/openembedded-core=
<br>
<br>
Alex<br>
</blockquote></div>

--0000000000003759ed06468ccccb--

