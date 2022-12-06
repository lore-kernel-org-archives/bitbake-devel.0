Return-Path: <debrabander@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0F2C63704
	for <webhook@archiver.kernel.org>; Tue,  6 Dec 2022 18:19:53 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.55813.1670350784617777565
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Dec 2022 10:19:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=IUai/qCr;
 spf=pass (domain: gmail.com, ip: 209.85.218.43, mailfrom: debrabander@gmail.com)
Received: by mail-ej1-f43.google.com with SMTP id b2so8213131eja.7
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Dec 2022 10:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IWLAgw86JkpFe13AXNkL6DxzVYvN0Xb+S4Gp+ESpk60=;
        b=IUai/qCrHdneXY93sIOB0zduLp5FnJ0MiUoSrSWIJ/w+YlhylfglecX3sWTqgxi1a8
         PPzUVsgTd7gL9V8UO89E4EuKtuiC+H8UCJPaSGEcC/pdR6wEuUMByY2RsOYqMwFukMMs
         2QzWDDa0B0kG9dAHUeKyxj6GfoNfQCJ/aTE5nNKnA94JcIDi+aUqaIP6vR/iRjbWpd1+
         fEjEF/yU+Bj5pZBsK4C+EcmC1do1eTMxVFXYO0Rgb7hazV/6r+XrJ77YyOqfqkq/mlcZ
         8hF1jOYtERZ+NpL6wss+BxbHGGmjbVNZRzVIUqHsTQz8noMy61QWPHxU3JZIAUcogFJb
         UCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWLAgw86JkpFe13AXNkL6DxzVYvN0Xb+S4Gp+ESpk60=;
        b=Th7ydZR2D5KCtgLEw+8ZGJQWl9Z+j8dHr5ll1rxNA3dij5HELy1WHyH0HnReoFTZdq
         9MaCnyVoAo9lEEDtRL6KfJHQoNEABNHLGup892wbvkmhLnGMEL1SdGdCuoAXyuF++4eF
         kk7eDlFnb7Y5wTUkqKF3KYsQiEKV4rUEnUFivKRprpSUm2L264UV2hEEt4kxixF/b6JV
         R5W4XQT4+Bn+ZblRIik/HsRp3kRi41ZjRbjExYxkpVEpa2v8DtFNU5TU9ewVS9zUb3Vy
         yq8KOIksMf07Cwohy8hZxejzbXglnVcDUyyHDSyK0OQqsKQ2liV1ndIVbZjARFblB0iC
         U+Dg==
X-Gm-Message-State: ANoB5pkM0ivZHUF448MRczaXDs3vkfeTM1zQ0QAPh4rZaeRV2Lp5KhNf
	6lm7ZRAu3kTeNUrJB45celk3wUSTVVKK/g==
X-Google-Smtp-Source: AA0mqf6SpyzSxU1kOkAuBW75kn3EmHWFz77bUs0pYuCLBOzacuyy/PfZ2Zh9FvngTacoSB0dqtl5Fg==
X-Received: by 2002:a17:907:9719:b0:7c0:e812:c2ff with SMTP id jg25-20020a170907971900b007c0e812c2ffmr10036618ejc.675.1670350783005;
        Tue, 06 Dec 2022 10:19:43 -0800 (PST)
Received: from polar.foobar.local (186-153-172-081.dynamic.caiway.nl. [81.172.153.186])
        by smtp.gmail.com with ESMTPSA id n19-20020a17090695d300b007c0cbdfba04sm5059157ejy.70.2022.12.06.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 10:19:42 -0800 (PST)
From: Frank de Brabander <debrabander@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Frank de Brabander <debrabander@gmail.com>
Subject: [PATCH] ensure locale en_US.UTF-8 is available on the system
Date: Tue,  6 Dec 2022 19:18:05 +0100
Message-Id: <20221206181805.3022-1-debrabander@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Dec 2022 18:19:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14139

Get rid of the duplicate code and add extra check that the
locale en_US.UTF-8 is available on the system. This new helper
method is now located right above the method filter_environment()
which sets LC_ALL environment variable to 'en_US.UTF-8'.

[YOCTO #10165]

Signed-off-by: Frank de Brabander <debrabander@gmail.com>
---
 bin/bitbake        |  3 +--
 bin/bitbake-server |  5 +++--
 bin/bitbake-worker |  3 +--
 lib/bb/utils.py    | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 7cbf88f4..f869eb48 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -25,8 +25,7 @@ except RuntimeError as exc:
 from bb import cookerdata
 from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
-if sys.getfilesystemencoding() != "utf-8":
-    sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
+bb.utils.check_system_locale()
 
 __version__ = "2.2.0"
 
diff --git a/bin/bitbake-server b/bin/bitbake-server
index 825e9d56..454a3919 100755
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
 if len(sys.argv) != 11 or not sys.argv[1].startswith("decafbad"):
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 3799b170..3cacdb0c 100755
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
index f4da3563..0df522b3 100644
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
@@ -608,6 +609,21 @@ def preserved_envvars():
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
2.20.1


