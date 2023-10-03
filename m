Return-Path: <gowrishankarstg@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598F2E776F2
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 02:51:43 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
 by mx.groups.io with SMTP id smtpd.web11.100517.1696301499064374680
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Oct 2023 19:51:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=G0mFvzcz;
 spf=pass (domain: gmail.com, ip: 209.85.217.51, mailfrom: gowrishankarstg@gmail.com)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4526d872941so231615137.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Oct 2023 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696301498; x=1696906298; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9E/bU41vcfpCyIq60KLTdH74OzAHZ6JOnTEjQzfGRRM=;
        b=G0mFvzczWsz7GikHhBPS1F3v5NDdkeb8+id396eakdYnIzSFjJZGU/A8CqD7kxycXw
         OgRN/N7uhN6ZuTkgT+rB04LBPBblJoo/3BC1jaaQLI+67WaiX47u6MCF+XqlyZI5rfQM
         8sFtZzeGOA8mmcFzxmV0TbjFsjWRYFT9m8EIA4UfpZaiBiBiUfBJQBZb5OLmIq3e9/Vj
         yknpYSOyrI51/N6XF7rYpbN3uexG1utM+RFzssRDPFAOMHR/io+8g28qZYjmiL+zJPbP
         M/KD99x+CZk6CyRWkk/31cZdA1KB/QYNHhEnozRe9kPy6aY/lg84O0rWyn0EUeLPGSqR
         Yv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696301498; x=1696906298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9E/bU41vcfpCyIq60KLTdH74OzAHZ6JOnTEjQzfGRRM=;
        b=Ynu9D1LrBu3FWMrURLduOgec4D+WZc1W/iqynbe82ONwWCSnwfgmwLfEUUha2CALwK
         1B6+iVKIkn6nJ7+boY1gEUMJC3taAmRW94rO5Qir87/lXp7FMP8pNPOfo9Xf0TAMZbZn
         kLw6tj7VY9msfkEuGWU7MX/8YCnSbI/+7jDQTAhasiwR7o2boxHIQvfec2YCsLaC5Sg1
         ihaEFVTIegFzaSWQRXdPbPmK9UW/HllnEL4fYTXQAVrbGuOc5U0L/9gBPyW9ew6lZ72X
         oA1eK5CG62Dfbd3WPsHQPf1HZo/g7VIoUJA3wzW2EVt39NNq+bu2r85ct/7Rpp05ZO0t
         2pCA==
X-Gm-Message-State: AOJu0YyjIgXyOvC7jASX0keiT8InK+rfDz4a2ut96DepbRf3tg8CXlX4
	WuCc/acEc71VjiEbBAR8aC498o8YWUR43cK/E0o=
X-Google-Smtp-Source: AGHT+IHPHNFup++IhYakpDhw3b7Gvfa8ky1swpIpYM8xn43R6+s8zwkmspK+/WrjkaTd/QlThCtSYl8tkN6fsYwlaH8=
X-Received: by 2002:a67:ff01:0:b0:452:6135:d with SMTP id v1-20020a67ff01000000b004526135000dmr11637792vsp.33.1696301497790;
 Mon, 02 Oct 2023 19:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203958.35361-1-gowrishankarstg@gmail.com>
 <9fffc17ec1ff6a4248f5d9eb8cd6a7243f93d899.camel@linuxfoundation.org>
 <CACTJJZN_8MrG5jkFF+0xfq3wQNTSpOi4cM-5VvGVxm8XDQPAOQ@mail.gmail.com> <ccd86ea525ab650de8b9304cefbd8ce50fcf9636.camel@linuxfoundation.org>
In-Reply-To: <ccd86ea525ab650de8b9304cefbd8ce50fcf9636.camel@linuxfoundation.org>
From: Gowrishankar Saminathan <gowrishankarstg@gmail.com>
Date: Tue, 3 Oct 2023 08:21:50 +0530
Message-ID: <CACTJJZOh4XU5xqP84ASao8UnVJcQ7SYyjFBv-10atc3ry7OS_g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] runqueue: Fix task execution
 dependency issue
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000353b280606c6f830"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 02:51:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15159

--000000000000353b280606c6f830
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Richard,

I wanted to express my gratitude for sharing the patches with me for
testing . I have tried all the commit you provided, with the exception of
5fdd28e37face59410da781d5d70178565e69e5e
<https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/runqueue.py?id=3D5=
fdd28e37face59410da781d5d70178565e69e5e>,
applied on top of yocto-3.1.27 . With other two commits issue still seems
to appear.
Interestingly *I couldn't reproduce the issue at all in "master" branch*,
It seems highly likely that the issue has already been resolved, and the
fix is readily available in the "master" branch, just as you mentioned.
Thank you for your assistance in addressing this matter.

Best Regards,
Gowrishanakr Saminathan





