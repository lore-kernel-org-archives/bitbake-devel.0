Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web09.28082.1617435811462958358
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Apr 2021 00:43:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E5amS+s8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id q26so716675wrz.9
        for <bitbake-devel@lists.openembedded.org>; Sat, 03 Apr 2021 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vjTskfNfFWg3HfFiMNw/8tHPLbHV75TbYs6I9TwH+D0=;
        b=E5amS+s8joKxDHMoMl3S20pqQ/mHfVueGTSUfmHfjajUR4PDlILMsxu4p/Uh9iL8se
         qH9L2opqyK3F1eSw+s6eIwFyPXRd4xGqNUr8i/QRYVgnjJcibkEcT21DjqnNgXzk5G6W
         PlP2GQefNnHz3TPPLqk+iFMC6W+9FSTK+ciJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vjTskfNfFWg3HfFiMNw/8tHPLbHV75TbYs6I9TwH+D0=;
        b=rO7jO5YbJ97RRhi3hhtMhhc20dpAuHM0DRoUG/jX7kobU67nC1FoiKa+4BZnkyE6yD
         sXgU5Y2rdRkpecA22G9xfVOG+lBMsEHyYWOElenYWTK1vBvT2e9pH+s/v/R7BMykBwMy
         K9KMWVwHmQvnklvitDWziryQqFnVMAHSCndGYDUKx0DPpnJ5brgCxs5OlHvgRdrUa03T
         3s0eLUzDlbd0LXRwn6XaOm3WXEe6PphtABfLbVjyApxN9hG48cNyo1m1JAmlCnCUj7YR
         4sVTqleRVBxeyXABbITi5XqF6DLtm/MKY0VKZYmiPzW4huNdYauKiRuN+ZvLtoo3lV8P
         mHGA==
X-Gm-Message-State: AOAM530rpFwfoDvK3rSJX8Or+HgV6ofX8PjfkwqedNYWCHReMGp43EMM
	a479t+oj0ja4bzKilZrOi38cdw==
X-Google-Smtp-Source: ABdhPJy31OewI8K1KcnF45rNKhmZ/oQRaCyp0+fAYvOlLuPkngdXDiMFzqzPqbvP9crbqXS/ptHT9Q==
X-Received: by 2002:adf:f948:: with SMTP id q8mr19220394wrr.296.1617435809873;
        Sat, 03 Apr 2021 00:43:29 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:a3bb:8f94:1e3d:b6? ([2001:8b0:aba:5f3c:a3bb:8f94:1e3d:b6])
        by smtp.gmail.com with ESMTPSA id f20sm2290996wmg.36.2021.04.03.00.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:43:29 -0700 (PDT)
Message-ID: <0a2fec0d96cc12e279bd803c70024c07334e50e5.camel@linuxfoundation.org>
Subject: Re: [PATCH 02/21] bitbake: fetch2/git: allow limiting upstream fetch refs to a subset
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, Bruce Ashfield
	 <bruce.ashfield@gmail.com>
Cc: linux-yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Date: Sat, 03 Apr 2021 08:43:27 +0100
In-Reply-To: <20210402171557.981599-3-paul.gortmaker@windriver.com>
References: <20210402171557.981599-1-paul.gortmaker@windriver.com>
	 <20210402171557.981599-3-paul.gortmaker@windriver.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-04-02 at 13:15 -0400, Paul Gortmaker wrote:
> If a clone in the download directory is not static, and was created with
> single-branch to avoid additonal unwanted content, then the fetcher will
> come along and spoil that effort by unconditonally getting refs/* from
> the server and downloading everything available at the server.
> 
> To that end, allow a companion variable that can optionally be used to
> limit the fetch to a subset of references that are in line with the
> desired content for the recipe in question, and so that large unwanted
> downloads aren't inadvertently triggered during an update.
> 
> If not specified, the existing "fetch everything" behaviour remains.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/git.py           | 3 ++-
>  documentation/ref-manual/variables.rst | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 22281e2cfb98..b54ec76d7174 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -362,7 +362,8 @@ class Git(FetchMethod):
>                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
>  
> 
> 
> 
>              runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
> -            fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
> +            fetchrefs = d.getVar('GITFETCHREFS_' + ud.names[0]) or d.getVar('GITFETCHREFS') or "refs/*:refs/*"
> +            fetch_cmd = "LANG=C %s fetch -f --progress %s %s" % (ud.basecmd, shlex.quote(repourl), fetchrefs)
>              if ud.proto.lower() != 'file':
>                  bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
>              progresshandler = GitProgressHandler(d)

I think one of the reasons I'm unease about this series is that some of the 
changes break the existing fetcher functionality. Taking the above, I 
understand why you want to filter the references but this will break the
mirroring.

How? Imagine a repo has branches A and B and the recipe filters to A. This 
will result in a mirror tarball only with A in it. The mirror tarball name will
attempt to be reused by a recipe referencing with B and the mirroring 
mechanism will fail.

Mirroring is the reason we do use all pull the whole repo here. It isn't
good from an efficiency standpoint but it does work well for mirroring. This
piece of code from the fetcher kind of summarises it:

"""
gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace('
','_'))
if gitsrcname.startswith('.'):
    gitsrcname = gitsrcname[1:]

# for rebaseable git repo, it is necessary to keep mirror tar ball
# per revision, so that even the revision disappears from the
# upstream repo in the future, the mirror will remain intact and still
# contains the revision
if ud.rebaseable:
    for name in ud.names:
        gitsrcname = gitsrcname + '_' + ud.revisions[name]

mirrortarball = 'git2_%s.tar.gz' % gitsrcname
"""

To make the above "work", you'd need to rename the mirror tarball to be
branch specific and include A or B in the mirror tarball filename.

I also then wonder whether the form of GITFETCHREFS is good API. It is certainly
powerful however the code already knows which branch we're asking it to fetch
so we could just add a parameter to the url "clonebranchonly" which asks it
to only clone that branch and not all the references?

I appreciate that doesn't give you the way to say "heads/v5.4/*" but instead
you'd get something more specific like "v5.4/standard/base" but that would 
filter the fetch to me even more efficient to the particularly use case a
user would generally be working with (a specific machine). I appreciate that
you're not going to like a mirror tarball per kernel branch and even trying
to get the system to generate all the right tarballs would be a nightmare.

Another alternative could be a parameter like ";filterclone=heads/v5.4/" which
the fetcher could then translate to "refs/heads/v5.4/*:refs/heads/v5.4/*" 
internally.

I guess in summary this means I have two worries about the API. Ideally we 
want something which can be put simply in the URL itself avoiding external 
variables. We also want something which is end user readable, rather than 
being a direct copy of the git commandline. I'd prefer to avoid direct 
commandlines as they only encourage people to start using them to different 
things and then we end up breaking mirrors, have incomplete test coverage
and/or find it really hard to add/change functionality later.

Cheers,

Richard




