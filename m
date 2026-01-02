Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E26FA375C
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:34:50 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11905.1767382489871464207
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=en6gzKGP;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8018eba13cso1932440166b.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382488; x=1767987288; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVvPZUTrqnZCZBZwVYqJUkuEtLQjD9tVRkQn0CEDe1k=;
        b=en6gzKGPshF3o2PML4Pozz+Cidugi3Nn2l39MYFABcqU9kzuWAtQ0ZrjMGM2H+UvW9
         11096Qc6vXimxgbwNfW3MlYIsz3Yy3sLZvqbhafp+Yu8Ii3dIaq/PdVtK++KihwZTwSd
         lqmE0hI89zFdPNCdPgJOsSbHsdt3qIxuI5m6WRJ72VNrU2ymls9mIIek/aK+U8IOAWYy
         EJu9ztO9I3aAWlT/vC+GD1hkMN4GueDS+mGvr40lIOo6O87EcwqH71nkSRhF0/JuR5hC
         L9z+fmy741g1V97Uuxt4q25P0RZDf4eUyAAzronuAUST6MBst+DnbGGF4knn+7KuLpX7
         wIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382488; x=1767987288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVvPZUTrqnZCZBZwVYqJUkuEtLQjD9tVRkQn0CEDe1k=;
        b=E0/2IIN1FE2eP3g5KRwKwEjt/n1Kx61AOlr1zZahkcEijCJJ9kF8XJeJwZ7/wnWpd2
         La77NK/90YLZFQU4CPcOXiHal2ER/HD5b/Va4KFQLFf2rhkcfeGlfyYr+hQEFTHsIOIO
         X5zBy6ZBJ9f9R7W/yyTDx7EBJYcVzeRFtBN9HMTAp/chx6tWt8K4ATYI3nJ9STfCgweo
         9QF4eJF0t2VNuAHvUKCo4qkRiAEf1+MM7JKnVpmbzRBh97Ua73XaZGqx/ixdB6tmLUqt
         53/rOoBhmLKjMbIxGtlVcxMe13PZC2DG/r6aE2r5y5z8WC3DjWzD6yKSv2czQewsYSDB
         3x3Q==
X-Gm-Message-State: AOJu0YwD4hJjUGfT3dUEY+Pg8CxnBKzYK2kMbVHw/PikXdZb7GJdmyMR
	GQqJqSQZUohv/bQUwtb1B/cW3/NMI2tXVZcN6fQ4zV/tvLOyO/VXnjPRYGBI6Q==
X-Gm-Gg: AY/fxX5Ea7Nbs9gXC57mm24Gvfs+wFq9ymSKUM80taTtukccBONCrFSocNPoBMY9NAO
	8nTAYDuEiXsAy40yWiyVyHiIx0oQucojQ9e+RGwboDyAmblHjO125+bXSSdsOblLloocf+z15UV
	2a8iQeuwdWDyZl5nyzDLfr5AR9oPRkOvoD9cHJqeS25oG+KXSH/wUCgWOVo5yWlvtZiCH5SkT2C
	H/a3Bcu7VDnjJL1Gfsjv3V8bxjcTiWYhl+HKIRyjHnRHR+o0F+hS91bKfglxGwj5wTe2VYp+VXS
	8h/fIH1oDncxWzz36yFNRvH64qy1uKvbq5ZCFaj/4CweAUpXDHZb3tITx3nXEj/ExQ6ym0vdhm0
	fj4HbXHOpPGCBn9xK8eN0/1YEYXJfuh7IFmyrE9TS56CG8tZM3TMFtcjul3aY6mlLJy9shgXSUb
	vt3y7x2KUK/luNdMP3oM4hMZ3guvXV/Z8bF/2vjgfnhFBlUpI=
X-Google-Smtp-Source: AGHT+IF3bxZ0gMo0EPyHg7kgGh1LyuJdKWXyvwd0peRXdmGbkqanHBBGfke25nkh580QVsz+P1ZdwQ==
X-Received: by 2002:a17:907:3cd5:b0:b83:95d7:9d50 with SMTP id a640c23a62f3a-b8395d79ffbmr1273917666b.38.1767382488074;
        Fri, 02 Jan 2026 11:34:48 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:47 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 04/10] bitbake-setup: consider overrides when checking whether layers have changed in 'status'/'update'
Date: Fri,  2 Jan 2026 20:34:31 +0100
Message-ID: <20260102193438.2960561-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102193438.2960561-1-alex.kanavin@gmail.com>
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:34:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18674

From: Alexander Kanavin <alex@linutronix.de>

This was erroneusly not done, and the original layer spec was used.

Make a function out of the code that overlayes overrides onto
the base layer spec, so the code doesn't have to be repeated.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index a0d1aaeda..7c4fa1934 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -331,12 +331,15 @@ def get_registry_config(registry_path, id):
                 return os.path.join(root, f)
     raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
 
+def merge_overrides_into_sources(sources, overrides):
+    layers = copy.deepcopy(sources)
+    for k,v in overrides.items():
+        if k in layers:
+            layers[k] = v
+    return layers
+
 def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"):
-    layer_config = copy.deepcopy(config["data"]["sources"])
-    layer_overrides = config["source-overrides"]["sources"]
-    for k,v in layer_overrides.items():
-        if k in layer_config:
-            layer_config[k] = v
+    layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
     sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
@@ -654,7 +657,8 @@ def build_status(top_dir, settings, args, d, update=False):
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
 
-    if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
+    layer_config = merge_overrides_into_sources(current_upstream_config["data"]["sources"], current_upstream_config["source-overrides"]["sources"])
+    if are_layers_changed(layer_config, layerdir, d):
         if update:
             update_build(current_upstream_config, confdir, setupdir, layerdir,
                          d, update_bb_conf=args.update_bb_conf)
-- 
2.47.3


