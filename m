Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9879CA5FA0
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 07:46:58 +0000 (UTC)
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32880.1790495201049154414
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Sep 2026 00:46:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=JPaY0zxK;
 spf=pass (domain: smile.fr, ip: 74.125.225.98, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48884b926f0so963856f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790495199; x=1791099999; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ao6gpCEgEayUZcwXqtktm4i185YPAb2C/VXgHnnZThg=;
        b=JPaY0zxKFI0lK1NQIs7nTCFJqMvaDXIFKzLrpkq+YByqpeB3mT9R4xmA25RuSBdTUn
         yi+a2bDyx6LikfDMvocczT3OrqCgJKNJlQm4vP272hIAVl4UYjU3b36B6GPv83jYtSI2
         Ip86js1CQQZNrfOiKBkKQoFlXdZQDNqw9KO3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495199; x=1791099999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ao6gpCEgEayUZcwXqtktm4i185YPAb2C/VXgHnnZThg=;
        b=Y7gScp+xFxLLKDSZ72WFzAzA3EjHatmDvXDjtSoMU0xUFTJe75pFp0GB/evi5LDJ7h
         nKXdVIboi5VDQ3m1plXxNpdZrpMNuVDHU64HUUqdJo4zK7zFMvY0mbhIwQc5+AWX9rnZ
         K6vSNEA0Vhm2fuXvP+/JTjYYP7LP332k1vwEKxWfGz5owsIf9Q5gzFwFSx2sYIvz5+EI
         PCNiqc96vAwaQdrZ71rWOo9Nqs02Glr7elK+lO8A8DO4I503hYpSQ0tEFwvNQHKx8ONu
         bV1RdrEtHzgRk/s45v5CnpW5P4JiZZcCEPoD//6acdeWAuKMIsHF9ShdMlG2k3+XBprV
         flWA==
X-Gm-Message-State: AFq9FYJqDzdVTF5brEM2/SDOl11HTqCGZjrVYr48zmFJXFZrJeHnij9O
	dnpIqUsIqdJiB171MFPBwZbZsKAJppIZ+NDh1rXkcZpBz8phcNUDLIvuh96viUaLk8u/sBJGPmV
	zTbvlrew=
X-Gm-Gg: AYBFou20aEmoWUeKlZNhHKQGJD4AQcFFxCMzrpkrC1707wh9V+QgcnvGHE3Dx6HquHc
	NZichuaj99HEuxQW00R9tHeCzbLWLGWSAQ6fypY8RMmyjrGPpsHS8/umj2aKTZhKwvKojoPbcpz
	fFUQZ0awQTDVp+58rCZZdgm2OEJe+weq9uNg/nm3qqpjCF/5hzT9byLseq4BL1HlBvZa3Z09VBj
	S7pWJoQI0+BZ3QaO+w4vlJTwzFsRuqiUJ3rCsQijCzqGJQXMJ1adp61wL3b8vuxhgn5wuDXR32P
	b57QjDXE/MZaytPPDYKCNu27wenMW3uqs6M1Z9p9chfWdR9lrp8sdj9vi03c6RoT0QG72IDUueX
	1ZQdRW73UYJdrj1t4Ww3PCIWXli+dawX2jqy6T38zkhctNwJRHvfcRe1bU0wDrj9REyT6j/3wsu
	QF5O50klmHXyjNOBTX6ZCwSc6PgYdx5bZ/EpI9U2wY0Jyu4Kp8TPDHEm4zqGH3spDvMFIlWLixn
	OL2wpvfl0hL4oUYXMFS3tlFvdBuRwccirTEbBggVv1fOp33DY71gikXHVuMyM0ZZLEqyKEAog==
X-Received: by 2002:a5d:5888:0:b0:488:57ad:d5c8 with SMTP id ffacd0b85a97d-4887171423cmr19465515f8f.3.1790495199308;
        Sun, 27 Sep 2026 00:46:39 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm18485266f8f.2.2026.09.27.00.46.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:46:39 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 3/6] runqueue: wait for covered tasks before setscene
Date: Sun, 27 Sep 2026 09:46:32 +0200
Message-ID: <ba8912536a60487216b402a069b5afcf605c1f47.1790495161.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790495160.git.yoann.congal@smile.fr>
References: <cover.1790495160.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 07:46:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20262

From: Chris Laplante <chris.laplante@agilent.com>

The existing continue only affected the inner loop, allowing setscene
execution while covered tasks were still running. Check the collection
directly so candidate selection waits as intended.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 714bcfa7a91327cb2e9934f5b428129936e61e99)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/runqueue.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ff8ecdf81..870633368 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2250,9 +2250,8 @@ class RunQueueExecute:
                             return True
                         continue
                     # If covered tasks are running, need to wait for them to complete
-                    for t in self.sqdata.sq_covered_tasks[nexttask]:
-                        if t in self.runq_running and t not in self.runq_complete:
-                            continue
+                    if any(t in self.runq_running and t not in self.runq_complete for t in self.sqdata.sq_covered_tasks[nexttask]):
+                        continue
                     if nexttask in self.sq_deferred:
                         # Deferred tasks that were still deferred were skipped above so we now need to process
                         logger.debug("Task %s no longer deferred" % nexttask)

