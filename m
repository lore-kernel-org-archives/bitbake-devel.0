Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA0ACA5512
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 09:05:03 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.7342.1694595897432066930
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 02:04:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Rro2JB08;
 spf=pass (domain: linaro.org, ip: 209.85.167.54, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-500a398cda5so10827371e87.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694595895; x=1695200695; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1NKQ3XtU0GoZH/yJDzw8WgZTI8F9Krx2YWDJGnGlf4=;
        b=Rro2JB08v5IPUiqB67uDGTZPEaipiSYaFvRKB7lpgL4Nc7AwFYgPaEfqNkQ2D9sSez
         oBPEOfhz3YYOAm8km2RY9ZqGb1CeDNj4PL38Bzuc6TbOQ0BVmsYC26Xjo4kMQ1+P22ix
         HIDF/xMXEJvEhXYGEgZ8VfamsPhbq5t+kKl9qHIaPYZLRQsfZzlUIlB2fVws/uFRLE7Z
         PTLACa+VG9PYH9XZAfbVgEbUazmQ9SBml2IpI5poceTS3T4pELOomFPIJEA8GI4Ks/MT
         +AaEsbJ6YP5JKiHMbIuvZWqImrJzJRK5GWibWt7lsbbblNy5+XH+Jub9KHjvee42+SBL
         WLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595895; x=1695200695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1NKQ3XtU0GoZH/yJDzw8WgZTI8F9Krx2YWDJGnGlf4=;
        b=ucoDzNQ3z+5LJgUShdWrSnlNRH9rjb256guUsAwdRlvaMUBn6CLFQOI8w0NYXlOo0/
         9xXsLNhTVPTQaNy+VqlhzHP5kgqRkQ1+NkNJj7EpNqcxOwqxxKjnwZ0rSZeefpicis+I
         dI9B3OnYAsLRKCwaVl6JUuavzddkuictM5Dh23hVOKHBUZ0OawniKZ2lsN8n2ZL1gOND
         4XjjM5Y2GhY4PWjJPCyJvFtTP/XoncjdHG+SmsYGb6/LyPyy4fvMUjYylCNYgSOV8vpU
         hzNnT4Zj1rfK+7c8Vu9aCFjplTcaJUiXfKZo9BYN77yhAx5cr5YYgpIs/3qffdoW2JTc
         XCzg==
X-Gm-Message-State: AOJu0Yw1Dhhk7T2NqsztzHisdwaa9pqHZ98UAhvpg8DVOsLU5JI2+ebZ
	Lsf6aElsPbBythQW8B3MJZ9mDQ==
X-Google-Smtp-Source: AGHT+IF1n/Pw4JVMPinO4NpiaWDhM58faWUhchaFbmRc9OTGRQWiLJ7n1IUyj/OAGnxgU1ZJei/OYg==
X-Received: by 2002:a05:6512:3b27:b0:501:2071:6784 with SMTP id f39-20020a0565123b2700b0050120716784mr1933961lfv.10.1694595895454;
        Wed, 13 Sep 2023 02:04:55 -0700 (PDT)
Received: from nuoska (dc7g6tyjby-d304c4945t-3.rev.dnainternet.fi. [2001:14ba:16cb:a800:e107:c77f:6058:ee33])
        by smtp.gmail.com with ESMTPSA id d5-20020ac24c85000000b005007e7211f7sm2060521lfl.21.2023.09.13.02.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:04:54 -0700 (PDT)
Date: Wed, 13 Sep 2023 12:04:53 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: revert path checks
Message-ID: <ZQF7NWTYQQvVX3JE@nuoska>
References: <20230913084344.29928-1-mikko.rapeli@linaro.org>
 <969bbf65ba6459eedd8df5a3b2cc3f378fdf05d2.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969bbf65ba6459eedd8df5a3b2cc3f378fdf05d2.camel@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 09:05:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15044

Hi,

On Wed, Sep 13, 2023 at 09:51:39AM +0100, Richard Purdie wrote:
> On Wed, 2023-09-13 at 11:43 +0300, Mikko Rapeli wrote:
> > Commit 10f38157a069cb6938323cadd5e523037a29ace9
> > triggers re-clones of uptodate repositories when their
> > access path changes. This is wrong. It is enough that
> > needed commits are found from the git repo. For example
> > when same DL_DIR is accessed using two different paths
> > due to a symlink, then the resulting absolute paths will
> > differ but the content is the same. Trust the content.
> > 
> > Avoids extra downloads of large repositories like linux-yocto
> > for kernel when the local cache was already uptodate.
> > 
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> > ---
> >  bitbake/lib/bb/fetch2/git.py | 14 +-------------
> >  1 file changed, 1 insertion(+), 13 deletions(-)
> > 
> > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> > index e11271b757..0c547ea303 100644
> > --- a/bitbake/lib/bb/fetch2/git.py
> > +++ b/bitbake/lib/bb/fetch2/git.py
> > @@ -371,19 +371,7 @@ class Git(FetchMethod):
> >              # The directory may exist, but not be the top level of a bare git
> >              # repository in which case it needs to be deleted and re-cloned.
> >              try:
> > -                # Since clones can be bare, use --absolute-git-dir instead of --show-toplevel
> > -                output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
> > -
> > -                toplevel = os.path.abspath(output.rstrip())
> > -                abs_clonedir = os.path.abspath(ud.clonedir).rstrip('/')
> > -                # The top level Git directory must either be the clone directory
> > -                # or a child of the clone directory. Any ancestor directory of
> > -                # the clone directory is not valid as the Git directory (and
> > -                # probably belongs to some other unrelated repository), so a
> > -                # clone is required
> > -                if os.path.commonprefix([abs_clonedir, toplevel]) != abs_clonedir:
> > -                    logger.warning("Top level directory '%s' doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> > -                    needs_clone = True
> > +                runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
> >              except bb.fetch2.FetchError as e:
> >                  logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
> >                  needs_clone = True
> 
> Doesn't this give rise to some of the original issues (it could find a
> parent git repo instead of the one being cloned)?

Yes, but this has not been a problem for me. Re-cloning existing fully cached
repositories is the effect I see.

I think the git commit id and branch should decide if fetch or re-clone steps are needed.
The path of the repository should not matter. The git remotes also not. Both of those can
and do change.

Cheers,

-Mikko

