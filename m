Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1547CD6E52
	for <webhook@archiver.kernel.org>; Sun, 31 May 2026 18:27:48 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12242.1780252067521924678
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 May 2026 11:27:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LaRJoGtN;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490a7629380so6131995e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780252066; x=1780856866; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eIW12zg2CwDUADxGyapICjrt9qCYE7D+NkcTbL3cpJU=;
        b=LaRJoGtNRddfDRQOi66pnfxZpgykOXoO+GuyHy3DIqU+PkHilTUrQEV40KgDwDu0Xr
         KVvUjMJ4FUp/a8OTGVjCXjTlWLmjwU0qf8Lc1GjApHY6qG78xDZDp4lJYWPEyUNpy5fT
         A5pO79sdaPSwsudr8lyP3RT88/4y8X87fImMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780252066; x=1780856866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIW12zg2CwDUADxGyapICjrt9qCYE7D+NkcTbL3cpJU=;
        b=qm7NnHZ+p4KqD8UdZ90yWkaBAxtolQcolJmbedYI7iMCEtn+bYADnnqq9rvvrG5K75
         rnXOIPD/teQXGNfFLH4hVvI9qifL+tdhta07iHmEHqlOQZ3uRMRFDrhtXYjoec2e5TLR
         jePROdsYixCIgZckrh93qx4cnFG6or3WwQWHpgcrPrrtMc4P1UQ6o4jOxwXjEkrDC2HJ
         LiS+tm4XRipW6zznjEEO1qR06c+Oxh7GjfgjuCnfoQkHQGYJGkuRc4PsKWUnnJB5MMmg
         ruU6WlzHO6ux1MBAXNRyyq+K6gQLsi2GSO5i44AUM8zDbH5aEAx9BbudFifDvjs4fLOy
         x+/Q==
X-Gm-Message-State: AOJu0Yyd8HmUUEa1Cgyq9FgtbHFsdbjQmrMyI2CKJofiQW4vlOZSOkev
	rHHrJSDgpp90IM4fdZUErnKOFK0/diIArB5ybVkbMIsLcs0S6DsJQCpzyC+AedkOADXcVV8+/qr
	P1lH3
X-Gm-Gg: Acq92OEZ6HFcqoqvQyoisunuZ8Ejswnom2KdjRK/NAqQHgv70uZ/JsQ17nQj9ofAox3
	bvUpG4/uMgg2M1STW7WzIrncIWw0TQC8Jt/JrAVXoiZH1VvjYrwMy9RajoJ1vAQ45SqcCKdaigL
	hRU8BpSxZkc+ANMapBVIhHTPgBVG+Y+rgCLCdC/Mlw7jdBtaCesC5RWXmc7YX38jL04EwEZME8M
	0rexEhL6/gMSwS9sS+dxgxE1zRMp4GGDJF4TAkdPTnQnkY1v8ly0PvAcxxDG2rQFw4Y7xTvUTXI
	H3xrxTn34Dm2Y4F1q6yWjCXhTNcrTXole4H3Yc/WSmNMNdUxl1Q2A+EgrbUnlxzMJdeQsyommD6
	pDlwpw3L3QdUFqQi4UsXzVDx6ydwnoCzws+VSAjnZl/Sdb0qzjO5SHAWkziq8im8WAn7uB3yUy0
	f0OieUG5zCDy6dqpxaAnnBcJLu0NS9Rzcitc88jD24Ry2YkprHV5G1xTDO747oRc8=
X-Received: by 2002:a05:600c:4fc4:b0:490:6889:202 with SMTP id 5b1f17b1804b1-490a29639e6mr139139575e9.29.1780252065547;
        Sun, 31 May 2026 11:27:45 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:229e:2449:eb7c:dbd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm18563488f8f.19.2026.05.31.11.27.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:27:45 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/6] bitbake-setup: Convert string commands to lists where possible
Date: Sun, 31 May 2026 19:27:38 +0100
Message-ID: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 18:27:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19572

String commands have to be processed by subprocess using shell=True which
is suboptimal for all kinds of reasons, including quoting. Convert to use
a list where possible to improve efficiency and the robustness of code. It
also means copy and paste will be more likely to use the preferred form.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 220540f7f9c..69c9882f4c4 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -128,8 +128,8 @@ def write_sources_fixed_revisions(config_dir, layer_dir, config_data):
         os.symlink(os.path.relpath(json_path ,layer_dir), json_link)
 
 def commit_config(config_dir):
