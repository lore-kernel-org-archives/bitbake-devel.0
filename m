Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383CCC433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 07:59:54 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by mx.groups.io with SMTP id smtpd.web12.41932.1636358393009365879
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Nov 2021 23:59:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=REk3/JKY;
 spf=pass (domain: gmail.com, ip: 209.85.221.179,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-vk1-f179.google.com with SMTP id t127so7721521vke.13
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Nov 2021 23:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tEo+LTSZTOMAf4it5ZjSZvBfEXjUo56Uget7/R/8h0=;
        b=REk3/JKY8nb7HbYsC961bh6c9OYKpMuLmtCQQ0bcbqAd7IvBLC1F5oE9FbGY+i9Wfj
         G8YS/tejVYxLjMBg+UD5h/u5jk9u82QH4+6lO2R6fwQ1QLzs6zCUwc6HoZupRBHU8LGd
         icfTuMEcTGVf/50eEfFkQz01NzHTX0jwocfIpxJRGg+/7t5ZysY0qPGfakw1hNfzzDJp
         EntvkIE7yHO1nEW8v6DmDVQNRhjDD9N9ExN2jamkR6eATXTOvGk3TrGfnuNvdZSaR+Up
         YBUVzER4qHTONYRnxec3xEEZ+Pe/DYiKd8kkxcOIi9gCiZDMBfcXHtm35CE2AYA1BDJj
         1E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tEo+LTSZTOMAf4it5ZjSZvBfEXjUo56Uget7/R/8h0=;
        b=nYCOmtYhH0pvC3Oucr/avXMm3o8NEcLNeAM1cglt0ngB1BUnlQBcYvgALGHSimVDDT
         G2YMHQdxumaqq2rS5yHz/zLCv29z9wG4TI/8D+qhyNrQjK1yonrIUUTMloJ0vOnNdzbe
         KXrzfthjXgtYxA57L/GEo4evioIHswD9ZoX3NQGc4krlf00APV8jCXWrChTYdiXNYR0+
         2gkAC5DANwGbjxUr3XgshN46H+FBqe1l27WatKijZ1s5C3zd1HKmYz/FZdjU7Gio6aPW
         0YWSQWVDePapu48T6z1EQqeJZtN7uovWM4DX9K7rzfcKg9UWjOi7OxM8rCRKhv0A+3rs
         whdQ==
X-Gm-Message-State: AOAM530snJjq1SGoFKqCxfXktvDnMptQoa+dEPKcB6jBuAR7R1vyrWx6
	liEAkbsAKHmBUYe1D6LtNjztzLZK9KFgrwqJDA0=
X-Google-Smtp-Source: 
 ABdhPJwFtQUNkiikt6yHCTVMa//N9++Nyu51MGdx9FE/2ueHEBUsBT6D/c6a0SLngA36nHeCyilSWnAAQ7/th+l2kiY=
X-Received: by 2002:a05:6122:a18:: with SMTP id
 24mr84449543vkn.6.1636358392196;
 Sun, 07 Nov 2021 23:59:52 -0800 (PST)
MIME-Version: 1.0
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <0b63fba531fc94bbe915dfc9915c0a2f42ad3ce9.camel@linuxfoundation.org>
 <42a0350d-991a-731d-29c2-83cd62da8c7b@weidmueller.com>
 <CAAdc0hwA12CiWHCXQV=MBHv-h=vopK7of3CUViR58fJ8k2rK1g@mail.gmail.com>
 <3556fec928b8b3f86c1a08b3cb4e2a2fb708cc9c.camel@iris-sensing.com>
 <5fb67154d576b74629e4836a86dcb5e479b73e67.camel@linuxfoundation.org>
 <6c13452e-77cc-6cd5-8d3d-0e2128663286@weidmueller.com>
In-Reply-To: <6c13452e-77cc-6cd5-8d3d-0e2128663286@weidmueller.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 8 Nov 2021 08:59:40 +0100
Message-ID: 
 <CANNYZj8=w5WZ50=thLn_c+DQDyTqd9j_C_m0j_WdTewi+Upt3w@mail.gmail.com>
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	"jeanmarie.lemetayer@gmail.com" <jeanmarie.lemetayer@gmail.com>,
	"bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
	Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>
Content-Type: multipart/alternative; boundary="000000000000b130ef05d04260c6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 07:59:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12930

--000000000000b130ef05d04260c6
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Nov 2021 at 08:41, Stefan Herbrechtsmeier <
stefan.herbrechtsmeier-oss@weidmueller.com> wrote:

> > Also, I did realise the npm fetcher tests simply don't work anymore.
> They're not
> > run as standard as our infrastructure didn't have npm on it to run the
> tests so
> > they have bitrotted :(.
>
> Is it possible to add the nodejs recipe to the core?
>

I don't think it's eligible (the criteria for core is 'broadly useful for
embedded use cases', which nodejs is clearly not ;). I think the question
should be 'is it possible to run nodejs tests on the autobuilder so it
doesn't regress', and to that the answer is 'yes'.

Alex

Alex

--000000000000b130ef05d04260c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, 8 Nov 2021 at 08:41, Stefan Herbrechtsmeier &lt;<a href=3D"m=
ailto:stefan.herbrechtsmeier-oss@weidmueller.com">stefan.herbrechtsmeier-os=
s@weidmueller.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">&gt; Also, I did realise the npm fetcher tests simply don&=
#39;t work anymore. They&#39;re not<br>
&gt; run as standard as our infrastructure didn&#39;t have npm on it to run=
 the tests so<br>
&gt; they have bitrotted :(.<br>
<br>
Is it possible to add the nodejs recipe to the core?<br></blockquote></div>=
<div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">I don&#39;t=
 think it&#39;s eligible (the criteria for core is &#39;broadly useful for =
embedded use cases&#39;, which nodejs is clearly not ;). I think the questi=
on should be &#39;is it possible to run nodejs tests on the autobuilder so =
it doesn&#39;t regress&#39;, and to that the answer is &#39;yes&#39;.</div>=
<div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Alex<br></d=
iv><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Alex<br>=
</div></div>

--000000000000b130ef05d04260c6--

