Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0784BE7B61B
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 13:45:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.18931.1696427114962669172
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Oct 2023 06:45:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=eHYYjAx1;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F18339C27A3
	for <bitbake-devel@lists.openembedded.org>; Wed,  4 Oct 2023 09:45:13 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MJjj92eJgVLk; Wed,  4 Oct 2023 09:45:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 785959C2B19;
	Wed,  4 Oct 2023 09:45:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 785959C2B19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1696427111; bh=0qMpVEEbEixAeLoJ3KpXjQoAHAoTgzwCFdb59GyFJUs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=eHYYjAx1n4wjiLjnUEwQp1cydHyp73GCR1SlSSgsIfTalj//Iqn6RLv6sVTFEky/A
	 K2yY889wScSp+vcCVrSIYyzU9azd3gdAl7qEbJGQfbpxADn0qLKm66WIhgLXN+xVvf
	 Z4FTJkMGBWA8E9MNZBx+0onJ+mwg0WKIkf+SydUt2nJF50+YciZOdFMwV4OwZVR2IN
	 wk9w1H+NpJZyAAsGE9Lierhi9r6/2rHVq4yn1i+g2AU2K8gOTEka2K/amCThee+Q9n
	 lH9HpUu/bDiQOBraSsZyAoXLo+tfYL4p79zJ8GYuslfXd846ITmrE61xi1pQl/JG5u
	 65CP6DqYvjx/A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id G1VE2HznELmc; Wed,  4 Oct 2023 09:45:11 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AA35C9C2AB7;
	Wed,  4 Oct 2023 09:45:10 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] toaster: Monitoring - implement Django logging system
Date: Wed,  4 Oct 2023 14:44:15 +0100
Message-Id: <20231004134415.11070-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Oct 2023 13:45:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15184

---
 lib/toaster/bldcollector/views.py   |   3 +
 lib/toaster/logs/.gitignore         |   1 +
 lib/toaster/toastergui/views.py     |   7 ++
 lib/toaster/toastergui/widgets.py   |   4 +
 lib/toaster/toastermain/logs.py     | 153 ++++++++++++++++++++++++++++
 lib/toaster/toastermain/settings.py |  66 +++++-------
 lib/toaster/toastermain/urls.py     |   2 +
 7 files changed, 198 insertions(+), 38 deletions(-)
 create mode 100644 lib/toaster/logs/.gitignore
 create mode 100644 lib/toaster/toastermain/logs.py

diff --git a/lib/toaster/bldcollector/views.py b/lib/toaster/bldcollector=
/views.py
index 04cd8b3d..bdf38ae6 100644
--- a/lib/toaster/bldcollector/views.py
+++ b/lib/toaster/bldcollector/views.py
@@ -14,8 +14,11 @@ import subprocess
 import toastermain
 from django.views.decorators.csrf import csrf_exempt
=20
+from toastermain.logs import log_view_mixin
+
=20
 @csrf_exempt
+@log_view_mixin
 def eventfile(request):
     """ Receives a file by POST, and runs toaster-eventreply on this fil=
e """
     if request.method !=3D "POST":
diff --git a/lib/toaster/logs/.gitignore b/lib/toaster/logs/.gitignore
new file mode 100644
index 00000000..e5ebf25a
--- /dev/null
+++ b/lib/toaster/logs/.gitignore
@@ -0,0 +1 @@
+*.log*
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/vie=
ws.py
index 552ff164..cc8517ba 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -34,6 +34,8 @@ import mimetypes
=20
 import logging
=20
+from toastermain.logs import log_view_mixin
+
 logger =3D logging.getLogger("toaster")
=20
 # Project creation and managed build enable
@@ -56,6 +58,7 @@ class MimeTypeFinder(object):
         return guessed_type
=20
 # single point to add global values into the context before rendering
+@log_view_mixin
 def toaster_render(request, page, context):
     context['project_enable'] =3D project_enable
     context['project_specific'] =3D is_project_specific
@@ -665,6 +668,7 @@ def recipe_packages(request, build_id, recipe_id):
     return response
=20
 from django.http import HttpResponse
+@log_view_mixin
 def xhr_dirinfo(request, build_id, target_id):
     top =3D request.GET.get('start', '/')
     return HttpResponse(_get_dir_entries(build_id, target_id, top), cont=
ent_type =3D "application/json")
@@ -1612,6 +1616,7 @@ if True:
=20
     from django.views.decorators.csrf import csrf_exempt
     @csrf_exempt
