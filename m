Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74ACCD342D
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 17:26:39 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3000.1762968389766338616
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 09:26:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TkvLHHQJ;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74526ca79beso793149a34.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762968389; x=1763573189; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKYr4GAbZ1z6goOOTg8rxGkw4PKgBUx/pd2d5CW+QSY=;
        b=TkvLHHQJQBrT15iRK/KshVrLT2afi3zzDysOkXwwPi9r6ibzQuw8ByuT/mPTADcpPB
         FdNDKBPrQRNEPtoCPp5+76ZuhOWjmfd4tn/3sit8Tfq17/fBfb+ZIf2Aqv1Sfsb91Rjw
         Qo7gxX/hUQ8nb5gUOr6JOOc00ifTckAAcxgN9qphERiMFoBiab0XF1fR2rsJYTSgCGkE
         BzQ6sntJO8g31WZviwXy3PZAwO0JLx3V85BkJdTENmDGSmYCr7Aosw560amUtH0WAuYV
         2m+G1mxKQwHSmjUdxQGP7nbnmx6hm5o7iMsRqHedX+qcegDo9tBSSYz3HdwGVj51YXeU
         eRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968389; x=1763573189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKYr4GAbZ1z6goOOTg8rxGkw4PKgBUx/pd2d5CW+QSY=;
        b=bmOb39blT7lggpbEmmbOhsFA/PJrVW0G5FehCCd3CgH+S2P34fxh7KtrXWaORQNRLw
         grj121Efz5YmjKlDFVJ230CIx1yWEVhfran7CuOt+yXIJMW5AjQrQ+QOb8iEuQNoPsiu
         cuXW5u38gUv+EtltiCVR0LcM8oaJ7cldGKKEUVXsXuNi08JfXPRxq/HN+cjlW/uxVIa3
         p30dHx7v3nVusmuB4mh+vDJZ2PDXo5Y6eWSltpHkH6LpvI02tjWX6UCx+FE+XXjaRXit
         BQmqxC20yADdbMhS3QQHe2Xn0IL2bX4uj1xO9Gfay5oDI7dcoqUVXgMdszKigVrCPHBD
         bL7g==
X-Gm-Message-State: AOJu0YwdLQhj3lfd5DpC1jO8L6jS3AmQID4rloUb/EnGqDGeKOea6mkv
	tZ+WVmrUfJe8jrqSDYgEULjJck1RploUfOpWeTeA3HxDazujEP+yqILB7o8Kuw==
X-Gm-Gg: ASbGncsxvK7WQKczt7agM6dVjNQkSWQoNJ59hTbM5dbNx49B91C3X++7cNDg1whxUCl
	1A9kX3mrarmWUneRmhkcoGzXnadr2yuTXdjqjHtqitJ29r5d5LqT/27DfPHa6f+PP4P7MUxKdyP
	AWgYyh6mtx66qHThJDXMOeEOfb3bMgcoB7liUCQ0ZXZVVo7BdzaZge7EwoeV8mSVB4K7dPvcU4v
	Mies6OeeTP4b4QWHRDqbxoz7AlwzoSDwo87ebGgNU68yvs63zESpf60RVNfM2oC7L/45SF0p6B8
	YhPVhtUDw5/7wxoLKTQb3S62km+KHlStq9Xs80DZUcghaw0GsIrA5Nkm6LZgUMYu6SqJTYilna7
	n/boUc2ThGP20TuFh59AxYs0XQc4tSuE4TbU0VVKH5aNDkxqbFzvZwuZoe8w5F2xCmT2RtfLpdg
	==
X-Google-Smtp-Source: AGHT+IF/wOxL/oImLtqlusI/KYO015BNTx2WpvlbLrs2x76axyuMXQsHU8QMQH5S9i5V99+4a1XyHg==
X-Received: by 2002:a05:6830:2473:b0:7c6:d0b2:8eb6 with SMTP id 46e09a7af769-7c72e2147a4mr1742457a34.15.1762968388843;
        Wed, 12 Nov 2025 09:26:28 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::51c7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c70468d028sm6012914a34.11.2025.11.12.09.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:26:28 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] bitbake-setup: Set DL_DIR in default site.conf
Date: Wed, 12 Nov 2025 10:26:19 -0700
Message-ID: <20251112172619.3764053-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112154121.3750738-1-JPEWhacker@gmail.com>
References: <20251112154121.3750738-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 17:26:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18363

When bitbake-setup writes out a site.conf file, populate it with a
default DL_DIR. By default, DL_DIR will point to the same DL_DIR that
bitbake-setup is configured to use.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 59f501948..3f0caab80 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -19,6 +19,7 @@ import datetime
 import glob
 import subprocess
 import copy
+import textwrap
 
 default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
@@ -469,7 +470,7 @@ def init_config(top_dir, settings, args, d):
         progress = event.progress if event.progress > 0 else 0
         print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
 
-    create_siteconf(top_dir, args.non_interactive)
+    create_siteconf(top_dir, args.non_interactive, settings)
     source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
     upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
@@ -672,7 +673,7 @@ def install_buildtools(top_dir, settings, args, d):
     print("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
     subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
 
-def create_siteconf(top_dir, non_interactive=True):
+def create_siteconf(top_dir, non_interactive, settings):
     siteconfpath = os.path.join(top_dir, 'site.conf')
     if os.path.exists(siteconfpath):
         print('A site.conf file already exists. Please remove it if you would like to replace it with a default one')
@@ -682,7 +683,17 @@ def create_siteconf(top_dir, non_interactive=True):
 
         os.makedirs(os.path.dirname(top_dir), exist_ok=True)
         with open(siteconfpath, 'w') as siteconffile:
-            siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
+            siteconffile.write(
+                textwrap.dedent(
+                    """\
+                    # This file is intended for build host-specific bitbake settings
+                    DL_DIR = "{dl_dir}"
+                    """.format(
+                        dl_dir=settings["default"]["dl-dir"],
+                    )
+                )
+            )
+
 
 def topdir_settings_path(top_dir):
     return os.path.join(top_dir, 'settings.conf')
-- 
2.51.1


