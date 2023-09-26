Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B8E7E624
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 11:27:12 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.16705.1695727629460914918
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Sep 2023 04:27:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eILADAP0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so77371515e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695727628; x=1696332428; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IHmojxgB1zdKrJ+BT5d5WUpEyrQRGY9jU5iB/DKars=;
        b=eILADAP0xa3MtJumUX6zV/q9tClkPCFueDyiKhWZOl/32ceVfFNLNESF+9EC8SZgpT
         XqYA/kaCsMPdpm5jem3iXdzJmJ7n3pvS5nm8VIuU+Mm3u9x2Viaz0OtgqrOUalBHSRWF
         tI1370kq6p+0/Xko1xlzUiwoxFGLmCWXKVFXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727628; x=1696332428;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6IHmojxgB1zdKrJ+BT5d5WUpEyrQRGY9jU5iB/DKars=;
        b=oYs7pp7qhpwvbY5Q/KLgaR1UmUou6qd5c1tZ7KnGqjxKvxYkH2spzHlUg7m5sAPKRn
         ra7o0VIAykJfHHkcQe2siAfz234m9LkmWLXltphH9sClsUABK43SdNFwZxfYWnZ0bKAz
         0yyTheOvDEWL4Bih2nApL3e+3HWoWA7CEx5xiLCL1WG9rkuz2pvImoCidEXepvMXAkav
         DF1jcqFzhR99Mcn16zKxXyC9utEnrxXBsQQQC4oFZlD4hzAYFbVsAfEyYWsQgQx+akYD
         VCwI9EJS8TmWNkawDETBTi2jnpuprVQ6aZ5XLaR3vVZ+i//bxX5DFypNps6zAzSKQ+9L
         MHcw==
X-Gm-Message-State: AOJu0YwiaXrEhnRtOvYs7HU9Aql1Nnyt9lQc4ymEpJ+BOCdSKsCevl9g
	LQqCilT1pRoRYWmakC6+akoqYkekfX8bM4jLgKw=
X-Google-Smtp-Source: AGHT+IFgUDfJIXim9u4mzJFC0EK7CKesY1KNfr0l0azzXvhOXmIDV/m9P/9cq+f/mzqFd5wEDydrtQ==
X-Received: by 2002:adf:f485:0:b0:322:4892:17f with SMTP id l5-20020adff485000000b003224892017fmr9076285wro.7.1695727627707;
        Tue, 26 Sep 2023 04:27:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:25bd:4a27:c3da:a228? ([2001:8b0:aba:5f3c:25bd:4a27:c3da:a228])
        by smtp.gmail.com with ESMTPSA id z8-20020adfd0c8000000b00317a29af4b2sm14479291wrh.68.2023.09.26.04.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:27:07 -0700 (PDT)
Message-ID: <289e9d07fda1186f4f01a753a81c5cfc05ddccb2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH 1/2] bitbake-getvar: further supress
 warnings when quiet option is supplied
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Date: Tue, 26 Sep 2023 12:27:06 +0100
In-Reply-To: <20230926101440.3610057-1-Qi.Chen@windriver.com>
References: <20230926101440.3610057-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 11:27:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15129

On Tue, 2023-09-26 at 03:14 -0700, Chen Qi via lists.openembedded.org
wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> When scripts rely on bitbake-getvar's output to get values, e.g.,
> oe-find-native-sysroot, we need to ensure no warning message messes
> things up.
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  bin/bitbake-getvar | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I think Peter already sent something along these lines which just
merged?

Cheers,

Richard

