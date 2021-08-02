Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.2029.1627945124685053090
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Aug 2021 15:58:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=vP/u3gkt;
 spf=softfail (domain: sakoman.com, ip: 209.85.221.45, mailfrom: steve@sakoman.com)
Received: by mail-wr1-f45.google.com with SMTP id z4so23241270wrv.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Aug 2021 15:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXGjFiw7fvNvZHI2ckLkCdWFn90jsy+WZlfdAGCwmP8=;
        b=vP/u3gkt6C29je39Snezj9F2tdXbklSvKeS7YA5Z+EV4Fz//+zDlgfz9kAzdt7EEq4
         J4aOrnF4rqeBHd1BKVeNV/P6jd9Zyjd4tA1C7mMv/vy3HFbyHmH0uo3uH+7F4dfDY/D5
         tMJpnTudtHfSWRoj6pYFypVieOw4bHqUusqd08Y7mpXSZnelSuxWuH0Bk9X/QFshaMpX
         HT3QQD/gC+YJEYP9UGKIXZzmJoVrLop/MqaUDaKPOjVdKTdry5Nhxf7Tk6jDKfbgx7b5
         LXAfN8q+VwbLTU5K/AJ88ByzjVflVhtLb9OjIjaB9Uaj0Osaye9RYvVG06XKAsrhgEu6
         tQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXGjFiw7fvNvZHI2ckLkCdWFn90jsy+WZlfdAGCwmP8=;
        b=fpb1hCGM1t/Owf0/tweIZH1+0GTafsse2HukNljAhBj29a7nl1EtHXgJ+zz+O3Hvd/
         8DTGCKaOgktHGM50pJ47eXbMjIgv9rbS/t3rnnmZi5v4h3tzYfLwHOnqIhgbynE8uPue
         AV7jxwBHomGwumanubb3C7NDsjJrnngojUdF/iF2kYaLVuz3Gz1w6bIL8qpkNOl+EVNo
         TE43XJ3wohQIRQXeDoRK4sBEEveSM3AIfOrzoMfMsRIMPASmj7vVzFGZrCjTICANGV5n
         VEU5hmx0RMyNI4/z1dt0FSASuSycMYLg/jSYwnecnJOtvkBYz1hadGrGASpyWLifa4ms
         UFBw==
X-Gm-Message-State: AOAM531kqO2A63+6u/tOK+JFfXZC6YdZDENAz5x5yMyE4gQJvG7lfrHn
	4k5cVOiYMPosw72smJPrgO+0ig+zZ3figGPxdmE2kA==
X-Google-Smtp-Source: ABdhPJxtH6SCyZL9o7TjXovmSdpxOp5d2Yc9fYfll/jVfbGsWyuZ1ARa0ttd9hTZsU4UKNh+YltoAdS/sWe1Y7d6j0I=
X-Received: by 2002:a5d:518a:: with SMTP id k10mr19872076wrv.400.1627945122779;
 Mon, 02 Aug 2021 15:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <168F5A432E4959C7.26257@lists.openembedded.org> <20210802194545.GM1528@denix.org>
In-Reply-To: <20210802194545.GM1528@denix.org>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Mon, 2 Aug 2021 12:58:30 -1000
Message-ID: <CAOSpxdaCTkHso7eCByhqBFwZ_i4PbzWUNd6et33efujwVnSC4w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH][1.46/1.48] providers: replace newly added logger.warn() with logger.warning()
To: Denys Dmytriyenko <denis@denix.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 2, 2021 at 9:45 AM Denys Dmytriyenko <denis@denix.org> wrote:
>
> Ping.

Hmmm . . . I thought I had grabbed this, but clearly not!

I'm on it!

Steve

>
> On Tue, Jul 06, 2021 at 08:20:27PM -0400, Denys Dmytriyenko wrote:
> > Commit https://git.openembedded.org/bitbake/commit/?id=78cd63285713fde59506eb2e71a7b7ee59a594ff
> > converted logger.info() to logger.warn(), which is deprecated and instead
> > should use logger.warning():
> >
> > https://lists.openembedded.org/g/bitbake-devel/topic/82742194#12377
> >
> > Signed-off-by: Denys Dmytriyenko <denis@denix.org>
> > ---
> >  lib/bb/providers.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/bb/providers.py b/lib/bb/providers.py
> > index 3f66a3d..484e1ea 100644
> > --- a/lib/bb/providers.py
> > +++ b/lib/bb/providers.py
> > @@ -151,7 +151,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
> >          if item:
> >              itemstr = " (for item %s)" % item
> >          if preferred_file is None:
> > -            logger.warn("preferred version %s of %s not available%s", pv_str, pn, itemstr)
> > +            logger.warning("preferred version %s of %s not available%s", pv_str, pn, itemstr)
> >              available_vers = []
> >              for file_set in pkg_pn:
> >                  for f in file_set:
> > @@ -163,7 +163,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
> >                          available_vers.append(ver_str)
> >              if available_vers:
> >                  available_vers.sort()
> > -                logger.warn("versions of %s available: %s", pn, ' '.join(available_vers))
> > +                logger.warning("versions of %s available: %s", pn, ' '.join(available_vers))
> >          else:
> >              logger.debug(1, "selecting %s as PREFERRED_VERSION %s of package %s%s", preferred_file, pv_str, pn, itemstr)
> >
> > --
> > 2.7.4
> >
>
> --
> Regards,
> Denys Dmytriyenko <denis@denix.org>
> PGP: 0x420902729A92C964 - https://denix.org/0x420902729A92C964
> Fingerprint: 25FC E4A5 8A72 2F69 1186  6D76 4209 0272 9A92 C964
