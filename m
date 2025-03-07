Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DB3C19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 18:56:41 +0000 (UTC)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
 by mx.groups.io with SMTP id smtpd.web10.18963.1741373797107824470
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 10:56:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TunLWXj3;
 spf=pass (domain: gmail.com, ip: 209.85.166.173, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d3e25323cfso19374405ab.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741373796; x=1741978596; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZfIEBy9LOpLItPlM/oWVLk9eZdzre/O1EdREkllS80=;
        b=TunLWXj3UTdQgKv8napTdF+ShFqCq4Kz6GlwjYJWEWlyhs//h65nvjTyCxS/zJFuiT
         GwbjTGKQ9xc+6cH9ZGXdsfhwAGjAayeTs0Tj+jy6q0h1zyX9vFZo+7uBHh4OEbu9k5RN
         b5JFTla7GTlY8Wf5qDc1Id+QyO+gN0PL16Xl3R9zIc6WyBwjcJyog94A6uywGg/359A5
         DqW3UJSLOktVMuef4rEUuT8rBScojdjC47hvEUsIoOjDlniMtwMrrF15hr76wTXycLMI
         Rx6BVFfzQW9p3XZi+WnCDeh0Qwdj6H8C/Yt3exSdQjx578PwTgmv0Wv4BQalMggCttVT
         eaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741373796; x=1741978596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZfIEBy9LOpLItPlM/oWVLk9eZdzre/O1EdREkllS80=;
        b=kE/gbQOdZ3lh5fHBNXZjCebVsUVRwvgSJOsXpr+sf1eaTbGnMNqTVVzLIQV+F7+7Mt
         fEQPAe2ZszVZSF8MvJJjZDXTLYQx6iGiGNDbsZQfOIQnhjLqTpcf3TJlXw5b0L0eh+ba
         JRGgTHbJPD24Dos+pTk1lC+orsbAwKgWnKt2F21M9uox5nDWCboq4xx8sW5VJTaS+jhJ
         LswBSemfc4dRQ9VR1aR2zvbxn6WRQwYiEI9lFoDpZhAGzvgFh2SgMaJwKJiEVNULuNZH
         mHukKGdpVwMngXPREaIeRNQP9fvc+GN9YlT9fPuhv3OFoZ7EY6JC5ag07VR10IbG8hEQ
         yb/w==
X-Gm-Message-State: AOJu0YwdBz4tiCachAOvd/WQzpa/pyy6bQMQKI2FhPFW/4JVZtArK4QG
	HbxsrP/yeotJNcvoMAyRIIQPxRI5AF0Gn+Yc/J5wco80n/kt3G/+ikQzrHTyoRdSt9cIBFApuw8
	GvyXkWqqRShn8ZS98lNc0Yom9JHM=
X-Gm-Gg: ASbGncv7TWW08Kgsm4wA0egxZrHyWnj3XJL6x+ieqCD78t39DS/wG4A2oRhqxJz3Pjc
	xufAXWlXVTmTXhjWCwulaifpTTVieFen2xP+osBF3eiMccJ66KlY7T5TRm7SI6Qu3ASO382C1y/
	I1K4exjPku1VvxtRpOgiIlNLqX39+gKQBM/JHyj+HVx3rSlMLoYW4qHjbf63c=
X-Google-Smtp-Source: AGHT+IHStBkENlxyDYj52Ft1SdEq+xk15e1hAEOeYUA2Lj1uHNwCERz+HWWwKqsfq7k1vKpi8V1rcxJ/EzB/KcBqL64=
X-Received: by 2002:a92:ca49:0:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d44192aa05mr64132545ab.15.1741373796282; Fri, 07 Mar 2025
 10:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20250228130137.400-1-eric.meyers@arthrex.com> <20250228130137.400-3-eric.meyers@arthrex.com>
 <CAB=6tBRU3+bKeNsbNpiHChBpeXbjR7Or3rOVT66-5K81OgZK2Q@mail.gmail.com> <CA+cKJ+GOjzvBoHrFr_Y634cOUJTrD1VC8864CfDKkRJp_ey2gQ@mail.gmail.com>
In-Reply-To: <CA+cKJ+GOjzvBoHrFr_Y634cOUJTrD1VC8864CfDKkRJp_ey2gQ@mail.gmail.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Fri, 7 Mar 2025 10:56:18 -0800
X-Gm-Features: AQ5f1JpQ1TCKyD8LIlr7vYkd0IJxBcSn-NQMLFc5uQgjCwgRx30GEl98gM76Rsg
Message-ID: <CAB=6tBRm_rJ2QeCdZhSNgTaZZ94DsyQX27MnAeLu9tiPnin2gQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC
To: Eric Meyers <eric.meyers15310@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Eric Meyers <eric.meyers@arthrex.com>, Geoff Parker <geoffrey.parker@arthrex.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000008c79a3062fc52e2a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 18:56:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17413

--0000000000008c79a3062fc52e2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 9:17=E2=80=AFAM Eric Meyers <eric.meyers15310@gmail.=
com>
wrote:

>
> Apologies if this isn't the correct process (this is my first time
> submitting a patch), but what's needed to merge this patch into
> master-next, then master?
>
>
For now, probably nothing, but it never hurts to do what you did and ask.
The
bitbake repo maintainers watch this list.

