Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A8D5B175
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:51:45 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47792.1765803098828779092
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 04:51:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MtCzcyk3;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so2313343f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 04:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765803097; x=1766407897; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w+MKpO1iFq+PRm1njJInaGAotTj17Qh3O4toYc/64w=;
        b=MtCzcyk35c2kMjiVqF7sNoi7LhMAZo4VNn7Yh2H70MYbfXDusd5XbsjCeFIUjZlFvl
         fKPGKHHXDFRrkLQ/j7t6sP9GWM9oG8wt+1l5kQ2kYxCBUlsy8uF0qpN5TN7tcjYUB4Fh
         LYw12VQhqXMXV0TR9/f2FcxsM0SEPKxzvq68IyMfdImCZo1jLrVGYnlUJbwSmHWZ7G1D
         knnUPlA33DGULI0JRCoF+AZWPe+FjlRsjl/FfTE3rrjRoNRokHY8Yx9bCGudG8oQjYHU
         YtvlA1du5JTX8+Q/Dw4D2z0+JMq+pL+EEm4reC2o1LyDWwXcK9GCTs7d6SHv5cCoditP
         T7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765803097; x=1766407897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6w+MKpO1iFq+PRm1njJInaGAotTj17Qh3O4toYc/64w=;
        b=YBc/HqHwav2gpTI9/ChvEdOpDDQ0wEjG5IeCQkHGTgaBkompMMA35OYHJyc9JSHYpd
         oaGBDgSq4oaf/HOtS7+c1qCueLMZinv44p9OEg9prizAvWvHRSWCw1+HXp2SgGX2YrYl
         V50p/+Zm72B/Eemy3uSkW/baffm03Ndmx2sWZYPK2zdkRwmoVtN+9QdMIdmTvsSEXj3A
         7CT6BgefeXV/b78Phy/d8+FzSuE/hoEGjfcpa1zsdFOjQroMrPiWDZIaf1aP2YbktymU
         m/7bIJpn8NrzJIC7mTI3oE1MzQryA9xLG+3kebWEofTM7GCxV8uouHFSa0SLiGf9P2cr
         KUAQ==
X-Gm-Message-State: AOJu0YyA70tFq74C+zqOo7w/x/PwG+DP1j17kbcY0UkZVZIqAdq8YaSB
	g5XxDmZVKc2XZqs0vA79DabQTeh5aZkZI//jmiHVrNpSvA2SYuD35d046JZ6zw==
X-Gm-Gg: AY/fxX7Hlf/fqxXaboZnzmsiopnTwc77vs7m56LI9mzNBRUrUg7iPUGrj32ic8IF/W3
	KXaS8SkJ3eplH1wlX0hOBtDL+skU8lqbuSgyDjXZ2PxBX+hYJtW7N6pC2s3Lb4ZXxgfqzBTkSCR
	v2hbBVLriKEfJ2koP6FO411sJbZ+MZsljftNLS2q20crZVnYZZDtv+xGv+AarkTpOrd0vOEXGbS
	9h4pRzcdLxDnpfHqYYuXC6o/rO/mkTMLlLfDOFHf9NZZC+k5PfW8v/OGXC76GlxS4Bbg7JfqqeE
	rAfOmIkDt7spgkjzoA7i+EGPdyS311lc4jwmMaQwZY/pTSQiyCXBJ5JRnycD60EKKzr64azvDvr
	aC5iHkQgIjaLrOA3vsu8xhiwvBjfqDX2spA3JNK+wY9QBzk9tLJ0+8xrX/rtBVWEIxiT29O/D1X
	xNaOJKVX8JqBk7bclt8JCTvx33zC8PAEESxY7F426ilMr+/RY=
X-Google-Smtp-Source: AGHT+IHABIRq9rzApx+Bz3Jf0VtqNqtVeyLUm0lOuIDF92p635elYSxmL3Lx2NwmG1O9wDqsb4I5yw==
X-Received: by 2002:a05:6000:420e:b0:430:f241:a11f with SMTP id ffacd0b85a97d-430f241a3cfmr8690821f8f.30.1765803097092;
        Mon, 15 Dec 2025 04:51:37 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm29303342f8f.0.2025.12.15.04.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:51:36 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	antonin.godard@bootlin.com,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 2/5] bitbake-setup: override complete source entries, not just the git-remote properties
Date: Mon, 15 Dec 2025 13:51:24 +0100
Message-ID: <20251215125127.2660714-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215125127.2660714-1-alex.kanavin@gmail.com>
References: <20251215125127.2660714-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 12:51:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18592

From: Alexander Kanavin <alex@linutronix.de>

The code was assuming that a source entry always contains
a git-remote property, and that is the only property that
should be replaced.

With upcoming introduction of local sources (using 'local' as a
property as an alternative to the existing 'git-remote'
property) that is no longer true.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b1d751899..8d4e9769a 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -323,7 +323,7 @@ def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"
     layer_overrides = config["source-overrides"]["sources"]
     for k,v in layer_overrides.items():
         if k in layer_config:
-            layer_config[k]["git-remote"] = v["git-remote"]
+            layer_config[k] = v
     sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
-- 
2.47.3


