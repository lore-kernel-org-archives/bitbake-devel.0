Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09B1C7619A
	for <webhook@archiver.kernel.org>; Sat, 15 Apr 2023 15:30:07 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.10575.1681572598626399749
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Apr 2023 08:29:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20221208.gappssmtp.com header.s=20221208 header.b=3abhgYvO;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.52, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f52.google.com with SMTP id w11so21776555pjh.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 15 Apr 2023 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20221208.gappssmtp.com; s=20221208; t=1681572598; x=1684164598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0ejQ+WaQvXtG3/rlnMeIJjFZafOPSGBKubmeaUMIHI=;
        b=3abhgYvOskqYjIcQgB822GDHTwkgvaXktmgLjVYsuq4R4YWBv0FQPRXWrX/c8YKYkr
         5VPKwqFOsN1W+Q2HZh/Zy6SeDf/iGgCDYs+7fRpOllzuziBrGtzB6CFRLHnxNearM6B/
         PzIrBBkf+KgBn7wPOvivMfvQT8hsjRmrEgopd1KHDAwROHwvEeLCXLIbKE+FpzdG+1Fn
         kC1iTDxh2pPTRPiOD1wcmWCzQWWhBDY2dfYbu/DWnWqX01peNLOOPjvCJZT+lyMNfd0C
         CXifMXs2F7fb8x1kStFPzZZrqy0qZ9xDyU+ojXnIGxCg+pGYyFmKQ/I78eZuKD+OQVeV
         52bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681572598; x=1684164598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0ejQ+WaQvXtG3/rlnMeIJjFZafOPSGBKubmeaUMIHI=;
        b=BEi286tiyVKnVzm/JKKc2shIfR8nD63xlaS8JqDa3FpBJB4rrpwQ2cBV4QIVoDYGSh
         kUhiChTLlCoa9P0Z+HvmIChrN053SZ4MujnqPN5bCOuxYU5mluEGFm5AQ62A2+iuAmcP
         Rk1DJSVCQWDQaD2Y7Tn97/398IbJGgfgcHhYWgAlIn9lleBDAs/4bUlqckZHMyjVNZna
         fO01PkLbhYgQWqEWarkHLZAiBdVZR1g6GjjCKAJrUAP7lYZcykInbY405wJuJKLcAScx
         b5bBdOaRFeRy24AkbTT5rT3S/9UEbxHKCs+Ll8u/JJ3/tqYnk5jh4eKgbLBk+dgBvee+
         Dv0Q==
X-Gm-Message-State: AAQBX9fiA3LTRxz1TgE4kjZYI7byVu7P2FQBxL80gZJeGKaqybMWN7dU
	Viz7aJBROSsQiqA0IOGZK33cv3e+OxETqo3UBKE=
X-Google-Smtp-Source: AKy350bKBmlFI8U57GY+hI10ZLe/prks3QLtsrb6lthgehXtwfN2aNNyV+v740seSJSTP44stybTRg==
X-Received: by 2002:a17:902:dac1:b0:1a6:4cbc:1504 with SMTP id q1-20020a170902dac100b001a64cbc1504mr8157202plx.60.1681572597640;
        Sat, 15 Apr 2023 08:29:57 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902be0a00b001a5240aa535sm4794819pls.37.2023.04.15.08.29.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 08:29:57 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/1] bin/utils: Ensure locale en_US.UTF-8 is available on the system
Date: Sat, 15 Apr 2023 05:29:49 -1000
Message-Id: <0c6f86b60cfba67c20733516957c0a654eb2b44c.1681572491.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1681572491.git.steve@sakoman.com>
References: <cover.1681572491.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Apr 2023 15:30:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14703

From: Frank de Brabander <debrabander@gmail.com>

Get rid of the duplicate code and add extra check that the
locale en_US.UTF-8 is available on the system. This new helper
method is now located right above the method filter_environment()
which sets LC_ALL environment variable to 'en_US.UTF-8'.

[YOCTO #10165]

Signed-off-by: Frank de Brabander <debrabander@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a4ce040a6fd540a1cac52f808f909f9fcf8c961c)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 bin/bitbake        |  3 +--
 bin/bitbake-server |  5 +++--
 bin/bitbake-worker |  3 +--
 lib/bb/utils.py    | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 042c9180..0b9cc629 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -25,8 +25,7 @@ except RuntimeError as exc:
 from bb import cookerdata
 from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
-if sys.getfilesystemencoding() != "utf-8":
-    sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
+bb.utils.check_system_locale()
 
 __version__ = "2.0.0"
 
diff --git a/bin/bitbake-server b/bin/bitbake-server
index f53f88b6..d00bb068 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -12,8 +12,9 @@ warnings.simplefilter("default")
 import logging
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
-if sys.getfilesystemencoding() != "utf-8":
-    sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
+import bb
+
+bb.utils.check_system_locale()
 
 # Users shouldn't be running this code directly
 if len(sys.argv) != 10 or not sys.argv[1].startswith("decafbad"):
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 2f3e9f72..5e62bc20 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -24,8 +24,7 @@ import subprocess
 from multiprocessing import Lock
 from threading import Thread
 
-if sys.getfilesystemencoding() != "utf-8":
-    sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
+bb.utils.check_system_locale()
 
 # Users shouldn't be running this code directly
 if len(sys.argv) != 2 or not sys.argv[1].startswith("decafbad"):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index cdb3c686..3f7f82d1 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -13,6 +13,7 @@ import errno
 import logging
 import bb
 import bb.msg
+import locale
 import multiprocessing
 import fcntl
 import importlib
@@ -606,6 +607,21 @@ def preserved_envvars():
     ]
     return v + preserved_envvars_exported()
 
+def check_system_locale():
+    """Make sure the required system locale are available and configured"""
+    default_locale = locale.getlocale(locale.LC_CTYPE)
+
+    try:
+        locale.setlocale(locale.LC_CTYPE, ("en_US", "UTF-8"))
+    except:
+        sys.exit("Please make sure locale 'en_US.UTF-8' is available on your system")
+    else:
+        locale.setlocale(locale.LC_CTYPE, default_locale)
+
+    if sys.getfilesystemencoding() != "utf-8":
+        sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\n"
+                 "Python can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
+
 def filter_environment(good_vars):
     """
     Create a pristine environment for bitbake. This will remove variables that
-- 
2.34.1


