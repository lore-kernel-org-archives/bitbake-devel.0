Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63344D690FC
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 11:34:47 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.92827.1732793677724767931
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Nov 2024 03:34:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iY25BunS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so6411975e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Nov 2024 03:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732793675; x=1733398475; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EX3FTqOSRCPli3rJc3v/BDoOBqSDIaoDjHxloGNIzdc=;
        b=iY25BunSNM/6zaXG8h73SFlduQFcT62rMQC9/5LZ+rv8HJ+uyqmC9GELYLy3mR8TL5
         nqXe5XghEpzUGQGWh6EWrUnMeOyU2vWyrKkuNXMC38OHYg0Km3bkPedUmqe+5UK/Sl0T
         sO1aTjX3f3KrBTjvUyZVPly72ng5K6K2AMlgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732793675; x=1733398475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EX3FTqOSRCPli3rJc3v/BDoOBqSDIaoDjHxloGNIzdc=;
        b=Wh3CHjxZ6p4dXdvpjX2jZWkRAvQS16PrHy9BDsdxWEXNkFPuc9z/x+1ii7FK9glAyT
         eN03GxerjVFd7vC4EVUEQ93+uArNNBREvkOsd59uuwENxcQJNKig91Y8DzubgsRKJ3CB
         JhElPTX/N0+veAAArXLPG4efjNifdB6kFEQ7ok+K3YnjIQqMcjD0K4OGJfjfDVcVKuu3
         xMKMQwx6k5vQhzGjw4tApYxn2RmC6NKg0jYybKXrIu225tRGHFCxn2337LkGOlAYJPjW
         9yQWQCjHcSgob+9tTNXKVy045b1UInaCaTsZJfx2WODe+JzxVXShG+JWfNNt7xDAKeMJ
         1v6A==
X-Forwarded-Encrypted: i=1; AJvYcCUZzwQqcnGJ+bqnrueQsZm3UVocC1pzxcul8AuG6k/kxMqWztn+dKR97wsER+6v1xsLih9gwAUgKH717SIs@lists.openembedded.org
X-Gm-Message-State: AOJu0YzaHVkUBz1khBcztUSnUy+KIn0vNYz8XIPGmEbvy7n1TF7e89Yg
	nrFGMHaud6Lg4xBjhaDOCCKJuBF2nQjcRnpQMMBNPB4STJ+beuoCWhdoR/E11Ek=
X-Gm-Gg: ASbGncsZhZHStaF/sENfSbvUhnJX9Ip1wzr13m/nvfkMEsBQelzHlUOrSHWl5AcBmwc
	va5Prj0FcAbcHEwjzmIjAuUmx355BJMZf8ClsBMNUaBnjljCDO7HuKnEQqS4kYdYe8cmB1Z/VBH
	9ILh7tM03VSEVkEl/HDIzLeQyhJKUtmC0Ehb+x+MKoqzipx2y2QegWKVXxJW75Ylh/RPZIT744v
	6r+IkEn8fkJeaGEt+6PFzL+3if3XHSouLTNz6et/cuOHWLSyII2xIf9Td6RcUmGas0vvbcMxhmf
	ZTxUgJcOcRADk0MWw4S23hv+/WaTTFr/AtJI+3Y=
X-Google-Smtp-Source: AGHT+IFyIowxUe3fSzU/B6NXFg3A5a6dH6tU4AJnS5oIKsMAXwex6AKepm+OKI4K2cUABiPFK7JVPw==
X-Received: by 2002:a05:600c:3b24:b0:434:a75b:5f59 with SMTP id 5b1f17b1804b1-434a9dbb06cmr72859805e9.3.1732793675510;
        Thu, 28 Nov 2024 03:34:35 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:930d:1506:79bd:20bc? ([2001:8b0:aba:5f3c:930d:1506:79bd:20bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f325fdsm19704965e9.30.2024.11.28.03.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:34:34 -0800 (PST)
Message-ID: <3ea5c511a8f0dcb930de62ae60cfd7ed0c6e00d2.camel@linuxfoundation.org>
Subject: Re: [2.8][PATCH] fetch2/git: Use quote from shlex, not pipes
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Steve Sakoman <steve@sakoman.com>
Date: Thu, 28 Nov 2024 11:34:33 +0000
In-Reply-To: <20241128081341.2190513-1-martin.jansa@gmail.com>
References: <20241128081341.2190513-1-martin.jansa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Nov 2024 11:34:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16845

On Thu, 2024-11-28 at 09:13 +0100, Martin Jansa wrote:
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> The pipes module is removed in python 3.13. It was already using the
> quote function from shlex so use that directly instead.
>=20
> The module already imports shlex too so it is an easy substitution.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> =C2=A0lib/bb/fetch2/git.py | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)

I've put that on the branch and will let Steve pick it up from there
for poky.

Cheers,

Richard

