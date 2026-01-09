Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB6D1A62D
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 13:20:18 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9811.1767964809279692048
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 05:20:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gONfeZ6j;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso20308605e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 05:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767964808; x=1768569608; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tiiw1L+ytdtJISvqhpS7HrLUdpHl6gbjyrk1CL7n61w=;
        b=gONfeZ6jCsHdB42WBnJPNaaGehfYiLXj1icN3nyXXBczGtcoKgyVTYXrOu8orhJUP5
         S+PdHrzvQFom/6aBRvd138IL1XHarwBJSfVmFNO665J4KsDROXSp/bReWcyhzMRkMPhn
         Zut9LswNrvFiRZ27SOHVyyXVjGp5fEtk9szICxsG2DMk9qgQg8jUqh9Kllf0Kgpimq7Y
         gL+vmjOCg9YFLoQ6FrsS55VpOtAjTQFLC2B3OsfVrHXG8ImPopGNPH3/+2ZYo3JoDk6R
         MY/wqMNBNbhHvg14uBqNtRfkrrls3/f7yFMbVQ3+BmCrxN4Ohjnch+N9WMFerFD3MYsg
         lqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964808; x=1768569608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tiiw1L+ytdtJISvqhpS7HrLUdpHl6gbjyrk1CL7n61w=;
        b=l9ROU1A/zHWrM08BrbANOigvOWOsL/ri0Ijj7ybfHpfk+ss9uelbSuswtJwe1t71qY
         +LHOAZNGR4lZrLI8MQ/pZBcQ/J4gsWQtBZ4vqkCFEw4sica6LPmQAUbOxDs6JmkS7maA
         fUOyc0Px7h7FyZm0ZkMa/SU79eNwD8CF+HxtirujaxIjhcfbWqY0z33C6+8i+rnZ9zE5
         LCwUma+PesOsEwtYjVvJBenDvvEapLOiLXuMy/r/QLb72fHqwWhPSfx6gUD8EGyJ+MI+
         DwbADwVQBRsY4ObqBClsDdq0KktGtGVjQiwALbCbt1ZihTwfaCPIGvZrqfKhaAYnoTk5
         O4Jg==
X-Gm-Message-State: AOJu0Yz7VqdRZ5ZYj1oNSM8CPrS7woDJhS0z0tk64jEiF+Vmt7F+0Se3
	hp5fCqnG7mmL34iRO393ysBjvvaHmYC+N/kcEdqukxMj7pfUqLyM4c/XXbb6rw==
X-Gm-Gg: AY/fxX4MXlUdUKowFl+pxYFnC9dotAeN4JAJ3XTleUef2SZXZm1Vx17KJq1WvddWycG
	qblDNX5N1NB4P+fO+U3dxhfK657MV87GTsIZlWtxtyGl1WX7YmObLbGS3DBM3Hf+1iidfdGnqKz
	asRJhF010wa+gj8gNo56JSFjkXic3m7dcW4QNfem7kOCFb5/fhQsdLCWiWbl9JnKQFOM6iWhAxV
	JW6aTiRCAMt2Ep6XKeqlWeDNus1FD+vGthOq69qKtnS6zctdi5dFlK7v63au3A7Z8JTcLguFl8Y
	LI92m6AQEcjchhQD6A4/C94vw+Hf9O0UljrJ4AK0h7KNVEcLe4OC+npwopKCRcvTJtjMDAfBXxQ
	0nYmFhyVSAfv8eo/Tq0o6hItLp10ar1vceVcfAEjbZy76J/AnjzByYLl3O5e9cp0J2mJH/1Rk5O
	zzRu89AydHJQhGEhZ/Nbd1uRIvECL1dhnbypsPmh1Szcz+jRs=
X-Google-Smtp-Source: AGHT+IEkZ6+DS+j+lXDzuLVcciF0WmfvYLewyy44HqTG+ynA6RvF1OEzfZRt0A2daoWWw8LC3S2OuA==
X-Received: by 2002:a05:600c:45c3:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-47d84b3f642mr101423255e9.33.1767964807548;
        Fri, 09 Jan 2026 05:20:07 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6953fasm202291505e9.5.2026.01.09.05.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:20:07 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/5] bitbake-setup: ensure paths with timestamps in them are unique
Date: Fri,  9 Jan 2026 14:19:57 +0100
Message-ID: <20260109132000.2372791-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109132000.2372791-1-alex.kanavin@gmail.com>
References: <20260109132000.2372791-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 13:20:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18724

From: Alexander Kanavin <alex@linutronix.de>

There have been instances where directories with timestamps
in them are created within the same second, and their paths
clash as the timestamp in them is the same for both, as the
timestamp is accurate to 1 second.

This adds a check for the directory existence and then adds
an ever-increasing counter until there's a path that isn't yet
created.

[YOCTO #16121]

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 06255b112..4ccf47e87 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -93,6 +93,17 @@ def _write_layer_list(dest, repodirs):
     with open(layers_f, 'w') as f:
         json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
 
+def add_unique_timestamp_to_path(path):
+    timestamp = time.strftime("%Y%m%d%H%M%S")
+    path_unique = "{}.{}".format(path, timestamp)
+    if os.path.exists(path_unique):
+        import itertools
+        for i in itertools.count(start=1):
+            path_unique = "{}.{}.{}".format(path, timestamp, i)
+            if not os.path.exists(path_unique):
+                break
+    return path_unique
+
 def checkout_layers(layers, layerdir, d):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
@@ -242,9 +253,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
         raise Exception("Cannot complete setting up a bitbake build directory from OpenEmbedded template '{}' as oe-setup-build was not found in any layers; please use oe-init-build-env manually.".format(template))
 
     bitbake_confdir = os.path.join(bitbake_builddir, 'conf')
-    timestamp = time.strftime("%Y%m%d%H%M%S")
-    backup_bitbake_confdir = os.path.join(bitbake_builddir, 'conf-backup.{}'.format(timestamp))
-    upstream_bitbake_confdir = os.path.join(bitbake_builddir, 'conf-upstream.{}'.format(timestamp))
+    backup_bitbake_confdir = add_unique_timestamp_to_path(os.path.join(bitbake_builddir, 'conf-backup'))
+    upstream_bitbake_confdir = add_unique_timestamp_to_path(os.path.join(bitbake_builddir, 'conf-upstream'))
 
     if os.path.exists(bitbake_confdir):
         os.rename(bitbake_confdir, backup_bitbake_confdir)
@@ -760,7 +770,7 @@ def install_buildtools(top_dir, settings, args, d):
         shutil.rmtree(buildtools_install_dir)
 
     install_buildtools = os.path.join(args.setup_dir, 'layers/oe-scripts/install-buildtools')
-    buildtools_download_dir = os.path.join(args.setup_dir, 'buildtools-downloads/{}'.format(time.strftime("%Y%m%d%H%M%S")))
+    buildtools_download_dir = add_unique_timestamp_to_path(os.path.join(args.setup_dir, 'buildtools-downloads/buildtools'))
     logger.plain("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
     subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
 
-- 
2.47.3


