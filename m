Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66DCC25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 18:42:48 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.208704.1698345764923687305
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 11:42:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=eBdwC4d4;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 84DB29C296F;
	Thu, 26 Oct 2023 14:42:43 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id oIv2adINVduc; Thu, 26 Oct 2023 14:42:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 993489C29B3;
	Thu, 26 Oct 2023 14:42:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 993489C29B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698345762; bh=nW9TyFpYGOLU8EGLfqJWMjjndGP6xNIUm7f/dh0Ahow=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=eBdwC4d4WmJLBssBQrqfQEjuRriINmXyTPwebsGMmxKhkovaHiYgvYCf6u0RyBPqT
	 MIz6yAP6YsOZfsfxkyaN2X2W1eXXE7fLqiwwGIRNgCnj27BU8+euhdpabG0qP2zcZs
	 S3WIwKj4x9cv5h857h15pZz0jIIJTpNwXjTvNkA3pOjCTFpSsjewNwqIRJ49zmjSVd
	 K2zwceS7iEo2syQaJA5AV8n9Gv6jwfHrYMsIKDueKukQ4743KiFXupcGdV6hSY+RgN
	 Hu+E6lWoyeWKOMK9esjxfU92xY5u51iWNH0mUjb93KcFPNcsZY+HCMmCuB3W6ZxRZM
	 ay1nYbpEqLfDw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id f-ZTtR5MvsJB; Thu, 26 Oct 2023 14:42:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7FFF49C296F;
	Thu, 26 Oct 2023 14:42:42 -0400 (EDT)
Date: Thu, 26 Oct 2023 14:42:42 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: Tim Orling <ticotimo@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	toaster <toaster@lists.yoctoproject.org>, 
	Tim Orling <tim.orling@konsulko.com>
Message-ID: <1501491700.143675.1698345762204.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <CANx9H-B_VfuVxHqK7F3M7+zy1OH0Thv41ZAZHCXUn_Nttpof9g@mail.gmail.com>
References: <1791B341DCBB88FE.20272@lists.yoctoproject.org> <CANx9H-B_VfuVxHqK7F3M7+zy1OH0Thv41ZAZHCXUn_Nttpof9g@mail.gmail.com>
Subject: Re: [Toaster] [PATCH] toaster: write logs to BUILDDIR
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC117 (Linux)/8.8.15_GA_4570)
Thread-Topic: toaster: write logs to BUILDDIR
Thread-Index: FJduF9ij4WmSK0HIMfJvWhWQpzg9+g==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 18:42:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15297

Tim,

Normaly when you visit some pages, this action create and logs inside files=
 toaster.logs etc, in build/ dir.

I suppose issue is because BUILDDIR is empty, yes i got nothing when i $ech=
o $BUILDDIR inside the container

----- Mail original -----
De: "Tim Orling" <ticotimo@gmail.com>
=C3=80: "alassane yattara" <alassane.yattara@savoirfairelinux.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>, "toaster" <toas=
ter@lists.yoctoproject.org>, "Tim Orling" <tim.orling@konsulko.com>
Envoy=C3=A9: Jeudi 26 Octobre 2023 18:54:13
Objet: Re: [Toaster] [PATCH] toaster: write logs to BUILDDIR

Allassane,

At least when running in the toaster-container, I'm seeing no logs, but
links like "conf/toaster_api.log", but that file doesn't exist and is not
downloadable.

I tried a couple other changes on:
https://git.yoctoproject.org/poky-contrib/log/?h=3Dtimo/toaster-logging-v3
(one of which was present in your series earlier today).

But I don't have experience with the log_viewer plugin and I'm not sure
what is happening to cause the "conf/" to be prepended to the log links in
the admin interface.

On Thu, Oct 26, 2023 at 8:53=E2=80=AFAM Tim Orling via lists.yoctoproject.o=
rg
<ticotimo=3Dgmail.com@lists.yoctoproject.org> wrote:

