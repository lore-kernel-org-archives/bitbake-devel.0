Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF6C4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 13:24:00 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web10.15418.1714483436770923022
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 06:23:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SaW2mFgn;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso90807331fa.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714483435; x=1715088235; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDrPKWB4qIOFhchgMqESA+EHqgH2K5gCsfmRMzGEmaA=;
        b=SaW2mFgn4Ny+Bzt+NWDaYAkVHFik4b1yPJKiMgycbJGuPKYFiw7jVKGy1OPdOgQadd
         cLYyIN5RCCY0Tsbh6I4Wv92/DwMWvFLLtsP6SItqLB1TbjJyZokOncSwaaBPWlbmZqL2
         +ITsdKVKtkoytotmOBe0bhe1Wgo6L69ARf2I4F0DCFO2JTwQTR/lvYndKQm48I6tcTyP
         5dlL4yYxTVM/CDwyB1Sp2AiZhp/KMH03mJoPjTNJfZA/XcH/NUHIwtZNAh4glmXxxtDT
         mVOKMN8SSlvMTYQMTDYUQP54ilwofOZZRWgLGypgNvkVf4O5Lnk9yNP9j5TAQKgS8b++
         zTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714483435; x=1715088235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDrPKWB4qIOFhchgMqESA+EHqgH2K5gCsfmRMzGEmaA=;
        b=RFWu660sWS1ttWPgpRgP7gzA46TLCf79dOEisYCBSAsQXtZldkWBFml5MzwBk899ME
         MmmxQwUjv6Bp9xBibzyTFI74q6x6xjMZmI3pW8c1RlUCibC1HJ4r50720fr77t2FvMF1
         gJueWqy5Xz+Y7OOWkTGx1Gcr/U9gw5hmdEb80zb5xUIN6oRHS6NLqmMWlcD4ioQgEDpP
         Ml2feWc4PYXv2MsrL0/5kYROlr5m4kJ36txVeXmIFzBWWkrtCao5YsXwAwrf19YXAVTL
         aDerKJdbTjtG1a5UCb3sMtffpBZF39e6kf0YSjRaB9OEvm7qm7NI0jw7cqglH5wnfpuo
         zlNg==
X-Gm-Message-State: AOJu0YwgGwQww2GBoiHVtSBWW8TwNk+5PJsxZV8wM5WY2k5UvNBcAaRH
	MPAmsEB28n5JqVSru0SV5Y2WV13lUT+1miMUKmwJeAngWg7D54IFOd/JVWMkwyWdtCpS5KdIAic
	9msL5EUWCYYMeTAhioi4FZDfxL9E=
X-Google-Smtp-Source: AGHT+IEKa84Gk9Kb0AGybTakbpkky9gFsSwzSZiOi3lupsy/H1eHjDlpWHvQw3sfc9TIibxy8Ed49MW/snrsgdU679Q=
X-Received: by 2002:a05:651c:20f:b0:2e0:5f2c:e0b5 with SMTP id
 y15-20020a05651c020f00b002e05f2ce0b5mr5571337ljn.36.1714483434637; Tue, 30
 Apr 2024 06:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-5-michael.opdenacker@bootlin.com> <CAJdd5GbeJL=Z4-YHYm8eab0x3JD3yynoBE+S0LsuP_E3cCYQPA@mail.gmail.com>
 <56222882-76c9-44ab-9a20-237a1293489b@bootlin.com>
In-Reply-To: <56222882-76c9-44ab-9a20-237a1293489b@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 30 Apr 2024 07:23:42 -0600
Message-ID: <CAJdd5GbR_LDbCX8aBzFkjrTj0GU55zJYWnQ07dJ1cC2wObz5BA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] prserv: enable database sharing
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, Tim Orling <ticotimo@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 13:24:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16162

On Tue, Apr 30, 2024 at 6:58=E2=80=AFAM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Hi Joshua
>
> Many thanks for the review and guidance. See my comments and questions
> below.
>
> On 4/29/24 at 22:34, Joshua Watt wrote:
> >> +        with closing(self.conn.cursor()) as cursor:
> >> +            if self.read_only:
> >> +                table_exists =3D cursor.execute(
> >> +                            "SELECT count(*) FROM sqlite_master \
> >> +                            WHERE type=3D'table' AND name=3D'%s'" % (=
self.table))
> >> +                if not table_exists:
> >> +                    raise prserv.NotFoundError
> > This is a race if you run the read-only server first, which seems like
> > a bad user experience. I'd probably create the table even if the
> > server is read-only (I'm pretty sure hash server works this way also)
>
>
> Fixed. Thanks.
>
> >
> >> +            row =3D data.fetchone()
> >> +            if row is not None:
> >> +                val=3Drow[0]
> >> +            else:
> >> +                #no value found, try to insert
> >> +                try:
> >> +                    cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?=
);"  % (self.table),
> >> +                               (version, pkgarch, checksum, value))
> >> +                except sqlite3.IntegrityError as exc:
> >> +                    logger.error(str(exc))
> > You probably want to make this whole SELECT / INSERT block a loop, and
> > instead of repeating the SELECT below, retry the loop on an integrity
> > error. The only reason you should be getting an integrity error is if
> > you have a race between multiple servers accessing the database at
> > once. In that case, looping back and trying to fall out in the
> > previous SELECT is better.
> >
> > This is especially important if you delete entries in the database, as
> > in pathological cases you might have to loop several times before you
> > fall out of the loop (although typically, you would only need to retry
> > once).
> >
> > I'd recommend this paradigm any other places you do SELECT / INSERT
> > where the INSERT depends on the SELECT.
>
> This is actually coming from the prserv legacy code, which I haven't
> really touched yet.
>
> Is this kind of event really expected to happen with sqlite3? I see that
> hashserve only checks for "sqlite3.IntegrityError" once, so maybe it's
> too pessimistic to anticipate errors here... Do we also want to support
> multiple builders accessing the same PR database?

The hash server API and databases are designed to avoid a SELECT /
INSERT dependency. If you look, the APIs are either just reading with
SELECT, or doing an INSERT that ignores if the entry already exists.
After the INSERT, it sometimes does a SELECT to try and read back the
inserted data, but this is fine as long as it correctly handles the
case where it might not get back the data that was just inserted (if
it's racing with a delete), which it does correctly. (e.g. INSERT ->
SELECT is fine, SELECT -> INSERT requires a retry).

>
> Anyway, if I really have to do it, I guess I'd also have to do it in the
> store_value() function which currently just logs an error without
> retrying. But if we loop, doesn't it add the risk to create an endless
> loop?

Sans bugs, no. In order to loop again, the database state must change
between the SELECT and INSERT statements (remember, a cursor is not a
read-lock on the database). As such, some other server sharing the
database *must* have made progress and successfully done an INSERT, so
holistically, the entire system (all servers) have made progress and
it's not an endless loop.


>
> Cheers,
> Michael.
>
> --
>
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

