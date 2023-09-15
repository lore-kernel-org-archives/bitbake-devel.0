Return-Path: <rustyhowell@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944B2EE0205
	for <webhook@archiver.kernel.org>; Fri, 15 Sep 2023 02:05:57 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web10.12102.1694743550238912903
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Sep 2023 19:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BURsa9XG;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: rustyhowell@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so25462571fa.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 19:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694743548; x=1695348348; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMUvLnWe/ueqmKejpnz6Tait+V86jyw/kBcQm90HGG0=;
        b=BURsa9XGMLEjkCd60iTpNp7vODpItbza3LLVzy63oXSxdrGkoaABZq+E65CWWUQDGB
         Ivlvizto2HFYPBTDXk2IIjOPo50EiVJgqqovImV1xUB1t9IcDvk/3rDpvvWpUzaQw/zu
         nB/K06As2s6bRGCZ3RXGaYtDs5Q1S/3jwEEUD2Bh1x3lVgbnDkcvdRf3ftC498wwMQPg
         WyDMxxK89KMmzkNaVRBausvNYQ6msDeRgpXf8ww1ZA0L2YEZZqSmhIKvjYAWCw9dMa+A
         YmPtPQ/KHRKqj0gi9p8l7216EkBNdJaH4m8xI4I325m2M+mWRG7KEbj4k/YvuwAsHQXt
         /wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694743548; x=1695348348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMUvLnWe/ueqmKejpnz6Tait+V86jyw/kBcQm90HGG0=;
        b=vCTEBbEg1avO/M/G8tEjm5zTKj+NHk1je5N6jbuaVe18PVj3xvpOjuFG8jZRGXASmr
         tNJFqybfvI1qI6WMf4Nx7pG7KFdw9Km6jep0ijWSmqESORtATfq4gND4zvvn8K2reoFz
         /eho0ZHetOmAvClIAujar/EgIH5MBMUJVlxWvBzpv19N0JtQ0R3aQ5o39uhW+Qm9V1/b
         dhw3e8TJmUbLNrrIc3pQKzmZP6MrGD+J/+MdUaPZ37pmU1FKJqHjhiZnMqZ4JTS6QL7O
         TdyejeCGz6hbkGKP68as5aH63iXk7czOISBXBpJT+aC8bjJr5Z9mwskEWvTolBIgWqKY
         Qg4w==
X-Gm-Message-State: AOJu0YyWuNcxpMQHuS1DsyhlaZ+zyNnTBTj25C7EtqyAAA9IzZOQ5DK8
	NN+5++ftqhBT+9hPUbmDMTKccNeBxsezAYCZU1E=
X-Google-Smtp-Source: AGHT+IFBtSuheAg91QIN4yjMhsX9KMtSiv3Vyp4z8sqY9Bf7gzEYwZS3iYLqrm2c617fkZnAYyPTIuzqiB0//R5V8ZI=
X-Received: by 2002:a2e:918a:0:b0:2b6:fa3f:9230 with SMTP id
 f10-20020a2e918a000000b002b6fa3f9230mr387877ljg.46.1694743547798; Thu, 14 Sep
 2023 19:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230913050824.13599-1-rustyhowell@gmail.com> <CANPvuRnb4XRK4A=YDXdS5cXjsNxPj_k1S4acfzFYHsKtUSs-Lw@mail.gmail.com>
 <1784CA099B7C177E.28514@lists.openembedded.org> <c5e1e8071e10f795996eef5efdc03d3a674e1863.camel@linuxfoundation.org>
In-Reply-To: <c5e1e8071e10f795996eef5efdc03d3a674e1863.camel@linuxfoundation.org>
From: Rusty Howell <rustyhowell@gmail.com>
Date: Thu, 14 Sep 2023 20:05:31 -0600
Message-ID: <CAE+BM3myUg93MVuKqOzO6UCqshxVWnxCAutBV_nEW9c9NLZqLw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] prserver: add self-tests
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Jose Quaresma <quaresma.jose@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Sep 2023 02:05:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15064

There was an article by WindRiver that pointed out that the database
is only written to disk when you stop the prserver.
https://docs.windriver.com/bundle/Wind_River_Linux_Toolchain_and_Build_Syst=
em_Users_Guide_LTS_1/page/use1553887504762.html
What is happening is that as soon as the prserver is started, an
exclusive transaction is started. That transaction is held open during
all the queries. If the queries are just SELECT statements, it doesn't
affect the currently held open transaction. But any time a new row is
inserted into the table, the transaction is committed and another
exclusive transaction is started immediately.  In summary, there is
always an open Exclusive transaction active.   This exclusivity
prevents other connections to the database, like in the scenario where
you want to dump the database for backup purposes.

