Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5BAC636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 07:53:46 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.9696.1676274819788711220
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Feb 2023 23:53:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P75zMjxT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso2922982wmo.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Feb 2023 23:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr115XOv8MbnW0UAZuDbMlicS6Xp1jVgcmzuQsxd2+k=;
        b=P75zMjxTsHM8jSZdJN9rnPmup5refHm2PlUe7E3W9zUtv8kNy67u8hBRSIvfnhmf8v
         mCQuqcwxlpruS6v2y4nLYGJzaNm09IN4pS2fUJaq7l8Zqiau0lvRg7ZJ764tgFDFjGbW
         GXrfT1puuE5t/d13ixRfzcztz513JDXI/OTMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wr115XOv8MbnW0UAZuDbMlicS6Xp1jVgcmzuQsxd2+k=;
        b=CsZlD++iE+9UPkdw0Md8L11eK/7+TpWKp3L4Io/qmVw+0EVe4L4lQ4V/BkSgTNVcQD
         xjUj3yv2QkLIgfLvBpadfAGgOpp4/uy3iipSdshzP+R9dvLiEdFIsm1sOXEDQJnnfnla
         N2WsfhK1sqiO2TdjanYeLJwjxglKH02xaD0dV3dwlD1s7IP1JitGW8lrhD7g20daGmE/
         0LPjGTaE3fTWWVK0MeiXo/tOF91qQ8kGpkvYlYFZ89byR8qISzZ4So6ua1vGlZtinB8A
         5Z2cmlFpzTArOSfGnEFnKq1m96WXh2gLoVRvk+yj+Q84wPDadcwI+ZpdQG0r7soiv64/
         CrAQ==
X-Gm-Message-State: AO0yUKUKh3C5i0FBz/SU340auRRcyOosRA0eDDaiQH3P3WueUpsc2+N/
	AmxzjuyzS+O7QYI1OTPIq4r4dw==
X-Google-Smtp-Source: AK7set8lvCbFUGTUzuMamwiCE3+8FuKjdbpufrJGjuE1cKC66hAGeTwFL+02eYPjR86AZuvP8JjYUw==
X-Received: by 2002:a05:600c:18a6:b0:3e0:e77:3056 with SMTP id x38-20020a05600c18a600b003e00e773056mr18463428wmp.30.1676274817882;
        Sun, 12 Feb 2023 23:53:37 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3ff9:6f9f:20be:c939? ([2001:8b0:aba:5f3c:3ff9:6f9f:20be:c939])
        by smtp.gmail.com with ESMTPSA id w23-20020a1cf617000000b003db1d9553e7sm16106580wmc.32.2023.02.12.23.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 23:53:37 -0800 (PST)
Message-ID: <77ea3ba616f423c96506e15482affd37d78dcaae.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] action.py: add BUILDDIR in
 bblayers_conf path for add-layer
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Pedro Baptista <pedro.miguel.baptista@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 13 Feb 2023 07:53:36 +0000
In-Reply-To: <20230212002024.5430-1-pedro.miguel.baptista@gmail.com>
References: <20230212002024.5430-1-pedro.miguel.baptista@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 07:53:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14396

On Sun, 2023-02-12 at 00:20 +0000, Pedro Baptista wrote:
> From: Pedro Baptista <pedro.miguel.baptista@gmail.com>
>=20
> By including the full path to bblayers.conf the add-layer
> command can be executed from any location, not only from the
> build directory.
>=20
> Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
> ---
>  bitbake/lib/bblayers/action.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action=
.py
> index 454c251410..76a2c5acd2 100644
> --- a/bitbake/lib/bblayers/action.py
> +++ b/bitbake/lib/bblayers/action.py
> @@ -37,7 +37,7 @@ class ActionPlugin(LayerPlugin):
>                  sys.stderr.write("Specified layer directory %s doesn't c=
ontain a conf/layer.conf file\n" % layerdir)
>                  return 1
> =20
> -        bblayers_conf =3D os.path.join('conf', 'bblayers.conf')
> +        bblayers_conf =3D os.path.join(os.environ['BUILDDIR'], 'conf', '=
bblayers.conf')
>          if not os.path.exists(bblayers_conf):
>              sys.stderr.write("Unable to find bblayers.conf\n")
>              return 1

We need the logic to be consistent with how bitbake itself finds
bblayers.conf. Bitbake doesn't know about BUILDDIR, I think it uses
BBAPTH. We should try and share the same logic.

Cheers,

Richard


