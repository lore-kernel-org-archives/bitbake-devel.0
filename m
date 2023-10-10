Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0CCCD8CA2
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 14:59:10 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.93541.1696949947301098978
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Oct 2023 07:59:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Wo7QpXr6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4064867903cso58719475e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696949945; x=1697554745; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JJ4VXrsgmydJF84tnhT44wb1paOAsXLbFJRF3fAXU+g=;
        b=Wo7QpXr6aZgFe+LO3IY/b69BzFb66vWpov76bndWwszKlonC0+BGDYvY0GUVybryon
         cibG46BGAbkvtK7R0/zstOk5zl6tkhHTmMlrOlD5eVrzwLLxW+dsjNs1Zv3CXb4wCb5N
         pWvVSLhI8pTiHX9w/ZLukFHeUd64Igp6l62Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696949945; x=1697554745;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJ4VXrsgmydJF84tnhT44wb1paOAsXLbFJRF3fAXU+g=;
        b=MCc8h6k5vzrpcw07iS18F2LQN8guWRlKfqxPJ9N8XVD3drGp7n972kCL/zoHrloiOb
         firnylROQk5DEsNn348kCe5mvdenSIAOfoNnYmVLmyNuYH1SZ/THW3f3V9PwW1eACe5O
         xdPmJZXOxDjmz5hXwBmXNQTgZhxgY5TUFrygEC5+CtKBna8Dw46epaAwHPeFVWDK2jUX
         efIKnbS2ctTNAQcWUif8+MuATeO0dzAL1tLStMSOdLtLVX/49kS3wAz8n7nVHWXT/vwm
         36CwPLBamU3jtiiNVAxBfVtGju/bq5q2lMmOnXFef7dAnLIUCMrXnKieH8wuAia2R4uL
         skiw==
X-Gm-Message-State: AOJu0YzS7VVyQpLptM/yLysK7Ai+235KODs6+uAedHS6eFHgLclKnipX
	DtWNw2zvmIKJa77Kc8zTSx5N6A==
X-Google-Smtp-Source: AGHT+IGByk7vOOE3ecKnIqumxi0H1kAtm4lHDtkaceTIxn9NXE/OnnNAI2fernvyyjXp9rC3H2xycQ==
X-Received: by 2002:a05:600c:2901:b0:3f9:b244:c294 with SMTP id i1-20020a05600c290100b003f9b244c294mr17042920wmd.35.1696949945492;
        Tue, 10 Oct 2023 07:59:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2892:849c:e303:df3f? ([2001:8b0:aba:5f3c:2892:849c:e303:df3f])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c378400b003fc0505be19sm14339657wmr.37.2023.10.10.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:59:05 -0700 (PDT)
Message-ID: <61aa3f568ea6cab50f0eb9e1168329122c3e0933.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Ensure that BBFILE_COLLECTIONS and
 BBPATH exist at add-layers and parsing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Talel BELHADJ SALEM <bhstalel@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Oct 2023 15:59:04 +0100
In-Reply-To: <CAOgG7m2BVasNj-xPFMbP0VBBi5aXB0tGF84fiK1QFY+1eNFmrg@mail.gmail.com>
References: <20231010014835.947330-1-bhstalel@gmail.com>
	 <49ed9ab41a08e2665bc66080d1955d078cb2d888.camel@linuxfoundation.org>
	 <CAOgG7m2BVasNj-xPFMbP0VBBi5aXB0tGF84fiK1QFY+1eNFmrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 14:59:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15206

On Tue, 2023-10-10 at 15:35 +0100, Talel BELHADJ SALEM wrote:
> Thanks=C2=A0for the reply,
>=20
> Regarding the second comment:
>=20
> Do you mean using addpylib can be an alternative for not setting
> BBFILE_COLLECTIONS and BBPATH ? If yes, I can't see an example on how
> to do that.

Layers don't have to contain recipes. Whether or not there is an
example, a layer with just library functions would be a valid layer and
I'm not taking patches which show them as invalid.

Cheers,

Richard


