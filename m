Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.2095.1627945989548606513
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Aug 2021 16:13:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=cRJjJ65G;
 spf=softfail (domain: sakoman.com, ip: 209.85.128.41, mailfrom: steve@sakoman.com)
Received: by mail-wm1-f41.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso520613wms.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Aug 2021 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6bcyMBztNejfInVdV18u2m+b926aVBnzeVt5zt5e9c=;
        b=cRJjJ65GfGrdUNT31jynyyHEYNknA1S8y1+ps73U4v+cB5Y+w/D4n0hWHbh1OZvg1l
         P4nReShIXwEFxiAEeE9fGWX2XVebzst/nJUJPIYK1SK2T+zX9ltgiU4ZVGPTlxR6YZHy
         fJFNbh0/ne/g2wgmL3ygmPu/+ZNjkpGFolzwKfudDciQOyhYvn56YsvJHMpk9C6JknwI
         yEgx6RYn7HQxMSiYw7J1I0Bd5yhrVPpKg5+rkxCa5mNBS4mfj32yj5OTDAkkn9rZqSqu
         v5M17/7LBI3XHR3+F+CVbbKtQJxsMqqQwYz9LAPLAKGJV8BLfww+djUtyTrD+zOmDc4c
         lbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6bcyMBztNejfInVdV18u2m+b926aVBnzeVt5zt5e9c=;
        b=DYNBDSBLLEIayLHvT0aYQHQj+AQC6/3uoqahKGxXSRYnQGcinpxImAtzpSARYP5u19
         HjiK7vThxgev4vAAMmmt47JnOKpGtpjAEmlMhE26ZzI6CqQkVzEeHSWwgPQqadWwtu5/
         4aXJExyZd7Re9WzR2gizC2l3Vzp5a39TLLvJT8M89jrAt4lZrr/ePQRqUhABfaT5SdHH
         QhFvE5UuEoBqJkKlnpYFT0XMHWppyMeAncz6+1Q394QvpiDFWxt9iFVnwMGCa25n7tpb
         0t1TYjhHR0IMpmaEX/ftQK4gld8TjuCD3S1L1Au0+ELdOxAX17TqIf8qNfeySXOs4Aud
         cJqA==
X-Gm-Message-State: AOAM531aQ2m1ctgnxWqN8S/1umdYrALXUFJ7i+zH98/WpJQj4wBuuRAa
	BnJ1O7KSgqJlc3pdXt719ECP2rQgowaBz0CJO7AY0A==
X-Google-Smtp-Source: ABdhPJwf8FIhrgg8wS/amRGIFwVfNBPrnYwkUgVtBhcGgL/zVxQm0a+9+jLGpMprwjxs2ggPpK72kIaNMZQtioitdUM=
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr1175912wma.118.1627945987846;
 Mon, 02 Aug 2021 16:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <168F5A432E4959C7.26257@lists.openembedded.org>
 <20210802194545.GM1528@denix.org> <16979F7767E2872E.11217@lists.openembedded.org>
In-Reply-To: <16979F7767E2872E.11217@lists.openembedded.org>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Mon, 2 Aug 2021 13:12:56 -1000
Message-ID: <CAOSpxdZmdpkW=4s7QcW-sPb31wWsFS+-Fym1Bo5BOByrUiXv7A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH][1.46/1.48] providers: replace newly added logger.warn() with logger.warning()
To: Steve Sakoman <steve@sakoman.com>
Cc: Denys Dmytriyenko <denis@denix.org>, bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 2, 2021 at 12:58 PM Steve Sakoman via
lists.openembedded.org <steve=sakoman.com@lists.openembedded.org>
wrote:
>
> On Mon, Aug 2, 2021 at 9:45 AM Denys Dmytriyenko <denis@denix.org> wrote:
> >
> > Ping.
>
> Hmmm . . . I thought I had grabbed this, but clearly not!
>
> I'm on it!

And I see Richard beat me to it :-)

Steve

> >
> > On Tue, Jul 06, 2021 at 08:20:27PM -0400, Denys Dmytriyenko wrote:
> > > Commit https://git.openembedded.org/bitbake/commit/?id=78cd63285713fde59506eb2e71a7b7ee59a594ff
> > > converted logger.info() to logger.warn(), which is deprecated and instead
> > > should use logger.warning():
> > >
> > > https://lists.openembedded.org/g/bitbake-devel/topic/82742194#12377
> > >
> > > Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> > > ---
> > >  lib/bb/providers.py | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/bb/providers.py b/lib/bb/providers.py
> > > index 3f66a3d..484e1ea 100644
> > > --- a/lib/bb/providers.py
> > > +++ b/lib/bb/providers.py
> > > @@ -151,7 +151,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
> > >          if item:
> > >              itemstr = " (for item %s)" % item
> > >          if preferred_file is None:
> > > -            logger.warn("preferred version %s of %s not available%s", pv_str, pn, itemstr)
> > > +            logger.warning("preferred version %s of %s not available%s", pv_str, pn, itemstr)
> > >              available_vers = []
> > >              for file_set in pkg_pn:
> > >                  for f in file_set:
> > > @@ -163,7 +163,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
> > >                          available_vers.append(ver_str)
> > >              if available_vers:
> > >                  available_vers.sort()
> > > -                logger.warn("versions of %s available: %s", pn, ' '.join(available_vers))
> > > +                logger.warning("versions of %s available: %s", pn, ' '.join(available_vers))
> > >          else:
> > >              logger.debug(1, "selecting %s as PREFERRED_VERSION %s of package %s%s", preferred_file, pv_str, pn, itemstr)
> > >
> > > --
> > > 2.7.4
> > >
> >
> > --
> > Regards,
> > Denys Dmytriyenko <denis@denix.org>
> > PGP: 0x420902729A92C964 - https://denix.org/0x420902729A92C964
> > Fingerprint: 25FC E4A5 8A72 2F69 1186  6D76 4209 0272 9A92 C964
>
> 
>
