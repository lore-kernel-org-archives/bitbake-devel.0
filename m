Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4E2C4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 13:56:10 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web10.16220.1714485364249714605
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 06:56:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D0fJ8kOD;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso91439671fa.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714485362; x=1715090162; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKuYn6DjogbANQRiFwtidlL6VXUfuAg5BlFqw0nY0A8=;
        b=D0fJ8kODtsBjMt4FK1aO+Q3+8Pjdm4mqzW0754iE5OggYYli/m3Icueg6KzgCGxx6s
         WYur9zBiD8+DffknQhiLc95XZeCuv+JCYbe5tUwRjT5AF3tkv815YNfPx4JoEpc9c6hW
         0t6+OTdvW0CWAPsnOj3pMbwKx5j50HlJ9bo9f+z19D8nT27tfSiCX1jbAS/UsX+2XdbH
         HS5jNcu0WVeHOFxvhWqXyQokBQZpwCioBopzWtga+zITwl82qvNmVD2rBWrj+OqwUaXA
         1zYfF2WQnB4kySj7a+bzm9PGrHvF5x4uj+yXd0nyuV812Zs9AZWhPFASTuyq5Hp6JbaL
         h+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485362; x=1715090162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKuYn6DjogbANQRiFwtidlL6VXUfuAg5BlFqw0nY0A8=;
        b=k1hGnBNc7Qg0PCtdXvMTiRjk9ATrJh+XTbV9Sgb+qqT4lPqdYLr+bDnaxcLru+USG7
         S5CXxYjo/bXwlGX7v99Df/Nht9VIUhJjaIgN9m0lvsY2BEeT25aMUuEPa4IaaKq/KzBl
         RLfzQ1attThzAGtk4hl75XaH94U+QGe1uJ6cjxBDlXvuRHfjf2zmoa+DOQbB7yU33f0I
         qREdcaT0mwgpbh5P1YtOEiDGNmqop5w/5JcpI50tqWlo0l3cE6hL+0Vv3u4z3K/KQO/t
         WBDwSZ59PzCT/a24LFA5Wb76WJlcVDI3+P57Y6fCh3ZnPJSFbsiq9ML7W5RNqp+8JsO4
         IEgw==
X-Gm-Message-State: AOJu0YyFGgbV1BgYkCFllGkeYCvEDBYXB1qPzcAXZhtb4zdgVE4lSPzb
	qS7j/yfB+ROUWvy+ZYvfWQVtXumC/Z2XO/Zccm0c+x/jznWn7aaS9gbbg0fy3SYz9jhAoigFv5X
	9y25tP9S3mIrcPg2EBN0qMXQGESU=
X-Google-Smtp-Source: AGHT+IEEoMyZ+Iic1NkOp2Ch5e7F1GGCsuhwBmUc/37c7QV+mvk5oTXxxy39P7sPrxlzw3CqCWfgMturyyirLHJP7tQ=
X-Received: by 2002:a2e:b0e9:0:b0:2e0:17c6:6256 with SMTP id
 h9-20020a2eb0e9000000b002e017c66256mr6365571ljl.45.1714485362022; Tue, 30 Apr
 2024 06:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-5-michael.opdenacker@bootlin.com> <CAJdd5GbeJL=Z4-YHYm8eab0x3JD3yynoBE+S0LsuP_E3cCYQPA@mail.gmail.com>
 <56222882-76c9-44ab-9a20-237a1293489b@bootlin.com> <CAJdd5GbR_LDbCX8aBzFkjrTj0GU55zJYWnQ07dJ1cC2wObz5BA@mail.gmail.com>
In-Reply-To: <CAJdd5GbR_LDbCX8aBzFkjrTj0GU55zJYWnQ07dJ1cC2wObz5BA@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 30 Apr 2024 07:55:49 -0600
Message-ID: <CAJdd5GZewzCZJFbVeASOMqQRKJRG51RcnBn1+A41_3pwn8_FtA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] prserv: enable database sharing
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, Tim Orling <ticotimo@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 13:56:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16163

