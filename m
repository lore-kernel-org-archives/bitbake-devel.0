Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web09.6449.1611233086464898857
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Jan 2021 04:44:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20150623.gappssmtp.com header.s=20150623 header.b=wFhnCu/X;
 spf=pass (domain: burtonini.com, ip: 209.85.167.41, mailfrom: ross@burtonini.com)
Received: by mail-lf1-f41.google.com with SMTP id m22so2310765lfg.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Jan 2021 04:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ak3KQBOwm4izD66Jp+WJSnHNkAksfMKAPW3OycBWNjk=;
        b=wFhnCu/XHfoq0qTKD/SU2nB7aTHXOjTEwgkq4Ofks/JDvE0zF8aUVJ3DYmOTSgVtpy
         tkAe8Jkc2arP4TQjbDw4Hm9pzHg9xiriXMRwUp2+8beA064MKjDspKeCA3JwCAY67T0u
         nk4RxkOR4891qykagO9zAEe/Xap7X2k2fjH1eo/gnLdyAi0IcSaLjyJeAQ9ACQVaa1aS
         nkqvN030PBKgAZo8pSNhU+sWZzw7MLf4JeSnOLxH4njGIUDCs9fiSvTFFNAsq3rwCgDG
         eI3JuNuqdNLdNBkENlWZvs3CP5Q2EnApBK41cCnfZeboWCVveFVZqVBZuIwZ6ATYqRgm
         lnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ak3KQBOwm4izD66Jp+WJSnHNkAksfMKAPW3OycBWNjk=;
        b=cQsxMj/lu63E1qAKMHRZUnzQ/ovAQbVWpY3PFpkr2TMMJl/3t/Q4eEjJx+eEE03Meg
         LvbHyzq9wxHYFmcFTlFdiwcabvevoGz4G5N62kqrnc0qG8tcePZRy5dFdxvkBXezft4D
         bWX2m84KAUuvi8FyCOisFQiEtg2pQ8LzJU3+YIbJTC7AkcmMmPrQ6OyAE2pRrN6II3lx
         ZYDgarAbwNmnQ+gnGjufYg0mO2cRs7np1GpBhm9BiRaTs/Q6pjy+R02J8zY4t0518eoe
         SepIJKojVy6oWJWkS/BeAmeNU/6UXjESMyUD4yT/J/MBiiu41spdljQjjcv8Rmf/3GuP
         hKEQ==
X-Gm-Message-State: AOAM5330MraxU3weorVH+eG3ex7G3IWtE2B8WUVQoh+MiYCN5NXqFlqo
	Riz8lpS7LFAVzRyq4vCkpERrJDFLk6jIWF58L1UJJg==
X-Google-Smtp-Source: ABdhPJz45PnlF/bxQ8KV1jm09H/KyXGpp3TIkrWJQOXWchsuAIhn59Ja+9OJSh7yA8v9iR4bBgsDILWqzJwxqToNJ78=
X-Received: by 2002:a19:d07:: with SMTP id 7mr1676898lfn.215.1611233084291;
 Thu, 21 Jan 2021 04:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20210120111304.3689-1-christophe.priouzeau@st.com>
In-Reply-To: <20210120111304.3689-1-christophe.priouzeau@st.com>
From: "Ross Burton" <ross@burtonini.com>
Date: Thu, 21 Jan 2021 12:44:33 +0000
Message-ID: <CAAnfSTsyC1YudFGtnm171AVEM7OQp9Nqi9KbuoOzTFuS+zN2Nw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] WGET: update user-agent
To: christophe.priouzeau@st.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, Ross Burton <ross.burton@arm.com>
Content-Type: text/plain; charset="UTF-8"

Acked by me.

On Wed, 20 Jan 2021 at 11:13, cpriouzeau via lists.openembedded.org
<christophe.priouzeau=st.com@lists.openembedded.org> wrote:
>
> With the usage of enterprise proxy, the user-agent defined are
> too old and refused by proxy configuration.
>
> Signed-off-by: Christophe Priouzeau <christophe.priouzeau@st.com>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
> V2:
>  - update of Two User-agent (integration of comment of Ross Burton
>  - Test passed under STMicroelectronics enterprise proxy
>
>  lib/bb/fetch2/wget.py | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index e6d9f528..e952f411 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -52,6 +52,12 @@ class WgetProgressHandler(bb.progress.LineFilterProgressHandler):
>
>
>  class Wget(FetchMethod):
> +
> +    # CDNs like CloudFlare may do a 'browser integrity test' which can fail
> +    # with the standard wget/urllib User-Agent, so pretend to be a modern
> +    # browser.
> +    user_agent = "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gecko/20100101 Firefox/84.0"
> +
>      """Class to fetch urls via 'wget'"""
>      def supports(self, ud, d):
>          """
> @@ -297,7 +303,7 @@ class Wget(FetchMethod):
>              # Some servers (FusionForge, as used on Alioth) require that the
>              # optional Accept header is set.
>              r.add_header("Accept", "*/*")
> -            r.add_header("User-Agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12")
> +            r.add_header("User-Agent", self.user_agent)
>              def add_basic_auth(login_str, request):
>                  '''Adds Basic auth to http request, pass in login:password as string'''
>                  import base64
> @@ -401,9 +407,8 @@ class Wget(FetchMethod):
>          """
>          f = tempfile.NamedTemporaryFile()
>          with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
> -            agent = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12"
>              fetchcmd = self.basecmd
> -            fetchcmd += " -O " + f.name + " --user-agent='" + agent + "' '" + uri + "'"
> +            fetchcmd += " -O " + f.name + " --user-agent='" + self.user_agent + "' '" + uri + "'"
>              try:
>                  self._runwget(ud, d, fetchcmd, True, workdir=workdir)
>                  fetchresult = f.read()
> --
> 2.17.1
>
> 
>
