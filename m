Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web12.25890.1605005614548402885
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2020 02:53:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20150623.gappssmtp.com header.s=20150623 header.b=oMAq8Tz+;
 spf=pass (domain: burtonini.com, ip: 209.85.208.172, mailfrom: ross@burtonini.com)
Received: by mail-lj1-f172.google.com with SMTP id y25so13228358lja.9
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2020 02:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXQrO50DlxCyU+FQytN+fCKPQJy+DkZ06s370MCJPzA=;
        b=oMAq8Tz+q2nck2a9sWBB4OwsH3qdpZMs5KkzlShYuo/k8uuzP5bHu0ukDl+QiH+WZj
         SOjDoPnc6XgxCFsZHBBQWgrtsoy1CGTPuskqFnXX6rm2aqYRFipYjfmLK2YMmiN+Tfmz
         dKY7Pff2TK2g8CZaOk7BoEEtgV5maLRCgEarP6p7KBmty4vMU/V5Q68Qx0+0dDV3vQPt
         tnBU43/Cie8mXJrE4pwnAZEwXMMA5+oyEyw238PcOWYok3DYB6VAEbJAsvWjn/bgsnoS
         flDffKwf7seDnzGjHElJoaZh7IH95hz6raoaIsbLJieD5dGEJNN0O3ugQ5oeC0MkZ6pL
         mhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXQrO50DlxCyU+FQytN+fCKPQJy+DkZ06s370MCJPzA=;
        b=qwM7jKkpqjBa3ItPspy/AYLdq45IQRXvHfJA1dgSbO9s8ze0Mu77nPRbrLrVb72ZMs
         KYEKcyIjappLJ62NQl72uS/vxsBx1bkuc9EVa4cMjxKqrGx7RIVYuwHjwPBLB4sRYuII
         FFtVINaI4TcZpj62+eoXLznSa/S9+ZIMJPp9dENGzQCnCZCVuFiz29c8J2kFyCxejD5K
         N7tPYEjJNp9dikoNOtBnp7JDY9fYFcNQ4V6HEbAw0di1ys6xBAXTVQyNGdhZwhvgW9Gf
         lEcbiI6xjI3Cmg7HVVX5eOlNghItXnQBHDbsK1/0uXgwdJx+PH6BZIO+LZlLayFAlm1V
         mg+A==
X-Gm-Message-State: AOAM533CSyRwHNJYoAKn0rcY8bfz6mZptkvOF3Nm3wYLGuCiFUi54FaC
	tW830evNGTYoILiHDKxlqP9THCbD3NDT5E2wBqbeXA==
X-Google-Smtp-Source: ABdhPJzrJ5+PZSlFuUeVNouaI6rh3A5Nb5w08l9dmjt/xNxwxuH+fOsfDVoVg9DRq+TFwXjSoEoRN9w3Qy5zJyzHNS0=
X-Received: by 2002:a2e:89d7:: with SMTP id c23mr6800756ljk.397.1605005612608;
 Tue, 10 Nov 2020 02:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20201109185638.59226-1-chris.laplante@agilent.com>
In-Reply-To: <20201109185638.59226-1-chris.laplante@agilent.com>
From: "Ross Burton" <ross@burtonini.com>
Date: Tue, 10 Nov 2020 10:53:21 +0000
Message-ID: <CAAnfSTuFCAE8jqsHB4txRNDSkFVp6yDUUOg5gJ4hLAQMzSv-5g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] build: defer processing of [dirs] and [cleandirs] until after lockfiles are acquired
To: chris.laplante@agilent.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

This is causing failures when building kernel-devsrc:
http://errors.yoctoproject.org/Errors/Details/537939/

Ross

On Mon, 9 Nov 2020 at 18:56, Chris Laplante via lists.openembedded.org
<chris.laplante=agilent.com@lists.openembedded.org> wrote:
>
> This is to avoid potential races for tasks that use both [cleandirs] and
> [lockfiles].
>
> Note that [dirs] cannot be processed until after [cleandirs], since
> the two may intersect, e.g.:
>
>     do_task[cleandirs] += "${WORKDIR}/my_clean_dir"
>     do_task[dirs] =+ "${WORKDIR}/my_clean_dir/subdir"
>
> This patch also adds sanity checking to detect attempts to create
> lockfiles under directories listed in [cleandirs] which, as of this
> patch, would make no sense.
>
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  lib/bb/build.py | 47 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 974d2ff0..d3a43778 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -179,7 +179,7 @@ class StdoutNoopContextManager:
>          return sys.stdout.name
>
>
> -def exec_func(func, d, dirs = None):
> +def exec_func(func, d, dirs=None):
>      """Execute a BB 'function'"""
>
>      try:
> @@ -188,24 +188,11 @@ def exec_func(func, d, dirs = None):
>          oldcwd = None
>
>      flags = d.getVarFlags(func)
> -    cleandirs = flags.get('cleandirs') if flags else None
> -    if cleandirs:
> -        for cdir in d.expand(cleandirs).split():
> -            bb.utils.remove(cdir, True)
> -            bb.utils.mkdirhier(cdir)
> -
>      if flags and dirs is None:
>          dirs = flags.get('dirs')
>          if dirs:
>              dirs = d.expand(dirs).split()
>
> -    if dirs:
> -        for adir in dirs:
> -            bb.utils.mkdirhier(adir)
> -        adir = dirs[-1]
> -    else:
> -        adir = None
> -
>      body = d.getVar(func, False)
>      if not body:
>          if body is None:
> @@ -249,7 +236,39 @@ def exec_func(func, d, dirs = None):
>              except OSError:
>                  pass
>
> +    cleandirs = flags.get('cleandirs') if flags else None
> +    cleandirs = d.expand(cleandirs).split() if cleandirs else []
> +
> +    if cleandirs and lockfiles:
> +        # Sanity check that no lockfiles are under any of the cleandirs.
> +        # Since cleandirs is processed after taking the lockfiles, we want to guard against deleting the lockfile's
> +        # enclosing directories.
> +        import pathlib
> +        for lockfile in lockfiles:
> +            lockfile_path = pathlib.PosixPath(lockfile).resolve()
> +            for cleandir in cleandirs:
> +                cleandir_path = pathlib.PosixPath(cleandir).resolve()
> +                try:
> +                    lockfile_path.relative_to(cleandir_path)
> +                except ValueError:
> +                    continue
> +                bb.fatal("Lockfile {0} cannot be placed inside {1} because that directory is set to be cleaned (see "
> +                         "[cleandirs] flag)".format(lockfile_path, cleandir_path))
> +
>      with bb.utils.fileslocked(lockfiles):
> +        # Process [cleandirs] varflag
> +        for cdir in cleandirs:
> +            bb.utils.remove(cdir, True)
> +            bb.utils.mkdirhier(cdir)
> +
> +        # Now process [dirs] varflag
> +        if dirs:
> +            for adir in dirs:
> +                bb.utils.mkdirhier(adir)
> +            adir = dirs[-1]
> +        else:
> +            adir = None
> +
>          if ispython:
>              exec_func_python(func, d, runfile, cwd=adir)
>          else:
> --
> 2.17.1
>
>
> 
>
