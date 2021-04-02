Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web09.22384.1617394615210394597
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 13:16:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kfs9pixv;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id u5so8775700ejn.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Apr 2021 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LliHztjkW5cOlgoFUesrBiuvkKZgMSEYDA0zJ/NIYYU=;
        b=Kfs9pixvuX2aSIGOJADxucJIaAlbfDY6lPHcfYsS9FWPn4qg6sNIRM+BxbjW9idpUw
         9VA8rkv27ZjmBYnDvC5zIsES1jBjMx4wQbvwTqky3vhfGzqcOtxfGuNQPjIkrUOZ/3sO
         10dShBGMId8Sv3ObpuUjIWgnVVQhgUxUyc2oKkC2PfwpIFi8LNiYAcjJf+E+d2eAIFSy
         U2cLoZFhvZAEYUOk9LpO+bUJsfdJwCumbBy9WlqPZo2Ak9IKYYEs20TTrb+cC+2M/qyW
         RhJK2EOnBXrB0IRfH1Tm5DY9+noySAI5sVRYZXPrqI8S2o+H62ep6slmYkBs2o1a5Wi/
         4nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LliHztjkW5cOlgoFUesrBiuvkKZgMSEYDA0zJ/NIYYU=;
        b=O1X32l/EhyPgs9QtQihaCQv8t97oEh0YOkehppB8+9mpTmHpf4h0aBDpZO61jC4USu
         hASf8kWiHKs7iaMz/0SQJHIokslsS+r9xhrzJA/2UmAZvAYGIzI0xEGSSMKIWvMXgXaR
         ZNs9al5enVIV4e5dzYJKmeyn6xcVBt+6+H8jVG8CNsPqhO6CsZEE1aiuYYBQePfVhOUQ
         +4qCbVZYk2k3lYcjtPhs+O72Zxwm/rnIPaIzhJ1f21RfvvpLUj5H/jzyYRgajwXz5LfG
         WMjsWrGrBMH9XcppsLvpkkTUDpa0D56Gj2W4SEUsnvmAR1CNRWo7DNLQhQovuq7nxmUc
         DSwg==
X-Gm-Message-State: AOAM532GKhEA77+L0UaXxaKrC2WhtdSwLsGVBMh4xoyLkFNovJCNTSLN
	OfiR598b2bGUcMaSdtzbJxgIm2N5/3+n3ZAlGZg=
X-Google-Smtp-Source: ABdhPJxbUtamCB6watc+DcM3nmB8K9XgNhENBP7p14PrbG3BIvEFMNSMZbTTd5UpcZT4vXTY4CXGc6l+amuC5uxV7vQ=
X-Received: by 2002:a17:906:2a16:: with SMTP id j22mr15819602eje.247.1617394613678;
 Fri, 02 Apr 2021 13:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210402171557.981599-1-paul.gortmaker@windriver.com> <20210402171557.981599-16-paul.gortmaker@windriver.com>
In-Reply-To: <20210402171557.981599-16-paul.gortmaker@windriver.com>
From: "Bruce Ashfield" <bruce.ashfield@gmail.com>
Date: Fri, 2 Apr 2021 16:16:42 -0400
Message-ID: <CADkTA4Mu3YYU7U2zegaGmfnL_Omeozb1nAHfRn59sfOZyw8n=Q@mail.gmail.com>
Subject: Re: [PATCH 15/21] kernel: add recipe for linux-master (mainline latest)
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Linux Yocto <linux-yocto@lists.yoctoproject.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 2, 2021 at 1:16 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> The idea for this recipe is to have a name "linux-master" that people
> can depend on as a reference for mainline; today and ideally for as long
> as we are maintaining it.  While the recipe is there for everybody,
> the obvious user we are creating this for is the linux-yocto-dev repo.
>
> At some point in the future, we'll carve off another chunk of post-v5.10
> work, mark it static and put it alongside of v5.10 and let this mainline
> recipe reference that.  But use of this "linux-master" will be 100%
> transparent to the underlying backing store changes.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  meta/recipes-kernel/linux/linux-master.bb | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 meta/recipes-kernel/linux/linux-master.bb
>
> diff --git a/meta/recipes-kernel/linux/linux-master.bb b/meta/recipes-kernel/linux/linux-master.bb
> new file mode 100644
> index 000000000000..f674c2562e81
> --- /dev/null
> +++ b/meta/recipes-kernel/linux/linux-master.bb

I won't reply to all of these fetch only naming patches (maybe this is
the last one,
I didn't check), so this is my last one.

My same namespace comment applies here

Actually, thinking of it more, we could even have these both with fetch-only in
the recipe name AND in a directory structure that implies the same thing.

And thirdly, maybe we could taint the tasks in some way to prevent that jumping
point to building.

Since yes, you'll get someone trying to ask for support using this to build
version 'x' of mainline. I have the battle scars to prove it :D

Bruce

> @@ -0,0 +1,13 @@
> +SUMMARY = "Linux kernel mainline source"
> +DESCRIPTION = "Fetch source of the latest linux mainline kernel"
> +
> +LICENSE = "GPLv2"
> +LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
> +
> +DL_NAME = ".torvalds.linux-master"
> +KORG_REF = "git.kernel.org.torvalds.linux-5.10"
> +SRC_URI = "${KORG_URLBASE}/torvalds/linux;rev=master;nobranch=1;dlname=${DL_NAME};packref=${KORG_REF}"
> +
> +do_fetch[depends] += "linux-5.10:do_fetch"
> +
> +require recipes-kernel/linux/fetch-only.inc
> --
> 2.25.1
>


-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
