Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F36C25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 15:06:07 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web11.73341.1698332762288958360
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 08:06:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MEtQgYG3;
 spf=pass (domain: gmail.com, ip: 209.85.128.179, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ae143e08b1so7581627b3.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698332761; x=1698937561; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQCSE8ToAonQPFLMhphD4BKLk8Zghut9v/PmBknqrYA=;
        b=MEtQgYG3FJa76Q3EcQw+JkCDwCWAygVO1OxuXqnte7LV3xwZO/Xq38gVo4WIN6AjsF
         bU7p7zi2Y8FxRTYpW2/McTHckSTqF6kaFWxmR8SMEo0kviDrK+Q1UhogKVihCspTp5J5
         wRYzUq8OuamhWTrT6wfAVdh3XsF3IaArbKykf8j4TZOm1svEYRY0ooPeLBoX0eQbkQjr
         uEpiBJtLh9JC24KnOr3Fc7If0DXG+mUDHRjGZfOhryigXh2+FS3Xud1ZsUr4uX6v70sL
         6XeYP0aS3FE9XGQ2AgXNroVEuk1bAo5JwZsqN3mJqNQCtanxLg9dYvKj4w/La6YsNAt8
         iYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698332761; x=1698937561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQCSE8ToAonQPFLMhphD4BKLk8Zghut9v/PmBknqrYA=;
        b=G1qOK4+TXnMxOlSlnvL4aE5BDRxNdKJrWAOM5ojY4ymiWImBY2b55irtpHf8kNA+/S
         btSwnYdkOORnSdlR3AtS3bMl/SpVvj261baT8K/cvrQnWMjI3ZRQR2+ka0IpoSF14hL0
         QrWzb5BWDyc/1GryHiGk9RZIQZKzsLuo0CwpNfZFAibyx6ZmPv8v7kjMXkSczjxZ78H/
         NwR8vdXqCE3wkRB4XH8s/w6RG/qm1QZWhQfn2nszPXOi0OkK6uqIvdMNZRFyj5CuF3Rk
         X5od0P6GpVUzUYuNyj3ym0RRCgUdBxWrxz0rHJttTCNCJiLI4ZVMXecLasK3v181wE97
         N4yQ==
X-Gm-Message-State: AOJu0YyVa/3feYLZO43WtFuPu88GCLxYSeRC0oGo4eVgI4OS6oVtYR0x
	7HS3V4UxnB/XbpwFv1L/gsyqvrYIFlJjJ4vGutTdZTOeEv0=
X-Google-Smtp-Source: AGHT+IE/NDykrZdimxP4rjAAXIg59SnDUaytNssy6l2Z1H5/eDsskqa9rZ1FvQwQt383qWZCwWRKlzkz26jeQX+dHhI=
X-Received: by 2002:a0d:eb96:0:b0:5a2:20ec:40be with SMTP id
 u144-20020a0deb96000000b005a220ec40bemr20953982ywe.29.1698332761261; Thu, 26
 Oct 2023 08:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231026140453.790676-1-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231026140453.790676-1-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Thu, 26 Oct 2023 08:05:50 -0700
Message-ID: <CANx9H-BqGSTrHMzeXmUGoJygGtHr=7y7yxejW+YrF6XP-iJvoQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] Bug-fix logging permission error in docker
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, Tim Orling <tim.orling@konsulko.com>
Content-Type: multipart/alternative; boundary="000000000000f20a3806089fe87d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 15:06:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15293

--000000000000f20a3806089fe87d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series should be squashed into one commit and cleaned up a bit. This
was just a work-in-progress branch from me and not intended to be the final
version.

