Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA187C83F03
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 14:25:36 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.24044.1751552732951659666
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jul 2025 07:25:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=WgsN48M0;
 spf=pass (domain: snapchat.com, ip: 209.85.208.43, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso8785689a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1751552731; x=1752157531; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyAxNqyQ9aUSPjUMZh7GEUwwHRL0PJ2wynxK0GtDH8Y=;
        b=WgsN48M0EZVPMUy6BgmxwHCOPaZr0NBXI6y3f2iHzt7gwmcqP57ujBbLpUTXl9CGbq
         V4kBKqZcgmbeNKKfZ31KxOngRX7TFP6guR3C8LPZ4L+ehfrn9RjoxsX9T5I2nUXpGTii
         KtVPfgJ43O+3fgzXBvoDgiuXpm8Zf4MnpPeIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751552731; x=1752157531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyAxNqyQ9aUSPjUMZh7GEUwwHRL0PJ2wynxK0GtDH8Y=;
        b=tQmBSkyK9sLS7kAOqA/aob2rj+XRgjpEiv9bofmIXkidOtRyZw65HB93xUmS1FUIAx
         G4QrzDFIfTwmbrNv89IvIV1RnY0iWrmC4y0ncqWLbjBdpLHOSTRiRaqVmP0PqUP1+HvH
         3kU0x7pOtup9SPI0qfGhOQ9Bmcc4wfCWlcZiHxrTB1gpzvAc7lgbZyX2t4uuaxCHj2Ae
         9wifnZNfwecqvmqWA4pr5qXFfrc1PdsSDPP1J7gdljc/ge7U/M6qAdXHxEF2W/wFwyVe
         xlFvJf5h0qklm5NSjOZ2ygcrBcwRgaqIOMdsvBqY0jV6CSR20/dPfebbAn1rCicKirfw
         UMtg==
X-Gm-Message-State: AOJu0YzBxb3tCNlbDR+x1R9jp0t00ctATDECRG0nS0hx/P4kddyqZFLy
	nEvoEMHEMOMtEgEHL0YIVdYkVg2QkvNxGgCnt0ToyXlLDSQUzzHsae+71se+jFeY3gsUMgJzTvN
	zLjRGvm4YepwrXDGSTECtdkNN58yaekRh0oSOUPtbgg==
X-Gm-Gg: ASbGncscocWX6hTSrP5jiYMJ1o2VwsQBGop5FsmYrZIzdJvnEqrbkeh+j6iTrN1HSHz
	kNl1++qTuSc0Kmi+6mTD3r0BrkA0vgrdkJaCXQ1pusOQgFdwL13p5ZcwcWLqW5qh7P0FlURFCjD
	5zOxVNVVzoE+16WtpsNzh35qraPJhdnLtyybk1d/FajG6i
X-Google-Smtp-Source: AGHT+IEBfZhTpdQbo9c5dEyurKWLVdCiu3WkPRewSTI4qsynLWge+oezfCeM/ssMPgeKgUeXRKQm30S8h4LX2p+3SR4=
X-Received: by 2002:a17:906:12d3:b0:ade:40cb:2515 with SMTP id
 a640c23a62f3a-ae3c2c7f6f0mr605312366b.59.1751552730928; Thu, 03 Jul 2025
 07:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250702204758.2773339-1-ecordonnier@snap.com>
 <1350a18ac7b6985471ac15e89321c559dbabab62.camel@linuxfoundation.org>
 <CAHUKmYb=-rkSodEzWrcBNPG9k=7-x2EDr9ovuU8iUkLVAa6d-g@mail.gmail.com> <979ed4823e11b76bb362dfeb83470959f53581a3.camel@linuxfoundation.org>
In-Reply-To: <979ed4823e11b76bb362dfeb83470959f53581a3.camel@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Thu, 3 Jul 2025 16:25:19 +0200
X-Gm-Features: Ac12FXw88Y3BEh3IvTDuY9EdygiRwWB86hKJWf2ObB6EZRVL_YdXQiVJ6IpYVdo
Message-ID: <CAHUKmYZo+BCLDN6Nefqpx6gZ2nn1z1M+a4VXVqx2KoByUFsN6A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] uihelper: Fix KeyError race condition in
 pidmap access
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000555778063907266c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 14:25:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17743

--000000000000555778063907266c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is no obvious pattern. The two builds with failure are successful
until this error is shown in the logs. There is no Ctrl+C interruption,
since those are build-servers without human interaction. There is also no
obvious reason why a SIGINT would be sent. I'll try to find the root-cause,
or at least some way to reproduce.

=C3=89tienne

On Thu, Jul 3, 2025 at 10:52=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2025-07-03 at 10:03 +0200, Etienne Cordonnier wrote:
> > Hi Richard,
> >
> > I have not yet found a way to reproduce the issue. I'm seeing the
> > issue in 2 from 50 builds after updating from 5.0.9 to 5.0.10, on a
> > build server with 60 cores, so that's about 4% failure rate. I've
> > never seen the error before the update. There are no other patches
> > applied to bitbake, however there are many other layers used so it
> > may not be reproducible on stand-alone poky. I'll monitor and try to
> > find a way to reproduce.
>
> Is there any pattern such as only interrupted builds (Ctrl+C?) or build
> with failing tasks? Any particular kinds of failures? Just trying to
> narrow down the possible causes and give ideas...
>
> Cheers,
>
> Richard
>
>

--000000000000555778063907266c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">There is no obvious pattern. The two builds with failure a=
re successful until this error is shown in the logs. There is no Ctrl+C int=
erruption, since those are build-servers without human interaction. There i=
s also no obvious reason why a SIGINT would be sent. I&#39;ll try to find t=
he root-cause, or at least some way to reproduce.<br><br>=C3=89tienne</div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jul 3, 2025 at 10:52=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto:rich=
ard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfound=
ation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Thu, 2025-07-03 at 10:03 +0200, Etienne Cordonnier wrote:<br>
&gt; Hi Richard,<br>
&gt; <br>
&gt; I have not yet found a way to reproduce the issue. I&#39;m seeing the<=
br>
&gt; issue in 2 from 50 builds after updating from 5.0.9 to 5.0.10, on a<br=
>
&gt; build server with 60 cores, so that&#39;s about 4% failure rate. I&#39=
;ve<br>
&gt; never seen the error before the update. There are no other patches<br>
&gt; applied to bitbake, however there are many other layers used so it<br>
&gt; may not be reproducible on stand-alone poky. I&#39;ll monitor and try =
to<br>
&gt; find a way to reproduce.<br>
<br>
Is there any pattern such as only interrupted builds (Ctrl+C?) or build<br>
with failing tasks? Any particular kinds of failures? Just trying to<br>
narrow down the possible causes and give ideas...<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--000000000000555778063907266c--

