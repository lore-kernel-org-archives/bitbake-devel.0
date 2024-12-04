Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA0CE77171
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 20:33:56 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.25073.1733344430756045248
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 12:33:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Aft4UIqU;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.41, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so209801a91.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 12:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1733344430; x=1733949230; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTKNo+CtlIIy1v/tAWisJ5For3J41Zwo2KlWYv8iMgQ=;
        b=Aft4UIqUNnFyYFqKETvQTHt9tGnoaytKujVTO7rKmzNsazyEXAjDIruhRn4SBTAyFR
         rDjQIHc5uKeDu/rePJawYJ2WK9uVh1O8qPlcjuJwwLK8MyYkjgExdNrZTL7rrhkzqITv
         piH7t5BJdJBZSVMfSzRMdaoH6dRmQ2Uk1m/Bgon/Fz3JxBQnoY5PO4UPW5uxoEm71jkd
         AzBdMrdSay4lazNuMUUYq/iRlRX1pl2x8btmp0HWiTcj5e/NOrdOcr1qMXWr5ajmDjWb
         t2G5VnhkSXDe1VR4gqDG2nZ2U0Y2N5z26mELPqMAeS7KPMgyrF1U9tYsOu76igt3vINt
         62fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344430; x=1733949230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTKNo+CtlIIy1v/tAWisJ5For3J41Zwo2KlWYv8iMgQ=;
        b=oz1jMrnHnlwRetr0ACrwyTta43iSqXN7RWdGSU1Hm60ZiEf1rdxW6Je8XQWhtESpLm
         2CCFzgrw16KE3fc2npMTnJhIfhru3pkJ5fN0ynWChhoXnbcTLRDCUVqklviSNuqJQZd4
         6+YeaIxMvQEUDSLO5C+IWE54vh6pr765DHgQqOjAo/yafoRlbny2QW+xSygDkKI/fPjh
         P3wItUVzsuSp5EDvhRCRuJAR+6ClJUsaKBO4KpJy5Q1SLPxw7pYAzcOqyfuJfCQe8GVF
         5Q4xC9noKsnbNcGiLiZC0TLKaxMw2yguCcKsHJ0AJ6oToUul5FgGtjPvEdwHUcQUyhnt
         GvQQ==
X-Gm-Message-State: AOJu0YzXP2zGoERaAocq7uxXlZiBOpcpBgajTK9GJdTomUPTlgLF0Caa
	UXe37VgDREPlUjNekTTXRvJnlw9r8RWyLLfZlfFCI1k8NIOQxosDszuKy6486ZkWpd6ZhtH9ZN1
	h
X-Gm-Gg: ASbGnctXP29ItpWHjwmvs/NH63OLjaQTAVysIZBWm+OdflsH+rAumtO1MEDIwZzUcHH
	P5zHTCvC5kwROZyt6AxPXSqZAFhzhx8FcSDlN3IqU7pg/0PRGTP1Yj24vyRD6dEVPRqzDQQZfbq
	ydMfu8OeHkz9lDBJ2pYKcc5BkA9TyqTZBpyAn8ZTrorxQRExw3KQEg5WsWsmoiiRAdWvi6f7krh
	rhwA3sdp4DkRLS4OqoN2Vx6AGIXvI+sLqFmzV0=
X-Google-Smtp-Source: AGHT+IGfdkvUHNemsmEY6ua+qRUe8N3WX6Bcl8FMHpPeIXDwrFjCRtzPSiM+4vNJBLN5HEj2QGPcDQ==
X-Received: by 2002:a17:90b:4a0a:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2ef0121020cmr10190437a91.19.1733344430093;
        Wed, 04 Dec 2024 12:33:50 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27062fa1sm1873984a91.45.2024.12.04.12.33.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:33:49 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/3] runqueue: Optimise setscene loop processing
Date: Wed,  4 Dec 2024 12:33:39 -0800
Message-Id: <28569e9796d4b34d7b77b4f79074ab7854850386.1733344286.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733344286.git.steve@sakoman.com>
References: <cover.1733344286.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 20:33:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16871

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
index 744542b08..75aef96a0 100644
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


