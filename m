Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52DAC41513
	for <webhook@archiver.kernel.org>; Thu, 19 Oct 2023 16:51:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.33087.1697734286076130458
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Oct 2023 09:51:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=OqYLJJDd;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AB46D9C2A31;
	Thu, 19 Oct 2023 12:51:24 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id KGJWYq4aPBAE; Thu, 19 Oct 2023 12:51:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D57B39C2AFF;
	Thu, 19 Oct 2023 12:51:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D57B39C2AFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697734280; bh=ivVgGY1gPiFnrleixwL3ry5H/MCytpL/fD7ckQ2gwi4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=OqYLJJDdo/1UaPlPIRTSVasosAQ0MDapyz/9qDjaUlqmMnX/ocCGl6MYa3/cF/AQR
	 /IVVxLdc9t2PKD5u8mVsEMLP0LNV/O+fqGuKttNE5RVFPxSL4hmRYlw2eliqI5qgLg
	 GfEYNIY30RHZ2FTJiPoA6R4lrba3pFxsv0jH8AYLx+L0Ir3Mdp/dSFhGf9SMy6Qz25
	 ieL6PIsrVsgM33kmPwV6UCbQl9IDaogKFU2WEFs8M8jAuFjHufL6jWBucvPowzz0l2
	 Cx4emF76BFxC24AS55lNEjlgjepCipj08a94LU1G+JUAGATVT9ZxqkUfYMTDfhf+g2
	 QC/ewfOSo6dWA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id JMMvRB1XvusY; Thu, 19 Oct 2023 12:51:20 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A8BE19C2A31;
	Thu, 19 Oct 2023 12:51:20 -0400 (EDT)
Date: Thu, 19 Oct 2023 12:51:20 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: Tim Orling <ticotimo@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Message-ID: <479117960.680150.1697734280326.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <CANx9H-AsiPDOTScyii-FmBzWJQterFaE4bZSrSO+iTVkyQiwXg@mail.gmail.com>
References: <20231004134415.11070-1-alassane.yattara@savoirfairelinux.com> <178D4218DDB89A92.29357@lists.openembedded.org> <CANx9H-AsiPDOTScyii-FmBzWJQterFaE4bZSrSO+iTVkyQiwXg@mail.gmail.com>
Subject: Re: [Toaster] [bitbake-devel] [PATCH] toaster: Monitoring -
 implement Django logging system
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC117 (Linux)/8.8.15_GA_3)
Thread-Topic: toaster: Monitoring - implement Django logging system
Thread-Index: CpLGZ4y1Os45SnBVvUOSw3T7snc5jA==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Oct 2023 16:51:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15265

Tim,

Seem OpenEmbedded user has not permission to log into bitbake/lib/toaster/l=
ogs,
Yes, I can use BUILDDIR instead of BASE_DIR as logging directory, but there=
 is no way to know if that work in container.

I'm trying to reproduce the issue, i cloned and run repos https://github.co=
m/crops/toaster-container master,=20
this pull crops/toaster:master, but I don't see logging system changes ther=
e.

Question:=20
- Is a way to pull a specific docker crops/toaster image that contain loggi=
ng system changes ?

Alassane

----- Mail original -----
De: "Tim Orling" <ticotimo@gmail.com>
=C3=80: "Alassane Yattara" <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Envoy=C3=A9: Jeudi 19 Octobre 2023 15:00:35
Objet: Re: [Toaster] [bitbake-devel] [PATCH] toaster: Monitoring - implemen=
t Django logging system

Unfortunately, this commit has broken running in a container.=20


