Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FC5CCFA05
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 03:33:07 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3880.1762486378128756605
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 19:32:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TuHw2tlE;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8804f840579so5177736d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 19:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762486377; x=1763091177; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XN1QU3pDeTjrg8etTs8e3giWe04uQxx49KUowQdqmlY=;
        b=TuHw2tlEfxd/wWt8ZWTvvZ/ceRbPNSvm+smr90V+AIvcGOgXCBwvQswUgpfNm8JC25
         yy6vlhkGwfV+mr3OyyBSQdl31Qho4vyzGZnNzmwu0Quz6UOZT4R8ggDkw9d4qVQtS4yv
         rPeIzYGYX1deDWyRWNVgfMCTYM0Rm5pRU9xJE/mM8a/gzHWcqdRHSCte4uhlDkHbFweN
         S5hsRHI7CrKHFK5VPiPkzZWRm8v10ST39Skprvice9hOqsnFkAQP3z5lCA4lSDSn8Y3a
         AE79uuZpmIrwDW0sGWKUIc/aSj+AdmsUUy9K9L70eKzVjK8T1pRLyOF4mk/roZ9Xvh9r
         GTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762486377; x=1763091177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN1QU3pDeTjrg8etTs8e3giWe04uQxx49KUowQdqmlY=;
        b=Dku/4FgpdgQ3SeO4FJ7Ny55utpTp5+YR/AXWWbm/jTfzLMDafhT/RVj1dkMIktC6GS
         fVgLKTFtRuIzyAll7sJfOh/Yjfs2t9Jrx0JXnDHzjDx0shx6VZXqT4LYmKzpuIv3RIzD
         o3xj/OAgEmxOnEj4l9z2KRABwRhdC77OJoVEvrVYyciXEnQMhmvc6o8FZF7XXkE/cY21
         1Kud5aXQRyK9Qj8PxNOzTbcv7MXipuQqm8cjk9Ha8ZJxeLO8pd7A4EqBjxPtGyrMyBD/
         UmWE75tZY268thz6z9luXK4dujrEGS1g9M5zHnfFtK/6XSnNYAWajXcC97I/Ado5f9uO
         8PfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVypji/ehKJlbNbpfedZjuM7Aqxb87A849Qh7dNDbgtaiQcTYf2x96MsYQ1efpdnMkVkEb3KEy5KOMg3I+7@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx8yHpHZqJXLd77wYS9IEY1wBohLnnl+NSd6PSOeU/6f2GzA2Gu
	h98YVRBHOvNupq9RMUYuKSHLzLabHWaMWl+6c2Szf48Y17VPoRIWbPnY5iFBZBD/cje9vYLkM2Q
	WoBG69P/5DqdA+FwXsfaxLSw0sDwDWTc=
X-Gm-Gg: ASbGncuQdn53z27fINoQZTb5HKx3PGgaIPpMvVDmhAnnKg16GPxt2ivqJ9753pioroW
	/OPNcEwhxwAmiF5cq3+EuMT/KIPupFqHAaSJa/aBFHeg7Hy+MmWb0yorniAJ7gnwWATF61bbUdl
	UtiwQMRv9C5a6TJxgTRYJFoIwUFu6OJTFq6lWfq+eJf/1EY7Cn2NW+1ECLmuPcmLk4YfzHuI7kp
	7FbucRvEzinu50dgYVep0/YktoaeTi2x4Fv8zsmvT+WWNWU6VOOH3+LyKlY5GT9PgsT4kc23zZa
	+MHgYhl/3dVjfdT6/AWmg7Y3tkcuww==
X-Google-Smtp-Source: AGHT+IHYnW+plY/zrCeEccSsjGcUyAY8qzkldRuQdIH4t96cx2CfW0z37+N1sjqzTHU6VdaE264xENlmnxUx4/xl6gI=
X-Received: by 2002:a05:6214:f29:b0:70d:fa79:baf0 with SMTP id
 6a1803df08f44-8817678dd83mr24199146d6.38.1762486376940; Thu, 06 Nov 2025
 19:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com> <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
 <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org> <DB5PR02MB10213C5C0AD578C01BF7DB065EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB10213C5C0AD578C01BF7DB065EFC3A@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 7 Nov 2025 04:32:46 +0100
