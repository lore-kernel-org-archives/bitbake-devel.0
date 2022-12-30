Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE9C3DA7D
	for <webhook@archiver.kernel.org>; Fri, 30 Dec 2022 15:46:24 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.20790.1672415174473856125
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Dec 2022 07:46:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=PBkOVZM3;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672415174;
  x=1703951174;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wC4f9YROSbd5qBvmEy+ATubTpLWvRsaoJyqUv08aUPI=;
  b=PBkOVZM33HmZvFI3Cgu9cvk7ce66Fi7ss3imDCxVr7Yjjbdg5IB0PyIb
   Zc10SpL5iP/0CqGt6ySWhDbHa21pCbCr+FmoNv+ygHJK797+ruAUj23ut
   2OtUts4sRw/yfHZa3ZwmtrdK8k00TEJ6aY9pay6wAJoMB/rx19XjIRp4I
   8k9af2FGDhMhi92/5Z2phWI/xod3PzkaDn/3/W+Q/ZiboEVxPCY6djpX0
   rUsWb2sf9TI41NKk7tHlcxfsvxDLzzLXg/VOmaghJCmeedMvHleS7chTe
   9G4DwbruPPuyTnUbC/TQfZhYuRkMV3xZ8AZU5gy1rcnBPHOuXP6g8b89L
   w==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 14/15] cache: Drop reciever side counting
 for SiggenRecipeInfo
Thread-Topic: [bitbake-devel] [PATCH 14/15] cache: Drop reciever side counting
 for SiggenRecipeInfo
Thread-Index: AQHZG6guDvBN/HQ0fEKDp2T6TrxC3q6Gk+iw
Date: Fri, 30 Dec 2022 15:46:12 +0000
Message-ID: <01f95d7bd4764f0c814347d9b712b524@axis.com>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
 <20221229170728.880367-15-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221229170728.880367-15-richard.purdie@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Dec 2022 15:46:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14260

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 29 december 2022 18:07
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 14/15] cache: Drop reciever side counting=
 for SiggenRecipeInfo

Change "reciever" to "receiver".

>=20
> Joshua Watt pointed out maintaining the counting on both sides of the
> connection isn't needed. Remove the receiver side counting and simplify
> the code, also allowing errors if the counts do go out of sync.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cache.py | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index 3fc097241a..ee924b2d2b 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -285,7 +285,6 @@ class SiggenRecipeInfo(RecipeInfoCommon):
>          cls.save_map =3D {}
>          cls.save_count =3D 1
>          cls.restore_map =3D {}
> -        cls.restore_count =3D {}
>=20
>      @classmethod
>      def _save(cls, deps):
> @@ -294,11 +293,13 @@ class SiggenRecipeInfo(RecipeInfoCommon):
>              return deps
>          for dep in deps:
>              fs =3D deps[dep]
> -            if fs in cls.save_map:
> +            if fs is None:
> +                ret.append((dep, None, None))
> +            elif fs in cls.save_map:
>                  ret.append((dep, None, cls.save_map[fs]))
>              else:
>                  cls.save_map[fs] =3D cls.save_count
> -                ret.append((dep, fs, None))
> +                ret.append((dep, fs, cls.save_count))
>                  cls.save_count =3D cls.save_count + 1
>          return ret
>=20
> @@ -309,18 +310,18 @@ class SiggenRecipeInfo(RecipeInfoCommon):
>              return deps
>          if pid not in cls.restore_map:
>              cls.restore_map[pid] =3D {}
> -            cls.restore_count[pid] =3D 1
>          map =3D cls.restore_map[pid]
>          for dep, fs, mapnum in deps:
> -            if mapnum:
> +            if fs is None and mapnum is None:
> +                ret[dep] =3D None
> +            elif fs is None:
>                  ret[dep] =3D map[mapnum]
>              else:
>                  try:
>                      fs =3D cls.store[fs]
>                  except KeyError:
>                      cls.store[fs] =3D fs
> -                map[cls.restore_count[pid]] =3D fs
> -                cls.restore_count[pid] =3D cls.restore_count[pid] + 1
> +                map[mapnum] =3D fs
>                  ret[dep] =3D fs
>          return ret
>=20
> --
> 2.37.2

//Peter


