Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF65BE9A04D
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 16:32:45 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17794.1771518761044568241
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Feb 2026 08:32:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P1DPSCjI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so206181366b.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 08:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1771518759; x=1772123559; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFPJMC6nn+mDNnMYwCKMGET9NVSjNnD70yRmXhHOfP4=;
        b=P1DPSCjI0FTag5Jc8JzI7B3b+5eFJVSuhmNYgWcZF9+KTmP3IijmCyLKB+oD4B3i4f
         1e1QkFG6Yl1MPcLx2MoIBgKlYTHWd1wHPIgI+OqJ1UJ6TaAWT3p6UbgKXQ3eLNkr33FO
         HRkDyjiiLADEFdshfYd1mBpdr/LuXiLPesSR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518759; x=1772123559;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFPJMC6nn+mDNnMYwCKMGET9NVSjNnD70yRmXhHOfP4=;
        b=iNeK65JyObK9YtexbJrPH1Jdd7vqSsJ76AJCdp/ZSGVVQShmwc6ysPlh0Pe7n7zq1T
         pMI8Ll4zQO91OfO5qRNuKCS0Kbqxwwt2a6B2iV8O3CR1QNgYjuZnY05FQKXRWE7Dy1FJ
         TFABVlTfi/jcs7SSdkQodprsbHM0lsyG+1Cz/Bp2o7ejYhmNE+qCWuc4way8REMpcDe5
         VRlQFV/WRIYRUzZqNcVJVft3eHKAvDZGHzEXiffJIqIM0AqZvtNL29MP9xrt2bdbbp3c
         alGAGQotsj92mJ3NV5C4i31JAHzWKDecx/K6tTp44WWX/+jmv/XEKqS+R+5xp8htH9LU
         qL1A==
X-Forwarded-Encrypted: i=1; AJvYcCWhlEoNcrw2rGpzW5lJsDKJIQhJu38WGSEY1YTnx1ATxlvSrw4SFS/uwX5sjGetGyvKBbGd//scLiTA76Ax@lists.openembedded.org
X-Gm-Message-State: AOJu0YzqvngGZansxJthqEcAkC25DG8zBrnV7X5Y07hC+GBZM7NL5fWM
	3e5Pt1yFhWia9CTGJE7wvfDR8qHw9+0edHdyl3bRH2E5do+nHtN8yGuXDnuLoNz9yaKFsEbPG7x
	NNOZPt4Q=
X-Gm-Gg: AZuq6aK72dEUcQf9zsBwimvRk4Xh2M40+Z5hPWLvBDwh1bCf+eyc3rhq/fHCw/5yo78
	Nu77ni45pITcjuA4t3C4IFZq3pTyFdGuKepC+fbO6a+1bEk3G9dLTeWbI3+hJ54q2xGBoc+Z3G5
	ocNeMpeDqSwN4EKk4a4Y0wwHGCQTWHMOQ9ajUwMDWFcI6E2q7XKs/e6+tHIrfdGf+h5ajYfROOH
	53nSniUnrOzvh32LsZ3ttB/3cAiW1zG2cYdgMV/raK2VLqx1TaVP45xM/l+hUowrfQeUW8SzVPs
	jfXizJ8tm5RQpPRnppnXZd71fbtmrYsT8vwFYxB7eR8S0tLAEd+Xk5s6WkrM0vC1Dr//TZgzRXo
	01+58pzutJh/Vx1YMSEWDBbcrLFuqR9Eapz48L1h1NtvPDZ2P/kZC9QQs7cY21kY5/Hsv8kXQ5F
	+Zukyztd3BonT94JVVohXwsNy1/d7IOLoiHfG7fpr+8kNAmGLbX/R68dRx0AXdgzQBRZMXw+9C4
	ESrCt7ZM4JUKUI=
X-Received: by 2002:a17:907:c04:b0:b88:48ba:cd7 with SMTP id a640c23a62f3a-b8fc38f190emr1036990266b.3.1771518759017;
        Thu, 19 Feb 2026 08:32:39 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:da95:be37:6ded:ea39? ([2001:8b0:aba:5f3c:da95:be37:6ded:ea39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc73f7c24sm595514766b.30.2026.02.19.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:32:38 -0800 (PST)
Message-ID: <eeda7effdc1bda1ac5422ac7cc8095d46021a578.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v2] cookerdata: Include "originating"
 recipe name when parsing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: JPEWhacker@gmail.com, bitbake-devel@lists.openembedded.org
Date: Thu, 19 Feb 2026 16:32:37 +0000
In-Reply-To: <20251219223620.2222861-1-JPEWhacker@gmail.com>
References: <20251030141904.69494-1-JPEWhacker@gmail.com>
	 <20251219223620.2222861-1-JPEWhacker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Feb 2026 16:32:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19069

On Fri, 2025-12-19 at 15:36 -0700, Joshua Watt via lists.openembedded.org w=
rote:
> When a bbappend file is parsed, the FILE variable is set to the name of
> the actual file being parsed (e.g. the name of the bbappend). Since
> PN/PV etc. are derived from FILE, this means that they can be
> misleading in the event that bbappend is using wildcards (e.g. PV might
> have the value of "%" instead of the actual version number).
>=20
> In order to allow bbappends to derived the actual information of the
> recipe, capture the name of the original recipe being parsed as
> ORIG_FILE when parsing a new recipe.
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
> =C2=A0lib/bb/cookerdata.py | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 22ac95eac..fe41bb3bf 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -512,6 +512,8 @@ class CookerDataBuilder(object):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb_data.setVar("__BBMULT=
ICONFIG", mc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb_data.setVar("FILE_LAY=
ERNAME", layername)
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb_data.setVar("ORIG_FILE", b=
bfile)
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bbfile_loc =3D os.path.a=
bspath(os.path.dirname(bbfile))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.parse.cached_mtime_no=
error(bbfile_loc)

We discussed this a bit on the review call today, I appreciate Joshua
wasn't there but it made sense to try and unblock this.

In brief, the concerns mentioned were:

* no tests/docs
* not wanting to encourage wide use of this
  (conflicting with the above)
* whether the name is right

The idea of using a __ prefix for the variable was mentioned. That
would allow Joshua to address the issues he has but not make it
'official' recommended API. That might be the compromise we need.

For the name itself, I'm really torn. For variables which bitbake
itself responds to, I've tried to standardise on a BB_ prefix. This is
more a variable bitbake exposes for use elsewhere and we have the FILE_
prefix already being used but I'm torn on whether we should continue
that theme or use something with BB_...

Cheers,

Richard