Your patches show up in patchwork here:
https://patchwork.yoctoproject.org/project/bitbake/list/
Just search for your name.

Also, have you reviewed the contribution docs?

https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html


..Ch:W..


--=20



*  Opinions expressed are my own. | --------------------------------|------
"Perfection must be reached by degrees              she requires the slow
hand of time."                                 |       -Voltaire*

--0000000000008c79a3062fc52e2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace">On Fri, Mar 7, 2025 at 9:17=E2=80=AFAM Eric Meyers &lt;=
<a href=3D"mailto:eric.meyers15310@gmail.com">eric.meyers15310@gmail.com</a=
>&gt; wrote:</div></div><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><br><div>Apologies if this isn&#39;t the correct process (this is =
my first time submitting a patch), but what&#39;s needed to merge this patc=
h into master-next, then master?</div><div><br></div></div></div></blockquo=
te><div><br></div><div><div style=3D"font-family:monospace" class=3D"gmail_=
default">For now, probably nothing, but it never hurts to do what you did a=
nd ask. The</div><div style=3D"font-family:monospace" class=3D"gmail_defaul=
t">bitbake repo maintainers watch this list.<br><br></div><div style=3D"fon=
t-family:monospace" class=3D"gmail_default">Your patches show up in patchwo=
rk here: <a href=3D"https://patchwork.yoctoproject.org/project/bitbake/list=
/">https://patchwork.yoctoproject.org/project/bitbake/list/</a></div><div s=
tyle=3D"font-family:monospace" class=3D"gmail_default">Just search for your=
 name.<br><br></div><div style=3D"font-family:monospace" class=3D"gmail_def=
ault">Also, have you reviewed the contribution docs?<br><br><a href=3D"http=
s://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html">https:=
//docs.yoctoproject.org/dev/contributor-guide/submit-changes.html</a><br></=
div><div style=3D"font-family:monospace" class=3D"gmail_default"><br></div>=
<div style=3D"font-family:monospace" class=3D"gmail_default"><br></div><div=
 style=3D"font-family:monospace" class=3D"gmail_default">..Ch:W..</div><br>=
</div><div>=C2=A0</div></div><span class=3D"gmail_signature_prefix">-- </sp=
an><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><b>=
<span style=3D"font-family:monospace">=C2=A0 Opinions expressed are my own.=
 |<br>=C2=A0--------------------------------|------ &quot;Perfection must b=
e reached by degrees<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 she requires the slow hand of time.&quot;<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -Voltaire</span></b></div></div></div></div>

--0000000000008c79a3062fc52e2a--

