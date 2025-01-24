Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEBC02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 15:59:44 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.15634.1737734378852224131
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jan 2025 07:59:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JVSzl2x+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862f32a33eso1173988f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 07:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737734377; x=1738339177; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au22/V+QssyGrN6f3dNFNbkLARVgDOYOxHT8eKedp2M=;
        b=JVSzl2x+UMYXtUhCb4aMQuOtddMj7H/cBjbxsrSHijoUiHVaeeZ/tc63WYLjwoVQSt
         Q35RlF/edwA0ESMoNzeVpAVBs1VC8vTxG5WshrUicvRnqyv4WU9ARfL6iC/FY8a1VUEj
         sT6xXbHDPAADUhPPiRViqDhwYrM4t2SiPE4bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734377; x=1738339177;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=au22/V+QssyGrN6f3dNFNbkLARVgDOYOxHT8eKedp2M=;
        b=NsRXUG3QbyDnqXxCKdlmN+e1DPlwAi366qcQmiCttoEzKVZAn1jpHl84cT+6KONhuO
         Z1V3JMogy8YWj04ZLFpDqQHbrcphf2kNJCseeksjARGRnCv9u6BRcSg4iDuRMcFdl/Rn
         yhsJ8SCu1jPwrqXE8oftheK08XXmqZUMAfv/Xus3UfEaSCuE378C9RuNZz/6M3dEB/7k
         rFTjrDgUke3dKPmrrJBILCzI7XGJZ1WzTLHxaUBASxFZ+ZhPrz0nOEQGD1VOoAnixXPz
         4vGoZwGfyyhw6CXqaWRSwBX3esYcyIK1ff88sr3uQOwLuAQX+HdgwKVU9VnDoUMujq5o
         B9RA==
X-Forwarded-Encrypted: i=1; AJvYcCXshy5iVexUJg3Q2JB2C/7YbbG4AzLXBYnCWNQBkSM0HzyxjRzCvtQ3pPs3uow1pMOYSU5dx7iOoLOcxl/a@lists.openembedded.org
X-Gm-Message-State: AOJu0YypWMqOGg0pmFXRfUyjEVG9jVODzY7XmJEM2aKIvsJ5tQuManiN
	J+JipgYVRSYYgdNaiypHGS34frNvizjOOrPwsVgf60Ly1OEgYZUEQawHvVfkCOk=
X-Gm-Gg: ASbGncvUrJBUTwl6C6lq6pIHspIUMRuIjTWGyuLIXAMOw5u4Pi8KCaFM1FQZ7o0l9f0
	fZv/w1qHIiMzthg7WGZrI8/1gcEeEYDZN6YDo17WDQbuR/gYE94icLruuItrOAI5EarT8jFE70Z
	2cPm6gCy+R/VYj+Ag8JyQd0QOsJ9HnuwFuwA+QJqCaExANkficOynUNcPlQRJobPqPM0jlA+3E7
	igvxSmuydE32QVX0uR769IzJMAbO+7OK2ZLv99ZazXg29f88Sj2j/VZUC4OMHP7R3gYmX2SVrWQ
	2yzcXz3oaQbC/4+wnLdfMhk9oaGJtkN8gsDMpC/uPwsJC9OTHgcmnmBwmN63zC85LIYERA==
X-Google-Smtp-Source: AGHT+IFoKXYKjbnqTruXlgxixYtKJYY4JIvGrRiTxO7dgBuqjoGu2HG8hUWHUgFGU+K5i+G6Wcux2Q==
X-Received: by 2002:a5d:6d86:0:b0:38a:518d:97b with SMTP id ffacd0b85a97d-38bf564d0c7mr27548980f8f.11.1737734377172;
        Fri, 24 Jan 2025 07:59:37 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6369:e73e:59c4:8223? ([2001:8b0:aba:5f3c:6369:e73e:59c4:8223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb057sm3088321f8f.62.2025.01.24.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:59:36 -0800 (PST)
Message-ID: <3bce45168a692ca4c740d41d761275f760420bdb.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] runqueue: add 'default' mc
 translation to mcdepends
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mark.hatle@kernel.crashing.org, bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jan 2025 15:59:35 +0000
In-Reply-To: <1737687019-22232-1-git-send-email-mark.hatle@kernel.crashing.org>
References: 
	<1737687019-22232-1-git-send-email-mark.hatle@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 15:59:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17075

On Thu, 2025-01-23 at 20:50 -0600, Mark Hatle via lists.openembedded.org wr=
ote:
> From: Mark Hatle <mark.hatle@amd.com>
>=20
> The default mc is '' (blank), however BB_CURRENT_MC returns 'default'.
> Allow a user to specify a mcdepend such as:
>=20
> =C2=A0 mc:${BB_CURRENT_MC}:m2:recipe:task
>=20
> Both '' (blank) and 'default' are now supported and have equivalent
> meaning.
>=20
> Signed-off-by: Mark Hatle <mark.hatle@amd.com>
> Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>

I'm wondering if we should remove "default" entirely, it is confusing
and I'm not sure we want to complicate the code with this. I'm going to
test a patch doing that.

Cheers,

Richard

