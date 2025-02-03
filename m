Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F140C02196
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:40:22 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.94070.1738604412358891550
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Feb 2025 09:40:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UzrogjG7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so32718665e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1738604411; x=1739209211; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqYI22Cl/rYhmU8Omt7PGu3bpAVLuyhl4ScrVDwIJvM=;
        b=UzrogjG7VZ+juAyU+VxWspEDvHyN3bur1dqPHdXcChpJw9mX4umNWoXOe1GjBzvH58
         T/th7AsE57pBG9riafGc+ZUm5RUuGedpKgb5PNipMTOWeLBt3P1FwJGBorrQSVhA5Dwz
         Ar2IFmD59pQ3ZSqHp9I6AFwQUXu3WwnrO/AiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738604411; x=1739209211;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqYI22Cl/rYhmU8Omt7PGu3bpAVLuyhl4ScrVDwIJvM=;
        b=sSmracnOolKiHgwTG/5AKMJ4H3jNq6AOEwrWPNPkIDrxy1sXbiomWWxaumuw7vAva8
         wgsC9f52NRwP6gMNYCooNn3S5DMlhLVHfAwoNDZPmvxiyrqrYoMaJORYlnaov5eyyTNK
         Kv41A2GN4lf2Ofj6GaZDi6IQ9ENs8YcvmQq9pBv7Sa98Vl4heUja7y+ibyj8OZfUa5Uc
         1YB7C8fM9NRViKDuTP9vTs0oD+fb0dzz8NFbuZtLJiFu9wsUSlV//r50lV+b9i0T3SRe
         xuKPpnXY7Sw153XiwTog0zdBMyW50aZMO0io1NQ404ufqU+RzNsz+X/LZSUmi9mbzrCU
         TTrw==
X-Forwarded-Encrypted: i=1; AJvYcCVd+8wPljd9VY250twKIkPiH6Jli0E7/O3+IIGkQrdpWp9MUIrh/TJtAscAQNCuGDMWnd88uxtvJ+F7lbUh@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz3roD590gGT1qCw8xyn+cPEZUYgLm4REqrZQS/E5MlRlCRr6gl
	cJ9Z73S3FWSrLezcX48lWGdhpmJ1VHr2TtxKjXNiqt3/l1F1KlsZdheD25glHdw=
X-Gm-Gg: ASbGncvOI9wn23ixWnjvECgxKEGWnJjHkCNbIdPYPUGMcxpL2FeLAUM7Wtd2yAanrg+
	oZ/UgrC7XwnHLfaIuB+qNIMnLZvdYQiIAsEeHbfL1mwBmTnNoQm1fOZmBGxqs5lh+utDlUbX/0O
	1OotU3rGWk8cec/OYPQP6QoxFdkFcz334PsGlWeErhebxqcBRMfQes7FE/UBhZ11akrI6DQ6HJ2
	k9UKOXbbAKs5SjWYtSTQgW6K88USrqDvj+jDPmNtFkiJOJjJP63fIsN80BCD8UIq/4uzNqPCwxz
	SfIJZ85LUIeNw6eQZ/ALrOoWX+k1zABKvqQltwV4sgCqTj2rH4bVcJDlKaJer2F/NBgrtEyI0bj
	PgL4D
X-Google-Smtp-Source: AGHT+IFfJjFtxOeRmwUXpUefOwdYJPQjw4XFnd+pOdRoIgWfjUyavcSYbqapev0U2J0YaU1WP56zhQ==
X-Received: by 2002:a05:600c:c87:b0:434:f1e9:afb3 with SMTP id 5b1f17b1804b1-438e0d879fdmr163419555e9.3.1738604410812;
        Mon, 03 Feb 2025 09:40:10 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:41c1:3919:865f:692c? ([2001:8b0:aba:5f3c:41c1:3919:865f:692c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc6df36sm205279525e9.25.2025.02.03.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:40:10 -0800 (PST)
Message-ID: <25ed9291b59922108451bdec071f56efea34dec3.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: Forbid ambiguous assignments to
 ${.}, ${+}, and ${:} variables
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Nikolai Merinov <n.merinov@inango-systems.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 03 Feb 2025 17:40:09 +0000
In-Reply-To: <20250203164235.1503956-1-n.merinov@inango-systems.com>
References: 
	<fc1891e201b3baaefb86c7c5f27202bc86ac171d.camel@linuxfoundation.org>
	 <20250203164235.1503956-1-n.merinov@inango-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Feb 2025 17:40:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17126

Hi Nikolai,

On Mon, 2025-02-03 at 18:42 +0200, Nikolai Merinov wrote:
> Hi Richard,
>=20
> > I'm worried that if we do what you patch does, we're complicating
> > the
> > code and potentially setting ourselves up for other new interesting
> > future problems.
>=20
> How about moving complicated part out of regular expression?
>=20
> Please take a look to the second version of the patch.

I prefer that version thanks!

If we can tweak the test name, I think we can merge that and I'll
continue to think about whether we should make the whitespace parsing
stricter.

Cheers,

Richard

