Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B27E10FCAEA
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 21:43:47 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2882.1775079818545820014
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Apr 2026 14:43:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KCh1b2bk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48704db565eso1931055e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Apr 2026 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775079817; x=1775684617; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iIv9D34VQCJsBZBNtEf/zEHcG3IRq+SAUiu9FPCjME4=;
        b=KCh1b2bkktlizMKiDFM0RHqSZI6QARFk2OQZtB9Yx66vY1d/R3rK9pZ/LOcwb0pEuI
         xFUJclXw/SQW1YFDWWz8Mf4sPmpdH6EjKa9ZUfPrG6rUi9MA9qU3vKXWhmw6RuTWnS7b
         RpgQcj3uC5Le+i7jzGmlapAyDceATDP7tApj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775079817; x=1775684617;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIv9D34VQCJsBZBNtEf/zEHcG3IRq+SAUiu9FPCjME4=;
        b=OUjDDhGAtcXimsuqSl+T9vDUUDOUOBWgQ7KS/HfOd+QCD8OupLtrj3gH6xUz76kBpi
         EhrrYkclWYfn+9BnZpQkrWT+SwvuWoSvpZp2+JDIAmD+m5DTPeKWyEXzMpk/wsin3HDB
         vUJi2P+j6/fNVwc3wnv2GkUq3W/cXzeyA92eoNbmgwTQD8zxCDB7Jj8Ahy6HGR277e+x
         etIR2Ac9ImF6+6YEJcxgEecRePVXk6/YAfgI15uvdwcPW0LfHSZqZa0VCFYAz81QMO/d
         TtzCoJTT//OlUC8HSojN0p+AuWAkqUOuZL9RLMY9QECFAI2KdaVqSHKt1OUXKWJyZL4H
         qa9A==
X-Forwarded-Encrypted: i=1; AJvYcCXaTgz73kFA9HOzDyo1rj76QsMo6xoOiHQ05kcDfbUU+H3tV7mCdggLSWgYIZU3dRuceJ4ekCbj1muroIwp@lists.openembedded.org
X-Gm-Message-State: AOJu0YxQyyIiKnbH5aBDghsYvELWJI+RQ8aSATDlTlBrLRDZJV78SSNU
	gMS7fgk5mLExiFboplOJf2XWLmbNZqQrq42WKIqEglglqe1nLVv1BNhIu8AYJL/DLJs=
X-Gm-Gg: ATEYQzzj1OsiG4ngQ14h/BQvE3VjWtTZXr25IX3Iyk65uWFZGse7ylVT9pQlq6AcFH8
	c1W/jXhbOBOsDyPdOQkxjMO03gmfoFiciimoozsg+6eKiF3I9GBz+NxzYHPvY8tiPQXWvPFttQG
	IPML4sQHG7lm9X9Jpwhm/oFQ3pL8orFUWZWI/MkFpHpw/y4qcnDU7HObnwzOQZ7CvSYIofU4upy
	9udKdK0I+aSyObwQSnJFN6eXrUSPODUQQF2/H6zkuaG/3//Dp3OIfvXzeHM1cB3p7mulvcNPM2U
	EOeVtFgH5evvPRlBYF4g4tPvhlQeQyKBv5WIrPSYLq6u7ftjfRPpmcXB36j2xbQZjmyDqC0g6Bz
	jQJrq5k8RCwaCkJ5nLhyQcbvoS3qEHfNdDGpMAT6YO4LIBcQvx/evffWw+MJvTYannCRK5rqPmO
	tnvx71SzDAtAVFGf/blesblRKp0xwsRLk70feJe6MkcZmIU/o3RiFwd51jjh6dgmng3q8SfD0AC
	7I+lYP0Qv3zP7B4C6oRFUq1a6o=
X-Received: by 2002:a05:600d:8453:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-4888b7698a4mr11409235e9.19.1775079816850;
        Wed, 01 Apr 2026 14:43:36 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:d91c:a3aa:733d:be2a? ([2001:8b0:aba:5f3c:d91c:a3aa:733d:be2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad782d1sm50542315e9.9.2026.04.01.14.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:43:35 -0700 (PDT)
Message-ID: <b9c18d2b87c1c089d5d0148dd2b3710fba5e9f2e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 03/13] bitbake-setup: Set function
 default to None
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
Date: Wed, 01 Apr 2026 22:43:33 +0100
In-Reply-To: <20260331160703.3137930-4-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
	 <20260331160703.3137930-4-rob.woolley@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Apr 2026 21:43:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19313

On Tue, 2026-03-31 at 09:06 -0700, Rob Woolley via lists.openembedded.org w=
rote:
> The function defaults are evaluated once and use across calls
> can lead to unexpected behaviour.
>=20
> Set the value to none and let the function initialize the value
> in the case when the value is not set.
>=20
> Resolves B006 from flake8-bugbear
>=20
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
> =C2=A0bin/bitbake-setup | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 313962cd4..f90f01f55 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -46,7 +46,7 @@ def color_enabled() -> bool:
> =C2=A0def get_diff_color_param() -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0 return "--color=3Dalways" if color_enabled() els=
e "--color=3Dnever"
> =C2=A0
> -def print_configs(prompt: str, choices: list[str], descriptions: list[st=
r] =3D []):
> +def print_configs(prompt: str, choices: list[str], descriptions: list[st=
r] =3D None):

This breaks the typing as None is not a list. Adrian then patched it to
fix that but that caused it's own set of problems as it required python
3.10.

Whilst I agree there is a problem, I cannot take this patch in this
form, we need to find a different solution.

Cheers,

Richard

