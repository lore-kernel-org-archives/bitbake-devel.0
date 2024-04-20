Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D41C4345F
	for <webhook@archiver.kernel.org>; Sat, 20 Apr 2024 20:35:49 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.19926.1713645347398224674
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Apr 2024 13:35:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Nw+72Lel;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51aff651083so280165e87.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 20 Apr 2024 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713645345; x=1714250145; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eChbVNdOXpn3xn7fXedsy0uw9XAoSgFamuBJZFfRRgI=;
        b=Nw+72LelBOu5q+mSGbWKBzmGgL80LG8szf5bd5jqfGddNDUYlg75gybHlf1z/29cD+
         XpxE8J6TuoV+8xsXD0AqL1Byrevus/BkhA4OQnAsCiWJpHV4VRvAHI+AAl75Ga5599c0
         MdL9lT0QhKUiwgugA7NrwU9rkJayLU9cfOpMdjwEEf31wdLRiOIJvYQuO/tM13huuuSz
         te9ahg+zwj03arLXCziZsuZdBAAtYPs6gBGO8NafH19YllkRKEOs1tdFCMnGb4dTELFZ
         fH3DARbyTpI60KhaBrcw7vWe2MmQNhJNjqDqDnCDarwPOKQTVTRFxxE6ChJdzAZI0pYc
         27yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713645345; x=1714250145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eChbVNdOXpn3xn7fXedsy0uw9XAoSgFamuBJZFfRRgI=;
        b=kEFunrM6G0jt0Fzyl1dZHIznk7L1D3mSwaaTeQeV5W6f9lUdCPDpwN6Ekq5wixe0TM
         eoHp2+aBmoDT1Z4UTaaVSg8Fn9N/DAGcH+hrYHLZS8WM00m7tBAHfeAczM9YagMG0F1w
         x9A/M618+0lkgD5i7ilx4i6eqXPYfklVAcfaNz6mJIxSkBgtenJAjmpsuOc5n5LAky8j
         58kWiEe2VFGTs4E7hZ5GayxyP8r2UdTImOjf0Kqv6t1ZBHVmWXpXjsDWC4rb2gzoIeHe
         ZUIe6Qj2QjBF50D/JcBgPxNyRiJREvULQxvYCJMt0vNYxOvZMVynuKryDkyopQFwFzLO
         b+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWURxzcS0zxueXVBqC7GrtQJdzi4TUeCJ/0S/NgI/g88fvjJvrM9T4ouzY+E7TO+pwF8nKDyNlcYhJGiqd/sDaOaHyoJd/FQ2s+KB/feLhP0dzYTsc=
X-Gm-Message-State: AOJu0Yzozsn0bq1pPd/6evBR2drpvj06939D+eokAqrwsO2k42Mj4xND
	OrUPBcxgkj+ZyxGJm1DGKFn1TCsxr9Fv7v8XLKZVikt6MftWrZ+W0Oze+R3YhMiYE26xwe4kRHq
	d5fninUi1b1G2DIWcMlKkc5WpwjE=
X-Google-Smtp-Source: AGHT+IG0uvmMDSuTXpDFE8NTwa5QOjRYTKVJMxWghVQ+V9/DM3uISnihggPCaJdFW0cJKwmB7uzwFg4vacCGj6p8ViI=
X-Received: by 2002:a05:6512:781:b0:519:63c1:6f2b with SMTP id
 x1-20020a056512078100b0051963c16f2bmr3148470lfr.54.1713645345126; Sat, 20 Apr
 2024 13:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <d85e68b3-18ec-428e-b17a-b012bc9e2c75@bootlin.com>
 <04d7efd9d4de05d1c3971a733187887708930d7f.camel@linuxfoundation.org> <7ca8f12c-fd13-4e60-ab4e-7016e2f9a683@bootlin.com>
In-Reply-To: <7ca8f12c-fd13-4e60-ab4e-7016e2f9a683@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Sat, 20 Apr 2024 15:35:33 -0500
Message-ID: <CAJdd5GZYDtvvhkKKD4jukbWDatiWPXxQTwsjh+6HcFji+wNCHg@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-selftest losing sqlite3 database contents!
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	BitBake developer list <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 20 Apr 2024 20:35:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16116

On Fri, Apr 19, 2024 at 4:13=E2=80=AFAM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Hi Richard,
>
> On 4/18/24 at 23:04, Richard Purdie wrote:
> > On Thu, 2024-04-18 at 21:42 +0200, Michael Opdenacker via lists.openemb=
edded.org wrote:
> >> I'm currently implementing bitbake-selftests for the PR server. I've g=
ot
> >> my first series of tests working, inserting several values into the
> >> database and then making queries to check that the stored values are
> >> correct.
> >>
> >> However, for the second series of tests, I want to start from the
> >> sqlite3 database file from the first series (prtest-basic.sqlite3), an=
d
> >> this time use it to start the server in read-only mode. However, the
> >> table is empty when I open it!
> >>
> >> This is confirmed by making an SQL query from the command line:
> >> $ sqlite3 prtest-basic.sqlite3
> >> SQLite version 3.37.2 2022-01-06 13:25:41
> >> Enter ".help" for usage hints.
> >> sqlite> select * from PRMAIN;
> >> sqlite>
> >>
> >> What could explain that the stored PR data are not flushed to the
> >> database file during my tests, but I have no such issue when I make an
> >> image with BitBake?
> >>
> >> I also changed the prserv/db.py file to run:
> >> self.connection.execute("PRAGMA synchronous =3D NORMAL;")
> >> self.connection.execute("PRAGMA journal_mode =3D WAL;")
> >>
> >> However, that didn't help.
> >> Any clues for debugging this?
> > Most selftests are designed to run in isolation. There is no "run X
> > after Y" mechanism since you can specify a single test to run. You may
> > need to merge the tests if you need the same database.
>
> Thanks for your help.
>
> Ouch, I'm trying but that looks complicated in my case:
>
>   * It seems I can't open the same database before the end of the test
>     with another, read-only server. Anyway, databases are not meant to
>     be shared between servers.
>   * It's not straightforward  to make a copy of the current database to
>     another file. It would be necessary to add a special server and
>     database hook for this purpose.
>   * I could export the current database, but I wouldn't be able to
>     import it into a read-only server.
>   * I can't make the current server  turn read-only. I could add a
>     client hook to do this, but do we want to allow clients to do this?
>   * I want to generate the database I use for the read-only tests,
>     because a ready-made one would have to be updated manually every
>     time we modify the database contents.

I'm not exactly sure what the purpose of the read-only prserv is in
the first place; based on these requirements, it sort of sounds like
there isn't anyway to make a read-only server that has actual data in
it :)

Ostensibly, you should be able to write a test fixture that does
whatever a real-life PR server installation would do to populate a
database and then make it read-only. You would then do this process on
the test database before each test where you needed to test the read
only functionality. You have to do it for each test because as you
noticed, you should not ever have "carry-over" in state from one test
to another. Having carry-over between tests is not a good idea for a
lot of reasons, which is why the hash server tests are setup the way
that they are with an empty database for each test.

If you need help figuring out how to do this I'm more than happy to
talk though how you might do it.

>
> That's why it would have been ideal to reuse a database from previous tes=
ts.
>
> Anyway, I'm not stuck and can implement the "upstream" tests anyway.
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

