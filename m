Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A6C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:03:17 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web10.21473.1702558997198575230
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 05:03:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iLyLEzS2;
 spf=pass (domain: gmail.com, ip: 209.85.167.176, mailfrom: quaresma.jose@gmail.com)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b9e2d50e61so5673303b6e.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 05:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702558996; x=1703163796; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dAN8XPDwtAvNtdTZt63HA1+ejvjdfH8mXaXIkERLY40=;
        b=iLyLEzS2mb5ggjxXWrc43Wo7BElZU0GN72SWiEijtX7l81PpZfL/GdQlLVu+yqsISW
         oOjfTxZHmQgDPwgDQZ4libKHBg0TX1H0PPlBWRoi+ztDhrI2aBwTa/Eb4tvLy24xsI3J
         eJrxVXVqskC+f0SjTrpZRQntAN+J3qSoY+TU9oz8Nq0Ren3sca3zDpnapegUtbXVsegn
         7Si4ZYIyLUiVZ2z6d2Pj3zPiP0zq3I//7yPFBZ44bYmFkepvjp45coSEdlxcBRFpSEra
         nFOqPimROxMESkcKN3ZQ1WC/0M5et91EBiXc7724KZbrKDaXa4+kgswVa53HHII6nWQU
         0a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558996; x=1703163796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAN8XPDwtAvNtdTZt63HA1+ejvjdfH8mXaXIkERLY40=;
        b=UovLWvhlq9Nekng6RZGWID4mcYF7OuGAUQIbmU+xWojtOovr4gUJAjQBxbD42TXhxS
         thNBDEGns8b2vvuhOHE1p0ZL/c/4eeawBsuMeceRcFkGsTqDj9VOc2cHzjpQKvryZ/mV
         rvcNFRLZKBJkr3Fx8LZij0URjktiwnt7EFKl31gsKdg91kby4IaLaVr1KpiD/22yfYEq
         zvneNk4mqJxMZOum8v3z2IxptgAil6oOvj154LT6POgLTzAoG16AAindMHCV0bJDqY5V
         u3z8HzsavhQH5BITWzCj9b18DdRn7zGTBVltl/2X12kvVtS8UYTW7tMTknnRAFB8ZL3K
         7PxA==
X-Gm-Message-State: AOJu0YxFIHbfRp2y4wuwydqzGhtRGg7MhAxdsDRkn8AawZIe5t9m3hm2
	Cd1kRbbKFjt+M6b8iIDsqdP+omJfGVKTX0tv2Dg=
X-Google-Smtp-Source: AGHT+IG1RfdjGW2Js4NANZmraSoABAWhKaSDm1glzBZoP1aNC/PrbOvFZ3EZz1KeMBSaJ918nO0jDmwH+ipq5AVbCp4=
X-Received: by 2002:a05:6808:1185:b0:3b9:e7ee:4973 with SMTP id
 j5-20020a056808118500b003b9e7ee4973mr11513397oil.108.1702558996438; Thu, 14
 Dec 2023 05:03:16 -0800 (PST)
MIME-Version: 1.0
References: <17A012684A72999E.8967@lists.openembedded.org> <CANPvuRntahuGpsSVeFXRWSfna2o=hVuqZ2my_iUrAKeu+sAXLw@mail.gmail.com>
 <08612b947964d6b22c8dbe6d3cc7188a1ae4b01d.camel@linuxfoundation.org>
In-Reply-To: <08612b947964d6b22c8dbe6d3cc7188a1ae4b01d.camel@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 14 Dec 2023 13:03:05 +0000
Message-ID: <CANPvuR=yQCznyniv52_HoBOu+NZ==o7qqio4CEscmwgFtPY+_Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake.conf remove duplicate PERSISTENT_DIR
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Jose Quaresma <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="000000000000312250060c77e878"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 13:03:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15668

--000000000000312250060c77e878
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia quinta,
14/12/2023 =C3=A0(s) 12:32:

> On Thu, 2023-12-14 at 09:13 +0000, Jose Quaresma wrote:
> > Hi,
> >
> > This patch was merged in bitbake master:
> >
> > f88f314c toaster: Commandline build import table improvements
> > -> 13cbc987 bitbake.conf remove duplicate PERSISTENT_DIR
> > da7f91d6 bitbake: toaster: add functional testing toaster error
> > details
> >
> > but I can't see it on poky master:
> >
> > 524255ad26 bitbake: toaster: Commandline build import table
> > improvements
> > dc608a5bbe bitbake: bitbake: toaster: add functional testing toaster
> > error details
> > 799c131d92 bitbake: toaster: remove test and update setup to avoid
> > rebuilding image
> >
> > Is there a bug somewhere?
>
> That file doesn't exist in poky since historically, two bitbake.conf
> files was considered confusing.
>
> https://git.yoctoproject.org/poky-config/tree/combo-layer.conf#n8


I didn't know this detail.
Thanks


>
>
> Cheers,
>
> Richard
>


--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000312250060c77e878
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&=
gt; escreveu no dia quinta, 14/12/2023 =C3=A0(s) 12:32:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Thu, 2023-12-14 at 09:13 +0000, =
Jose Quaresma wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; This patch was merged in bitbake master:<br>
&gt; <br>
&gt; f88f314c toaster: Commandline build import table improvements<br>
&gt; -&gt; 13cbc987 bitbake.conf remove duplicate PERSISTENT_DIR<br>
&gt; da7f91d6 bitbake: toaster: add functional testing toaster error<br>
&gt; details<br>
&gt; <br>
&gt; but I can&#39;t see it on poky master:<br>
&gt; <br>
&gt; 524255ad26 bitbake: toaster: Commandline build import table<br>
&gt; improvements<br>
&gt; dc608a5bbe bitbake: bitbake: toaster: add functional testing toaster<b=
r>
&gt; error details<br>
&gt; 799c131d92 bitbake: toaster: remove test and update setup to avoid<br>
&gt; rebuilding image<br>
&gt; <br>
&gt; Is there a bug somewhere?<br>
<br>
That file doesn&#39;t exist in poky since historically, two bitbake.conf<br=
>
files was considered confusing.<br>
<br>
<a href=3D"https://git.yoctoproject.org/poky-config/tree/combo-layer.conf#n=
8" rel=3D"noreferrer" target=3D"_blank">https://git.yoctoproject.org/poky-c=
onfig/tree/combo-layer.conf#n8</a></blockquote><div><br>I didn&#39;t know t=
his detail.<br>Thanks<br>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div>

--000000000000312250060c77e878--

