Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BFCC02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 03:09:07 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.34523.1737515335711406659
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 19:08:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=xbab9NFc;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21636268e43so140583455ad.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 19:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1737515335; x=1738120135; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0ZwE7ByCjuia0Q5BsD6SbLdbUQvok2z2Bzgc1HHLaI=;
        b=xbab9NFchRG4CgQUjxVHJvugmPIGJGQP2R2P9iHpVvAF9s94Q2Mb0YKujllwtCrweO
         XnInjKwLNunwIpEcVSTVeixWvH85tTwD/OpyU2ekC5gau6XvaABQx3cMoDt0belGNIUX
         sL9Yj+nc1sJyCxjga3nvPT8gvenTr6b8vIZlCDGqwcHRHHVyOzERdnFm8qny6cQTnvyG
         6uP1pFiKZqAescdm2u1pfQOj3TsWHHNdhfXOvpRFtpifQIx0x1X35yGsll7ZlDx3d0b/
         hj9MH3Hn3KHGfHcoyOHDW1yuU7cG+mYfiJGumPgmfsQ19EKkHLTakP7nn2Ai+k169kGx
         D8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737515335; x=1738120135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0ZwE7ByCjuia0Q5BsD6SbLdbUQvok2z2Bzgc1HHLaI=;
        b=SPxlPQtMyOb8x+i9qml/5v3ZIrYZg7frgmUliZmeOpW7WTXiEjhwhaoHrTaZ6Af6Wn
         v7Xo+gTfgM+tyYfO5vmBCzIGbt1fgG2yFUNI8TaA9H8Mjttc3qk8EfhVU2ooZ+qV9DfA
         YKUMjmcHGaljBmKnnxQUfjI+EviCfUdUy2e1rN0qak+AU7iHAbPMqADdKM7foMHnxOQ6
         V4RKiKtnXHL3jyoPxOqdYqrkHekOd6IUIfBF5m2ESt+Y7nh/EDiflDEGYP8GptxAxv4z
         YCadt6TeG+iuuKC90s4znLKJXU1li1FSGUUliG+RWbgfV5JdZCwaUH9wUzM0eFIp2/Ar
         wpYg==
X-Gm-Message-State: AOJu0YwdEZKnHrRhKTKQGuEmSlDffySRj066++z/i56ufaDGEmhaDe9S
	xw3HQKYPa5hvkRJrH5I3t6pZzozUkkQQkjJgt/4okTC/g1R5+AdiA2uZYma16QvUldPyP/o6Gl4
	wWUk=
X-Gm-Gg: ASbGncu2PDAb1gd9bmHnOVBMgh1QtmtDEE0NhxuY4BHtXaOCf9FtN3RW3BzoU8qzRoc
	r+nCSDsooqy84KlxvIItZmIWwzCYYi81jaj6SflfYFE6jznGB6HPV6WPwvJMqTn8OTqN45gaT3c
	FA6bv6a0XrtndhbNlzu2p7zrqgAA1cpZZ/IxzcZJMyXC1sgLs8If+jzbf4XSKv1g8g3CrZFSEYK
	m+5wT2c/HbMJmHkqdXxBrQRexMDzEtRzKAJ7l+RjDRW59C0JZ9+bdsOwrY=
X-Google-Smtp-Source: AGHT+IHR0DEDLoSd27Jfy0dlml98T2yKIRKXADI1VGjM3dXW8BgjSh0rGn1u+kE/jIsi37z1ebUu1w==
X-Received: by 2002:a05:6a20:2453:b0:1e1:af9e:2779 with SMTP id adf61e73a8af0-1eb214f073cmr30973726637.22.1737515335022;
        Tue, 21 Jan 2025 19:08:55 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm10050820b3a.66.2025.01.21.19.08.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 19:08:54 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/3] ui/knotty: respect NO_COLOR & check for tty; rename print_hyperlink => format_hyperlink
Date: Tue, 21 Jan 2025 19:08:45 -0800
Message-ID: <72a334d5d5763476d5421a902fabb303f3f84bd8.1737515198.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737515198.git.steve@sakoman.com>
References: <cover.1737515198.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 03:09:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17054

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/knotty.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 5956ab177..3784c93ad 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -577,6 +577,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     else:
         log_exec_tty = False
 
+    should_print_hyperlinks = sys.stdout.isatty() and os.environ.get('NO_COLOR', '') == ''
+
     helper = uihelper.BBUIHelper()
 
     # Look for the specially designated handlers which need to be passed to the
@@ -944,10 +946,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     try:
         termfilter.clearFooter()
         summary = ""
-        def print_hyperlink(url, link_text):
-            start = f'\033]8;;{url}\033\\'
-            end = '\033]8;;\033\\'
-            return f'{start}{link_text}{end}'
+        def format_hyperlink(url, link_text):
+            if should_print_hyperlinks:
+                start = f'\033]8;;{url}\033\\'
+                end = '\033]8;;\033\\'
+                return f'{start}{link_text}{end}'
+            return link_text
 
         if taskfailures:
             summary += pluralise("\nSummary: %s task failed:",
@@ -955,7 +959,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             for (failure, log_file) in taskfailures.items():
                 summary += "\n  %s" % failure
                 if log_file:
-                    hyperlink = print_hyperlink(f"file://{log_file}", log_file)
+                    hyperlink = format_hyperlink(f"file://{log_file}", log_file)
                     summary += "\n    log: {}".format(hyperlink)
         if warnings:
             summary += pluralise("\nSummary: There was %s WARNING message.",
-- 
2.43.0


