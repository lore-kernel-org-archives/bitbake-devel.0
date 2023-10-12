Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87796CDB46E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 04:35:09 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web10.4425.1697085308878979122
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Oct 2023 21:35:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JDZx6GQP;
 spf=pass (domain: gmail.com, ip: 209.85.219.170, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d77ad095f13so523293276.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Oct 2023 21:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697085308; x=1697690108; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8LZfJdST6SNtB2vpfp9eDiVoqMd9f6dUzPGsNeNGWMM=;
        b=JDZx6GQP5FSftlUVKH7qzKHneRiqnvc6P683C9Zdd23UjoSZupThQedlLwUBTC7/PQ
         YHrTXQKidR77P7s+Cb0ykVtyHbHyC8z+u3GydYgaHv7iszCjRIn2DAHlFyjPhEhPEi/O
         4BC2ouX5c0Mk1YV0OlHrlpfl1zBkuoycyjfiJy207EMKxgNrx0S9o4L1DixP+hX2bPgl
         lkJyFQVhZdf/Q4XLuvMwK4h/XUe9SY137EXDS1whDutDhd5PX2EZp+2KQBbvD4Y719bv
         6Et+bx7sS3jpvsYWF+CqRXqTZmPXsfbrslLj+S6xagcn5By3/l8P8hJWDo6Spd0nacfm
         1Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697085308; x=1697690108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LZfJdST6SNtB2vpfp9eDiVoqMd9f6dUzPGsNeNGWMM=;
        b=Y3OZwrK28N74z53fL2fvK4pFPtFvNiIbYIoAaxrDhDJraBwdtky3NcbGCKZL18hckO
         C4AorOzFZnzEguEgOdpHghyYDvdcc2L0g6XpB4FHnx68K2sZBWUYFLphhPMLnYuvKAcE
         OhdasdQiVH1HU1dY+1BUtYQqTO+aHVqXHL6wKzdbJkwiKGY1EgMoGNbADynvX36RF+fJ
         FU6r8z0GfcauPiRyrGpxa/bwWgGU42yr/wpr5HOr1/3H8UHixGjG4HXuHE/QYlJJPk5u
         hKYy+NIhjaTOD5kyXOed7rdqkWKm3wcJUdgA71wfXccFatbQt59b5CPGDmINOCGsvuu1
         HvYQ==
X-Gm-Message-State: AOJu0YzUGzY4ulEsudM/Tj7i7Pq485iBTT/Nk3SvvBLRss0jjnIUUtqw
	dzab4W2SQPDjteWqU95snogngaoLqAqvYhQkFdYpZ6jwMv4=
X-Google-Smtp-Source: AGHT+IEWMW0bSXJChjDv6QRDNJCBVuYMcLwSZ95N5V9/RhMmV0IFiMeS2GWWVxkUTvpZvJ9erJ7fz7RTQqwEhGomhlE=
X-Received: by 2002:a25:ce85:0:b0:d9a:3d01:cea7 with SMTP id
 x127-20020a25ce85000000b00d9a3d01cea7mr9030427ybe.56.1697085307763; Wed, 11
 Oct 2023 21:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231004134415.11070-1-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231004134415.11070-1-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Wed, 11 Oct 2023 21:34:56 -0700
Message-ID: <CANx9H-C-q9YDsryXxgipO-to-B1t=fYO=Q2cvvpmiVGPn-obsQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] toaster: Monitoring - implement Django
 logging system
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ec455606077d764b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 04:35:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15212

--000000000000ec455606077d764b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

i think this introduces a missing dependency in toaster-requirements.txt on
django-log-viewer or similar, as there is now a failure on
https://github.com/crops/toaster-container for "master"
03:55:49 E: 0.862   File "<frozen importlib._bootstrap>", line 1014, in
_gcd_import
03:55:49 E: 0.862   File "<frozen importlib._bootstrap>", line 991, in
_find_and_load
03:55:49 E: 0.862   File "<frozen importlib._bootstrap>", line 973, in
_find_and_load_unlocked
03:55:49 E: 0.862 ModuleNotFoundError: No module named 'log_viewer'"
"


