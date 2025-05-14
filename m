Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0C8C3ABDA
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 21:30:04 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.113459.1747258197900950622
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 May 2025 14:29:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=i5duXiZI;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so2023375e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1747258196; x=1747862996; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9oW0UZ/QCsIARU0oLyBwe62V1l3WqA9b3yTbquNokA=;
        b=i5duXiZIRyhdV/1T7MjIv4vm8Yaxa9xiohltPYREDACTxQZH4EcFDfZ9B/8sBT935m
         hFaF+iBxRdfk3P4D342Mq3Q1y4HXkZgjkyme/bZGFQdjYMTYhcCq0c6+FwBeTqHciL8A
         Bgx0oAccB373aTB3IydHpsVfpCoxHEzO8wzvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747258196; x=1747862996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9oW0UZ/QCsIARU0oLyBwe62V1l3WqA9b3yTbquNokA=;
        b=oXDWDam4yvGtssaOUK0BwtY6QRna8rqgjrV6nXpmxazFfnEiA1WE4TJT2uG8/Up1ZQ
         RgzLO9bjX610y6A9d/dFHob38BOwkZ9n02EFE2TTJtM+yO8ueHafhN1E8prTCpJtevuq
         eXji2BM6ulyu1Os9CUJt4BSz1CY8hPyQEWzQaws7Vt4mnHDk/fvKe/jnZrcgD+oIhgej
         9Ou7D6g6wVz3zbEObLPjxXhIRdHk3CxkQWDHdQdSRKFIiKy9+Hk0kIf/u2AE4aTFJ24w
         IMda7nmJaaDm69eTKJibOE5hDVOx30PdAhpujoMR2Yb4MoxCyl50QsZo0dsrf47Rqjus
         znFg==
X-Gm-Message-State: AOJu0YwZ1YNar2V5eYAo4ftzD4OPgCyHRIrIlVTweJMP0H2yvmBmG5e4
	++YbXZuThlipSVfLd/WQ8AhuZbwSwmyqkNj86Gr9o7kIw4zoAQZdw+9Iu529RaXKr9fWKYcOkwx
	N
X-Gm-Gg: ASbGnct+P8xkEd7doTQbPPjfDl1d/9B+RyUGebXO3Ss5LliN7xyvUI5JgJ5ySqqQ/GK
	QNrFe3Ti2XmN/u2K/K9czH6WTXwjYAYH5T6wZARjnWNYdQ0IR8r6q5lTDigb4btpQ1EfQXUD2Lb
	vaTz5NjCUf5Lt4bWYThegmfVo0pkzCCtyeAk8RAWp1QWvHC7ekD1joWxR6O1YaTaFxBrk/Hicad
	nbR6CsukI1RtOCgAeejrG01aEkUSkLIhqRXzUoqIOMT8vfgthARuXyBz7Te9D+4QcwFlLl4Isnz
	DkKpMmqvkpV2rOsLvu3IZzgMqVsF6sDXsgsgHcDvuT18LQ7BnvN1l522xl33S23yNN8MV6HqeiP
	g1xLJpFvkhqxB3hmP2qBcJgYpuGtpWpcVLdCRWtv7IMuizzRmsAsaLMZZtfU=
X-Google-Smtp-Source: AGHT+IEgn2QbWDsVtwJxQafgcsET01VKZLEc1A616WOzKWAgWEDYpJH/X4QC4ZVjXDpWJOldndneJg==
X-Received: by 2002:a05:600c:3e08:b0:43d:b33:679c with SMTP id 5b1f17b1804b1-442f850c54amr9226795e9.14.1747258196103;
        Wed, 14 May 2025 14:29:56 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.home (2a01cb001331aa0017b58d8bf04048c3.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:17b5:8d8b:f040:48c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f337db47sm42883815e9.12.2025.05.14.14.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 14:29:55 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] knotty: pass failed task logs through the log infrastructure
Date: Wed, 14 May 2025 23:28:52 +0200
Message-Id: <20250514212851.837656-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 21:30:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17611

From: Yoann Congal <yoann.congal@smile.fr>

By switching from print() to bb.plain() to print failing task logs, we
allow them to be saved in BB_CONSOLELOG.

Fixes [YOCTO #15798]: This allows AB reproducibility test to save the
full log of the failing tasks and helps debugging.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/ui/knotty.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 2fff1b36..9a589a5c 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -353,7 +353,7 @@ def print_event_log(event, includelogs, loglines, termfilter):
         termfilter.clearFooter()
         bb.error("Logfile of failure stored in: %s" % logfile)
         if includelogs and not event.errprinted:
-            print("Log data follows:")
+            bb.plain("Log data follows:")
             f = open(logfile, "r")
             lines = []
             while True:
@@ -366,11 +366,11 @@ def print_event_log(event, includelogs, loglines, termfilter):
                     if len(lines) > int(loglines):
                         lines.pop(0)
                 else:
-                    print('| %s' % l)
+                    bb.plain('| %s' % l)
             f.close()
             if lines:
                 for line in lines:
-                    print(line)
+                    bb.plain(line)
 
 def _log_settings_from_server(server, observe_only):
     # Get values of variables which control our output