X-Gm-Features: AWmQ_bkKpH32n4Y2KRn9BXFM8mC5UMixVf3H2O5zUpteADCHf_TifB_AqHEgyrw
Message-ID: <CANNYZj_qwFt6F-LEwMqe0D04dy7t9_FJMWf1tpCUZ0bayfdUZQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>, 
	Antonin Godard <antonin.godard@bootlin.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="0000000000006b47960642f8d603"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 03:33:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18296

--0000000000006b47960642f8d603
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri 7. Nov 2025 at 1.59, Peter Kjellerstedt <peter.kjellerstedt@axis.com=
>
wrote:

>
> >
> > bb-layers-relative maybe?
> >
> > bb-layers-relative-to-this-file is precise but does feel a bit too
> > unwieldy. Any other options?
> >
> > Cheers,
> >
> > Richard
>
> After I saw Alex' patch for bitbake-setup.schema.json:
>
> https://lore.kernel.org/openembedded-core/20251106170815.2439421-1-alex.k=
anavin@gmail.com/T/#u
> it made me realize that I had not thought that paths in both
> bb-layers and bb-layers-relative are actually relative, just to
> different locations. Unfortunately, I think the newly suggested
> name is then misleading as it implies that paths in bb-layers
> are not relative. :( I now also understand why the longer
> bb-layers-relative-to-this-file was originally proposed.
>
> I don't have a good solution for this. The best I can come up
> with is to rename them both to, e.g., bb-layers-dir-relative and
> bb-layers-file-relative


I tend to agree. I=E2=80=99d rather call them =E2=80=98bb-layers-in-sources=
=E2=80=99 and
=E2=80=98bb-layers-in-this-dir=E2=80=99. Patch is coming even though I=E2=
=80=99m technically on
holiday since midnight. This is important.

Alex

>

--0000000000006b47960642f8d603
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">On Fri 7. Nov 2025 at 1.59, Peter Kjellerstedt &lt;<=
a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blank">peter.kjell=
erstedt@axis.com</a>&gt; wrote:<br></div></div><div><div dir=3D"auto"><div =
class=3D"gmail_quote"></div></div></div><div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;padding-left:1ex;border-left-color:rgb(204,204,204)" dir=3D"auto">=
<br>
&gt; <br>
&gt; bb-layers-relative maybe?<br>
&gt; <br>
&gt; bb-layers-relative-to-this-file is precise but does feel a bit too<br>
&gt; unwieldy. Any other options?<br>
&gt; <br>
&gt; Cheers,<br>
&gt; <br>
&gt; Richard<br>
<br>
After I saw Alex&#39; patch for bitbake-setup.schema.json:<br>
<a href=3D"https://lore.kernel.org/openembedded-core/20251106170815.2439421=
-1-alex.kanavin@gmail.com/T/#u" rel=3D"noreferrer" target=3D"_blank">https:=
//lore.kernel.org/openembedded-core/20251106170815.2439421-1-alex.kanavin@g=
mail.com/T/#u</a><br>
it made me realize that I had not thought that paths in both <br>
bb-layers and bb-layers-relative are actually relative, just to <br>
different locations. Unfortunately, I think the newly suggested <br>
name is then misleading as it implies that paths in bb-layers <br>
are not relative. :( I now also understand why the longer <br>
bb-layers-relative-to-this-file was originally proposed.<br>
<br>
I don&#39;t have a good solution for this. The best I can come up <br>
with is to rename them both to, e.g., bb-layers-dir-relative and <br>
bb-layers-file-relative</blockquote><div dir=3D"auto"><br></div></div><div>=
<div dir=3D"auto">I tend to agree. I=E2=80=99d rather call them =E2=80=98bb=
-layers-in-sources=E2=80=99 and =E2=80=98bb-layers-in-this-dir=E2=80=99. Pa=
tch is coming even though I=E2=80=99m technically on holiday since midnight=
. This is important.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Ale=
x</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-=
color:rgb(204,204,204)" dir=3D"auto"></blockquote>
</div>

--0000000000006b47960642f8d603--

