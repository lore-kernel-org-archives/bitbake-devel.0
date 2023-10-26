Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1767CC25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 15:53:58 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.204042.1698335630123590422
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 08:53:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cNYYjRLC;
 spf=pass (domain: gmail.com, ip: 209.85.210.179, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6bd73395bceso793219b3a.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698335629; x=1698940429; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6KI75QaBk/l6LZNHAyvyi22nMl3o27BoeWwayfQiWc=;
        b=cNYYjRLCW0Ae0hJz5KsxzAluus3+rxx2DbGdQ4QTYsHnIDj/woBiMEksA75wO8plJf
         wxW/Htoo7CM8gMAG22cWc/OljiVo/9VbYKZaiAUVPZpO+L6ErbFKeRBqGO8GDSbrmMF4
         k+3szOsrMmRtDMMgqYVhaT2ObOQS68TRwqZFWoCGi4VrP3BlVWO4KS/lMqu+xZgGGs2W
         5cqjsndlqL0IVTteuxfQP/k3IeI/TdYTtjuX8UtcZ7zMhtAad+TLGr33wAs486N6dWBg
         Vzb35KhhxxldCWQwIm0n7YHU11fvJS5lhMu3hvlQ0FQ3DLH3F8K2lD1W8v1/GTpNbYqh
         MJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335629; x=1698940429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6KI75QaBk/l6LZNHAyvyi22nMl3o27BoeWwayfQiWc=;
        b=gx2iAH9hm6UBC+aHSAfkF+PjMx8RzAFdDci1eGKEGMmHidMjvnNDHbOfvC2LCCmCmb
         0nDyoiRA7SBmGN1duy4ZUgqHsPQVURaiL/k65LeKlJe+U7DwtFTMc0PnUXxDrB7IL8Us
         g1UvjEYyVfmNQU6nWnIFTFyHPS6tI34YpRopaqkbaijbKB2VeYHCy/7cJVsjeTl57Upg
         HEZIwXOFpOizAcT87EF8ql+ITS6NrGeOT3fzio2eSfr1dxDc5c3saNAMwOJqiu9e4k3V
         g7Q8jE3w1yzhYiOIuHKTFWSNWqe8eFnYDVbZbthu8L8UkKl/T0XM0G16A2k63N0mpHB2
         K/Mg==
X-Gm-Message-State: AOJu0YxTmy044m0++edzhiIbzcis4UTeQVnelXpygl9VAptSVq1Mj0LS
	JERPpOlyB492FpSlAbpJn/KvWH4YP9YJEw==
X-Google-Smtp-Source: AGHT+IHOvwPfVBf/TPdTGzfcQjH5ZfMaXGbz13m9HnqsaZPKKN+31j1hGGYpoN/FV8yJtzm/SP9XEA==
X-Received: by 2002:a05:6a00:3a03:b0:68f:ce6a:8685 with SMTP id fj3-20020a056a003a0300b0068fce6a8685mr182109pfb.14.1698335629096;
        Thu, 26 Oct 2023 08:53:49 -0700 (PDT)
Received: from chiron.hsd1.or.comcast.net ([2601:1c0:ca00:cea0:7b95:b952:8a12:4bc2])
        by smtp.gmail.com with ESMTPSA id y5-20020aa793c5000000b006926506de1csm11286767pff.28.2023.10.26.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:53:48 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: alassane.yattara@savoirfairelinux.com,
	Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH] toaster: write logs to BUILDDIR
Date: Thu, 26 Oct 2023 08:53:33 -0700
Message-Id: <20231026155333.16534-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 15:53:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15295

Fixes "2efb14648 toaster: Monitoring - implement Django logging system" when
running in a container.

When running in a container, the previous approach of using BASE_DIR
is not a writable path. Also, we really do not want to be writing logs into
the source tree, as the BASE_DIR was resolving to bitbake/lib/toaster/logs

Since Toaster is only ever running in an environment where oe-init-buildenv
or similar has been sourced, we should instead write the logs to BUILDDIR.
This is where the existing toaster_ui.log was already being written.

Drop the /logs/ directory, as it has not been created which also breaks
in a container environment. Instead, prepend the api.log, etc. with "toaster_"
and write them alongside the existing toaster_ui.log

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 lib/toaster/toastermain/logs.py     | 9 +++++----
 lib/toaster/toastermain/settings.py | 7 ++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastermain/logs.py b/lib/toaster/toastermain/logs.py
index b4910e443..5a296bc3f 100644
--- a/lib/toaster/toastermain/logs.py
+++ b/lib/toaster/toastermain/logs.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # -*- coding: utf-8 -*-
 
+import os
 import logging
 import json
 from pathlib import Path
 from django.http import HttpRequest
 
-BASE_DIR = Path(__file__).resolve(strict=True).parent.parent
+BUILDDIR = Path(os.environ.get('BUILDDIR'))
 
 
 def log_api_request(request, response, view, logger_name='api'):
@@ -108,7 +109,7 @@ LOGGING_SETTINGS = {
         'file_django': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/django.log',
+            'filename': BUILDDIR / 'toaster_django.log',
             'when': 'D',  # interval type
             'interval': 1,  # defaults to 1
             'backupCount': 10,  # how many files to keep
@@ -117,7 +118,7 @@ LOGGING_SETTINGS = {
         'file_api': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/api.log',
+            'filename': BUILDDIR / 'toaster_api.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
@@ -126,7 +127,7 @@ LOGGING_SETTINGS = {
         'file_toaster': {
             'level': 'INFO',
             'class': 'logging.handlers.TimedRotatingFileHandler',
-            'filename': BASE_DIR / 'logs/toaster.log',
+            'filename': BUILDDIR / 'toaster.log',
             'when': 'D',
             'interval': 1,
             'backupCount': 10,
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index b083cf588..c65f4b630 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -315,13 +315,14 @@ for t in os.walk(os.path.dirname(currentdir)):
 # more details on how to customize your logging configuration.
 LOGGING = LOGGING_SETTINGS
 
-# Build paths inside the project like this: BASE_DIR / 'subdir'.
-BASE_DIR = Path(__file__).resolve(strict=True).parent.parent
+# Rather than using BASE_DIR inside the source tree, we use
+# BUILDDIR which is exported by the bitbake environment
+BUILDDIR = os.environ.get("BUILDDIR")
 
 # LOG VIEWER
 # https://pypi.org/project/django-log-viewer/
 LOG_VIEWER_FILES_PATTERN = '*.log*'
-LOG_VIEWER_FILES_DIR = os.path.join(BASE_DIR, 'logs')
+LOG_VIEWER_FILES_DIR = BUILDDIR
 LOG_VIEWER_PAGE_LENGTH = 25      # total log lines per-page
 LOG_VIEWER_MAX_READ_LINES = 100000  # total log lines will be read
 LOG_VIEWER_PATTERNS = ['INFO', 'DEBUG', 'WARNING', 'ERROR', 'CRITICAL']
-- 
2.34.1