On Wed, Oct 4, 2023 at 6:45=E2=80=AFAM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> ---
>  lib/toaster/bldcollector/views.py   |   3 +
>  lib/toaster/logs/.gitignore         |   1 +
>  lib/toaster/toastergui/views.py     |   7 ++
>  lib/toaster/toastergui/widgets.py   |   4 +
>  lib/toaster/toastermain/logs.py     | 153 ++++++++++++++++++++++++++++
>  lib/toaster/toastermain/settings.py |  66 +++++-------
>  lib/toaster/toastermain/urls.py     |   2 +
>  7 files changed, 198 insertions(+), 38 deletions(-)
>  create mode 100644 lib/toaster/logs/.gitignore
>  create mode 100644 lib/toaster/toastermain/logs.py
>
> diff --git a/lib/toaster/bldcollector/views.py
> b/lib/toaster/bldcollector/views.py
> index 04cd8b3d..bdf38ae6 100644
> --- a/lib/toaster/bldcollector/views.py
> +++ b/lib/toaster/bldcollector/views.py
> @@ -14,8 +14,11 @@ import subprocess
>  import toastermain
>  from django.views.decorators.csrf import csrf_exempt
>
> +from toastermain.logs import log_view_mixin
> +
>
>  @csrf_exempt
> +@log_view_mixin
>  def eventfile(request):
>      """ Receives a file by POST, and runs toaster-eventreply on this fil=
e
> """
>      if request.method !=3D "POST":
> diff --git a/lib/toaster/logs/.gitignore b/lib/toaster/logs/.gitignore
> new file mode 100644
> index 00000000..e5ebf25a
> --- /dev/null
> +++ b/lib/toaster/logs/.gitignore
> @@ -0,0 +1 @@
> +*.log*
> diff --git a/lib/toaster/toastergui/views.py
> b/lib/toaster/toastergui/views.py
> index 552ff164..cc8517ba 100644
> --- a/lib/toaster/toastergui/views.py
> +++ b/lib/toaster/toastergui/views.py
> @@ -34,6 +34,8 @@ import mimetypes
>
>  import logging
>
> +from toastermain.logs import log_view_mixin
> +
>  logger =3D logging.getLogger("toaster")
>
>  # Project creation and managed build enable
> @@ -56,6 +58,7 @@ class MimeTypeFinder(object):
>          return guessed_type
>
>  # single point to add global values into the context before rendering
> +@log_view_mixin
>  def toaster_render(request, page, context):
>      context['project_enable'] =3D project_enable
>      context['project_specific'] =3D is_project_specific
> @@ -665,6 +668,7 @@ def recipe_packages(request, build_id, recipe_id):
>      return response
>
>  from django.http import HttpResponse
> +@log_view_mixin
>  def xhr_dirinfo(request, build_id, target_id):
>      top =3D request.GET.get('start', '/')
>      return HttpResponse(_get_dir_entries(build_id, target_id, top),
> content_type =3D "application/json")
> @@ -1612,6 +1616,7 @@ if True:
>
>      from django.views.decorators.csrf import csrf_exempt
>      @csrf_exempt
> +    @log_view_mixin
>      def xhr_testreleasechange(request, pid):
>          def response(data):
>              return HttpResponse(jsonfilter(data),
> @@ -1648,6 +1653,7 @@ if True:
>          except Exception as e:
>              return response({"error": str(e) })
>
> +    @log_view_mixin
>      def xhr_configvaredit(request, pid):
>          try:
>              prj =3D Project.objects.get(id =3D pid)
> @@ -1726,6 +1732,7 @@ if True:
>              return HttpResponse(json.dumps({"error":str(e) + "\n" +
> traceback.format_exc()}), content_type =3D "application/json")
>
>
> +    @log_view_mixin
>      def customrecipe_download(request, pid, recipe_id):
>          recipe =3D get_object_or_404(CustomImageRecipe, pk=3Drecipe_id)
>
> diff --git a/lib/toaster/toastergui/widgets.py
> b/lib/toaster/toastergui/widgets.py
> index 53696912..51ed153a 100644
> --- a/lib/toaster/toastergui/widgets.py
> +++ b/lib/toaster/toastergui/widgets.py
> @@ -32,6 +32,7 @@ import re
>  import os
>
>  from toastergui.tablefilter import TableFilterMap
> +from toastermain.logs import log_view_mixin
>
>  try:
>      from urllib import unquote_plus
> @@ -84,6 +85,7 @@ class ToasterTable(TemplateView):
>
>          return context
>
> +    @log_view_mixin
>      def get(self, request, *args, **kwargs):
>          if request.GET.get('format', None) =3D=3D 'json':
>
> @@ -414,6 +416,7 @@ class ToasterTypeAhead(View):
>      def __init__(self, *args, **kwargs):
>          super(ToasterTypeAhead, self).__init__()
>
> +    @log_view_mixin
>      def get(self, request, *args, **kwargs):
>          def response(data):
>              return HttpResponse(json.dumps(data,
> @@ -469,6 +472,7 @@ class MostRecentBuildsView(View):
>
>          return False
>
> +    @log_view_mixin
>      def get(self, request, *args, **kwargs):
>          """
>          Returns a list of builds in JSON format.
> diff --git a/lib/toaster/toastermain/logs.py
> b/lib/toaster/toastermain/logs.py
> new file mode 100644
> index 00000000..f9953982
> --- /dev/null
> +++ b/lib/toaster/toastermain/logs.py
> @@ -0,0 +1,153 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +
> +import logging
> +import json
> +from pathlib import Path
> +from django.http import HttpRequest
> +
> +BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
> +
> +
> +def log_api_request(request, response, view, logger_name=3D'api'):
> +    """Helper function for LogAPIMixin"""
> +
> +    repjson =3D {
> +        'view': view,
> +        'path': request.path,
> +        'method': request.method,
> +        'status': response.status_code
> +    }
> +
> +    logger =3D logging.getLogger(logger_name)
> +    logger.info(
> +        json.dumps(repjson, indent=3D4, separators=3D(", ", " : "))
> +    )
> +
> +
> +def log_view_mixin(view):
> +    def log_view_request(*args, **kwargs):
> +        # get request from args else kwargs
> +        request =3D None
> +        if len(args) > 0:
> +            for req in args:
> +                if isinstance(req, HttpRequest):
> +                    request =3D req
> +                    break
> +        elif request is None:
> +            request =3D kwargs.get('request')
> +
> +        response =3D view(*args, **kwargs)
> +        log_api_request(
> +            request, response, request.resolver_match.view_name,
> 'toaster')
> +        return response
> +    return log_view_request
> +
> +
> +
> +class LogAPIMixin:
> +    """Logs API requests
> +
> +    tested with:
> +        - APIView
> +        - ModelViewSet
> +        - ReadOnlyModelViewSet
> +        - GenericAPIView
> +
> +    Note: you can set `view_name` attribute in View to override
> get_view_name()
> +    """
> +
> +    def get_view_name(self):
> +        if hasattr(self, 'view_name'):
> +            return self.view_name
> +        return super().get_view_name()
> +
> +    def finalize_response(self, request, response, *args, **kwargs):
> +        log_api_request(request, response, self.get_view_name())
> +        return super().finalize_response(request, response, *args,
> **kwargs)
> +
> +
> +LOGGING_SETTINGS =3D {
> +    'version': 1,
> +    'disable_existing_loggers': False,
> +    'filters': {
> +        'require_debug_false': {
> +            '()': 'django.utils.log.RequireDebugFalse'
> +        }
> +    },
> +    'formatters': {
> +        'datetime': {
> +            'format': '%(asctime)s %(levelname)s %(message)s'
> +        },
> +        'verbose': {
> +            'format': '{levelname} {asctime} {module} {name}.{funcName}
> {process:d} {thread:d} {message}',
> +            'datefmt': "%d/%b/%Y %H:%M:%S",
> +            'style': '{',
> +        },
> +        'api': {
> +            'format': '\n{levelname} {asctime}
> {name}.{funcName}:\n{message}',
> +            'style': '{'
> +        }
> +    },
> +    'handlers': {
> +        'mail_admins': {
> +            'level': 'ERROR',
> +            'filters': ['require_debug_false'],
> +            'class': 'django.utils.log.AdminEmailHandler'
> +        },
> +        'console': {
> +            'level': 'DEBUG',
> +            'class': 'logging.StreamHandler',
> +            'formatter': 'datetime',
> +        },
> +        'file_django': {
> +            'level': 'INFO',
> +            'class': 'logging.handlers.TimedRotatingFileHandler',
> +            'filename': BASE_DIR / 'logs/django.log',
> +            'when': 'D',  # interval type
> +            'interval': 1,  # defaults to 1
> +            'backupCount': 10,  # how many files to keep
> +            'formatter': 'verbose',
> +        },
> +        'file_api': {
> +            'level': 'INFO',
> +            'class': 'logging.handlers.TimedRotatingFileHandler',
> +            'filename': BASE_DIR / 'logs/api.log',
> +            'when': 'D',
> +            'interval': 1,
> +            'backupCount': 10,
> +            'formatter': 'verbose',
> +        },
> +        'file_toaster': {
> +            'level': 'INFO',
> +            'class': 'logging.handlers.TimedRotatingFileHandler',
> +            'filename': BASE_DIR / 'logs/toaster.log',
> +            'when': 'D',
> +            'interval': 1,
> +            'backupCount': 10,
> +            'formatter': 'verbose',
> +        },
> +    },
> +    'loggers': {
> +        'django.request': {
> +            'handlers': ['file_django', 'console'],
> +            'level': 'WARN',
> +            'propagate': True,
> +        },
> +        'django': {
> +            'handlers': ['file_django', 'console'],
> +            'level': 'WARNING',
> +            'propogate': True,
> +        },
> +        'toaster': {
> +            'handlers': ['file_toaster'],
> +            'level': 'INFO',
> +            'propagate': False,
> +        },
> +        'api': {
> +            'handlers': ['file_api'],
> +            'level': 'INFO',
> +            'propagate': False,
> +        }
> +    }
> +}
> diff --git a/lib/toaster/toastermain/settings.py
> b/lib/toaster/toastermain/settings.py
> index 609c85d9..b083cf58 100644
> --- a/lib/toaster/toastermain/settings.py
> +++ b/lib/toaster/toastermain/settings.py
> @@ -9,6 +9,8 @@
>  # Django settings for Toaster project.
>
>  import os
> +from pathlib import Path
> +from toastermain.logs import LOGGING_SETTINGS
>
>  DEBUG =3D True
>
> @@ -186,7 +188,13 @@ TEMPLATES =3D [
>                  'django.template.loaders.app_directories.Loader',
>                  #'django.template.loaders.eggs.Loader',
>              ],
> -            'string_if_invalid': InvalidString("%s"),
> +            #
> https://docs.djangoproject.com/en/4.2/ref/templates/api/#how-invalid-vari=
ables-are-handled
> +            # Generally, string_if_invalid should only be enabled in
> order to debug
> +            # a specific template problem, then cleared once debugging i=
s
> complete.
> +            # If you assign a value other than '' to string_if_invalid,
> +            # you will experience rendering problems with these template=
s
> and sites.
> +            #  'string_if_invalid': InvalidString("%s"),
> +            'string_if_invalid': "",
>              'debug': DEBUG,
>          },
>      },
> @@ -242,6 +250,9 @@ INSTALLED_APPS =3D (
>      'django.contrib.humanize',
>      'bldcollector',
>      'toastermain',
> +
> +    # 3rd-lib
> +    "log_viewer",
>  )
>
>
> @@ -302,43 +313,22 @@ for t in os.walk(os.path.dirname(currentdir)):
>  # the site admins on every HTTP 500 error when DEBUG=3DFalse.
>  # See http://docs.djangoproject.com/en/dev/topics/logging for
>  # more details on how to customize your logging configuration.
> -LOGGING =3D {
> -    'version': 1,
> -    'disable_existing_loggers': False,
> -    'filters': {
> -        'require_debug_false': {
> -            '()': 'django.utils.log.RequireDebugFalse'
> -        }
> -    },
> -    'formatters': {
> -        'datetime': {
> -            'format': '%(asctime)s %(levelname)s %(message)s'
> -        }
> -    },
> -    'handlers': {
> -        'mail_admins': {
> -            'level': 'ERROR',
> -            'filters': ['require_debug_false'],
> -            'class': 'django.utils.log.AdminEmailHandler'
> -        },
> -        'console': {
> -            'level': 'DEBUG',
> -            'class': 'logging.StreamHandler',
> -            'formatter': 'datetime',
> -        }
> -    },
> -    'loggers': {
> -        'toaster' : {
> -            'handlers': ['console'],
> -            'level': 'DEBUG',
> -        },
> -        'django.request': {
> -            'handlers': ['console'],
> -            'level': 'WARN',
> -            'propagate': True,
> -        },
> -    }
> -}
> +LOGGING =3D LOGGING_SETTINGS
> +
> +# Build paths inside the project like this: BASE_DIR / 'subdir'.
> +BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
> +
> +# LOG VIEWER
> +# https://pypi.org/project/django-log-viewer/
> +LOG_VIEWER_FILES_PATTERN =3D '*.log*'
> +LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, 'logs')
> +LOG_VIEWER_PAGE_LENGTH =3D 25      # total log lines per-page
> +LOG_VIEWER_MAX_READ_LINES =3D 100000  # total log lines will be read
> +LOG_VIEWER_PATTERNS =3D ['INFO', 'DEBUG', 'WARNING', 'ERROR', 'CRITICAL'=
]
> +
> +# Optionally you can set the next variables in order to customize the
> admin:
> +LOG_VIEWER_FILE_LIST_TITLE =3D "Logs list"
> +
>
>  if DEBUG and SQL_DEBUG:
>      LOGGING['loggers']['django.db.backends'] =3D {
> diff --git a/lib/toaster/toastermain/urls.py
> b/lib/toaster/toastermain/urls.py
> index 03603026..3be46fcf 100644
> --- a/lib/toaster/toastermain/urls.py
> +++ b/lib/toaster/toastermain/urls.py
> @@ -28,6 +28,8 @@ urlpatterns =3D [
>      # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
>
>
> +    url(r'^logs/', include('log_viewer.urls')),
> +
>      # This is here to maintain backward compatibility and will be
> deprecated
>      # in the future.
>      url(r'^orm/eventfile$', bldcollector.views.eventfile),
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15184):
> https://lists.openembedded.org/g/bitbake-devel/message/15184
> Mute This Topic: https://lists.openembedded.org/mt/101755228/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000ec455606077d764b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>i think this introduces a missing dependency in toast=
er-requirements.txt on django-log-viewer or similar, as there is now a fail=
ure on <a href=3D"https://github.com/crops/toaster-container">https://githu=
b.com/crops/toaster-container</a> for &quot;master&quot;</div><div>03:55:49=
 E: 0.862 =C2=A0 File &quot;&lt;frozen importlib._bootstrap&gt;&quot;, line=
 1014, in _gcd_import<br>03:55:49 E: 0.862 =C2=A0 File &quot;&lt;frozen imp=
ortlib._bootstrap&gt;&quot;, line 991, in _find_and_load<br>03:55:49 E: 0.8=
62 =C2=A0 File &quot;&lt;frozen importlib._bootstrap&gt;&quot;, line 973, i=
n _find_and_load_unlocked<br>03:55:49 E: 0.862 ModuleNotFoundError: No modu=
le named &#39;log_viewer&#39;&quot;<br></div><div>&quot;</div><div><br></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On W=
ed, Oct 4, 2023 at 6:45=E2=80=AFAM Alassane Yattara &lt;<a href=3D"mailto:a=
lassane.yattara@savoirfairelinux.com">alassane.yattara@savoirfairelinux.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
---<br>
=C2=A0lib/toaster/bldcollector/views.py=C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0lib/toaster/logs/.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A01 +<br>
=C2=A0lib/toaster/toastergui/views.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 ++=
<br>
=C2=A0lib/toaster/toastergui/widgets.py=C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0lib/toaster/toastermain/logs.py=C2=A0 =C2=A0 =C2=A0| 153 ++++++++++++=
++++++++++++++++<br>
=C2=A0lib/toaster/toastermain/settings.py |=C2=A0 66 +++++-------<br>
=C2=A0lib/toaster/toastermain/urls.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<=
br>
=C2=A07 files changed, 198 insertions(+), 38 deletions(-)<br>
=C2=A0create mode 100644 lib/toaster/logs/.gitignore<br>
=C2=A0create mode 100644 lib/toaster/toastermain/logs.py<br>
<br>
diff --git a/lib/toaster/bldcollector/views.py b/lib/toaster/bldcollector/v=
iews.py<br>
index 04cd8b3d..bdf38ae6 100644<br>
--- a/lib/toaster/bldcollector/views.py<br>
+++ b/lib/toaster/bldcollector/views.py<br>
@@ -14,8 +14,11 @@ import subprocess<br>
=C2=A0import toastermain<br>
=C2=A0from django.views.decorators.csrf import csrf_exempt<br>
<br>
+from toastermain.logs import log_view_mixin<br>
+<br>
<br>
=C2=A0@csrf_exempt<br>
+@log_view_mixin<br>
=C2=A0def eventfile(request):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; Receives a file by POST, and runs to=
aster-eventreply on this file &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0if request.method !=3D &quot;POST&quot;:<br>
diff --git a/lib/toaster/logs/.gitignore b/lib/toaster/logs/.gitignore<br>
new file mode 100644<br>
index 00000000..e5ebf25a<br>
--- /dev/null<br>
+++ b/lib/toaster/logs/.gitignore<br>
@@ -0,0 +1 @@<br>
+*.log*<br>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views=
.py<br>
index 552ff164..cc8517ba 100644<br>
--- a/lib/toaster/toastergui/views.py<br>
+++ b/lib/toaster/toastergui/views.py<br>
@@ -34,6 +34,8 @@ import mimetypes<br>
<br>
=C2=A0import logging<br>
<br>
+from toastermain.logs import log_view_mixin<br>
+<br>
=C2=A0logger =3D logging.getLogger(&quot;toaster&quot;)<br>
<br>
=C2=A0# Project creation and managed build enable<br>
@@ -56,6 +58,7 @@ class MimeTypeFinder(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return guessed_type<br>
<br>
=C2=A0# single point to add global values into the context before rendering=
<br>
+@log_view_mixin<br>
=C2=A0def toaster_render(request, page, context):<br>
=C2=A0 =C2=A0 =C2=A0context[&#39;project_enable&#39;] =3D project_enable<br=
>
=C2=A0 =C2=A0 =C2=A0context[&#39;project_specific&#39;] =3D is_project_spec=
ific<br>
@@ -665,6 +668,7 @@ def recipe_packages(request, build_id, recipe_id):<br>
=C2=A0 =C2=A0 =C2=A0return response<br>
<br>
=C2=A0from django.http import HttpResponse<br>
+@log_view_mixin<br>
=C2=A0def xhr_dirinfo(request, build_id, target_id):<br>
=C2=A0 =C2=A0 =C2=A0top =3D request.GET.get(&#39;start&#39;, &#39;/&#39;)<b=
r>
=C2=A0 =C2=A0 =C2=A0return HttpResponse(_get_dir_entries(build_id, target_i=
d, top), content_type =3D &quot;application/json&quot;)<br>
@@ -1612,6 +1616,7 @@ if True:<br>
<br>
=C2=A0 =C2=A0 =C2=A0from django.views.decorators.csrf import csrf_exempt<br=
>
=C2=A0 =C2=A0 =C2=A0@csrf_exempt<br>
+=C2=A0 =C2=A0 @log_view_mixin<br>
=C2=A0 =C2=A0 =C2=A0def xhr_testreleasechange(request, pid):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def response(data):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return HttpResponse(jsonfil=
ter(data),<br>
@@ -1648,6 +1653,7 @@ if True:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return response({&quot;erro=
r&quot;: str(e) })<br>
<br>
+=C2=A0 =C2=A0 @log_view_mixin<br>
=C2=A0 =C2=A0 =C2=A0def xhr_configvaredit(request, pid):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prj =3D Project.objects.get=
(id =3D pid)<br>
@@ -1726,6 +1732,7 @@ if True:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return HttpResponse(json.du=
mps({&quot;error&quot;:str(e) + &quot;\n&quot; + traceback.format_exc()}), =
content_type =3D &quot;application/json&quot;)<br>
<br>
<br>
+=C2=A0 =C2=A0 @log_view_mixin<br>
=C2=A0 =C2=A0 =C2=A0def customrecipe_download(request, pid, recipe_id):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recipe =3D get_object_or_404(CustomImageR=
ecipe, pk=3Drecipe_id)<br>
<br>
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/wid=
gets.py<br>
index 53696912..51ed153a 100644<br>
--- a/lib/toaster/toastergui/widgets.py<br>
+++ b/lib/toaster/toastergui/widgets.py<br>
@@ -32,6 +32,7 @@ import re<br>
=C2=A0import os<br>
<br>
=C2=A0from toastergui.tablefilter import TableFilterMap<br>
+from toastermain.logs import log_view_mixin<br>
<br>
=C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0from urllib import unquote_plus<br>
@@ -84,6 +85,7 @@ class ToasterTable(TemplateView):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return context<br>
<br>
+=C2=A0 =C2=A0 @log_view_mixin<br>
=C2=A0 =C2=A0 =C2=A0def get(self, request, *args, **kwargs):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if request.GET.get(&#39;format&#39;, None=
) =3D=3D &#39;json&#39;:<br>
<br>
@@ -414,6 +416,7 @@ class ToasterTypeAhead(View):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, *args, **kwargs):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super(ToasterTypeAhead, self).__init__()<=
br>
<br>
+=C2=A0 =C2=A0 @log_view_mixin<br>
=C2=A0 =C2=A0 =C2=A0def get(self, request, *args, **kwargs):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def response(data):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return HttpResponse(json.du=
mps(data,<br>
@@ -469,6 +472,7 @@ class MostRecentBuildsView(View):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
<br>
+=C2=A0 =C2=A0 @log_view_mixin<br>
=C2=A0 =C2=A0 =C2=A0def get(self, request, *args, **kwargs):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Returns a list of builds in JSON format.<=
br>
diff --git a/lib/toaster/toastermain/logs.py b/lib/toaster/toastermain/logs=
.py<br>
new file mode 100644<br>
index 00000000..f9953982<br>
--- /dev/null<br>
+++ b/lib/toaster/toastermain/logs.py<br>
@@ -0,0 +1,153 @@<br>
+#!/usr/bin/env python3<br>
+# -*- coding: utf-8 -*-<br>
+<br>
+import logging<br>
+import json<br>
+from pathlib import Path<br>
+from django.http import HttpRequest<br>
+<br>
+BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent<br>
+<br>
+<br>
+def log_api_request(request, response, view, logger_name=3D&#39;api&#39;):=
<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Helper function for LogAPIMixin&quot;&quot=
;&quot;<br>
+<br>
+=C2=A0 =C2=A0 repjson =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;view&#39;: view,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;path&#39;: request.path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;method&#39;: request.method,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;status&#39;: response.status_code<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 logger =3D logging.getLogger(logger_name)<br>
+=C2=A0 =C2=A0 <a href=3D"http://logger.info" rel=3D"noreferrer" target=3D"=
_blank">logger.info</a>(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 json.dumps(repjson, indent=3D4, separators=3D(=
&quot;, &quot;, &quot; : &quot;))<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+<br>
+def log_view_mixin(view):<br>
+=C2=A0 =C2=A0 def log_view_request(*args, **kwargs):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # get request from args else kwargs<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 request =3D None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(args) &gt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for req in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(req,=
 HttpRequest):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 requ=
est =3D req<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif request is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 request =3D kwargs.get(&#39;requ=
est&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 response =3D view(*args, **kwargs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_api_request(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 request, response, request.resol=
ver_match.view_name, &#39;toaster&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return response<br>
+=C2=A0 =C2=A0 return log_view_request<br>
+<br>
+<br>
+<br>
+class LogAPIMixin:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Logs API requests<br>
+<br>
+=C2=A0 =C2=A0 tested with:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - APIView<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - ModelViewSet<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - ReadOnlyModelViewSet<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - GenericAPIView<br>
+<br>
+=C2=A0 =C2=A0 Note: you can set `view_name` attribute in View to override =
get_view_name()<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def get_view_name(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if hasattr(self, &#39;view_name&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.view_name<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return super().get_view_name()<br>
+<br>
+=C2=A0 =C2=A0 def finalize_response(self, request, response, *args, **kwar=
gs):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_api_request(request, response, self.get_vi=
ew_name())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return super().finalize_response(request, resp=
onse, *args, **kwargs)<br>
+<br>
+<br>
+LOGGING_SETTINGS =3D {<br>
+=C2=A0 =C2=A0 &#39;version&#39;: 1,<br>
+=C2=A0 =C2=A0 &#39;disable_existing_loggers&#39;: False,<br>
+=C2=A0 =C2=A0 &#39;filters&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;require_debug_false&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;()&#39;: &#39;django.utils.=
log.RequireDebugFalse&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 &#39;formatters&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;datetime&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;format&#39;: &#39;%(asctime=
)s %(levelname)s %(message)s&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;verbose&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;format&#39;: &#39;{levelnam=
e} {asctime} {module} {name}.{funcName} {process:d} {thread:d} {message}&#3=
9;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;datefmt&#39;: &quot;%d/%b/%=
Y %H:%M:%S&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;style&#39;: &#39;{&#39;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;api&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;format&#39;: &#39;\n{leveln=
ame} {asctime} {name}.{funcName}:\n{message}&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;style&#39;: &#39;{&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 &#39;handlers&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;mail_admins&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;ERROR&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filters&#39;: [&#39;require=
_debug_false&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;class&#39;: &#39;django.uti=
ls.log.AdminEmailHandler&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;console&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;DEBUG&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;class&#39;: &#39;logging.St=
reamHandler&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;formatter&#39;: &#39;dateti=
me&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;file_django&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;INFO&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;class&#39;: &#39;logging.ha=
ndlers.TimedRotatingFileHandler&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BASE_DIR / &=
#39;logs/django.log&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;when&#39;: &#39;D&#39;,=C2=
=A0 # interval type<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;interval&#39;: 1,=C2=A0 # d=
efaults to 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backupCount&#39;: 10,=C2=A0=
 # how many files to keep<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;formatter&#39;: &#39;verbos=
e&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;file_api&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;INFO&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;class&#39;: &#39;logging.ha=
ndlers.TimedRotatingFileHandler&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BASE_DIR / &=
#39;logs/api.log&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;when&#39;: &#39;D&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;interval&#39;: 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backupCount&#39;: 10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;formatter&#39;: &#39;verbos=
e&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;file_toaster&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;INFO&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;class&#39;: &#39;logging.ha=
ndlers.TimedRotatingFileHandler&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filename&#39;: BASE_DIR / &=
#39;logs/toaster.log&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;when&#39;: &#39;D&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;interval&#39;: 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;backupCount&#39;: 10,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;formatter&#39;: &#39;verbos=
e&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 &#39;loggers&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;django.request&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;handlers&#39;: [&#39;file_d=
jango&#39;, &#39;console&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;WARN&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;propagate&#39;: True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;django&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;handlers&#39;: [&#39;file_d=
jango&#39;, &#39;console&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;WARNING&#3=
9;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;propogate&#39;: True,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;toaster&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;handlers&#39;: [&#39;file_t=
oaster&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;INFO&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;propagate&#39;: False,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;api&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;handlers&#39;: [&#39;file_a=
pi&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;INFO&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;propagate&#39;: False,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/=
settings.py<br>
index 609c85d9..b083cf58 100644<br>
--- a/lib/toaster/toastermain/settings.py<br>
+++ b/lib/toaster/toastermain/settings.py<br>
@@ -9,6 +9,8 @@<br>
=C2=A0# Django settings for Toaster project.<br>
<br>
=C2=A0import os<br>
+from pathlib import Path<br>
+from toastermain.logs import LOGGING_SETTINGS<br>
<br>
=C2=A0DEBUG =3D True<br>
<br>
@@ -186,7 +188,13 @@ TEMPLATES =3D [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;django.t=
emplate.loaders.app_directories.Loader&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#&#39;django.=
template.loaders.eggs.Loader&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;string_if_invalid&#39;: Inv=
alidString(&quot;%s&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # <a href=3D"https://docs.django=
project.com/en/4.2/ref/templates/api/#how-invalid-variables-are-handled" re=
l=3D"noreferrer" target=3D"_blank">https://docs.djangoproject.com/en/4.2/re=
f/templates/api/#how-invalid-variables-are-handled</a><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generally, string_if_invalid s=
hould only be enabled in order to debug<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # a specific template problem, t=
hen cleared once debugging is complete.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # If you assign a value other th=
an &#39;&#39; to string_if_invalid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # you will experience rendering =
problems with these templates and sites.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 &#39;string_if_invalid&#=
39;: InvalidString(&quot;%s&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;string_if_invalid&#39;: &qu=
ot;&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;debug&#39;: DEBUG,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0},<br>
@@ -242,6 +250,9 @@ INSTALLED_APPS =3D (<br>
=C2=A0 =C2=A0 =C2=A0&#39;django.contrib.humanize&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;bldcollector&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;toastermain&#39;,<br>
+<br>
+=C2=A0 =C2=A0 # 3rd-lib<br>
+=C2=A0 =C2=A0 &quot;log_viewer&quot;,<br>
=C2=A0)<br>
<br>
<br>
@@ -302,43 +313,22 @@ for t in os.walk(os.path.dirname(currentdir)):<br>
=C2=A0# the site admins on every HTTP 500 error when DEBUG=3DFalse.<br>
=C2=A0# See <a href=3D"http://docs.djangoproject.com/en/dev/topics/logging"=
 rel=3D"noreferrer" target=3D"_blank">http://docs.djangoproject.com/en/dev/=
topics/logging</a> for<br>
=C2=A0# more details on how to customize your logging configuration.<br>
-LOGGING =3D {<br>
-=C2=A0 =C2=A0 &#39;version&#39;: 1,<br>
-=C2=A0 =C2=A0 &#39;disable_existing_loggers&#39;: False,<br>
-=C2=A0 =C2=A0 &#39;filters&#39;: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;require_debug_false&#39;: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;()&#39;: &#39;django.utils.=
log.RequireDebugFalse&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 },<br>
-=C2=A0 =C2=A0 &#39;formatters&#39;: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;datetime&#39;: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;format&#39;: &#39;%(asctime=
)s %(levelname)s %(message)s&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 },<br>
-=C2=A0 =C2=A0 &#39;handlers&#39;: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;mail_admins&#39;: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;ERROR&#39;=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;filters&#39;: [&#39;require=
_debug_false&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;class&#39;: &#39;django.uti=
ls.log.AdminEmailHandler&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;console&#39;: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;DEBUG&#39;=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;class&#39;: &#39;logging.St=
reamHandler&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;formatter&#39;: &#39;dateti=
me&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 },<br>
-=C2=A0 =C2=A0 &#39;loggers&#39;: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;toaster&#39; : {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;handlers&#39;: [&#39;consol=
e&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;DEBUG&#39;=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;django.request&#39;: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;handlers&#39;: [&#39;consol=
e&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;level&#39;: &#39;WARN&#39;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;propagate&#39;: True,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
+LOGGING =3D LOGGING_SETTINGS<br>
+<br>
+# Build paths inside the project like this: BASE_DIR / &#39;subdir&#39;.<b=
r>
+BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent<br>
+<br>
+# LOG VIEWER<br>
+# <a href=3D"https://pypi.org/project/django-log-viewer/" rel=3D"noreferre=
r" target=3D"_blank">https://pypi.org/project/django-log-viewer/</a><br>
+LOG_VIEWER_FILES_PATTERN =3D &#39;*.log*&#39;<br>
+LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, &#39;logs&#39;)<br>
+LOG_VIEWER_PAGE_LENGTH =3D 25=C2=A0 =C2=A0 =C2=A0 # total log lines per-pa=
ge<br>
+LOG_VIEWER_MAX_READ_LINES =3D 100000=C2=A0 # total log lines will be read<=
br>
+LOG_VIEWER_PATTERNS =3D [&#39;INFO&#39;, &#39;DEBUG&#39;, &#39;WARNING&#39=
;, &#39;ERROR&#39;, &#39;CRITICAL&#39;]<br>
+<br>
+# Optionally you can set the next variables in order to customize the admi=
n:<br>
+LOG_VIEWER_FILE_LIST_TITLE =3D &quot;Logs list&quot;<br>
+<br>
<br>
=C2=A0if DEBUG and SQL_DEBUG:<br>
=C2=A0 =C2=A0 =C2=A0LOGGING[&#39;loggers&#39;][&#39;django.db.backends&#39;=
] =3D {<br>
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls=
.py<br>
index 03603026..3be46fcf 100644<br>
--- a/lib/toaster/toastermain/urls.py<br>
+++ b/lib/toaster/toastermain/urls.py<br>
@@ -28,6 +28,8 @@ urlpatterns =3D [<br>
=C2=A0 =C2=A0 =C2=A0# url(r&#39;^admin/doc/&#39;, include(&#39;django.contr=
ib.admindocs.urls&#39;)),<br>
<br>
<br>
+=C2=A0 =C2=A0 url(r&#39;^logs/&#39;, include(&#39;log_viewer.urls&#39;)),<=
br>
+<br>
=C2=A0 =C2=A0 =C2=A0# This is here to maintain backward compatibility and w=
ill be deprecated<br>
=C2=A0 =C2=A0 =C2=A0# in the future.<br>
=C2=A0 =C2=A0 =C2=A0url(r&#39;^orm/eventfile$&#39;, bldcollector.views.even=
tfile),<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15184): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15184" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15184</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/101755228/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/101755228/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000ec455606077d764b--

