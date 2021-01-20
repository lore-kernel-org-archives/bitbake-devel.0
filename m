Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web08.26208.1611140033075349004
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Jan 2021 02:53:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20150623.gappssmtp.com header.s=20150623 header.b=KBuCNajo;
 spf=pass (domain: burtonini.com, ip: 209.85.208.181, mailfrom: ross@burtonini.com)
Received: by mail-lj1-f181.google.com with SMTP id f17so25488735ljg.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Jan 2021 02:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6wCuN43+9vjPf3pY4EvjsWFNoMeq1T8OjXXRadabJE=;
        b=KBuCNajo2CwXS/SNvjprFDe5JsXhVcnZ0LKRH+TIETpPHPK7ToIrG5V8voKv/DEqtB
         K2Mo9D0xYJuok85Hu9XCsKvc27+bCU7Wm6zRMXXQ7UpZNuZ1Jv0M7IUiFLakRAwFsxUG
         8i1qlMM2orEPS02dAHIcpK3ZiAI8MazDMEPuCFPPAs8U37VQRs84aXcC7I9SRvYSB+1I
         UYCx83o+ugHbBSh50Rs9pShAA+/AKRafyqLEv0Fk9X01qp+UJVEOztv4xVHW8phw7yYf
         KWhI0pUwQvieN97OWKQR1v5cGZ9hlniRZ7+V/+spm3bdDPxAt/xSQGFdmbs/61iZActt
         tocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6wCuN43+9vjPf3pY4EvjsWFNoMeq1T8OjXXRadabJE=;
        b=pnbUXn8ZzrIsi8NuTrBDXioaAjeF03G+rt70rNCXc5IH4Dfji8y231QIQaJ5lQJX/5
         tzqd6P7yN4F25akyq2VBya1DX5jtUhqw//JvPWcUaGrjrNiVW64sY4nl+YUo4tHqta83
         YfINTgUJXO66FmymViyVOezYMVlMVEjVTOMejEturfORzxUhXXuU9f7hL39+whfgmZoZ
         XKYu06NCo2/CW6qvkrBsFMLJFSz9ZS8qgb9gXdvxpF65a1LXROmcXrKcvu2nT7xGqOUf
         /tl8DGd6RZPxk39qbjEnPE+i2+TiczBMGjZ2x4XIfxU+mKtAREc/agF+H6JjORlMolNz
         DdCg==
X-Gm-Message-State: AOAM530omV8zFGBdempA7YfaqXUEqFedjVompT9+a01tYUa02KdGEt3Y
	w5TndS/APs9wCyrGMzbtxQR5yGNkx0qxVH3yb1oIsQ==
X-Google-Smtp-Source: ABdhPJwgN3/I+CRwsw3y67jmEZqVOCcZbxavZd7Ql2d6Ivv4P3KpkjZvvcT1HsUe95eKH+tlHNpOzyqc3sxoXnLux2U=
X-Received: by 2002:a2e:3807:: with SMTP id f7mr4116114lja.24.1611140031315;
 Wed, 20 Jan 2021 02:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20210120095046.31357-1-christophe.priouzeau@st.com>
In-Reply-To: <20210120095046.31357-1-christophe.priouzeau@st.com>
From: "Ross Burton" <ross@burtonini.com>
Date: Wed, 20 Jan 2021 10:53:40 +0000
Message-ID: <CAAnfSTuFRJWaouXNz3DsFsXnT+ShNA5RYQx=S2zFs4FhT3WDgA@mail.gmail.com>
Subject: Re: [bitbake-devel] [MASTER][1.46][PATCH] WGET: update user-agent
To: christophe.priouzeau@st.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

There are two instances of the User-Agent in that code.  A quick patch
I came up with during the call yesterday is as follows:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=ross/mut&id=16b98ea3e0d01f1c71073d135301c6db315b0ac8

If you can come up with a patch that incorporates the fixes in mine,
feel free to post it with your authorship as there's no way I can test
it.

Ross

On Wed, 20 Jan 2021 at 09:50, cpriouzeau via lists.openembedded.org
<christophe.priouzeau=st.com@lists.openembedded.org> wrote:
>
> With the usage of enterprise proxy, the user-agent defined are
> too old and refused by proxy configuration.
>
> Signed-off-by: Christophe Priouzeau <christophe.priouzeau@st.com>
> ---
>  lib/bb/fetch2/wget.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index e6d9f528..98c6635d 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -297,7 +297,7 @@ class Wget(FetchMethod):
>              # Some servers (FusionForge, as used on Alioth) require that the
>              # optional Accept header is set.
>              r.add_header("Accept", "*/*")
> -            r.add_header("User-Agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12")
> +            r.add_header("User-Agent", "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gecko/20100101 Firefox/84.0")
>              def add_basic_auth(login_str, request):
>                  '''Adds Basic auth to http request, pass in login:password as string'''
>                  import base64
> --
> 2.17.1
>
> 
>
