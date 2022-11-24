Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8623C4332F
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 17:04:11 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.28957.1669309444813737413
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Nov 2022 09:04:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OezbKBw1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5so1725936wmo.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 09:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cub116ttEsjEkikTKdBTEUo6GU6usLXqnzxKIsCxjl4=;
        b=OezbKBw1TIbQf0xPjHLweFCFQzdaOBj57/r/JdK6fjmXLUBI/LGSacCTpaG4DToCYo
         ixbAn62PW+58RZgL0sKHwLycW8etOvtwCKr0VuTV4isDCT8K22ZmDYVYXuWu4cIBy3/V
         ADJT4L4LrLVaapvExZ+saIsNwbb5jN6fHCySA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cub116ttEsjEkikTKdBTEUo6GU6usLXqnzxKIsCxjl4=;
        b=msQga+uhLsiL92AhEOZdhS02T9ioEluihHZ4MVMwj+8ZK9gaDsxBfnDvnX2hWt5Ize
         0czwp9cFTTgTieYm+m/6xv4DdcQbL5WFy0JTYhb1wTaCx3tKI1gnrh+0m4GPuc7ldEOb
         GDprE9WFlxTUINWwouBp+HgiOZ0HBfd+ZwH1fnLkDpkW/vgyaiSLhkT37vIQnuvPxZp8
         jBfS9pmm1iH/pVKS1/+0zu0I0FoxeINi0EIJMMjnEtB8plHBw/H7AuDAc/19myANXW6q
         zFQaFyrtk+Xh64KAlRuojhiXjhoHPB7BrUJEE8Q8WITsJnoq+NO4yAcfeaz6yZqLms5X
         63EA==
X-Gm-Message-State: ANoB5pnOH+2XR0qyk5Nybt3+byaoJ8vfqz3kAlPfbWzR420zhiJhb6FP
	ehhrnUlfGgTgVSRefdF2REtqFw==
X-Google-Smtp-Source: AA0mqf7RsoU7CIpxbEbKcpin6sXgYSAgzCtMcSe97+9rpOlLz+qRlxrPPpqD4oodT1s1LiKVMXv4/Q==
X-Received: by 2002:a05:600c:4fd6:b0:3cf:d952:db2b with SMTP id o22-20020a05600c4fd600b003cfd952db2bmr8299120wmq.19.1669309443055;
        Thu, 24 Nov 2022 09:04:03 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:4038:3d32:5f00:5957? ([2001:8b0:aba:5f3c:4038:3d32:5f00:5957])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b003a2f2bb72d5sm7873048wmo.45.2022.11.24.09.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:04:01 -0800 (PST)
Message-ID: <10122bb1047aebb8b7e7225704cf41090ac61b3e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] using same logic for overrides
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: zzs <zzs213@126.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2022 17:04:00 +0000
In-Reply-To: <20200930031129.9934-1-zzs213@126.com>
References: <20200930031129.9934-1-zzs213@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 17:04:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14111

On Wed, 2020-09-30 at 11:11 +0800, zzs wrote:
> From: =E5=BC=A0=E5=BF=A0=E5=B1=B1 <zzs213@126.com>
>=20
> Signed-off-by: =E5=BC=A0=E5=BF=A0=E5=B1=B1 <zzs213@126.com>
> ---
>  bitbake/lib/bb/data_smart.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
> index 7f1b6dcb4f..7689987f05 100644
> --- a/bitbake/lib/bb/data_smart.py
> +++ b/bitbake/lib/bb/data_smart.py
> @@ -648,7 +648,7 @@ class DataSmart(MutableMapping):
>          if '_' in var:
>              override =3D var[var.rfind('_')+1:]
>              shortvar =3D var[:var.rfind('_')]
> -            while override and override.islower():
> +            while override and __override_regexp__.match(override):
>                  try:
>                      if shortvar in self.overridedata:
>                          # Force CoW by recreating the list first

This looks like it is against dunfell and not master? I'll tweak it to
apply there though, thanks.

Cheers,

Richard


