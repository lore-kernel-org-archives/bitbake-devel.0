Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C01ACD1297
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 15:41:30 +0000 (UTC)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.252.1762962088179508772
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 07:41:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TUEg37s/;
 spf=pass (domain: gmail.com, ip: 209.85.166.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-43323851d03so3415485ab.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962087; x=1763566887; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXcfGfAPlumYckXOhqNnWJhXBJJ+4rqAuFjXu+9WaNc=;
        b=TUEg37s/27/LXMgT+ZMFWpGSUtNniDHYhAUjXR9zJikxhmB0cljEsFv7ZFqaV2wtsK
         fEc6zm86S5A4MzOCWwZO5UkS3ozaFlKsTEOvN/eWt7UgUovhJj+nTkTDG1r6kchJESBW
         i4sAM7qZlyNVOgKf6u1cqg6uOci8k3jiMGMKJAn/4vOe79bIrvbvhgabXpe8gO91Ch9O
         KySSe2gFd+FW2i5ksEKZqkFpHY9HXfdEkZJBJzz0qHHCGp1Ok9BTrYKEs6ODIU1pTjmP
         nCQ+NBg+D8Stdrq2u6dBpBCoby7fWvGHQ8eRM8/ZpoDNtlVkP7onUtjdRy2Qo1ijYbJG
         MGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962087; x=1763566887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXcfGfAPlumYckXOhqNnWJhXBJJ+4rqAuFjXu+9WaNc=;
        b=TSof/pPZPp8OLzEjPHb2Waf1KzD/90YO/7ezySrSrBAvZE8iYIGxcRbpXlSVjjVYbq
         8S7WsNz7hpDTLOzZSiYtI66eQAv4Gs85g+PKnLhRD4ieUMdMgHW4Ix+Zt+tBN26c20Kt
         G4/xlzWCkTyRts9XlzbXtkEI2CjnzBz2yzfWyY+UjiYhDiIJzpviFVAg7/3ouhlcnVXs
         gzZDoB7S0RqN8Xz5SeSVQrgLBXI9XKhPaNKqi++CwTcGLRCgw4BczJPF+5GveaCCa8re
         GoVXiQ9Scp6eYVMaytLvGJW+gKRMsLXlXTyJBStBQ9h0wOb4e2/d/PGz0mNcjC6k1pG/
         naEA==
X-Gm-Message-State: AOJu0YzjTdlL8kde0obq+LsNoqPxwiK7wFBMgv0PUVLWPZ1jWJjabCeq
	IJinGO2r/re0QE5My8hr3Y8tITcQ0j+JZzQtIWNXVC/gYvWrtiLfhCCQq+tN1w==
X-Gm-Gg: ASbGncvSPJNjDWLcIWf7NRufM3eegw8r8yZBHajEGQChjz4BDBrP6dLGHMxDZA850RN
	+ejcCdrdLgOCSpvAS84/Ci//SupxSFiOWpF4RprmerSJdBhek3cukq/ym0kic3kuSD7dacfjJTS
	PKY1xdIhm1eu6pEkWfRtpijRnHusw0skPoissc/FA74dY75DH1cTnDJtm+cbPCLedq4ZoE4NiID
	DtYuaxvacq1qO7mAEIBh/4hPm1VdVBM47CLH71UH/rWoDHxOqVWBgB8Y1YG2tRG2UudfYBVaG5T
	OcjT/yIB6B/E8/91cRIaIuRL4kQnXg9dLZEFSS3zoO2dVVJwONTjKpuJGYzEGeE92hMSKyWS2jc
	MxhRF6PTt0jDkAXptH9TIUxWjzba8izYEjJ9VvkT2gnWslKb2EU8i/ilPfwPhM0LydXR95Fwd/w
	==
X-Google-Smtp-Source: AGHT+IHSq8uus1Hmdo7pOZXws2ESNl/07FXnzPys47fFFLVzXlmBUpfugUW0vHl0290upJuf6TwmKA==
X-Received: by 2002:a92:ca4d:0:b0:434:70bd:8b47 with SMTP id e9e14a558f8ab-43473d117f6mr54250615ab.11.1762962087113;
        Wed, 12 Nov 2025 07:41:27 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::51c7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7aaf77e24sm1154289173.16.2025.11.12.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:41:26 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/2] bitbake-setup: Set DL_DIR and SSTATE_DIR in default site.conf
Date: Wed, 12 Nov 2025 08:41:20 -0700
Message-ID: <20251112154121.3750738-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 15:41:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18355

When bitbake-setup writes out a site.conf file, populate it with a
default DL_DIR and SSTATE_DIR. By default, DL_DIR will point to the same
DL_DIR that bitbake-setup is configured to use, and SSTATE_DIR will be a
"sstate" directory under the top level bitbake setup directory

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 59f501948..590828c9b 100755
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
@@ -682,7 +683,19 @@ def create_siteconf(top_dir, non_interactive=True):
 
         os.makedirs(os.path.dirname(top_dir), exist_ok=True)
         with open(siteconfpath, 'w') as siteconffile:
-            siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
+            siteconffile.write(
+                textwrap.dedent(
+                    """\
+                    # This file is intended for build host-specific bitbake settings
+                    DL_DIR = "{dl_dir}"
+                    SSTATE_DIR = "{top_dir}/sstate"
+                    """.format(
+                        dl_dir=settings["default"]["dl-dir"],
+                        top_dir=top_dir,
+                    )
+                )
+            )
+
 
 def topdir_settings_path(top_dir):
     return os.path.join(top_dir, 'settings.conf')
-- 
2.51.1