rhowell@sirius:~$ sqlite3 ~/pr.db .dump
PRAGMA foreign_keys=3DOFF;
BEGIN TRANSACTION;
/**** ERROR: (5) database is locked *****/

The change to remove the "BEGIN EXCLUSIVE TRANSACTION" command is
alleviates that. Always having an exclusive transaction is not
necessary.  If a row is inserted into the table, the changes are
committed immediately (written to disk), but there is no need to
exclude other connections to the database.
That's why the unit tests wont work without this change, because the
unit tests open a second connection to the database to check the rows
in the table directly.

Hope this helps. I should have added this explanation to the commit
message. My apologies. I can amend the commit and resubmit.
Rusty

On Thu, Sep 14, 2023 at 8:30=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2023-09-14 at 15:24 +0100, Richard Purdie via
> lists.openembedded.org wrote:
> > On Thu, 2023-09-14 at 09:51 +0100, Jose Quaresma wrote:
> > >
> > >
> > > Rusty Howell <rustyhowell@gmail.com> escreveu no dia quarta,
> > > 13/09/2023 =C3=A0(s) 06:09:
> > > > Add some self tests for the prserver. As changes are made to the
> > > > prserver, the tests will
> > > > help ensure that any behavioral changes are known, or that changes
> > > > do not affect behavior.
> > > >
> > > > Signed-off-by: Rusty Howell <rustyhowell@gmail.com>
> > > > ---
> > > >  .gitignore                           |   1 +
> > > >  bitbake/bin/bitbake-selftest         |   5 +-
> > > >  bitbake/lib/prserv/db.py             |   2 +-
> > > >  bitbake/lib/prserv/tests/.gitignore  |   2 +
> > > >  bitbake/lib/prserv/tests/__init__.py |   0
> > > >  bitbake/lib/prserv/tests/prserver.py | 213
> > > > +++++++++++++++++++++++++++
> > > >  6 files changed, 221 insertions(+), 2 deletions(-)
> > > >  create mode 100644 bitbake/lib/prserv/tests/.gitignore
> > > >  create mode 100644 bitbake/lib/prserv/tests/__init__.py
> > > >  create mode 100644 bitbake/lib/prserv/tests/prserver.py
> > > >
> > > > diff --git a/.gitignore b/.gitignore
> > > > index 8f48d452da..c227363e3c 100644
> > > > --- a/.gitignore
> > > > +++ b/.gitignore
> > > > @@ -36,3 +36,4 @@ _toaster_clones/
> > > >  downloads/
> > > >  sstate-cache/
> > > >  toaster.sqlite
> > > > +.idea
> > > > diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-
> > > > selftest
> > > > index f25f23b1ae..8b601aa2b8 100755
> > > > --- a/bitbake/bin/bitbake-selftest
> > > > +++ b/bitbake/bin/bitbake-selftest
> > > > @@ -16,6 +16,7 @@ try:
> > > >      import bb
> > > >      import hashserv
> > > >      import layerindexlib
> > > > +    import prserv
> > > >  except RuntimeError as exc:
> > > >      sys.exit(str(exc))
> > > >
> > > > @@ -35,7 +36,9 @@ tests =3D ["bb.tests.codeparser",
> > > >           "hashserv.tests",
> > > >           "layerindexlib.tests.layerindexobj",
> > > >           "layerindexlib.tests.restapi",
> > > > -         "layerindexlib.tests.cooker"]
> > > > +         "layerindexlib.tests.cooker",
> > > > +         "prserv.tests.prserver",
> > > > +        ]
> > > >
> > > >  for t in tests:
> > > >      t =3D '.'.join(t.split('.')[:3])
> > > > diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
> > > > index b4bda7078c..8cefb28f16 100644
> > > > --- a/bitbake/lib/prserv/db.py
> > > > +++ b/bitbake/lib/prserv/db.py
> > > > @@ -71,7 +71,7 @@ class PRTable(object):
> > > >      def sync(self):
> > > >          if not self.read_only:
> > > >              self.conn.commit()
> > > > -            self._execute("BEGIN EXCLUSIVE TRANSACTION")
> > > > +            #self._execute("BEGIN EXCLUSIVE TRANSACTION")
> > > >
> > >
> > >
> > > Is this change intentional? imo they should be on another commit
> > > since it doesn't seem related.
> >
> > I was wondering that too, it certainly needs explaining if it should be
> > there...
>
> It does look like the tests only pass with that change. I also noticed
> a .idea file being added to gitignore which looked a little
> questionable.
>
> Cheers,
>
> Richard

