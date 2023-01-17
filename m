Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7D3C38147
	for <webhook@archiver.kernel.org>; Tue, 17 Jan 2023 23:13:40 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.2137.1673997215055858036
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Jan 2023 15:13:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ceYqTF1i;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso291112wms.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Jan 2023 15:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4Jk2wT4xGJprZuFi2zPtOwXAXI0zvfU1W67cHak9hQ=;
        b=ceYqTF1iY3+M9+zARVX9oHp5ePDdxY5seEw4zWy6xdXA4f8QSHxT67EiJhrMHnjbHg
         uXXT+7G92lEWm9OPKe3Q2CR45bdTvBaIG1zqkZgIjGVHBkLZWtreebqEtYNKGlWrMjf9
         qPAYdbAEglhnWybqigOt9iAKGO1Sd3EclC+RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4Jk2wT4xGJprZuFi2zPtOwXAXI0zvfU1W67cHak9hQ=;
        b=Z5g6XDJnKZEChGwRtGMGBiuoCz4Sd3JIS1MDOl32liOYpKy9PRCF+TNK/HZQrbzTrS
         uju0ULRv0LcvxXrZEokX5MoEueG883QP3rrSBkKzlGTUefBVRmQyTQrWdRywBLb/iMW5
         Qq7xxa0bLWbk8kTD3O+ES9SZEB/T/Hjfu9hBvjjxhMMUaUDZUZ77xK9fo41qUirzlk+u
         IVUeZ7ts6MRcI58oztmp3j/gZNSqLlqMHYPDM0mBZMe4aKNU7+ooUx3toEiHJ2XioQNG
         3Z51iHRMHic38GVX0CMFsR0T+DK2KcWXjM+BqLAPvsqKua7liXdr6yrjDc3icQF5bB+i
         R3UA==
X-Gm-Message-State: AFqh2kquNlIRFoTiwESRdKT3pIi3OKFUItEduVl0eE8RK0JgWsyMzCcF
	Su+fqNQuah8NWh4XNIUSouxbm5ZXkAa8nzPY
X-Google-Smtp-Source: AMrXdXuMbSy4ENFMnjjhh13Xr3543MY9w8btJwjwGtSESMOFL7stTreJxtDNp08x9Vti7w6DfFDasg==
X-Received: by 2002:a05:600c:1c1a:b0:3da:fbd2:a324 with SMTP id j26-20020a05600c1c1a00b003dafbd2a324mr4556803wms.36.1673997213113;
        Tue, 17 Jan 2023 15:13:33 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:54cb:642:5dda:e3f7? ([2001:8b0:aba:5f3c:54cb:642:5dda:e3f7])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003db0a08694bsm253441wmq.8.2023.01.17.15.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 15:13:32 -0800 (PST)
Message-ID: <c510d7c971e772ce0c2c50229862e2b475e5c4a3.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2: kill parameters in
 uri_find_decoded
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Pavel Zhukov <pavel@zhukoff.net>, bitbake-devel@lists.openembedded.org
Date: Tue, 17 Jan 2023 23:13:32 +0000
In-Reply-To: <20230117153643.21716-1-pavel@zhukoff.net>
References: <20230117153643.21716-1-pavel@zhukoff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Jan 2023 23:13:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14320

On Tue, 2023-01-17 at 16:36 +0100, Pavel Zhukov wrote:
> Fixes:
>   File "/bitbake/./lib/bb/fetch2/__init__.py", line 446, in uri_replace
>     if uri_decoded[loc][k] !=3D uri_find_decoded[loc][k]:
> KeyError: 'module'
>=20
> Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
> index 893ec6f6bd..b1cd6b25c2 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -469,6 +469,7 @@ def uri_replace(ud, uri_find, uri_replace, replacemen=
ts, d, mirrortarball=3DNone):
>                      basename =3D os.path.basename(mirrortarball)
>                      # Kill parameters, they make no sense for mirror tar=
balls
>                      uri_decoded[5] =3D {}
> +                    uri_find_decoded[5] =3D {}
>                  elif ud.localpath and ud.method.supports_checksum(ud):
>                      basename =3D os.path.basename(ud.localpath)
>                  if basename:

The fix looks reasonable but is there a test we should be adding to
cover this scenario?

Cheers,

Richard


