Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D918C71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 19:58:12 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.43527.1694375884137275533
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 12:58:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=FHm5v2cw;
 spf=pass (domain: gmail.com, ip: 209.85.208.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bf6b37859eso36770531fa.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694375882; x=1694980682; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDiz8y0/m4IZK5TBEVL/dz5suUHTPoEaCPdYUQkr2H4=;
        b=FHm5v2cwVcJOGAAXgRh76fGX8SSuFZvqAdYjIy7a+5qo8vDHxnecj9fXYXp1AsaUfP
         WT3rGlunc9FcPISAb4fR0IRru7N5A9XdiDxDbd6aAxl3HSgflO9M+oHVsnR047g0CQ6F
         QGH6J19ZUbyQZrWjFVSGBSJlEHp6UDiKGhODWYKCR+LzE1D7dP2IQi54GuPSx+wr3bIk
         APuZYb96XgI4X4+nHr/kGkM/gyNvXOEyCe3lJypXF89JXyP9L6DlquYytbPOaYwpfHWL
         WsrkwJvQf0U3XyxNbIrwiR5hn+HVd7fNFockglW85m+0jhzpXg2S3jXMvVGRo0aRKv25
         AhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694375882; x=1694980682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDiz8y0/m4IZK5TBEVL/dz5suUHTPoEaCPdYUQkr2H4=;
        b=I41Ycmw0vlz23P+xoEa7NFjOnp1IHYIwuTdVBO0wcCA6uZk2K4N5ZNSg0NmUQ4b6UW
         qGXMFru3HG9qJLbPftu3+CiCgJHjNaCyMIlmvS1E2+W++Ayus4yDD6z41Aa4ExvuSphX
         n6TTCqKIf+aCtQ85WcpeBZEmeC2R0FOu44WsMbLl5dSwdcRgGzV+zwBkWxdtRPF3eCsp
         Dbw9yHrJcW4km/u7wM6dBRMtT8PCGCJZT0ughrBZDaApKOJ6yv2X05JszojZZCwxjKjV
         v+o5GP0JLwpsX4M48ZizOCElUZ059pWkr8tVrfwYSttdBMAenabAF1B25W6I2xoecSlV
         ln0A==
X-Gm-Message-State: AOJu0Yy9VSdHjGZ3PFalWsxSnkSWlY/Odr+D3hTg47yVqberVmTWztRS
	zauZ8f4wLE1Hi30VuVJJosgTT1D52tW6Dm5mObA=
X-Google-Smtp-Source: AGHT+IG45Zs0hiQVmeJ+4FH0VmSLkeA5gYMn2avD9dlTLA2wm6muE4frsNAboYDWMyYT8LZwgmRkEAZ2FkmO2tI8NVM=
X-Received: by 2002:a2e:9b16:0:b0:2b6:ee99:fffc with SMTP id
 u22-20020a2e9b16000000b002b6ee99fffcmr6166349lji.36.1694375881998; Sun, 10
 Sep 2023 12:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230910194648.942409-2-rs@ti.com>
In-Reply-To: <20230910194648.942409-2-rs@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 10 Sep 2023 21:57:50 +0200
Message-ID: <CANNYZj9innMGasLvCuZBEvB8Cr65AwRW+wyRK_mUaU8MOmJjQA@mail.gmail.com>
Subject: Re: [PATCH v2] bitbake-worker: remove the network flag
To: rs@ti.com
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	denis@denix.org, reatmon@ti.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 19:58:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15025

Please stop sending the patch. You are just winding everyone up. If
you want to have a discussion, open a thread with the comment about
icecc and friends, and we'll take it from there, otherwise any further
submission from you will be treated with suspicion and mistrust, which
is not the outcome you want.

Alex

On Sun, 10 Sept 2023 at 21:54, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> The network flag does not currently respect proxies by default as the
> fetch stage does [1]. As such it only works for some users at the whim
> of the recipe writer.
>
> This introduces an issue downstream as the build results are now
> dependent on the network architecture of the builder, the recipe in
> question, and the combination of proxy variables they choose to export
> in addition to the normal host variables that affect builds (host tool
> version, build environment, etc).
>
> This is far more indeterminate than a build system that properly exports
> proxy variables. If abuse of the network tag is an issue, then the
> network tag should be removed in it's current state and networking
> should depend entirely on whether the current task is 'do_fetch'.
>
> [1] https://lists.openembedded.org/g/bitbake-devel/topic/100924096
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>
> What I feel would be the proper solution to the aforementioned issues.
>
> Examples of layers that currently use the network flag outside of the do_fetch
> stage:
>
>         oe-core (icecc.bbclass)
>         meta-openembedded (go recipes)
>         meta-flutter (all flutter recipes and classes)
>
> This is not an attempt to shame maintainers. I'm just curious why the network
> task expects every maintainer to handle proxy variables (something pretty much
> required if you are actually using the network in that task) independently. It
> just results in needless debugging and a bunch of patches attempting to export
> variables in their own way. Sorry if this comes off as antagonistic in any way.
>
>  bin/bitbake-worker                                       | 2 +-
>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 6 ------
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 451e6926..f25880c1 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -270,7 +270,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
>
>                  bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
>
> -                if not bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
> +                if taskname != 'do_fetch':
>                      if bb.utils.is_local_uid(uid):
>                          logger.debug("Attempting to disable network for %s" % taskname)
>                          bb.utils.disable_network(uid, gid)
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 58975f4c..b35c332c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1519,12 +1519,6 @@ functionality of the task:
>     released. You can use this variable flag to accomplish mutual
>     exclusion.
>
> --  ``[network]``: When set to "1", allows a task to access the network. By
> -   default, only the ``do_fetch`` task is granted network access. Recipes
> -   shouldn't access the network outside of ``do_fetch`` as it usually
> -   undermines fetcher source mirroring, image and licence manifests, software
> -   auditing and supply chain security.
> -
>  -  ``[noexec]``: When set to "1", marks the task as being empty, with
>     no execution required. You can use the ``[noexec]`` flag to set up
>     tasks as dependency placeholders, or to disable tasks defined
> --
> 2.42.0
>

