Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E71BCD98D1
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 22:53:29 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33615.1781132004327087769
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 15:53:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=U0/2INfO;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ac357c55so76931935e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781132003; x=1781736803; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CjKr0qX1d668HabZpFzG+MHiddz0rIE6LgKXx4FAjA=;
        b=U0/2INfOgYBDLaRfVBPSTZ3DxG3hVLgYQBYlxe7G+894KI6amg3W7IloGbKoEESME6
         pGoDl6RlRrxkAOCrf66A45/ZgUnmhMimgYdFC/806n/LZP0h6LKjFT04lKs3+IXOBqw0
         5lMVZftcJpAlfIP7KEDtUyuPjkjl3Md3XdNIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132003; x=1781736803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4CjKr0qX1d668HabZpFzG+MHiddz0rIE6LgKXx4FAjA=;
        b=LVFQP055yAWx0xAfg+mIWQn6MqqcqW8ekoTRUG/3AOxD2rZSDqf8tEKlnUgt+rOpcI
         Td7XZjczvrptHyNVLq0vAN77UBQTWKsXoaixtSctCopaAfEffT8YaxaHO+05X7W2z9KI
         w24OrZ0yEIIOw0TTEa5fp882HiBYzQo8xGy8aHCkpf0JH0JB4yNbU8117vtfgM+eHvuW
         qMXtJ9naZ+RH3GMlGtHpgCEP6+24BMB1mLeV2L5zX2onq/SXHbLuvoUi8QomaJdWrYjC
         4FxM8w8CLSNwVLcbykfBBHNJJuJasTlw0HBSXOcoDoAEsfH4LwGr3SP+7Vxm//do2t+D
         wNeg==
X-Gm-Message-State: AOJu0YyLdj4ws8xE3GCOCJZ/PIL+/X2u+4x164tH5b99DwXfovzFiW07
	eBpwhPI3VaadnNEwM/clr0SrFgDJeAzoN0IFn/redZFhfU/c+fF3IifephzVNHOsn3We/bWNz++
	iIi5x
X-Gm-Gg: Acq92OG3lZNlF6n/rlOzvjEcVSzCX5gPPNWNCdE8KKpC9ra6WibqcRNnaVw5P8Rc8Q/
	1SypGuAkmvWixgtirBJKFDr5oMsCeUHK0yD3tvHbpNKSoZj5eMgBgZFIlKd5xZGu4LbNDCUgATh
	2gEur4pEXq1FucuLmi+LnbZLWDydXo8IRjfR0JaZYToY7YdFFtyUBmfkTXKijE5vitjybXAS+6/
	qWn4as/tGm6NRJ4faxZ5YEGighOJ6B/6UnipSYwHBLPcxhRP0inn2WXn2jD8CkBcX5X6i4E0O51
	AeVgz3Tb4lzhKQklTV0t9L/KApVJmOM0fQnvs6hMBnX5Av5lvnrw7A/b4+uw0y1kBC5mayvDe88
	wjv3uyaURT3+O+xtQSVPTvSnqPx8nQ6dkL5Mrtfg7KVW9sy2N6w1AFATi2z3TucxplBqkesVq6q
	ofG6mGCTJtHFngXeKdjFKzMo80A5jQuhHC5dlxWyxTKVjSW9Zf8QfBfDbtK0JMK6xK5yl6/bJFN
	vvsIZ604dPP0X7AgxGw/0Jb3Ch30wBbuQFI0Ec=
X-Received: by 2002:a05:600c:c493:b0:490:ae52:499c with SMTP id 5b1f17b1804b1-490c25f1ab6mr459391815e9.21.1781132002610;
        Wed, 10 Jun 2026 15:53:22 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00bb749f54eeb85d7b.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:bb74:9f54:eeb8:5d7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm132348771f8f.29.2026.06.10.15.53.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:53:22 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 1/6] fetch2: reraise IOError during download
Date: Thu, 11 Jun 2026 00:53:03 +0200
Message-ID: <69e22a5f95d650ed83e6064d4e99b8dc067a6659.1781131922.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781131922.git.yoann.congal@smile.fr>
References: <cover.1781131922.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 22:53:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19648

From: Anthony Squires <me@anthonysquires.ca>

Fixes [YOCTO #16268]

Adds a missing "raise" statement to download that ensures when there
is an IOError/OSError that is is correctly reported and not silently
discarded.

When an IOError is thrown in this case do_fetch silently passes which
then leads to downstream failures in do_unpack when the file doesn't
exist.

Signed-off-by: Anthony Squires <me@anthonysquires.ca>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0460038e4705934e614b26ba5febc09293924cd4)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0e4f491ce..d913d7511 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1969,6 +1969,7 @@ class Fetch(object):
                 if e.errno in [errno.ESTALE]:
                     logger.error("Stale Error Observed %s." % u)
                     raise ChecksumError("Stale Error Detected")
+                raise
 
             except BBFetchException as e:
                 if isinstance(e, NoChecksumError):

