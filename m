Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18E7C25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 17:54:28 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
 by mx.groups.io with SMTP id smtpd.web10.207371.1698342865427634650
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 10:54:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IBcIx1mW;
 spf=pass (domain: gmail.com, ip: 209.85.161.43, mailfrom: ticotimo@gmail.com)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-581ed744114so639531eaf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698342864; x=1698947664; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xr6ItwneL1sxpl9Z/JW534//pX2LJ2SQiLb2D207OsY=;
        b=IBcIx1mWQjiMiN75UxXBx2cg4bNwqyOVVmjd2XGJKsbsXDtNIk+onx/ASbY8X9+DBG
         ka+dM3wCQUFbAeNV264a4R4mjHGDobyQ/WurQYreezZ6RagvY1jIY0DoL296m4pgem4g
         V+TEzBMU5Abuum3lyFBKWHmZA8qT67SDhDkg63GHzhgN5vpDUuYMwG9WlUBpmuZAHBS0
         m5Bi1rzOK03KCfGX140y9Kr+DVkwafny0K26+uJtb/N0zECNTjeTSLDTooL8+YFGjKTI
         Sd3b85ek9J28+56S9s4QZe4He8PzvAVakVGT8bOzBHJgQopEvh2OKuIuR74VhhZ3fGRk
         nvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698342864; x=1698947664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xr6ItwneL1sxpl9Z/JW534//pX2LJ2SQiLb2D207OsY=;
        b=YG+esHsjVRbzNK/DtfT8YxPPPVBDJm56qBHqO7qz1ySMYGJVYcqcbQblADBhuSsPiL
         4ZJ44TxgoSGOvaMBNycgJCerJpApF0y9KVZItT881wgzrvHal69yeEatDzUAG1GarNhO
         LSuFKAnnZeeE+NhnbbWfNdg64mr5B+iugfdIJ3uiNFWoXSn9scPLgqyhTDxnXzvR3iyP
         bOnFDlukTfZlXKUJGwMSmotKGH73fOGMC9IUyKYzfaozteIL+QYAsRmB0ycZ0UEmC2xu
         SqO0nCz4wl83qFIGPGcpGKBz+9P7vwcc3mkJ96vVU5M5Uz1FA3PuJ1jRFxXEOQgVuyz1
         GKeQ==
X-Gm-Message-State: AOJu0YzsE6X1uT9QG3RzTFsIjb853M+afAwnMuiWhIn+vU4y4bZC2zQi
	qqshuthFdczc2+Q1OBfwrRXZ6Ul5ttcsWeKYDSo=
X-Google-Smtp-Source: AGHT+IFyPhICEro6v9Pjr/kJZDJBGzdjmuM/SN93A2FWhflSBbvBZrPyJ/Zx43rx9VUm0oNtJkQXG2WhhBCxtr0nMJE=
X-Received: by 2002:a05:6870:61ce:b0:1e9:b08d:69f0 with SMTP id
 b14-20020a05687061ce00b001e9b08d69f0mr295077oah.51.1698342864413; Thu, 26 Oct
 2023 10:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <1791B341DCBB88FE.20272@lists.yoctoproject.org>
In-Reply-To: <1791B341DCBB88FE.20272@lists.yoctoproject.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Thu, 26 Oct 2023 10:54:13 -0700
Message-ID: <CANx9H-B_VfuVxHqK7F3M7+zy1OH0Thv41ZAZHCXUn_Nttpof9g@mail.gmail.com>
Subject: Re: [Toaster] [PATCH] toaster: write logs to BUILDDIR
To: alassane.yattara@savoirfairelinux.com
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org, 
	Tim Orling <tim.orling@konsulko.com>
Content-Type: multipart/alternative; boundary="00000000000023e7a60608a2431e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 17:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15296

--00000000000023e7a60608a2431e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

--00000000000023e7a60608a2431e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Allassane,<div><br></div><div>At least when running in the=
 toaster-container, I&#39;m seeing no logs, but links like &quot;conf/toast=
