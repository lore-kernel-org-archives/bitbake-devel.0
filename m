Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E3C25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 15:32:57 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.203551.1698334372655563765
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 08:32:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=tGdWcvy1;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 958459C2C3C
	for <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 11:32:51 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ZUM5owwtobbF; Thu, 26 Oct 2023 11:32:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0313E9C2CB2;
	Thu, 26 Oct 2023 11:32:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0313E9C2CB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698334371; bh=SusAWPqJkZsDDDsoUVFtBBrKrnHN8lq2LJWxEI4IbDw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=tGdWcvy1Yv65FJdTu85iLLIQ0AjPK1SiLNfY8gyoh6DwUk0+LB1goaVQI+UU2RnI2
	 dUZ1z0tReZ9Ga745vpadsD7oudfTkpRwYNVJbeAx0RN8kw/Oz0UmFhRs1YzmoFuW3l
	 SFSzSvjW5eJaSeW7xRMgMB1HnZKqDx5vSrgVmiKiRB2jjb0FlZgf3P+MD2y7uMqEk+
	 sz/6cPoBF4uavXdav7U1anHhet/BtNe9zU3Fxsuvxz+2QmRwevvCB8oJCmG7dtyDRb
	 xlFUQ4F8Mxb8DW+Ww+RKHmve+QrWZQu/aTZJCmh6ITJavtO4v80YmbltCHg0o6x3i+
	 DnVQSLnzMRQhA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id sBxPvoH3drcY; Thu, 26 Oct 2023 11:32:50 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1A1BB9C2C3C;
	Thu, 26 Oct 2023 11:32:49 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3] Toaster: Bug-fix logging permission error in docker
Date: Thu, 26 Oct 2023 16:32:20 +0100
Message-Id: <20231026153220.870484-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 15:32:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15294

Use BUILDDIR for logs
Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/toastermain/logs.py     | 9 +++++----
 lib/toaster/toastermain/settings.py | 5 +----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastermain/logs.py b/lib/toaster/toastermain/lo=
gs.py
index b4910e44..e73d9ff1 100644
--- a/lib/toaster/toastermain/logs.py
+++ b/lib/toaster/toastermain/logs.py
@@ -1,12 +1,13 @@
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
+BUILDDIR =3D Path(os.environ.get('BUILDDIR', '/tmp'))
=20
=20
 def log_api_request(request, response, view, logger_name=3D'api'):
@@ -108,7 +109,7 @@ LOGGING_SETTINGS =3D {
         'file_django': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/django.log',
+            'filename': BUILDDIR / 'django.log',
             'when': 'D',  # interval type
             'interval': 1,  # defaults to 1
             'backupCount': 10,  # how many files to keep
@@ -117,7 +118,7 @@ LOGGING_SETTINGS =3D {
         'file_api': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/api.log',
+            'filename': BUILDDIR / 'toaster_api.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
@@ -126,7 +127,7 @@ LOGGING_SETTINGS =3D {
         'file_toaster': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/toaster.log',
+            'filename': BUILDDIR / 'toaster.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermai=
n/settings.py
index b083cf58..bdf7b0b1 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -315,13 +315,10 @@ for t in os.walk(os.path.dirname(currentdir)):
 # more details on how to customize your logging configuration.
 LOGGING =3D LOGGING_SETTINGS
=20
-# Build paths inside the project like this: BASE_DIR / 'subdir'.
-BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
-
 # LOG VIEWER
 # https://pypi.org/project/django-log-viewer/
 LOG_VIEWER_FILES_PATTERN =3D '*.log*'
-LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, 'logs')
+LOG_VIEWER_FILES_DIR =3D Path(os.environ.get('BUILDDIR', '/tmp'))
 LOG_VIEWER_PAGE_LENGTH =3D 25      # total log lines per-page
 LOG_VIEWER_MAX_READ_LINES =3D 100000  # total log lines will be read
 LOG_VIEWER_PATTERNS =3D ['INFO', 'DEBUG', 'WARNING', 'ERROR', 'CRITICAL'=
]
--=20
2.34.1


