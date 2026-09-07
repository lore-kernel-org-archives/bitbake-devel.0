Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFB5C79F9E
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 13:53:57 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35615.1788789234593327872
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 06:53:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gI9AdpoN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2530cabcf4so547200066b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788789233; x=1789394033; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jzc2bYtABgcWbOUlkihfQKwwI/nimllt/ojWxYphjSY=;
        b=gI9AdpoNDF52FgZPAuIjczhKYCbqkIWmseDsndrYYUXidtywz4nL61rpgldKq2FvIl
         i1JuB8Uztt6dWl0ei7pC30fZ5u9dbsmVWh3twZb6gKRLs9AT+fB6TUx+uNf4GhojhXsZ
         Oa17PDsG8YyRM/A9rQj855fg+k+cuYtU4/Uxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789233; x=1789394033;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jzc2bYtABgcWbOUlkihfQKwwI/nimllt/ojWxYphjSY=;
        b=oxU9XjJ2eYLR307O8f5pxkcZ0VpFqj++LJHf1kF0gx4sEBH/VcIPo6/B7C6A5Wdlnc
         nqnx2+he0LHNw2Q8loZ5/w1zlyHGcB+H79PbUEIfKh5UWbpRHpQ/t+pWJf1ztWjjd0dx
         DoFw/jnTQyWZJHq0zwBeyCvahxG8f9qLJ8k8vsR+nzHUfoOXR4asViXg2qfJBih30NsW
         LcxGxgqPoIb4yElTBpQrFc9O/RBQlb4gB343qCrOpwC1Zz1TA5UWoafvDGXRuJEP8pN0
         iYr/m7JOxBTLrJX+NKwk81n+Lfl6kuG2OL4/uxZbJuEgEHlYhx6BZVAbS/8dkhfQWk6Q
         AJAQ==
X-Gm-Message-State: AFuF++kVfcAeLz9vbjfszHb9FnRg4udGtGGPoH3gOwiiSTzuGiGZ73p3
	nPvjyYHU5MT4zDaiiPLE9SwaNPQFB/YiQ1LblurZue8sgYJoKb0o1aU+o6Ei0E2lmcrCw8QxOi2
	FxWy8g+U=
X-Gm-Gg: AYBFou32rHrVhv7WW2Mo41dOCIvpSjcubgp83lTUOZ80YSOhuzp9/OMtMmyVOyT2ajs
	gJjF3jOfIiRXgF01PfuPXpa7X2gVKIvah1eq6JS3fYZb8egreAjwN6eFbRFXX0pkKZuraqmUjh0
	zpZPxpxMSQ8tyOzRoyGREfnNG03Z579R4JE0foCKXQ+BM81t/aUoypGaGRraUAdv6+qOlILhgBQ
	QnwipeXZ2VAznaXD59Cih7fpAZSNwJ0oqwyTKyoZP9AYzr+sQUvkJkUR212xgJF7nzarkjYXsHH
	24fUkzEtCCqku5i4BWztoZHzT0fEE2pbB3YcspSn6rOumSVKi0AK1vc3vagbz6SPNGuU6AGPk7u
	3g/A1MKUNCE3moD9xfx3NEKyCTvBYrgM28COaNLpUBt9RQvgqzNzizYZcM6dXejRAIaIK2FDh8V
	1+u0F9RQplz40VTJKp06hjXPC3xW6PPQDbgZ11tb5RZQe1/yra4YvmmlkefJnyiVJS2vthyJdYW
	dY+kC23bVHhb9uCmVJMAwzvIsp4w24OrRlrmARO3W8tnAR0hdEeuU8=
X-Received: by 2002:a17:907:3e1a:b0:c24:87e5:6491 with SMTP id a640c23a62f3a-c260c971f12mr1486976066b.2.1788789232683;
        Mon, 07 Sep 2026 06:53:52 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e2ae:fec4:d03e:3153? ([2001:8b0:aba:5f3c:e2ae:fec4:d03e:3153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d582304sm476201766b.43.2026.09.07.06.53.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:53:51 -0700 (PDT)
Message-ID: <77729bcd7a222489deb4175fe61bda24da0f25f0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] tests/fetch: Swap bitbake github mirror
 for YP one
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 07 Sep 2026 14:53:51 +0100
In-Reply-To: <18D30CBDF6C61D5C.4159725@lists.openembedded.org>
References: <18D30CBDF6C61D5C.4159725@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 13:53:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20163

On Mon, 2026-09-07 at 14:24 +0100, Richard Purdie via lists.openembedded.or=
g wrote:
> We need a reliable mirror of the bitbake repo and github is no longer tha=
t. Swap
> to use git.yoctoproject.org which happens to also carry bitbake. We only =
really need
> two different urls.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> =C2=A0lib/bb/tests/fetch.py | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)

This used to work but doesn't. Back to the drawing board...

Cheers,

Richard

