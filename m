Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D056CFA755
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 09:58:33 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.18584.1728035904972024218
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Oct 2024 02:58:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cpqvSl04;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cdac05af9so1846874f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Oct 2024 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728035903; x=1728640703; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6XPFh96ashjr9MrJuZ+PVYiWk2cXGnXTDmmo5J3MD8=;
        b=cpqvSl04EVQp/OrmzBJZH6ApeSsKxvcT9mKWaA46vyV3u3nXGgQAWVL0OZ9F8Z/j9k
         6oqnSef82KXkrgN85FeGRuLSz3YN1FASth1vYAiMFar0xAlDPrExBBPA9twdc5tjsMbz
         9idAYDZqPceiRuTruy99iLrwcXGdVhl8bcNao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728035903; x=1728640703;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6XPFh96ashjr9MrJuZ+PVYiWk2cXGnXTDmmo5J3MD8=;
        b=r/bPVPk0O1N8oiI4gnrSlyJQRrXXNa6VvVH7448gZANhuktuX8RbyilXJU6ixpf1P4
         ocS5O1VeGyYQAk1nqPxPUihDVCfR7c7XVM2xpwsynHWdQD5FKXvX1HixeMTHTWhbMmxG
         SOywwUwetszye8BUG1yfZwYnWiDclmZyIrIFkbIjBSupiWudAKr9qejVkTkm2rM1+K/K
         YjFncDmyHNpBwBnJ5Q6SsvG9JGsUzPUOqXTIRPsPqvKuwG3RUnnrYs8/7F+iuo6YsvQt
         UhJL2qJeZfhCg+m0MU0oCIloYfFb1RVuK3Ws61jxWRXvfT/vgmLLjPfRuG4PoJgsURoG
         0efw==
X-Forwarded-Encrypted: i=1; AJvYcCUn8Kwn5vageQhd4TVDgGIi824H03FvHUITP5AC344w5nV1bPZlBtEl8+3qZJDyr6eTdpHBBhBG66HDsfX/@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx9n33+LLWNwXeLrNYdVsb8bCXy8jRCoIZ/0Ec1AFq+qlLTNeeR
	xmisDv96LalRDtsGWzgBZLjMJEyE/jKPwoH2MITqXCDIljMA0B2nir1pFowISZgHsIsttuXW/zU
	w
X-Google-Smtp-Source: AGHT+IESacqRHhi2/nICv9OZzfFYEoop0idNqiJ2S2XjwZ1J967yol9bwSvIeHPigRU4XFBUPH3/UA==
X-Received: by 2002:adf:facf:0:b0:371:8dd3:27c8 with SMTP id ffacd0b85a97d-37d0e74e71amr1754936f8f.23.1728035903069;
        Fri, 04 Oct 2024 02:58:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:25ac:3f31:db63:541d? ([2001:8b0:aba:5f3c:25ac:3f31:db63:541d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08260d5fsm2905472f8f.63.2024.10.04.02.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:58:22 -0700 (PDT)
Message-ID: <46a43e5aa802fcb59dc2dd1fc832e4fd787939b9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] fetch2/svn: Support to feed an external
 SSL certificate file and its password
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mfumita@electromag.com.au, bitbake-devel@lists.openembedded.org
Date: Fri, 04 Oct 2024 10:58:21 +0100
In-Reply-To: <20241004030640.10440-1-mfumita@electromag.com.au>
References: <20241004030640.10440-1-mfumita@electromag.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Oct 2024 09:58:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16638

On Fri, 2024-10-04 at 11:06 +0800, Morikazu Fumita via lists.openembedded.o=
rg wrote:
> Add parameters to feed an external SSL certificate and its password to th=
e following SVN runtime options.
> =C2=A0 --config-option=3Dservers:global:ssl-client-cert-file=3D"..."
> =C2=A0 --config-option=3Dservers:global:ssl-client-cert-password=3D"..."
>=20
> Can be specified with:
> =C2=A0 SRC_URI =3D "svn://[repository];protocol=3Dhttps;cert_file=3D[cert=
ificate path];cert_pass=3D[password]"
>=20
> Signed-off-by: Mori Fumita <mfumita@electromag.com.au>
> ---
> =C2=A0lib/bb/fetch2/svn.py | 16 +++++++++++++++-
> =C2=A01 file changed, 15 insertions(+), 1 deletion(-)

These look like things which you really shouldn't be putting into a
SRC_URI. Wouldn't they be better in the subversion config files within
the user's HOME directory?

We've not taken things adding support for passwords in various SRC_URIs
since it encourages behaviour which isn't secure/recommended.

Cheers,

Richard

