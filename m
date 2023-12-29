Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1C6C46CD3
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 11:16:35 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.144616.1703848587142590302
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Dec 2023 03:16:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KIEjtrmk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d5aa35b60so26736145e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 03:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703848585; x=1704453385; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1tN4WQDobuti2bPQPs9zEHLngDN+3tFicAtoLS9gso=;
        b=KIEjtrmkMsiUd9EyARZrzztIKB8G+bTRfz2Uc05/de5WTcA78Mt7XL1dvL/U2574rY
         tYXHAxKr3j1xq7Y/zkNYZOz5pdG5lTCYR+ruNkexvi6X6V2Y0H8NyfmFWfQvZsQ+Cv/D
         r2f0EhRo2rE3nCjh/u1s2ePjQq1KNyHcDJIfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703848585; x=1704453385;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1tN4WQDobuti2bPQPs9zEHLngDN+3tFicAtoLS9gso=;
        b=iB8ZBj9tfLbPmG+HgMSRnI9fyQhksfhf9HRFxLQntv9HjeRXiwyHVcOShADdfVlYTj
         BEK93UnFxtoUY/Zno3c1JdC4oJXx8pPqxMENwxqGday4SQpR/oHKTGh4Tk6/18AQL9J+
         XCDUAnmefaCcEXqJuqTLi5Zc1WN8xaCbIC5ksz7lzlgF8u/I49nuWwuaY3vLbKbcU0a0
         yB7sajXMGPboxB+yzgC5ilssYdri1WNgz1s+5rQh1u5n8bjeiOn8pa1J4d2QmOjo3SMF
         xm01Cw76JbMxkl1e05wNjLXsPtq0u6Bs1MY3PPeLm73xZtjaGo5jLdVJbWDWIr8Yswv7
         6UFw==
X-Gm-Message-State: AOJu0YxSlKX/WAH3MNfxJjjsRZ4Gqa60Qk5fUteDk79eGRkWTmXiCJTh
	8oTkfeF5QnZohlZ4YfuExnnoFr5XBiV2rA==
X-Google-Smtp-Source: AGHT+IELGxVgE5ZSdOEVkz+kgHiJ/CX66wQjo6JNLpeT3+3QJybPFPYcejm++NhYB2GwtBbZ7S2Jgw==
X-Received: by 2002:a05:600c:22d2:b0:40d:6045:e847 with SMTP id 18-20020a05600c22d200b0040d6045e847mr954842wmg.88.1703848585240;
        Fri, 29 Dec 2023 03:16:25 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:87c1:7de2:db24:7cc8? ([2001:8b0:aba:5f3c:87c1:7de2:db24:7cc8])
        by smtp.gmail.com with ESMTPSA id fm9-20020a05600c0c0900b0040d570e8f50sm15585378wmb.12.2023.12.29.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 03:16:23 -0800 (PST)
Message-ID: <35a13b43c34c7159be6ddc3e00266e01d7ba712a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 1/1] bitbake: event: Inject empty
 lines to make code match lineno in filename
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
Date: Fri, 29 Dec 2023 11:16:22 +0000
In-Reply-To: <b64c2496383eb263e6fd2d636ec7a2d88b424db6.1703829627.git.liezhi.yang@windriver.com>
References: <cover.1703829627.git.liezhi.yang@windriver.com>
	 <b64c2496383eb263e6fd2d636ec7a2d88b424db6.1703829627.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 11:16:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15719

On Thu, 2023-12-28 at 22:06 -0800, Robert Yang via
lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
>=20
> So that we can get the correct error messages.
>=20
> * In python 3.10.9, the error message was:
>   ERROR: Unable to register event handler 'defaultbase_eventhandler':
>     File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>       # SPDX-License-Identifier: MIT
>              ^^^^^
>   SyntaxError: invalid syntax
>=20
>   This is hard to debug since the error line number 4 is incorrect, but n=
othing
>   is wrong with the code in line 4.
>=20
> * Now the error message and lineno is correct:
>   ERROR: Unable to register event handler 'defaultbase_eventhandler':
>     File "/path/to/poky/meta/classes-global/base.bbclass", line 256
>       an error line
>          ^^^^^
>   SyntaxError: invalid syntax
>=20
> And no impact on parsing time:
> * Before:
> $ rm -fr cache tmp; time bitbake -p
> real    0m27.254s
>=20
> * Now:
> $ rm -fr cache tmp; time bitbake -p
> real    0m27.200s
>=20
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/event.py | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> index f8acacd80d1..7722258b7e8 100644
> --- a/bitbake/lib/bb/event.py
> +++ b/bitbake/lib/bb/event.py
> @@ -257,6 +257,8 @@ def register(name, handler, mask=3DNone, filename=3DN=
one, lineno=3DNone, data=3DNone):
>          # handle string containing python code
>          if isinstance(handler, str):
>              tmp =3D "def %s(e, d):\n%s" % (name, handler)
> +            # Inject empty lines to make code match lineno in filename
> +            tmp =3D "\n" * (lineno-1) + tmp
>              try:
>                  code =3D bb.methodpool.compile_cache(tmp)
>                  if not code:

Looks good but don't you need remove the ast line number adjustment a
few lines later as well?

Should we put some tests into bitbake-selftest for this?

Cheers,

Richard

