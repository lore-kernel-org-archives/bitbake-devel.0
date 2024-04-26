Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44907C4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 17:56:08 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.2615.1714154165389041593
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Apr 2024 10:56:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DHJRGJ1X;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so31286451fa.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714154163; x=1714758963; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtVeRfFlHUzi8lxxKlp3VNYuQUKnjQFfzngTEhECcgI=;
        b=DHJRGJ1XarhEfF33G857TZXq0+hkWVpA924ADyuL9XQHXGz44WskfvPL81/E/yGLVK
         gBq3ReOOg8PtUTFD16ilCIC1lJlUwkSNHkuyOujygFV5hn4cgyq1hCTtrq4v+4Cy+nF0
         r1RQ1ppx+aZmSdZvshcALuxwYeXiWarp5mIB+elzNUB6QaQQRFXH7RXM1xS3UoDPPDQ2
         rhHrJ3dW0a0074Xrdp/XHEz0i6E7LdjgP8/TYIxmLZ021I/ssUxDYIdpotgWPpeiOxQW
         LJ9+HgT8yzt2BYykrhyOCY9cBTVpf7/cdVoQ1kalr3B62dzqXzX2aQLA+uSNzsIlo7M4
         +31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154163; x=1714758963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtVeRfFlHUzi8lxxKlp3VNYuQUKnjQFfzngTEhECcgI=;
        b=ItLqZ4yr8rZ75/MM5LImmdD6rZNclQb5v+JudqZDw7BOBZhZkri1IbcHQxcJ+SwhaK
         u25RHHgnoTEA98z+uM3Mfzek+yOLmSdymoAaT8rbuczIE/JZxG3F50VvKkUtmGKFkFOo
         GvlUioUGuPII0BZsmX40SXLqh5g8ZH4H5pN+PAgso6Y3c1ovH2DcFfUKF2GMQVm87ye+
         rSkOUZjE2OqRwzw/eWUe6HYhNlSVwrWSp9jRheKUv+qz9sgGVwBlMWsyaae3fTaoXsq+
         vka5+UR+BHr4klxOG3iuE6FSqmaRXpe/jV5NRyJ34/LYexeTab6wJ9Xxh/rZzHYruFp3
         Jk8g==
X-Gm-Message-State: AOJu0YwOill0X5dGaQZhjV6cQhvaGMxWRp58zsahM9yoUV7g3Ir5WRpe
	1pzeK5JuTNTa+N9cy7tDTqCGg77uMRmjjV5BgszeprceX2O+ocvOOD1uKSYWLX2qfqSc9P2I/Qi
	WvNY/v7RLBFVfKWRiic3I6GCYoaLJfA==
X-Google-Smtp-Source: AGHT+IH/rso7PLPg2vPoU5bRdffcJHsgvirbG+bf2rZXcSNaiVMb/Iy4+GbXCp0SIbYqG2UF1Cc8vqnrE1sibBkI6B4=
X-Received: by 2002:a2e:9c0b:0:b0:2da:802b:2154 with SMTP id
 s11-20020a2e9c0b000000b002da802b2154mr354092lji.16.1714154163210; Fri, 26 Apr
 2024 10:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240423182543.226113-1-JPEWhacker@gmail.com> <20240423182729.226345-1-JPEWhacker@gmail.com>
 <17C929449F85DB18.1247@lists.openembedded.org> <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
 <CAJdd5GbB5xFBq6sC7kEP0YferegyXQYai9Mo-1jAkxe9wxSG7A@mail.gmail.com> <95b0d470-02b7-437d-b9bf-210d3b988f94@bootlin.com>
In-Reply-To: <95b0d470-02b7-437d-b9bf-210d3b988f94@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 26 Apr 2024 11:55:51 -0600
Message-ID: <CAJdd5GZRt8NXpVhh14-Fnpp4ixfj0XcEZUFjoeg0nqheOpkGYg@mail.gmail.com>
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 17:56:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16146

On Fri, Apr 26, 2024 at 6:53=E2=80=AFAM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Hi Joshua
>
> Many thanks for the tips!
>
> On 4/24/24 at 16:23, Joshua Watt wrote:
> > On Wed, Apr 24, 2024 at 3:20=E2=80=AFAM Michael Opdenacker
> > <michael.opdenacker@bootlin.com> wrote:
> >> Hi Joshua
> >>
> >> On 4/24/24 at 10:15, Michael Opdenacker via lists.openembedded.org wro=
te:
> >>> Which branch did you use to generate your patch? I can't manage to
> >>> apply it to either "master", "master-next" or the branch I shared
> >>> recently...
> >>>
> >>> Ah, just found it. You used "nanbield".
> >>>
> >>> I'll test it in my branch and "torture" it with regular tests and my
> >>> new bitbake selftests.
> >> Oops, the tests are failing:
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> ERROR: test_0b_db (prserv.tests.FunctionTests)
> >> ----------------------------------------------------------------------
> >> Traceback (most recent call last):
> >>     File "/home/mike/work/yocto/poky/bitbake/lib/prserv/tests.py", lin=
e
> >> 114, in test_0b_db
> >>       self.assertTrue(self.table.test_package(version, pkgarch))
> >>     File "/home/mike/work/yocto/poky/bitbake/lib/prserv/db.py", line 7=
6,
> >> in test_package
> >>       row=3Ddata.fetchone()
> >> sqlite3.ProgrammingError: Cannot operate on a closed cursor.
> > Ah right. Ok so instead of doing the cursor operation in the
> > _exectue(), you'll need to do it in each API call. The general
> > strategy is to do:
> >
> >   def _importHist():
> >       if self.read_only:
> >           return None
> >       with closing(self.conn.cursor()) as cursor:
> >           # Use cursor.execute() for all statements, e.g.
> >           row =3D cursor.execute("SELECT value ....")
> >           data =3D row.fetchone()
> >
> > You can use the same cursor for multiple queries, so you only need the
> > one for each API call (e.g. you don't need to make a new one for each
> > execute statement).
> >
> > With this strategy I don't think you'll ever get DB locking errors, so
> > you should be able to eliminate the _execute() wrapper
> >
> > Just make sure you _always_ use a cursor to execute any database
> > queries. It will ruin your day if you combine self.conn.execute() with
> > cursor queries :)
> >
> > The cursor makes your database modifications atomic, that is any
> > changes you make to the database aren't applied until the cursor is
> > closed, and then they are applied atomically so either all the changes
> > you made are commited, or none of them. Keep in mind that this does
> > _not_ mean that your database reads are also atomic with your writes;
> > if another process commits to the database between your read and write
> > (or even between two reads) it's possible you will be dealing with a
> > stale understanding of the database when you commit.
> >
> > Sorry about the nanbield branch, I wasn't paying attention
>
> What you suggest seems to work fine.
>
> By the way, I still had empty databases after leaving the tests, but addi=
ng:
> self.conn.commit()
> after a group or INSERT or UPDATE commands did the trick.
>
> What's strange is that the hashserver code does without doing this.

It has commit() calls also, look in sqlite.py. I frequently forget
that the cursor doesn't implicitly commit when closed (unlike SQL
Alchemy, which _does_ do that) :)

>
> Anyway, let me test that two servers can access the same database now.
> If everything works, I'll be able to send a V5 soon!
>
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

