Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C166DC433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Dec 2021 11:28:41 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web08.65750.1638876519296771943
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Dec 2021 03:28:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=TKELa0Ge;
 spf=pass (domain: gmail.com, ip: 209.85.222.54,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f54.google.com with SMTP id n6so25912917uak.1
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Dec 2021 03:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSkPNiHci7TX+igTUMMJixzckh9u7xZGoVs7ChyuYgc=;
        b=TKELa0GeyMIedUZ4K+HqJX4g4QX5Xmz5MwnlEAbssmgoGWGpUjpO+61GMjOAvbjo9t
         I5dqX4hTKIAuph6SffUkzTGu4hIE+CiQ4jJW7Mgl1XABOgONqFmqiqyFI1PxR9ThtnAG
         ijEv2eUIfS6bIvtyhLQw+CX+eFDzcIkW7pA7lM6Q80JlA19+BorOFA3bJ9nGUm/hCiTM
         Aek6lZU9lnAwQiIUZW2Atye8akwdMraF0mnR8XsjpVVd6B1+7I2LYNJdBSoBpcWgyqMv
         OcH/wxvYmZBU5acLnjp83At+vWZSGCT8qxAjgtNScDkG+aP+zBRRf11ZwuJwYd1cDCU7
         LK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSkPNiHci7TX+igTUMMJixzckh9u7xZGoVs7ChyuYgc=;
        b=eVKIVvQRvwy3gCt+vTKd2QLvaPDkJyr1+xwT+KwWEW1HWbj1jgzZe30MUvbfIz4TKj
         +qNADCybvrzK2zlwofaL4mINKhPx01lZ/rNTAqKNS/j5zcW3RgUTKR9HAHCZFMXQpzgp
         jHD6ebgw8bbW7gOmLyM7yfTKmjdesHuQHvpm2Ql20/k8rKVGr4Rcpc2ioHvf8FUdqnEQ
         cyf2O9GJYGdDQkthHRKe2cI7Hd3mmfI92E89ntg5noMczINORUAAYgtf1v5Me3B+Z7KX
         9rwyTpNu+KhM5irmFt0f1UHwaN1f+ijJCgmwZ/It25mAkh4lKduzo7A7YAKE1hnRnOQA
         li1A==
X-Gm-Message-State: AOAM530VVwbCDw9PstGGlkQLxPBLBYWA5NqkzOM7N9hw4EuUvvqjEAG8
	J1MeGPasWy8KawivT0iFgXILnlIzFh3K1q0m8NQ=
X-Google-Smtp-Source: 
 ABdhPJyq3G/L+iq+HQ39fxffHwMMlOeIDyNS9zX+slGQejUSk2+M71Ljcspr3PtmuLWe2Rj9wq00NQg05KdEcSQK/cw=
X-Received: by 2002:a05:6102:3232:: with SMTP id
 x18mr43423849vsf.38.1638876518358;
 Tue, 07 Dec 2021 03:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20211206164119.4076119-1-alex@linutronix.de>
 <4ff493233f785384ac845b2b712388155a328bab.camel@linuxfoundation.org>
 <CANNYZj-=TU6QNRDE4u13cc28F_PxnzCeMSd7txRh6N2pMTmspw@mail.gmail.com>
 <3600232f440e8a1a1caed9a57f0105a02f38e6df.camel@linuxfoundation.org>
In-Reply-To: 
 <3600232f440e8a1a1caed9a57f0105a02f38e6df.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 7 Dec 2021 12:28:27 +0100
Message-ID: 
 <CANNYZj-7+8_qFEisJeQzAx4uUhRFGGcWdcX3TX5HuwU1kM6gSQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: do not hardcode tarball
 compressors in version check
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000b5239405d28cac1e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Dec 2021 11:28:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13140

--000000000000b5239405d28cac1e
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Dec 2021 at 11:24, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> The issue was a .orig.tar.XXX so perhaps we're missing a test for that
> though?
>
> I appreciate we can't cover everything, my worry is that if we change this
> code
> again, we may lose this corner case...
>

The issue was that orig.tar.gz was covered by the regex (as it was
explicitly listed), but orig.tar.bz2 was not. The test already checks
various .tar.XXX suffixes, so I don't think there's much value in also
adding .orig.tar.XXX and stable.tar.XXX and src.tar.XXX checks. They've all
been changed to use \w (i.e. alphanumeric suffix).

Alex

--000000000000b5239405d28cac1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, 7 Dec 2021 at 11:24, Richard Purdie &lt;<a href=3D"mailto:ri=
chard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
The issue was a .orig.tar.XXX so perhaps we&#39;re missing a test for that =
though?<br>
<br>
I appreciate we can&#39;t cover everything, my worry is that if we change t=
his code<br>
again, we may lose this corner case...<br></blockquote></div><div class=3D"=
gmail_quote"><br></div><div class=3D"gmail_quote">The issue was that orig.t=
ar.gz was covered by the regex (as it was explicitly listed), but orig.tar.=
bz2 was not. The test already checks various .tar.XXX suffixes, so I don&#3=
9;t think there&#39;s much value in also adding .orig.tar.XXX and stable.ta=
r.XXX and src.tar.XXX checks. They&#39;ve all been changed to use \w (i.e. =
alphanumeric suffix).<br></div><div class=3D"gmail_quote"><br></div><div cl=
ass=3D"gmail_quote">Alex<br></div></div>

--000000000000b5239405d28cac1e--

