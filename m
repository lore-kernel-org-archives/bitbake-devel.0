Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DE0C021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 15:51:33 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.11518.1740498687048718097
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 07:51:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l+oxJTzq;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e670d29644so44261196d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 07:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740498686; x=1741103486; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ozs09132RFs1tlplPVW7nJ8VhVJNV/6xnQHDPcLCHZg=;
        b=l+oxJTzqeLpNnoJLuLi6ruvFi0MymJ42GhLG4IdwctIzEjVHooPGj2GQeHww+m/xAM
         bywT+OdHcq9t0D/FW5+aed4fzC0qRfDi6godVNRpuolWmdbJOq9DKVzyMPdPhhNbddWM
         QFaYIIyndRMnFcheT+S1I6+f7okr2tTUVn8ELFIjPBRugUA1Wk1vuZqQmvVb8aTA5fL0
         HEpm5TvSaB5X4yFZ/p29ptK73UEr+mqER41emR7vwcnGJZULXpZNvqLlrl7D4OHSQfgJ
         B5PiebP/Lr9kHGFbWbN+Xev1IlMhMFmU4arj5rKSeBYzxpIM1v/VP7bz6Y0AG6R1CpdB
         vNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740498686; x=1741103486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ozs09132RFs1tlplPVW7nJ8VhVJNV/6xnQHDPcLCHZg=;
        b=asEk+/vqZ4/zklFOCCrk/ASsSjc1OLuqluviDoOUP3wpsOAQ6PtGRRH/AN68SG4Zda
         GSe4Qb7krNWg8QXSDVHgbm1I3FQhijxhB+5+7egpTOxB61AkjN63hcTHvPabkxXGIEcQ
         OXS2a9/PrRJSSr6G/JCOyOzRx8FfTtSk664qVG+N3zLn9lQ+UkcfT+Pp+0iEsukgLsjk
         hGjRk1mCh2BM9WuN5mkFN02fdmBfZKfZRPLCm25Mg5737IZp3mGVIiSz5oLvO6aFh8iM
         cQzkNgXQ/505VeZUyWyXsyu1RGeE2DPJ9mQRcAfvQoTiShpUE1/aZRaQ6RlRrpokCccx
         xx5g==
X-Gm-Message-State: AOJu0Yy9M7NaP6qWJjOe3Vdmw411HMDhwzCXsIaaqRLL6A/IAblJdNtJ
	H5wCamOmK3DV0hQE4jMx8Zh5OKHriIaK900jdtyLMMRqW+Eug31i6Xl5fSQ5uggwaVwtLG7i+Jx
	nSWFn8dZaGPfmklFOKKq5+cMiYA0=
X-Gm-Gg: ASbGnctPThKmo0ZSG0Klm7C3Bu1E+xIO3PN7uSCge6oxYmSG75CHWk6EyIUKoSIVPuQ
	mM1iUxvQsPuxWQkAVpZGh3heZ5Z7f02NOqLrliYU/Iu9Ymw7233Rnk4FRyhkGyllpwXDpzgZczC
	qQ546EnaL7DNT/51e7zwzL24eTEZreZBwRohZD9G2b5Q==
X-Google-Smtp-Source: AGHT+IG7VcnhLT35jvPNP37GNPPjWHXKfsik0O7sZDCjybbliGMUkp5J4mbBPQMZJu7dYul9jIaUZx+bAhf33q8GSWo=
X-Received: by 2002:a05:6214:194c:b0:6e6:5d9a:9171 with SMTP id
 6a1803df08f44-6e6b00fc43bmr281177416d6.23.1740498686056; Tue, 25 Feb 2025
 07:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20250225120947.172025-1-alex.kanavin@gmail.com> <b4e76037f4fff35822a2f80888587fe6cb124953.camel@linuxfoundation.org>
In-Reply-To: <b4e76037f4fff35822a2f80888587fe6cb124953.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 25 Feb 2025 16:51:13 +0100
X-Gm-Features: AQ5f1JojmWxahd0fQl8PQ6FTnmv9dlyp2TWmQYW7utQ6Z7xPgAT4BKDvuuuv2TY
Message-ID: <CANNYZj-CJyEwaVQtowyo7ynk=mP1D6461NZACS73wcx9xKX4cQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/cooker.py: make
 BB_HASHSERVE_UPSTREAM issues fatal, write specific error messages
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 15:51:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17318

On Tue, 25 Feb 2025 at 14:46, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> I agree we should split the messages and I'm ok with making ImportError
> fatal but I'm not sure we should change ConnectionError as it means a
> single connection failure to an overloaded server will abort the build.
> We've seen this problem before which is why it is a warning.

Sure, I can tweak this.

> We can't really reference oe-core from bitbake unfortunately either.
> We'd probably need to link to docs at that point.

Here I'm not sure how to rephrase. We can't mention oe-core at all? Or
is it okay to say smth like

"Install the missing module on the build host. If you are using
bitbake with oe-core, you can also use buildtools" etc.

If you can give me a canned error message that I can copy paste,
that'd be best :D

Alex

