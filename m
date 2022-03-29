Return-Path: <simon.eu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D86C433F5
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 06:36:10 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web12.3596.1648535769223861351
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 23:36:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=F8Ezu0n7;
 spf=pass (domain: gmail.com, ip: 209.85.214.178,
 mailfrom: simon.eu@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id c23so16795673plo.0
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+umNY/jFV/Y53xEFnC430LQzQuHugEnDsLGFOJh9rik=;
        b=F8Ezu0n7XKHYJlhfF4TE4DwC9E2IUAdanEfJjxilJvYKmE+ToxtAqplv1K70dt3seF
         9wJVbLW55YlZ+1QliCpB3pcSmLLCCQ9uboZoV5o3tThp/H+Y4tNxgQlapEEUzG3NBKwJ
         VFXCos1cwsukjSN9ahesgb+t5bkKscU7qd9gR6r20r9oakBGjR+zsnCGx/AnhC8Po17b
         Ivvwum21ZdDEF+3eDCCE++WZTssq+V96RHLWpKqlPKUh5YK1coze0+E64XEMhIGCSxlq
         9wY0xTKtzKKs02WjxyZ7hb8LfShfSpukoLkSgzMt7tUCLOgFbyMcSlQVuVDusFJnPvBt
         1gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+umNY/jFV/Y53xEFnC430LQzQuHugEnDsLGFOJh9rik=;
        b=auyu3giGITy3UOH5lZX7KmmPcy0iwAiV3WyhQpRywSh6zqjHNQZjXmJNcSBvnrUzhh
         GYRODCcYZAQ8GnSdhqpCyDRCP/uj6vRIQJ/zYmEpNaHIPFQbkgNNf5nd00U4QRFVU+G5
         88QfPLNWgd+XyOYkR4Ng5ad0JfU+oI2B6gLBh6OCnCJEAfOJNDqDejIM+2j4YoZaT60K
         9ros1VqNJj5B3XWP4oJTSvyoe62JrP3JNANopdz6UxbmRnToIBllBqyZDYLNmQw8Ly8W
         o8QvLCKoxRm0QtgBLoXsAMg8YslSC4kmdX4LBKQYX7qbByiShmkXyNBk+dwOprdx2pnr
         voEg==
X-Gm-Message-State: AOAM533hpwd9z70c3SkTeYpx8Kgs8ugGBjoivrgAH7LEyyuHxObGcOsr
	nG4lsvd27Z3H7JLOSiUxUuWqhYByxnxU2L6CpWw=
X-Google-Smtp-Source: 
 ABdhPJwKz2CD6G37/8G58oRvFoxfW2Vl9LMZXmBaQ2vaK7PSc3VgI0YS8oNwDPiKqs+ijPGQjWPudBJI1/Y3biDYBzk=
X-Received: by 2002:a17:90a:380f:b0:1bd:4aa6:651 with SMTP id
 w15-20020a17090a380f00b001bd4aa60651mr2975018pjb.83.1648535768740; Mon, 28
 Mar 2022 23:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211215092509.60979-1-simon.eu@gmail.com>
 <42d3ff93-33a1-e751-b0ff-974c8ecb4858@bootlin.com>
 <CAO8d5BY0R2d4Ufvk9cWwx=t95sOcQXs-5NGquP-3AAH8xG-RAg@mail.gmail.com>
 <9e458156-8a40-ce06-986a-8ce39b546712@bootlin.com>
 <CAO8d5BYN7g0oEoPG=CrTt99pQ1-fYkx5bq-RiB_j9E3OBu4K2w@mail.gmail.com>
 <ca5a3aed-e04c-b2b5-65eb-6bb424d0c379@bootlin.com>
 <6035008ce96fb9055547cf0cc2ffa51d2262c9ea.camel@linuxfoundation.org>
 <CAO8d5BYO1z76mtrYiXt5P-gg0VZFRgL_b0DcBteuP6WxHpkhnQ@mail.gmail.com>
 <0e261493-b077-1fe6-cefb-39c55018cc83@bootlin.com>
In-Reply-To: <0e261493-b077-1fe6-cefb-39c55018cc83@bootlin.com>
From: Simon Eugster <simon.eu@gmail.com>
Date: Tue, 29 Mar 2022 08:35:57 +0200
Message-ID: 
 <CAO8d5BaCPigsCYiBnUNH1J9A_uRTz=cqCcCcFrF_E+JS-ONK_A@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH] bitbake: doc: bitbake-user-manual:
 Add more explanations to OVERRIDES
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000e540c905db55a49d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 06:36:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13528

--000000000000e540c905db55a49d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, Mar 25, 2022 at 3:31 PM Michael Opdenacker <
michael.opdenacker@bootlin.com> wrote:

> Hi Simon,
>
> On 3/23/22 13:24, Simon A. Eugster wrote:
> > I submitted a patch for only the OVERRIDE part now. (The in-reply-to
> > did not seem to have an effect =E2=80=93 sorry for that!)
> >
> > I can submit that part as separate patch and I'm happy to re-phrase or
> > change it in other ways.
> >
> > +.. note::
> > +
> > +   Before Honister (3.4), override style used ``_`` instead of ``:``,
> > so you will
> > +   still find a lot of documentation using =E2=80=9C_append=E2=80=9D, =
=E2=80=9C_prepend=E2=80=9D, and
> > +   =E2=80=9C_remove=E2=80=9D.
>
>
> This text has already been added:
>
> https://git.openembedded.org/bitbake/commit/?id=3Dad2307823a96e91873d804a=
a9d8f11c9ff39bec0


Ah okay, I did not see that. Perfect!

Simon

--000000000000e540c905db55a49d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Michael,</div><div></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, =
Mar 25, 2022 at 3:31 PM Michael Opdenacker &lt;<a href=3D"mailto:michael.op=
denacker@bootlin.com">michael.opdenacker@bootlin.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Simon,<br>
<br>
On 3/23/22 13:24, Simon A. Eugster wrote:<br>
&gt; I submitted a patch for only the OVERRIDE part now. (The in-reply-to<b=
r>
&gt; did not seem to have an effect =E2=80=93 sorry for that!)<br>
&gt;<br>
&gt; I can submit that part as separate patch and I&#39;m happy to re-phras=
e or<br>
&gt; change it in other ways.<br>
&gt;<br>
&gt; +.. note::<br>
&gt; +<br>
&gt; + =C2=A0 Before Honister (3.4), override style used ``_`` instead of `=
`:``,<br>
&gt; so you will<br>
&gt; + =C2=A0 still find a lot of documentation using =E2=80=9C_append=E2=
=80=9D, =E2=80=9C_prepend=E2=80=9D, and<br>
&gt; + =C2=A0 =E2=80=9C_remove=E2=80=9D.<br>
<br>
<br>
This text has already been added:<br>
<a href=3D"https://git.openembedded.org/bitbake/commit/?id=3Dad2307823a96e9=
1873d804aa9d8f11c9ff39bec0" rel=3D"noreferrer" target=3D"_blank">https://gi=
t.openembedded.org/bitbake/commit/?id=3Dad2307823a96e91873d804aa9d8f11c9ff3=
9bec0</a></blockquote><div><br></div><div>Ah okay, I did not see that. Perf=
ect!</div><div><br></div><div>Simon<br></div></div></div>

--000000000000e540c905db55a49d--

