Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B3C433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:49:12 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web09.11926.1645289351481821094
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:49:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=K8qHbOz8;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1645289352;
  x=1676825352;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=4oiSkYjhTFeWXoqntvvhX1vNLbWg9VaZjvHorv4Vqtk=;
  b=K8qHbOz82dVQmiThE/F91aSMyPpfayT7/JJY+tNxCBSpfbJoBggzQ9hI
   S2Otm+YkkVy1yho9qMNUPZvMtTfUlMFjg6b1300FVMIVIYcW7VecHPauV
   AQWp9d2oCm7VVLZUshjUGLGXX7egFSr0ugmM9YXO3f2FMNiQJNh4nvslq
   WdzXyAhnzCDfh05NnyRD/1ec8pL7JE6mR9vNib7SpP7FGFtcloch+pjPe
   NAjpEQtlTIYT0eMOD7SrcP6jZmMV6+7Xg2TSvVxMeOCMmuzQ2YR89xZar
   m+aIk48Z+cnl9gtN1ydr9J6ZPLX7wBKsJVqoSdDUjCwDYbxKngT0nG67o
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "zygmunt.krynicki@huawei.com" <zygmunt.krynicki@huawei.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] wget: move loop-invariant load of
 BB_ORIGENV
Thread-Topic: [bitbake-devel] [PATCH] wget: move loop-invariant load of
 BB_ORIGENV
Thread-Index: AQHYJbAA3pJrbtWstkGM2U1lxfUxE6ybFV/Q
Date: Sat, 19 Feb 2022 16:49:09 +0000
Message-ID: <c271185878ce4234ac15cbf78b3cdaa7@axis.com>
References: <20220219164439.8534-1-zygmunt.krynicki@huawei.com>
In-Reply-To: <20220219164439.8534-1-zygmunt.krynicki@huawei.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:49:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13386

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Zygmunt Krynicki via
> lists.openembedded.org
> Sent: den 19 februari 2022 17:45
> To: bitbake-devel@lists.openembedded.org
> Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
> Subject: [bitbake-devel] [PATCH] wget: move loop-invariant load of
> BB_ORIGENV
>=20
> BB_ORIGENV is used as a fallback environment block. It is repeatedly
> access inside the loop. Since it is a loop invariant, move it out of the

Change "access" to "accessed".

> loop.
>=20
> Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
> ---
>  lib/bb/fetch2/wget.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index 253cabce..9a3a9d66 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -316,10 +316,10 @@ class Wget(FetchMethod):
>          # to scope the changes to the build_opener request, which is whe=
n
> the
>          # environment lookups happen.
>          newenv =3D {}
> +        origenv =3D d.getVar("BB_ORIGENV")
>          for name in bb.fetch2.FETCH_EXPORT_VARS:
>              value =3D d.getVar(name)
>              if not value:
> -                origenv =3D d.getVar("BB_ORIGENV")
>                  if origenv:
>                      value =3D origenv.getVar(name)

You can simplify it to:

            if not value and origenv:
                value =3D origenv.getVar(name)

>              if value:
> --
> 2.25.1


