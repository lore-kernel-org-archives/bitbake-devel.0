Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D3C05027
	for <webhook@archiver.kernel.org>; Thu, 26 Jan 2023 16:47:34 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.78756.1674751644074122515
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Jan 2023 08:47:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SDWcSHoE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id r2so2381622wrv.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 08:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1RdxGI0gfod9VGixaWJVZzbLxdJrMBHBA11ck1zOk3U=;
        b=SDWcSHoEuGitQAXfAGDp08RAzZpr1YtMDJJKflsG7bIWOIknzK7MQpyycXBgnfDKkF
         qhHDgX23eM6SxLnJtltNtuc1YedRlfr6nge4vUT/1GPztVY2Ck7sIiZ9EnuZSVBB2mdN
         6eGwVg+krDZWk5C1egtjOHnmpGYWUYgNVrduI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RdxGI0gfod9VGixaWJVZzbLxdJrMBHBA11ck1zOk3U=;
        b=ZPVycGDH2LGzD3lCN6oR4jDs/eq+EHv73HIIkv0QYjBLmg1DqlBkwuvaPzEBHu7rTN
         fteoAcbgmjmAAzQ1sCak6xcnLjyuVpmc5ED5neiHwWqwJtVl9W+tggmOdMnVF4vOPgid
         pN9Q12yK0WUDjcRoHl6KEYTSc+ywmXAvx9ZOJg6m5r0DrlxlnskPB2iHtPM1HXcEroR8
         kQlp7VgLWjwJxIU4VxTYTIi8NneQUzzDOuwRUemfmRm94C3dqiZoxBDvJQnGHF8QbMwk
         6qNRMJHYXUTVKQg/nuZSxEzKFxvND+CloLVZuagV5fwxMuBlSOszE2QCGDXOy6BX+dHy
         /h6A==
X-Gm-Message-State: AO0yUKVPMhYjQskAPmRqIeN7KRwHoM4eLXrU8epnKl3fALVhxiPAjQsw
	OEq4vCBJ7R2aSUBp9H1ODm62ag==
X-Google-Smtp-Source: AK7set9ARKAkr723K1NrBYdVVMDcMtknLhaxCFJtvkNHjbeXmYbdea5a0pUWCDuYpLAf3fZCZyD6hw==
X-Received: by 2002:a05:6000:5:b0:2bf:ae2f:c6ff with SMTP id h5-20020a056000000500b002bfae2fc6ffmr9091234wrx.31.1674751642392;
        Thu, 26 Jan 2023 08:47:22 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f2d7:e330:f537:35d8? ([2001:8b0:aba:5f3c:f2d7:e330:f537:35d8])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d67c9000000b00294176c2c01sm1720182wrw.86.2023.01.26.08.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:47:22 -0800 (PST)
Message-ID: <cf441572a9c2070c607ac377e6cfd77bd205a190.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bb/utils: include SSL certificate paths
 in export_proxies
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ross Burton <ross.burton@arm.com>, bitbake-devel@lists.openembedded.org
Cc: nd@arm.com
Date: Thu, 26 Jan 2023 16:47:21 +0000
In-Reply-To: <20230126143935.1444197-1-ross.burton@arm.com>
References: <20230126143935.1444197-1-ross.burton@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Jan 2023 16:47:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14349

On Thu, 2023-01-26 at 14:39 +0000, Ross Burton wrote:
> bb.utils.export_proxies() is a poor-man's alternative for the
> environment setup code in bb/fetch2, but it's used in several places
> where recipes want to download manually (such as cve-update-db-native).
>=20
> Notably, export_proxies() doesn't pass on the SSL certificate paths from
> the original environment, so if SSL_CERT_FILE needs to be set (for
> example, in a buildtools environment) then proxies work but SSL doesn't.
>=20
> In an ideal world export_proxies and the same logic in fetch2 would
> merge, but until then we can add the SSL_CERT_ variables and duplicate
> the basic logic: check the datastore first and then the original
> environment for variables.
>=20
> Also remove the return value as nothing ever checked it.
>=20
> [ YOCTO #15000 ]
>=20
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  bitbake/lib/bb/utils.py | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 8c791595730..bfbc48b6cd9 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -1699,23 +1699,20 @@ def disable_network(uid=3DNone, gid=3DNone):
> =20
>  def export_proxies(d):
>      """ export common proxies variables from datastore to environment ""=
"
> -    import os
> =20
>      variables =3D ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PRO=
XY',
>                      'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY',
> -                    'GIT_PROXY_COMMAND']
> -    exported =3D False
> +                    'GIT_PROXY_COMMAND', 'SSL_CERT_FILE', 'SSL_CERT_DIR'=
]
> =20
> -    for v in variables:
> -        if v in os.environ.keys():
> -            exported =3D True
> -        else:
> -            v_proxy =3D d.getVar(v)
> -            if v_proxy is not None:
> -                os.environ[v] =3D v_proxy
> -                exported =3D True
> +    origenv =3D d.getVar("BB_ORIGENV")
> =20
> -    return exported
> +    for name in variables:
> +        value =3D d.getVar(name)
> +        if not value and origenv:
> +            value =3D origenv.getVar(name)
> +        if value:
> +            os.environ[name] =3D value
> +    return os
> =20

"return os"?

Cheers,

Richard




