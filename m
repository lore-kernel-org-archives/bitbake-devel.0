Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6570C64EC4
	for <webhook@archiver.kernel.org>; Wed,  8 Mar 2023 21:41:29 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.6176.1678311680740175232
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Mar 2023 13:41:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=oL+mGfzV;
 spf=softfail (domain: sakoman.com, ip: 209.85.208.51, mailfrom: steve@sakoman.com)
Received: by mail-ed1-f51.google.com with SMTP id s11so71373218edy.8
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Mar 2023 13:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112; t=1678311679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JImTkBODm44ypyB4hbMslCm7C8uwiEuGiaJmosiHr6c=;
        b=oL+mGfzVP45Hak9GA+3lkiYtQWamXyvJYo14csiQRemMdLhyRonEmjFNkDbEUC0AYd
         45kTW8eB4P8JMaiYHcvAlnEk25sifK7t0HuVAzXKu1AUvzGj1nx6OgrQIMSFpMojRsVp
         CHoj+eQ/urBh/sOpaIvyJDZaqCTxod0w4Q9WUtIOvUzStyqApRxXQ9Bjv978xiJx0jvg
         fkGtv8vlEecklMlvpsVs/EOZHW/H7fc1cKdKUeCLwNeWXZu3abX8Zy5tOkWR+ER66r+O
         a+Yv8490LIV7m28IkJnooyGhhqxeekdbnGcleotj2J4EwTZbqjsovMuoKSGkwnr8n4dV
         9HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JImTkBODm44ypyB4hbMslCm7C8uwiEuGiaJmosiHr6c=;
        b=NPErMeGnoWjJ+yixIIhIB3pJO/mvUTE2Iu0oeuQM51e6uEcVg3DQ1c0V+erbPN5wXq
         ihWr0udM1MLfL1EZsn5L/S67AYPpxNufoBfgCPuZnVANTAhMSzxAqVSmHGRGqMAJcMZV
         f/nZCTnCKYe5Y9gnhp1FpJrVkCTkc8NA87t/C6F7/ZmLEAlA+WBnuwtm51Ipn7YdOhRw
         8gctHdFx7fx0jCFXPxHcmfahtN28MdZHi9z/sZwxnkw8JSD+TedKsXQikGam8p4H+naR
         qqrZwAnNEE5L2sCv72au6uZX9dw5i4k/7H/CJz3DGA7zGmpiyDAGfrT2DyEbmcVY80Ft
         xWog==
X-Gm-Message-State: AO0yUKUWUcrbgvpilnj9j9DIJSjRkMcr14i4cIlMgd0qx8jQBdETh5o2
	2klFJnkZu8gCF0d98wo7pev8XwJh+vHPz6kIV+DBXA==
X-Google-Smtp-Source: AK7set+JjICCNZ5ZatEogcVSnS+u2bQhCFIxxc6IZbg+VZe6JhOOuV+9CGN/OWPnQOKYye2MXxJ7d+E3lQ3JTEgJ5p8=
X-Received: by 2002:a17:906:308e:b0:879:5db8:8bb2 with SMTP id
 14-20020a170906308e00b008795db88bb2mr9176287ejv.7.1678311679002; Wed, 08 Mar
 2023 13:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20221206181805.3022-1-debrabander@gmail.com> <6d2196a8-f618-872d-2f51-93afdc99933a@windriver.com>
In-Reply-To: <6d2196a8-f618-872d-2f51-93afdc99933a@windriver.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Wed, 8 Mar 2023 11:41:08 -1000
Message-ID: <CAOSpxdbx8o8qYLUR4Mm+0PgjQoO9kA5Kp+edpy--NZKbdzAmww@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] ensure locale en_US.UTF-8 is available on
 the system
To: Randy MacLeod <randy.macleod@windriver.com>
Cc: debrabander@gmail.com, bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Mar 2023 21:41:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14528

