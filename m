Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D363CC7EE22
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 10:35:58 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.13023.1683714953187501525
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 May 2023 03:35:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=KTtv1Phk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3078c092056so2921556f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683714951; x=1686306951;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLqnS4p3NF0TLfY+L/f3eAaqFc3gBrJpCDXKf5LlnkE=;
        b=KTtv1PhkSQIbvK0wbBib+fqOosBRb0D0j5S2p0lHfav/w4ADOOCEbHlZFVTKS9d0Bg
         UY1WhghnNxW9GK8cV/VCyFf3H1nqtWUntWsgm89n2K1sT1H/xT2GAWsNT6GTqTwMbGyP
         VTYPau0dGdr+agOKbqdEnoA3TJEnwtie+vE9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683714951; x=1686306951;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLqnS4p3NF0TLfY+L/f3eAaqFc3gBrJpCDXKf5LlnkE=;
        b=enEOY1Ryzn0MDTGX5CcKZfA+0VO/AkZO76v6R0amKr2JEL8bfC2PKd3nYCnIVsRZVa
         X5EjpAqgH8P3XzEHjvZS7WQuxeFxowp00AxBSZzGFyRIZ3dte8TCo4Yla8emnO/4QDRx
         KTiTzNxw2EUifP3JpbshNokYBxE5wR8PyMjkB3PN0TVcHhnilAwhYASx868g0G2/Tcka
         yg/S4mNVWKt2hNQkjC3k2CulWVPmH+YSyv+451WdaEZLtnOjJMOQj695zlVjspMgQkTe
         4hQ+9Ea9ZL66hnTr/6si9Jzzx1ZDyoQmw7eJwMnCbmXf66hYDvsFzc0IaI0PgH4JI8Mq
         3ZvA==
X-Gm-Message-State: AC+VfDxFmLZOh8L300/SfU2D3jbP0Mqd8YsEmFpWfFPUQcnJyJaIIlp8
	ujCZGUbxgRixT0l+VLfItT9shg==
X-Google-Smtp-Source: ACHHUZ4DdLABzEIJzaSwrUZhQzlU0PJB13y16seN6l4hOt72StCcnHabhGLd/PWGrprB6IXxBRcJKA==
X-Received: by 2002:a5d:4004:0:b0:2fa:631a:9f23 with SMTP id n4-20020a5d4004000000b002fa631a9f23mr12073747wrp.2.1683714951501;
        Wed, 10 May 2023 03:35:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:97c0:2f0a:108:d273? ([2001:8b0:aba:5f3c:97c0:2f0a:108:d273])
        by smtp.gmail.com with ESMTPSA id a11-20020adfeecb000000b003048477729asm16891002wrp.81.2023.05.10.03.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 03:35:50 -0700 (PDT)
Message-ID: <dc333728ed8a71d512609709ce6603e7c0b3e188.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] bitbake: add --noreply-timeout option
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Chen, Qi" <Qi.Chen@windriver.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 10 May 2023 11:35:49 +0100
In-Reply-To: <CO6PR11MB56021F72AD89D4BC727C33CAED779@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230510031631.1813338-1-Qi.Chen@windriver.com>
	 <25b122740ed8d9d0c62068542da4fa99c53e2dd9.camel@linuxfoundation.org>
	 <CO6PR11MB56021F72AD89D4BC727C33CAED779@CO6PR11MB5602.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 10:35:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14775

On Wed, 2023-05-10 at 09:43 +0000, Chen, Qi wrote:
> Hi Richard,
>=20
> It's not the bitbake server that takes more than 1 minute to start,
> it's that the 'updateConfig' command that takes more than 1 minute.
> From what I see, other commands finish quite fast except the actual
> building one.

The updateConfig command doesn't actually build anything. All it does
is triggers a parse of the base configuration, it isn't even parsing
recipes, just the bitbake.conf and layer.conf files.

Think of updateConfig as just bringing the two ends of the connection,
client and server into sync.

I'm a bit worried that if the system is so overloaded it can't do that
in 60s, we have bigger problems.

> The server was still usable, even after the second world build
> managed to start.
>=20
> I'm not using any special configuration. All default values. I do
> have extra layers added, such as meta-openembedded/*, meta-
> virtualization, meta-browser, meta-security, meta-selinux, etc.
> Anyway, the task number of a world build is about 40000+.
>=20
> In fact, what I really want to do is to set the timeout to be some
> large value on our autobuilders so that we can avoid this start-up
> timeout failure. If such patch is not suitable for the official
> bitbake, I'll make it a local patch until our autobuilders are
> configured more properly. Do you have any suggestion?
>=20
> That's all the information and the background.

What is BB_NUMBER_THREADS set to and how many CPU cores? Spinning media
or SSDs? What are the system load numbers when this happens?

I think that if this startup timeout is happening, there will be other
issues and you need to resolve the overloaded system problem rather
than just move the timeout problem to somewhere else.

Cheers,

Richard