er_api.log&quot;, but that file doesn&#39;t exist and is not downloadable.<=
/div><div><br></div><div>I tried a couple other changes on:</div><div><a hr=
ef=3D"https://git.yoctoproject.org/poky-contrib/log/?h=3Dtimo/toaster-loggi=
ng-v3">https://git.yoctoproject.org/poky-contrib/log/?h=3Dtimo/toaster-logg=
ing-v3</a><br></div><div>(one of which was present in your series earlier t=
oday).</div><div><br></div><div>But I don&#39;t have experience with the lo=
g_viewer plugin and I&#39;m not sure what is happening to cause the &quot;c=
onf/&quot; to be prepended to the log links in the admin interface.</div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Thu, Oct 26, 2023 at 8:53=E2=80=AFAM Tim Orling via <a href=3D"http://list=
s.yoctoproject.org">lists.yoctoproject.org</a> &lt;ticotimo=3D<a href=3D"ma=
ilto:gmail.com@lists.yoctoproject.org">gmail.com@lists.yoctoproject.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fixe=
s &quot;2efb14648 toaster: Monitoring - implement Django logging system&quo=
t; when<br>
running in a container.<br>
<br>
When running in a container, the previous approach of using BASE_DIR<br>
is not a writable path. Also, we really do not want to be writing logs into=
<br>
the source tree, as the BASE_DIR was resolving to bitbake/lib/toaster/logs<=
br>
<br>
Since Toaster is only ever running in an environment where oe-init-buildenv=
<br>
or similar has been sourced, we should instead write the logs to BUILDDIR.<=
br>
This is where the existing toaster_ui.log was already being written.<br>
<br>
Drop the /logs/ directory, as it has not been created which also breaks<br>
in a container environment. Instead, prepend the api.log, etc. with &quot;t=
oaster_&quot;<br>
and write them alongside the existing toaster_ui.log<br>
<br>
Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com" ta=
rget=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
---<br>
=C2=A0lib/toaster/toastermain/logs.py=C2=A0 =C2=A0 =C2=A0| 9 +++++----<br>
=C2=A0lib/toaster/toastermain/settings.py | 7 ++++---<br>
=C2=A02 files changed, 9 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/lib/toaster/toastermain/logs.py b/lib/toaster/toastermain/logs=
.py<br>
index b4910e443..5a296bc3f 100644<br>
--- a/lib/toaster/toastermain/logs.py<br>
+++ b/lib/toaster/toastermain/logs.py<br>
@@ -1,12 +1,13 @@<br>
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
+BUILDDIR =3D Path(os.environ.get(&#39;BUILDDIR&#39;))<br>
<br>
<br>
=C2=A0def log_api_request(request, response, view, logger_name=3D&#39;api&#=
39;):<br>
@@ -108,7 +109,7 @@ LOGGING_SETTINGS =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;file_django&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;level&#39;: &#39;INFO&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;class&#39;: &#39;loggi=
ng.handlers.TimedRotatingFileHandler&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BASE_DIR / &=
#39;logs/django.log&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BUILDDIR / &=
#39;toaster_django.log&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;when&#39;: &#39;D&#39;=
,=C2=A0 # interval type<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;interval&#39;: 1,=C2=
=A0 # defaults to 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;backupCount&#39;: 10,=
=C2=A0 # how many files to keep<br>
@@ -117,7 +118,7 @@ LOGGING_SETTINGS =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;file_api&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;level&#39;: &#39;INFO&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;class&#39;: &#39;loggi=
ng.handlers.TimedRotatingFileHandler&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BASE_DIR / &=
#39;logs/api.log&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BUILDDIR / &=
#39;toaster_api.log&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;when&#39;: &#39;D&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;interval&#39;: 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;backupCount&#39;: 10,<=
br>
@@ -126,7 +127,7 @@ LOGGING_SETTINGS =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;file_toaster&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;level&#39;: &#39;INFO&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;class&#39;: &#39;loggi=
ng.handlers.TimedRotatingFileHandler&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BASE_DIR / &=
#39;logs/toaster.log&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BUILDDIR / &=
#39;toaster.log&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;when&#39;: &#39;D&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;interval&#39;: 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;backupCount&#39;: 10,<=
br>
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/=
settings.py<br>
index b083cf588..c65f4b630 100644<br>
--- a/lib/toaster/toastermain/settings.py<br>
+++ b/lib/toaster/toastermain/settings.py<br>
@@ -315,13 +315,14 @@ for t in os.walk(os.path.dirname(currentdir)):<br>
=C2=A0# more details on how to customize your logging configuration.<br>
=C2=A0LOGGING =3D LOGGING_SETTINGS<br>
<br>
-# Build paths inside the project like this: BASE_DIR / &#39;subdir&#39;.<b=
r>
-BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent<br>
+# Rather than using BASE_DIR inside the source tree, we use<br>
+# BUILDDIR which is exported by the bitbake environment<br>
+BUILDDIR =3D os.environ.get(&quot;BUILDDIR&quot;)<br>
<br>
=C2=A0# LOG VIEWER<br>
=C2=A0# <a href=3D"https://pypi.org/project/django-log-viewer/" rel=3D"nore=
ferrer" target=3D"_blank">https://pypi.org/project/django-log-viewer/</a><b=
r>
=C2=A0LOG_VIEWER_FILES_PATTERN =3D &#39;*.log*&#39;<br>
-LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, &#39;logs&#39;)<br>
+LOG_VIEWER_FILES_DIR =3D BUILDDIR<br>
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
View/Reply Online (#5896): <a href=3D"https://lists.yoctoproject.org/g/toas=
ter/message/5896" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctop=
roject.org/g/toaster/message/5896</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/102202795/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/102202795/924729</a><br>
Group Owner: <a href=3D"mailto:toaster%2Bowner@lists.yoctoproject.org" targ=
et=3D"_blank">toaster+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/toaster/unsub" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/toaster/=
unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo=
@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--00000000000023e7a60608a2431e--