On Wed, Mar 8, 2023 at 11:08=E2=80=AFAM Randy MacLeod
<randy.macleod@windriver.com> wrote:
>
> On 2022-12-06 13:18, Frank de Brabander via lists.openembedded.org wrote:
>
> Get rid of the duplicate code and add extra check that the
> locale en_US.UTF-8 is available on the system. This new helper
> method is now located right above the method filter_environment()
> which sets LC_ALL environment variable to 'en_US.UTF-8'.
>
> Nice:
>
> foo@2b7837225ffb:~/b/test$ bitbake -p coreutils
> Please make sure locale 'en_US.UTF-8' is available on your system
>
>
> Steve,
>
> It would be nice if you cherry-pick this back to langdale and kirkstone, =
it's a clean c-p.

OK, will do!

Steve

> [YOCTO #10165]
>
> Signed-off-by: Frank de Brabander <debrabander@gmail.com>
> ---
>  bin/bitbake        |  3 +--
>  bin/bitbake-server |  5 +++--
>  bin/bitbake-worker |  3 +--
>  lib/bb/utils.py    | 16 ++++++++++++++++
>  4 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/bin/bitbake b/bin/bitbake
> index 7cbf88f4..f869eb48 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -25,8 +25,7 @@ except RuntimeError as exc:
>  from bb import cookerdata
>  from bb.main import bitbake_main, BitBakeConfigParameters, BBMainExcepti=
on
>
> -if sys.getfilesystemencoding() !=3D "utf-8":
> -    sys.exit("Please use a locale setting which supports UTF-8 (such as =
LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale after loadi=
ng so we need a UTF-8 when Python starts or things won't work.")
> +bb.utils.check_system_locale()
>
>  __version__ =3D "2.2.0"
>
> diff --git a/bin/bitbake-server b/bin/bitbake-server
> index 825e9d56..454a3919 100755
> --- a/bin/bitbake-server
> +++ b/bin/bitbake-server
> @@ -12,8 +12,9 @@ warnings.simplefilter("default")
>  import logging
>  sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv=
[0])), 'lib'))
>
> -if sys.getfilesystemencoding() !=3D "utf-8":
> -    sys.exit("Please use a locale setting which supports UTF-8 (such as =
LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale after loadi=
ng so we need a UTF-8 when Python starts or things won't work.")
> +import bb
> +
> +bb.utils.check_system_locale()
>
>  # Users shouldn't be running this code directly
>  if len(sys.argv) !=3D 11 or not sys.argv[1].startswith("decafbad"):
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 3799b170..3cacdb0c 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -24,8 +24,7 @@ import subprocess
>  from multiprocessing import Lock
>  from threading import Thread
>
> -if sys.getfilesystemencoding() !=3D "utf-8":
> -    sys.exit("Please use a locale setting which supports UTF-8 (such as =
LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale after loadi=
ng so we need a UTF-8 when Python starts or things won't work.")
> +bb.utils.check_system_locale()
>
>  # Users shouldn't be running this code directly
>  if len(sys.argv) !=3D 2 or not sys.argv[1].startswith("decafbad"):
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index f4da3563..0df522b3 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -13,6 +13,7 @@ import errno
>  import logging
>  import bb
>  import bb.msg
> +import locale
>  import multiprocessing
>  import fcntl
>  import importlib
> @@ -608,6 +609,21 @@ def preserved_envvars():
>      ]
>      return v + preserved_envvars_exported()
>
> +def check_system_locale():
> +    """Make sure the required system locale are available and configured=
"""
> +    default_locale =3D locale.getlocale(locale.LC_CTYPE)
> +
> +    try:
> +        locale.setlocale(locale.LC_CTYPE, ("en_US", "UTF-8"))
> +    except:
> +        sys.exit("Please make sure locale 'en_US.UTF-8' is available on =
your system")
> +    else:
> +        locale.setlocale(locale.LC_CTYPE, default_locale)
> +
> +    if sys.getfilesystemencoding() !=3D "utf-8":
> +        sys.exit("Please use a locale setting which supports UTF-8 (such=
 as LANG=3Den_US.UTF-8).\n"
> +                 "Python can't change the filesystem locale after loadin=
g so we need a UTF-8 when Python starts or things won't work.")
> +
>  def filter_environment(good_vars):
>      """
>      Create a pristine environment for bitbake. This will remove variable=
s that
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14139): https://lists.openembedded.org/g/bitbake-deve=
l/message/14139
> Mute This Topic: https://lists.openembedded.org/mt/95499228/3616765
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [randy.=
macleod@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
> --
> # Randy MacLeod
> # Wind River Linux

