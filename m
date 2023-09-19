Return-Path: <insu0.park@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C177CD342F
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 00:43:10 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.7800.1695084180875546196
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Sep 2023 17:43:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=noBvWrSd;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: insu0.park@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-64cca551ae2so30534306d6.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 17:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695084180; x=1695688980; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z+gbOZ99pgUP3XhvT+eZlaggE6ZW8jMS42XPhhNyh74=;
        b=noBvWrSdwy/rokPmAeSJoEZ49NZ4yIawqa/vyIfeqRbGgbYZOzrkKr0/3Qj+7+kSoL
         QakfROMiEHZ15DslBSgK+QUtSMmIBzQCEoWbisW8qtGPH24ItOC1nm659caCyu7Y6dHF
         Vv9q62J87HC4V+p03iSqI5BpFZEv++4fdTqqouH+Fp2mUPr5pnPHd2el/KwLcbhgWkrA
         H18N+/Oy5CAiZCtz9tYWJY2caI9b3aaZQWZvTN4Dfi10ZPDPetv2rQJSJy7ZmNI49XRl
         1Ok5W4363xR3u9OF2NWmveIHVVnGxRZ0JEc0cb7vUDIPN/OukWNTuU/2OFNEq/pIy6lO
         iY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695084180; x=1695688980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+gbOZ99pgUP3XhvT+eZlaggE6ZW8jMS42XPhhNyh74=;
        b=BAnTBL1twqHpqZLNmbO0rZyB80U72jifI8MVeX23aD/fcPnyzY5CK1IpP71BxvkgSm
         uhav3JPsGyIvrKNSM5OAg/aKR3L8V+RGNH5Tmx6jDKCoOdouwVr1y+6WF9jhrXvKjqEj
         oHh1sQH5z0xDPPigPSnNdbeg0zBAO0sgqEvUFEXnVJeE7W/vN8bzrCOueSoS7zsViQZv
         uLO2ki6UsAsdbQqEL9wv/UpuojJEpOMjLlj96pFzTQUMiKVGXz1B+5Y6SHeZBMBJVJHl
         eRaDsksedmJSNE20Q9noMLrawjtufUSpeAULSWuCLWTGK4yGZ505xW4gZw32+A15Pg8Z
         Fgrg==
X-Gm-Message-State: AOJu0YxwLLDI/DTxBR/kCDtXSyIUdeVaUAhkNUfcNi97kuYs6i/p1bFS
	CtdiIlc7YOou1aVbx7zROp9/colkf8OSU7RR8Kk=
X-Google-Smtp-Source: AGHT+IEEesYThXTM87iiLtqee8j4F1JON1KZ0UFW26iJLSJRJ6MzWEmDevKa41SpOiqeA36KA4NNFlKtcp5yQnbDu68=
X-Received: by 2002:a0c:fac1:0:b0:655:87a1:49c4 with SMTP id
 p1-20020a0cfac1000000b0065587a149c4mr10837179qvo.39.1695084179965; Mon, 18
 Sep 2023 17:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230918090522.659869-1-insu0.park@gmail.com> <0b769953cf43aaaaf13e335550b42ca0fe7b44f6.camel@linuxfoundation.org>
In-Reply-To: <0b769953cf43aaaaf13e335550b42ca0fe7b44f6.camel@linuxfoundation.org>
From: Insu Park <insu0.park@gmail.com>
Date: Tue, 19 Sep 2023 09:42:47 +0900
Message-ID: <CAAoCe3E4zyO3_rNXs3yiLaUBXuz2gYqEnkDmMNuKjj0+QbR7XQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/1] Fix dependency handling bug of
 :remove operation
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000069498e0605ab8a44"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Sep 2023 00:43:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15081

--00000000000069498e0605ab8a44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 7:02=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> This looks reasonable to fix but before we do, I'd like to ensure that
> there are tests for it added to lib/bb/tests/ (run with bitbake-
> selftest). Could you have a look and see if you could add them please?
>
> This is to ensure we don't regress this corner case in future.
>
> Thanks,
>
> Richard
>

All right. I will post v2 soon.

Thanks,
Insu

--00000000000069498e0605ab8a44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Sep 18, 2023 at 7:02=E2=80=AFPM Richard Pu=
rdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_b=
lank" rel=3D"noreferrer">richard.purdie@linuxfoundation.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
This looks reasonable to fix but before we do, I&#39;d like to ensure that<=
br>
there are tests for it added to lib/bb/tests/ (run with bitbake-<br>
selftest). Could you have a look and see if you could add them please?<br>
<br>
This is to ensure we don&#39;t regress this corner case in future.<br>
<br>
Thanks,<br>
<br>
Richard<br></blockquote><div><br></div><div>All right. I will post v2 soon.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=
=3D"auto">Insu</div></div></div></div>

--00000000000069498e0605ab8a44--