> Fixes "2efb14648 toaster: Monitoring - implement Django logging system"
> when
> running in a container.
>
> When running in a container, the previous approach of using BASE_DIR
> is not a writable path. Also, we really do not want to be writing logs in=
to
> the source tree, as the BASE_DIR was resolving to bitbake/lib/toaster/log=
s
>
> Since Toaster is only ever running in an environment where oe-init-builde=
nv
> or similar has been sourced, we should instead write the logs to BUILDDIR=
.
> This is where the existing toaster_ui.log was already being written.
>
> Drop the /logs/ directory, as it has not been created which also breaks
> in a container environment. Instead, prepend the api.log, etc. with
> "toaster_"
> and write them alongside the existing toaster_ui.log
>
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
>  lib/toaster/toastermain/logs.py     | 9 +++++----
>  lib/toaster/toastermain/settings.py | 7 ++++---
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/lib/toaster/toastermain/logs.py
> b/lib/toaster/toastermain/logs.py
> index b4910e443..5a296bc3f 100644
> --- a/lib/toaster/toastermain/logs.py
> +++ b/lib/toaster/toastermain/logs.py
> @@ -1,12 +1,13 @@
>  #!/usr/bin/env python3
>  # -*- coding: utf-8 -*-
>
> +import os
>  import logging
>  import json
>  from pathlib import Path
>  from django.http import HttpRequest
>
> -BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
> +BUILDDIR =3D Path(os.environ.get('BUILDDIR'))
>
>
>  def log_api_request(request, response, view, logger_name=3D'api'):
> @@ -108,7 +109,7 @@ LOGGING_SETTINGS =3D {
>          'file_django': {
>              'level': 'INFO',
>              'class': 'logging.handlers.TimedRotatingFileHandler',
> -            'filename': BASE_DIR / 'logs/django.log',
> +            'filename': BUILDDIR / 'toaster_django.log',
>              'when': 'D',  # interval type
>              'interval': 1,  # defaults to 1
>              'backupCount': 10,  # how many files to keep
> @@ -117,7 +118,7 @@ LOGGING_SETTINGS =3D {
>          'file_api': {
>              'level': 'INFO',
>              'class': 'logging.handlers.TimedRotatingFileHandler',
> -            'filename': BASE_DIR / 'logs/api.log',
> +            'filename': BUILDDIR / 'toaster_api.log',
>              'when': 'D',
>              'interval': 1,
>              'backupCount': 10,
> @@ -126,7 +127,7 @@ LOGGING_SETTINGS =3D {
>          'file_toaster': {
>              'level': 'INFO',
>              'class': 'logging.handlers.TimedRotatingFileHandler',
> -            'filename': BASE_DIR / 'logs/toaster.log',
> +            'filename': BUILDDIR / 'toaster.log',
>              'when': 'D',
>              'interval': 1,
>              'backupCount': 10,
> diff --git a/lib/toaster/toastermain/settings.py
> b/lib/toaster/toastermain/settings.py
> index b083cf588..c65f4b630 100644
> --- a/lib/toaster/toastermain/settings.py
> +++ b/lib/toaster/toastermain/settings.py
> @@ -315,13 +315,14 @@ for t in os.walk(os.path.dirname(currentdir)):
>  # more details on how to customize your logging configuration.
>  LOGGING =3D LOGGING_SETTINGS
>
> -# Build paths inside the project like this: BASE_DIR / 'subdir'.
> -BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
> +# Rather than using BASE_DIR inside the source tree, we use
> +# BUILDDIR which is exported by the bitbake environment
> +BUILDDIR =3D os.environ.get("BUILDDIR")
>
>  # LOG VIEWER
>  # https://pypi.org/project/django-log-viewer/
>  LOG_VIEWER_FILES_PATTERN =3D '*.log*'
> -LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, 'logs')
> +LOG_VIEWER_FILES_DIR =3D BUILDDIR
>  LOG_VIEWER_PAGE_LENGTH =3D 25      # total log lines per-page
>  LOG_VIEWER_MAX_READ_LINES =3D 100000  # total log lines will be read
>  LOG_VIEWER_PATTERNS =3D ['INFO', 'DEBUG', 'WARNING', 'ERROR', 'CRITICAL'=
]
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5896):
> https://lists.yoctoproject.org/g/toaster/message/5896
> Mute This Topic: https://lists.yoctoproject.org/mt/102202795/924729
> Group Owner: toaster+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

