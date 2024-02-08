Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36447C4828F
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 18:02:27 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.1022.1707415345483419521
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Feb 2024 10:02:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FoNim5VX;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51168572090so127128e87.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 10:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707415344; x=1708020144; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hg0QDCUlj3szaJtKd767L1ihlZg6Ih3TS8kGJ1Tt1Q=;
        b=FoNim5VXZfwNL3nMkxql1a9XX6cvKlbBqKXr0/12sLKPz2BgCbeZdqo/aC0eSqxegC
         jzk9/afJLeFDiOfo8i81/JPybmpcOBb3CzEJN344OV+DjnI8w2Bwl91OqyOjxznfb6Js
         BlZmhUODixmCVluEzPhaJQveYtxr5GezP3oBsgh5zmDtYDcujGo3hhZZ/2mwb1qek1i/
         H/78YeGRgeR9viRbKyLbtAAioIyFPumK9B5P435Sp9EE+sMRmTFcQKBkkwRWuz/2w2YI
         CcXG7U7B9W43Bd7LVHSmxUtOh3ito+ApV99rLDrodS8/8IiZyCZDnZkF7X61WANssg2L
         lvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707415344; x=1708020144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hg0QDCUlj3szaJtKd767L1ihlZg6Ih3TS8kGJ1Tt1Q=;
        b=RDBWYiL4KPEU2Qzs2n8CxnYVHa8W3/AAqY+WGBDEZApKcPVFY2EtsqoH1UOqcwmz6x
         Tuto4YAGGheOPeGFhki+Zvr3uhcr8+ay+N+HzvUHGBM6yT77U5pcbx1Y7lNcOmoHEssn
         Xzc6pTksaiKJSXqb9uqJ/gaUvdNdk9Phm5yM5F8AfYVxvhI3/I0Z2e+QkurfGwttaXeE
         K5O4fEXK4TaSjoHbPc0hjBXFRPhZLlKPYKC7kMXSVnFFqWQlvhHNUGD0pX3C1Pl3hsjG
         Zunc/sOqoQMiTCOA13ikOKuQP7vipL+dZrLV/1BHrUjttPtlNvlqbYY1adqRkqGQ8YI0
         w4Cg==
X-Gm-Message-State: AOJu0Yy4m2WjJOJ0jEB1AhK3yltKHmROD3+mEPg1GpjEph8Yb+SRbnFy
	wVsPS6Mpzo/Rg/BF6XTIj40w1ZO1q76Xz4Sxw5ZNwpd9ERgcI46igwyxkjxxUFQBoSRljAzq3s1
	PmvZWZkJ1s9uEK2mkVaLqHUjqtvo=
X-Google-Smtp-Source: AGHT+IGc/6IgsbG59RLbYQgeEUWyN7Jcbny/rgoS4RbCMrEMzmK80Yh+ziv3khadQUme84RvP6O0TeKyF9Sp5EsCIN0=
X-Received: by 2002:a05:6512:684:b0:511:6711:1604 with SMTP id
 t4-20020a056512068400b0051167111604mr4463013lfe.52.1707415343366; Thu, 08 Feb
 2024 10:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20240208134322.3936320-1-tobias.hagelborn@axis.com>
In-Reply-To: <20240208134322.3936320-1-tobias.hagelborn@axis.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 8 Feb 2024 11:02:11 -0700
Message-ID: <CAJdd5GZ4jF3Unx8072JTtQzFbN3VZ=J-Vi86cNhwUfki_kPr3w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] hashserv: Postgres adaptations for
 ignoring duplicate inserts
To: Tobias Hagelborn <tobias.hagelborn@axis.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 18:02:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15844

On Thu, Feb 8, 2024 at 6:43=E2=80=AFAM Tobias Hagelborn
<tobias.hagelborn@axis.com> wrote:
>
> From: Tobias Hagelborn <tobiasha@axis.com>
>
> Hash Equivalence server performs unconditional insert also of duplicate
> hash entries. This causes excessive error log entries in Postgres.
> Rather ignore the duplicate inserts.
>
> The alternate behavior should be isolated to the postgres
> engine type.

Thanks. General approach seems fine, but we need to make sure the
function return codes are correct still, see below.

>
> Signed-off-by: Tobias Hagelborn <tobias.hagelborn@axis.com>
> ---
>
> I have only had the opportunity to validate against Postgres DB.
>
>  lib/hashserv/sqlalchemy.py | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/lib/hashserv/sqlalchemy.py b/lib/hashserv/sqlalchemy.py
> index cee04bff..af9da80d 100644
> --- a/lib/hashserv/sqlalchemy.py
> +++ b/lib/hashserv/sqlalchemy.py
> @@ -32,6 +32,7 @@ from sqlalchemy import (
>  import sqlalchemy.engine
>  from sqlalchemy.orm import declarative_base
>  from sqlalchemy.exc import IntegrityError
> +from sqlalchemy.dialects.postgresql import insert as postgres_insert
>
>  Base =3D declarative_base()
>
> @@ -287,11 +288,23 @@ class Database(object):
>              return result.rowcount
>
>      async def insert_unihash(self, method, taskhash, unihash):
> -        statement =3D insert(UnihashesV2).values(
> -            method=3Dmethod,
> -            taskhash=3Dtaskhash,
> -            unihash=3Dunihash,
> -        )
> +        # Postgres specific ignore on insert duplicate
> +        if self.engine.name =3D=3D 'postgresql':
> +            statement =3D postgres_insert(UnihashesV2).values(
> +                method=3Dmethod,
> +                taskhash=3Dtaskhash,
> +                unihash=3Dunihash,
> +            )
> +            statement =3D statement.on_conflict_do_nothing(
> +                index_elements=3D("method", "taskhash")
> +            )
> +        else:
> +            statement =3D insert(UnihashesV2).values(
> +                method=3Dmethod,
> +                taskhash=3Dtaskhash,
> +                unihash=3Dunihash,
> +            )
> +

Do you need to check the rowcount from the execution result in order
to know if you should return True of False in the function? I didn't
bother doing that before because it would raise an IntergrityError,
but with the "do nothing" I'm not sure that will happen anymore.

>          self.logger.debug("%s", statement)
>          try:
>              async with self.db.begin():
> @@ -311,7 +324,15 @@ class Database(object):
>          if "created" in data and not isinstance(data["created"], datetim=
e):
>              data["created"] =3D datetime.fromisoformat(data["created"])
>
> -        statement =3D insert(OuthashesV2).values(**data)
> +        # Postgres specific ignore on insert duplicate
> +        if self.engine.name =3D=3D 'postgresql':
> +            statement =3D postgres_insert(OuthashesV2).values(**data)
> +            statement =3D statement.on_conflict_do_nothing(
> +                index_elements=3D("method", "taskhash", "outhash")
> +            )
> +        else:
> +            statement =3D insert(OuthashesV2).values(**data)
> +
>          self.logger.debug("%s", statement)
>          try:
>              async with self.db.begin():

Same here

> --
> 2.30.2
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15842): https://lists.openembedded.org/g/bitbake-deve=
l/message/15842
> Mute This Topic: https://lists.openembedded.org/mt/104238536/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

