Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04686CAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 09:19:43 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web11.15152.1758014376697809625
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 02:19:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WKXGOMHS;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7240eb21ccaso58044226d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014376; x=1758619176; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuSedzuIaMyPic+Sfp3wJms2dCfXg8QG/1WFudMCbrk=;
        b=WKXGOMHSj9yJXs9Ww/bVQguj4x1tMADCoy+KduaAIaiSaiw/QFXN6v/KxDMCNrGgIH
         +aeLJS7QRuQUVHqAVfxO88GyfXrVoCO27J7jRLPC5cI7y180jBAyrQ8t88VKtwccdXVQ
         oeTpbzgpk63bafK3+QG6Q8TqBF1vfioquWNxSL4Xghxc5vJQkuRS+4s6yGPH5CaH44ei
         CNP1Cfai4eyuBGaqlInaDmhoe/b7FcOo4tnQw4J0CWMZIyY08E75EajgkAaztUJcSbtT
         1/NILZ/3POuS7RejBX7dokeL4nB/SaiR81ih8KHsjy8DzawIenoOBkrAuCPFEEfosH01
         2ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014376; x=1758619176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuSedzuIaMyPic+Sfp3wJms2dCfXg8QG/1WFudMCbrk=;
        b=jDlWhNOCqsZ0rTWAUHMaOo+kMHR7dHRX2tys5oPfNpjanOI4fpe+WHv8HvLYBXUyXE
         BYb/o/KnYCaWknIHk0a65TbcLfMshnw7sDUWKM42XR78oDg/CjcYXCLeejOF8Bx/7V9G
         BMEFCauW7DrxezovQGin0hKytmTVNvvque0ONU7byKLj1xh7+0LHC55JuCAilJqJT99L
         2RfSn4hGlfQykb0JY5tkp7dh5oEGw/mHEfOL7+QFjbV79goLN/XrEjB+MOXyrn0QIkDA
         AT8jGgYgSyC8lc0mURz4yK8ylT8JTRrZCbw8/d2LgcNggaXAS/eS+DXbzRwlhWgDwUUk
         EfRA==
X-Forwarded-Encrypted: i=1; AJvYcCXt+FAuZuwjdCW66AFA8fT2dyBlp/3/FwboWeeb8+B9zKMduN85OLejPinj/q0PspBb3U+1O0rFMNB3fmzu@lists.openembedded.org
X-Gm-Message-State: AOJu0YzmqmTSAg5zker5hkj9gM5ixuZK2weGikcb0CcJvcC2B+VacoW7
	u/t9y+zElJCqv8SuWVxRDN+lhwGt+EYiORUJ9Nso0QW7gSa6IzlCyDEjEy8uWPAIzKtJTk6XFDy
	CYD75ojbSNeLbnSVqrJsJhYOi5aAxd1E=
X-Gm-Gg: ASbGncvbMQ+Wu7iqyEDz632CEefA2SdUiqwuya2euIBX4t81wlxnYivYoNfQzgR68sk
	894bs/Y+X9mxTcrrNX1fyPoUzqoBjzJ519OATHTP8s0kqKqM0Tp6JWCewKImSHokOfeX4j+zJxI
	E4qgUGxn94eP9cOH67WGDeqIEHezfZXEFLyrgNiSK5MOuKZxEvXXbMQYZIJDLKVJEStvWiyLtne
	1uU8JJ4fRp2jxv0oFe/oFXcOOnvr8jIF70WI76scrYjdjd/APOOU0VCoU1SGo/qXAilIqh6edvI
	Ffp2P0YZxdMMxB5vrdlxZGh5PH6+BGq5jBDcU8xR
X-Google-Smtp-Source: AGHT+IGJIQ3NnojqPAAamDYh7l4mzLZeIrX3Y2i+67IgGHRexiioOz8KXisF2ix8fGpFm+F58XDWHAhN8gdm+S+DiEM=
X-Received: by 2002:ad4:5d46:0:b0:78d:4452:754d with SMTP id
 6a1803df08f44-78d5d83f435mr15218306d6.13.1758014375710; Tue, 16 Sep 2025
 02:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250912204559.10360-1-reatmon@ti.com> <20250912204559.10360-3-reatmon@ti.com>
 <18656C3B10F3AB3F.17447@lists.openembedded.org>
In-Reply-To: <18656C3B10F3AB3F.17447@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 16 Sep 2025 11:19:24 +0200
X-Gm-Features: AS18NWACLBpeNpa3_EV8vnpQHzumK9GNPgAS1qds-oIxf8bleHOCBLpTNIhKZFs
Message-ID: <CANNYZj9aHpQ+zUpBpsSrO2AFAy6eYc-hS8JHXqaOhG0PqLpTJw@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH 3/3] bitbake-setup: Add
 --build-dir-style to init
To: alex.kanavin@gmail.com
Cc: reatmon@ti.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 09:19:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18041

On Mon, 15 Sept 2025 at 11:57, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> For the 'config' and 'options' styles, I'd just replace them with
> explicit --build-dir-name=<name> option which will just let users
> specify whatever they like.

This was trivial to add, so I just went and did it. Will arrive in the
usual weekly rollup of fixes (or I will push to github at some point
after looking at some other requests I'm getting).

Alex

