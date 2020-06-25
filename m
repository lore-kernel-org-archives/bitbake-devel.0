Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web11.12175.1593096256536610174
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2020 07:44:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Y9TPQ2br;
 spf=pass (domain: konsulko.com, ip: 209.85.167.178, mailfrom: paul.barker@konsulko.com)
Received: by mail-oi1-f178.google.com with SMTP id w17so4463398oie.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2020 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kHlvITUPzjDiF9czFm14s8upbISakUWY5JjegQ06Ro=;
        b=Y9TPQ2br7+wZyih+pmLUL3bSsxaHcU0Fb0BYU3w9YczAghF32U+cRNELHb6waDetdl
         iiCPT5cxftclolwe6788bAc+51D2on8Wzjl49AOtCXz05wstQbWh1Pjp/rvKb/BDN6yo
         dkyNDIPa2G8EH0MWdII1bhnpoRjnJ69XGbP2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kHlvITUPzjDiF9czFm14s8upbISakUWY5JjegQ06Ro=;
        b=U5TT2pXtbT5BKgWX0G44ZIXEnM/1fMQg8qLBICizRH9uIF1OHeKVpj0El9w8aZEnyi
         84S2Z/1g7lHMjBQHdZp7xy2flYxeS1xxsaw5tbhWpp60jC1BT70Uk9ucVC6iVGws3CVa
         jMFl3wbx5LVi8VMe/rZGeyxyslCioFqcJL+/1SZM7ClnL4f5iOHdmy7vfondDfnodJhh
         Lg6u/rLzFcp7iWJFuTCO3tPVTBeOMnjYXmvN1ViSiDHRY0fTl0Uy/pWr0dmlr5wVS4xE
         IrqgEPqvmXBN7bxlhZD8pSVJnpnoJh4GYnIem7ok3HuVSUWbYnjcE/dP+HVyShAvc2eb
         Xxdg==
X-Gm-Message-State: AOAM530og0faxNFOnwuFATeZj1vljJyW50b6kXiv/Nrg9iwKZU1N+Cl9
	vIW0UvAGqOBDVl1IUXdj1I2l29qK7hTTS23CO5SZbCTl
X-Google-Smtp-Source: ABdhPJzP73NJjUAQKifGwEpJtj+sfh9FOcZM2UFjRMiYIapbbaK1jn+S/qEfK38CDKdvhCiPqOAKZAm+HSNTN6xlXMA=
X-Received: by 2002:aca:49cb:: with SMTP id w194mr2344637oia.152.1593096255869;
 Thu, 25 Jun 2020 07:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <lyh7uzxnvx.fsf@ensc-virt.intern.sigma-chemnitz.de>
In-Reply-To: <lyh7uzxnvx.fsf@ensc-virt.intern.sigma-chemnitz.de>
From: "Paul Barker" <pbarker@konsulko.com>
Date: Thu, 25 Jun 2020 15:44:05 +0100
Message-ID: <CAM9ZRVuqYrSW5-WLsUnZG4ok=qSc82BkrZgSC=ToGgDoBLXpBg@mail.gmail.com>
Subject: Re: [bitbake-devel] Support for git+https://foo.example.com like URIs
To: enrico.scholz@sigma-chemnitz.de
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jun 2020 at 14:42, Enrico Scholz via lists.openembedded.org
<enrico.scholz=sigma-chemnitz.de@lists.openembedded.org> wrote:
>
> Hello,
>
> for some years we are using a mechanism which allows to encode the
> protocol ("https", "file", ...) within the base uri.  So, we can write
>
>
> | PROJECT_BASE_URI = "git+https://foo.example.com/project"
> | SRC_URI = "${PROJECT_BASE_URI}/some-repo"
>
> instead of
>
> | PROJECT_BASE_URI = "git://foo.example.com/project"
> | PROJECT_BASE_PROTOCOL = "https"
> | SRC_URI = "${PROJECT_BASE_URI}/some-repo;protocol=${PROJECT_BASE_PROTOCOL}"
>
>
> Four years ago I wrote a bug report [1] with a patch against bitbake
> itself which was more or less rejected.
>
> In the meantime, I moved this out in an OE class [2] which overrides
> 'bb.fetch.decodeurl'.
>
>
> Is there some generic interest in this functionality so that I can
> create and send a patch for bitbake?  Or is this too special and people
> are happy with altering ${MIRROR}?
>
>
>
> Enrico
>
> Footnotes:
> [1]  https://bugzilla.yoctoproject.org/show_bug.cgi?id=9738
>
> [2]  https://github.com/sigma-embedded/meta-de.sigma-chemnitz/blob/zeus/classes/elito-uridecode.bbclass
>      https://github.com/sigma-embedded/meta-de.sigma-chemnitz/blob/zeus/lib/elito/__init__.py

I'd implement this in an inverse way, add a new class for your
projects, eg. my-project.bbclass:

    MY_REPO_NAME ?= "${BPN}"
    SRC_URI = "git://foo.example.com/project/${MY_REPO_NAME};protocol=https"

Then in your recipe, inherit the bbclass and override the repo name if
it doesn't match the recipe name:

    MY_REPO_NAME = "some-repo"
    inherit my-project

That can be done with no modification or monkey patching of the fetcher.

Thanks,

--
Paul Barker
Konsulko Group
