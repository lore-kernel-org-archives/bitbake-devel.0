Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF55C4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 18:01:18 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web10.2739.1714154476608998720
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Apr 2024 11:01:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gL+X1da8;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ddc2ea2091so23712811fa.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714154474; x=1714759274; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPsc4QLX3CVIVvC9BZ+O/z9eD9n0IHyjUWmE5ibDfsw=;
        b=gL+X1da8kpAL5fTquSJvlUeqvw3OGxi7la8tFOVEb+HaCBtJ/wQoesT0rCqVKhGMOb
         nuAKZLMvrPv0VVX3nK55SOMkELWGYDEwNgb0Se6dqEkGY9MePSIy0k/f9SCIVFkDGcuO
         84TLNzXdWgVpR+ams4wC4B6J/MGvOMLa/oaas9Q7jzOVmOEJSb3dK1CKB176tfxKJ79S
         2o+2bIb6rTz5H2N6NwOnKRB8RwWc2yOgwHsb5BjWr9VAXY1pDWv/tPNrwN4quLIqLTBx
         ss9HgfNIArd5YrIsfDGGjL156XtO+1oYr4H1EjK+XfEWjchtzbjMujX/BCCcQ7g4+rwu
         d5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154474; x=1714759274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPsc4QLX3CVIVvC9BZ+O/z9eD9n0IHyjUWmE5ibDfsw=;
        b=l0MBB64iBrxm6Fc14ZjHjqz+rm/7rBZFIaCW9Gw9//usw3uq5Ch8nUErTlglkrvvRt
         Mmo9X5RVMSmZYcOtv10lU6ftTwTwnXrKdd2a8zRTR/RILOrJWCZ059L/R90y8LGOaH5n
         jgP0KnG/kpyj+CeleU7/JkpU5jjdgwkW4bvEg1GUQEYGVbszTVhM+gtSjBfd6UyPX5xs
         CdadiGuPohJCrB9OlJ19eg/PLW4XflZFkN19a9tBEr/vwLjbZGQAnu0Py8uFKtkgQVBF
         B/Kwy/TBmdeLkP+NdG9Z1oxKSYUNGPSlcg8aOj0LRFK6ZYGO2V5E/J5gm3q4mPCjAq7q
         JjPg==
X-Gm-Message-State: AOJu0YygWw+sFFTbUxnI3+ZUawIPaG8o44ZyBhgZSaOqfM6aKj+Keat0
	kUUApFK4lbygB8IjERoTY+Ahc4U4oX3eHhLNujQusVVO52eAsNGIFRGErudzTG7dfjMy25gDizA
	Q1hbuo5kXb62LTj+y0DpAbcbpILfAUQ==
X-Google-Smtp-Source: AGHT+IFQDCt/Vcte5BUK37ZT78osCBlAvaqdp0Oc6Ae6Ummrhsa29DPKY0qnqyOnTkB/kGzvthc5B16JzaVYFSIS224=
X-Received: by 2002:a05:651c:2112:b0:2d4:6f14:53d5 with SMTP id
 a18-20020a05651c211200b002d46f1453d5mr2367757ljq.26.1714154474378; Fri, 26
 Apr 2024 11:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240423182543.226113-1-JPEWhacker@gmail.com> <20240423182729.226345-1-JPEWhacker@gmail.com>
 <17C929449F85DB18.1247@lists.openembedded.org> <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
 <CAJdd5GbB5xFBq6sC7kEP0YferegyXQYai9Mo-1jAkxe9wxSG7A@mail.gmail.com>
 <17C9D59E2FED0839.6322@lists.openembedded.org> <f2d334bc-4c26-45cb-9395-0bfc642d74e5@bootlin.com>
In-Reply-To: <f2d334bc-4c26-45cb-9395-0bfc642d74e5@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 26 Apr 2024 12:01:02 -0600
Message-ID: <CAJdd5GbCQYrZZsWO7MmKT_SehF8cn0yAtP-H52ZBXgU7s3ZUxw@mail.gmail.com>
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 18:01:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16147

On Fri, Apr 26, 2024 at 6:56=E2=80=AFAM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
>
> On 4/26/24 at 14:53, Michael Opdenacker via lists.openembedded.org wrote:
> > By the way, I still had empty databases after leaving the tests, but
> > adding:
> > self.conn.commit()
> > after a group or INSERT or UPDATE commands did the trick.
>
>
> For the record, my database was created with the below settings:
>
> self.connection.execute("PRAGMA synchronous =3D NORMAL;")

synchronous only affects when sqlite makes the sync() syscall, and
therefore should have no impact on multiple processes using the
database. Setting it NORMAL will cause some sync() calls to occur such
that if power loss occurs, there is no (or very minimal) chance of
database corruption (but perhaps lost data). Since sync() generally
has a higher than normal impact on Yocto builds, the hash server
defaults to OFF, so that there are no sync() calls. The data is
correct and fine, as long as no power loss occurs and can be shared
between multiple processes and doesn't affect build performance.

> self.connection.execute("PRAGMA journal_mode =3D WAL;")
>
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

