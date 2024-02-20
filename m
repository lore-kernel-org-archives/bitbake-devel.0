Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F70C48BC3
	for <webhook@archiver.kernel.org>; Tue, 20 Feb 2024 15:36:16 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web10.16007.1708443366748517901
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Feb 2024 07:36:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Su+Nq7Wd;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so3752526e87.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708443365; x=1709048165; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZV8iPD/3OXaorv9HXeupXEvXKbYihwuhZJmnnyV5gw=;
        b=Su+Nq7WdqLloWaJkNmcQoIdZDlAWwhO80vBi1+p6djZYQcv5VBiwubnon/juHMF31a
         FwhGHB7oQl41r+ID/if7lkpD5YBHfl9Wq3HrJEflbv2JNsJgmghKjC14rf+AS57IgDZE
         JOfmJBa79u3Fi8uNZki9ikCcAlgYr8SS2UnX8TekTFwxEcr6JS6HTeG6U2KZc4pTXnbV
         lny69kTyHoinURRYcQlT4tx+e0VSyaqF1VUBxR5MycWldXSnYipo+/fLDVx/QgF39+7e
         UF08ihs+AmfRrxsL7LV186iaiqrzmJbljUuGKnWVFqHQtDOVTgFnRDBA54y2r1uAzAbn
         QYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443365; x=1709048165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZV8iPD/3OXaorv9HXeupXEvXKbYihwuhZJmnnyV5gw=;
        b=oMrXBxxEwCX94Q8RW1c2bVSIHf7jMLq5P/b7KOK2Y145rE1gdtli9Rw3hvARFtto6r
         6I1MdTv0TSdziKoeidXBUxNTwkPV5qARtNfDax5doG7TRRRTQTritGtAxPPkZIEs//eU
         Va5idvOBXH8OrO0iMvjrxOKeYCy69/0Jz8qObgdN+7W29znJoznP14KJMOEjNnrcaM56
         /ftMUeXhaIjAvj/NQ6tAUX9bWhsTrO4JDKoCQQgxjbyKgiPDk6iFL8SMica7wjuh5M9f
         zk/KtAk12OTYDi6it97sOd4MSeXi+nQUO2Gaz8x0FQeiUkNANaSfyptjCja7r8ThTbjn
         d0rw==
X-Gm-Message-State: AOJu0YzryMlhA6zLIwa92y1yFnU+hv8IQmXVvdzpr9hmk5OY8sWm6gWB
	WQx6jKo1ObPfLFUw7SQvklW3nDk4weQQAc7HHPB1y3+BPcl9QDhMOZN1joc2nC5u2ZtbVy3qKK+
	7zBPgbWcsZ0QOhhxouZ9bPagj98N5uPn3
X-Google-Smtp-Source: AGHT+IE/LeIoPzZuMXhSE4ENBwXElPl2hAGEQ0MY2KTwHJbNQ/EJ1tdguDG/iEEul/fwEaO1aAB8Fqq0Kxek1G3zjLQ=
X-Received: by 2002:a05:6512:402:b0:512:b24c:dba with SMTP id
 u2-20020a056512040200b00512b24c0dbamr3590147lfk.60.1708443364659; Tue, 20 Feb
 2024 07:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20240220062705.3611869-1-tobiasha@axis.com>
In-Reply-To: <20240220062705.3611869-1-tobiasha@axis.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 20 Feb 2024 08:35:52 -0700
Message-ID: <CAJdd5GaHiakYT4W0kaVhp6NvU4nBccR6MKHtjR_YsMehi-Lg6w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Re-enable connection pooling with psycopg
 3 driver
To: Tobias Hagelborn <tobias.hagelborn@axis.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 15:36:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15949

On Mon, Feb 19, 2024 at 11:27=E2=80=AFPM Tobias Hagelborn
<tobias.hagelborn@axis.com> wrote:
>
> Re-enable connection pooling in case `postgresql+psygopg` driver
> is used. Async connection pooling is supported in psycopg 3 [psycopg]
> driver in SQLAlchemy.
>
> Signed-off-by: Tobias Hagelborn <tobiasha@axis.com>
> ---
>
> Connection pooling was disabled since asyncpg does not support it.
> With psycopg3 driver it is possible to re-enable connection pooling again=
.
>
> I wanted to show that it is possible to get the performance back again
> and avoid using other, more complex deployments such as pgbouncer to
> achieve connection pooling.
>
> Checking the driver url is possibly a bit hackish.
> Having some command line parameter would result in a larger change
> and also force the user to know which drivers do support pooling properly=
.
>
> I tested this setup with some of my stress tests and with a batch of buil=
ds
> and it seems to hold.
>
>  lib/hashserv/sqlalchemy.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/lib/hashserv/sqlalchemy.py b/lib/hashserv/sqlalchemy.py
> index b17a17621..e33527e80 100644
> --- a/lib/hashserv/sqlalchemy.py
> +++ b/lib/hashserv/sqlalchemy.py
> @@ -93,7 +93,11 @@ class DatabaseEngine(object):
>
>      async def create(self):
>          self.logger.info("Using database %s", self.url)
> -        self.engine =3D create_async_engine(self.url, poolclass=3DNullPo=
ol)
> +        if self.url.drivername =3D=3D 'postgresql+psycopg':
> +            # Psygopg 3 (psygopg) driver can handle async connection poo=
ling
> +            self.engine =3D create_async_engine(self.url)
> +        else:
> +            self.engine =3D create_async_engine(self.url, poolclass=3DNu=
llPool)

This approach is fine with me. If we need an argument in the future we
can make one that does "yes", "no", "auto" options. Do you happen to
know if this is version dependent or if it's just because I didn't
test with the psycopg driver?

>
>          async with self.engine.begin() as conn:
>              # Create tables
> --
> 2.30.2
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15944): https://lists.openembedded.org/g/bitbake-deve=
l/message/15944
> Mute This Topic: https://lists.openembedded.org/mt/104463321/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