On Thu, Oct 26, 2023 at 7:05=E2=80=AFAM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> From: Tim Orling <tim.orling@konsulko.com>
>
> toastermain: use BUILDDIR for logs
>
> Developer: Tim Orling
> Reviewer: Alassane Yattara
>
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  bitbake/lib/toaster/toastermain/logs.py     | 10 ++++++----
>  bitbake/lib/toaster/toastermain/settings.py |  5 +++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/bitbake/lib/toaster/toastermain/logs.py
> b/bitbake/lib/toaster/toastermain/logs.py
> index b4910e4432..db5d459f9b 100644
> --- a/bitbake/lib/toaster/toastermain/logs.py
> +++ b/bitbake/lib/toaster/toastermain/logs.py
> @@ -1,12 +1,14 @@
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
> +#BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
> +BUILDDIR =3D os.environ.get("BUILDDIR")
>
>
>  def log_api_request(request, response, view, logger_name=3D'api'):
> @@ -108,7 +110,7 @@ LOGGING_SETTINGS =3D {
>          'file_django': {
>              'level': 'INFO',
>              'class': 'logging.handlers.TimedRotatingFileHandler',
> -            'filename': BASE_DIR / 'logs/django.log',
> +            'filename': BUILDDIR / 'logs/django.log',
>              'when': 'D',  # interval type
>              'interval': 1,  # defaults to 1
>              'backupCount': 10,  # how many files to keep
> @@ -117,7 +119,7 @@ LOGGING_SETTINGS =3D {
>          'file_api': {
>              'level': 'INFO',
>              'class': 'logging.handlers.TimedRotatingFileHandler',
> -            'filename': BASE_DIR / 'logs/api.log',
> +            'filename': BUILDDIR / 'logs/api.log',
>              'when': 'D',
>              'interval': 1,
>              'backupCount': 10,
> @@ -126,7 +128,7 @@ LOGGING_SETTINGS =3D {
>          'file_toaster': {
>              'level': 'INFO',
>              'class': 'logging.handlers.TimedRotatingFileHandler',
> -            'filename': BASE_DIR / 'logs/toaster.log',
> +            'filename': BUILDDIR / 'logs/toaster.log',
>              'when': 'D',
>              'interval': 1,
>              'backupCount': 10,
> diff --git a/bitbake/lib/toaster/toastermain/settings.py
> b/bitbake/lib/toaster/toastermain/settings.py
> index b083cf5885..50b873cb49 100644
> --- a/bitbake/lib/toaster/toastermain/settings.py
> +++ b/bitbake/lib/toaster/toastermain/settings.py
> @@ -316,12 +316,13 @@ for t in os.walk(os.path.dirname(currentdir)):
>  LOGGING =3D LOGGING_SETTINGS
>
>  # Build paths inside the project like this: BASE_DIR / 'subdir'.
> -BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
> +#BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
> +BUILDDIR =3D os.environ.get("BUILDDIR")
>
>  # LOG VIEWER
>  # https://pypi.org/project/django-log-viewer/
>  LOG_VIEWER_FILES_PATTERN =3D '*.log*'
> -LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, 'logs')
> +LOG_VIEWER_FILES_DIR =3D os.path.join(BUILDDIR, 'logs')
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
> View/Reply Online (#15287):
> https://lists.openembedded.org/g/bitbake-devel/message/15287
> Mute This Topic: https://lists.openembedded.org/mt/102200280/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000f20a3806089fe87d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This series should be squashed into one commit and cleaned=
 up a bit. This was just a work-in-progress branch from me and not intended=
 to be the final version.</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Oct 26, 2023 at 7:05=E2=80=AFAM Alassane Y=
attara &lt;<a href=3D"mailto:alassane.yattara@savoirfairelinux.com">alassan=
e.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">From: Tim Orling &lt;<a href=3D"mailto:tim.or=
ling@konsulko.com" target=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
<br>
toastermain: use BUILDDIR for logs<br>
<br>
Developer: Tim Orling<br>
Reviewer: Alassane Yattara<br>
<br>
Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com" ta=
rget=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br>
---<br>
=C2=A0bitbake/lib/toaster/toastermain/logs.py=C2=A0 =C2=A0 =C2=A0| 10 +++++=
+----<br>
=C2=A0bitbake/lib/toaster/toastermain/settings.py |=C2=A0 5 +++--<br>
=C2=A02 files changed, 9 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/bitbake/lib/toaster/toastermain/logs.py b/bitbake/lib/toaster/=
toastermain/logs.py<br>
index b4910e4432..db5d459f9b 100644<br>
--- a/bitbake/lib/toaster/toastermain/logs.py<br>
+++ b/bitbake/lib/toaster/toastermain/logs.py<br>
@@ -1,12 +1,14 @@<br>
=C2=A0#!/usr/bin/env python3<br>
=C2=A0# -*- coding: utf-8 -*-<br>
<br>
+import os<br>
=C2=A0import logging<br>
=C2=A0import json<br>
=C2=A0from pathlib import Path<br>
=C2=A0from django.http import HttpRequest<br>
<br>
-BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent<br>
+#BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent<br>
+BUILDDIR =3D os.environ.get(&quot;BUILDDIR&quot;)<br>
<br>
<br>
=C2=A0def log_api_request(request, response, view, logger_name=3D&#39;api&#=
39;):<br>
@@ -108,7 +110,7 @@ LOGGING_SETTINGS =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;file_django&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;level&#39;: &#39;INFO&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;class&#39;: &#39;loggi=
ng.handlers.TimedRotatingFileHandler&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BASE_DIR / &=
#39;logs/django.log&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BUILDDIR / &=
#39;logs/django.log&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;when&#39;: &#39;D&#39;=
,=C2=A0 # interval type<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;interval&#39;: 1,=C2=
=A0 # defaults to 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;backupCount&#39;: 10,=
=C2=A0 # how many files to keep<br>
@@ -117,7 +119,7 @@ LOGGING_SETTINGS =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;file_api&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;level&#39;: &#39;INFO&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;class&#39;: &#39;loggi=
ng.handlers.TimedRotatingFileHandler&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BASE_DIR / &=
#39;logs/api.log&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BUILDDIR / &=
#39;logs/api.log&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;when&#39;: &#39;D&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;interval&#39;: 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;backupCount&#39;: 10,<=
br>
@@ -126,7 +128,7 @@ LOGGING_SETTINGS =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;file_toaster&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;level&#39;: &#39;INFO&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;class&#39;: &#39;loggi=
ng.handlers.TimedRotatingFileHandler&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BASE_DIR / &=
#39;logs/toaster.log&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BUILDDIR / &=
#39;logs/toaster.log&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;when&#39;: &#39;D&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;interval&#39;: 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;backupCount&#39;: 10,<=
br>
diff --git a/bitbake/lib/toaster/toastermain/settings.py b/bitbake/lib/toas=
ter/toastermain/settings.py<br>
index b083cf5885..50b873cb49 100644<br>
--- a/bitbake/lib/toaster/toastermain/settings.py<br>
+++ b/bitbake/lib/toaster/toastermain/settings.py<br>
@@ -316,12 +316,13 @@ for t in os.walk(os.path.dirname(currentdir)):<br>
=C2=A0LOGGING =3D LOGGING_SETTINGS<br>
<br>
=C2=A0# Build paths inside the project like this: BASE_DIR / &#39;subdir&#3=
9;.<br>
-BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent<br>
+#BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent<br>
+BUILDDIR =3D os.environ.get(&quot;BUILDDIR&quot;)<br>
<br>
=C2=A0# LOG VIEWER<br>
=C2=A0# <a href=3D"https://pypi.org/project/django-log-viewer/" rel=3D"nore=
ferrer" target=3D"_blank">https://pypi.org/project/django-log-viewer/</a><b=
r>
=C2=A0LOG_VIEWER_FILES_PATTERN =3D &#39;*.log*&#39;<br>
-LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, &#39;logs&#39;)<br>
+LOG_VIEWER_FILES_DIR =3D os.path.join(BUILDDIR, &#39;logs&#39;)<br>
=C2=A0LOG_VIEWER_PAGE_LENGTH =3D 25=C2=A0 =C2=A0 =C2=A0 # total log lines p=
er-page<br>
=C2=A0LOG_VIEWER_MAX_READ_LINES =3D 100000=C2=A0 # total log lines will be =
read<br>
=C2=A0LOG_VIEWER_PATTERNS =3D [&#39;INFO&#39;, &#39;DEBUG&#39;, &#39;WARNIN=
G&#39;, &#39;ERROR&#39;, &#39;CRITICAL&#39;]<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15287): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15287" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15287</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102200280/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102200280/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000f20a3806089fe87d--