-    bb.process.run("git -C {} add .".format(config_dir))
-    bb.process.run("git -C {} commit --allow-empty --no-verify -a -m 'Configuration at {}'".format(config_dir, time.asctime()))
+    bb.process.run(['git', '-C', config_dir, 'add', '.'])
+    bb.process.run(['git', '-C', config_dir, 'commit', '--allow-empty', '--no-verify', '-a', '-m', 'Configuration at ' + time.asctime()])
 
 def _write_layer_list(dest, repodirs):
     layers = []
@@ -357,7 +357,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
         _setup_build_conf(layers, filerelative_layers, bitbake_confdir)
 
     if template:
-        bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, bitbake_builddir))
+        bb.process.run([oesetupbuild, "setup", "-c", template, "-b", bitbake_builddir, "--no-shell"])
     else:
         oeinitbuildenvdir = os.path.join(layerdir, 'oe-init-build-env-dir')
         if not os.path.exists(os.path.join(oeinitbuildenvdir, "oe-init-build-env")):
@@ -857,11 +857,11 @@ def init_config(top_dir, settings, args):
     os.makedirs(confdir)
     os.makedirs(layerdir)
 
-    bb.process.run("git -C {} init -b main".format(confdir))
+    bb.process.run(["git", "-C", confdir, "init", "-b", "main"])
     # Make sure commiting doesn't fail if no default git user is configured on the machine
-    bb.process.run("git -C {} config user.name bitbake-setup".format(confdir))
-    bb.process.run("git -C {} config user.email bitbake-setup@not.set".format(confdir))
-    bb.process.run("git -C {} commit --no-verify --allow-empty -m 'Initial commit'".format(confdir))
+    bb.process.run(["git", "-C", confdir, "config", "user.name", "bitbake-setup"])
+    bb.process.run(["git", "-C", confdir, "config", "user.email", "bitbake-setup@not.set"])
+    bb.process.run(["git", "-C", confdir, "commit", "--no-verify", "--allow-empty", "-m", "Initial commit"])
 
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
 
@@ -872,7 +872,7 @@ def init_config(top_dir, settings, args):
 
 def get_diff(file1, file2):
     try:
-        bb.process.run('diff {} -uNr {} {}'.format(get_diff_color_param(), file1, file2))
+        bb.process.run(["diff", get_diff_color_param(), "-uNr", file1, file2])
     except bb.process.ExecutionError as e:
         if e.exitcode == 1:
             return e.stdout
@@ -887,7 +887,7 @@ def are_layers_changed(layers, layerdir, d):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
 
-        rev_parse_result = bb.process.run('git -C {} rev-parse HEAD'.format(os.path.join(layerdir, repodir)))
+        rev_parse_result = bb.process.run(['git', '-C', os.path.join(layerdir, repodir), "rev-parse", "HEAD"])
         local_revision = rev_parse_result[0].strip()
         if sha1_re.match(rev):
             if rev != local_revision:
@@ -937,7 +937,7 @@ def build_status(top_dir, settings, args, d, update=False):
     new_upstream_config = obtain_config(top_dir, registry, args, source_overrides, d)
 
     write_upstream_config(confdir, new_upstream_config)
-    config_diff = bb.process.run('git -C {} diff {}'.format(confdir, get_diff_color_param()))[0]
+    config_diff = bb.process.run(["git", "-C" , confdir, "diff", get_diff_color_param()])[0]
 
     if config_diff:
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
@@ -945,7 +945,7 @@ def build_status(top_dir, settings, args, d, update=False):
             update_build(new_upstream_config, confdir, setupdir, layerdir, d,
                          update_bb_conf=args.update_bb_conf, rebase_conflicts_strategy=args.rebase_conflicts_strategy)
         else:
-            bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
+            bb.process.run(["git", "-C", confdir, "restore", "config-upstream.json"])
         return
 
     layer_config = merge_overrides_into_sources(current_upstream_config["data"]["sources"], current_upstream_config["source-overrides"]["sources"])

