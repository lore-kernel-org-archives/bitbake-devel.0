Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16179C021AA
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 23:10:19 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.10258.1739920209526837021
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Feb 2025 15:10:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e1dx1ebj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4396d2e32b7so28184685e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 15:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739920208; x=1740525008; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqEselOcjPjIbAmObMFsq+Jf89WiWBXSIRv1s59Oyo4=;
        b=e1dx1ebjAVWg6RTdoHiZKIUR2VnSnv4zlYgR5mg6nxNMmC/6URGNUBepEuI12fCo0g
         AFLQLYkJNPVmXsA7EbQTVrcSuJ4oKvvX6RogfegRR58mhyBWjKULa1c0tl6CCDZrKfgL
         zqk9YrF0/ocLhRVaKPbjMhAeO6avmw7iEawuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739920208; x=1740525008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqEselOcjPjIbAmObMFsq+Jf89WiWBXSIRv1s59Oyo4=;
        b=MSNB3uQG0mOnKV8BiAjMVS0ojrc+UXLpyPJBDclYiksOTQAiOoph+vQEQJlq7PI6Fl
         ri8E1kHszn+kM8nAMchFoc3AIlueiCyofDDWSo1AfEjanFihykD/CGz3NdTI+RT+By5D
         O4PBnbx/KYKWTi5QX3Mtiz/qvxBz+RhGkKLzzxoPZeAXFCNJ8vFUtKNKpA7iAz6Mm2yu
         P24dJ5qw6ryjwTt57XlgK0447UmHvkRYWVnUwfk2sy2QFjLWdy2JPOAxAyN9yOIT+bQ3
         fPjglQqkwUJrDPljieUHQHH8/SolvJxBnabZ9E4wCylBVBbuIhKQnRJ/xxCp+dRdZ7r/
         pN/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtcn5nrH4K2/TT7F/flYE6R51CH4N96zgvvpX/ftcXZs2CG+A/r+et1cq+C3BFKTUQ6gow2pd2dpp3MrE+@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw5KCYOtzge4JifLNP3vfmz5xCRQPUKG6nKQlqksVvQjmOxpeme
	fN6h8sqJPm30GMpKxyMSpsOMnpZNMggHQ6ezjBGxjFNWng7yCNR8EKmExtPl5Ls=
X-Gm-Gg: ASbGncsSajDovamcvXyF6dGDeX29jXJ410NRhNhGLhJr4iEWBbNoaflQX25EIXO98aA
	QxowwXTBligyc3t1wtbh2x1dhK8LmDcWPqakHBlMohvpAAfElX71Yc0dIgkRfshprB1GKxcbhx6
	v3TBsFsOhMrT4L99w/Nf2jFuxd8zrGhw/OTvfP81rG+DOyAGwyzisPrM3aaNQQjWO8eTj32FtuQ
	zt+L0w8eAyLVQ6dLAUf7q2mOi8dC3DeQPhsiDGSnq8aHNU3Xz0MPwczonNQjoubYMZoj7NBfEHi
	WEG3I2aDVnwZ3zKasF8AxgzKDGbqQNmIZum/HQfNNd0+1Vflo/ldSENuxkH7uzGVso8etdULSyC
	Tkx/8
X-Google-Smtp-Source: AGHT+IFH0qQi7g8zb36pA9EYl0yBT4Hy63aUL9WIW+GE7Ak6R1YQxNtrMFxgWAXAHmQ7ZK7H+Poy1Q==
X-Received: by 2002:a05:600c:4ecf:b0:439:3d5c:a028 with SMTP id 5b1f17b1804b1-4396e6e842amr151837505e9.12.1739920207760;
        Tue, 18 Feb 2025 15:10:07 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1cdc:d60b:3749:b3e3? ([2001:8b0:aba:5f3c:1cdc:d60b:3749:b3e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7b68sm15940454f8f.85.2025.02.18.15.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:10:07 -0800 (PST)
Message-ID: <5f208b50fbc0976804716a11c0f230fa8ca312ae.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH 1/1] utils: pylint: clean up imports
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: michaelestner@web.de, bitbake-devel@lists.openembedded.org
Date: Tue, 18 Feb 2025 23:10:06 +0000
In-Reply-To: <20250217152953.70557-1-michaelestner@web.de>
References: <20250217152953.70557-1-michaelestner@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 23:10:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17245

On Mon, 2025-02-17 at 16:29 +0100, Michael Estner via
lists.openembedded.org wrote:
> As mentioned in the TODO file I run pylint
> and start clean code including:
> Remove double imports
> Order the imports as mentioned by pylint.
> First small patch to see if what I do
> fits the expectations.
>=20
> Signed-off-by: Michael Estner <michaelestner@web.de>
> ---
> =C2=A0lib/bb/utils.py | 10 +++-------
> =C2=A01 file changed, 3 insertions(+), 7 deletions(-)

Thanks for this. The patch itself was fine and I've merged it. I did
need to tweak the commit message itself a little bit to be more focused
on the patch and have correct line wrapping.

I was initially a bit worried as the TODO file hasn't been touched in a
long time but you did pick a sensible improvement so well done for
filtering it to something useful.

I would warn that we wouldn't necessarily act on everything suggested
by the linter, we'd prefer to focus on "real" issues. Unneeded imports
definitely fit into that category.

I'll try and find some time to clean up that TODO file a bit.

Cheers,

Richard

