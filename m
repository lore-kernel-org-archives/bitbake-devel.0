Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.22376.1617394438891600072
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 13:13:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=B88I9yqq;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id hq27so8750950ejc.9
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Apr 2021 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OeYWIWmBNu39xulAvtxOj6zpTpP4b/tFV/CNxsg0pEg=;
        b=B88I9yqqoQzba2hOm3RJGH5AIvtIA/dCqAbN1llCgXYBTKG+02Tm+zh91ahapCazUf
         nnpldCEWI4f3Fsnmij+tfiDUNfvtwwogZr62H8CVFkUJ7T9p2LrxdPHw1s/RT55vBliE
         8o6zu35MZT50mFrwM/h3EN8IjOk5hNy4U3jlrf68MZarUL+aNBdiJ9BvkXYd1OcQHbOb
         ojoX94ToSYTw55RruFZzbluoeAowG6fxQbOSPgbKxYexr3o7VFW2UoUWJugLi0ahSaiE
         UcgZCAW7tG970hxt4XlGP7j9gmgcoaXvq1VveXt+8cTioRCMPomuosEk9EbaDlY7F9YC
         ZO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeYWIWmBNu39xulAvtxOj6zpTpP4b/tFV/CNxsg0pEg=;
        b=OTP+vPKt2q/LxLK4ub0ohGURnVTxJMnn8LmIt5fJ955mGbclxTnXDG6mjU3OCdlsN0
         7YkwBvDVx+CLuxy45zyZthIDqc6ONVbVp2RVSuwFLzryPsjeAPJPYp0qU+V6jHGVYNYf
         25RpE1/3rJD8e5DZEOmjgCp+J9RTap6H356BItxATg1g0kF9fQxl8/93VOHR9QoVy2uu
         syPS5yVjch9l62wiIlMJKQUu46US2BnDXbBpBY0dCraTR1TVRvrRfN5x14IiAKrmMC0f
         paw6OZs3IppLitbOFSRshc8MKY49+HGaUWS9OFt60lEfM4lz3p+TYKQWn3Pbpt8lxj77
         uvHw==
X-Gm-Message-State: AOAM530mK7ZSD5TVPsR2w0djirR6HL4KdgOdRouJOuy00w/MDYf+A066
	uLSRbcLhqtRsWQoqoKA5jG0HLhQmKhIOYn6ydMw=
X-Google-Smtp-Source: ABdhPJyR0RoS96a3CxPHOUsg8FNQ1azOI9Qg1Cpwt+dLKwjQ8X8bRyrqdxCEFjZU/N3DEQhHDuG5pUGOTPLKJ0Mth/c=
X-Received: by 2002:a17:906:75a:: with SMTP id z26mr15493007ejb.22.1617394437288;
 Fri, 02 Apr 2021 13:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210402171557.981599-1-paul.gortmaker@windriver.com> <20210402171557.981599-12-paul.gortmaker@windriver.com>
In-Reply-To: <20210402171557.981599-12-paul.gortmaker@windriver.com>
From: "Bruce Ashfield" <bruce.ashfield@gmail.com>
Date: Fri, 2 Apr 2021 16:13:46 -0400
Message-ID: <CADkTA4OiUnnQDfY+vXgBFkaC-P=zPH0xWO3Z8v8aOJY0T2Es8g@mail.gmail.com>
Subject: Re: [PATCH 11/21] kernel: add a fetch-only recipe for mainline v5.10 source
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Linux Yocto <linux-yocto@lists.yoctoproject.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 2, 2021 at 1:16 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> With v5.10 being the newest baseline currently in use by linux-yocto and
> with the download size being 1/2 the size of current linux-yocto itself,
> the v5.10 makes a good initial line in the sand for blocking out the
> source in a way to optimize sharing.
>
> With this commit present, one can test via "bitbake -c fetch linux-5.10".
>
> Pending recipes who will want this source present will add:
>         do_fetch[depends] += "linux-5.10:do_fetch"
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  meta/recipes-kernel/linux/fetch-linux.inc | 7 +++++++
>  meta/recipes-kernel/linux/linux-5.10.bb   | 9 +++++++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 meta/recipes-kernel/linux/fetch-linux.inc
>  create mode 100644 meta/recipes-kernel/linux/linux-5.10.bb
>
> diff --git a/meta/recipes-kernel/linux/fetch-linux.inc b/meta/recipes-kernel/linux/fetch-linux.inc
> new file mode 100644
> index 000000000000..e3fdd0bb36c2
> --- /dev/null
> +++ b/meta/recipes-kernel/linux/fetch-linux.inc
> @@ -0,0 +1,7 @@
> +# Boilerplate to fetch up to a single tag of mainline
> +
> +require recipes-kernel/linux/fetch-only.inc
> +
> +GITCLONEARGS = "--bare --single-branch --branch v${KTAG}"
> +DL_NAME = ".torvalds.linux-${KTAG}"
> +SRC_URI = "${KORG_URLBASE}/torvalds/linux;tag=v${KTAG};nobranch=1;static=1;dlname=${DL_NAME}"
> diff --git a/meta/recipes-kernel/linux/linux-5.10.bb b/meta/recipes-kernel/linux/linux-5.10.bb
> new file mode 100644
> index 000000000000..7f8a27bcb1f0
> --- /dev/null
> +++ b/meta/recipes-kernel/linux/linux-5.10.bb

A specific comment is that this should actually have "fetch-only" in
the name of the recipe.

We want to avoid any confusion about this being buildable, and that it
is not a jumping point
for kernel builds.

Trust me, someone will ask.

linux-yocto has v5.10/base which is vanilla -stable, and simply
because the name is
linux-yocto, people never realize that they can build a completely
stock greg-kh kernel
until they turn blue :D

Otherwise, I like the concept and can take it for a spin.

Bruce



> @@ -0,0 +1,9 @@
> +SUMMARY = "Linux kernel v5.10 source"
> +DESCRIPTION = "Fetch source of the linux kernel up to the v5.10 tag"
> +
> +LICENSE = "GPLv2"
> +LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
> +
> +KTAG = "5.10"
> +
> +require recipes-kernel/linux/fetch-linux.inc
> --
> 2.25.1
>


-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
