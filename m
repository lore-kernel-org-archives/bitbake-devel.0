Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D477C77B73
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 11:43:08 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.5736.1681990984398881380
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Apr 2023 04:43:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=gJ/PRh1v;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id v10so1072008wmn.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Apr 2023 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681990982; x=1684582982;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57Mr5AZlsHkzCk38eqr78ARMhac6JUJsuzNIiaMcmWg=;
        b=gJ/PRh1vEIMEDuJzMyKyZD94uhwfenmnmN1lfW1XElq/Rqs4j/edkE+2qJo/vKkSeI
         njDKUPPmG3pVQqYxgJ4teoNku/KlP5pe4XGTTrxUkDXS5ChHxW+NyyQKdYXsA3oKin8f
         abUDsnmL17TwEzXETEbGveqzAUD4tNQseQgiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681990982; x=1684582982;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57Mr5AZlsHkzCk38eqr78ARMhac6JUJsuzNIiaMcmWg=;
        b=RZF1jkF+yYV1F7Ty+SCdfkdxt4BVr2K9ufs2LJpf9esJg2+FNbmC3kDvfvdCv/UFpf
         q6ZgWTEnykfdYSnd+gG62OjqD1rEoFnX5ouRaXmJAljIwat6W2xySuifVpD7lobcPv0L
         j3MBYlYy027cofSwnRhy/JK8x2NPEJMbTfsheLnO8nyTS5NHnXJisRNKWR8TF+kSeKvG
         YuZuCPQZPPGVHwQ3fpGSt3deSGRCc44V7/PizTz0eHSFemeJLVqbDCcDcONfxrKVNsk1
         S+xwCO1VhS6Fp7TopLydaJdQ+eL8ja5CsbyRWbW+YV23cLi5jboGz2DqxoqSfNcWXX0t
         Ji7A==
X-Gm-Message-State: AAQBX9dcqBbuyNenn3ZGIjtpYTcJ7rwV3k/K1mT4lYHZ/lKJj46lX1fZ
	WcvlevJu8UQ6QznrVMoMS5sVxvjivuC7hPHha6Q=
X-Google-Smtp-Source: AKy350YZ2d7lfogZY7IAqpH1GHsr9UCm4zurOv1oAfbBeA6leFh3bbXm/vMUMZVYZuil2l0wMK3+rw==
X-Received: by 2002:a1c:ed13:0:b0:3f1:6cdf:93ac with SMTP id l19-20020a1ced13000000b003f16cdf93acmr1154389wmh.17.1681990982385;
        Thu, 20 Apr 2023 04:43:02 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ce55:21b0:963b:173c? ([2001:8b0:aba:5f3c:ce55:21b0:963b:173c])
        by smtp.gmail.com with ESMTPSA id o22-20020a1c7516000000b003f18372d540sm1779140wmc.14.2023.04.20.04.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 04:43:02 -0700 (PDT)
Message-ID: <b4f209d135c1dcf47253ba561ccbde128b0123e9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: git fetcher: use urllib quote
 ...
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: thilo.cestonaro@thalesgroup.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 20 Apr 2023 12:43:01 +0100
In-Reply-To: <PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
References: 
	<PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Apr 2023 11:43:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14726

On Wed, 2023-03-22 at 08:37 +0000, Thilo C. via lists.openembedded.org
wrote:
> to use the path url-compatible. This needs to happen before the shell
> quotation happens.
>=20
> Without this commit, spaces in the clone URL will be used as " " and
> not as "%20" which will fail.
> This commit changes the " " in the URL to "%20" when it is a http or
> https url.
>=20
> Signed-off-by: Thilo Cestonaro <thilo.cestonaro@thalesgroup.com>
> ---
> =C2=A0lib/bb/fetch2/git.py | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 578edc59..dc7f848d 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -66,6 +66,7 @@ import re
> =C2=A0import shlex
> =C2=A0import subprocess
> =C2=A0import tempfile
> +import urllib
> =C2=A0import bb
> =C2=A0import bb.progress
> =C2=A0from contextlib import contextmanager
> @@ -697,7 +698,12 @@ class Git(FetchMethod):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0username =3D ud.user + '@=
'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0username =3D ""
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return "%s://%s%s%s" % (ud.proto, username, =
ud.host,
> ud.path)
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D ud.path
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.proto in [ 'http', 'https' ]:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D urllib.parse.quote(ud=
.path)
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return "%s://%s%s%s" % (ud.proto, username, =
ud.host, path)
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0def _revision_key(self, ud, d, name):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"""

I'd like to ensure that we add test coverage to "bitbake-selftest" to
cover this situation (see lib/bb/tests/fetch.py).

We tend not to accept fixes like this unless we have test coverage to
prevent future regressions.

Cheers,

Richard



