Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B371E77172
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 20:41:47 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.25256.1733344900203292811
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 12:41:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=QpcMSBMM;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215c4000c20so1779965ad.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 12:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1733344899; x=1733949699; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cL03ZZJzyks7UsEX8uuC05r5atyoHKqwkuocj6y14LA=;
        b=QpcMSBMM+deu4IzTuPkXQCMAFIKl3M+DJoHzo65Pog7M4kYdJ45SC6+DVsx9lOO6dq
         7GhMZOzPwsACZrUxoAEHfp1MiLH7e5UGMR5qTNv3CobiLdHHPZplU6CBvc3DlKxB/7ty
         VubTm9Xpr0sfNOfUIrFG6wMAAndc+NbOHRcoY9lV8emNgK9ulken2OxkzGbGjf5Ezx6P
         qKET9ps0oNEewivJJqtOzyT7Zuo3nz63QXMCYmCw2IzTR23u9G0ij9vqJOeW9uOUSIMf
         fuZCHSPtFqIKtnD+hXodOkqcmMsho3O278D4BvLdM/f/7ogissS5ILSe9SM9v+2u1yOg
         JVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344899; x=1733949699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cL03ZZJzyks7UsEX8uuC05r5atyoHKqwkuocj6y14LA=;
        b=ceyhfis1uQ831bZyjOD2wHjBgly7P6e+e0pBaxio6+HQ0a2NA/kEmZr0soYvqB0DJ4
         Mcy83O7w4o2ErvF53uMJFuejiLjtB5ZRX9xBv5DMVaIk3PN354IE/fj7auEXK0hYQiK3
         uvG8IFV5r6rPFu8Tfy6y8WxC30ONxXOFa4Lx+K7Bsq31rivxiZw09Kw9sPbhGxWawcT4
         v1vHaLl/M0yELZ9EqUnGHcSqn2yiU89osQsjPTUYv7r9PMDfOFVztvsT+id5apzVIHE+
         vQzQE3jKD9ts9UgMWW+12AvTEHi/9udgjyoSFMHLsfj0W85cv7Kgbsp3nGN6Qws+I2HV
         zO0w==
X-Gm-Message-State: AOJu0YwD8jvRUAV9Lq7lmXX1IAYmPAhuwbChtTa2ZPUW1wdCQuocBCSh
	R9el4TY8qgKGvC+ndWvBsOksoiHe9sB2y2ZO0PcYbROz3XltQAVuFiOKVA2Hjy9Mx3p23z//4vw
	4
X-Gm-Gg: ASbGnct/Gl6urEqhpxkMog8ep920fB/eV5JsCn6N5SuH0Be5zJuKaPpekdHbDp0UlqZ
	QsFopqRFOqicquj5hg5i8JLEyNipEyzlHYf50KHlxEjUwKqk2ipjYC4d4gWjiTOsQ77IayxgMv9
	77cEo+WCJsuiShlS+PaergkZzbi/RO/CRQfgqM0LRPWeVAIiYqoALtWm8ObU0n4iPWd3BQgc0Q9
	KyR7mVeXMwG4EMW+W9L9pK9dTx8I2RbaTp5zZo=
X-Google-Smtp-Source: AGHT+IH5AIx9ccSUg1WLVvgKDxY9pPmliKdKP4SHWin0Y/lSABT45PcfWjHzExhnS+8EWEsrC6VTXA==
X-Received: by 2002:a17:903:98e:b0:215:5aba:7a8f with SMTP id d9443c01a7336-215bd269d60mr104148145ad.46.1733344899518;
        Wed, 04 Dec 2024 12:41:39 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155abd92ecsm80057415ad.200.2024.12.04.12.41.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:41:39 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 2/3] runqueue: Optimise setscene loop processing
Date: Wed,  4 Dec 2024 12:41:26 -0800
Message-Id: <5465f9b6e3b4748e563efc53657af96f02a41c7a.1733344775.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733344775.git.steve@sakoman.com>
References: <cover.1733344775.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 20:41:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16875

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Rather than looping through things we looped through on the previous execution,
start looping where we left off for setscene processing. This gives speed
improvements depending on the kind of build being executed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 00f4d932e3af0eeb333339cbe942010fc76dee0f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9f3abff85..b34e2d560 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -14,6 +14,7 @@ import os
 import sys
 import stat
 import errno
+import itertools
 import logging
 import re
 import bb
@@ -2189,11 +2190,16 @@ class RunQueueExecute:
         if not hasattr(self, "sorted_setscene_tids"):
             # Don't want to sort this set every execution
             self.sorted_setscene_tids = sorted(self.rqdata.runq_setscene_tids)
+            # Resume looping where we left off when we returned to feed the mainloop
+            self.setscene_tids_generator = itertools.cycle(self.rqdata.runq_setscene_tids)
 
         task = None
         if not self.sqdone and self.can_start_task():
-            # Find the next setscene to run
-            for nexttask in self.sorted_setscene_tids:
+            loopcount = 0
+            # Find the next setscene to run, exit the loop when we've processed all tids or found something to execute
+            while loopcount < len(self.rqdata.runq_setscene_tids):
+                loopcount += 1
+                nexttask = next(self.setscene_tids_generator)
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values() and nexttask not in self.sq_harddep_deferred:
                     if nexttask in self.sq_deferred and self.sq_deferred[nexttask] not in self.runq_complete:
                         # Skip deferred tasks quickly before the 'expensive' tests below - this is key to performant multiconfig builds
-- 
2.34.1


