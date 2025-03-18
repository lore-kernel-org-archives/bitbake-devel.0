Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B237EC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 12:16:24 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.10279.1742300182283715621
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 05:16:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZdxC4T0w;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394036c0efso21966225e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742300181; x=1742904981; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df6PpmOeT8ImXLAiusjxJ1pJaCLiIV6IEva0HpNn0fY=;
        b=ZdxC4T0wgN2ti2ZnnbUhjkt2CqSFMSVHUQtm6qHDCSoAfwPWdiicvQmqr8sTYcqeuS
         sxKyKYEtH6jOI62HivwEusYTF8GeiJeeP12Xq1lC0TLeqNGt4p5ot6SPABb1u3A4dF0i
         yiVjMuQ0SFA/M3UnS/EScjdHrf2uPdXDMhbBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300181; x=1742904981;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=df6PpmOeT8ImXLAiusjxJ1pJaCLiIV6IEva0HpNn0fY=;
        b=MRE2jYkTlaTV3ZAU9K4RH3dl/2Yv3QyP0yUuPCBks6eYTEcYho1cxiYwQV2hng7t1L
         EtdsegXAGT3HGuK0N5dwHRHExMHdTc9ygW3LauDgasOVAF8LI+vPuEItEthvKj6+xCSv
         xilhU3Dz9tMA9+Zz0fKcjf6Pcya31TBFfbJ9qCqZo7D2eWAw+UlSas5MBbxv1233jpA3
         1qcXPnLZjiX+7+hxcOvn3Mg/bZ0d6mGVcTIhTxLP5j0y+MCvmeEic9eod0VjjjOAz6sh
         0Ogb7IzpauHmix77cADVRAJqtPxJEhLoi4D4aDKhLo5jzCvkKjJSLYThRvVs6vSf6Kvx
         0Neg==
X-Forwarded-Encrypted: i=1; AJvYcCVnF0NP8S+XjOI+Q3JCmjf/NNcu754tqyRzVG68p5N+KmIUUXDoZgFvRr16rbbDPzt6FJOhOwEUPie8/MJZ@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxu13MP1SD0nR9oybqBlSLHCJTHWhzGHxejqeL+0z7OyMk1DIKk
	uUkIlGxX8sPBGjLyO5f/KdYcOXOfiR9NLENTTvcvBaaW2OgkOV2vVojMhC4A2CB2jTOOxdJez34
	w
X-Gm-Gg: ASbGncuv7d0IiD3+tfBxZbU8dWIYEeN3XEo5fozZn42J0D4R8vrLvuJHasc/WyXoFpL
	/b9t48RnWKvQ2L3U56KoLgtVBKuGHYZGJXbWzS3sPFGjHslREJx/WDvHA3C0CNgMTopEZyGIi8t
	lRVLDQ2SkhMJktZd/MHxZWQT6R6oq5WUg27aaZNlDJfxSF2zWUKks48e23znSos9cZxceUBltmH
	6fvOqvxAJsVqwVpe0gl0sAdYOPtZm+Rk3SmIT4Qr/pWJ5uF/NeKj4KTnWKH/HyPWCEngPiwMxYv
	Ar9oUnR0aO6s23It3d9A3tHNcGnaykigxsYBF1NhSG49YLVCaACd6SNid7gFIdGKxshPHgI+A82
	7Emkasij4817eUSGdqmwgqt6JYbuMVjmtOw==
X-Google-Smtp-Source: AGHT+IG4N0qwpew7xsmlNzZOrSg5hyuAnOrISf0mwIF2C8Sk3tDBXa/9hveNiRBO7FGnlSzJAYREhQ==
X-Received: by 2002:a05:600c:1d2a:b0:43d:1c3:cb2e with SMTP id 5b1f17b1804b1-43d3b9a4268mr23435895e9.17.1742300180531;
        Tue, 18 Mar 2025 05:16:20 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:791f:f4e7:28a8:7096? ([2001:8b0:aba:5f3c:791f:f4e7:28a8:7096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb62c1sm133564635e9.4.2025.03.18.05.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:16:19 -0700 (PDT)
Message-ID: <cd1694281d8b3186b2feb4733a857f1fb1cde9cb.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/get: Rework tag parameter handling
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Marko, Peter" <Peter.Marko@siemens.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 18 Mar 2025 12:16:19 +0000
In-Reply-To: <182DE3FED35CF57D.22901@lists.openembedded.org>
References: <20250318110743.3936601-1-richard.purdie@linuxfoundation.org>
		 <AS1PR10MB5697EA94CD905C93AF76CD38FDDE2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
	 <182DE3FED35CF57D.22901@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 12:16:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17456

On Tue, 2025-03-18 at 12:01 +0000, Richard Purdie via lists.openembedded.or=
g wrote:
> On Tue, 2025-03-18 at 11:52 +0000, Marko, Peter wrote:
> > Hello Richard,
> >=20
> > I think this will break git shallow tarballs.
> > Those (at least in scarthgap) don't contain tags so the check will fail=
 during unpack.
>=20
> In that case we may need to add something to ensure that any tags for
> the commits in the shallow clone are present.

I've sent a patch which I think allows this to work.

Cheers,

Richard

