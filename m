Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD77D2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 11:51:54 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4503.1768909909514248595
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 03:51:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=YZHz50pr;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801c314c84so33271325e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 03:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1768909908; x=1769514708; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2D1Znkj/YwaEZtU2gU7HqVJcge+m+vPDnXY9AkfsZE=;
        b=YZHz50prGc1LZCaeXnpuujgLYWdaU6eqYMPbP5ijQKTfGDqXmhFO9lqCyIjNyiX74A
         jqhUJFCd0MggyRzIh67xWbeaaHw8xaKRoTadjaSR5ppWstMPSirCyrR/33rhE0X0fQC6
         QCn0ueO/scBCNlrxgyI5Lwf4wUo/RE8L+B2oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909908; x=1769514708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G2D1Znkj/YwaEZtU2gU7HqVJcge+m+vPDnXY9AkfsZE=;
        b=cMehjMSV4lEHy1Ne1ddAMl4EHMqZCGSjkcEfB4Qw9br/Qbb+p9uWzicyorUuY9LUxI
         +CT62AQ4wfDzwXhgnsTha3wQ46OgMona677k4UPAUK3EqqkoHlCRcwqcFw2pn3ChRKYY
         AD6SOhVHpJZjCAgwY+0ZtgZA+roG8beP98D7EOR6/xXRJjLB+j7m9BTOwl00/fjUiNS8
         e/BGc+KsxWZYGoZwbBfy51oeAHNDSwCf9uChXic2JFPE+divBJqldMMwm6lzlY74XsGh
         rNBr71VFzKSJYGIhjnP5zo6kDeZrecRRCNGVRiU4goGcxTvrCYLhn9+7c17io6Q9xZCn
         HusQ==
X-Gm-Message-State: AOJu0YxDRjCOJgJKc7GfQQ6epNhCssfXCVS8ZUJa+3eUasIjpt/LFeGs
	Ro/4qA+KH/Wipl5ipez184VTt8tn5avbZxk011mEa/5wR1jL5IFsx0ikGGRzy3TUvuOnRlQ34q9
	aPYcF
X-Gm-Gg: AY/fxX5+l+tz1H3zqj+Du4r0BYjfJB8HFJDy9le7it4i25AGI1AZXWM8IHKJDP+ts6s
	wYFF7lsvsu9/mJxstfKfAITQC2W7cTSWrOdNya5lt4uFWCnuM070rhz8rmXCykxZPuffWRBnXj/
	syrg3wRDRw1ZuB+OdZ6bIpe2yRS3m0WgBLWAqbBRtAViExX5VdPVMFz3e0USSXvu1Z4O0KBIR0y
	BgTYNobcku60zxiG05MFJ3VNHza7cfiDKqiqvq2w/Z80WUrJs2UrlgggfDKS6nbSb4RXKTNa2Ls
	fWBNOopzh0SsvqkHU9ohEH4rjVBh1rWJeqQqVRqCqnAn4wcwQ95/RMpJcKXCcS7Op8jjH+u1+H6
	s4dexr3UTiZJ7JRCNX75UPWbz48iQJtyeb4UJvOzJtdt3TPInRqi7Toq4AnRbz7IxTBebDQOAcx
	Y7Lgilj+9zDny+a4eQzX+LMcpfGCL5O5d3sPdVp3k9yFlqi+N6EkDU2J64BRhwvvCbrmc7aSTPM
	WWl3n28JN7UAJMQO1oKAw==
X-Received: by 2002:a05:600c:c178:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-4801e34cd0emr206819765e9.31.1768909907668;
        Tue, 20 Jan 2026 03:51:47 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c197sm246193565e9.1.2026.01.20.03.51.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:51:47 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][whinlatter][2.16][PATCH 1/1] bitbake-setup: ensure paths with timestamps in them are unique
Date: Tue, 20 Jan 2026 12:51:25 +0100
Message-ID: <74f8a927ca6a20342072e5579182aea917b6dc30.1768909613.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1768909613.git.yoann.congal@smile.fr>
References: <cover.1768909613.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 11:51:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18815

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e96b97e176b2fcc0bfdcf0151dff6df3ecaefcb3)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-setup | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 75be90940..0e0cbb135 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -89,6 +89,17 @@ def _write_layer_list(dest, repodirs):
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
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
@@ -225,9 +236,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
         raise Exception("Cannot complete setting up a bitbake build directory from OpenEmbedded template '{}' as oe-setup-build was not found in any layers; please use oe-init-build-env manually.".format(template))
 
     bitbake_confdir = os.path.join(bitbake_builddir, 'conf')
-    timestamp = time.strftime("%Y%m%d%H%M%S")
-    backup_bitbake_confdir = os.path.join(bitbake_builddir, 'conf-backup.{}'.format(timestamp))
-    upstream_bitbake_confdir = os.path.join(bitbake_builddir, 'conf-upstream.{}'.format(timestamp))
+    backup_bitbake_confdir = add_unique_timestamp_to_path(os.path.join(bitbake_builddir, 'conf-backup'))
+    upstream_bitbake_confdir = add_unique_timestamp_to_path(os.path.join(bitbake_builddir, 'conf-upstream'))
 
     if os.path.exists(bitbake_confdir):
         os.rename(bitbake_confdir, backup_bitbake_confdir)
@@ -714,7 +724,7 @@ def install_buildtools(top_dir, settings, args, d):
         shutil.rmtree(buildtools_install_dir)
 
     install_buildtools = os.path.join(args.setup_dir, 'layers/oe-scripts/install-buildtools')
-    buildtools_download_dir = os.path.join(args.setup_dir, 'buildtools-downloads/{}'.format(time.strftime("%Y%m%d%H%M%S")))
+    buildtools_download_dir = add_unique_timestamp_to_path(os.path.join(args.setup_dir, 'buildtools-downloads/buildtools'))
     print("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
     subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
 

