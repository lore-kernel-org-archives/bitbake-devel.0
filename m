Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78769C64EC4
	for <webhook@archiver.kernel.org>; Wed,  8 Mar 2023 10:50:00 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.4105.1678272593012606020
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Mar 2023 02:49:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JqHxnpj3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id h11so14900874wrm.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Mar 2023 02:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678272591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SW0qRjy+HUk5sQb+BczPSQ+Jp2Qz6PtJ1YCZf1hiVg=;
        b=JqHxnpj3WctBZLstiphqeRiynwjDC6VWxpLAdYWqdvoPmRw5cdIkiTpYEGpD8mpvJ8
         OvxWOEj0oRXM9kHFscY45Lqej/QNrp4ktLMG9TswtH4pdAxIQDJe4D7u44RB6ilOjAVd
         mVJ/OPUZlNitdEukv7ClIxT8WQbQCP0H8iX/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SW0qRjy+HUk5sQb+BczPSQ+Jp2Qz6PtJ1YCZf1hiVg=;
        b=jSs5/75VXlPdJPRbLBLT8gtyWi2rjxm22C62UBXzvBWluYvBkuvZDHuuFd6XjXqcV8
         pp82pZOuWONjClCA/reJXFnaHE32Cd31xBkRVPYoASQqBSBLF7hyNYkGzPZbbgvXff9R
         WOAsRNFzF7g/GlstBEj5MfZPbDipMdMD6ea4OKl2Peuk7mmnarKo1AkvSS93M4SHHS7l
         HW3wMZi30GxQC9PLcGJQB1uaSjhG6pi2c727aScm6Pk2Zaw6eTA0KNO5qMhLUu51haCb
         03gJpwnGEP6Sac63GhVdyGIHTTESu+Xu35tN+xduxHixdkaBUARpX8wb0FOnnQuBu5f0
         7lKw==
X-Gm-Message-State: AO0yUKUk0qebNuAfHXiEJZNgH/YrfM9Pusvbk8GTRbwKLO2I7cQtCOpe
	JOKHW2Q77LhUZu8nOntLQBozOg==
X-Google-Smtp-Source: AK7set/JgChZl5FZ1V2VrLBQfelWOGtP0jW/2Y2hD/z+D5OHqVdWOx1ViI069vIx6TVaGYTOfdkB9w==
X-Received: by 2002:adf:db82:0:b0:2c7:df22:1184 with SMTP id u2-20020adfdb82000000b002c7df221184mr11389784wri.56.1678272591264;
        Wed, 08 Mar 2023 02:49:51 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1eb8:fdef:c144:ef0b? ([2001:8b0:aba:5f3c:1eb8:fdef:c144:ef0b])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4cd2000000b002c551f7d452sm15316015wrt.98.2023.03.08.02.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:49:50 -0800 (PST)
Message-ID: <9492b64c0e41f32dfe9afb8bf8e06f4e9e331c48.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] data_smart: fix library name contains
 special word cause do_package failed
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 08 Mar 2023 10:49:50 +0000
In-Reply-To: <20230308095539.651015-1-xiangyu.chen@eng.windriver.com>
References: <20230308095539.651015-1-xiangyu.chen@eng.windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Mar 2023 10:50:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14526

On Wed, 2023-03-08 at 17:55 +0800, Xiangyu Chen wrote:
> From: Xiangyu Chen <xiangyu.chen@windriver.com>
>=20
> When the package library name contains like _append/_prepend words
> and the pkg-config added those libraries to requires, the do_package
> would report an error message:
>=20
> "Variable xxxx contains an operation using the old override syntax.
> Please convert this layer/metadata before attempting to use with a
> newer bitbake"
>=20
> This was found on latest version abseil-cpp package due to there is
> a library name called "absl_log_internal_append_truncated"
>=20
> So discard to check a variable with "Requires" header in setVar()
>=20
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> ---
>  lib/bb/data_smart.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index c597dbad..fc33d34c 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -539,7 +539,7 @@ class DataSmart(MutableMapping):
>      def setVar(self, var, value, **loginfo):
>          #print("var=3D" + str(var) + "  val=3D" + str(value))
> =20
> -        if not var.startswith("__anon_") and ("_append" in var or "_prep=
end" in var or "_remove" in var):
> +        if not var.startswith("Requires") and not var.startswith("__anon=
_") and ("_append" in var or "_prepend" in var or "_remove" in var):
>              info =3D "%s" % var
>              if "file" in loginfo:
>                  info +=3D " file: %s" % loginfo["file"]

"Requires" seems like a really strange name for a variable to start
with, where is that coming from? I don't think we should be hardcoding
OE-Core specific datastore usage inside bitbake. We're definitely not
merging that as is.

Is this from the pkgconfig code in do_package? If so we should probably
take a closer look at what that is doing as it doesn't sound good.

Cheers,

Richard


