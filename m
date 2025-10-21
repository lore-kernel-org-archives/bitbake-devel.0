Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579CECCD1B9
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 19:13:57 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.21629.1761074035448391896
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Oct 2025 12:13:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CYgtZcwU;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87dcb1dd50cso81684316d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761074034; x=1761678834; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yauaNG9V4wP4DOtdfnaMaJV67I78ln617lO1Xzg1o0=;
        b=CYgtZcwUz67TsXG+JZHwQhcY6dT30CxuQP0tQFnZiastuj4exvUaYjKYstgXP3Rv+g
         dOvzYQVkxIMm91G/TDKTQdf8yCfNZ1yzR7Zfq64q/wisbovXMRyGZRZ17BsR6TE85vBL
         mStrpWKKUVZFaXWWYoYbqch7u4zlv3A+ho/ZLLF4OVz27E7h+bmQrq4fUpuelZrOMK5z
         LaOJIq79++oHxd2wu/3X63PuwZ0P0AnLibF/WgvxdlZH5QQBYm9MJqrAd+sIjFVJBGme
         htOfHBmWKpeXz6ajb2ilwe+dSJoDiDIXBX9dMxgVqy08ahxFmsuYs5mLQb18E1iRE7te
         3b7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074034; x=1761678834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yauaNG9V4wP4DOtdfnaMaJV67I78ln617lO1Xzg1o0=;
        b=NN64ZEv4rdM1ePXXPpMH0+rUNu4UNdAbdUKJecGPsEqoVjDl7cE6WJ5mWfqEdTy7RA
         JPpitgCa8TCLdRF8FqSFGrWUgoLu3yxMJcqpvdXKiar4uLrnF+FLKKdoXx7Lzp3qg4cp
         y43+55Fdh5OH/Vp7tcCUEpgqEs7MiDpHWeqUdf+gubPdrQIrWLkr92CR5+DckXBAXQ+K
         3fG+L9x/M0o8PuKaM2DoUdaPzG8RyeZYoMQoKzDdloNHPsxrnNsQM1UXV3490CyKXO+7
         lmFYJ2C82ekFfeUB/b2PO2X5+viTJZqgc6yapBRYOIvm9T5GE1+yLnyRYvA17jWIVrjM
         l5YA==
X-Gm-Message-State: AOJu0Yy63huWi9oZa1Gfb87WDKSftRN9GxYs91OJbvMIgiF+PoTsrF6w
	hRUyBshwrd77uBa/OOb2ccgn5Q8JmaYqqnVqWDfjhAYthcPREd0qIGAXiFA19Xp9rHOsc0XJwGi
	OkNY+MRGB3x5VGt1155naKKaZOkJnPHaQrw==
X-Gm-Gg: ASbGnctrqo4EIY0/1opNS12YxKdlmxEOHI0MkhUAm4cizCPRhmvHolpPp8EAsyhG+/P
	Gy8QVooiJqllM3i1mmcuge5F9IwqSqgEbOSswoaVNLDFydW1joMEZT5l+hAE0G+g2imArzyc4NJ
	POQl4uFgqnS+dX7X+Gf295Ykk+CMYMSjjkIycZPYqY8Dy/JsIL6539dfXIORGBV9zPCiBRTEIUY
	sPqWOpgUFXk8+5IAcDiL31FQbYMm1vMJmRIuYwqZMBiAg3YDqQRHV9YrR5hPMOMj3DsPKlygo/+
	nuMYly1T/lTixnCIKo/YPtFgYtxp7CWcQFQ1iNqMlZwye/CJzAMxhNXCjRgf+M+kcSrBUgN5WLk
	94l4yVgVY31HMAPyK2w==
X-Google-Smtp-Source: AGHT+IEqzpf87MNNaxtsAAdW4QtFOgufYR4V1ntzGcCiId+PSAi69E85aBimvgCMUxSlUx8WvsSQRM363xOxQgBvE2Q=
X-Received: by 2002:a05:6214:2686:b0:87c:2847:f7bf with SMTP id
 6a1803df08f44-87c2847f8a7mr199218906d6.17.1761074034463; Tue, 21 Oct 2025
 12:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251021182834.11403-1-adam.blank.g@gmail.com>
 <20251021182834.11403-2-adam.blank.g@gmail.com> <CANNYZj89auY9L+aeYNuRpxBqV0kX=3pmDMVx8w8+diAuoQuMMQ@mail.gmail.com>
 <CAFAffzy7rhcF5mxRUhX8kyRz3pezVEA9oSAD5Ukt5ax=ZsL=xA@mail.gmail.com>
In-Reply-To: <CAFAffzy7rhcF5mxRUhX8kyRz3pezVEA9oSAD5Ukt5ax=ZsL=xA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 21 Oct 2025 21:13:42 +0200
X-Gm-Features: AS18NWAgiAcVNPZpyAXeH6I3GYdZzVs3tgClGnUhNi3XdcYnpgQYxfWw9LmsR1E
Message-ID: <CANNYZj9y7VoyCCdz2v6eGyy=bpazPUPRR-eYMGQgs2mkk2GiyQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] doc: bitbake-user-manual: describe
 UNPACKDIR in fetching
To: Adam Blank <adam.blank.g@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 19:13:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18203

On Tue, 21 Oct 2025 at 20:59, Adam Blank <adam.blank.g@gmail.com> wrote:
> Yes, of course you are right. That being said, I must say it is truly dif=
ficult to grasp the convention used in Bitbake's manual. One time an oe-cor=
e class is referenced by name in a note, or an example, the other time the =
same thing is explicitly discouraged :-) One time an abstract, non oe-core =
example is requested, the other time a specific oe-core variable is used, w=
hile an abstract one would fit just as well.

Yes, the documentation is not perfect. Neverthless, bitbake docs
should describe only what is implemented in bitbake itself, and strive
to use abstract examples.

Alex

