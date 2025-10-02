Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5528CCD182
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 10:09:45 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.5231.1759399777849993283
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 03:09:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IMfsBFdc;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee130237a8so577727f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399776; x=1760004576; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8qqT3sN+iuVfNxkatQt7RoqzzONzAC1cNfVfZc6Y7I=;
        b=IMfsBFdcZgjlQiBwMzYgq7ruwYHhZRCy1TnMRU/ikbyrKPVGoNraq4mey9CAv9x29g
         GXGsGmCvTUzDgxBFY0UV5NgVlb75yDUv17fvC18ko/PTCDXhCB4LTO0O2Eve/0HG2Zgg
         fSkx3MceC1V4EBe5KCsfqK+drW4iSLWozPPLpaYnWl9igVnzem96KOIqRH6u760/BccI
         lx6/yLuXpa1iTmIfLBmF8JKGCsl8H0fY4VYyqDo1iJNhkPByokY3pJ4Re/fZuIjoJ0BQ
         XS+CcoCw6WIve7TMbXG8dHn0MCDEr4X5nmhUgG0wE6aDBbzRN0jTDPvlId//M9y7zJ2f
         Fdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399776; x=1760004576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8qqT3sN+iuVfNxkatQt7RoqzzONzAC1cNfVfZc6Y7I=;
        b=k7Sehd6gPthTdTQJStxP9M9lVvHcnS92Y+24RwoHF10WG4IPV2qqBJ9hsdOJ7A+/I+
         3uwUSXxKLhUfKakXVuRQg0hx6WNgM+XGqRnRyfKPsShYeEfYKvNnktqUzWCPr3/kmyfz
         9I8QKyxs57aEIx8f2CS773K28mifdA5PkoLRlAwG5EuooNt25TUruZiAePs7joYD0Znt
         Doz2Wl5dK5DjNbCNtCZQBa2a8FhpTm5AqBXzKwmL2Qh6kNKCosk5i41KhGRPkOsWoaVG
         6gzdl6Dw980gSRqofE9GyiKz0Ry4+9Js19zQKt+/GS9moExE5XzluQg5ZodfHcEQDRv2
         kYPg==
X-Gm-Message-State: AOJu0YwnKJCVlK73B5eOJs/y896PKeXNmlgpXKl4z+lvH09hpAB4I/XF
	bfLxKcXy0wHKyK4LtQpIJdQgSUIuBuhMloPYxi6mNNbPAK0pPG+s0oaFb1gFKA==
X-Gm-Gg: ASbGncueoHl8SLLI4pArfkAuYE9W9wEWjG1Uy94DmXNHUlFFCNhglu+04HVaetBlTrE
	lcqWOgn2Ju4o4I967nKGlbEGWT1WQCNH3Pv6x19XLO37ec26ytOSRiYHjGnhs00cEbNHUmp6Www
	uT0ZudgnhqJ1t9z5AF0BaNfZwIoLgc5FXuW2CoPzQXSSy2pDbEEKE6QB5v5Dij5C3jP+5GVx1KE
	VDYlLYjXSjWZ9Z0T0XwJz6c4WicG27zIYHa6AwCJsRFYQrvewgQ1q9zpYMSUr90Bj5E2+S7+LEA
	ESjtNuLJ/lD2My53Y1t5cI3WOqkyLsM8zaoBJuy2XKDjeoUo4qHXtarVB57MD7+N6YcbTPP8WFO
	nqYa43aXBsaMcklcykm/ur70f6ilBLV7v96Dxbm5SLMdUFd4+GSdCF1htOka9Pj8Jlr/8oRk/1e
	2FChIQTAp3jH1PpWGlMbB0rhG40FQc5xN5uCzAw3rvxnAIFzAIoOvuESVrzp3m2y3XO8KqpttM7
	tD2UI9ohQ==
X-Google-Smtp-Source: AGHT+IE8USIC/ZgOmQAWfQ0KGSSPxz047WC7T+BSn+l9hdBaFKIB48kMCYwVcckCQLc34kfYvkhkMg==
X-Received: by 2002:a05:6000:2012:b0:3ea:e0fd:290a with SMTP id ffacd0b85a97d-425577ecb00mr4621119f8f.12.1759399776092;
        Thu, 02 Oct 2025 03:09:36 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm2953894f8f.12.2025.10.02.03.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:09:35 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 7/7] bitbake: registry: make a separate configuration for poky with sstate mirror
Date: Thu,  2 Oct 2025 12:09:29 +0200
Message-Id: <20251002100929.1054540-7-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002100929.1054540-1-alex.kanavin@gmail.com>
References: <20251002100929.1054540-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 10:09:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18121

From: Alexander Kanavin <alex@linutronix.de>

Using sstate mirror places much higher requirements on both network robustness
and network bandwidth than just fetching source code. When the network doesn't meet
those, the user experience can be very frustrating as errors can be cryptic and
intermittent, or bitbake would just seemingly do nothing for a long time.

Let's make sstate an opt-in, and provide a caution for using it. When it does
work, it works wonderfully and does accelerate builds significantly.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../configurations/poky-master.conf.json           | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 3f1299179..60531ba02 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -53,10 +53,7 @@
     "bitbake-setup": {
         "configurations": [
         {
-            "name": "poky",
-            "description": "Poky - The Yocto Project testing distribution",
             "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
-            "oe-fragments": ["core/yocto/sstate-mirror-cdn"],
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
@@ -66,7 +63,18 @@
                     "description": "Distribution configuration variants",
                     "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
                 }
+            },
+            "configurations": [
+            {
+                "name": "poky",
+                "description": "Poky - The Yocto Project testing distribution"
+            },
+            {
+                "name": "poky-with-sstate",
+                "description": "Poky - The Yocto Project testing distribution with internet sstate acceleration. Use with caution as it requires a completely robust local network with sufficient bandwidth.",
+                "oe-fragments": ["core/yocto/sstate-mirror-cdn"]
             }
+            ]
         }
         ]
     },
-- 
2.39.5


