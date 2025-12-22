Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8E7E67810
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 18:15:34 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.85733.1766427333518995187
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 10:15:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=nmSn2s+E;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.182, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fb6c7874cso31529167b3.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1766427332; x=1767032132; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdVaAfXWuUi2/1GRYyY3CHkZ6fLgniV8klJ3sV9zs6U=;
        b=nmSn2s+EA6da8Z+ooGT3YHxY5z1gZVY+nWYATUbs778x8fPl/IgF151DeV6snEPko6
         UQG8J45tdAbTtdEppMlmztQLWwV6G43Y9ljIxu1OFxp9/MmJqcF0SUMMF+N6cecjAnBD
         +2ERCpFEByALX7THh10s5hP8seNZzJeuHOwk8zxQT7Ci4vTt6WJUs1TCmWorUzlLm1Lp
         tgEpm/ozoRZlgw10lF31M1PsrvSEwvuZ/I9T77cyFtnXKYyC0fYas6VexY/h0Fs/WJLO
         2AgG8saDSwd9c53njh5sALw8M8FOhAQOuA7mPo+QcKd32+s7q9Xrs25Sv3FQqI/CKFPI
         EqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766427332; x=1767032132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdVaAfXWuUi2/1GRYyY3CHkZ6fLgniV8klJ3sV9zs6U=;
        b=hVCqF8DPyuwEzmjQtEJYxkIAOk9BMLjcV2ZK54ChAXDOV2NhRV7YIVmMsw/9JawgCv
         ByfXfS9/rOeZ+Bx1eKfm2bgo5R8CEIkB/Zz9Mul8pL0ijMuvgJZQeudjqhVHO7a99/qi
         uPfmkWo4ixK3ErpTosc6fve6WWQn0Ongh54F2Lmxdr5oWlMS/VnsE0of1EWPfM1YxSyn
         nbNMFwJgxzbQfK/Co3AMwcskm5nTzu6fM6jjfvzEaBf5TQYBjgPVDIamRLXF5H1cQcHB
         Y5PeGy6pRqnf+qBT8FIjVlC4lZJjmKmA+J5vnn0flPUKix0a9NJJX370lCINegY5DwG4
         xscQ==
X-Gm-Message-State: AOJu0YyqTuhvwTKwhkwQY4ynx3h24s0u+H6uAEmkh6e9AtDia97DjefB
	2rWMyFWhRMdb+pvz9vqu94AUcvqM8zLe5pCcm3lS6pqH5GpgIu4UrdswtlYhdR+sLY+B9NccD0P
	Od2Qezeo=
X-Gm-Gg: AY/fxX54ebCSZypaSMd2ez2inVeLiQUP1j3ZUrdT5gkvaKTD5xUtiLm9fOX1dzRjuXC
	OmKJyNQIviJqlXsyWEB9hvkXQFFs8ALtGCnfVNwa3Yfl2/LfjbB2o0wCyP+8VFpL9vfzYHIBJE6
	u7ApQ8F44tpjXZLP2Kv40TBKTOMAJdRDoS2NvyAJh85VqHBclcdCx8kAH9euB+VNyPOtQsgUmrq
	R9bJ25l2QqEYtHDMom/13EtT6CXYJh1OLH615K18A67W6kqJj7uUpCGNbW3iX61IpnFLXJZD2oh
	NdbzwNaRpu2y1sHIMC0PjYvJOGMQDMfshB+lxS77ULtAHViVdztLmdyUyjQVqrCCI7BPC9Q8z0m
	mVmbeBFH6H5NZ3MHAcbY5G2/wdwtuDm0FvYTtlyt8RXhA7z7Ul2v+I2siMARBqxejkkOgJdHHIR
	khJ1imSdDyxM5G1BR4N1m1AiyyvUbRE1aHSgFdNgn9PuAqpzK9bBNOsYK1LecFjRiLnpET1d/sW
	KTDUOpMEIYYAmNmrwcQ
X-Google-Smtp-Source: AGHT+IFJAuelrjXOTMqGRxYNa6HSU9PvWRVvjfWV74IDdl7mdJ+pjimvPKGycfvipvXNOt0rVjTMrA==
X-Received: by 2002:a05:690e:1c06:b0:646:518d:b89 with SMTP id 956f58d0204a3-6466a83447cmr9696739d50.13.1766427332360;
        Mon, 22 Dec 2025 10:15:32 -0800 (PST)
Received: from localhost.localdomain ([189.172.79.153])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43c71b6sm45308507b3.22.2025.12.22.10.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 10:15:32 -0800 (PST)
From: Anibal Limon <anibal@limonsoftware.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com,
	richard.purdie@linuxfoundation.org,
	Anibal Limon <anibal@limonsoftware.com>
Subject: [PATCH] bitbake-setup: _symlink_local fix case when update
Date: Mon, 22 Dec 2025 18:15:27 +0000
Message-ID: <20251222181527.2424323-1-anibal@limonsoftware.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 18:15:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18640

When run an update with setup_dir containing a local symlinked source it
fails because symlink already exists, so test for previous symlink
existance and update it if not point to the same local source directory.

Fixes,

```
$ bitbake-setup update --setup_dir /home/workspaces/ls/meta-ls/bitbake-setup/ls-master/stm32-toolchain

...
Traceback (most recent call last):
  File "/home/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 1042, in <module>
    main()
    ~~~~^^
  File "/home/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 1035, in main
    args.func(top_dir, all_settings, args, d)
    ~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 667, in build_update
    build_status(top_dir, settings, args, d, update=True)
    ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 652, in build_status
    update_build(new_upstream_config, confdir, setupdir, layerdir, d,
    ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 update_bb_conf=args.update_bb_conf)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 340, in update_build
    sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
  File "/home/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 132, in checkout_layers
    _symlink_local(os.path.expanduser(r_local["path"]), os.path.join(layerdir,repodir))
    ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 114, in _symlink_local
    os.symlink(src, dst)
    ~~~~~~~~~~^^^^^^^^^^
FileExistsError: [Errno 17] File exists: '/home/workspaces/ls/meta-ls/layers' -> '/home/workspaces/ls/meta-ls/bitbake-setup/ls-master/stm32-toolc
hain/layers/ls-layers'
```

Signed-off-by: Anibal Limon <anibal@limonsoftware.com>
---
 bin/bitbake-setup | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 1ea6796b5..378fbdc91 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -110,8 +110,19 @@ def checkout_layers(layers, layerdir, d):
             layers_fixed_revisions[r_name]['git-remote']['rev'] = revision
 
     def _symlink_local(src, dst):
-        logger.plain("Making a symbolic link {} pointing to {}".format(dst, src))
-        os.symlink(src, dst)
+        do_symlink = False
+
+        if os.path.islink(dst):
+            if not os.path.samefile(src, dst):
+                logger.plain("Updating symbolic link {} pointing to {}".format(dst, src))
+                os.remove(src)
+                do_symlink = True
+        else:
+            logger.plain("Making a symbolic link {} pointing to {}".format(dst, src))
+            do_symlink = True
+
+        if do_symlink:
+            os.symlink(src, dst)
 
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
-- 
2.47.3


