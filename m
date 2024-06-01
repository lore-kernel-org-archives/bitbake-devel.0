Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC6C27C51
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 12:27:37 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.36149.1717244852521394385
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jun 2024 05:27:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=OABGK2UU;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.174, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70249c5fb36so1219802b3a.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717244852; x=1717849652; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUYcg6Sv5Gn3fQQaDwdpurPht4QtDDI+R+iPtcbdmaw=;
        b=OABGK2UUt94EV2gwOOn8fQHvC0LS6cd/7oPwJFfTQtckCvjUV/TzaoL/x1c+7o3BdN
         bVzX+yM6hwbZ6qU3qspq3u8ozDRG2DvvvulT2qdu+FFzAnD4cyqtOunDuxDk4X0OzJKh
         I1mPYriIgNNKJVfXvIaD7fN1boqp3XYJjVu/J+PfmrNt6l6GxMbduhD55yc3BushBeFt
         qBtNgm0CXeSBuxnbLHuerKnklzInh3OLvoeSZKK0wPR/RZBnphzqnuXKmPqG4OcyUwZ6
         ZuRVBl2ld6d97GGyrtZtCfPwiMapANbmCp0DtcIHgdA6/1+JC9C/MpgTLBOuHiLMRopX
         y8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717244852; x=1717849652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUYcg6Sv5Gn3fQQaDwdpurPht4QtDDI+R+iPtcbdmaw=;
        b=ICMnRLRyXVG04QVg3dp+lK52bJmh/L9+PgaO7fFDQDZnC9fVvwjeMIlyApn4d27uIT
         Evm+uXsIyoPBOPKrzvAeyN8LTNqhraZWe7G6BvwxW9h4arsmKqoK0tpydNIo6by/XNlT
         KxEIGgDV5zl03184sFWZGzNfPzju9e+KlLJvNKfht3yrLNQ4MXHbtjyy+/yYCwMEm1h8
         2C649UWYuam3tBw9y0Z95OJRBfbJalcUrQrHqLVrIptU73iH5w1vsfpgz8VIIyIA8i7u
         k9HHhtKFbi1GmLLOl51ZvihdGnP/dkvm5KtRGaBrVmhn+RsY71dxlJ7ghm9NFVt0GIP0
         KIQQ==
X-Gm-Message-State: AOJu0YwF1nCq9gUNfQBKnlY9iifyumXSJHQX5Ui/uAcforv7TNeyndU8
	7/p9Rr2hpfUD4t+XJ5XLx7JxpT+xrg4grG8R0mpRDRWKKo/allgYgswKg5Ly2thJ8/pBBEmtNb3
	o
X-Google-Smtp-Source: AGHT+IFdMn3jlPWBoScjxVORiS7PqHLUT1aXuCAxCP/SmOo+GTG9NGllZWoTs1EucG7OK+Me+Y4wjA==
X-Received: by 2002:a05:6a20:320d:b0:1b1:f7a1:df91 with SMTP id adf61e73a8af0-1b26f296e46mr4027853637.61.1717244851659;
        Sat, 01 Jun 2024 05:27:31 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b30013sm2809362b3a.211.2024.06.01.05.27.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:27:31 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/8] runqueue: Add timing warnings around slow loops
Date: Sat,  1 Jun 2024 05:27:16 -0700
Message-Id: <de8a0348ba6c63536263d17f15935e61db78271b.1717244760.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717244760.git.steve@sakoman.com>
References: <cover.1717244760.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 12:27:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16305

From: Richard Purdie <richard.purdie@linuxfoundation.org>

With hashserve enabled, there are two slow paths/loops, one at initial runqueue
generation and also during the rehash process when new outhashes are found.

Add timing information at the hashserve log level for when these loops
take longer than 30s or 60s overall. This will leave evidence in the logs when
things are running particularly slowly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index bc7e18175..beec1e046 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1273,6 +1273,9 @@ class RunQueueData:
 
         bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids)
 
+        starttime = time.time()
+        lasttime = starttime
+
         # Iterate over the task list and call into the siggen code
         dealtwith = set()
         todeal = set(self.runtaskentries)
@@ -1284,6 +1287,14 @@ class RunQueueData:
                     self.prepare_task_hash(tid)
                 bb.event.check_for_interrupts(self.cooker.data)
 
+            if time.time() > (lasttime + 30):
+                lasttime = time.time()
+                hashequiv_logger.verbose("Initial setup loop progress: %s of %s in %s" % (len(todeal), len(self.runtaskentries), lasttime - starttime))
+
+        endtime = time.time()
+        if (endtime-starttime > 60):
+            hashequiv_logger.verbose("Initial setup loop took: %s" % (endtime-starttime))
+
         bb.parse.siggen.writeout_file_checksum_cache()
 
         #self.dump_data()
@@ -2556,6 +2567,9 @@ class RunQueueExecute:
             elif self.rqdata.runtaskentries[p].depends.isdisjoint(total):
                 next.add(p)
 
+        starttime = time.time()
+        lasttime = starttime
+
         # When an item doesn't have dependencies in total, we can process it. Drop items from total when handled
         while next:
             current = next.copy()
@@ -2588,6 +2602,14 @@ class RunQueueExecute:
                 total.remove(tid)
                 next.intersection_update(total)
 
+                if time.time() > (lasttime + 30):
+                    lasttime = time.time()
+                    hashequiv_logger.verbose("Rehash loop slow progress: %s in %s" % (len(total), lasttime - starttime))
+
+        endtime = time.time()
+        if (endtime-starttime > 60):
+            hashequiv_logger.verbose("Rehash loop took more than 60s: %s" % (endtime-starttime))
+
         if changed:
             for mc in self.rq.worker:
                 RunQueue.send_pickled_data(self.rq.worker[mc].process, bb.parse.siggen.get_taskhashes(), "newtaskhashes")
-- 
2.34.1