On Tue, Apr 30, 2024 at 7:23=E2=80=AFAM Joshua Watt <jpewhacker@gmail.com> =
wrote:
>
> On Tue, Apr 30, 2024 at 6:58=E2=80=AFAM Michael Opdenacker
> <michael.opdenacker@bootlin.com> wrote:
> >
> > Hi Joshua
> >
> > Many thanks for the review and guidance. See my comments and questions
> > below.
> >
> > On 4/29/24 at 22:34, Joshua Watt wrote:
> > >> +        with closing(self.conn.cursor()) as cursor:
> > >> +            if self.read_only:
> > >> +                table_exists =3D cursor.execute(
> > >> +                            "SELECT count(*) FROM sqlite_master \
> > >> +                            WHERE type=3D'table' AND name=3D'%s'" %=
 (self.table))
> > >> +                if not table_exists:
> > >> +                    raise prserv.NotFoundError
> > > This is a race if you run the read-only server first, which seems lik=
e
> > > a bad user experience. I'd probably create the table even if the
> > > server is read-only (I'm pretty sure hash server works this way also)
> >
> >
> > Fixed. Thanks.
> >
> > >
> > >> +            row =3D data.fetchone()
> > >> +            if row is not None:
> > >> +                val=3Drow[0]
> > >> +            else:
> > >> +                #no value found, try to insert
> > >> +                try:
> > >> +                    cursor.execute("INSERT INTO %s VALUES (?, ?, ?,=
 ?);"  % (self.table),
> > >> +                               (version, pkgarch, checksum, value))
> > >> +                except sqlite3.IntegrityError as exc:
> > >> +                    logger.error(str(exc))
> > > You probably want to make this whole SELECT / INSERT block a loop, an=
d
> > > instead of repeating the SELECT below, retry the loop on an integrity
> > > error. The only reason you should be getting an integrity error is if
> > > you have a race between multiple servers accessing the database at
> > > once. In that case, looping back and trying to fall out in the
> > > previous SELECT is better.
> > >
> > > This is especially important if you delete entries in the database, a=
s
> > > in pathological cases you might have to loop several times before you
> > > fall out of the loop (although typically, you would only need to retr=
y
> > > once).
> > >
> > > I'd recommend this paradigm any other places you do SELECT / INSERT
> > > where the INSERT depends on the SELECT.
> >
> > This is actually coming from the prserv legacy code, which I haven't
> > really touched yet.
> >
> > Is this kind of event really expected to happen with sqlite3? I see tha=
t
> > hashserve only checks for "sqlite3.IntegrityError" once, so maybe it's
> > too pessimistic to anticipate errors here... Do we also want to support
> > multiple builders accessing the same PR database?
>
> The hash server API and databases are designed to avoid a SELECT /
> INSERT dependency. If you look, the APIs are either just reading with
> SELECT, or doing an INSERT that ignores if the entry already exists.
> After the INSERT, it sometimes does a SELECT to try and read back the
> inserted data, but this is fine as long as it correctly handles the
> case where it might not get back the data that was just inserted (if
> it's racing with a delete), which it does correctly. (e.g. INSERT ->
> SELECT is fine, SELECT -> INSERT requires a retry).

Sorry, also forgot to mention: if your use case is _just_ a read-write
server and a read-only server, then you are correct, you do not need
to worry about retries. I think that's your only use case for this
work, so the above statements are just for posterity, as I suspect we
will be doing more work on the PR server after you finish the current
work :)

>
> >
> > Anyway, if I really have to do it, I guess I'd also have to do it in th=
e
> > store_value() function which currently just logs an error without
> > retrying. But if we loop, doesn't it add the risk to create an endless
> > loop?
>
> Sans bugs, no. In order to loop again, the database state must change
> between the SELECT and INSERT statements (remember, a cursor is not a
> read-lock on the database). As such, some other server sharing the
> database *must* have made progress and successfully done an INSERT, so
> holistically, the entire system (all servers) have made progress and
> it's not an endless loop.
>
>
> >
> > Cheers,
> > Michael.
> >
> > --
> >
> > Michael Opdenacker, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> >

