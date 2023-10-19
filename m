Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FEECDB482
	for <webhook@archiver.kernel.org>; Thu, 19 Oct 2023 18:01:52 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
 by mx.groups.io with SMTP id smtpd.web11.34915.1697738509797305694
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Oct 2023 11:01:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Of3i2w2L;
 spf=pass (domain: gmail.com, ip: 209.85.128.175, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a81ab75f21so85335867b3.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Oct 2023 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697738509; x=1698343309; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1S8Sb9TAGDjWYUvryvGqEdjag2E3Wm+7OehgshyhQc=;
        b=Of3i2w2LAQNvvg2QTrkrxy8BLqx+06zIuHTr54VjhRgdBLi+DQMdhUEmjdAjOOoKEL
         ZegfNqyvKqdsyGFR1Xp44EbkZ/eOgqctic5vmQO4W9el41uCeUTvkX7ooACap537ve5p
         VFjteLW/fRUR3GmFS1lfw+KoiRvJprMsRclhvxxK78a9bq4VdT4pVuyea148Qwmrw84J
         FP672r6CEns3jE2yp+X8Z9qifmbY40ekMEIOdRv1YwWMUZVFjnyp9qqvZeSCuusNYzPW
         CIBNX+j3R7EmXDtn/ZChOqsZgN1DHq5h69L4GNEBdR+ninIYXkgtQrORzSiKTGZs4E05
         PSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697738509; x=1698343309;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1S8Sb9TAGDjWYUvryvGqEdjag2E3Wm+7OehgshyhQc=;
        b=RAcvVnbYMcSER+kQscvILbr2Il+MFhoAIiyLoVBJN1SbJA3hSA0i1Chro4fJxSakcS
         UhRNCIJ7ErmiqzufXkb2Lh67mW+USHbHyPdkvAM60BDCqrmNMB65RW/sfyOHNz9Gw3nu
         FckYEw4XRlq8s2V7E6QNJ78FS5AIj9Oig/vdWFQ2OE92FM/b1Ab+BrRE+41w2M7DxJtW
         AJqiQCijbjk5OTG67ZGLet0N0AXpxwginkhulSRd5Oa+kvzv5ApV4KC8YyG6hopUZT8I
         V0Q3Os1IUcl8aUyc4/MSgDSJgROrqKg5TsXUREB2QsY5B7gR9UE5k+D4Lc4TaxRCfVMh
         hNEA==
X-Gm-Message-State: AOJu0YxpFKtaLPh7bhGhjyCffCnPEb/+P9oz2RsaAoaO71EI7MiK4+Sj
	R0V+muK4ljVOCGjc7yrbBcxsPhDeX3DxDdxLRAs=
X-Google-Smtp-Source: AGHT+IF2R1ysulCLKytrLfD1zc2Y1MxPrCazaSVD/rkeWEqxy0B1PlMQPlyYShyGad6q49WLFsCE3wG/UvooPyyFT/Y=
X-Received: by 2002:a81:4996:0:b0:5a8:3550:61b2 with SMTP id
 w144-20020a814996000000b005a8355061b2mr3250342ywa.29.1697738508651; Thu, 19
 Oct 2023 11:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231004134415.11070-1-alassane.yattara@savoirfairelinux.com>
 <178D4218DDB89A92.29357@lists.openembedded.org> <CANx9H-AsiPDOTScyii-FmBzWJQterFaE4bZSrSO+iTVkyQiwXg@mail.gmail.com>
 <479117960.680150.1697734280326.JavaMail.zimbra@savoirfairelinux.com> <178F917CE0158B76.20272@lists.yoctoproject.org>
In-Reply-To: <178F917CE0158B76.20272@lists.yoctoproject.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Thu, 19 Oct 2023 11:01:37 -0700
Message-ID: <CANx9H-Bi9eQJ=KnO0=hKaBzqYyYcYiWNjjwDoZcUqeRwf9C-qA@mail.gmail.com>
Subject: Re: [Toaster] [bitbake-devel] [PATCH] toaster: Monitoring - implement
 Django logging system
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000bad1380608158c63"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Oct 2023 18:01:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15267

--000000000000bad1380608158c63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 10:12=E2=80=AFAM Tim Orling via lists.yoctoproject.=
org
<ticotimo=3Dgmail.com@lists.yoctoproject.org> wrote:

> Let me take a moment to say how great it is to have other folks looking a=
t
> Toaster and to be able to discuss these issues with folks that understand
> Django.
>
> On Thu, Oct 19, 2023 at 9:51=E2=80=AFAM Alassane Yattara <
> alassane.yattara@savoirfairelinux.com> wrote:
>
>> Tim,
>>
>> Seem OpenEmbedded user has not permission to log into
>> bitbake/lib/toaster/logs,
>>
>
> This is probably not where we want the logs anyway.
>
>
>> Yes, I can use BUILDDIR instead of BASE_DIR as logging directory, but
>> there is no way to know if that work in container.
>>
>>
> This is where we should put the logs most likely. It should be writable b=
y
> the container user.
>
>
>> I'm trying to reproduce the issue, i cloned and run repos
>> https://github.com/crops/toaster-container master,
>> this pull crops/toaster:master, but I don't see logging system changes
>> there.
>>
>>
> The master branch container is failing, so it did not push a new containe=
r
> image.
>
>
>> Question:
>> - Is a way to pull a specific docker crops/toaster image that contain
>> logging system changes ?
>>
>>
>  I pushed a branch with the exact scripts I use locally to test Toaster
> with the toaster-container.
> https://github.com/moto-timo/toaster-container/tree/scripts
>
> You will need to run build-and-test.sh to have the absolute latest change=
s
> in bitbake "master".
> It should stall at "Starting toaster...", so you will need to run "docker
> logs toasterserver-<UUID>"
> or whatever the container name is (docker ps -a will tell you).
>

docker logs toasterserver-<UUID> will allow you to see the otherwise hidden
Python traceback.


>
> You should be able to point your web browser at http://localhost:8000 and
> see that toaster is in fact
> running and has built "quilt-native"... but the traceback is throwing of
> the bitbake/bin/toaster script's
> check for whether toaster is running or not.
>

Correction. I had a local (non containerized) Toaster instance also
running. You should NOT be able to connect with the browser.


> FWIW, you can make changes in the build-and-test.sh script to test a
> different branch... I've done this
> in the past when testing fixes. And examples of that usage are commented
> out in the script:
> #GITREPO=3D"git:yoctoproject.org/poky-contrib"
> #BRANCH=3D"timo/hardknott/toaster-fixes"
>
> Alassane
>>
>> ----- Mail original -----
>> De: "Tim Orling" <ticotimo@gmail.com>
>> =C3=80: "Alassane Yattara" <alassane.yattara@savoirfairelinux.com>
>> Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
>> Envoy=C3=A9: Jeudi 19 Octobre 2023 15:00:35
>> Objet: Re: [Toaster] [bitbake-devel] [PATCH] toaster: Monitoring -
>> implement Django logging system
>>
>> Unfortunately, this commit has broken running in a container.
>>
>>
>> The system will start.
>> Traceback (most recent call last):
>> File "/usr/lib/python3.8/logging/config.py", line 563, in configure
>> handler =3D self.configure_handler(handlers[name])
>> File "/usr/lib/python3.8/logging/config.py", line 744, in
>> configure_handler
>> result =3D factory(**kwargs)
>> File "/usr/lib/python3.8/logging/handlers.py", line 200, in __init__
>> BaseRotatingHandler.__init__(self, filename, 'a', encoding, delay)
>> File "/usr/lib/python3.8/logging/handlers.py", line 55, in __init__
>> logging.FileHandler.__init__(self, filename, mode, encoding, delay)
>> File "/usr/lib/python3.8/logging/__init__.py", line 1147, in __init__
>> StreamHandler.__init__(self, self._open())
>> File "/usr/lib/python3.8/logging/__init__.py", line 1176, in _open
>> return open(self.baseFilename, self.mode, encoding=3Dself.encoding)
>> PermissionError: [Errno 13] Permission denied:
>> '/home/usersetup/poky/bitbake/lib/toaster/logs/api.log'
>>
>> The above exception was the direct cause of the following exception:
>>
>> Traceback (most recent call last):
>> File "/home/usersetup/poky/bitbake/bin/../lib/toaster/manage.py", line
>> 16, in <module>
>> execute_from_command_line(sys.argv)
>> File
>> "/opt/venv/lib/python3.8/site-packages/django/core/management/__init__.p=
y",
>> line 442, in execute_from_command_line
>> utility.execute()
>> File
>> "/opt/venv/lib/python3.8/site-packages/django/core/management/__init__.p=
y",
>> line 416, in execute
>> django.setup()
>> File "/opt/venv/lib/python3.8/site-packages/django/__init__.py", line 19=
,
>> in setup
>> configure_logging(settings.LOGGING_CONFIG, settings.LOGGING)
>> File "/opt/venv/lib/python3.8/site-packages/django/utils/log.py", line
>> 76, in configure_logging
>> logging_config_func(logging_settings)
>> File "/usr/lib/python3.8/logging/config.py", line 808, in dictConfig
>> dictConfigClass(config).configure()
>> File "/usr/lib/python3.8/logging/config.py", line 570, in configure
>> raise ValueError('Unable to configure handler '
>> ValueError: Unable to configure handler 'file_api'
>>
>> The reason is that BASE_DIR is resolving to bitbake/lib/toaster and the
>> logs are in this case are attempting to write to a read only file system=
.
>>
>> When running locally, this works, but perhaps is not where OpenEmbedded
>> users expect the logs to be:
>> $ ls bitbake/lib/toaster/logs
>> api.log toaster.log.2023-10-13 toaster.log.2023-10-16
>> django.log toaster.log.2023-10-14 toaster.log.2023-10-17
>> toaster.log toaster.log.2023-10-15
>>
>> Previously, the logs were written into the build directory, like the
>> toaster_ui.log still is:
>> build-toaster-2/toaster_ui.log
>>
>> This also pointed out an issue with the toaster script:
>> [ https://git.yoctoproject.org/poky/tree/bitbake/bin/toaster#n308 |
>> https://git.yoctoproject.org/poky/tree/bitbake/bin/toaster#n308 ]
>> When we have a Python trace back, the code is not catching that there wa=
s
>> a failure to fully start nor fail.
>> e.g. "Successful start." was not output, but neither was "Toaster build
>> server not started."
>>
>> The health check in [
>> https://github.com/crops/toaster-container/blob/master/tests/runtests.sh=
#L91
>> |
>> https://github.com/crops/toaster-container/blob/master/tests/runtests.sh=
#L91
>> ] never sees "Successful start." so unfortunately, the test stage just
>> eventually times out.
>>
>> On Wed, Oct 11, 2023 at 9:35 PM Tim Orling via [
>> http://lists.openembedded.org/ | lists.openembedded.org ] <ticotimo=3D [
>> mailto:gmail.com@lists.openembedded.org |
>> gmail.com@lists.openembedded.org ] > wrote:
>>
>>
>>
>> i think this introduces a missing dependency in toaster-requirements.txt
>> on django-log-viewer or similar, as there is now a failure on [
>> https://github.com/crops/toaster-container |
>> https://github.com/crops/toaster-container ] for "master"
>> 03:55:49 E: 0.862 File "<frozen importlib._bootstrap>", line 1014, in
>> _gcd_import
>> 03:55:49 E: 0.862 File "<frozen importlib._bootstrap>", line 991, in
>> _find_and_load
>> 03:55:49 E: 0.862 File "<frozen importlib._bootstrap>", line 973, in
>> _find_and_load_unlocked
>> 03:55:49 E: 0.862 ModuleNotFoundError: No module named 'log_viewer'"
>> "
>>
>>
>> On Wed, Oct 4, 2023 at 6:45 AM Alassane Yattara < [ mailto:
>> alassane.yattara@savoirfairelinux.com |
>> alassane.yattara@savoirfairelinux.com ] > wrote:
>>
>>
>> ---
>> lib/toaster/bldcollector/views.py | 3 +
>> lib/toaster/logs/.gitignore | 1 +
>> lib/toaster/toastergui/views.py | 7 ++
>> lib/toaster/toastergui/widgets.py | 4 +
>> lib/toaster/toastermain/logs.py | 153 ++++++++++++++++++++++++++++
>> lib/toaster/toastermain/settings.py | 66 +++++-------
>> lib/toaster/toastermain/urls.py | 2 +
>> 7 files changed, 198 insertions(+), 38 deletions(-)
>> create mode 100644 lib/toaster/logs/.gitignore
>> create mode 100644 lib/toaster/toastermain/logs.py
>>
>> diff --git a/lib/toaster/bldcollector/views.py
>> b/lib/toaster/bldcollector/views.py
>> index 04cd8b3d..bdf38ae6 100644
>> --- a/lib/toaster/bldcollector/views.py
>> +++ b/lib/toaster/bldcollector/views.py
>> @@ -14,8 +14,11 @@ import subprocess
>> import toastermain
>> from django.views.decorators.csrf import csrf_exempt
>>
>> +from toastermain.logs import log_view_mixin
>> +
>>
>> @csrf_exempt
>> +@log_view_mixin
>> def eventfile(request):
>> """ Receives a file by POST, and runs toaster-eventreply on this file ""=
"
>> if request.method !=3D "POST":
>> diff --git a/lib/toaster/logs/.gitignore b/lib/toaster/logs/.gitignore
>> new file mode 100644
>> index 00000000..e5ebf25a
>> --- /dev/null
>> +++ b/lib/toaster/logs/.gitignore
>> @@ -0,0 +1 @@
>> +*.log*
>> diff --git a/lib/toaster/toastergui/views.py
>> b/lib/toaster/toastergui/views.py
>> index 552ff164..cc8517ba 100644
>> --- a/lib/toaster/toastergui/views.py
>> +++ b/lib/toaster/toastergui/views.py
>> @@ -34,6 +34,8 @@ import mimetypes
>>
>> import logging
>>
>> +from toastermain.logs import log_view_mixin
>> +
>> logger =3D logging.getLogger("toaster")
>>
>> # Project creation and managed build enable
>> @@ -56,6 +58,7 @@ class MimeTypeFinder(object):
>> return guessed_type
>>
>> # single point to add global values into the context before rendering
>> +@log_view_mixin
>> def toaster_render(request, page, context):
>> context['project_enable'] =3D project_enable
>> context['project_specific'] =3D is_project_specific
>> @@ -665,6 +668,7 @@ def recipe_packages(request, build_id, recipe_id):
>> return response
>>
>> from django.http import HttpResponse
>> +@log_view_mixin
>> def xhr_dirinfo(request, build_id, target_id):
>> top =3D request.GET.get('start', '/')
>> return HttpResponse(_get_dir_entries(build_id, target_id, top),
>> content_type =3D "application/json")
>> @@ -1612,6 +1616,7 @@ if True:
>>
>> from django.views.decorators.csrf import csrf_exempt
>> @csrf_exempt
>> + @log_view_mixin
>> def xhr_testreleasechange(request, pid):
>> def response(data):
>> return HttpResponse(jsonfilter(data),
>> @@ -1648,6 +1653,7 @@ if True:
>> except Exception as e:
>> return response({"error": str(e) })
>>
>> + @log_view_mixin
>> def xhr_configvaredit(request, pid):
>> try:
>> prj =3D Project.objects.get(id =3D pid)
>> @@ -1726,6 +1732,7 @@ if True:
>> return HttpResponse(json.dumps({"error":str(e) + "\n" +
>> traceback.format_exc()}), content_type =3D "application/json")
>>
>>
>> + @log_view_mixin
>> def customrecipe_download(request, pid, recipe_id):
>> recipe =3D get_object_or_404(CustomImageRecipe, pk=3Drecipe_id)
>>
>> diff --git a/lib/toaster/toastergui/widgets.py
>> b/lib/toaster/toastergui/widgets.py
>> index 53696912..51ed153a 100644
>> --- a/lib/toaster/toastergui/widgets.py
>> +++ b/lib/toaster/toastergui/widgets.py
>> @@ -32,6 +32,7 @@ import re
>> import os
>>
>> from toastergui.tablefilter import TableFilterMap
>> +from toastermain.logs import log_view_mixin
>>
>> try:
>> from urllib import unquote_plus
>> @@ -84,6 +85,7 @@ class ToasterTable(TemplateView):
>>
>> return context
>>
>> + @log_view_mixin
>> def get(self, request, *args, **kwargs):
>> if request.GET.get('format', None) =3D=3D 'json':
>>
>> @@ -414,6 +416,7 @@ class ToasterTypeAhead(View):
>> def __init__(self, *args, **kwargs):
>> super(ToasterTypeAhead, self).__init__()
>>
>> + @log_view_mixin
>> def get(self, request, *args, **kwargs):
>> def response(data):
>> return HttpResponse(json.dumps(data,
>> @@ -469,6 +472,7 @@ class MostRecentBuildsView(View):
>>
>> return False
>>
>> + @log_view_mixin
>> def get(self, request, *args, **kwargs):
>> """
>> Returns a list of builds in JSON format.
>> diff --git a/lib/toaster/toastermain/logs.py
>> b/lib/toaster/toastermain/logs.py
>> new file mode 100644
>> index 00000000..f9953982
>> --- /dev/null
>> +++ b/lib/toaster/toastermain/logs.py
>> @@ -0,0 +1,153 @@
>> +#!/usr/bin/env python3
>> +# -*- coding: utf-8 -*-
>> +
>> +import logging
>> +import json
>> +from pathlib import Path
>> +from django.http import HttpRequest
>> +
>> +BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
>> +
>> +
>> +def log_api_request(request, response, view, logger_name=3D'api'):
>> + """Helper function for LogAPIMixin"""
>> +
>> + repjson =3D {
>> + 'view': view,
>> + 'path': request.path,
>> + 'method': request.method,
>> + 'status': response.status_code
>> + }
>> +
>> + logger =3D logging.getLogger(logger_name)
>> + [ http://logger.info/ | logger.info ] (
>> + json.dumps(repjson, indent=3D4, separators=3D(", ", " : "))
>> + )
>> +
>> +
>> +def log_view_mixin(view):
>> + def log_view_request(*args, **kwargs):
>> + # get request from args else kwargs
>> + request =3D None
>> + if len(args) > 0:
>> + for req in args:
>> + if isinstance(req, HttpRequest):
>> + request =3D req
>> + break
>> + elif request is None:
>> + request =3D kwargs.get('request')
>> +
>> + response =3D view(*args, **kwargs)
>> + log_api_request(
>> + request, response, request.resolver_match.view_name, 'toaster')
>> + return response
>> + return log_view_request
>> +
>> +
>> +
>> +class LogAPIMixin:
>> + """Logs API requests
>> +
>> + tested with:
>> + - APIView
>> + - ModelViewSet
>> + - ReadOnlyModelViewSet
>> + - GenericAPIView
>> +
>> + Note: you can set `view_name` attribute in View to override
>> get_view_name()
>> + """
>> +
>> + def get_view_name(self):
>> + if hasattr(self, 'view_name'):
>> + return self.view_name
>> + return super().get_view_name()
>> +
>> + def finalize_response(self, request, response, *args, **kwargs):
>> + log_api_request(request, response, self.get_view_name())
>> + return super().finalize_response(request, response, *args, **kwargs)
>> +
>> +
>> +LOGGING_SETTINGS =3D {
>> + 'version': 1,
>> + 'disable_existing_loggers': False,
>> + 'filters': {
>> + 'require_debug_false': {
>> + '()': 'django.utils.log.RequireDebugFalse'
>> + }
>> + },
>> + 'formatters': {
>> + 'datetime': {
>> + 'format': '%(asctime)s %(levelname)s %(message)s'
>> + },
>> + 'verbose': {
>> + 'format': '{levelname} {asctime} {module} {name}.{funcName} {process:d=
}
>> {thread:d} {message}',
>> + 'datefmt': "%d/%b/%Y %H:%M:%S",
>> + 'style': '{',
>> + },
>> + 'api': {
>> + 'format': '\n{levelname} {asctime} {name}.{funcName}:\n{message}',
>> + 'style': '{'
>> + }
>> + },
>> + 'handlers': {
>> + 'mail_admins': {
>> + 'level': 'ERROR',
>> + 'filters': ['require_debug_false'],
>> + 'class': 'django.utils.log.AdminEmailHandler'
>> + },
>> + 'console': {
>> + 'level': 'DEBUG',
>> + 'class': 'logging.StreamHandler',
>> + 'formatter': 'datetime',
>> + },
>> + 'file_django': {
>> + 'level': 'INFO',
>> + 'class': 'logging.handlers.TimedRotatingFileHandler',
>> + 'filename': BASE_DIR / 'logs/django.log',
>> + 'when': 'D', # interval type
>> + 'interval': 1, # defaults to 1
>> + 'backupCount': 10, # how many files to keep
>> + 'formatter': 'verbose',
>> + },
>> + 'file_api': {
>> + 'level': 'INFO',
>> + 'class': 'logging.handlers.TimedRotatingFileHandler',
>> + 'filename': BASE_DIR / 'logs/api.log',
>> + 'when': 'D',
>> + 'interval': 1,
>> + 'backupCount': 10,
>> + 'formatter': 'verbose',
>> + },
>> + 'file_toaster': {
>> + 'level': 'INFO',
>> + 'class': 'logging.handlers.TimedRotatingFileHandler',
>> + 'filename': BASE_DIR / 'logs/toaster.log',
>> + 'when': 'D',
>> + 'interval': 1,
>> + 'backupCount': 10,
>> + 'formatter': 'verbose',
>> + },
>> + },
>> + 'loggers': {
>> + 'django.request': {
>> + 'handlers': ['file_django', 'console'],
>> + 'level': 'WARN',
>> + 'propagate': True,
>> + },
>> + 'django': {
>> + 'handlers': ['file_django', 'console'],
>> + 'level': 'WARNING',
>> + 'propogate': True,
>> + },
>> + 'toaster': {
>> + 'handlers': ['file_toaster'],
>> + 'level': 'INFO',
>> + 'propagate': False,
>> + },
>> + 'api': {
>> + 'handlers': ['file_api'],
>> + 'level': 'INFO',
>> + 'propagate': False,
>> + }
>> + }
>> +}
>> diff --git a/lib/toaster/toastermain/settings.py
>> b/lib/toaster/toastermain/settings.py
>> index 609c85d9..b083cf58 100644
>> --- a/lib/toaster/toastermain/settings.py
>> +++ b/lib/toaster/toastermain/settings.py
>> @@ -9,6 +9,8 @@
>> # Django settings for Toaster project.
>>
>> import os
>> +from pathlib import Path
>> +from toastermain.logs import LOGGING_SETTINGS
>>
>> DEBUG =3D True
>>
>> @@ -186,7 +188,13 @@ TEMPLATES =3D [
>> 'django.template.loaders.app_directories.Loader',
>> #'django.template.loaders.eggs.Loader',
>> ],
>> - 'string_if_invalid': InvalidString("%s"),
>> + # [
>> https://docs.djangoproject.com/en/4.2/ref/templates/api/#how-invalid-var=
iables-are-handled
>> |
>> https://docs.djangoproject.com/en/4.2/ref/templates/api/#how-invalid-var=
iables-are-handled
>> ]
>> + # Generally, string_if_invalid should only be enabled in order to debu=
g
>> + # a specific template problem, then cleared once debugging is complete=
.
>> + # If you assign a value other than '' to string_if_invalid,
>> + # you will experience rendering problems with these templates and
>> sites.
>> + # 'string_if_invalid': InvalidString("%s"),
>> + 'string_if_invalid': "",
>> 'debug': DEBUG,
>> },
>> },
>> @@ -242,6 +250,9 @@ INSTALLED_APPS =3D (
>> 'django.contrib.humanize',
>> 'bldcollector',
>> 'toastermain',
>> +
>> + # 3rd-lib
>> + "log_viewer",
>> )
>>
>>
>> @@ -302,43 +313,22 @@ for t in os.walk(os.path.dirname(currentdir)):
>> # the site admins on every HTTP 500 error when DEBUG=3DFalse.
>> # See [ http://docs.djangoproject.com/en/dev/topics/logging |
>> http://docs.djangoproject.com/en/dev/topics/logging ] for
>> # more details on how to customize your logging configuration.
>> -LOGGING =3D {
>> - 'version': 1,
>> - 'disable_existing_loggers': False,
>> - 'filters': {
>> - 'require_debug_false': {
>> - '()': 'django.utils.log.RequireDebugFalse'
>> - }
>> - },
>> - 'formatters': {
>> - 'datetime': {
>> - 'format': '%(asctime)s %(levelname)s %(message)s'
>> - }
>> - },
>> - 'handlers': {
>> - 'mail_admins': {
>> - 'level': 'ERROR',
>> - 'filters': ['require_debug_false'],
>> - 'class': 'django.utils.log.AdminEmailHandler'
>> - },
>> - 'console': {
>> - 'level': 'DEBUG',
>> - 'class': 'logging.StreamHandler',
>> - 'formatter': 'datetime',
>> - }
>> - },
>> - 'loggers': {
>> - 'toaster' : {
>> - 'handlers': ['console'],
>> - 'level': 'DEBUG',
>> - },
>> - 'django.request': {
>> - 'handlers': ['console'],
>> - 'level': 'WARN',
>> - 'propagate': True,
>> - },
>> - }
>> -}
>> +LOGGING =3D LOGGING_SETTINGS
>> +
>> +# Build paths inside the project like this: BASE_DIR / 'subdir'.
>> +BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
>> +
>> +# LOG VIEWER
>> +# [ https://pypi.org/project/django-log-viewer/ |
>> https://pypi.org/project/django-log-viewer/ ]
>> +LOG_VIEWER_FILES_PATTERN =3D '*.log*'
>> +LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, 'logs')
>> +LOG_VIEWER_PAGE_LENGTH =3D 25 # total log lines per-page
>> +LOG_VIEWER_MAX_READ_LINES =3D 100000 # total log lines will be read
>> +LOG_VIEWER_PATTERNS =3D ['INFO', 'DEBUG', 'WARNING', 'ERROR', 'CRITICAL=
']
>> +
>> +# Optionally you can set the next variables in order to customize the
>> admin:
>> +LOG_VIEWER_FILE_LIST_TITLE =3D "Logs list"
>> +
>>
>> if DEBUG and SQL_DEBUG:
>> LOGGING['loggers']['django.db.backends'] =3D {
>> diff --git a/lib/toaster/toastermain/urls.py
>> b/lib/toaster/toastermain/urls.py
>> index 03603026..3be46fcf 100644
>> --- a/lib/toaster/toastermain/urls.py
>> +++ b/lib/toaster/toastermain/urls.py
>> @@ -28,6 +28,8 @@ urlpatterns =3D [
>> # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
>>
>>
>> + url(r'^logs/', include('log_viewer.urls')),
>> +
>> # This is here to maintain backward compatibility and will be deprecated
>> # in the future.
>> url(r'^orm/eventfile$', bldcollector.views.eventfile),
>> --
>> 2.34.1
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5884):
> https://lists.yoctoproject.org/g/toaster/message/5884
> Mute This Topic: https://lists.yoctoproject.org/mt/102060497/924729
> Group Owner: toaster+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000bad1380608158c63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 19, 2023 at 10:12=E2=80=
=AFAM Tim Orling via <a href=3D"http://lists.yoctoproject.org">lists.yoctop=
roject.org</a> &lt;ticotimo=3D<a href=3D"mailto:gmail.com@lists.yoctoprojec=
t.org">gmail.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Let me take a =
moment to say how great it is to have other folks looking at Toaster and to=
 be able to discuss these issues with folks that understand Django.</div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, =
Oct 19, 2023 at 9:51=E2=80=AFAM Alassane Yattara &lt;<a href=3D"mailto:alas=
sane.yattara@savoirfairelinux.com" target=3D"_blank">alassane.yattara@savoi=
rfairelinux.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Tim,<br>
<br>
Seem OpenEmbedded user has not permission to log into bitbake/lib/toaster/l=
ogs,<br></blockquote><div><br></div><div>This is probably not where we want=
 the logs anyway.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
Yes, I can use BUILDDIR instead of BASE_DIR as logging directory, but there=
 is no way to know if that work in container.<br>
<br></blockquote><div><br></div><div>This is where we should put the logs m=
ost likely. It should be writable by the container user.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
I&#39;m trying to reproduce the issue, i cloned and run repos <a href=3D"ht=
tps://github.com/crops/toaster-container" rel=3D"noreferrer" target=3D"_bla=
nk">https://github.com/crops/toaster-container</a> master, <br>
this pull crops/toaster:master, but I don&#39;t see logging system changes =
there.<br>
<br></blockquote><div><br></div><div>The master branch container is failing=
, so it did not push a new container image.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
Question: <br>
- Is a way to pull a specific docker crops/toaster image that contain loggi=
ng system changes ?<br>
<br></blockquote><div><br></div><div>=C2=A0I pushed a branch with the exact=
 scripts I use locally to test Toaster with the toaster-container.</div><di=
v><a href=3D"https://github.com/moto-timo/toaster-container/tree/scripts" t=
arget=3D"_blank">https://github.com/moto-timo/toaster-container/tree/script=
s</a><br></div><div><br></div><div>You will need to run build-and-test.sh t=
o have the absolute latest changes in bitbake &quot;master&quot;.</div><div=
>It should stall at &quot;Starting toaster...&quot;, so you will need to ru=
n &quot;docker logs toasterserver-&lt;UUID&gt;&quot;</div><div>or whatever =
the container name is (docker ps -a will tell you).</div></div></div></bloc=
kquote><div><br></div><div>docker logs toasterserver-&lt;UUID&gt; will allo=
w you to see the otherwise hidden Python traceback.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div clas=
s=3D"gmail_quote"><div><br></div><div>You should be able to point your web =
browser at <a href=3D"http://localhost:8000" target=3D"_blank">http://local=
host:8000</a> and see that toaster is in fact</div><div>running and has bui=
lt &quot;quilt-native&quot;... but the traceback is throwing of the bitbake=
/bin/toaster script&#39;s</div><div>check for whether toaster is running or=
 not.</div></div></div></blockquote><div><br></div><div>Correction. I had a=
 local (non containerized) Toaster instance also running. You should NOT be=
 able to connect with the browser.=C2=A0</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_qu=
ote"><div><br></div><div>FWIW, you can make changes in the build-and-test.s=
h script to test a different branch... I&#39;ve done this</div><div>in the =
past when testing fixes. And examples of that usage are commented out in th=
e script:</div><div>#GITREPO=3D&quot;git:<a href=3D"http://yoctoproject.org=
/poky-contrib" target=3D"_blank">yoctoproject.org/poky-contrib</a>&quot;<br=
>#BRANCH=3D&quot;timo/hardknott/toaster-fixes&quot;</div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
Alassane<br>
<br>
----- Mail original -----<br>
De: &quot;Tim Orling&quot; &lt;<a href=3D"mailto:ticotimo@gmail.com" target=
=3D"_blank">ticotimo@gmail.com</a>&gt;<br>
=C3=80: &quot;Alassane Yattara&quot; &lt;<a href=3D"mailto:alassane.yattara=
@savoirfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.=
com</a>&gt;<br>
Cc: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blan=
k">bitbake-devel@lists.openembedded.org</a>, <a href=3D"mailto:toaster@list=
s.yoctoproject.org" target=3D"_blank">toaster@lists.yoctoproject.org</a><br=
>
Envoy=C3=A9: Jeudi 19 Octobre 2023 15:00:35<br>
Objet: Re: [Toaster] [bitbake-devel] [PATCH] toaster: Monitoring - implemen=
t Django logging system<br>
<br>
Unfortunately, this commit has broken running in a container. <br>
<br>
<br>
The system will start. <br>
Traceback (most recent call last): <br>
File &quot;/usr/lib/python3.8/logging/config.py&quot;, line 563, in configu=
re <br>
handler =3D self.configure_handler(handlers[name]) <br>
File &quot;/usr/lib/python3.8/logging/config.py&quot;, line 744, in configu=
re_handler <br>
result =3D factory(**kwargs) <br>
File &quot;/usr/lib/python3.8/logging/handlers.py&quot;, line 200, in __ini=
t__ <br>
BaseRotatingHandler.__init__(self, filename, &#39;a&#39;, encoding, delay) =
<br>
File &quot;/usr/lib/python3.8/logging/handlers.py&quot;, line 55, in __init=
__ <br>
logging.FileHandler.__init__(self, filename, mode, encoding, delay) <br>
File &quot;/usr/lib/python3.8/logging/__init__.py&quot;, line 1147, in __in=
it__ <br>
StreamHandler.__init__(self, self._open()) <br>
File &quot;/usr/lib/python3.8/logging/__init__.py&quot;, line 1176, in _ope=
n <br>
return open(self.baseFilename, self.mode, encoding=3Dself.encoding) <br>
PermissionError: [Errno 13] Permission denied: &#39;/home/usersetup/poky/bi=
tbake/lib/toaster/logs/api.log&#39; <br>
<br>
The above exception was the direct cause of the following exception: <br>
<br>
Traceback (most recent call last): <br>
File &quot;/home/usersetup/poky/bitbake/bin/../lib/toaster/manage.py&quot;,=
 line 16, in &lt;module&gt; <br>
execute_from_command_line(sys.argv) <br>
File &quot;/opt/venv/lib/python3.8/site-packages/django/core/management/__i=
nit__.py&quot;, line 442, in execute_from_command_line <br>
utility.execute() <br>
File &quot;/opt/venv/lib/python3.8/site-packages/django/core/management/__i=
nit__.py&quot;, line 416, in execute <br>
django.setup() <br>
File &quot;/opt/venv/lib/python3.8/site-packages/django/__init__.py&quot;, =
line 19, in setup <br>
configure_logging(settings.LOGGING_CONFIG, settings.LOGGING) <br>
File &quot;/opt/venv/lib/python3.8/site-packages/django/utils/log.py&quot;,=
 line 76, in configure_logging <br>
logging_config_func(logging_settings) <br>
File &quot;/usr/lib/python3.8/logging/config.py&quot;, line 808, in dictCon=
fig <br>
dictConfigClass(config).configure() <br>
File &quot;/usr/lib/python3.8/logging/config.py&quot;, line 570, in configu=
re <br>
raise ValueError(&#39;Unable to configure handler &#39; <br>
ValueError: Unable to configure handler &#39;file_api&#39; <br>
<br>
The reason is that BASE_DIR is resolving to bitbake/lib/toaster and the log=
s are in this case are attempting to write to a read only file system. <br>
<br>
When running locally, this works, but perhaps is not where OpenEmbedded use=
rs expect the logs to be: <br>
$ ls bitbake/lib/toaster/logs <br>
api.log toaster.log.2023-10-13 toaster.log.2023-10-16 <br>
django.log toaster.log.2023-10-14 toaster.log.2023-10-17 <br>
toaster.log toaster.log.2023-10-15 <br>
<br>
Previously, the logs were written into the build directory, like the toaste=
r_ui.log still is: <br>
build-toaster-2/toaster_ui.log <br>
<br>
This also pointed out an issue with the toaster script: <br>
[ <a href=3D"https://git.yoctoproject.org/poky/tree/bitbake/bin/toaster#n30=
8" rel=3D"noreferrer" target=3D"_blank">https://git.yoctoproject.org/poky/t=
ree/bitbake/bin/toaster#n308</a> | <a href=3D"https://git.yoctoproject.org/=
poky/tree/bitbake/bin/toaster#n308" rel=3D"noreferrer" target=3D"_blank">ht=
tps://git.yoctoproject.org/poky/tree/bitbake/bin/toaster#n308</a> ] <br>
When we have a Python trace back, the code is not catching that there was a=
 failure to fully start nor fail. <br>
e.g. &quot;Successful start.&quot; was not output, but neither was &quot;To=
aster build server not started.&quot; <br>
<br>
The health check in [ <a href=3D"https://github.com/crops/toaster-container=
/blob/master/tests/runtests.sh#L91" rel=3D"noreferrer" target=3D"_blank">ht=
tps://github.com/crops/toaster-container/blob/master/tests/runtests.sh#L91<=
/a> | <a href=3D"https://github.com/crops/toaster-container/blob/master/tes=
ts/runtests.sh#L91" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/crops/toaster-container/blob/master/tests/runtests.sh#L91</a> ] never sees=
 &quot;Successful start.&quot; so unfortunately, the test stage just eventu=
ally times out. <br>
<br>
On Wed, Oct 11, 2023 at 9:35 PM Tim Orling via [ <a href=3D"http://lists.op=
enembedded.org/" rel=3D"noreferrer" target=3D"_blank">http://lists.openembe=
dded.org/</a> | <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer=
" target=3D"_blank">lists.openembedded.org</a> ] &lt;ticotimo=3D [ mailto:<=
a href=3D"mailto:gmail.com@lists.openembedded.org" target=3D"_blank">gmail.=
com@lists.openembedded.org</a> | <a href=3D"mailto:gmail.com@lists.openembe=
dded.org" target=3D"_blank">gmail.com@lists.openembedded.org</a> ] &gt; wro=
te: <br>
<br>
<br>
<br>
i think this introduces a missing dependency in toaster-requirements.txt on=
 django-log-viewer or similar, as there is now a failure on [ <a href=3D"ht=
tps://github.com/crops/toaster-container" rel=3D"noreferrer" target=3D"_bla=
nk">https://github.com/crops/toaster-container</a> | <a href=3D"https://git=
hub.com/crops/toaster-container" rel=3D"noreferrer" target=3D"_blank">https=
://github.com/crops/toaster-container</a> ] for &quot;master&quot; <br>
03:55:49 E: 0.862 File &quot;&lt;frozen importlib._bootstrap&gt;&quot;, lin=
e 1014, in _gcd_import <br>
03:55:49 E: 0.862 File &quot;&lt;frozen importlib._bootstrap&gt;&quot;, lin=
e 991, in _find_and_load <br>
03:55:49 E: 0.862 File &quot;&lt;frozen importlib._bootstrap&gt;&quot;, lin=
e 973, in _find_and_load_unlocked <br>
03:55:49 E: 0.862 ModuleNotFoundError: No module named &#39;log_viewer&#39;=
&quot; <br>
&quot; <br>
<br>
<br>
On Wed, Oct 4, 2023 at 6:45 AM Alassane Yattara &lt; [ mailto:<a href=3D"ma=
ilto:alassane.yattara@savoirfairelinux.com" target=3D"_blank">alassane.yatt=
ara@savoirfairelinux.com</a> | <a href=3D"mailto:alassane.yattara@savoirfai=
relinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</a> ] =
&gt; wrote: <br>
<br>
<br>
--- <br>
lib/toaster/bldcollector/views.py | 3 + <br>
lib/toaster/logs/.gitignore | 1 + <br>
lib/toaster/toastergui/views.py | 7 ++ <br>
lib/toaster/toastergui/widgets.py | 4 + <br>
lib/toaster/toastermain/logs.py | 153 ++++++++++++++++++++++++++++ <br>
lib/toaster/toastermain/settings.py | 66 +++++------- <br>
lib/toaster/toastermain/urls.py | 2 + <br>
7 files changed, 198 insertions(+), 38 deletions(-) <br>
create mode 100644 lib/toaster/logs/.gitignore <br>
create mode 100644 lib/toaster/toastermain/logs.py <br>
<br>
diff --git a/lib/toaster/bldcollector/views.py b/lib/toaster/bldcollector/v=
iews.py <br>
index 04cd8b3d..bdf38ae6 100644 <br>
--- a/lib/toaster/bldcollector/views.py <br>
+++ b/lib/toaster/bldcollector/views.py <br>
@@ -14,8 +14,11 @@ import subprocess <br>
import toastermain <br>
from django.views.decorators.csrf import csrf_exempt <br>
<br>
+from toastermain.logs import log_view_mixin <br>
+ <br>
<br>
@csrf_exempt <br>
+@log_view_mixin <br>
def eventfile(request): <br>
&quot;&quot;&quot; Receives a file by POST, and runs toaster-eventreply on =
this file &quot;&quot;&quot; <br>
if request.method !=3D &quot;POST&quot;: <br>
diff --git a/lib/toaster/logs/.gitignore b/lib/toaster/logs/.gitignore <br>
new file mode 100644 <br>
index 00000000..e5ebf25a <br>
--- /dev/null <br>
+++ b/lib/toaster/logs/.gitignore <br>
@@ -0,0 +1 @@ <br>
+*.log* <br>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views=
.py <br>
index 552ff164..cc8517ba 100644 <br>
--- a/lib/toaster/toastergui/views.py <br>
+++ b/lib/toaster/toastergui/views.py <br>
@@ -34,6 +34,8 @@ import mimetypes <br>
<br>
import logging <br>
<br>
+from toastermain.logs import log_view_mixin <br>
+ <br>
logger =3D logging.getLogger(&quot;toaster&quot;) <br>
<br>
# Project creation and managed build enable <br>
@@ -56,6 +58,7 @@ class MimeTypeFinder(object): <br>
return guessed_type <br>
<br>
# single point to add global values into the context before rendering <br>
+@log_view_mixin <br>
def toaster_render(request, page, context): <br>
context[&#39;project_enable&#39;] =3D project_enable <br>
context[&#39;project_specific&#39;] =3D is_project_specific <br>
@@ -665,6 +668,7 @@ def recipe_packages(request, build_id, recipe_id): <br>
return response <br>
<br>
from django.http import HttpResponse <br>
+@log_view_mixin <br>
def xhr_dirinfo(request, build_id, target_id): <br>
top =3D request.GET.get(&#39;start&#39;, &#39;/&#39;) <br>
return HttpResponse(_get_dir_entries(build_id, target_id, top), content_typ=
e =3D &quot;application/json&quot;) <br>
@@ -1612,6 +1616,7 @@ if True: <br>
<br>
from django.views.decorators.csrf import csrf_exempt <br>
@csrf_exempt <br>
+ @log_view_mixin <br>
def xhr_testreleasechange(request, pid): <br>
def response(data): <br>
return HttpResponse(jsonfilter(data), <br>
@@ -1648,6 +1653,7 @@ if True: <br>
except Exception as e: <br>
return response({&quot;error&quot;: str(e) }) <br>
<br>
+ @log_view_mixin <br>
def xhr_configvaredit(request, pid): <br>
try: <br>
prj =3D Project.objects.get(id =3D pid) <br>
@@ -1726,6 +1732,7 @@ if True: <br>
return HttpResponse(json.dumps({&quot;error&quot;:str(e) + &quot;\n&quot; +=
 traceback.format_exc()}), content_type =3D &quot;application/json&quot;) <=
br>
<br>
<br>
+ @log_view_mixin <br>
def customrecipe_download(request, pid, recipe_id): <br>
recipe =3D get_object_or_404(CustomImageRecipe, pk=3Drecipe_id) <br>
<br>
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/wid=
gets.py <br>
index 53696912..51ed153a 100644 <br>
--- a/lib/toaster/toastergui/widgets.py <br>
+++ b/lib/toaster/toastergui/widgets.py <br>
@@ -32,6 +32,7 @@ import re <br>
import os <br>
<br>
from toastergui.tablefilter import TableFilterMap <br>
+from toastermain.logs import log_view_mixin <br>
<br>
try: <br>
from urllib import unquote_plus <br>
@@ -84,6 +85,7 @@ class ToasterTable(TemplateView): <br>
<br>
return context <br>
<br>
+ @log_view_mixin <br>
def get(self, request, *args, **kwargs): <br>
if request.GET.get(&#39;format&#39;, None) =3D=3D &#39;json&#39;: <br>
<br>
@@ -414,6 +416,7 @@ class ToasterTypeAhead(View): <br>
def __init__(self, *args, **kwargs): <br>
super(ToasterTypeAhead, self).__init__() <br>
<br>
+ @log_view_mixin <br>
def get(self, request, *args, **kwargs): <br>
def response(data): <br>
return HttpResponse(json.dumps(data, <br>
@@ -469,6 +472,7 @@ class MostRecentBuildsView(View): <br>
<br>
return False <br>
<br>
+ @log_view_mixin <br>
def get(self, request, *args, **kwargs): <br>
&quot;&quot;&quot; <br>
Returns a list of builds in JSON format. <br>
diff --git a/lib/toaster/toastermain/logs.py b/lib/toaster/toastermain/logs=
.py <br>
new file mode 100644 <br>
index 00000000..f9953982 <br>
--- /dev/null <br>
+++ b/lib/toaster/toastermain/logs.py <br>
@@ -0,0 +1,153 @@ <br>
+#!/usr/bin/env python3 <br>
+# -*- coding: utf-8 -*- <br>
+ <br>
+import logging <br>
+import json <br>
+from pathlib import Path <br>
+from django.http import HttpRequest <br>
+ <br>
+BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent <br>
+ <br>
+ <br>
+def log_api_request(request, response, view, logger_name=3D&#39;api&#39;):=
 <br>
+ &quot;&quot;&quot;Helper function for LogAPIMixin&quot;&quot;&quot; <br>
+ <br>
+ repjson =3D { <br>
+ &#39;view&#39;: view, <br>
+ &#39;path&#39;: request.path, <br>
+ &#39;method&#39;: request.method, <br>
+ &#39;status&#39;: response.status_code <br>
+ } <br>
+ <br>
+ logger =3D logging.getLogger(logger_name) <br>
+ [ <a href=3D"http://logger.info/" rel=3D"noreferrer" target=3D"_blank">ht=
tp://logger.info/</a> | <a href=3D"http://logger.info" rel=3D"noreferrer" t=
arget=3D"_blank">logger.info</a> ] ( <br>
+ json.dumps(repjson, indent=3D4, separators=3D(&quot;, &quot;, &quot; : &q=
uot;)) <br>
+ ) <br>
+ <br>
+ <br>
+def log_view_mixin(view): <br>
+ def log_view_request(*args, **kwargs): <br>
+ # get request from args else kwargs <br>
+ request =3D None <br>
+ if len(args) &gt; 0: <br>
+ for req in args: <br>
+ if isinstance(req, HttpRequest): <br>
+ request =3D req <br>
+ break <br>
+ elif request is None: <br>
+ request =3D kwargs.get(&#39;request&#39;) <br>
+ <br>
+ response =3D view(*args, **kwargs) <br>
+ log_api_request( <br>
+ request, response, request.resolver_match.view_name, &#39;toaster&#39;) <=
br>
+ return response <br>
+ return log_view_request <br>
+ <br>
+ <br>
+ <br>
+class LogAPIMixin: <br>
+ &quot;&quot;&quot;Logs API requests <br>
+ <br>
+ tested with: <br>
+ - APIView <br>
+ - ModelViewSet <br>
+ - ReadOnlyModelViewSet <br>
+ - GenericAPIView <br>
+ <br>
+ Note: you can set `view_name` attribute in View to override get_view_name=
() <br>
+ &quot;&quot;&quot; <br>
+ <br>
+ def get_view_name(self): <br>
+ if hasattr(self, &#39;view_name&#39;): <br>
+ return self.view_name <br>
+ return super().get_view_name() <br>
+ <br>
+ def finalize_response(self, request, response, *args, **kwargs): <br>
+ log_api_request(request, response, self.get_view_name()) <br>
+ return super().finalize_response(request, response, *args, **kwargs) <br>
+ <br>
+ <br>
+LOGGING_SETTINGS =3D { <br>
+ &#39;version&#39;: 1, <br>
+ &#39;disable_existing_loggers&#39;: False, <br>
+ &#39;filters&#39;: { <br>
+ &#39;require_debug_false&#39;: { <br>
+ &#39;()&#39;: &#39;django.utils.log.RequireDebugFalse&#39; <br>
+ } <br>
+ }, <br>
+ &#39;formatters&#39;: { <br>
+ &#39;datetime&#39;: { <br>
+ &#39;format&#39;: &#39;%(asctime)s %(levelname)s %(message)s&#39; <br>
+ }, <br>
+ &#39;verbose&#39;: { <br>
+ &#39;format&#39;: &#39;{levelname} {asctime} {module} {name}.{funcName} {=
process:d} {thread:d} {message}&#39;, <br>
+ &#39;datefmt&#39;: &quot;%d/%b/%Y %H:%M:%S&quot;, <br>
+ &#39;style&#39;: &#39;{&#39;, <br>
+ }, <br>
+ &#39;api&#39;: { <br>
+ &#39;format&#39;: &#39;\n{levelname} {asctime} {name}.{funcName}:\n{messa=
ge}&#39;, <br>
+ &#39;style&#39;: &#39;{&#39; <br>
+ } <br>
+ }, <br>
+ &#39;handlers&#39;: { <br>
+ &#39;mail_admins&#39;: { <br>
+ &#39;level&#39;: &#39;ERROR&#39;, <br>
+ &#39;filters&#39;: [&#39;require_debug_false&#39;], <br>
+ &#39;class&#39;: &#39;django.utils.log.AdminEmailHandler&#39; <br>
+ }, <br>
+ &#39;console&#39;: { <br>
+ &#39;level&#39;: &#39;DEBUG&#39;, <br>
+ &#39;class&#39;: &#39;logging.StreamHandler&#39;, <br>
+ &#39;formatter&#39;: &#39;datetime&#39;, <br>
+ }, <br>
+ &#39;file_django&#39;: { <br>
+ &#39;level&#39;: &#39;INFO&#39;, <br>
+ &#39;class&#39;: &#39;logging.handlers.TimedRotatingFileHandler&#39;, <br=
>
+ &#39;filename&#39;: BASE_DIR / &#39;logs/django.log&#39;, <br>
+ &#39;when&#39;: &#39;D&#39;, # interval type <br>
+ &#39;interval&#39;: 1, # defaults to 1 <br>
+ &#39;backupCount&#39;: 10, # how many files to keep <br>
+ &#39;formatter&#39;: &#39;verbose&#39;, <br>
+ }, <br>
+ &#39;file_api&#39;: { <br>
+ &#39;level&#39;: &#39;INFO&#39;, <br>
+ &#39;class&#39;: &#39;logging.handlers.TimedRotatingFileHandler&#39;, <br=
>
+ &#39;filename&#39;: BASE_DIR / &#39;logs/api.log&#39;, <br>
+ &#39;when&#39;: &#39;D&#39;, <br>
+ &#39;interval&#39;: 1, <br>
+ &#39;backupCount&#39;: 10, <br>
+ &#39;formatter&#39;: &#39;verbose&#39;, <br>
+ }, <br>
+ &#39;file_toaster&#39;: { <br>
+ &#39;level&#39;: &#39;INFO&#39;, <br>
+ &#39;class&#39;: &#39;logging.handlers.TimedRotatingFileHandler&#39;, <br=
>
+ &#39;filename&#39;: BASE_DIR / &#39;logs/toaster.log&#39;, <br>
+ &#39;when&#39;: &#39;D&#39;, <br>
+ &#39;interval&#39;: 1, <br>
+ &#39;backupCount&#39;: 10, <br>
+ &#39;formatter&#39;: &#39;verbose&#39;, <br>
+ }, <br>
+ }, <br>
+ &#39;loggers&#39;: { <br>
+ &#39;django.request&#39;: { <br>
+ &#39;handlers&#39;: [&#39;file_django&#39;, &#39;console&#39;], <br>
+ &#39;level&#39;: &#39;WARN&#39;, <br>
+ &#39;propagate&#39;: True, <br>
+ }, <br>
+ &#39;django&#39;: { <br>
+ &#39;handlers&#39;: [&#39;file_django&#39;, &#39;console&#39;], <br>
+ &#39;level&#39;: &#39;WARNING&#39;, <br>
+ &#39;propogate&#39;: True, <br>
+ }, <br>
+ &#39;toaster&#39;: { <br>
+ &#39;handlers&#39;: [&#39;file_toaster&#39;], <br>
+ &#39;level&#39;: &#39;INFO&#39;, <br>
+ &#39;propagate&#39;: False, <br>
+ }, <br>
+ &#39;api&#39;: { <br>
+ &#39;handlers&#39;: [&#39;file_api&#39;], <br>
+ &#39;level&#39;: &#39;INFO&#39;, <br>
+ &#39;propagate&#39;: False, <br>
+ } <br>
+ } <br>
+} <br>
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/=
settings.py <br>
index 609c85d9..b083cf58 100644 <br>
--- a/lib/toaster/toastermain/settings.py <br>
+++ b/lib/toaster/toastermain/settings.py <br>
@@ -9,6 +9,8 @@ <br>
# Django settings for Toaster project. <br>
<br>
import os <br>
+from pathlib import Path <br>
+from toastermain.logs import LOGGING_SETTINGS <br>
<br>
DEBUG =3D True <br>
<br>
@@ -186,7 +188,13 @@ TEMPLATES =3D [ <br>
&#39;django.template.loaders.app_directories.Loader&#39;, <br>
#&#39;django.template.loaders.eggs.Loader&#39;, <br>
], <br>
- &#39;string_if_invalid&#39;: InvalidString(&quot;%s&quot;), <br>
+ # [ <a href=3D"https://docs.djangoproject.com/en/4.2/ref/templates/api/#h=
ow-invalid-variables-are-handled" rel=3D"noreferrer" target=3D"_blank">http=
s://docs.djangoproject.com/en/4.2/ref/templates/api/#how-invalid-variables-=
are-handled</a> | <a href=3D"https://docs.djangoproject.com/en/4.2/ref/temp=
lates/api/#how-invalid-variables-are-handled" rel=3D"noreferrer" target=3D"=
_blank">https://docs.djangoproject.com/en/4.2/ref/templates/api/#how-invali=
d-variables-are-handled</a> ] <br>
+ # Generally, string_if_invalid should only be enabled in order to debug <=
br>
+ # a specific template problem, then cleared once debugging is complete. <=
br>
+ # If you assign a value other than &#39;&#39; to string_if_invalid, <br>
+ # you will experience rendering problems with these templates and sites. =
<br>
+ # &#39;string_if_invalid&#39;: InvalidString(&quot;%s&quot;), <br>
+ &#39;string_if_invalid&#39;: &quot;&quot;, <br>
&#39;debug&#39;: DEBUG, <br>
}, <br>
}, <br>
@@ -242,6 +250,9 @@ INSTALLED_APPS =3D ( <br>
&#39;django.contrib.humanize&#39;, <br>
&#39;bldcollector&#39;, <br>
&#39;toastermain&#39;, <br>
+ <br>
+ # 3rd-lib <br>
+ &quot;log_viewer&quot;, <br>
) <br>
<br>
<br>
@@ -302,43 +313,22 @@ for t in os.walk(os.path.dirname(currentdir)): <br>
# the site admins on every HTTP 500 error when DEBUG=3DFalse. <br>
# See [ <a href=3D"http://docs.djangoproject.com/en/dev/topics/logging" rel=
=3D"noreferrer" target=3D"_blank">http://docs.djangoproject.com/en/dev/topi=
cs/logging</a> | <a href=3D"http://docs.djangoproject.com/en/dev/topics/log=
ging" rel=3D"noreferrer" target=3D"_blank">http://docs.djangoproject.com/en=
/dev/topics/logging</a> ] for <br>
# more details on how to customize your logging configuration. <br>
-LOGGING =3D { <br>
- &#39;version&#39;: 1, <br>
- &#39;disable_existing_loggers&#39;: False, <br>
- &#39;filters&#39;: { <br>
- &#39;require_debug_false&#39;: { <br>
- &#39;()&#39;: &#39;django.utils.log.RequireDebugFalse&#39; <br>
- } <br>
- }, <br>
- &#39;formatters&#39;: { <br>
- &#39;datetime&#39;: { <br>
- &#39;format&#39;: &#39;%(asctime)s %(levelname)s %(message)s&#39; <br>
- } <br>
- }, <br>
- &#39;handlers&#39;: { <br>
- &#39;mail_admins&#39;: { <br>
- &#39;level&#39;: &#39;ERROR&#39;, <br>
- &#39;filters&#39;: [&#39;require_debug_false&#39;], <br>
- &#39;class&#39;: &#39;django.utils.log.AdminEmailHandler&#39; <br>
- }, <br>
- &#39;console&#39;: { <br>
- &#39;level&#39;: &#39;DEBUG&#39;, <br>
- &#39;class&#39;: &#39;logging.StreamHandler&#39;, <br>
- &#39;formatter&#39;: &#39;datetime&#39;, <br>
- } <br>
- }, <br>
- &#39;loggers&#39;: { <br>
- &#39;toaster&#39; : { <br>
- &#39;handlers&#39;: [&#39;console&#39;], <br>
- &#39;level&#39;: &#39;DEBUG&#39;, <br>
- }, <br>
- &#39;django.request&#39;: { <br>
- &#39;handlers&#39;: [&#39;console&#39;], <br>
- &#39;level&#39;: &#39;WARN&#39;, <br>
- &#39;propagate&#39;: True, <br>
- }, <br>
- } <br>
-} <br>
+LOGGING =3D LOGGING_SETTINGS <br>
+ <br>
+# Build paths inside the project like this: BASE_DIR / &#39;subdir&#39;. <=
br>
+BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent <br>
+ <br>
+# LOG VIEWER <br>
+# [ <a href=3D"https://pypi.org/project/django-log-viewer/" rel=3D"norefer=
rer" target=3D"_blank">https://pypi.org/project/django-log-viewer/</a> | <a=
 href=3D"https://pypi.org/project/django-log-viewer/" rel=3D"noreferrer" ta=
