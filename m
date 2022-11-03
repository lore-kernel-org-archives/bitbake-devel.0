Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02413C4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 21:09:46 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web08.3901.1667509778593176704
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Nov 2022 14:09:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UOWcKicD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id bk15so4491597wrb.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Nov 2022 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI4EqgI5bda39UfZfCnIr9PkYW4hMur3Y0YYZIks39c=;
        b=UOWcKicD9bWAlv2Bg61KJCnmAabq/l9Bvnm8as3HCXUdxbFZGTXqWMFLePLd/tX00u
         2V2rWKG4wruGgAysbflYS/x4fsbAG8qAc9rixdXjYT1H7aAe0TW09e1QSRRoUeMQ0/Yt
         /pAeAnCIAxZYKgTolfbYiMkaZ/3XFG0A00IuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RI4EqgI5bda39UfZfCnIr9PkYW4hMur3Y0YYZIks39c=;
        b=NjYFwEoyPV4YmuLYqCkcFAGQFXCUaU3HGZ1EPJsDEz7mPzyvdrW28HaEJPmcsi5Td+
         r85kDB4fFUvNJ8FBCDgVdA1fB8c00RZuCi8UPr1RlG8UIfQCtqF+hqcA+x35OGtSOzql
         ptBkXjpoEmQRnYRbM9tNNbbeJMQZ6E5YgX4ZsQB2JmGONi5oAmTkSoi34LQcaoZQs9Ep
         Ri2YIk+6BXbiGFRc6AL+WMEX4KBxoPA9FqgzFc6LGhQ2jekFNuK74wAGIz9bh2ZZ8+Pa
         T4XXF3x7wvo2fzOtRlciUfmo00SLaDZLwejWYvNIFOAqgJhjmt6LS1EQT/ZxNEslZC/L
         cvAA==
X-Gm-Message-State: ACrzQf2vZJfgL4ig6Qhvqtrox0PA4n0DctrwbnV6EOeOTlvCi1Q26MtF
	35fePqbsHOxU233C+ojLU0+sBw==
X-Google-Smtp-Source: AMsMyM5pCXLgeGfSCFx0yfQAjF59wN3CpH4kr56PmWJUnmlrfReyqA/ouaWx7hKpjhQWqq1AuVjKGw==
X-Received: by 2002:adf:f051:0:b0:236:70db:20d9 with SMTP id t17-20020adff051000000b0023670db20d9mr20450916wro.91.1667509776546;
        Thu, 03 Nov 2022 14:09:36 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:28c5:bec7:4f4d:2683? ([2001:8b0:aba:5f3c:28c5:bec7:4f4d:2683])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0560001c0700b00236705daefesm1852123wrb.39.2022.11.03.14.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:09:35 -0700 (PDT)
Message-ID: <c08e7b6b682dca94207a890f770e119d40c018ee.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: expand network varFlag
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <Martin.Jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 03 Nov 2022 21:09:34 +0000
In-Reply-To: <20221103090356.1655054-1-Martin.Jansa@gmail.com>
References: <20221103090356.1655054-1-Martin.Jansa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Nov 2022 21:09:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14056

On Thu, 2022-11-03 at 10:03 +0100, Martin Jansa wrote:
> * this allows to use conditional when setting the value
>=20
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  bin/bitbake-worker | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 7be39370..fa606667 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -263,12 +263,15 @@ def fork_off_task(cfg, data, databuilder, workerdat=
a, fn, task, taskname, taskha
> =20
>                  bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN=
"), taskname.replace("do_", "")))
> =20
> -                if not the_data.getVarFlag(taskname, 'network', False):
> +                task_network =3D the_data.getVarFlag(taskname, 'network'=
)
> +                if not task_network:
>                      if bb.utils.is_local_uid(uid):
>                          logger.debug("Attempting to disable network for =
%s" % taskname)
>                          bb.utils.disable_network(uid, gid)
>                      else:
>                          logger.debug("Skipping disable network for %s si=
nce %s is not a local uid." % (taskname, uid))
> +                else:
> +                    logger.debug("Skipping disable network for %s since =
network varFlag is set to %s." % (taskname, task_network))
> =20
>                  # exported_vars() returns a generator which *cannot* be =
passed to os.environ.update()=20
>                  # successfully. We also need to unset anything from the =
environment which shouldn't be there=20

I was trying to avoid having to worry about having to handle values
like "0" enabling the network :(

Cheers,

Richard


