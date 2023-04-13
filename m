Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B75EC77B61
	for <webhook@archiver.kernel.org>; Thu, 13 Apr 2023 18:22:54 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.21686.1681410165083820836
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Apr 2023 11:22:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@sakoman-com.20221208.gappssmtp.com header.s=20221208 header.b=l+v6hlVa;
 spf=softfail (domain: sakoman.com, ip: 209.85.218.52, mailfrom: steve@sakoman.com)
Received: by mail-ej1-f52.google.com with SMTP id dm2so39757729ejc.8
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Apr 2023 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20221208.gappssmtp.com; s=20221208; t=1681410163; x=1684002163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBG+SpVoMgkvNYB3Eh3Y5TOARUETmFMpE2ODnLfpTUg=;
        b=l+v6hlVa1KQAzSxa/tHNGjhAc+uJGTIAgABy1DQK6+KI8Rc/mpbbgUdB7Hq2maaCrj
         ssL//zmBQU9m3PJDTRCGgZr7pm++VRLKxyTef8q0l97BYquK83f+a12jvIa4RlWb1OKF
         0EWfp/rx62RhR3RnIqoZ5raXymMUFvleG5sXZHcIAVGiNtzxGoBOBziVxs/UfbQx6n+a
         4O13CutLZH30kNb2bh/fGPWXZcA7u5jkMKbbyg5xZ5hbpznfwWHYl93CrlI6blSLZfeH
         oW7NEfcHmYIXnX/07unVRWlgRQAyx4jZZ1YjF8XZR51OwOc1NizLNA4cowhiUnwbzJ/h
         vVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681410163; x=1684002163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBG+SpVoMgkvNYB3Eh3Y5TOARUETmFMpE2ODnLfpTUg=;
        b=hfmhnzmGQ9zqRg/TTU8ajRXGm88CLASlv3fxBgFUCyUM2+uaVUb85ue6o/zoF4qaxq
         5N+z4OjWD5QnU36ZCU1ilv0CTVODqCqiUX5xbPIwspvYdJ8zfbMvni+bgGDwBBSsHTaF
         clq039prm8AKukkIsK4f9SWn2ampsOTEW3NU+FENPG3CtvQjTSgJmy9tcpdK8dQuv58M
         sMJCx9Wcf1j6G0ja6TUdGMeXMrmuHSR9dul1UZKlzV1bw9uWdylTfQvoSwaQbB1KIy1r
         sIBWOy7JpeqMEfb74Y5ZqTdL5eLcVFoud5hYEyliPt7Pwh70ObhdgYg+zBADBCQ8D4hL
         4wcg==
X-Gm-Message-State: AAQBX9fKCOUNVgPhVF1TI1knuSf/6+AgbY39MwWspVnoUYeKIgrTni2C
	dDAKyXm6uylMDJ8Qg2GeGc6e4Yqojyqf/AZdBNA8ag==
X-Google-Smtp-Source: AKy350ZINuv759Pxnn0qRMOfb/PGk9fDdClyxTajf7bNWilSCazAn0cXryW5JV9QGgN7nNr4YRCFlEDhWSVy+JdYMPQ=
X-Received: by 2002:a17:906:ef08:b0:94e:b38f:4c43 with SMTP id
 f8-20020a170906ef0800b0094eb38f4c43mr1058576ejs.3.1681410163017; Thu, 13 Apr
 2023 11:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221206181805.3022-1-debrabander@gmail.com> <6d2196a8-f618-872d-2f51-93afdc99933a@windriver.com>
 <CAOSpxdbx8o8qYLUR4Mm+0PgjQoO9kA5Kp+edpy--NZKbdzAmww@mail.gmail.com> <4c9b8990-3e7b-baff-5f8e-c338f0e2ca41@windriver.com>
In-Reply-To: <4c9b8990-3e7b-baff-5f8e-c338f0e2ca41@windriver.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Thu, 13 Apr 2023 08:22:31 -1000
Message-ID: <CAOSpxdb1cduq+y4t86QuqqmjV22RStXatTrS9-3GfAoyhaevWw@mail.gmail.com>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Apr 2023 18:22:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14698

On Tue, Apr 11, 2023 at 8:04=E2=80=AFAM Randy MacLeod
<randy.macleod@windriver.com> wrote:
>
> On 2023-03-08 16:41, Steve Sakoman wrote:
>
> On Wed, Mar 8, 2023 at 11:08=E2=80=AFAM Randy MacLeod
> <randy.macleod@windriver.com> wrote:
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
>
> OK, will do!
>
>
> Steve,
>
> Did this cherry-pick slip through the cracks?

Sadly, yes.  Thanks for the reminder, I've got it in my test queue now.

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
>
>
> --
> # Randy MacLeod
> # Wind River Linux