rget=3D"_blank">https://pypi.org/project/django-log-viewer/</a> ] <br>
+LOG_VIEWER_FILES_PATTERN =3D &#39;*.log*&#39; <br>
+LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, &#39;logs&#39;) <br>
+LOG_VIEWER_PAGE_LENGTH =3D 25 # total log lines per-page <br>
+LOG_VIEWER_MAX_READ_LINES =3D 100000 # total log lines will be read <br>
+LOG_VIEWER_PATTERNS =3D [&#39;INFO&#39;, &#39;DEBUG&#39;, &#39;WARNING&#39=
;, &#39;ERROR&#39;, &#39;CRITICAL&#39;] <br>
+ <br>
+# Optionally you can set the next variables in order to customize the admi=
n: <br>
+LOG_VIEWER_FILE_LIST_TITLE =3D &quot;Logs list&quot; <br>
+ <br>
<br>
if DEBUG and SQL_DEBUG: <br>
LOGGING[&#39;loggers&#39;][&#39;django.db.backends&#39;] =3D { <br>
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls=
.py <br>
index 03603026..3be46fcf 100644 <br>
--- a/lib/toaster/toastermain/urls.py <br>
+++ b/lib/toaster/toastermain/urls.py <br>
@@ -28,6 +28,8 @@ urlpatterns =3D [ <br>
# url(r&#39;^admin/doc/&#39;, include(&#39;django.contrib.admindocs.urls&#3=
9;)), <br>
<br>
<br>
+ url(r&#39;^logs/&#39;, include(&#39;log_viewer.urls&#39;)), <br>
+ <br>
# This is here to maintain backward compatibility and will be deprecated <b=
r>
# in the future. <br>
url(r&#39;^orm/eventfile$&#39;, bldcollector.views.eventfile), <br>
-- <br>
2.34.1 <br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#5884): <a href=3D"https://lists.yoctoproject.org/g/toas=
ter/message/5884" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctop=
roject.org/g/toaster/message/5884</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/102060497/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/102060497/924729</a><br>
Group Owner: <a href=3D"mailto:toaster%2Bowner@lists.yoctoproject.org" targ=
et=3D"_blank">toaster+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/toaster/unsub" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/toaster/=
unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo=
@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000bad1380608158c63--

