Return-Path: <aw@pionix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EACEC54E94
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 14:21:44 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web11.74614.1674742894686885517
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 06:21:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pionix-de.20210112.gappssmtp.com header.s=20210112 header.b=uvDku2jC;
 spf=pass (domain: pionix.de, ip: 209.85.208.179, mailfrom: anton.woellert@pionix.de)
Received: by mail-lj1-f179.google.com with SMTP id p25so2002020ljn.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 06:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pionix-de.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ9GQybB6VIIIefdkg6JqmrcQGFVVN/pavN7Tspecec=;
        b=uvDku2jCslZXtsqmNf8ORBOVbtIEPiImO29UnLdmvueZ9xaJWXrnQl5jr1pqAYhJk0
         0/ETQhybG95hLAZIaKTASxm2eNpWdT3FnhqRTysZg/fHjNW+A9OLgKC/07Hypz/j/Ex2
         KPP7TrF0/s4F/rFxGUWkD/wjCml2xwuesWPdRdfvE4GhREVipTTZc+FipMn4pZxMf/G1
         JWdQvpbVLjMsXgdcQ+AjaVuIXbmAnuNqat4k70IiSryvXXRLgolRg1+RAM8Y6Oskuc13
         ge6wizPSA/NLXA/NEjey1+BifHbt5p+50WvWAMPU1xIrYh4d8Ll2r79mD66Ae+vZq0l1
         fiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ9GQybB6VIIIefdkg6JqmrcQGFVVN/pavN7Tspecec=;
        b=d8sixU85mDRTVRclkeJMSCK7AKoRbprgtYG506DuQg59YYcmyoSsz45pJ2/XFhtHqk
         feWXq3AM6IxjxGN6UFViEI8bamFqyOYhBs4mJ64rlQbPie7th7xR3RwrAAZKq2x+mlmH
         G7+lQl7N4UK1J0nQCARzVSqXdUXWduXDtEPKaDGD1fxb/QrvQX06zbBtMLEPWdVK0KJa
         aSbuWs/U6jUwFFiJ78h0x6W0FnkEBZts9RCnwqwYtvAKs4l1b+eLDspoiA6EW74BUmco
         TF/mfF58OZpe2RxJ3KB5fOA/u04SClv5o6nSLzXvQ6lBL/RkgTMmoh/HwdvXoOfRSDpf
         WzAA==
X-Gm-Message-State: AFqh2kp3ZmzqUyrECCb4lD7VwrTtVc+S6MoLhjjayzTw8mrZZr7vBQ7s
	yErONjo84h1IuIanNIQT0VJGzR9KtJWG5flb4wRr9A==
X-Google-Smtp-Source: AMrXdXuueU1sz+aW5tK095wQkCD8m3+g5lLtxPhIldu1aSFy09NG1mkZZQPQKvw0SNDlHl27IuPTwmIHnje5H1DWa+U=
X-Received: by 2002:a05:651c:2106:b0:27f:cf81:cb9 with SMTP id
 a6-20020a05651c210600b0027fcf810cb9mr1864041ljq.268.1674742892727; Thu, 26
 Jan 2023 06:21:32 -0800 (PST)
MIME-Version: 1.0
References: <Yyvr.1674722117946957577.GL4y@lists.openembedded.org> <CANNYZj_ZrA5XzBkDDZa+6QoYYtizQAnu1VAMCZuh1ZVUic6gUg@mail.gmail.com>
In-Reply-To: <CANNYZj_ZrA5XzBkDDZa+6QoYYtizQAnu1VAMCZuh1ZVUic6gUg@mail.gmail.com>
From: Anton <aw@pionix.de>
Date: Thu, 26 Jan 2023 15:21:21 +0100
Message-ID: <CAMoDz1W_yqm1ZPSBwC9c9tTdpLTESUDJkpO5TrAT7pFgX5WGfA@mail.gmail.com>
Subject: Re: [bitbake-devel] Using bitbake as a native standalone package-manager
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000003627e405f32b770a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 14:21:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14347

--0000000000003627e405f32b770a
Content-Type: text/plain; charset="UTF-8"

Thank you for your reply,

can you point me onto any guide about how to create such a minimal oe-core?

best, Anton

Am Do., 26. Jan. 2023 um 09:41 Uhr schrieb Alexander Kanavin <
alex.kanavin@gmail.com>:

> You can certainly do it, but it's not a use case that is supported
> through the core layer. You need to make a minimal replacement for
> oe-core.
>

--0000000000003627e405f32b770a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Thank you for your reply,</div><div>=
<br></div><div>can you point me onto any guide about how to create such a m=
inimal oe-core?</div><div><br></div><div>best, Anton<br></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Am Do., 26. J=
an. 2023 um 09:41=C2=A0Uhr schrieb Alexander Kanavin &lt;<a href=3D"mailto:=
alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt;:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">You can certainly do it, but it&#39=
;s not a use case that is supported<br>
through the core layer. You need to make a minimal replacement for<br>
oe-core.<br>
</blockquote></div></div>

--0000000000003627e405f32b770a--