On Wed, Sep 27, 2023 at 1:17=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2023-09-26 at 20:29 +0530, Gowrishankar Saminathan wrote:
> > Hello Richard,
> >
> > I am facing this issue in the BitBake version tagged as yocto-3.1.27
> > when I used it in Yocto of the same version.
> > Upon reviewing the master branch, it appears to have a similar
> > implementation to yocto-3.1.27 regarding this issue case.
> > Consequently, I believe this issue should also apply to the master
> > branch.
>
> Whilst your patch might apply, I'm not convinced it is necessary. I'd
> like you to reproduce the issue with master please as I'm not sure you
> will be able to.
>
> >
> > It would be great if the master branch already includes this fix. If
> > possible, kindly provide the commit which addresses this issue.
> >
> > Thanks for reaching me out!
>
> There were multiple patches fixing a variety of issues. Some like this
> one appear to be in dunfell (3.1).
>
>
> https://git.yoctoproject.org/poky/commit/bitbake?id=3D7ea37b929153e112b8d=
843c05fab06354aa575fc
>
> Some like this one appear not to be:
>
>
> https://git.yoctoproject.org/poky/commit/bitbake?id=3D9982b2c0f2a4bf6d451=
b532856ca6cf126985f22
>
> and this one too:
>
>
> https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/runqueue.py?id=3D=
5fdd28e37face59410da781d5d70178565e69e5e
>
> I'd look at the changes to runqueue.py between dunfell and master as I
> do suspect this is fixed there, just not the way your patch attempts
> to.
>
> Cheers,
>
> Richard
>
>
>
>
>
>

--000000000000353b280606c6f830
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Richard,</div><div><br></div><div>
I wanted to express my gratitude for sharing the patches with me for testin=
g

. I have tried all the commit you provided, with the exception of

<a href=3D"https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/runqueue=
.py?id=3D5fdd28e37face59410da781d5d70178565e69e5e">5fdd28e37face59410da781d=
5d70178565e69e5e</a>, applied on top of=20
<span class=3D"gmail-im">yocto-3.1.27</span>

. With other two commits issue still seems to appear.</div><div>Interesting=
ly <b>I couldn&#39;t reproduce the issue at all in &quot;master&quot; branc=
h</b>, It seems highly likely that the issue has already been resolved, and=
 the
 fix is readily available in the &quot;master&quot; branch, just as you men=
tioned.</div><div>
Thank you for your assistance in addressing this matter. <br></div><div><br=
></div><div>Best Regards,</div><div>Gowrishanakr Saminathan<br></div><div><=
br></div><div>

<table summary=3D"commit info" class=3D"gmail-commit-info"><tbody><tr><th><=
br></th><td colspan=3D"2" class=3D"gmail-sha1"><br></td></tr></tbody></tabl=
e><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Sep 27, 2023 at 1:17=E2=80=AFAM Richard Purdie &lt;<a h=
ref=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfound=
ation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, 2023-09-26 at 20:29 +0530, Gowrishankar Saminathan wrote=
:<br>
&gt; Hello Richard,<br>
&gt; <br>
&gt; I am facing this issue in the BitBake version tagged as yocto-3.1.27<b=
r>
&gt; when I used it in Yocto of the same version.=C2=A0<br>
&gt; Upon reviewing the master branch, it appears to have a similar<br>
&gt; implementation to yocto-3.1.27 regarding this issue case.<br>
&gt; Consequently, I believe this issue should also apply to the master<br>
&gt; branch.<br>
<br>
Whilst your patch might apply, I&#39;m not convinced it is necessary. I&#39=
;d<br>
like you to reproduce the issue with master please as I&#39;m not sure you<=
br>
will be able to.<br>
<br>
&gt; <br>
&gt; It would be great if the master branch already includes this fix. If<b=
r>
&gt; possible, kindly provide the commit which addresses this issue.<br>
&gt; <br>
&gt; Thanks for reaching me out!<br>
<br>
There were multiple patches fixing a variety of issues. Some like this<br>
one appear to be in dunfell (3.1).<br>
<br>
<a href=3D"https://git.yoctoproject.org/poky/commit/bitbake?id=3D7ea37b9291=
53e112b8d843c05fab06354aa575fc" rel=3D"noreferrer" target=3D"_blank">https:=
//git.yoctoproject.org/poky/commit/bitbake?id=3D7ea37b929153e112b8d843c05fa=
b06354aa575fc</a><br>
<br>
Some like this one appear not to be:<br>
<br>
<a href=3D"https://git.yoctoproject.org/poky/commit/bitbake?id=3D9982b2c0f2=
a4bf6d451b532856ca6cf126985f22" rel=3D"noreferrer" target=3D"_blank">https:=
//git.yoctoproject.org/poky/commit/bitbake?id=3D9982b2c0f2a4bf6d451b532856c=
a6cf126985f22</a><br>
<br>
and this one too:<br>
<br>
<a href=3D"https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/runqueue=
.py?id=3D5fdd28e37face59410da781d5d70178565e69e5e" rel=3D"noreferrer" targe=
t=3D"_blank">https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/runque=
ue.py?id=3D5fdd28e37face59410da781d5d70178565e69e5e</a><br>
<br>
I&#39;d look at the changes to runqueue.py between dunfell and master as I<=
br>
do suspect this is fixed there, just not the way your patch attempts<br>
to.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000353b280606c6f830--

