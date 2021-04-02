Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web09.22433.1617394802711189746
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 13:20:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Sb9tSNhS;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id e14so8756991ejz.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Apr 2021 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyYSrNdG95YoUlQP/jFV4nhZkJD5supwlHI3yjEEUDA=;
        b=Sb9tSNhS0EfHwdqkZ6phx/LWXzwrXgcMH5DdBQLW1Qh/2ENHX1T94ckdn7JkS1l6NY
         EBKt49T1jN9Zhp9gL282dlPXHXf8lKxqMSVa1qBVUN3/UNUImVawMznen/5HZbkdQ//p
         Nt+W/zKNsM3PsBx+GylrV2vs/islnoKc0joZGCn8ZZA7mCEXBrGUOpAVyWHcaeVrVa1L
         Fu/x3JAwNQ3LFBpEn+2gEeHBB1BAFTUxZ4/SY/xkCsIVGxiAV6KMcFEqqocdnf3h0qns
         ANOsjU9pWiRM+lxNXI2Gv18KQbPPXRNQnLVY+qnstLAFb+5UHU0wViBxXo7qQcbpqy2m
         WhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyYSrNdG95YoUlQP/jFV4nhZkJD5supwlHI3yjEEUDA=;
        b=QKwKfL2mfYhh+FRxA+PB3xR9ZPDBoKF/mr+bdQ/Vm2hEUCyqE7efqPkuo+T6q8SuCM
         FBQtgKvyrcZWZCvt7MhMlEnnR+SHOx3MniW4hX4RLlqkr7niCQHjUV/TXFe0KcRhSkE2
         lk6UInh+oSVWIL86LcuNRskDVwQC6/IZPS3uw3+627gzxezYFGxO7k/AluxRUvPc0jzH
         SU9EDypa9oApxKB1Rj9INnFlWLdsb+BrwntUo0SBSeI3lI3v/5Xt49sgA2J3eZhOiCd3
         v3GE5RwuAlfCHZelErFkP7xxmmfjqKcrMovbpZgXQigFFa5+JyQaW4HY3oXn4QgTQ0X7
         hCUA==
X-Gm-Message-State: AOAM533reNAHIcwiUr/ME6E/lOcw9XC20+8BBFvgSPmSwtlh+SpJgYla
	eY11giLoCLmzT32DBnSh+pLVNGZcVXaMXCPBmto=
X-Google-Smtp-Source: ABdhPJz3leqb1h8CllLXKS3uVBZG3pxbgbDwxagXeRt6fGSEr/MTUYwnpFc6TSvcP6bZSPTfqi/yv3Om7VFGf23P7R8=
X-Received: by 2002:a17:906:5689:: with SMTP id am9mr15212518ejc.298.1617394801121;
 Fri, 02 Apr 2021 13:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210402171557.981599-1-paul.gortmaker@windriver.com> <20210402171557.981599-22-paul.gortmaker@windriver.com>
In-Reply-To: <20210402171557.981599-22-paul.gortmaker@windriver.com>
From: "Bruce Ashfield" <bruce.ashfield@gmail.com>
Date: Fri, 2 Apr 2021 16:19:50 -0400
Message-ID: <CADkTA4NknKAiejYwJwYzj=F5FW-xDGZz0QTmYyOezCoevkNh3Q@mail.gmail.com>
Subject: Re: [PATCH 21/21] kernel: disable (pre)mirror for linux-yocto and linux-yocto-dev
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Linux Yocto <linux-yocto@lists.yoctoproject.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 2, 2021 at 1:16 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> As per the comment in the file itself, we have to explicitly disable
> (pre)mirror support for both kernel repositories, or else the fetcher
> will unhelpfully volunteer to wget gigs of what amounts to largely
> useless content that we don't want.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  meta/recipes-kernel/linux/linux-yocto.inc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/meta/recipes-kernel/linux/linux-yocto.inc b/meta/recipes-kernel/linux/linux-yocto.inc
> index a85280990b43..5ec1b1ba7023 100644
> --- a/meta/recipes-kernel/linux/linux-yocto.inc
> +++ b/meta/recipes-kernel/linux/linux-yocto.inc
> @@ -56,3 +56,13 @@ do_install_append(){
>
>  # enable kernel-sample for oeqa/runtime/cases's ksample.py test
>  KERNEL_FEATURES_append_qemuall=" features/kernel-sample/kernel-sample.scc"
> +
> +# For linux-yocto-dev, the existing v3.17 based premirror tarball is of no
> +# value, and for the non-dev variants, we don't want to be going off and
> +# w-getting the 3+ gigabyte (!!!) mirror tarball either, when we've got
> +# a shared v5.10 repository already.  We can delete this in the future once
> +# these old tarballs are gone.  But really we may never bother to mirror
> +# either of them ever again, since they are (a) now small, and (b) leaf
> +# nodes at the end of the chain where the content is regularly changing.
> +PREMIRRORS = ""
> +MIRRORS = ""

I suppose these are already set somewhere else, so a ?= won't actually
override the defaults.

I was just trying to think of a way that someone might want to turn it
back on, and they'd have to use an override in a bbappend to do it ..
but I suppose that isn't any nastier than would be required with ?=

Bruce

> --
> 2.25.1
>


-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
