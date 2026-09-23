Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541E1C9830C
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 14:18:20 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8073.1790173091273367826
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 07:18:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=U5J9FFKL;
 spf=pass (domain: snapchat.com, ip: 74.125.225.140, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so7304025e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790173089; x=1790777889; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ILAbk2sQrw0oBW+eh1pKOZA9VBY1XzzkX0CuHrwxlE=;
        b=U5J9FFKLCAvzC+ONpq4JHEuffeg5I2DySkkruMMR/Rr8bknmQstRLGO5bAVMY8KRCs
         xwy6Q0kQbSmejZKYx89S3iOOx66NmdJXxEy92j02065e7kuCI5yFslUgkIIdpHAIWzSG
         n32mTmlZVgm8fiMEPSOK1u3wxoptSA52PvrD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173089; x=1790777889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ILAbk2sQrw0oBW+eh1pKOZA9VBY1XzzkX0CuHrwxlE=;
        b=n4BhCvsDcAHDxq0LuPS0PoZjA+4VCNlMQ0oDEVT6MeWNdI1iuLmJ76uSDZwG/2Kf7N
         mvdtaFL//1mzrfRzywjUpMPaHsXo6vMWrtAmQk6uVQivq2v4G7g9f1xaiIF1uzSbdP5j
         /xQitLROte50JWsLedRK7hSU/N0rCA5UMZkE9Sx8Xomu2Bsechp2znHXCN964whXUCMk
         7sgAdVmq91BXFCaEBbr3ff/XsjErjP8oYAnaqpE6ELIox7fdGBiiakUa+w51Iar+bTuE
         lJ8gZU/dN0vluVC5GRBJFvEXCrj7zStk9+Y1jfEsUtUXFaYShrAzb/1QkHb7pwbbF4Re
         M+cg==
X-Gm-Message-State: AFuF++nw3ZRBQVERkUpkMzUKFPMV6CrZde4i56sTALzQuTg4+c/6e94U
	hwsajgyDx3njFcnXK0X17iPGu2BOMn7O5XV+/gj4o9svJzAVXTphqLZtJ3UFNNXAKa43QITcLZP
	fQ0m9Uj0=
X-Gm-Gg: AYBFou3e2wrnkF4RnxHqLyHOtz0AaZOA8QrEeQgJIMlmG2tzWvIaYkvwU5o01Mj8KCn
	K12FybJqpqrBSzJIYTPmaC8l7J795nRX1hymHk5OBMXidL/0Aef7mRl8k9prlm94eS4rP7rJdYj
	WwyWI2lOsRYn2E6ore7tpS64KtzbvglkSN2pjmSl03YMq3hPHCtyX+Kj1NMCDCtH7knGufP8JjS
	UB9AYI7u63o90CiL8MHZaKyHgb83rEdf7bP+jiIxyDNggNEB1CXvb+ETKUgIo4/4kJIizxZAJwE
	tFBsBwWUymxUEJ5FWwpGFGCDw6UbKZ8i7jGMZxcVtJtyNibBu5EKWEYi53ZlWNnRWJMRzlnMviF
	k1W84CWgE9v3VvjrJIetnE5HiGGs51tUXaVdpZYYpBcqFYd1kksk+F+zvQ5KOgsK19aiUYHeQaU
	WkLzZ631FmufQd9T/QI8WMynhmaa96GEG5RJE/tbqFCZqqC5DHCNAPzK2LJkM6l35iMRf5+Au3F
	ylCMAXZcAAEvb8etQKFuHt2U+DJD6ikqGuMtSekFdIgqIfnsEO50w==
X-Received: by 2002:a05:600c:4fc2:b0:49f:c196:47b9 with SMTP id 5b1f17b1804b1-49fdeff81b2mr39621145e9.4.1790173089412;
        Wed, 23 Sep 2026 07:18:09 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1a0e00sm68930665e9.10.2026.09.23.07.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:18:08 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] cache: Emit load progress only at integer percentage boundaries
Date: Wed, 23 Sep 2026 16:18:04 +0200
Message-ID: <20260923141804.2730554-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 14:18:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20243

From: Etienne Cordonnier <ecordonnier@snap.com>

The check added in bdd7813d8 ("Show the user progress when loading the
cache") was meant to fire events only on whole percentage boundaries,
which Python 2's integer division provided. Since the move to Python 3,
"/" returns a float that increases on every cache entry, so a progress
event is sent for each of the ~5,000 entries in a typical cached parse.
Use floor division to restore the intended ~100 events.

Cached parse-only startup improved from 5.03s to 4.54s on average across
three alternating runs each.

AI-Generated: Uses OpenAI Codex
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 2361c5684..24bde62a9 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -736,7 +736,7 @@ class MulticonfigCache(Mapping):
                 # we might have calculated incorrect total size because a file
                 # might've been written out just after we checked its size
                 cachesize = current_progress
-            current_percent = 100 * current_progress / cachesize
+            current_percent = 100 * current_progress // cachesize
             if current_percent > previous_percent:
                 previous_percent = current_percent
                 bb.event.fire(bb.event.CacheLoadProgress(current_progress, cachesize),
-- 
2.43.0


