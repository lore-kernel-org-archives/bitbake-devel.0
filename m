Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D003C433FE
	for <webhook@archiver.kernel.org>; Sat, 19 Nov 2022 00:35:03 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.9962.1668818097993666819
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Nov 2022 16:34:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=RmBWeHMn;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1668818098;
  x=1700354098;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=XC/2SPi5L0m9+OlrIf22EQFJYxbZLLSrju/JuhWaJIc=;
  b=RmBWeHMn68CnKOgwFcBX0C6BpB1ETz4dIBHhVVshvtn4S168UUQyhcAk
   8af8xSyk49Ae44n+Ya09uGpFzPwHvluZrUy/IZ/N0mxzszWS5thqcTqrB
   y7mWMFF5oPSqix1CnYhEDeGleAYMCcUvjXziJjxNDx3FZm/BpSx0EYf7Y
   h2CQvpkdRxSH9KbSmoAtcBLg/bsJaCn9Eod77GIrMfk/PEqZFbQMAt3ts
   1kNSUVsBTCSgmu8n83Z89+F4QTsn+RIVem/2qMY7cxDpA3h/8UbtbkrOW
   Gx6+k9vfhOvCFRuwzL/W6qDGsdYtfzsmDRdo6ueIpw5oK8dsqlU9WAMQC
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/2] cache: Drop unused function
Thread-Topic: [bitbake-devel] [PATCH 2/2] cache: Drop unused function
Thread-Index: AQHY+bX4SZiOyVv40k2+OotngpXK4K5FacLw
Date: Sat, 19 Nov 2022 00:34:55 +0000
Message-ID: <945d11a4ce3048a490f2e43cc0c0d088@axis.com>
References: <20221116122125.2564989-1-richard.purdie@linuxfoundation.org>
 <20221116122125.2564989-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221116122125.2564989-2-richard.purdie@linuxfoundation.org>
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
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Nov 2022 00:35:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14091

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 16 november 2022 13:21
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 2/2] cache: Drop unused function
>=20
> At this point users appear to all cann add_info directly. Failing

Change "cann" to "call".

> to do that means the file dependency tracking code isn't active
> so would cause problems. Therefore drop the unused function.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cache.py | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index 22ca6f56e6..22ed3e80be 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -649,18 +649,6 @@ class Cache(object):
>                  self.cacheclean =3D False
>              self.depends_cache[filename] =3D info_array
>=20
> -    def add(self, file_name, data, cacheData, parsed=3DNone):
> -        """
> -        Save data we need into the cache
> -        """
> -
> -        realfn =3D virtualfn2realfn(file_name)[0]
> -
> -        info_array =3D []
> -        for cache_class in self.caches_array:
> -            info_array.append(cache_class(realfn, data))
> -        self.add_info(file_name, info_array, cacheData, parsed)
> -
>  class MulticonfigCache(Mapping):
>      def __init__(self, databuilder, data_hash, caches_array):
>          def progress(p):
> --
> 2.34.1

//Peter


