Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77B9C3ABC0
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 08:05:31 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.3540.1746605129900713866
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 May 2025 01:05:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Lpz5iUom;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0b308856fso699363f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 May 2025 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746605128; x=1747209928; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Day+EK2xEDEhSzQ81X2qNA2flrsfzHM2rDpR7hSvd9s=;
        b=Lpz5iUom3E4ZX0bdQMdB9z+PdpWMc8kqnFYob63BpzrKw2sV0k0EzINuhbNaGroB4p
         WuRtrVrqBXD0cRfnyxgn+4CGBS1o8yKUQJfBzJQQH05GUvgfYbUbbY0UhhUtRIdzs92N
         z/bQY3iGnCaX233bnPNqXiJUFsuetjNT1Qhvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746605128; x=1747209928;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Day+EK2xEDEhSzQ81X2qNA2flrsfzHM2rDpR7hSvd9s=;
        b=uALv+XgjBDpSSM2aydQLJpgZf2lpVrNoAyJIv4PHEZovRRFJwbC7ajoZjDGrrFaxnt
         ct49iqiS1QajgJn2xER7BCR8uK8JXn9n4q29QS+hEKk1F5NFpqpBmID333SnP/U05AQO
         Q7J2tkTKu0ZcF2jBGyqBjHD65RIVCKv/QIL1CAh8n27m0XYlFh8wqtvHbM7Mcj0B7jS6
         lDOGLSrpe5/vZ+06AhK48lYQ39Ez+Ql7s9MN3HFWWb6TIQYFGyrai+22kmqRosQbHewQ
         8wXU6e2LvYymzfFe+NyManlWRs3KYpgpUU2QhIKJ4aMXwK7RgnqNHST7q65oAk6/T6P8
         XGWw==
X-Gm-Message-State: AOJu0Yw9I0Yr7ZjJ7IRZOcWVCqA6WwizsrYwv1eMiamxFwp61VVmwXb5
	DCY6tc4O5mAhWGboAfB1vCDrkVwbzPueuebSfVm0ReVTw8qUZw+IZXGDdEVC1fE=
X-Gm-Gg: ASbGncuKtpGdshR5aMhP0gh7dP3A094cZnlQIbKfZdOZzNC9ukGZTbRQuyEd9VxEURD
	Rk9Hl4gPOQAHufmZ+O8rlWi+AI/9Gfi8F1WSWeVl7l4/oqXdaExXqc116/ifBIFo6N1hWz7pukk
	NFP6HhWktsaiEW2T6j6l3nQPJSWwASgQWv7HftJtTBuZuMZSylmn+5X4Bq7ERSvL9lTgM2Tj/un
	GkNl8/LTlZQ7rUhYCNyWGlYiwL8N0UxM0dVv5qVNkiJiiiYf8Stfa8ep1OiZmsKvLcjBobqyrry
	9OlntpsdlIVsGVZ+2k/k31+heww+TdM62HDtzUBD7ZcLImnEdCLwORaV3nHGcgKpZak5BuTCqLi
	+VzfSPo1idgWEXV3bGrausb574Q+o5HFz6bIFGw==
X-Google-Smtp-Source: AGHT+IFE72pwQieGQRgLZdRNuYF1DuXO0AcvLeF+NBHTqy0VF5euV+m1ozYJA2zIbDd/LKpSsH3bEg==
X-Received: by 2002:a5d:64e8:0:b0:39c:1257:ccae with SMTP id ffacd0b85a97d-3a0b4a1c722mr1756042f8f.57.1746605127753;
        Wed, 07 May 2025 01:05:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:12c3:1543:c9e5:5d2? ([2001:8b0:aba:5f3c:12c3:1543:c9e5:5d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffb1sm16026375f8f.73.2025.05.07.01.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:05:26 -0700 (PDT)
Message-ID: <4ea9b9dcda4e5482050f472b03b69bdaf062d532.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch: Add support for
 remapping URL's
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Sawas Etairidis <setairidis@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
 Savvas Etairidis <falital@hotmail.com>
Date: Wed, 07 May 2025 09:05:26 +0100
In-Reply-To: <CAKJXz6d061e5h-_7vV6iWVj90gFvKqnKC=yRQqWaobqjvzfLgg@mail.gmail.com>
References: <20250505185755.1952-1-falital@hotmail.com>
	 <292ee69d270d71860a7ebada65e4f6aeeca01d13.camel@linuxfoundation.org>
	 <CAKJXz6d061e5h-_7vV6iWVj90gFvKqnKC=yRQqWaobqjvzfLgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 May 2025 08:05:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17598

Hi Savvas,

On Wed, 2025-05-07 at 09:28 +0200, Sawas Etairidis wrote:
> I think it would be better to not modify how PREMIRRORS and MIRRORS
> work since users already depend on them and expect them to work on
> specific way.
> Like this you can add extra rules to rewrite the source code url and
> then use=C2=A0 PREMIRRORS and MIRRORS if they exists.
> I could instead provide an example how someone could have the same
> result using PREMIRRORS if you think it is not worth having this as
> standalone feature.

Looking at the bug in question
(https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10699), the issue is
filed against the layer index and the issue in question was more about
allowing layers to list their mirror urls so that we could canonicalise
different urls.

Your patch is against bitbake itself and it is unclear if we need that
support in bitbake itself to solve that bug which was targetting a
layer index change if I understand correctly.

There is already some discussion about changing the way
PREMIRRORS/MIRRORS work for other issues and given that, I'm reluctant
to add new code paths that add complexity and do things in a different
way. I've been hoping rather than adding complexity, we could try and
simplify whilst still maintaining the different use cases we need.

Cheers,

Richard

