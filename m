Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E7C77B60
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 17:08:13 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.107965.1680628091646009043
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Apr 2023 10:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20210112 header.b=e2CmC5zr;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id d17so33544173wrb.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680628090; x=1683220090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVahIwqz21EmBAyMeh8OYsuKEP/3JO+QYYs/wkg7aSg=;
        b=e2CmC5zri05wzp8IIkzfJqutIURHdBFedSz7GcbjKZIJYDyk4ax72FzEc5aDY2XOR8
         +38mFAaF8pEhs9sFCBbL+unTxJIc85tQPnc1F/GR68jgDqjkojym1Bcz6GIvYMHQmBGd
         mPtU5v2CgAni2lohgyL/IXxZgqHqRUxAqm6e6apmWR6FViqbimfkehaj5tbo5U8StZVP
         LjJl2QiYIF3BkVSTBYalO2EfjssQbWvnsE49lUzGqau0h6TWvvb4f9EQL7SHr02duqGE
         g91vyVqJWoGzR0xmcmFE3I+t0DI09wqmzG3uqAsCoUJhu4SWpsd+EtypjVemq0XGINJR
         aNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628090; x=1683220090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVahIwqz21EmBAyMeh8OYsuKEP/3JO+QYYs/wkg7aSg=;
        b=znu+2e/oY8SceImjKs15eYVBn+4weAQS4Qiw9kEnFJSeSIEcOY6Ad0ffAUrnSblGZz
         I3YyxllrUMqt9Uzvxh7FyDnlmsZEQ4QoLINTIRbBg58Ud9iki1mhIwkOmGdlUj5qka+Z
         janGe2OLH/3f2qCkbrvTZnLldGMNdyD54nJdiCElpiQ7IG90QBFbrIkiq1qz1HCEiF8M
         GuKBNqi6/HBKGmztp32ArHFS0cUvf3VEKBX3L7XWtWPcs0SZAQjyMrvjYD1MbHcI3ERB
         taPW6kQf3q2hcL0mxO2OkIiYY3k5wMLx99lSmc0DWrr1i+5NmnBeRGlZk3+DBJeaagDU
         g/GQ==
X-Gm-Message-State: AAQBX9cSD3gOiGEuWItLIpzORXK5iqou0Wq17szeJwiKgQDkLA8WKfGy
	ElAxQVNYu+ofsD+7u3eILSsgkxaMEGOOaE3DU6g=
X-Google-Smtp-Source: AKy350Z6KnSkt4TQRCbo3wa+DA5+MbPZTa+4ebGj8aUe9cUeCDFgCIn2mPiTu/y1XPHZRMv/E6v6sMNUplBGY2zV8Qg=
X-Received: by 2002:adf:fd8d:0:b0:2e4:c513:5835 with SMTP id
 d13-20020adffd8d000000b002e4c5135835mr602940wrr.1.1680628090026; Tue, 04 Apr
 2023 10:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230401152101.19037-1-frederic.martinsons@gmail.com> <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
In-Reply-To: <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 4 Apr 2023 19:07:52 +0200
Message-ID: <CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at once
To: akuster <akuster@mvista.com>
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004e3d1e05f885b8b4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 17:08:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14633

--0000000000004e3d1e05f885b8b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 4, 2023 at 6:50=E2=80=AFPM akuster <akuster@mvista.com> wrote:

>
>
> On 4/1/23 11:21 AM, Frederic Martinsons wrote:
> > From: Frederic Martinsons <frederic.martinsons@gmail.com>
> >
> > Instead of only display the first and stop.
> > For recipe (crago based) that can contains several artifacts
> > to fetch with their checksum, it will particularly handy
> > to display all of missing one.
> >
> > An example of error message would be
>
> I am confused. Is this patch supposed to add the pkg version or not?  I
> am not seeing any. Any ideas?
>

name parameter with pkg version was added to bbclass in:
https://git.openembedded.org/openembedded-core/commit/?id=3D1795e98a04ad09b=
011afcc7cc3bf6dc49475b19a

this change only allows all missing/incorrect checksums to be showsn at the
same time, instead of one checksum per do_fetch failure.

--0000000000004e3d1e05f885b8b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Apr 4, 2023 at 6:50=E2=80=AFPM ak=
uster &lt;<a href=3D"mailto:akuster@mvista.com">akuster@mvista.com</a>&gt; =
wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br>
<br>
On 4/1/23 11:21 AM, Frederic Martinsons wrote:<br>
&gt; From: Frederic Martinsons &lt;<a href=3D"mailto:frederic.martinsons@gm=
ail.com" target=3D"_blank">frederic.martinsons@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Instead of only display the first and stop.<br>
&gt; For recipe (crago based) that can contains several artifacts<br>
&gt; to fetch with their checksum, it will particularly handy<br>
&gt; to display all of missing one.<br>
&gt;<br>
&gt; An example of error message would be<br>
<br>
I am confused. Is this patch supposed to add the pkg version or not?=C2=A0 =
I <br>
am not seeing any. Any ideas?<br></blockquote><div><br></div><div>name para=
meter with pkg version was added to bbclass in:</div><div><a href=3D"https:=
//git.openembedded.org/openembedded-core/commit/?id=3D1795e98a04ad09b011afc=
c7cc3bf6dc49475b19a">https://git.openembedded.org/openembedded-core/commit/=
?id=3D1795e98a04ad09b011afcc7cc3bf6dc49475b19a</a><br></div><div><br></div>=
<div>this change only allows all missing/incorrect checksums to be showsn a=
t the same time, instead of one checksum per do_fetch failure.</div></div><=
/div>

--0000000000004e3d1e05f885b8b4--

