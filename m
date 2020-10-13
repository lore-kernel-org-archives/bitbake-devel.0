Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
 by mx.groups.io with SMTP id smtpd.web10.1979.1602613236491399260
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Oct 2020 11:20:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Al+pqloo;
 spf=softfail (domain: sakoman.com, ip: 209.85.218.68, mailfrom: steve@sakoman.com)
Received: by mail-ej1-f68.google.com with SMTP id ce10so1141647ejc.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2020 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cs9j+IkH+MX8f00S5akkQkZbiTPk8snOpKME/OSS2ko=;
        b=Al+pqloowqvJa8DdUe6ApJ2qP75Q2hfHibUcm3u6gjaCMrU4ZnFvncPkqI3bktNur+
         rPxiFbcfcBDIuer9QtqgmINdCFoput+EmLFzU6Yr/MITh7qy0YjzfJSF6aYtZMSdxCAa
         xkTCcYnz7T21rL/7wFjQmoY16A4fqKyUrMEG6RncGRd8RRBCHWH8dtMG8cn2Vqbdmpy/
         mtMa0RTGRJA9J1JGu616sIS+hilovm4bIl+mxLUl/eUnqa2PQ5LLsUmEzj9/fAbXrh4t
         JJF7ZM3DntfQFvVsVYddc4c0T7Jq0wPBLUY+wFw5S4ZpZODzH+n3JGtKTZQTbD8ukgy4
         +t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cs9j+IkH+MX8f00S5akkQkZbiTPk8snOpKME/OSS2ko=;
        b=bt2Kt0d19Ttxrvp63VEJMYzMmlLlLu0HE7ET6eIVL2s5stvEyMKoOeEkw9gPQLECF0
         g1N8kXDd9Jg+7sOPsHmEDWPLuU8y2x9AYesg5n3Zt+pwpWMyA8DdmyMwfEoa9LR6jSTd
         pCDaoFUidxsQMdS1ktlBfo3mcKQqFBYB+0k3rJol/WW+4+P5W+6iEiyD7QZJsoliJM4z
         ddhjWhpGJZvOM1I9GaIFYcvxQ82DgURwYHppMPWxNibBaYUjB0KtVXgkrTM0rxb45Tyf
         9orOEVZQujvcJprr3holJxKh/IUD4QFuaXJhxWukZ++R4pkT88EQDMRbbHy30BHCPrWd
         Qu5w==
X-Gm-Message-State: AOAM531g8uN9xQPplp3heUedWOHDFFN40PMd6D4CLnMQb4Kpy1+2Yu4s
	MrN5xEW3/2Y6xDTrJC0bNbmE9kt2dK7k4t8U0iSEVQ==
X-Google-Smtp-Source: ABdhPJwP56m2klNBejtJSmea4Iei/PP5vrSZpv8BO1HnRiFVFKajPYlYdzMAhmX8ZRqsWRf+aOEuHaqxbASwdgE7VGU=
X-Received: by 2002:a17:906:4811:: with SMTP id w17mr976883ejq.431.1602613234902;
 Tue, 13 Oct 2020 11:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602515077.git.steve@sakoman.com> <0a8a13131b2d520a405877cb9d39f3eae7d6882a.1602515077.git.steve@sakoman.com>
 <lyo8l69z68.fsf@ensc-virt.intern.sigma-chemnitz.de>
In-Reply-To: <lyo8l69z68.fsf@ensc-virt.intern.sigma-chemnitz.de>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Tue, 13 Oct 2020 08:20:23 -1000
Message-ID: <CAOSpxdZ-L_YBuB+urokrTuLNKdLBhnrc7xY41ubh_p03ZVxzSw@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 1/2] bitbake: fetch/git: add support for SRC_URI containing spaces in url
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Charlie Davies <charles.davies@whitetree.xyz>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 13, 2020 at 12:51 AM Enrico Scholz
<enrico.scholz@sigma-chemnitz.de> wrote:
>
> "Steve Sakoman" <steve@sakoman.com> writes:
>
> > This commit adds support for such urls by implementing two changes.
> > Firstly, when bitbake makes a git command line call the url is
> > surrounded by quotes so that the url, regardless of spaces, is
> > treated as one argument. Secondly, additional parsing of various
> > filepath variables, which are based off of the url, are now
> > completed with any spaces in the url replaced with underscores.
> >
> > -            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, repourl, ud.clonedir)
> > +            clone_cmd = "LANG=C %s clone --bare --mirror \"%s\" %s --progress" % (ud.basecmd, repourl, ud.clonedir)
>
> Why do you quote it manually (and with double instead of single quote))
> instead of using shlex.quote() or making the clone_cmd an array?

This question is best addressed to the patch author (copied)

Note that this patch has already been accepted into the master branch,
and my request for comment was just for cherry-picking the commit into
the dunfell branch.

Steve
