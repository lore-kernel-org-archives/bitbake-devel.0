Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAD9C9EC89
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 13:04:23 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32408.1768223055229560926
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 05:04:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DUEK9hUf;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432755545fcso3721060f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768223053; x=1768827853; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1RssWHfudj1aZ4XVb5OlOsJtQnvZk9idnLiA05Rz7+o=;
        b=DUEK9hUfbSx1T6LzIwu438arMYWeltUGnc1DF90HIypS22fY3Ks7Mg7kswsdQfZqcH
         laG35r/Wc1Fa+2kEA8J3e8+RP0DhLRGQ4mrEhNf48coRVXT4hatCnzV6shC3r3BAqSQ+
         lWxMKaGrGntM8WhtZGRWjqpAS77Iuvj5SIKqw5Co0e3Qulh4NtuXLZQAs/IZZFbUO1bB
         I7KEEQNEAJ8z5eN8ghssLZEZnB+Hc3kf12tfwT5leY+FyyuLPa/EZCDrE+uCWqKFQmR6
         tHR+50PjPncp0XarmF4zXckzH/A9y5B4VnCih0Fa8bN5lG88xZlguy5o8F2eQCZ2Q5kF
         /I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768223053; x=1768827853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RssWHfudj1aZ4XVb5OlOsJtQnvZk9idnLiA05Rz7+o=;
        b=jAi11dEYMW8Py7csUjm02hNdAgdeGTacYhGc1ppqMSOW4MD8RMDwH0OGyVC8rwCbcj
         URyUcjhRceQsAAoq55jj9xVAHV3e+ojs/xCDKzFxzmrD/XBHCVDpsMZxtR/5fEPLreQH
         HyOpgfo6PoQo/kHAA+RgIgsZ4PV+fMww7uff/ncJgxf9m8WwGZ8Bd2tJRkacBT5dIedV
         YcaOQUlyn6lbJBSNqwxN7D+vCySWFRaf2owCciA2RCEBBbQRr2wXrBOv7wb9s8xqrxT7
         zOZ6TTOP+tZNIpOBr4fbMbudvqbFvP6W4B41bqVCDIU2rbRlckp5u7LOZLov6iydqrd3
         VTbA==
X-Gm-Message-State: AOJu0YxToMkMg1UIZdZ0FCWrdqPmgL+3i/9k3sVIaOJRuYu1X3sVeVGH
	jo8LlCWO/eR9YiSGRy0YAY3EV7F1r27K8d7xZ4d724WdYKKTimgQxJ6MwVFSKav3
X-Gm-Gg: AY/fxX491KHh8pIqL0Za0R5qTleJSBI9oKiZMHnIaPZL8ZbF9yPTwKghMkdedHmnmgB
	HZ6L2g686YUsKfwIox0lFuXlEuoCW61BuUzkAuzMtqovpLagtnoB6H4TvqHLQCS7Gg1lLIhBNlb
	bSgzfN0srTtGIyHRcCUYppYyaMNmKGDu29AfuUPscKadZlipKs3dNAYi6UV7eYG718Q8x4BKVBU
	vuvITJsifAP9/mcmV4lwnqiTVviIjdeuJgs0VyfN75A/Hnz4xCitoKEp9v00wMgPCZVkWla4QyI
	5chPqEGNCI3gVjjHi61v0lta7DodTOliw9bfhuNKjWmwSFp9hE1Fw8uAiIyKCYfOZjXziITwHAE
	aIClgoMziZfiSBvbNYZ/x5m++tbdYP5uSTgCMtXHeofxxOYpbQ2H90BbPwc1fDkt4EkXISoKY3i
	eKD9xxgxpcTjlErC8eaygC7O9hqWkG8IDUcnuLq/KCAcnpwlI=
X-Google-Smtp-Source: AGHT+IEflAWwtLLQHkGlgI60oYVo5jPyb8dUSwRDV3xWremIPpPlYjRIGBOqdz/nVat8FQFT+tBcFQ==
X-Received: by 2002:a05:6000:4305:b0:429:c14f:5f7d with SMTP id ffacd0b85a97d-432c374f13cmr21535227f8f.29.1768223053249;
        Mon, 12 Jan 2026 05:04:13 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacdcsm38056660f8f.1.2026.01.12.05.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:04:12 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: correctly deduce top directory from BBPATH environment variable
Date: Mon, 12 Jan 2026 14:03:58 +0100
Message-ID: <20260112130358.3165670-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 13:04:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18731

From: Alexander Kanavin <alex@linutronix.de>

This fixes running 'bitbake-setup init' in an active bitbake session when
a top dir settings file is absent. In this case, bitbake-setup was trying to make
a whole new top directory under the current directory. It will will now use
the existing top directory, deducing it from BBPATH (similar to status and
update operations), which was always the intent.

The code was relying on an existence of a top directory settings file, which was
always present in earlier prototypes, but is currently created
only when a setting is explicitly written into it. This logic is changed
to use the bitbake-setup's cache directory, which is also explicitly created.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..7f6ea550c 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -43,6 +43,7 @@ def cache_dir(top_dir):
 def init_bb_cache(top_dir, settings, args):
     dldir = settings["default"]["dl-dir"]
     bb_cachedir = os.path.join(cache_dir(top_dir), 'bitbake-cache')
+    os.makedirs(bb_cachedir, exist_ok=True)
 
     d = bb.data.init()
     d.setVar("DL_DIR", dldir)
@@ -920,7 +921,7 @@ def get_top_dir(args, settings):
     setup_dir_via_bbpath = get_setup_dir_via_bbpath()
     if setup_dir_via_bbpath:
         top_dir = os.path.dirname(setup_dir_via_bbpath)
-        if os.path.exists(topdir_settings_path(top_dir)):
+        if os.path.exists(cache_dir(top_dir)):
             return top_dir
 
     if hasattr(args, 'setup_dir'):
-- 
2.47.3


