Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web12.52705.1629281247778039827
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Aug 2021 03:07:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@burtonini-com.20150623.gappssmtp.com header.s=20150623 header.b=Ac4rOyQ9;
 spf=pass (domain: burtonini.com, ip: 209.85.221.54, mailfrom: ross@burtonini.com)
Received: by mail-wr1-f54.google.com with SMTP id v4so2558306wro.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Aug 2021 03:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burtonini-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNHD02HSYQJ1sN6ZHgYKoPtDBVGKm5Q69aILOTUDgco=;
        b=Ac4rOyQ9SSVHkGMMDk5gIwBRprmaa8AeA/rPUPlunr9ldQa+uMHi6BMC8mIQkB1iV2
         8ghdqFkOuJCDMoCzgPNhpcPABv5Fe3UO0GgkVvzf55BaQ/7s02C9iprseaeOnQ5xexcj
         n5/lwbOcMY0dofgqfvjnsE3Pg5wTSugrPD+KpqWuRQZj9lBBc7LfL3P2gJE1cjuQmFkq
         N1tutMj3+GldvXS06S6xicddmncj970mtEk/rs3RPCR+Vd5pO0Wm/5IoctuEADlHl0rz
         TpwOldasziJHp8CghQvoY4q99iQg9wJUd7DmICky9IidaKDk4ZMaKRBOadJ/knSdiYaE
         2NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNHD02HSYQJ1sN6ZHgYKoPtDBVGKm5Q69aILOTUDgco=;
        b=KqlvtEHerW/uvDFTqCHVHfASXuubJmSSPCNWPLs7ygAmOzr9alEd9YBzIWg1YvRDWy
         RGr2643NCzS92lonOlPVj5WkUQJ9BVeJqGxaNNiKNXTHQ34L6QsNZZpOA+o70uIfoelc
         8Unm+ea6+/1Sk7KZJYbU7U+2UYa4LipiJXGgrpEtRB8bV7o2AQuekXPLn/ElsL+ojFLH
         gOhHABQ22VKwUVkYU5kLx2xsOr6VSdCgel3fNE+y+Bz8UpnFQqYNT13r0VFdq49u6Xe8
         andDRUjRC6Xa543PFHplTpMyd3KpshbFvP5DgmxWNSuDSlt72VZs4St2QXcipxZLczSD
         /Ekg==
X-Gm-Message-State: AOAM531FOCm3Q3CYxazLIkiK+AT4ciXDMm16p+zLMNyIUiTZBYh9njK+
	eJ90pmrmTgMWRkot5hPDNovj5d3RD2oqrw9/Hv9QEQ==
X-Google-Smtp-Source: ABdhPJzCteZPrS27S9hl9IjWC+BpDpP4uapJutGhu8vatU1v28xa7Xb4ZgSkDo7ZGRlUsEGZJkOk50YPE5IsRu3cVSU=
X-Received: by 2002:a5d:534e:: with SMTP id t14mr9600457wrv.109.1629281245883;
 Wed, 18 Aug 2021 03:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210810165509.19121-1-ross.burton@arm.com> <20210810165509.19121-3-ross.burton@arm.com>
 <ly5yw4rmx4.fsf@ensc-virt.intern.sigma-chemnitz.de> <lywnojqeyb.fsf@ensc-virt.intern.sigma-chemnitz.de>
In-Reply-To: <lywnojqeyb.fsf@ensc-virt.intern.sigma-chemnitz.de>
From: "Ross Burton" <ross@burtonini.com>
Date: Wed, 18 Aug 2021 11:07:15 +0100
Message-ID: <CAAnfSTt+vLN3hHE7aRDBtcO7dbkWEEX_SwAXxc5R5D=SbqvaRA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 3/4] fetch2/wget: ensure all variables are set when calling urllib
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

As you've chased this, please send a patch.  Apologies, I thought I
checked that all the variables were already checked by the time the
with block closes.

Ross

On Wed, 18 Aug 2021 at 10:28, Enrico Scholz
<enrico.scholz@sigma-chemnitz.de> wrote:
>
> "Enrico Scholz via lists.openembedded.org"
> <enrico.scholz=sigma-chemnitz.de@lists.openembedded.org> writes:
>
> > "Ross Burton" <ross@burtonini.com> writes:
> >
> >> Instead of just exporting the proxy variables when calling into urllib,
> >> use bb.utils.environment() to export all of the known variables that are
> >> needed for proper connectivity.
> >
> > This patch breaks fetching from sstate servers[1].
>
> | --- a/bitbake/lib/bb/fetch2/wget.py
> | +++ b/bitbake/lib/bb/fetch2/wget.py
> | ...
> | +        with bb.utils.environment(**newenv):
> | +            import ssl
> |          ...
> |          try:
> |              uri = ud.url.split(";")[0]
>
> Moving this 'try' block (with the `opener.open(r)` call) into the 'with'
> context seems to solve the problem.
>
>
>
> Enrico
