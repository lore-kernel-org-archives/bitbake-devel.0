Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36805CAC5BB
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 08:08:55 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.4184.1760083727484510354
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 01:08:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=YnLBFxTl;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-421851bcb25so772931f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760083726; x=1760688526; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5s45A6r1c05zDjZFrzRgxwITdw4K8jckeunLzK7Sl0w=;
        b=YnLBFxTlBEOpmSNxff4G3NmWg8SEphEoNKQTmot0hdKEw2uXsCCoKbBq0TYHpqIMkG
         hLIGNrS9ui3Mg1AzY4wpDWzOgRbx1tHVGOxKYVAaHS+0shtPQZGPvEs2L4/KHm7MyE/V
         dmSwbFz4G0DwY5KaDrblhvzSk1IpzIPZULsT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760083726; x=1760688526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5s45A6r1c05zDjZFrzRgxwITdw4K8jckeunLzK7Sl0w=;
        b=BASCz9XFsvttPOjQ6Bdj/gnCgJUprjNHNR29n/ADbtr+9xOVbhdSl+zwSo93YnAtoJ
         YCL4HX6KFj3tH8QsdZrEI7xEHA+JLJZyVH+V6CvlxoB6t12xk+n7cRHZawHvB5zb/XEQ
         UnqlVO5FCghgmc18NlDy613qSrYTdDBv0DLnCUEKYC7xaJVIYDmfv2muCQ0iB2AazoSk
         dE49d6VF1gfxpcd2s35nLUolShQKKRrkGt/9R1hXZFwsCEt+Xp2RgrJa4qdG28dTYaAq
         atjcn7SUe/dMrDPELvPuILZXv0VgDeYVugay6WtugzFMqXVBbRaqD5pWc+xf1zlaToVO
         kQSA==
X-Gm-Message-State: AOJu0Yy58BnaU+Dsc47bdQ2B4ujZBHCG6MS0YzO4ECIWduWZbTLJk3Yd
	JW+TjFKtwmZda9wHcispwWUOyNPjJCaFyZm4dyhL58DXVhMEwOKYxAupaAgOrtAMnzzpMT+rU7P
	HWXvFXoVdeT6UTI8vwQVdukwlSqAWjGaod9X0NtprqQ==
X-Gm-Gg: ASbGnctKD/O6n++IA8diEmwcfm7IjlP4ZGgU3WJXozWWVYySRdsDqybYlQeRltvByIL
	Z+hes3lHy04fOswK+wcCvZIqeBSJanfKhIjmFf98Vpf1KAfoIXgHzY+WLN/bJF+HeKH5+pulijm
	sENCMW8VN8IhkZswxs0Cf9vsEPFfApFEmxAySc8eshK0gXBaz3job4Hd02FX/zvWQ841FLjKsGE
	cnAGNU8I2aabSwYZ12Lgd5XA9EqVbaMTQpKIqoeOZMVW8zgXq47laUcy9k6
X-Google-Smtp-Source: AGHT+IFvqwkCzZpwT1e+XDYd1jrz40BZVkRNLKZHaJR2e3kW/MAG7WX1oNKPrIc3oQzCO4uZTkp4uPLEd+yHO//5UKE=
X-Received: by 2002:a05:6000:2910:b0:3ee:109a:3a83 with SMTP id
 ffacd0b85a97d-4266e8d8e78mr6366116f8f.29.1760083725789; Fri, 10 Oct 2025
 01:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251009223552.2648331-1-yoann.congal@smile.fr> <CANNYZj9JJ+tP68X9pLyie5a1xh7+3VMUui142eV50Rc_doR81Q@mail.gmail.com>
In-Reply-To: <CANNYZj9JJ+tP68X9pLyie5a1xh7+3VMUui142eV50Rc_doR81Q@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Fri, 10 Oct 2025 10:08:19 +0200
X-Gm-Features: AS18NWBOYFOdSWEd1pxZhIJ6CADW-t3BxrmlTmZETHR2oXLJNKGEBePRKlINk7U
Message-ID: <CAMSfU+4twDb_wpQfqoxVbzP8u_B7HqTo68TMzyQ5RLhsv9MJJA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] ast: Warn on multiple builtin config
 fragments for the same variable
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004043050640c96d5f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 08:08:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18164

--0000000000004043050640c96d5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 10 oct. 2025 =C3=A0 08:40, Alexander Kanavin <alex.kanavin@gmail.co=
m> a
=C3=A9crit :

> On Fri, 10 Oct 2025 at 00:36, Yoann Congal via lists.openembedded.org
> <yoann.congal=3Dsmile.fr@lists.openembedded.org> wrote:
> > +            if len(builtin_fragments_list) > 1:
> > +                bb.warn(
> > +                    ("%s has multiple builtin fragments for %s: %s. "
> > +                     "This is not supported but build will continue
> using the last value.")
>
> I think the message should be:
>
> "Multiple builtin fragments are enabled for %s via variable %s: %s. "
> "This likely points to a mis-configuration in the metadata, as only
> one of them should be set. The build will use the last value."
>

v2 sent. Thanks!


> Alex
>


--=20
Yoann Congal
Smile ECS

--0000000000004043050640c96d5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0ven. 10=
 oct. 2025 =C3=A0=C2=A008:40, Alexander Kanavin &lt;<a href=3D"mailto:alex.=
kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 10 Oct 2025 a=
t 00:36, Yoann Congal via <a href=3D"http://lists.openembedded.org" rel=3D"=
noreferrer" target=3D"_blank">lists.openembedded.org</a><br>
&lt;yoann.congal=3D<a href=3D"mailto:smile.fr@lists.openembedded.org" targe=
t=3D"_blank">smile.fr@lists.openembedded.org</a>&gt; wrote:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(builtin_fragments_li=
st) &gt; 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (&quot;%s has multiple builtin fragments for %s: %s. &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;This is not supported but build will continue using the last v=
alue.&quot;)<br>
<br>
I think the message should be:<br>
<br>
&quot;Multiple builtin fragments are enabled for %s via variable %s: %s. &q=
uot;<br>
&quot;This likely points to a mis-configuration in the metadata, as only<br=
>
one of them should be set. The build will use the last value.&quot;<br></bl=
ockquote><div><br></div><div>v2 sent. Thanks!</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
Alex<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000004043050640c96d5f--

