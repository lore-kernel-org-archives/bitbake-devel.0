Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC39EC83030
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 08:03:54 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.17315.1751529824547008869
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jul 2025 01:03:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=HYaRLdWG;
 spf=pass (domain: snapchat.com, ip: 209.85.218.49, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3b336e936so490248066b.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1751529823; x=1752134623; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5U9qy+q+v6PFukuQ3n59Dlc1rJi7oBG14Ci2WH6e9Yk=;
        b=HYaRLdWGDE9zkZwww9f0tHBYy9Kd3NUSXB/l26+PQEVUzFgvlw3GZnemOS4RYQNz8d
         JmrbNSRiZtLBR4SqFnCsqDwtnKdEEWQIOIbApno0KRvrxht9PrhnHrl2gdKtFWpVPi9s
         SDEjVnbvBS/+3WvvlfmqsjW7ZOGExluP1Dnw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751529823; x=1752134623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5U9qy+q+v6PFukuQ3n59Dlc1rJi7oBG14Ci2WH6e9Yk=;
        b=UViroQL5sJWOLmY11yHfMagV2uclDdWyRHpFn9DgAgnnXRL/Vj7jSSEhD5dVKyVXAU
         hc/28QfZeB4kQKjd0pMcSaQQ4oOyIg8LYwbv6c8VvPGBRQfyXgxaOR5d0ohXhIk9UPwq
         DdbvigA1mYjolg4RsoS3Oigjy3TGROvIjTGe1DvfWUxe7GIeqsOWHZcUNNXzXi8LzhCW
         4Yj9Z+O3ifvySSC8c+mRv0v3hvcVxKPWO6BBXcvcKORbjukxpkWyEucdWSdNF6qbxlHn
         mdIHAvN5KrR06iq32kAawlngg+IQVnj/iZ7Cfw7nkLJ97FFQWEvrPtgoHSHsfCjf24sD
         +uYQ==
X-Gm-Message-State: AOJu0YyAP4Du2EGNzFFG3jpnKRM85CKEDAv5PRMR6xvJaAXUXwvHfKA3
	D3KyLPCjwVEsa9DFc/3p2SuU7w+Cy8XFohHOOXBHULzoiDqFcXKF8PMvt5qQrILkBCi+NAG5DgN
	3QpTWhzbTrXeOUK4PNfx5IjJJBtzG391/9A5RcI7fDg==
X-Gm-Gg: ASbGncts/rA0Ek78P6vC82CpLr5wenHZLSGssCfZGFr1G2UacDWXH0SLcoL5b6+SYC+
	G91ulTz3AcKe73eP4WHehAAzyuZNmQpf+HBv4hAy5O4Xv+4q/VMV9uf5hTWTxH8Ftnnwkk5nArB
	8dIhP8zoxB36seAX3hIHTrkLy34Eb4PbUmZtPim0ehc9WD
X-Google-Smtp-Source: AGHT+IHsJwmWsIFhmJvhesBrLHyfkfE9FyMMeUgvE3B5nN8VE3kd6LQPKpYvZBj8r6bgcxJ5MVMxd9I6lSMk7NPfaa4=
X-Received: by 2002:a17:907:970c:b0:ae0:b7bd:34b2 with SMTP id
 a640c23a62f3a-ae3c2b02d13mr649180666b.27.1751529822605; Thu, 03 Jul 2025
 01:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250702204758.2773339-1-ecordonnier@snap.com> <1350a18ac7b6985471ac15e89321c559dbabab62.camel@linuxfoundation.org>
In-Reply-To: <1350a18ac7b6985471ac15e89321c559dbabab62.camel@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Thu, 3 Jul 2025 10:03:31 +0200
X-Gm-Features: Ac12FXwkz3e4xK0HjIXXEzRWsSoKDEPfDlJa3qwbYtR5wOPd260xRZ-44WiitHM
Message-ID: <CAHUKmYb=-rkSodEzWrcBNPG9k=7-x2EDr9ovuU8iUkLVAa6d-g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] uihelper: Fix KeyError race condition in
 pidmap access
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e40a10063901d0f5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Jul 2025 08:03:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17740

