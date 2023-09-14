Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC6CA0EF6
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 05:17:18 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web10.5329.1694668636618708411
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 22:17:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=SoZQrW6N;
 spf=pass (domain: linaro.org, ip: 209.85.167.43, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-502e0b7875dso909356e87.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 22:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694668635; x=1695273435; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFOXFTDhIKOkdzEU0+x2Lv+NJKj4ju60e6GlkAddqtE=;
        b=SoZQrW6NNZ0I2ixkJGdiNuy3+B34vfYtEglaZxZ0w8h4dTB7ny2aGjePjtCijAfCej
         N0XZVrXqWm+tRakKgKCwMIYtXJfOGoSq/vS5BjQogFcHjSGKuyFGAib9daCBDltxyhkW
         jqYcmWzEixjGW/7ppX8dH8w41sO0ZGpj5FH3wknzax8nvo4F7HgOcyWRGYgxT2MStZDa
         akfHYTAxpsPC7OZC/1tUHoJZeZUqRmLWqcbHAJGCgiWsgav91kMGVenfV6haGrykXHGN
         xMynWYX4hLQnLA6OrhAYykBPlmrq49uf6MoHgYMYCwAqvsYEtoFjgsykiw/9XLBBMRlc
         2fKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694668635; x=1695273435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFOXFTDhIKOkdzEU0+x2Lv+NJKj4ju60e6GlkAddqtE=;
        b=wZsbeum0os6udJIw3jZbV/dgJ+UPaPRdxJhvDJ1ENPF2eIMSzJNA6wQ9i3wQSljUaa
         rWoSuZ3SX0CuA1b5NbX720onPyT4/EAszf5KAzK+54asfTi3R2eR7tE5nZypnZIcpnL7
         i1igTjLydrJRA+DE16GjAsvPu9xtmSynRBzptxCH8mi/S2yimIGK0aU7dAYvbgE4G9ne
         5SlFq0QPhbArefujyzkeuVTvhouabt7XMY2znetXmRZtZNOw2dBgk/q1H3hp6+0ilcUd
         TdLyxUYQn+DiDhdCn16USyOVT9xmZ/1AwcabaijJKtzcg/TbHHLSbBhai5hZU7RMh38R
         2bCQ==
X-Gm-Message-State: AOJu0YxawB6h6mFKMg8pLoLGnVB+0i99pY4wo2nenV8/jQBMYdMQOKRy
	UDBFklZ9JAR/d/tehC26js5a+A==
X-Google-Smtp-Source: AGHT+IFak4bhU2n2QALwiNINQqpvyd3AsLNE0vKMzwdh0D1MdyrWeMCynbf6BEP0Flx8EDj/PeExRw==
X-Received: by 2002:a05:6512:1585:b0:500:bf33:3add with SMTP id bp5-20020a056512158500b00500bf333addmr4963424lfb.47.1694668634658;
        Wed, 13 Sep 2023 22:17:14 -0700 (PDT)
Received: from nuoska (dc7g6tyjby-d304c4945t-3.rev.dnainternet.fi. [2001:14ba:16cb:a800:e107:c77f:6058:ee33])
        by smtp.gmail.com with ESMTPSA id o18-20020a056512051200b00500b561285bsm120288lfb.292.2023.09.13.22.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 22:17:13 -0700 (PDT)
Date: Thu, 14 Sep 2023 08:17:11 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH 2/2] fetch2: git: Use path_is_descendant()
 instead of path for repo check
Message-ID: <ZQKXV0qhiVFkMXhS@nuoska>
References: <20230913190425.3761792-1-JPEWhacker@gmail.com>
 <20230913190425.3761792-3-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913190425.3761792-3-JPEWhacker@gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 05:17:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15059

Hi,

On Wed, Sep 13, 2023 at 01:04:25PM -0600, Joshua Watt wrote:
> Using path prefixes to check if the git directory is a descendant of the
> clone directory can be easily confused with symlinkes and bind mounts,
> causing directories to be deleted unnecessarily. Instead, use
> bb.utils.path_is_descendant() which is immune to the these sorts of
> problems.

I'm confused by this. What is the original problem? Corrupt download cache git repo
being confused with poky git tree when building in "poky/build" directory and downloads
are in "poky/build/downloads"? And at the time of check we don't know if git commit, branch,
or git remote have changed and we want to avoid full clone if possible?

Cheers,

-Mikko

> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index e11271b757a..4385d0b37af 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -373,20 +373,17 @@ class Git(FetchMethod):
>              try:
>                  # Since clones can be bare, use --absolute-git-dir instead of --show-toplevel
>                  output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
> +                toplevel = output.rstrip()
>  
> -                toplevel = os.path.abspath(output.rstrip())
> -                abs_clonedir = os.path.abspath(ud.clonedir).rstrip('/')
> -                # The top level Git directory must either be the clone directory
> -                # or a child of the clone directory. Any ancestor directory of
> -                # the clone directory is not valid as the Git directory (and
> -                # probably belongs to some other unrelated repository), so a
> -                # clone is required
> -                if os.path.commonprefix([abs_clonedir, toplevel]) != abs_clonedir:
> -                    logger.warning("Top level directory '%s' doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> +                if not bb.utils.path_is_descendant(toplevel, ud.clonedir):
> +                    logger.warning("Top level directory '%s' is not a descendant of '%s'. Re-cloning", toplevel, ud.clonedir)
>                      needs_clone = True
>              except bb.fetch2.FetchError as e:
>                  logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
>                  needs_clone = True
> +            except FileNotFoundError as e:
> +                logger.warning("%s", e)
> +                needs_clone = True
>  
>              if needs_clone:
>                  shutil.rmtree(ud.clonedir)
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15057): https://lists.openembedded.org/g/bitbake-devel/message/15057
> Mute This Topic: https://lists.openembedded.org/mt/101344082/7159507
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mikko.rapeli@linaro.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


