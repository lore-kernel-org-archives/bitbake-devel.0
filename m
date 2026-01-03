Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC41FC617D
	for <webhook@archiver.kernel.org>; Sat,  3 Jan 2026 09:45:55 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21945.1767433548822469372
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Jan 2026 01:45:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TJ2zsMrx;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632b0621so79146895e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 03 Jan 2026 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767433547; x=1768038347; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wRjzpZEj5A1jmy2mcvPjWhx8V1JizIOdXnNgpZAY0Tg=;
        b=TJ2zsMrxGLMwbDg9zCtP/4K9XmLFw1ywtDhurPQi8zPpsNHm0aGhOcSuTWlnEBJNw2
         uyMRg0SPFWgnSHCfSol5E+bkysu4/ZZwx/uLBOc8IUx4I0upDkGGFWvZLPE1stTyNxew
         B8/fetgezVkbKThmRhHOX4c/nYhwpcY0Thlm1ACQ52TBd1uD2ziCV9rMyhUWer0LQt6G
         oaVK7RD4/87Q4cfZRiHl7dLk1U1mseZ2Rh8EkgJ9/z9cxwChEOQwbjphEugsjUq0fatc
         8DL9f9y06Jnh5tilGf1q3gH/uE9NqDGsh2MxrwJE8WzQx3CKvNI6f0N4PqqK18YeJI7N
         8z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767433547; x=1768038347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRjzpZEj5A1jmy2mcvPjWhx8V1JizIOdXnNgpZAY0Tg=;
        b=qy4K/WKBfSbUuevj4FIdWc+CZRP3RJTGPF2thQ8N71kSdvhAqavU6u2CdbmtQD4E5X
         LOdpkr+Ev8KAYKWkvq+nSd+P1SsqjPbxFyvgnSljb85Vp1r4LVTjqnL6X+RTIAJ/EnuZ
         WVciUfsrwVCCDI4HcL7yLvYWB3QOM4JTQUWIagNuCAOK7FDvXDG/xXcpblmn0S0GA/MY
         cv1eShHxsS9ffs/qjHbiwOg3e/JplDbjRU3dH2Wlf+cEazMxbsOrzBzCuT2/UY3b/fJO
         /Yefx8QIVl4Xf5bwWsR3zhCxVccqKYGB3XoQtvjJDQz8tkiN3zipBAnnrl1RrzGBnD21
         GBQg==
X-Gm-Message-State: AOJu0YzO7sI1sbYWbNItanbaGR1WF8E9RWo41GcHWX6nkEEhJJenyZot
	hZZbwUkVt4WDu3CEBomA1iCHFpN3ZU74Bi9zQ9YZVXlvF4mmVMoAxg5QZlOwSQ==
X-Gm-Gg: AY/fxX6Xjc9ZtG5dRMkwsvepEvzsGkQAfF/Hoiu4PoMhhtYZFJbuCTMNC9g5Jakav2N
	HKrso989LQWAsj9E3nwlGWr6NpC7zpQiYXgTI4e2EBEziNSZeX6w/8o8Lwok/yPO9lZ2n6jTv8F
	YUuEQcAUTkSx3zj96YtYVLDRJ5oWIP8nqSmpuN5efjPGC50OygToRsUQpW6O0DrPmkm9l4pLSZ9
	6LdmE0+/HxxGqSstohOVejzl6JYQHim3vFzKMYp6u9rQoXglK+FhQjHww6spg3iA9l5tA6HEmO8
	vhETopdvKfNAepkhPeWbAryCsCCr6i54gogsrvHx+ubHhKe6lqEFu3IvKNDIfdqUxUX56jB3bjh
	PqhW6PJ4Gtw6y8fHcRxnYeeC4CJUB17nf1QTiDe1SxQ0boZUxMFrvCqYdbHKqSQD4JdiuRFYrra
	z9ErGzAXVE5n3qKZ1miPfgl67rGGjMtQeKZ1VbGPmOntPdadg=
X-Google-Smtp-Source: AGHT+IFBnEGXLW2h97SabgclY9tjatjbBJ99FD/SvxhrvbOLpLYsMxyjthYcif0fLKjStuECBrx0CA==
X-Received: by 2002:a05:600c:310e:b0:479:2a3c:f31a with SMTP id 5b1f17b1804b1-47d1956eb70mr553283805e9.1.1767433546896;
        Sat, 03 Jan 2026 01:45:46 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d34500fsm28696215e9.15.2026.01.03.01.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 01:45:46 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: read fixed revisions json from config dir, not from layer dir
Date: Sat,  3 Jan 2026 10:45:39 +0100
Message-ID: <20260103094539.3110823-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 03 Jan 2026 09:45:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18685

From: Alexander Kanavin <alex@linutronix.de>

The file (or symlink to it) is present in layer dir only if the build was
set up by a newer version of bitbake-setup, and otherwise there will be a
'file not found' error. Reading it from config dir maintains compatibility
with setups made by previous iterations of bitbake-setup.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 58273e4dd..38c1d4d36 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -93,7 +93,7 @@ def _write_layer_list(dest, repodirs):
     with open(layers_f, 'w') as f:
         json.dump({"version":"1.0","layers":layers}, f, sort_keys=True, indent=4)
 
-def checkout_layers(layers, layerdir, d):
+def checkout_layers(layers, confdir, layerdir, d):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
@@ -118,7 +118,7 @@ def checkout_layers(layers, layerdir, d):
         os.symlink(src, dst)
 
     def _has_local_modifications(r_name, r_path):
-        fixed_revisions = json.load(open(os.path.join(layerdir, "sources-fixed-revisions.json")))
+        fixed_revisions = json.load(open(os.path.join(confdir, "sources-fixed-revisions.json")))
         rev = fixed_revisions['sources'][r_name]['git-remote']['rev']
         status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
         if status:
@@ -370,7 +370,7 @@ def merge_overrides_into_sources(sources, overrides):
 
 def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"):
     layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
-    sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
+    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
     setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
-- 
2.47.3


