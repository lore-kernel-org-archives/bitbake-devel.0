Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD9CEB64DD
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 06:59:21 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.37774.1691737152089990522
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Aug 2023 23:59:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gbY64gA/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso15689075e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 10 Aug 2023 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691737150; x=1692341950;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKBp7GbPxWtxDSn6y0Tb7A2IpGUeKNXd790QS53nfHE=;
        b=gbY64gA/LpOBvMYtHdvmGvl1PmxWiENBybiimD6sV4xHHJBYCki77irAkvpTtqOILl
         ZtX2OazJsfZ5yybjMxt2VVgWxqb6qBlrKd8xn9phYBn1LDGZFWjYm6MDtK7NlpNe5PX/
         7vgMv6A9rMZPhXsHxOwGs55ciqKaOjTPg5mH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691737150; x=1692341950;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NKBp7GbPxWtxDSn6y0Tb7A2IpGUeKNXd790QS53nfHE=;
        b=UsiFrvg77NcJieAWWQ4YfnC+B+nhO1ocOlx8KktRsH71IJN9mElYRFQlL5037yWAoj
         vGID3k4VHsl7gnocHyXqiNowkNu3/Zhc0snoMiIGJq+VwCwLcLnUBsQp9KoIz4+tKM9y
         /DZemUGgptcAMAfQV6m/X5KFi5MaMU7nD52lazNOt1fotkhKn6hnR8E9LADP1EUtstDu
         EhmnmXPACXx7+g5EXzOl4eUjog5W1HEwWBGY8lO+co8Yy6Q4OhMSz9Q70N4UrYs5X2OZ
         Z9HjNEkrvYEezoTvLHlnyFRnWzSp4u9NK+Js2cj3WHlB5+ljjVwo+d/+6QNBTdOChoON
         QyDA==
X-Gm-Message-State: AOJu0YyI3wcXJ2CAQ8IOuZ2JGl8Z85RMp0cMCAxO5y5A8uBMKGhIEvNC
	HpD1InnCODRiqppMmp51sP7QNg==
X-Google-Smtp-Source: AGHT+IFaOuDWKGee9ywcVXMRUK5pwnpGyYcPt+qNH2Ictf7Ob+ywa4f0Pyj4Egmyb457fyEQyMhhgQ==
X-Received: by 2002:adf:f88d:0:b0:313:f5f8:a331 with SMTP id u13-20020adff88d000000b00313f5f8a331mr618415wrp.34.1691737150244;
        Thu, 10 Aug 2023 23:59:10 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1e7:9ff1:d8f3:9443? ([2001:8b0:aba:5f3c:1e7:9ff1:d8f3:9443])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d500d000000b00317ddccb0d1sm4409558wrt.24.2023.08.10.23.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:59:09 -0700 (PDT)
Message-ID: <d34f06b75fc99508e620368598a561555681bc40.camel@linuxfoundation.org>
Subject: Re: [PATCH] server/process: fix sig handle
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yang.xu@mediatek.com, bitbake-devel@lists.openembedded.org
Date: Fri, 11 Aug 2023 07:59:09 +0100
In-Reply-To: <20230811022046.7829-1-yang.xu@mediatek.com>
References: <20230811022046.7829-1-yang.xu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Aug 2023 06:59:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14935

On Fri, 2023-08-11 at 02:20 +0000, yang.xu@mediatek.com wrote:
> From: Yang Xu <yang.xu@mediatek.com>
>=20
> process.signal_received is a list for signum and not iterable,
> change a suitable method to handle sig.
>=20
> Signed-off-by: Yang Xu <yang.xu@mediatek.com>
> ---
>  lib/bb/server/process.py | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index 4d4fa6d1..f62faed0 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -860,11 +860,10 @@ class ConnectionWriter(object):
>                  process.queue_signals =3D True
>                  self._send(obj)
>                  process.queue_signals =3D False
> -                try:
> -                    for sig in process.signal_received.pop():
> -                        process.handle_sig(sig, None)
> -                except IndexError:
> -                    pass
> +
> +                while len(process.signal_received) > 0:
> +                    sig =3D process.signal_received.pop()
> +                    process.handle_sig(sig, None)
>          else:
>              self._send(obj)
> =20

Well spotted, thanks!

Cheers,

Richard

