Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A27ACA101F
	for <webhook@archiver.kernel.org>; Sun,  7 Sep 2025 15:52:20 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.21149.1757260337147278119
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Sep 2025 08:52:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N+zjRU1w;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b9853e630so34019115e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 07 Sep 2025 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757260335; x=1757865135; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3psvyh0FnI8j3Gv3AnzmrRgkoj7SUYxRiVAhmpaxRM8=;
        b=N+zjRU1w7EoDh1qAgHQwocxYA+U+/6Hu36g1hA6LkKzTvbcekGrZNxnGXMgpSuBKvq
         9yeD39VyOfAiFtGOkJ7ylkF7nmTYihXjhl3kLWdmNUka9dkcjy9LQbiAyDeFTnM/Wi5L
         oNxp9SNRaV1s0XxyIpwl2tr9+ZLoJ7fEV8/Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757260335; x=1757865135;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3psvyh0FnI8j3Gv3AnzmrRgkoj7SUYxRiVAhmpaxRM8=;
        b=jbReLhn9zlg7YkrwHB8E97R/TujAAYvw5tqTMVOb30/0oLCgC2l0PU0pT9IaQHK33l
         CBCJX5MQJZLiPL/ZIPs5kyLCJrLIG46V9XFAvRuqifpbl6SsgMRwv4IVa4M5/jjpOdYe
         x7r9eoj+EPPduXgpxaZZ/+SYXlHaanxs9rhFOWKAVYp8GyBWszuw2IVTpFHj6Nb7db0x
         cRBlzvqPMZnhAsxnq3yBxG/qCypiE99qVFoNuMt/d1XXQOtKSzQyA12Lczc5ok02i45h
         Y6W/rWNwJ48D+eYZUesGTbhCv8o5SOAMrzzHNZCi72RW8eDijYtmRAczwsbIxliwtLxm
         EBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTTjjABwpO2c2xypU0blCSw8f7+z9nPztvj/s4ht2ZVCRFUg57LM2XZV0AX22Y13N2U27JQzwdfH/l8PTK@lists.openembedded.org
X-Gm-Message-State: AOJu0YzvlHnudlTum/OtzohdVsVaUUN2nwr8i0hCtll5paOGP8kpj4X4
	U3mwFyEP7jJ/5IsnYozihyhK1IMCqMjNzsQCpsqnu/2R33i63/XDIqsfAg7p6VnbOeY=
X-Gm-Gg: ASbGnctB3BX8z8yJKfSVFrAUb0asqwopNNylsmhhbdGIs4Nlr5h+ojF9G6SJj6lyvz6
	JoWlT5M7YQZr7KCavcksn03Bg247vWkLs7Z5WMtmG45tvO0EjfOwNmzd7hbvWa0CJdm5upilOyj
	aOtsbU/P6zwdvnBTbucOrW65Fb1wOdmU1L14WVQjFzs55nv/f5i9SiAgk9QjZaUr8czkcfRmvKR
	CcUEk5PtsCsujDWBWhDHOfhNpoAo/etpRBe5gqIdSbRN6NhooStlU2EzKTRO5Mwco/qfbuyh1MA
	XnA069q5VwT5AfJ2HG2EXMvyP6TGqf/V/lh3AAizRXH2jtiSs+C0x995FrxFLcs2cs+NJAQq7fM
	37dfFUn+YK2/dsb/hPCsvk1uSlgmhrAiS7PYat8xPL6/aSmPR+UsNLmk5ekEgX7CqwiA091xdHX
	oDOi4KHVqVpttWNwDTiRMS9g==
X-Google-Smtp-Source: AGHT+IF/PtDhiEGzVfEEMRWYGxiQ4gs6L+TgWbfZfaewQnX5Nj1wDRwirjArMoAgLB6NGoueyHbCfg==
X-Received: by 2002:a05:600c:4694:b0:45d:d908:dc02 with SMTP id 5b1f17b1804b1-45ddded9c21mr39346575e9.31.1757260335470;
        Sun, 07 Sep 2025 08:52:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1741:6852:c453:e19c? ([2001:8b0:aba:5f3c:1741:6852:c453:e19c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0752c05sm72437195e9.10.2025.09.07.08.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 08:52:14 -0700 (PDT)
Message-ID: <c1124597a57241518f4ddee17c5786ecb11caf2f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 0/6] fetch2: add support for
 implicit urls
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Sun, 07 Sep 2025 16:52:13 +0100
In-Reply-To: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
	<20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 07 Sep 2025 15:52:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17983

On Tue, 2025-09-02 at 08:55 +0200, Stefan Herbrechtsmeier via lists.openemb=
edded.org wrote:
> The patch series add support for implicit URLs inside the fetcher. The
> implicit URLs could be defined inside a source like a version control
> system (git submodule) or a lock file (package-lock.json, cargo.lock or
> go.sum). The integration of implicit URLs beside explicit URLs
> simplifies the fetcher classes and avoid bugs because of iterations
> between the Fetch and FetchMethod classes.
>=20
> The series remove most methods inside the gitsm fetcher and only leaves
> the parsing of the git submodules and the unpack functionality. It
> allows the gitsm fetcher to use the premirror only feature. The current
> implementation leads to problems because the download of the git
> submodules is triggered via the download method which is called deeply
> inside the fetcher code.

We had the discussion a while back and the conclusion seemed to be that
implict urls were disliked by a significant number of people as the
were too unclear about what was going on behind the scenes and also
made things like software manifests harder. There was a strong
preference for metadata helpers and explicit lists of components which
we have for crates/rust and now for go too.

It feels like this series is moving us back to the other direction. Is
that correct and if so, what has changed in the approach since the last
discussion?

Cheers,

Richard

