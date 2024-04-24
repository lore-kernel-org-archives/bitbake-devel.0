Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CACC4345F
	for <webhook@archiver.kernel.org>; Wed, 24 Apr 2024 14:23:37 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.17875.1713968614873080471
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Apr 2024 07:23:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZWVaZHbM;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5196c755e82so9734521e87.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Apr 2024 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713968613; x=1714573413; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FH+VLEDs/7bwvVn2UEiw+9GIPoTmB84q3Do2D2ag6M=;
        b=ZWVaZHbM35MbpI1s60KJXWXuJtJEA3WSRP+b2vyuoen0nmmYbJcM1tLt1v3JBcZhB5
         J4xQPUd+V9fleDQlbssvnAehQbNENXcLqUsRkhIhs/5g7EPCICONcZNO0zfgMXe0l523
         YInaxZ/ktDWa76krl2EHR6fF5jjNQU9KJ0pAHVSHdI9CKNt7IPXvy4pylc9B8IBXqv2a
         xKWHtrEU9N8FAwDTbEMaSDURR/AxU77iq/7WlPYCfU3Lf+rdh2+oytci2X/jlhV0yKjW
         jviKLpqirtLhyD9DMSnnSlOGKpU02p18kjpqsvynb5PwdNZRSmf18XmWyQd73JrGOFGV
         erJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968613; x=1714573413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FH+VLEDs/7bwvVn2UEiw+9GIPoTmB84q3Do2D2ag6M=;
        b=a6EEqTzBqplJTzK2oI9ku4Wr4GIGGSACa6Je71Vk1oZYpEUGcURfXk1iXKf25rWYLu
         Z/3kTdL+9uACC+IKbQAqtoTyMgucGnGbxxp39aycP3rwZh82JsZE1tXBfeFhEtuWf2PI
         M6/W8uf03Lf3yy11RRkRWjTdAYmYGHCDLql+ExUGY3m/yFpbAd1pBNariGqgIUSrY+/J
         6xzBjc9so93dEVuCOBD5SffurYC/UvKPPPKQ3070PA03MATE8Vg0WZZ8YwRU3aCqmPTx
         FW7sDFIAB8MFM5mMAqKTOMZV0ID3OcK5AQGo6GCce57xsYnuFuCwWdzxmTDxtuEDLJdf
         RCdg==
X-Gm-Message-State: AOJu0YwJnQU2PUZSglz1xnNflrLAnVXGFWPlRHqZ6iAFezvn1YWU+q72
	941NLD5eKCXQlpaYBXBRBrmDHjsqeweLhTXjHTDdxexfiUvVTI/NkJrrurTxGqReberEcU6XEA0
	R2C0uFlyr2JIpPXzGOKCCdcciJ0U=
X-Google-Smtp-Source: AGHT+IEz2uQRA7Tbi0XKKKANKYPC/t32as5lQn+DO4u1qIM5ayN++7aoguYaCMd1ReaAJWXOUMIxnNFUj1L9dWJQtyM=
X-Received: by 2002:ac2:46cb:0:b0:519:231:e4b9 with SMTP id
 p11-20020ac246cb000000b005190231e4b9mr2056556lfo.48.1713968612748; Wed, 24
 Apr 2024 07:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240423182543.226113-1-JPEWhacker@gmail.com> <20240423182729.226345-1-JPEWhacker@gmail.com>
 <17C929449F85DB18.1247@lists.openembedded.org> <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
In-Reply-To: <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 24 Apr 2024 08:23:20 -0600
Message-ID: <CAJdd5GbB5xFBq6sC7kEP0YferegyXQYai9Mo-1jAkxe9wxSG7A@mail.gmail.com>
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Apr 2024 14:23:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16139

On Wed, Apr 24, 2024 at 3:20=E2=80=AFAM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Hi Joshua
>
> On 4/24/24 at 10:15, Michael Opdenacker via lists.openembedded.org wrote:
> > Which branch did you use to generate your patch? I can't manage to
> > apply it to either "master", "master-next" or the branch I shared
> > recently...
> >
> > Ah, just found it. You used "nanbield".
> >
> > I'll test it in my branch and "torture" it with regular tests and my
> > new bitbake selftests.
>
> Oops, the tests are failing:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ERROR: test_0b_db (prserv.tests.FunctionTests)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/home/mike/work/yocto/poky/bitbake/lib/prserv/tests.py", line
> 114, in test_0b_db
>      self.assertTrue(self.table.test_package(version, pkgarch))
>    File "/home/mike/work/yocto/poky/bitbake/lib/prserv/db.py", line 76,
> in test_package
>      row=3Ddata.fetchone()
> sqlite3.ProgrammingError: Cannot operate on a closed cursor.

Ah right. Ok so instead of doing the cursor operation in the
_exectue(), you'll need to do it in each API call. The general
strategy is to do:

 def _importHist():
     if self.read_only:
         return None
     with closing(self.conn.cursor()) as cursor:
         # Use cursor.execute() for all statements, e.g.
         row =3D cursor.execute("SELECT value ....")
         data =3D row.fetchone()

You can use the same cursor for multiple queries, so you only need the
one for each API call (e.g. you don't need to make a new one for each
execute statement).

With this strategy I don't think you'll ever get DB locking errors, so
you should be able to eliminate the _execute() wrapper

Just make sure you _always_ use a cursor to execute any database
queries. It will ruin your day if you combine self.conn.execute() with
cursor queries :)

The cursor makes your database modifications atomic, that is any
changes you make to the database aren't applied until the cursor is
closed, and then they are applied atomically so either all the changes
you made are commited, or none of them. Keep in mind that this does
_not_ mean that your database reads are also atomic with your writes;
if another process commits to the database between your read and write
(or even between two reads) it's possible you will be dealing with a
stale understanding of the database when you commit.

Sorry about the nanbield branch, I wasn't paying attention


>
> Let me send you my patch series with your change included. I'll send
> them through a private e-mail. Don't want to spam the list at this stage.
> Thanks
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

