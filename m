Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C34C433FE
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 12:02:00 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.21987.1669291316667500171
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Nov 2022 04:01:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TAqwnyl7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id t1so1138616wmi.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 04:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x1pb5qs4c6u/7LXFkJIGzYbwBu759sPb9l6MV4u67M=;
        b=TAqwnyl7X8iN0yr5+0iH6fEp6Yx+Z/oMbNwKWuriitZQx59no0LVzbOZjLxV9Sb84U
         XqAoCCImlSWE5U/h/fhom8aDN4W/k7mA09pRbZIw4oVQkrUZ7D6PBV0bY3yGkSLs8xgo
         nV5Ar+0mSnVbh0AsbXEdu7gL+LAoqE+St3vgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9x1pb5qs4c6u/7LXFkJIGzYbwBu759sPb9l6MV4u67M=;
        b=ZdWBO1WsUjlDT4eu+cpVs/0Ehi2lYYNmf/jDgoR42lF+PUIQ/vyn4WUGg+5Bc56w6W
         gcDspWiGEzNgbT+p1E23iQMPDm8ioX/pDl73sJB9i6jWX5me1kySVuS9ChnU6d4Lkqg9
         EnAlA+RDY1qEZNJLHZ2SYrm6Dpta4K1uoAJbLYnfChXTgtopUhSlZ1SCjESajyMGFIth
         AHzw3pbYsx8tkkUFt8GZXuuAbn1nihX0BllOa2KVopASyqDwC6pu1ffYbsfmkgTevdf6
         umBTac+6CBCn2ImttMkRAG60LTqQzYc9NcQst/FApazp9S7O/pC0k5/i5AtjaZix8b3L
         K4cw==
X-Gm-Message-State: ANoB5pn+haMHfCw+F7njuajnlpRdtwsY1dHJJ7G9wisVKiblBV7F2esD
	7CdEaSx8FA+Lru1UH9MRLWpEplW1kIgFGA==
X-Google-Smtp-Source: AA0mqf78Aif6jFf8f8UBWQgSXdRJ36l4w9n2oa+g9Rsz/IQFgWdkLL9Um0+tVYEKm0wElqIIxUw8Qw==
X-Received: by 2002:a05:600c:600c:b0:3cf:81b1:bc7b with SMTP id az12-20020a05600c600c00b003cf81b1bc7bmr14080686wmb.121.1669291314930;
        Thu, 24 Nov 2022 04:01:54 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:4038:3d32:5f00:5957? ([2001:8b0:aba:5f3c:4038:3d32:5f00:5957])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d668b000000b00241bc4880fesm1130446wru.111.2022.11.24.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 04:01:53 -0800 (PST)
Message-ID: <089c8b5944101a3ec48844fc744d7b6fd1558931.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] command.py: cleanup
 bb.cache.parse_recipe
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chen Qi <Qi.Chen@windriver.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2022 12:01:50 +0000
In-Reply-To: <20221124091045.12018-1-Qi.Chen@windriver.com>
References: <20221124091045.12018-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 12:02:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14106

On Thu, 2022-11-24 at 01:10 -0800, Chen Qi wrote:
> The parse_recipe has been removed from bb.cache, replace it with
> the databuilder._parse_recipe.
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  lib/bb/command.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/command.py b/lib/bb/command.py
> index fa9fd054c..c9571f63d 100644
> --- a/lib/bb/command.py
> +++ b/lib/bb/command.py
> @@ -564,7 +564,7 @@ class CommandsSync:
>          if config_data:
>              # We have to use a different function here if we're passing =
in a datastore
>              # NOTE: we took a copy above, so we don't do it here again
> -            envdata =3D bb.cache.parse_recipe(config_data, fn, appendfil=
es, mc)['']
> +            envdata =3D command.cooker.databuilder._parse_recipe(config_=
data, fn, appendfiles, mc)['']
>          else:
>              # Use the standard path
>              envdata =3D command.cooker.databuilder.parseRecipe(fn, appen=
dfiles)

How did you run into that? I'm a bit worried we're missing some test
coverage here?

Cheers,

Richard