--000000000000e40a10063901d0f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I have not yet found a way to reproduce the issue. I'm seeing the issue in
2 from 50 builds after updating from 5.0.9 to 5.0.10, on a build server
with 60 cores, so that's about 4% failure rate. I've never seen the error
before the update. There are no other patches applied to bitbake, however
there are many other layers used so it may not be reproducible on
stand-alone poky. I'll monitor and try to find a way to reproduce.

=C3=89tienne

On Thu, Jul 3, 2025 at 8:42=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2025-07-02 at 22:47 +0200, Etienne Cordonnier via
> lists.openembedded.org wrote:
> > From: Etienne Cordonnier <ecordonnier@snap.com>
> >
> > I'm seeing random build errors on scarthgap 5.0.10 because the pid is
> not contained in pidmap.
> > Fix the error by ensure the PID exists in pidmap before accessing it.
> >
> > Call-stack of the error:
> >
> > ```
> > Traceback (most recent call last):
> >   File "poky/bitbake/lib/bb/ui/knotty.py", line 681, in main
> >     helper.eventHandler(event)
> >   File "poky/bitbake/lib/bb/ui/uihelper.py", line 43, in eventHandler
> >     removetid(event.pid, tid)
> >   File "poky/bitbake/lib/bb/ui/uihelper.py", line 28, in removetid
> >     if self.pidmap[pid] =3D=3D tid:
> > KeyError: 21041
> > WARNING: Exiting due to interrupt.
> > ```
>
> The code was designed such that this should not happen. If it is
> happening, it suggests there is some other issue going on with the task
> reference handling and the patch is just hiding some other underlying
> problem.
>
> Is there any way to reproduce the issue? Have you other patches applied
> to bitbake?
>
> Cheers,
>
> Richard
>

--000000000000e40a10063901d0f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<br><br>I have not yet found a way to reproduce=
 the issue. I&#39;m seeing the issue in 2 from 50 builds after updating fro=
m 5.0.9 to 5.0.10, on a build server with 60 cores, so that&#39;s about 4% =
failure rate. I&#39;ve never seen the error before the update. There are no=
 other patches applied to bitbake, however there are many other layers used=
 so it may not be reproducible on stand-alone poky. I&#39;ll monitor and tr=
y to find a way to reproduce.<br><br>=C3=89tienne</div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On T=
hu, Jul 3, 2025 at 8:42=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto:ric=
hard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, =
2025-07-02 at 22:47 +0200, Etienne Cordonnier via <a href=3D"http://lists.o=
penembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.or=
g</a> wrote:<br>
&gt; From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; <br>
&gt; I&#39;m seeing random build errors on scarthgap 5.0.10 because the pid=
 is not contained in pidmap.<br>
&gt; Fix the error by ensure the PID exists in pidmap before accessing it.<=
br>
&gt; <br>
&gt; Call-stack of the error:<br>
&gt; <br>
&gt; ```<br>
&gt; Traceback (most recent call last):<br>
&gt; =C2=A0 File &quot;poky/bitbake/lib/bb/ui/knotty.py&quot;, line 681, in=
 main<br>
&gt; =C2=A0=C2=A0=C2=A0 helper.eventHandler(event)<br>
&gt; =C2=A0 File &quot;poky/bitbake/lib/bb/ui/uihelper.py&quot;, line 43, i=
n eventHandler<br>
&gt; =C2=A0=C2=A0=C2=A0 removetid(event.pid, tid)<br>
&gt; =C2=A0 File &quot;poky/bitbake/lib/bb/ui/uihelper.py&quot;, line 28, i=
n removetid<br>
&gt; =C2=A0=C2=A0=C2=A0 if self.pidmap[pid] =3D=3D tid:<br>
&gt; KeyError: 21041<br>
&gt; WARNING: Exiting due to interrupt.<br>
&gt; ```<br>
<br>
The code was designed such that this should not happen. If it is<br>
happening, it suggests there is some other issue going on with the task<br>
reference handling and the patch is just hiding some other underlying<br>
problem.<br>
<br>
Is there any way to reproduce the issue? Have you other patches applied<br>
to bitbake?<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--000000000000e40a10063901d0f5--

