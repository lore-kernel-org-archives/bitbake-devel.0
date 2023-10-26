Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551BDC25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 14:05:47 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.71438.1698329139715946284
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 07:05:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Rq4U92Dn;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6EBCA9C29B3;
	Thu, 26 Oct 2023 10:05:38 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CeBHcSeUJ4Xt; Thu, 26 Oct 2023 10:05:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B19789C2D0E;
	Thu, 26 Oct 2023 10:05:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B19789C2D0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698329137; bh=8ym42zoo+WidPdgMhxuC7AtOcHckYkV+n9gQQNFfZuM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Rq4U92Dn7xDMU8+g8aWUY4i2HBimMG+4A4rHeVDiQXXAMzkHR96RNshf5APQuOVYI
	 8sFpljASjRRmFsn5ewQcY4WAkM+sDSu0/Yxlz4/MWmWkUL0F7+rfli+5Pwr4SakddD
	 +tL6tXoK8mCvEqREmF2XB7KrYiz5kzPerRiYYQ7uKXHjyCbKYzZYOPsYXtbAb47Us8
	 dB3gYD3A3PLnxk+EtfD0Pqjdc3/vWjA/SDGcfalHiFeeVW51BvsMbdSVQ/+h2Z2EVs
	 RyV8RFxOGPdDuqhAERJStaKpbu1tnMgNzE2Gp78xOsRSYx2YduaPYewdOovfq6ZgNa
	 5LBmjlufQn+Yw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 67bCds8eM_eD; Thu, 26 Oct 2023 10:05:37 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A02F69C29B3;
	Thu, 26 Oct 2023 10:05:36 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>,
	Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/3] Bug-fix logging permission error in docker
Date: Thu, 26 Oct 2023 15:04:51 +0100
Message-Id: <20231026140453.790676-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 14:05:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15287

From: Tim Orling <tim.orling@konsulko.com>

toastermain: use BUILDDIR for logs

Developer: Tim Orling
Reviewer: Alassane Yattara

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 bitbake/lib/toaster/toastermain/logs.py     | 10 ++++++----
 bitbake/lib/toaster/toastermain/settings.py |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/toaster/toastermain/logs.py b/bitbake/lib/toaste=
r/toastermain/logs.py
index b4910e4432..db5d459f9b 100644
--- a/bitbake/lib/toaster/toastermain/logs.py
+++ b/bitbake/lib/toaster/toastermain/logs.py
@@ -1,12 +1,14 @@
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
+#BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
+BUILDDIR =3D os.environ.get("BUILDDIR")
=20
=20
 def log_api_request(request, response, view, logger_name=3D'api'):
@@ -108,7 +110,7 @@ LOGGING_SETTINGS =3D {
         'file_django': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/django.log',
+            'filename': BUILDDIR / 'logs/django.log',
             'when': 'D',  # interval type
             'interval': 1,  # defaults to 1
             'backupCount': 10,  # how many files to keep
@@ -117,7 +119,7 @@ LOGGING_SETTINGS =3D {
         'file_api': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/api.log',
+            'filename': BUILDDIR / 'logs/api.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
@@ -126,7 +128,7 @@ LOGGING_SETTINGS =3D {
         'file_toaster': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/toaster.log',
+            'filename': BUILDDIR / 'logs/toaster.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
diff --git a/bitbake/lib/toaster/toastermain/settings.py b/bitbake/lib/to=
aster/toastermain/settings.py
index b083cf5885..50b873cb49 100644
--- a/bitbake/lib/toaster/toastermain/settings.py
+++ b/bitbake/lib/toaster/toastermain/settings.py
@@ -316,12 +316,13 @@ for t in os.walk(os.path.dirname(currentdir)):
 LOGGING =3D LOGGING_SETTINGS
=20
 # Build paths inside the project like this: BASE_DIR / 'subdir'.
-BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
+#BASE_DIR =3D Path(__file__).resolve(strict=3DTrue).parent.parent
+BUILDDIR =3D os.environ.get("BUILDDIR")
=20
 # LOG VIEWER
 # https://pypi.org/project/django-log-viewer/
 LOG_VIEWER_FILES_PATTERN =3D '*.log*'
-LOG_VIEWER_FILES_DIR =3D os.path.join(BASE_DIR, 'logs')
+LOG_VIEWER_FILES_DIR =3D os.path.join(BUILDDIR, 'logs')
 LOG_VIEWER_PAGE_LENGTH =3D 25      # total log lines per-page
 LOG_VIEWER_MAX_READ_LINES =3D 100000  # total log lines will be read
 LOG_VIEWER_PATTERNS =3D ['INFO', 'DEBUG', 'WARNING', 'ERROR', 'CRITICAL'=
]
--=20
2.34.1


