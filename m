Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53932C25B67
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 00:36:54 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.86739.1698367012546306479
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 17:36:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=yYPExjo8;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C05F39C2BF6;
	Thu, 26 Oct 2023 20:36:51 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1uSdFNN1yrIa; Thu, 26 Oct 2023 20:36:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CA5F89C2D14;
	Thu, 26 Oct 2023 20:36:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CA5F89C2D14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698367010; bh=U4d4MnAoljGr2sK3zqb6nfHXGB+wws2m2tsdoLTzoAs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=yYPExjo82XHoQgelTytcv4gdrV1qp18N2oMkAfiJ3XXGc0Fa2mkrsL3QN3PvBWGXT
	 P5+tq60lSJdCsSyDFOUEqvPtvesL6iPe4DASGHDUr0xmXOUN2JhHrQPxhIbHaDs7KN
	 Ym8pIPlzjw70ygvV/VFNF+uxT16bkiwcqDpzKoLFRHat50SR1Nla2fPCM3Hm/xw3tu
	 6m+80rtgAtOHe951gvRTp6IrG+Pb6tktl0pzRE9uN2w+ccolOIfqPVKkaXbbbUWSaj
	 FD17gju/zvI+XJ2J1xt/lqGaZ5OrtOxU79M3EYr3oWnaS/AjvhNilTu5UJR16GjfV4
	 q5WqlpqNnGG6g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YbLaew3X4Y90; Thu, 26 Oct 2023 20:36:50 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D19C59C2BF6;
	Thu, 26 Oct 2023 20:36:49 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>,
	Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] Toaster: Write logs to BUILDDIR/toaster_logs
Date: Fri, 27 Oct 2023 01:36:46 +0100
Message-Id: <20231027003646.1434696-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Oct 2023 00:36:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15300

Fixes "2efb14648 toaster: Monitoring - implement Django logging system" w=
hen
running in a container.

When running in a container, the previous approach of using BASE_DIR
is not a writable path. Also, we really do not want to be writing logs in=
to
the source tree, as the BASE_DIR was resolving to bitbake/lib/toaster/log=
s

Since Toaster is only ever running in an environment where oe-init-builde=
nv
or similar has been sourced, we should instead write the logs to BUILDDIR=
.

Using BUILDDIR to logs make path writable but django-log-viewer does'nt m=
anage
to write logs using an absolute path as BUILDDIR, where the existing toas=
ter_ui.log
was already being written.

Also drop the /logs/ directory, as it has not been created which also bre=
aks
in a container environment

To handle the constraints linked to django-log-viewer and /logs/, we've u=
pdated
bitbake/bin/toaster to create a toaster_logs/ directory in BUILDDIR if it=
 doesn't exist,
when toaster starts up.

Also manage to set BUILDDIR/toaster_logs/ as default location for toaster=
 logs.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 bin/toaster                         | 12 ++++++++++--
 lib/toaster/toastermain/logs.py     | 10 +++++-----
 lib/toaster/toastermain/settings.py |  4 ++--
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 558a8195..f002c8c1 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -84,7 +84,7 @@ webserverStartAll()
     echo "Starting webserver..."
=20
     $MANAGE runserver --noreload "$ADDR_PORT" \
-           </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
+           </dev/null >>${TOASTER_LOGS_DIR}/web.log 2>&1 \
            & echo $! >${BUILDDIR}/.toastermain.pid
=20
     sleep 1
@@ -181,6 +181,14 @@ WEBSERVER=3D1
 export TOASTER_BUILDSERVER=3D1
 ADDR_PORT=3D"localhost:8000"
 TOASTERDIR=3D`dirname $BUILDDIR`
+# ${BUILDDIR}/toaster_logs/ became the default location for toaster logs
+# This is needed for implemented django-log-viewer: https://pypi.org/pro=
ject/django-log-viewer/
+# If the directory does not exist, create it.
+TOASTER_LOGS_DIR=3D"${BUILDDIR}/toaster_logs/"
+if [ ! -d $TOASTER_LOGS_DIR ]
+then
+    mkdir $TOASTER_LOGS_DIR
+fi
 unset CMD
 for param in $*; do
     case $param in
@@ -299,7 +307,7 @@ case $CMD in
         export BITBAKE_UI=3D'toasterui'
         if [ $TOASTER_BUILDSERVER -eq 1 ] ; then
             $MANAGE runbuilds \
-               </dev/null >>${BUILDDIR}/toaster_runbuilds.log 2>&1 \
+               </dev/null >>${TOASTER_LOGS_DIR}/toaster_runbuilds.log 2>=
&1 \
                & echo $! >${BUILDDIR}/.runbuilds.pid
         else
             echo "Toaster build server not started."
diff --git a/lib/toaster/toastermain/logs.py b/lib/toaster/toastermain/lo=
gs.py
index b4910e44..62d87196 100644
--- a/lib/toaster/toastermain/logs.py
+++ b/lib/toaster/toastermain/logs.py
@@ -1,13 +1,13 @@
 #!/usr/bin/env python3
 # -*- coding: utf-8 -*-
=20
+import os
 import logging
 import json
 from pathlib import Path
 from django.http import HttpRequest
=20
-BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
-
+BUILDDIR =3D Path(os.environ.get('BUILDDIR', '/tmp'))
=20
 def log_api_request(request, response, view, logger_name=3D'api'):
     """Helper function for LogAPIMixin"""
@@ -108,7 +108,7 @@ LOGGING_SETTINGS =3D {
         'file_django': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/django.log',
+            'filename': BUILDDIR / 'toaster_logs/django.log',
             'when': 'D',  # interval type
             'interval': 1,  # defaults to 1
             'backupCount': 10,  # how many files to keep
@@ -117,7 +117,7 @@ LOGGING_SETTINGS =3D {
         'file_api': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/api.log',
+            'filename': BUILDDIR / 'toaster_logs/api.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
@@ -126,7 +126,7 @@ LOGGING_SETTINGS =3D {
         'file_toaster': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/toaster.log',
+            'filename': BUILDDIR / 'toaster_logs/web.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermai=
n/settings.py
index b083cf58..5de881c4 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -316,12 +316,12 @@ for t in os.walk(os.path.dirname(currentdir)):
 LOGGING =3D LOGGING_SETTINGS
=20
 # Build paths inside the project like this: BASE_DIR / 'subdir'.
-BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
+BUILDDIR =3D os.environ.get("BUILDDIR", "/tmp")
=20
 # LOG VIEWER
 # https://pypi.org/project/django-log-viewer/
 LOG_VIEWER_FILES_PATTERN =3D '*.log*'
-LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, 'logs')
+LOG_VIEWER_FILES_DIR =3D os.path.join(BUILDDIR, "toaster_logs/")
 LOG_VIEWER_PAGE_LENGTH =3D 25      # total log lines per-page
 LOG_VIEWER_MAX_READ_LINES =3D 100000  # total log lines will be read
 LOG_VIEWER_PATTERNS =3D ['INFO', 'DEBUG', 'WARNING', 'ERROR', 'CRITICAL'=
]
--=20
2.34.1


