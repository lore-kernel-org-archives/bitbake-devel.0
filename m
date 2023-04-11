Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD6C77B6F
	for <webhook@archiver.kernel.org>; Tue, 11 Apr 2023 16:50:53 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.19905.1681231845381158698
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Apr 2023 09:50:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YCS2avQd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so12611619wmb.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681231844;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGiTap8hIvsY5uMqLvaSU3s4KRq7D7yrXo1rDN4uCqY=;
        b=YCS2avQdvbCJnU4HKVHoTgMLytBE9rpQmRXVYIqbYWPutwBZNdwGhzrDh0SztiJTOZ
         K4e2Vg+Ins/5seAHuNz2Rc7whLJP9ZalRzXTXtBvipkaKnR1gm+vqtRg3mGjRMqNoKrM
         NgIr0jd0n+SVncNG+hWA14Gnfr0jxk8ZFfWUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231844;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UGiTap8hIvsY5uMqLvaSU3s4KRq7D7yrXo1rDN4uCqY=;
        b=vnV7bx4SHDU+ddxaaluf1Mcc85TiNBSzU/pVV5ELk1bwBckSKhDZ+VIRg7p4PkMywz
         Z8xwxfleEhkMF0dRED4IcfNIV9Xo6MwMhZoJOS7hImPK46fnwkvwGbLMiCkkubruzUpQ
         egwA8nlhdox74Zh74W85rKCMpUhrB0T1UxOKPKH6im62roVapthH8kd5/Ctn4FuFyRwW
         G8y5zdhV1KrMtKS6zl+O2bwCTD5bz7iIl2H2SWzy7Ksa4iWFb6Sf9wIiSuCYOSeNI0lG
         T9AI1mIMf7mHoRN4YjyJwpRue0k+Pok27Gba6vXxIKWZF2P7W7ep+aUlypNF7VNC7rhU
         P3ow==
X-Gm-Message-State: AAQBX9fn686VXeYtK+njvbdRcgOg/fYPTNgkBRfSixKcYKy+fyhSm2p+
	FMhjAFIZFMAZ/Lls1kfgZ/1FofVHNi2Y/AAzS6w=
X-Google-Smtp-Source: AKy350ZLXqI1zSrGqRsbsMvPRPgzrX4nSOYeB25vCtW/vJGoP5ohKlwDZf8QPILk9IsuaGTd/wHNhA==
X-Received: by 2002:a1c:7c11:0:b0:3ed:2a91:3bc9 with SMTP id x17-20020a1c7c11000000b003ed2a913bc9mr8070178wmc.15.1681231843834;
        Tue, 11 Apr 2023 09:50:43 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:d973:4e5f:b43e:78a5? ([2001:8b0:aba:5f3c:d973:4e5f:b43e:78a5])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c00ce00b003ed243222adsm17452567wmm.42.2023.04.11.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:50:43 -0700 (PDT)
Message-ID: <bed59afa659823a6656aa978168330642648811a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] event: add bb.event.ParseError
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Yu, Mingli" <mingli.yu@eng.windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 11 Apr 2023 17:50:42 +0100
In-Reply-To: <20230410091900.2897894-1-mingli.yu@eng.windriver.com>
References: <20230410091900.2897894-1-mingli.yu@eng.windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 16:50:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14693

On Mon, 2023-04-10 at 17:19 +0800, Yu, Mingli wrote:
> From: Mingli Yu <mingli.yu@windriver.com>
>=20
> Add bb.event.ParseError to let error-report can catch this kind of error.
>=20
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  lib/bb/cooker.py | 6 ++++--
>  lib/bb/event.py  | 8 ++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 1797a1d4..206f8ffb 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -2223,7 +2223,7 @@ class CookerParser(object):
> =20
>              self.results =3D itertools.chain(self.results, self.parse_ge=
nerator())
> =20
> -    def shutdown(self, clean=3DTrue):
> +    def shutdown(self, clean=3DTrue, eventmsg=3D""):
>          if not self.toparse:
>              return
>          if self.haveshutdown:
> @@ -2238,6 +2238,8 @@ class CookerParser(object):
> =20
>              bb.event.fire(event, self.cfgdata)
>          else:
> +            if eventmsg:
> +                bb.event.fire(bb.event.ParseError(eventmsg), self.cfgdat=
a)
>              bb.error("Parsing halted due to errors, see error messages a=
bove")

Shouldn't this always fire the event even if there is no specific error
message?

Cheers,

Richard