+    @log_view_mixin
     def xhr_testreleasechange(request, pid):
         def response(data):
             return HttpResponse(jsonfilter(data),
@@ -1648,6 +1653,7 @@ if True:
         except Exception as e:
             return response({"error": str(e) })
=20
+    @log_view_mixin
     def xhr_configvaredit(request, pid):
         try:
             prj =3D Project.objects.get(id =3D pid)
@@ -1726,6 +1732,7 @@ if True:
             return HttpResponse(json.dumps({"error":str(e) + "\n" + trac=
eback.format_exc()}), content_type =3D "application/json")
=20
=20
+    @log_view_mixin
     def customrecipe_download(request, pid, recipe_id):
         recipe =3D get_object_or_404(CustomImageRecipe, pk=3Drecipe_id)
=20
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/w=
idgets.py
index 53696912..51ed153a 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -32,6 +32,7 @@ import re
 import os
=20
 from toastergui.tablefilter import TableFilterMap
+from toastermain.logs import log_view_mixin
=20
 try:
     from urllib import unquote_plus
@@ -84,6 +85,7 @@ class ToasterTable(TemplateView):
=20
         return context
=20
+    @log_view_mixin
     def get(self, request, *args, **kwargs):
         if request.GET.get('format', None) =3D=3D 'json':
=20
@@ -414,6 +416,7 @@ class ToasterTypeAhead(View):
     def __init__(self, *args, **kwargs):
         super(ToasterTypeAhead, self).__init__()
=20
+    @log_view_mixin
     def get(self, request, *args, **kwargs):
         def response(data):
             return HttpResponse(json.dumps(data,
@@ -469,6 +472,7 @@ class MostRecentBuildsView(View):
=20
         return False
=20
+    @log_view_mixin
     def get(self, request, *args, **kwargs):
         """
         Returns a list of builds in JSON format.
diff --git a/lib/toaster/toastermain/logs.py b/lib/toaster/toastermain/lo=
gs.py
new file mode 100644
index 00000000..f9953982
--- /dev/null
+++ b/lib/toaster/toastermain/logs.py
@@ -0,0 +1,153 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+import logging
+import json
+from pathlib import Path
+from django.http import HttpRequest
+
+BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
+
+
+def log_api_request(request, response, view, logger_name=3D'api'):
+    """Helper function for LogAPIMixin"""
+
+    repjson =3D {
+        'view': view,
+        'path': request.path,
+        'method': request.method,
+        'status': response.status_code
+    }
+
+    logger =3D logging.getLogger(logger_name)
+    logger.info(
+        json.dumps(repjson, indent=3D4, separators=3D(", ", " : "))
+    )
+
+
+def log_view_mixin(view):
+    def log_view_request(*args, **kwargs):
+        # get request from args else kwargs
+        request =3D None
+        if len(args) > 0:
+            for req in args:
+                if isinstance(req, HttpRequest):
+                    request =3D req
+                    break=20
+        elif request is None:
+            request =3D kwargs.get('request')
+
+        response =3D view(*args, **kwargs)
+        log_api_request(
+            request, response, request.resolver_match.view_name, 'toaste=
r')
+        return response
+    return log_view_request
+
+
+
+class LogAPIMixin:
+    """Logs API requests
+
+    tested with:
+        - APIView
+        - ModelViewSet
+        - ReadOnlyModelViewSet
+        - GenericAPIView
+
+    Note: you can set `view_name` attribute in View to override get_view=
_name()
+    """
+
+    def get_view_name(self):
+        if hasattr(self, 'view_name'):
+            return self.view_name
+        return super().get_view_name()
+
+    def finalize_response(self, request, response, *args, **kwargs):
+        log_api_request(request, response, self.get_view_name())
+        return super().finalize_response(request, response, *args, **kwa=
rgs)
+
+
+LOGGING_SETTINGS =3D {
+    'version': 1,
+    'disable_existing_loggers': False,
+    'filters': {
+        'require_debug_false': {
+            '()': 'django.utils.log.RequireDebugFalse'
+        }
+    },
+    'formatters': {
+        'datetime': {
+            'format': '%(asctime)s %(levelname)s %(message)s'
+        },
+        'verbose': {
+            'format': '{levelname} {asctime} {module} {name}.{funcName} =
{process:d} {thread:d} {message}',
+            'datefmt': "%d/%b/%Y %H:%M:%S",
+            'style': '{',
+        },
+        'api': {
+            'format': '\n{levelname} {asctime} {name}.{funcName}:\n{mess=
age}',
+            'style': '{'
+        }
+    },
+    'handlers': {
+        'mail_admins': {
+            'level': 'ERROR',
+            'filters': ['require_debug_false'],
+            'class': 'django.utils.log.AdminEmailHandler'
+        },
+        'console': {
+            'level': 'DEBUG',
+            'class': 'logging.StreamHandler',
+            'formatter': 'datetime',
+        },
+        'file_django': {
+            'level': 'INFO',
+            'class': 'logging.handlers.TimedRotatingFileHandler',
+            'filename': BASE_DIR / 'logs/django.log',
+            'when': 'D',  # interval type
+            'interval': 1,  # defaults to 1
+            'backupCount': 10,  # how many files to keep
+            'formatter': 'verbose',
+        },
+        'file_api': {
+            'level': 'INFO',
+            'class': 'logging.handlers.TimedRotatingFileHandler',
+            'filename': BASE_DIR / 'logs/api.log',
+            'when': 'D',
+            'interval': 1,
+            'backupCount': 10,
+            'formatter': 'verbose',
+        },
+        'file_toaster': {
+            'level': 'INFO',
+            'class': 'logging.handlers.TimedRotatingFileHandler',
+            'filename': BASE_DIR / 'logs/toaster.log',
+            'when': 'D',
+            'interval': 1,
+            'backupCount': 10,
+            'formatter': 'verbose',
+        },
+    },
+    'loggers': {
+        'django.request': {
+            'handlers': ['file_django', 'console'],
+            'level': 'WARN',
+            'propagate': True,
+        },
+        'django': {
+            'handlers': ['file_django', 'console'],
+            'level': 'WARNING',
+            'propogate': True,
+        },
+        'toaster': {
+            'handlers': ['file_toaster'],
+            'level': 'INFO',
+            'propagate': False,
+        },
+        'api': {
+            'handlers': ['file_api'],
+            'level': 'INFO',
+            'propagate': False,
+        }
+    }
+}
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermai=
n/settings.py
index 609c85d9..b083cf58 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -9,6 +9,8 @@
 # Django settings for Toaster project.
=20
 import os
+from pathlib import Path
+from toastermain.logs import LOGGING_SETTINGS
=20
 DEBUG =3D True
=20
@@ -186,7 +188,13 @@ TEMPLATES =3D [
                 'django.template.loaders.app_directories.Loader',
                 #'django.template.loaders.eggs.Loader',
             ],
-            'string_if_invalid': InvalidString("%s"),
+            # https://docs.djangoproject.com/en/4.2/ref/templates/api/#h=
ow-invalid-variables-are-handled
+            # Generally, string_if_invalid should only be enabled in ord=
er to debug
+            # a specific template problem, then cleared once debugging i=
s complete.
+            # If you assign a value other than '' to string_if_invalid,
+            # you will experience rendering problems with these template=
s and sites.
+            #  'string_if_invalid': InvalidString("%s"),
+            'string_if_invalid': "",
             'debug': DEBUG,
         },
     },
@@ -242,6 +250,9 @@ INSTALLED_APPS =3D (
     'django.contrib.humanize',
     'bldcollector',
     'toastermain',
+
+    # 3rd-lib
+    "log_viewer",
 )
=20
=20
@@ -302,43 +313,22 @@ for t in os.walk(os.path.dirname(currentdir)):
 # the site admins on every HTTP 500 error when DEBUG=3DFalse.
 # See http://docs.djangoproject.com/en/dev/topics/logging for
 # more details on how to customize your logging configuration.
-LOGGING =3D {
-    'version': 1,
-    'disable_existing_loggers': False,
-    'filters': {
-        'require_debug_false': {
-            '()': 'django.utils.log.RequireDebugFalse'
-        }
-    },
-    'formatters': {
-        'datetime': {
-            'format': '%(asctime)s %(levelname)s %(message)s'
-        }
-    },
-    'handlers': {
-        'mail_admins': {
-            'level': 'ERROR',
-            'filters': ['require_debug_false'],
-            'class': 'django.utils.log.AdminEmailHandler'
-        },
-        'console': {
-            'level': 'DEBUG',
-            'class': 'logging.StreamHandler',
-            'formatter': 'datetime',
-        }
-    },
-    'loggers': {
-        'toaster' : {
-            'handlers': ['console'],
-            'level': 'DEBUG',
-        },
-        'django.request': {
-            'handlers': ['console'],
-            'level': 'WARN',
-            'propagate': True,
-        },
-    }
-}
+LOGGING =3D LOGGING_SETTINGS
+
+# Build paths inside the project like this: BASE_DIR / 'subdir'.
+BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
+
+# LOG VIEWER
+# https://pypi.org/project/django-log-viewer/
+LOG_VIEWER_FILES_PATTERN =3D '*.log*'
+LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, 'logs')
+LOG_VIEWER_PAGE_LENGTH =3D 25      # total log lines per-page
+LOG_VIEWER_MAX_READ_LINES =3D 100000  # total log lines will be read
+LOG_VIEWER_PATTERNS =3D ['INFO', 'DEBUG', 'WARNING', 'ERROR', 'CRITICAL'=
]
+
+# Optionally you can set the next variables in order to customize the ad=
min:
+LOG_VIEWER_FILE_LIST_TITLE =3D "Logs list"
+
=20
 if DEBUG and SQL_DEBUG:
     LOGGING['loggers']['django.db.backends'] =3D {
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/ur=
ls.py
index 03603026..3be46fcf 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -28,6 +28,8 @@ urlpatterns =3D [
     # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
=20
=20
+    url(r'^logs/', include('log_viewer.urls')),
+
     # This is here to maintain backward compatibility and will be deprec=
ated
     # in the future.
     url(r'^orm/eventfile$', bldcollector.views.eventfile),
--=20
2.34.1


