Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792BCDC192
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:49 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88587.1767701440987032787
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d9k5bx7+;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so1380104a12.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701439; x=1768306239; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVvPZUTrqnZCZBZwVYqJUkuEtLQjD9tVRkQn0CEDe1k=;
        b=d9k5bx7+U1iQOra7U4iwosud4a9UTYHUFO3TiH4cs2XS7ywOglC/+LrOsC8jp6qYJ3
         fnnISJ8zjf4+rqkEQW5Cbk9odPdueDMAoTmtSvKGmrblLBZJt+T9M+qDuBoEv7V/I1Sx
         Imymeo0z9TEP0bcoquGU5xkhPPfrUob5xTRDS8p2gtEORI5f8Qj6ujTCvZ2UhHAILC6f
         EtZRtJ6x03KDfBbUJYR2Fmjm8I59jcL7kPxDiAcuvRhsZhGSTftbtNoMxQz/4PZLlZP0
         G8Yd3SWrVusD4cifLoFqD0xgU4HankDqTqkyyBRdjfohRfjElCuFO6WkFqeuocqqg/MA
         Mzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701439; x=1768306239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVvPZUTrqnZCZBZwVYqJUkuEtLQjD9tVRkQn0CEDe1k=;
        b=h42CWfAeAlB9zqvqat0M6qjFL8Tpqi0ZlCwecpeYEVu/9bpz/bAIKmGqi30g06Wo+/
         SA9H+VlpvI1cWndPrFg4PrLYkXrHchawnVMqTSZqp94N5sFIwndaEXvluT/3thU8prOt
         +24xaMezcpZW4Ro92MsqFwDsaRRpnRKOyPA0qzjm1BbT6l4+qkPdgwWu16LRFI9JgSZ9
         iSWWdzataL+bJEKSZCtmLC6pqLKPSTi7+MX3YsG1b31xdEtIY1SZK6DHrWjt22VaArQo
         oUZxVWwDImes/TOhNjjdK/baRTquyiDKBSf45UdvPDrhXU34nK0yAVg5g8z6mzDhkUWf
         KT1w==
X-Gm-Message-State: AOJu0Yy7sc1VygCHw86dqv2Vz8Apgd9C/g5uxt/nzdKn+oEUwTaijZti
	xtHRhNW2OcS3A8sRsy+Gbniytp9YqH5gMHTqdxOUxSFsWi9zMplkUmA1BLCE4Q==
X-Gm-Gg: AY/fxX4SIeVL1raCykEe2dAAYjbTbaHv7bHaH9/8q3dW5TQEzLph6LWhDtJWyrXHLa5
	76s5Od9hR8Sa/Vk6wjPfnxMXFyGNrvHUHhF7VQ0i8oAsvFVuozBlM6KsZnf2MMFEZUQyfAOAtHk
	YNj7kaG5xJg0FY3SzKcI4+KjCpali7ROVnx1Tamub7lFnN5jMjyHyzwlWMfMTw8Ih8JVcdQD4yC
	AAFLxpjxuTT0eJyWzRJ9luvMF3BSyWOMFj12mPbHWin+gqmsyZdjqwHfnhOH1/MuyI3TVbap8Tg
	2XSkEfzTk4VOrv85py5CEKiOD2erZt3+ioqPLe/0qk93DSSdYq0jGG5oqzrgpDyn2jwlui3INOQ
	NemOhUq7Nd4xIz3V/c0RuQbyQYwVMZZZNYxohkjgtzM3fp5lpZBPW1fiQBfCdmwQ9dW8ngbmZ4j
	uSHql0swpsPZaqFoXvvogy4JT8BV1/nG91o7YSRQ8Ehfv/ue8=
X-Google-Smtp-Source: AGHT+IGK9s6y/lvcwLafk6Vfgs5xXvTvFnn8OvQnYimiPZtmAwdmF+Geh5Yjfw63xDL4Vb/3HYPtIQ==
X-Received: by 2002:a17:906:d554:b0:b76:d880:398c with SMTP id a640c23a62f3a-b8426c99fe3mr309361766b.61.1767701439187;
        Tue, 06 Jan 2026 04:10:39 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:38 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 04/10] bitbake-setup: consider overrides when checking whether layers have changed in 'status'/'update'
Date: Tue,  6 Jan 2026 13:10:26 +0100
Message-ID: <20260106121033.3892596-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18694

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


