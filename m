Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64640C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 12:50:28 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.128959.1680699021586234939
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 05:50:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=fu+2ZyIm;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id a11so37175325lji.6
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680699020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzquxmSXcut6nqmvks9tqckwxVaneuly2PvIzc+Z3Cg=;
        b=fu+2ZyImEOTF4EcswtsOB2Cr2XaWZ8yGZ16f+91iFUyhl7yYCwcnfw8RAWtv8hS/tB
         32Kr4LqTu4ZN6Vv+uBUR+AkNI7ELo2yV+DVJ64m6m+H7AwphWONKTnlUYLqrXy9yIkvm
         LIJJGs+4edYMlNmGlW2vtSx8r+py2SM/rQpLD4/WyRobJohUPAyiJmYFvyAK36IBVItQ
         FNMgZQqgkaA7kizcG2yQ7HLgs2pLoxEqwzWWUBskj/TJMHf1qoshIozPdyuWv4+xyjIh
         hZw+mDLDFhoDC2AD+iMdDMNcHkBnEz/FkbhuYVts1+1U1UEilA+BPQIGvCK3atE/lYwA
         Lo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680699020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzquxmSXcut6nqmvks9tqckwxVaneuly2PvIzc+Z3Cg=;
        b=R6wHrcIbf4yJ8vuSAxKu1OZQqIDD7mw1EbMfkYmlWpPrMwEz2l/VqW2w9juj4oyqWZ
         kOSAI1N2aTsXSeDP4IUBzbmwAB+Z2Maz7XrKRh8mbm05eXMQwoS28LvAC1ji4j/y2Ljd
         y8Z12I9w/JZDpd6R2wxgN6c1JFRq9wmMB2mT7XlbAnL6zpkqCQGlw/ZAV19MwwqGQQEg
         RcWMkCiDpvt96s3yv4XXa8nBbehYD0jLKrNDq0s00blG7M05qwp0sFa1/SfvOg6o5CEH
         5clkb8GwG3BVQojoq1GMiLUmTNrfRsLccDu4B0gDxaTvpyXrBKmhlNGSI2PErzaGqZCH
         59dg==
X-Gm-Message-State: AAQBX9f/22Ia4v3S5plS/p3BWm1PUfeE6DZwP2y5q2CovN6Akz/bC5J0
	Fdfwhd1qlK+fXpmuO7Fv/xmYuodGH8K5txenlpo=
X-Google-Smtp-Source: AKy350YwDMU3GywVZx2jJQcaOzFcXLY8AkuPPs8l8iIaaZ7FmyD4RObseQ9aDArjvNw7e9cb+Ws7AqT7TBsqmaOmHO8=
X-Received: by 2002:a05:651c:546:b0:2a2:35dd:4b30 with SMTP id
 q6-20020a05651c054600b002a235dd4b30mr1048027ljp.3.1680699019577; Wed, 05 Apr
 2023 05:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
 <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
 <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de>
In-Reply-To: <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 5 Apr 2023 14:50:08 +0200
Message-ID: <CA+cAkeowGLd7K7b3kkvaVcE8=4b_Tx-WeAfFuddu+TZ9_9KtgA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name' entries
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000094d7205f8963cd2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 12:50:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14656

--000000000000094d7205f8963cd2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It remains the problem with zvariant recipe in meta-selftest layer but I'll
let others answer since they may have a bigger picture on that

Le mer. 5 avr. 2023, 14:24, Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
a =C3=A9crit :

> Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com> writes:
>
> > A rust project must have a Cargo.lock in its source (
> >
> https://doc.rust-lang.org/cargo/faq.html#why-do-binaries-have-cargolock-i=
n-version-control-but-not-libraries
>
> It is recommended (due to documentation issues), but not required.
>
>
> Enrico
>

--000000000000094d7205f8963cd2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It remains the problem with zvariant recipe in meta-selft=
est layer but I&#39;ll let others answer since they may have a bigger pictu=
re on that=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Le mer. 5 avr. 2023, 14:24, Enrico Scholz &lt;<a href=3D"ma=
ilto:enrico.scholz@sigma-chemnitz.de">enrico.scholz@sigma-chemnitz.de</a>&g=
t; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Fr=C3=A9d=C3=
=A9ric Martinsons &lt;<a href=3D"mailto:frederic.martinsons@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">frederic.martinsons@gmail.com</a>&gt; writ=
es:<br>
<br>
&gt; A rust project must have a Cargo.lock in its source (<br>
&gt; <a href=3D"https://doc.rust-lang.org/cargo/faq.html#why-do-binaries-ha=
ve-cargolock-in-version-control-but-not-libraries" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">https://doc.rust-lang.org/cargo/faq.html#why-do-bin=
aries-have-cargolock-in-version-control-but-not-libraries</a><br>
<br>
It is recommended (due to documentation issues), but not required.<br>
<br>
<br>
Enrico<br>
</blockquote></div>

--000000000000094d7205f8963cd2--

