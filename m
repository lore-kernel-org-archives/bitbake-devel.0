Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F55C52D7C
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 09:14:21 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.12151.1724404456003595704
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Aug 2024 02:14:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h/1g0y1d;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso17372195e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Aug 2024 02:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724404454; x=1725009254; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRSXEgZY4lPfyannNLeIFK5uMgMRcSZu/lSdDCTcDZE=;
        b=h/1g0y1d6xVvBx3jN38ws4QeLlfQD/Yx+Yumfa6rh91XZNIxwAtS9RMS/VbhGoCgsk
         BltLnEj51WLwbAnmdFZ1SJwWWpIGvzxuJrJ1rnQdj0ZFHZVF1KWWQkq8kUFPu19YOLOz
         LdP7JNq9aGR/PtV5M1f/g6D1AYtPy+NALDhK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724404454; x=1725009254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRSXEgZY4lPfyannNLeIFK5uMgMRcSZu/lSdDCTcDZE=;
        b=q5yN4C8bYQHrNfsp500t0BHH7vzmHt3mUypSJSzLGrvbrK4FD5/2m07f5Z2FYYOA3E
         /HpR/yxFJQ1f0IsaFf74WrePqrAH0dULfSgXTFj2OjgR7Xeef/em/f7Tb4CkwgOyg743
         B/2XDws7Ui0BuAhfaTp2lCFiwl/3waY2q8R1l2TKF3XakMJC6wZcCuusnjdBgEa6f4FM
         6G/74oyqsPtQvpRB+aTv9X3pTF21qx/y0v3e8l14OnMgoRDLtvckAczyQYi285i8xjru
         npKGc7XOwRhJVuG1114KzkD866NZ2q/S1CvkxhKA4MpkEBeEcMqEp+mMh+KMIBH9ZoMD
         SYtA==
X-Forwarded-Encrypted: i=1; AJvYcCVmNGm3YSyVHmUjL7lnpnA0ln/4Fd6vYDYYp9BG5Y+1RYTLmROPUqMJexDTWswxgGFQaadu0C/WNlvigVg1@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx6uwY2X0YMnkRwCfhoduFlxMJm4ItGfQGc5HtuurvrSHPnLKeO
	6XUxN9aARQbWxUZZx7/ORqpPlMGeuhC0TJxZ58pmsvvQP9WqmI0R/6bqo3m5ITE=
X-Google-Smtp-Source: AGHT+IFk8z3mDzIZcT1ZcopQGY8Bmh4IHwQ98z+DrdFUrxEunfM4dG4SeFM1aOcBI7YnKrCvxPDkFA==
X-Received: by 2002:a5d:58fb:0:b0:371:8685:84e with SMTP id ffacd0b85a97d-37311855f8dmr1121622f8f.22.1724404454240;
        Fri, 23 Aug 2024 02:14:14 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f4f5:df28:3cf9:5842? ([2001:8b0:aba:5f3c:f4f5:df28:3cf9:5842])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c5edsm3677405f8f.31.2024.08.23.02.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:14:13 -0700 (PDT)
Message-ID: <7c8eab24043fb9f05c2df8ebe4f55d724595c977.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] gcp.py: remove slow calls to gsutil stat
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ecordonnier@snap.com, bitbake-devel@lists.openembedded.org
Date: Fri, 23 Aug 2024 10:14:13 +0100
In-Reply-To: <20240823084108.1106312-1-ecordonnier@snap.com>
References: <20240823084108.1106312-1-ecordonnier@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Aug 2024 09:14:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16520

On Fri, 2024-08-23 at 10:41 +0200, Etienne Cordonnier via lists.openembedde=
d.org wrote:
> From: Etienne Cordonnier <ecordonnier@snap.com>
>=20
> The changes of 1ab1d36c0af6fc58a974106b61ff4d37da6cb229 added calls to "g=
sutil stat" to avoid unhandled exceptions, however:
> - in the case of checkstatus() this is redundant with the call to self.gc=
p_client.bucket(ud.host).blob(path).exists() which already returns True/Fal=
se
> =C2=A0and does not throw an exception in case the file does not exist.
> - Also the call to gsutil stat is much slower than using the python clien=
t to call exists() so we should not replace the call to exists() with a cal=
l to gsutil stat.
> - I think the intent of calling check_network_access in checkstatus() was=
 to error-out in case the error is disabled. We can rather change the strin=
g "gsutil stat" to something else to make the code more readable.
> - add a try/except block in download() instead of the extra call to gsuti=
l
>=20
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
> =C2=A0lib/bb/fetch2/gcp.py | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
> index eb3e0c6a6..9ac2f752f 100644
> --- a/lib/bb/fetch2/gcp.py
> +++ b/lib/bb/fetch2/gcp.py
> @@ -19,11 +19,11 @@ Additionally, gsutil must also be installed.
> =C2=A0
> =C2=A0import os
> =C2=A0import bb
> +from google.api_core.exceptions import NotFound
> =C2=A0import urllib.parse, urllib.error
> =C2=A0from bb.fetch2 import FetchMethod
> =C2=A0from bb.fetch2 import FetchError
> =C2=A0from bb.fetch2 import logger
> -from bb.fetch2 import runfetchcmd
> =C2=A0
> =C2=A0class GCP(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0 """

I put this into a testing branch and everything broke since the google
module isn't present in most places. I've moved the import into the
download method.

Cheers,

Richard

