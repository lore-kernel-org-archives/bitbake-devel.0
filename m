Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C4DC433FE
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 18:45:27 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web09.9791.1636137927060759096
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 11:45:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Q0JU2ktv;
 spf=pass (domain: gmail.com, ip: 209.85.222.54,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f54.google.com with SMTP id s13so3262392uaj.11;
        Fri, 05 Nov 2021 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k12EYiZt2TJZze+0DnVwUY9cDlO0VgFvLTVaOCA234Q=;
        b=Q0JU2ktvNFv0UIt+Mv44PlI5bo50lKRroSydWT7OsAswD9LxPpmXYpBv2p89bs9PXe
         ZxYEbTugfwCE+BEY03eF3CkU0yUpM5B926i3jaNRuQgYk+XBbqqzXqn4FCPNhSKlb+lK
         AHjSXOTealLAZlGM5UWwmogodmEIzNXHRlanbPuOsROGiFXO8kyI+yGnNrBX6YvlJ7Zl
         SY5YcdRdp94WstQGt150qf1F02aaX5lc+BuyykKk+nC2CBPKIOcQaawDHsYdsN364D8t
         PRd+XFLokah83QDDeDg/AICsHI7RWgLnonym7cw1EQIde4utj1uvdxdEyMRcb0Qzn+Cm
         4keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k12EYiZt2TJZze+0DnVwUY9cDlO0VgFvLTVaOCA234Q=;
        b=njxGzN+BLqcvNh3LM4uVP79bZdZH9HehiwmbPmcMcXMApw824h0HxDEMkEyO+8LSJR
         GWam5t4UMhXGqqMQtTSniOLw9DbxuRBJM0oiRV7MkSLUd/rmH33VrexpfW8XW31b88hu
         vsLvlKFdUL0em9dD0PxiLpJ6+NSOz4xliUoC72jbydVAJANIJhLZybI222Zufa3sCXGU
         NhZkZLxSrBQM216QflpOfPK+Z2G5m4mrCmmWGLdjYoOKRRHU/qeRi/3GDegy6pJj/p9m
         FZBlxyeNI6mf3wbmB6jq5ALoSnu1E9wl5iw68rS7vnJAkL6BCUh1W33XwOrxS7zDW9h6
         CIPw==
X-Gm-Message-State: AOAM5333yvkADkDNpHf7/U/kSvsrxN5FuSKNYHrLIqUEbNqybE+OXZ6Z
	4AGZTnB6c5pqS1D8gjZmEGdDaagCh4/mKUBFTW4=
X-Google-Smtp-Source: 
 ABdhPJzZ4jmtTodW1jwsSoMvwjQxjdsx1jnKOyzr2JkWZFK/HG2MnPio1GCUeCeO/10JEcnXKp/WWjRfwraHWnzcccw=
X-Received: by 2002:a67:c511:: with SMTP id e17mr16601470vsk.40.1636137926245;
 Fri, 05 Nov 2021 11:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211105133104.19895-1-jasper@fancydomain.eu>
 <CANNYZj_s8_PkKfMQnBxNZLs-p0F5xb4StCXiF84OkbE5zpptqw@mail.gmail.com>
 <ea3f24549a6e54f880e925e8f5cf6128fc5629f9.camel@iris-sensing.com>
 <CANNYZj9sxmakRNGKUuH+ZAWDMJs2EhKT5O4f8HRxd=ovhQPpug@mail.gmail.com>
 <281CD8F4-9B15-40A6-9AAE-F2C0D633E5AD@fancydomain.eu>
In-Reply-To: <281CD8F4-9B15-40A6-9AAE-F2C0D633E5AD@fancydomain.eu>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 5 Nov 2021 19:45:14 +0100
Message-ID: 
 <CANNYZj-pKjvRT+Y39mT-t3G+GBON0Z=xZFURJH8AhPGfjOf7yw@mail.gmail.com>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
To: Jasper Orschulko <jasper@fancydomain.eu>
Cc: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	"openembedded-core@lists.openembedded.org"
 <openembedded-core@lists.openembedded.org>,
	"martin@mko.dev" <martin@mko.dev>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000e5bfeb05d00f0b12"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 18:45:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12918

--000000000000e5bfeb05d00f0b12
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Nov 2021 at 19:05, Jasper Orschulko <jasper@fancydomain.eu> wrote:

>
> But that is exactly what we are doing, by integrating the repo fetcher
> into the yocto workflow, thus improving the yocto tooling :)
> Why reinvent the wheel, when you can reuse whats already there? You
> wouldn't reinvent git just for yocto, would you?
>

What I mean is that I would try harder to find a workable setup while
keeping the recipes for individual items that need to be built.
For instance, devtool is capable of updating source revisions in recipes
automatically, it may not work exactly as you want, but that can be fixed.
Yes, repo itself is not proprietary, but your organizational workflow is.

Particularly this:
"if you want to create another version with different cmake flags, you
would have to create copies of all 50ish recipes"
looks odd. Why would you make copies? Just set the needed flags with a
variable that is set from a global config,
perhaps the distro or local.conf.

Alex

--000000000000e5bfeb05d00f0b12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, 5 Nov 2021 at 19:05, Jasper Orschulko &lt;<a href=3D"mailto:=
jasper@fancydomain.eu">jasper@fancydomain.eu</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div><br>But that is exactly wh=
at we are doing, by integrating the repo fetcher into the yocto workflow, t=
hus improving the yocto tooling :)<br>Why reinvent the wheel, when you can =
reuse whats already there? You wouldn&#39;t reinvent git just for yocto, wo=
uld you?<br></div></blockquote><div><br></div>What I mean is that I would t=
ry harder to find a workable setup while keeping the recipes for individual=
 items that need to be built. <br></div><div class=3D"gmail_quote">For inst=
ance, devtool is capable of updating source revisions in recipes automatica=
lly, it may not work exactly as you want, but that can be fixed.<br></div><=
div class=3D"gmail_quote">Yes, repo itself is not proprietary, but your org=
anizational workflow is.<br></div><div class=3D"gmail_quote"><br></div><div=
 class=3D"gmail_quote">Particularly this:</div><div class=3D"gmail_quote">&=
quot;if you want to create another version with different cmake flags, you =
would have to create copies of all 50ish recipes&quot;</div><div class=3D"g=
mail_quote">looks odd. Why would you make copies? Just set the needed flags=
 with a variable that is set from a global config,</div><div class=3D"gmail=
_quote">perhaps the distro or local.conf.</div><div class=3D"gmail_quote"><=
br></div><div class=3D"gmail_quote">Alex<br></div></div>

--000000000000e5bfeb05d00f0b12--

