Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC220C87FC9
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 14:59:42 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.9683.1753801173742810564
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Jul 2025 07:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d9ZNRWNZ;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso59370191fa.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753801172; x=1754405972; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8sMOa47VctfZ8NTYG4ecKN1D1jvwd63d+uJZDpU/1c8=;
        b=d9ZNRWNZwzewNQKLHFildCiTnSuhaULXUohuQdVNM4aPTLQ2q9jzw9BR32+T6EDCas
         cjt5ygZe6TMK1DTzmNsrgTe/FNA7aTjTfqB8PuSrIWeUJxTNvjVxQ/ABxVBzYywyXBxT
         Zj769JL6BPYYyruw6E3crOiclyai1ZydvJrtsxGHByTw9Y+UHaJgnnGWfeHcLs87oSaR
         lCxVQId8MUN9DQOI7Z6wsxGCWlQTkJOv3LuoE4HkqMJBy75OCxq7BrkqcfaSSgWiQz1N
         2Qvk4X+OUsquo8KlVU6sftGK9erD3od1HqBPVK7KlbpulJlkFYwxoUTROUKreH2646AK
         d7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801172; x=1754405972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sMOa47VctfZ8NTYG4ecKN1D1jvwd63d+uJZDpU/1c8=;
        b=uBNsnQYFXcDx1Jl2zl5yko5SkHr0iDggZXvPwtTCXVENT8cqm7MBp4n0g3J0Ac5eEd
         AYQdzjQUTG6+9ihWLYTenzS5SUP+whXTHvfszvGZCaoVBj6MGbDuP03E49dL5SyO+mlq
         O9eDS6Br8lE45Mm1O9Wcvso3NX4AbmNHGKme6i3c6DCxabf6bPXqbeYk9BtG2Vy4dpbn
         vLiEYHwRPlHmFeyXMolSE33aM2RN8BBSXwSTjt2p1oEJxmzFNEM2A/rNrMRiWHW/Nh/E
         Vd6mOgVVfv1l1SBUk4JWzMqrQvBmYU+dK2LHPS5OkzZTUABX7bTRoOxz2D6/sZ0qgO2c
         zzWQ==
X-Gm-Message-State: AOJu0YzXpNQ/XcUI3kQMOWMV4lsvG+3t0mlLlczYiVuTa8XdOpzqjmXy
	dI+jViRnZLP4sWh9E5QKtyhsf75WxAU3yKzJmKS7EmJONnnuXjNtpu51DXdnlFq3h3jMIOpQ4kk
	04briZa6t2C/WMqPeMsPdAqqOOPrV6Ws+7Q==
X-Gm-Gg: ASbGnct+Z/h0qOlMUv8t7OjIQ6APgAW5p1X2y3ZYGVIYmAVhIzrQauhXGwVzunK5kuW
	a8aqLv7tWzPnzvWEt4MJh6cO7TLTwF+JgySa13BUyWFFghaeR+bq1Nsns/jSf9QJJGGN1A2JLBf
	DnMYhXwv8Lc3PuwBQ5mhUWq1bIiF7ySrYsmxQmgSG7mEx8rWtcx6ATuEYivYTSobGXmC2hwXakj
	NPfPjNuCBb5vVyKdectyg==
X-Google-Smtp-Source: AGHT+IGJrc9G7jQnSES8G/0tHfZ1rD8JCb/ahiX4wPlkWc9AjSe83qyIo7jVAnAVOdDnDAyx8JTJmpP8Itbaugmvw7U=
X-Received: by 2002:a2e:beaa:0:b0:32b:57e3:971a with SMTP id
 38308e7fff4ca-331ee7b6206mr49970051fa.35.1753801171400; Tue, 29 Jul 2025
 07:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144906.1665908-1-JPEWhacker@gmail.com> <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
In-Reply-To: <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 29 Jul 2025 08:59:19 -0600
X-Gm-Features: Ac12FXzyvpuC4iNaZ8NEnZegZsD4awmwNJ61Qzf18ALh0O789IWQe0nG0BPUNoE
Message-ID: <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d3fcc4063b12a725"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Jul 2025 14:59:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17821

--000000000000d3fcc4063b12a725
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 8:57=E2=80=AFAM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:

> On Tue, 29 Jul 2025 at 16:49, Joshua Watt via lists.openembedded.org
> <JPEWhacker=3Dgmail.com@lists.openembedded.org> wrote:
> > Our setup is that we have a "disto" layer that we need to maintain
> > against several version of Yocto at once. In this disto layer, we make
> > policy choices that sometimes are tied to a specific version of a recip=
e
> > found in a specific version of Yocto using a bbappend; and often that
> > version is only in one or two Yocto versions, which means that the
> > bbappend will be dangling in the others.
>
> This is where the weak point of the argument is. Yocto does not make
> concessions to layers that attempt to be compatible across yocto
> releases, patches that help such layers had been previously rejected,
> and this would create a precedent to the contrary.
>
> It's always possible to make a branch.
>

Branching isn't an option for us; we are unwilling to add the maintenance
overhead of dealing with that.


>
> Alex
>

--000000000000d3fcc4063b12a725
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 29,=
 2025 at 8:57=E2=80=AFAM Alexander Kanavin &lt;<a href=3D"mailto:alex.kanav=
in@gmail.com">alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, 29 Jul 2025 at 16:49, Joshua Wa=
tt via <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=
=3D"_blank">lists.openembedded.org</a><br>
&lt;JPEWhacker=3D<a href=3D"mailto:gmail.com@lists.openembedded.org" target=
=3D"_blank">gmail.com@lists.openembedded.org</a>&gt; wrote:<br>
&gt; Our setup is that we have a &quot;disto&quot; layer that we need to ma=
intain<br>
&gt; against several version of Yocto at once. In this disto layer, we make=
<br>
&gt; policy choices that sometimes are tied to a specific version of a reci=
pe<br>
&gt; found in a specific version of Yocto using a bbappend; and often that<=
br>
&gt; version is only in one or two Yocto versions, which means that the<br>
&gt; bbappend will be dangling in the others.<br>
<br>
This is where the weak point of the argument is. Yocto does not make<br>
concessions to layers that attempt to be compatible across yocto<br>
releases, patches that help such layers had been previously rejected,<br>
and this would create a precedent to the contrary.<br>
<br>
It&#39;s always possible to make a branch.<br></blockquote><div><br></div><=
div>Branching isn&#39;t an option for us; we are unwilling to add the maint=
enance overhead of dealing with that.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div></div>

--000000000000d3fcc4063b12a725--