The system will start.=20
Traceback (most recent call last):=20
File "/usr/lib/python3.8/logging/config.py", line 563, in configure=20
handler =3D self.configure_handler(handlers[name])=20
File "/usr/lib/python3.8/logging/config.py", line 744, in configure_handler=
=20
result =3D factory(**kwargs)=20
File "/usr/lib/python3.8/logging/handlers.py", line 200, in __init__=20
BaseRotatingHandler.__init__(self, filename, 'a', encoding, delay)=20
File "/usr/lib/python3.8/logging/handlers.py", line 55, in __init__=20
logging.FileHandler.__init__(self, filename, mode, encoding, delay)=20
File "/usr/lib/python3.8/logging/__init__.py", line 1147, in __init__=20
StreamHandler.__init__(self, self._open())=20
File "/usr/lib/python3.8/logging/__init__.py", line 1176, in _open=20
return open(self.baseFilename, self.mode, encoding=3Dself.encoding)=20
PermissionError: [Errno 13] Permission denied: '/home/usersetup/poky/bitbak=
e/lib/toaster/logs/api.log'=20

The above exception was the direct cause of the following exception:=20

Traceback (most recent call last):=20
File "/home/usersetup/poky/bitbake/bin/../lib/toaster/manage.py", line 16, =
in <module>=20
execute_from_command_line(sys.argv)=20
File "/opt/venv/lib/python3.8/site-packages/django/core/management/__init__=
.py", line 442, in execute_from_command_line=20
utility.execute()=20
File "/opt/venv/lib/python3.8/site-packages/django/core/management/__init__=
.py", line 416, in execute=20
django.setup()=20
File "/opt/venv/lib/python3.8/site-packages/django/__init__.py", line 19, i=
n setup=20
configure_logging(settings.LOGGING_CONFIG, settings.LOGGING)=20
File "/opt/venv/lib/python3.8/site-packages/django/utils/log.py", line 76, =
in configure_logging=20
logging_config_func(logging_settings)=20
File "/usr/lib/python3.8/logging/config.py", line 808, in dictConfig=20
dictConfigClass(config).configure()=20
File "/usr/lib/python3.8/logging/config.py", line 570, in configure=20
raise ValueError('Unable to configure handler '=20
ValueError: Unable to configure handler 'file_api'=20

The reason is that BASE_DIR is resolving to bitbake/lib/toaster and the log=
s are in this case are attempting to write to a read only file system.=20

When running locally, this works, but perhaps is not where OpenEmbedded use=
rs expect the logs to be:=20
$ ls bitbake/lib/toaster/logs=20
api.log toaster.log.2023-10-13 toaster.log.2023-10-16=20
django.log toaster.log.2023-10-14 toaster.log.2023-10-17=20
toaster.log toaster.log.2023-10-15=20

Previously, the logs were written into the build directory, like the toaste=
r_ui.log still is:=20
build-toaster-2/toaster_ui.log=20

This also pointed out an issue with the toaster script:=20
[ https://git.yoctoproject.org/poky/tree/bitbake/bin/toaster#n308 | https:/=
/git.yoctoproject.org/poky/tree/bitbake/bin/toaster#n308 ]=20
When we have a Python trace back, the code is not catching that there was a=
 failure to fully start nor fail.=20
e.g. "Successful start." was not output, but neither was "Toaster build ser=
ver not started."=20

The health check in [ https://github.com/crops/toaster-container/blob/maste=
r/tests/runtests.sh#L91 | https://github.com/crops/toaster-container/blob/m=
aster/tests/runtests.sh#L91 ] never sees "Successful start." so unfortunate=
ly, the test stage just eventually times out.=20

On Wed, Oct 11, 2023 at 9:35 PM Tim Orling via [ http://lists.openembedded.=
org/ | lists.openembedded.org ] <ticotimo=3D [ mailto:gmail.com@lists.opene=
mbedded.org | gmail.com@lists.openembedded.org ] > wrote:=20



i think this introduces a missing dependency in toaster-requirements.txt on=
 django-log-viewer or similar, as there is now a failure on [ https://githu=
b.com/crops/toaster-container | https://github.com/crops/toaster-container =
] for "master"=20
03:55:49 E: 0.862 File "<frozen importlib._bootstrap>", line 1014, in _gcd_=
import=20
03:55:49 E: 0.862 File "<frozen importlib._bootstrap>", line 991, in _find_=
and_load=20
03:55:49 E: 0.862 File "<frozen importlib._bootstrap>", line 973, in _find_=
and_load_unlocked=20
03:55:49 E: 0.862 ModuleNotFoundError: No module named 'log_viewer'"=20
"=20


On Wed, Oct 4, 2023 at 6:45 AM Alassane Yattara < [ mailto:alassane.yattara=
@savoirfairelinux.com | alassane.yattara@savoirfairelinux.com ] > wrote:=20


---=20
lib/toaster/bldcollector/views.py | 3 +=20
lib/toaster/logs/.gitignore | 1 +=20
lib/toaster/toastergui/views.py | 7 ++=20
lib/toaster/toastergui/widgets.py | 4 +=20
lib/toaster/toastermain/logs.py | 153 ++++++++++++++++++++++++++++=20
lib/toaster/toastermain/settings.py | 66 +++++-------=20
lib/toaster/toastermain/urls.py | 2 +=20
7 files changed, 198 insertions(+), 38 deletions(-)=20
create mode 100644 lib/toaster/logs/.gitignore=20
create mode 100644 lib/toaster/toastermain/logs.py=20

diff --git a/lib/toaster/bldcollector/views.py b/lib/toaster/bldcollector/v=
iews.py=20
index 04cd8b3d..bdf38ae6 100644=20
--- a/lib/toaster/bldcollector/views.py=20
+++ b/lib/toaster/bldcollector/views.py=20
@@ -14,8 +14,11 @@ import subprocess=20
import toastermain=20
from django.views.decorators.csrf import csrf_exempt=20

+from toastermain.logs import log_view_mixin=20
+=20

@csrf_exempt=20
+@log_view_mixin=20
def eventfile(request):=20
""" Receives a file by POST, and runs toaster-eventreply on this file """=
=20
if request.method !=3D "POST":=20
diff --git a/lib/toaster/logs/.gitignore b/lib/toaster/logs/.gitignore=20
new file mode 100644=20
index 00000000..e5ebf25a=20
--- /dev/null=20
+++ b/lib/toaster/logs/.gitignore=20
@@ -0,0 +1 @@=20
+*.log*=20
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views=
.py=20
index 552ff164..cc8517ba 100644=20
--- a/lib/toaster/toastergui/views.py=20
+++ b/lib/toaster/toastergui/views.py=20
@@ -34,6 +34,8 @@ import mimetypes=20

import logging=20

+from toastermain.logs import log_view_mixin=20
+=20
logger =3D logging.getLogger("toaster")=20

# Project creation and managed build enable=20
@@ -56,6 +58,7 @@ class MimeTypeFinder(object):=20
return guessed_type=20

# single point to add global values into the context before rendering=20
+@log_view_mixin=20
def toaster_render(request, page, context):=20
context['project_enable'] =3D project_enable=20
context['project_specific'] =3D is_project_specific=20
@@ -665,6 +668,7 @@ def recipe_packages(request, build_id, recipe_id):=20
return response=20

from django.http import HttpResponse=20
+@log_view_mixin=20
def xhr_dirinfo(request, build_id, target_id):=20
top =3D request.GET.get('start', '/')=20
return HttpResponse(_get_dir_entries(build_id, target_id, top), content_typ=
e =3D "application/json")=20
@@ -1612,6 +1616,7 @@ if True:=20

from django.views.decorators.csrf import csrf_exempt=20
@csrf_exempt=20
+ @log_view_mixin=20
def xhr_testreleasechange(request, pid):=20
def response(data):=20
return HttpResponse(jsonfilter(data),=20
@@ -1648,6 +1653,7 @@ if True:=20
except Exception as e:=20
return response({"error": str(e) })=20

+ @log_view_mixin=20
def xhr_configvaredit(request, pid):=20
try:=20
prj =3D Project.objects.get(id =3D pid)=20
@@ -1726,6 +1732,7 @@ if True:=20
return HttpResponse(json.dumps({"error":str(e) + "\n" + traceback.format_ex=
c()}), content_type =3D "application/json")=20


+ @log_view_mixin=20
def customrecipe_download(request, pid, recipe_id):=20
recipe =3D get_object_or_404(CustomImageRecipe, pk=3Drecipe_id)=20

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/wid=
gets.py=20
index 53696912..51ed153a 100644=20
--- a/lib/toaster/toastergui/widgets.py=20
+++ b/lib/toaster/toastergui/widgets.py=20
@@ -32,6 +32,7 @@ import re=20
import os=20

from toastergui.tablefilter import TableFilterMap=20
+from toastermain.logs import log_view_mixin=20

try:=20
from urllib import unquote_plus=20
@@ -84,6 +85,7 @@ class ToasterTable(TemplateView):=20

return context=20

+ @log_view_mixin=20
def get(self, request, *args, **kwargs):=20
if request.GET.get('format', None) =3D=3D 'json':=20

@@ -414,6 +416,7 @@ class ToasterTypeAhead(View):=20
def __init__(self, *args, **kwargs):=20
super(ToasterTypeAhead, self).__init__()=20

+ @log_view_mixin=20
def get(self, request, *args, **kwargs):=20
def response(data):=20
return HttpResponse(json.dumps(data,=20
@@ -469,6 +472,7 @@ class MostRecentBuildsView(View):=20

return False=20

+ @log_view_mixin=20
def get(self, request, *args, **kwargs):=20
"""=20
Returns a list of builds in JSON format.=20
diff --git a/lib/toaster/toastermain/logs.py b/lib/toaster/toastermain/logs=
.py=20
new file mode 100644=20
index 00000000..f9953982=20
--- /dev/null=20
+++ b/lib/toaster/toastermain/logs.py=20
@@ -0,0 +1,153 @@=20
+#!/usr/bin/env python3=20
+# -*- coding: utf-8 -*-=20
+=20
+import logging=20
+import json=20
+from pathlib import Path=20
+from django.http import HttpRequest=20
+=20
+BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent=20
+=20
+=20
+def log_api_request(request, response, view, logger_name=3D'api'):=20
+ """Helper function for LogAPIMixin"""=20
+=20
+ repjson =3D {=20
+ 'view': view,=20
+ 'path': request.path,=20
+ 'method': request.method,=20
+ 'status': response.status_code=20
+ }=20
+=20
+ logger =3D logging.getLogger(logger_name)=20
+ [ http://logger.info/ | logger.info ] (=20
+ json.dumps(repjson, indent=3D4, separators=3D(", ", " : "))=20
+ )=20
+=20
+=20
+def log_view_mixin(view):=20
+ def log_view_request(*args, **kwargs):=20
+ # get request from args else kwargs=20
+ request =3D None=20
+ if len(args) > 0:=20
+ for req in args:=20
+ if isinstance(req, HttpRequest):=20
+ request =3D req=20
+ break=20
+ elif request is None:=20
+ request =3D kwargs.get('request')=20
+=20
+ response =3D view(*args, **kwargs)=20
+ log_api_request(=20
+ request, response, request.resolver_match.view_name, 'toaster')=20
+ return response=20
+ return log_view_request=20
+=20
+=20
+=20
+class LogAPIMixin:=20
+ """Logs API requests=20
+=20
+ tested with:=20
+ - APIView=20
+ - ModelViewSet=20
+ - ReadOnlyModelViewSet=20
+ - GenericAPIView=20
+=20
+ Note: you can set `view_name` attribute in View to override get_view_name=
()=20
+ """=20
+=20
+ def get_view_name(self):=20
+ if hasattr(self, 'view_name'):=20
+ return self.view_name=20
+ return super().get_view_name()=20
+=20
+ def finalize_response(self, request, response, *args, **kwargs):=20
+ log_api_request(request, response, self.get_view_name())=20
+ return super().finalize_response(request, response, *args, **kwargs)=20
+=20
+=20
+LOGGING_SETTINGS =3D {=20
+ 'version': 1,=20
+ 'disable_existing_loggers': False,=20
+ 'filters': {=20
+ 'require_debug_false': {=20
+ '()': 'django.utils.log.RequireDebugFalse'=20
+ }=20
+ },=20
+ 'formatters': {=20
+ 'datetime': {=20
+ 'format': '%(asctime)s %(levelname)s %(message)s'=20
+ },=20
+ 'verbose': {=20
+ 'format': '{levelname} {asctime} {module} {name}.{funcName} {process:d} {=
thread:d} {message}',=20
+ 'datefmt': "%d/%b/%Y %H:%M:%S",=20
+ 'style': '{',=20
+ },=20
+ 'api': {=20
+ 'format': '\n{levelname} {asctime} {name}.{funcName}:\n{message}',=20
+ 'style': '{'=20
+ }=20
+ },=20
+ 'handlers': {=20
+ 'mail_admins': {=20
+ 'level': 'ERROR',=20
+ 'filters': ['require_debug_false'],=20
+ 'class': 'django.utils.log.AdminEmailHandler'=20
+ },=20
+ 'console': {=20
+ 'level': 'DEBUG',=20
+ 'class': 'logging.StreamHandler',=20
+ 'formatter': 'datetime',=20
+ },=20
+ 'file_django': {=20
+ 'level': 'INFO',=20
+ 'class': 'logging.handlers.TimedRotatingFileHandler',=20
+ 'filename': BASE_DIR / 'logs/django.log',=20
+ 'when': 'D', # interval type=20
+ 'interval': 1, # defaults to 1=20
+ 'backupCount': 10, # how many files to keep=20
+ 'formatter': 'verbose',=20
+ },=20
+ 'file_api': {=20
+ 'level': 'INFO',=20
+ 'class': 'logging.handlers.TimedRotatingFileHandler',=20
+ 'filename': BASE_DIR / 'logs/api.log',=20
+ 'when': 'D',=20
+ 'interval': 1,=20
+ 'backupCount': 10,=20
+ 'formatter': 'verbose',=20
+ },=20
+ 'file_toaster': {=20
+ 'level': 'INFO',=20
+ 'class': 'logging.handlers.TimedRotatingFileHandler',=20
+ 'filename': BASE_DIR / 'logs/toaster.log',=20
+ 'when': 'D',=20
+ 'interval': 1,=20
+ 'backupCount': 10,=20
+ 'formatter': 'verbose',=20
+ },=20
+ },=20
+ 'loggers': {=20
+ 'django.request': {=20
+ 'handlers': ['file_django', 'console'],=20
+ 'level': 'WARN',=20
+ 'propagate': True,=20
+ },=20
+ 'django': {=20
+ 'handlers': ['file_django', 'console'],=20
+ 'level': 'WARNING',=20
+ 'propogate': True,=20
+ },=20
+ 'toaster': {=20
+ 'handlers': ['file_toaster'],=20
+ 'level': 'INFO',=20
+ 'propagate': False,=20
+ },=20
+ 'api': {=20
+ 'handlers': ['file_api'],=20
+ 'level': 'INFO',=20
+ 'propagate': False,=20
+ }=20
+ }=20
+}=20
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/=
settings.py=20
index 609c85d9..b083cf58 100644=20
--- a/lib/toaster/toastermain/settings.py=20
+++ b/lib/toaster/toastermain/settings.py=20
@@ -9,6 +9,8 @@=20
# Django settings for Toaster project.=20

import os=20
+from pathlib import Path=20
+from toastermain.logs import LOGGING_SETTINGS=20

DEBUG =3D True=20

@@ -186,7 +188,13 @@ TEMPLATES =3D [=20
'django.template.loaders.app_directories.Loader',=20
#'django.template.loaders.eggs.Loader',=20
],=20
- 'string_if_invalid': InvalidString("%s"),=20
+ # [ https://docs.djangoproject.com/en/4.2/ref/templates/api/#how-invalid-=
variables-are-handled | https://docs.djangoproject.com/en/4.2/ref/templates=
/api/#how-invalid-variables-are-handled ]=20
+ # Generally, string_if_invalid should only be enabled in order to debug=
=20
+ # a specific template problem, then cleared once debugging is complete.=
=20
+ # If you assign a value other than '' to string_if_invalid,=20
+ # you will experience rendering problems with these templates and sites.=
=20
+ # 'string_if_invalid': InvalidString("%s"),=20
+ 'string_if_invalid': "",=20
'debug': DEBUG,=20
},=20
},=20
@@ -242,6 +250,9 @@ INSTALLED_APPS =3D (=20
'django.contrib.humanize',=20
'bldcollector',=20
'toastermain',=20
+=20
+ # 3rd-lib=20
+ "log_viewer",=20
)=20


@@ -302,43 +313,22 @@ for t in os.walk(os.path.dirname(currentdir)):=20
# the site admins on every HTTP 500 error when DEBUG=3DFalse.=20
# See [ http://docs.djangoproject.com/en/dev/topics/logging | http://docs.d=
jangoproject.com/en/dev/topics/logging ] for=20
# more details on how to customize your logging configuration.=20
-LOGGING =3D {=20
- 'version': 1,=20
- 'disable_existing_loggers': False,=20
- 'filters': {=20
- 'require_debug_false': {=20
- '()': 'django.utils.log.RequireDebugFalse'=20
- }=20
- },=20
- 'formatters': {=20
- 'datetime': {=20
- 'format': '%(asctime)s %(levelname)s %(message)s'=20
- }=20
- },=20
- 'handlers': {=20
- 'mail_admins': {=20
- 'level': 'ERROR',=20
- 'filters': ['require_debug_false'],=20
- 'class': 'django.utils.log.AdminEmailHandler'=20
- },=20
- 'console': {=20
- 'level': 'DEBUG',=20
- 'class': 'logging.StreamHandler',=20
- 'formatter': 'datetime',=20
- }=20
- },=20
- 'loggers': {=20
- 'toaster' : {=20
- 'handlers': ['console'],=20
- 'level': 'DEBUG',=20
- },=20
- 'django.request': {=20
- 'handlers': ['console'],=20
- 'level': 'WARN',=20
- 'propagate': True,=20
- },=20
- }=20
-}=20
+LOGGING =3D LOGGING_SETTINGS=20
+=20
+# Build paths inside the project like this: BASE_DIR / 'subdir'.=20
+BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent=20
+=20
+# LOG VIEWER=20
+# [ https://pypi.org/project/django-log-viewer/ | https://pypi.org/project=
/django-log-viewer/ ]=20
+LOG_VIEWER_FILES_PATTERN =3D '*.log*'=20
+LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, 'logs')=20
+LOG_VIEWER_PAGE_LENGTH =3D 25 # total log lines per-page=20
+LOG_VIEWER_MAX_READ_LINES =3D 100000 # total log lines will be read=20
+LOG_VIEWER_PATTERNS =3D ['INFO', 'DEBUG', 'WARNING', 'ERROR', 'CRITICAL']=
=20
+=20
+# Optionally you can set the next variables in order to customize the admi=
n:=20
+LOG_VIEWER_FILE_LIST_TITLE =3D "Logs list"=20
+=20

if DEBUG and SQL_DEBUG:=20
LOGGING['loggers']['django.db.backends'] =3D {=20
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls=
.py=20
index 03603026..3be46fcf 100644=20
--- a/lib/toaster/toastermain/urls.py=20
+++ b/lib/toaster/toastermain/urls.py=20
@@ -28,6 +28,8 @@ urlpatterns =3D [=20
# url(r'^admin/doc/', include('django.contrib.admindocs.urls')),=20


+ url(r'^logs/', include('log_viewer.urls')),=20
+=20
# This is here to maintain backward compatibility and will be deprecated=20
# in the future.=20
url(r'^orm/eventfile$', bldcollector.views.eventfile),=20
--=20
2.34.1=20









-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5881): https://lists.yoctoproject.org/g/toaster/message=
/5881
Mute This Topic: https://lists.yoctoproject.org/mt/102060497/7896845
Group Owner: toaster+owner@lists.yoctoproject.org
Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [alassane.yatta=
ra@savoirfairelinux.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

