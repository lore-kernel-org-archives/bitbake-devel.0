Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FCEC4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 16:58:24 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.19657.1670691493525795659
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 10 Dec 2022 08:58:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=VAAReD3E;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id b3so11834258lfv.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 10 Dec 2022 08:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oPyvvdd2pxR3/cjyOOGfpimObNquqjrrXXZ93VnV4rg=;
        b=VAAReD3ENQFT5HnW2Zx4gwiMv7CDHNSNVxtmjJX14WOK305yUSLl1QwQ7qLa9OcdxO
         oxDxeYN03TbUWyc1M+cf6wLT3UJXayTdoouNCW4LrQ+ttm3AVkhLgQY5aCd2w8Ya0064
         eE57OfnF3a6BmF8pO98sQVuxxubAc7sBSMH076c2uyu5UsSsI3Q9jGX2UEE9C8lO+fox
         hQwH1UvSq4RO5cUC1+T2N8L0iOFFviW7funKKKw0+SXrd1CP1gIvl9TJoplZ34KYRDpY
         gncNyTtsRMievU4JGUohi5fwPBR0CkhLGQfUVSg05HDJ/bZLPA0nFPk/NqbmXgSIllWT
         OfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPyvvdd2pxR3/cjyOOGfpimObNquqjrrXXZ93VnV4rg=;
        b=B6i++hHZWCeO2YPJARTl+5Q+QzTvp0te1udX6UZhdgD6xMn9gu74m6UC227WRYkYFf
         wsnaIYI7HNaVgSzl6JzTBOOt0urLjcIL/JFgFCWufh+HV9zBk1TQZE87dpqmaoACp5DU
         1K1lML1kMdpt0WXLz7HwRthyNM6s9yYptEx6hTGHmHrrKVlZ4KIJMsZ9P9wZjlXKxnzY
         oydg1Mcmhu2b4eFQhlsVO/FHVBQQmO0a742PXeArYqATAmfRMJOb+iSy1UI93m1V7WlC
         j+xRi0Z7ZevmA0t4Am1R6uJ1iMKPlr2tGdc9b2OVFyKb6OesPgZSqSoqLGSUoicrmY//
         yW3Q==
X-Gm-Message-State: ANoB5plnufB7RdoLiNsYfbupfYDyxFO+Y0hEPp4wYWeWvNQlooM2ivBY
	tsy4JVY7D+WLwreyZfCjH94ztoxzrX7sSO/SzoM=
X-Google-Smtp-Source: AA0mqf7Sv/LYJGslqL2gqlCwiRtiLKvvow8qe1bRFpbpHG2m+q7sbo62M7lXlRSCR2cBPeg97vmXp3l1w4ZXnsFuIiA=
X-Received: by 2002:ac2:4c47:0:b0:4a2:4d53:8294 with SMTP id
 o7-20020ac24c47000000b004a24d538294mr29441360lfk.263.1670691491728; Sat, 10
 Dec 2022 08:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20221209085840.3733809-1-alex@linutronix.de> <Y5NJPlVxNR7kQsG1@mail.local>
 <CANNYZj_WLrfAUWjDu1Bqd+MTc+JO9p7YMH0qaQMFpe212Bx=0A@mail.gmail.com>
 <Y5NLdKDFJXGo7X/R@mail.local> <CANNYZj8yB7ThFEnssxReBi919zrN6qqbtNQR=psKYioCNYJqQQ@mail.gmail.com>
 <172F29E70A8CA3CF.5373@lists.openembedded.org> <Y5Sr9HSWIc5LVzl9@mail.local>
In-Reply-To: <Y5Sr9HSWIc5LVzl9@mail.local>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 10 Dec 2022 17:58:00 +0100
Message-ID: <CANNYZj-25E_7MN9waDi68pEb0ttkXXXNekX3Kinpa+Gc4mLsgg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/wget.py: correctly match
 versioned directories
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexander Kanavin <alex@linutronix.de>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e4d2bb05ef7c2c21"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 10 Dec 2022 16:58:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14168

--000000000000e4d2bb05ef7c2c21
Content-Type: text/plain; charset="UTF-8"

On Sat 10. Dec 2022 at 16.55, Alexandre Belloni <
alexandre.belloni@bootlin.com> wrote:

>
> Note that the issue is that you are sending a patch for poky which then
> doesn't apply properly on bitbake
>

I don't understand how it's ending up partially applied though. The part
that modifies existing files is applied correctly, but the part that adds
new files - in the same directory as the modified files - is not.

Alex

--000000000000e4d2bb05ef7c2c21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>On Sat 10. Dec 2022 at 16.55, Alexandre Belloni &lt;<=
a href=3D"mailto:alexandre.belloni@bootlin.com" target=3D"_blank">alexandre=
.belloni@bootlin.com</a>&gt; wrote:<br></div><div><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-color=
:rgb(204,204,204)" dir=3D"auto"><br>
Note that the issue is that you are sending a patch for poky which then<br>
doesn&#39;t apply properly on bitbake<br></blockquote></div><div class=3D"g=
mail_quote"><br></div><div class=3D"gmail_quote">I don&#39;t understand how=
 it&#39;s ending up partially applied though. The part that modifies existi=
ng files is applied correctly, but the part that adds new files - in the sa=
me directory as the modified files - is not.</div><div class=3D"gmail_quote=
"><br></div><div class=3D"gmail_quote">Alex<br></div></div>
</div>

--000000000000e4d2bb05ef7c2c21--

