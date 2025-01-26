Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D070DC02181
	for <webhook@archiver.kernel.org>; Sun, 26 Jan 2025 10:38:22 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.27917.1737887893753942908
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jan 2025 02:38:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N80igom2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so40251115e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 26 Jan 2025 02:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737887892; x=1738492692; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puHUPc+hyMKk4FaeKjW2r4FObY2EBRM+O13X767Wv5M=;
        b=N80igom23+dFcctBux462cuMn5dT4+ULuDhdI85lptjGcKZAYNShFPxjSIewzaYRFH
         60WTVPCeRoI7yZbFGAxGFfaottjih85LM8F5Gwo1hlciyvF5Feqrj58oQhyFUnJwp6ra
         pbbT8Xu0WYnbQZR4fC17Aer7cNFUdCRNMmoJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737887892; x=1738492692;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=puHUPc+hyMKk4FaeKjW2r4FObY2EBRM+O13X767Wv5M=;
        b=w+r8fuDr27EeLyibJWsGrbM98pSD7OXjgqFfpj8s9CNHh+ZTnsQuEHMvYHr0DPc/q0
         Qo4rnw/v5m4Uxps0pFy0BT1sT4DFobdysNYlDPOe66GAPev6yJAWQo1Lxc3bc5Sqg3mO
         aF9CYMFmJkrXcroYrq0i/On+lVJYAF7p96MUA+KKLn8oTYn5aRVlKvHVLf1tJlqAMEyo
         aMiqdEuiJkPGi1CT6h9J+xgxGQmWRAI9VMsNbrozLRII47va1wtIaLy+2wS4UZfcv5eL
         XEfjLmEGq2Ia+yAqNFzPBquY586YpxSQ1FMqdUiv45Y3eFlLxP3crc4zJrpn8BSgkatw
         GQDg==
X-Forwarded-Encrypted: i=1; AJvYcCXys2sn9mAU5spfERk1vh5ITZ7c6DZhN8kOnwjl9gncWbXNGkalBK/Ia9TT2vNgg+N8Xp66q2Bj/HiJiQ20@lists.openembedded.org
X-Gm-Message-State: AOJu0YyM9BKTi7mML/xtoiPEbCl1xNJVgrXaTdnlw0F2IWinywaRkkix
	YA7aUpinYDswlhDsTNgJzr4wP58g0XGf88751fldntgV6aSCuAM8N7i8wyrjh+U=
X-Gm-Gg: ASbGncvwqQJ32x/LABPTbp+2IPjawfUUTHsen98i+Dt6hDc0k2S+zZObLn77n3lLqcA
	k7aTArEUHtlj03AFWLGE3QE6njE70NZBlebUo+G2XdyhVWE9+6obUmosmw0TlXTj7vpp2F5+OwC
	IgcvQ3wXBOzddQAz88AXz4A2adK6FfzEDr+kffBzeFlEWhC+Lcps8wyPaY/gQeAIKqZfDNfZ3BG
	9OrIAc7I7Plz3+SCl0M7YLuhz3hC7fZzcA0gTH8KVgVONc8LrvBpi3YYGRx8+SNVhIJi8Z6n7pA
	jUWTJ6c/fchmqKfZnYwRrz2ltbty9/JqtSZE7VVnsqTOPpTV/uZ9ICiYFPvZUo3ph18=
X-Google-Smtp-Source: AGHT+IE4NA3XIYrvGJMsAM3U3wwS7qZaQcaltXQ8yagLgDcVaCNHqAjjh/Gie123fi921HLdOUvpcA==
X-Received: by 2002:a05:600c:a07:b0:434:f9c4:a850 with SMTP id 5b1f17b1804b1-438913cb16emr363364095e9.10.1737887891211;
        Sun, 26 Jan 2025 02:38:11 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6905:4568:b67b:291? ([2001:8b0:aba:5f3c:6905:4568:b67b:291])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48b11esm91562165e9.19.2025.01.26.02.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 02:38:09 -0800 (PST)
Message-ID: <4f6e1a70fed80b6310476a9e04071d0da7447211.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH v2] doc/logging: small clean-up and name
 environment
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: joerg.sommer@navimatix.de, bitbake-devel@lists.openembedded.org, 
	docs@lists.yoctoproject.org
Date: Sun, 26 Jan 2025 10:38:08 +0000
In-Reply-To: <6ab2ca1d7d9cd7ebf98aaca7e19612b3de0f133b.1737884847.git.joerg.sommer@navimatix.de>
References: <D6UW0L5UHG5P.1JGNQ7WKC2N6@bootlin.com>
	 <6ab2ca1d7d9cd7ebf98aaca7e19612b3de0f133b.1737884847.git.joerg.sommer@navimatix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jan 2025 10:38:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17092

On Sun, 2025-01-26 at 10:47 +0100, J=C3=B6rg Sommer via lists.yoctoproject.=
org wrote:
> From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
>=20
> The variable *BB_LOGCONFIG* is part of *BB_ENV_PASSTHROUGH_ADDITIONS* in
> /scripts/oe-buildenv-internal and can therefore be passed as environment
> variable.

We have to be a little careful here since that script is in oe-core and
bitbake can be used with things that aren't oe-core and may not set
that.

>=20
> -Then set the :term:`BB_LOGCONFIG` variable in ``conf/local.conf``::
> +Then set :term:`BB_LOGCONFIG` as an environment variable when running
> +BitBake, or set it in ``conf/local.conf``::
> =C2=A0
> =C2=A0=C2=A0=C2=A0 BB_LOGCONFIG =3D "hashequiv.json"

We might need to document that it should be included in
BB_ENV_PASSTHROUGH_ADDITIONS. Perhaps making that a bitbake default
might be the easiest...

Cheers,

Richard


