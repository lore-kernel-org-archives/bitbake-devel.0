Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444B1C83030
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 21:40:49 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.4158.1751924444070340771
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Jul 2025 14:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RLYs/Ytz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453398e90e9so25023785e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Jul 2025 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751924442; x=1752529242; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZksvnzKKMnvuqHeZ90EFwbge557n3BZAwvRDVAmjcQM=;
        b=RLYs/YtzCNhHqQYe1yKJZcdPsIT9nkuY+EAnQyZnYWA4JbFHQKhy3MrHh20Y7AihwL
         WkAhd3xFbx7ENysLKm2Ujac6MsoxaOEqvJR0Uox+PKmDZsE5O+bjS2L13gY2SSNGtkDN
         4t3SoJzPiFO8J3kkgI2QPQhG217WVu7CpL7mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924442; x=1752529242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZksvnzKKMnvuqHeZ90EFwbge557n3BZAwvRDVAmjcQM=;
        b=KI5NfEjUqPKHB0uTfgYm/5fQUh7FWCGOb+RXj4+y+2DwZl+q0JfkJEcxmCm/MQs8Sc
         Jg+FLFnSbjOaNVpTmCg5asOA0JTzyN/S5HxtmmVQLAbZ4Sutuz92WSeiNVA0SW3PKc74
         TppseAItk8jCRSNf4CPPGfdS0qAGthgXpPMd68ttPj3d4+uG1+WLhkUfuhPEup4BXJjV
         Dg/+kOl0XcV9edgACKufhSS7RlTd0bPnexl77JxuInBFgz33anlLm4sC//x2V+XdIgBo
         MYYN/OXbeJf55uiyW7ifkBd24tBnOMo22bk/g+gomNEqmvtghpkn0jOmF5o+NH3mzF/n
         7cZQ==
X-Gm-Message-State: AOJu0YzDCpd4Ju9u4GtL1YsKQbYimE2VkDUrscjbn6WdiU32L+Cz9Ikq
	p91xAg2HOi+fhgIp3ZcZ7UvpZShEacXX/eKfPSb4iOEfIXK5sNixKe64JhSfqJdu6UMsDuD0G9j
	VWUHH
X-Gm-Gg: ASbGncuEs/t8wKI1Jn0PNErBKxWOUScKkOVOtz38arSvhlsOqem2sAXqhOgrzrFNJDQ
	KtOkYiuRROz7X5rwr6MmQBiioOow0VaQyoIPVgujlOJEcWFB0om6daCuE+Sq3P/xvyn/nHkDmyt
	SonvuBf6ij/2OJ3wshHuELheNqUeBYWiEaiuJPBCu7rBVgI6uY6eh9hKaGQShOPV282IAkopOiV
	QaNTYklGQ4JFtrIYdxFlfXe14R8BWFkVW7jr2wIa5BoFkYo61kWIe0vn8qRMNX1w/WGD5Lby5AR
	5zjjG62Pglq04G2bHvcDM1u65UjR8UzK/jxkKWPtvkWqJK1JwVLtl70b8a2+kYQU/caKrchKM+u
	F5XiPRfltdtmBqD0x4d7QJtPvxU5SQo/0tyhxGtJyugQRRpToBF0=
X-Google-Smtp-Source: AGHT+IHbbf7E/dq5mmpQi7cDgckg0qqLQ5uZocVOVbYKjkiAhwvYD4w1acSpkrdqfq6nwJbMaJhC6g==
X-Received: by 2002:a05:6000:5c8:b0:3b3:9cb4:43f9 with SMTP id ffacd0b85a97d-3b4964c0a82mr10326272f8f.16.1751924441968;
        Mon, 07 Jul 2025 14:40:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f30e:ae60:b271:f9d2? ([2001:8b0:aba:5f3c:f30e:ae60:b271:f9d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bc5asm11161027f8f.20.2025.07.07.14.40.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 14:40:41 -0700 (PDT)
Message-ID: <7b41f7172a2a3f67cb6a21d1bcb816601e923eed.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] cooker: Use a queue to feed parsing
 jobs
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 07 Jul 2025 22:40:40 +0100
In-Reply-To: <184FFC262D6E2196.11046@lists.openembedded.org>
References: <184FFC262D6E2196.11046@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Jul 2025 21:40:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17753

On Mon, 2025-07-07 at 14:46 +0100, Richard Purdie via lists.openembedded.or=
g wrote:
> Curerntly, recipes to parse are split into equal groups and passed to
> each parse thread at the start of parsing. We can replace this with
> a queue and collect a new job as each parsing process becomes idle
> to better spread load in the case of slow parsing jobs.
>=20
> Some of the data we need has to be passed in at fork time since it
> can't be pickled, so the job to parse is only referenced as an index
> in that list.
>=20
> This should better spread load for slow to parse recipes such as those
> with many class extensions.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> =C2=A0lib/bb/cooker.py | 33 +++++++++++++++++++++------------
> =C2=A01 file changed, 21 insertions(+), 12 deletions(-)

Sadly this is still wrong and adds delays to parser shutdown. I'll
continue to try and work out how to make everything work together.

Cheers,

Richard

