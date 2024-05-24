Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C4C41513
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:12:12 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.18334.1716563524178123412
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 08:12:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=M/O+y+HW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354f14bd80cso2054409f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716563522; x=1717168322; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOBHB9UFcpKgyYj46gSdBED+TC6aAiFH7W+dZlvXhz8=;
        b=M/O+y+HWzq9j2r2wPQfxHPAw2Y3RqqrVEQQVEaRbNgy55l8KL1egKdvRFm03GIJGTZ
         w7dGk+s0Wsetrpq+hvadtxmP4Q/30SjVv5FGF/aHCrByxuB9Zqwlxi1cQ2/OgyH1awbl
         RvQDzqOQdgG4hYuAgdsBw1AKaqccvrZDZqvIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563522; x=1717168322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOBHB9UFcpKgyYj46gSdBED+TC6aAiFH7W+dZlvXhz8=;
        b=lG41ZAy/H1gAGMON/gRyAd5tMDaZmSIAMcj7qBiQJRH1Bz23f+kRniEYpsQjHnbG+a
         3ojO1NmtAUxgXHE+vmS7UNp7rtXXj9KtUgJnzc8I2erdkUUqZowl8xTUMAEte8HBghrP
         vVu8Nr/pUi/XS7T2ywimW+JOdZ1Ohb4sIGYgLhYfocuXz4RkKYD/EMOHRWE4QNr3hAaR
         jNcQ4HNTw9nx2c4mN1RzkorXnZ2bVk55k83z9WiNKOzgC+Tyo0fejuaRRAr0FxEnbiy0
         lRfxFa0cSjmbc3dy1WrlieMG/o4gBkZp4o6+R3H61FEoxSkIGOoMT96RmXDmam9jB+w8
         RiFQ==
X-Gm-Message-State: AOJu0YzXkxXHiTT7TmIg49MviOuj/8c3KXOCn60ZICvUR73lxpJoUwhp
	xhBl9dxzHO2z8iv+szWHzY73iRLZYnUQVMmhMnVxUMS/+KTAxTvr0eFpbHEgowkIWPHuyb/wOM1
	R
X-Google-Smtp-Source: AGHT+IHQQFMcV2yk6shQ/byKUkdQHpA5FWXZcvZbR6uQCd5fUivuVJOcdpQLyrWlrfmliSK4eCtq0w==
X-Received: by 2002:a05:6000:12cf:b0:355:1e8:4513 with SMTP id ffacd0b85a97d-3552fdfa8ccmr1552624f8f.53.1716563522416;
        Fri, 24 May 2024 08:12:02 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9ca4:3686:8521:57da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db23sm1841759f8f.23.2024.05.24.08.12.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:12:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/6] runqueue: Add timing warnings around slow loops
Date: Fri, 24 May 2024 16:11:56 +0100
Message-Id: <20240524151200.2449512-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
References: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:12:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16256

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
index 6c2034176e..b0375fcb36 100644
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
@@ -2557,6 +2568,9 @@ class RunQueueExecute:
             elif self.rqdata.runtaskentries[p].depends.isdisjoint(total):
                 next.add(p)
 
+        starttime = time.time()
+        lasttime = starttime
+
         # When an item doesn't have dependencies in total, we can process it. Drop items from total when handled
         while next:
             current = next.copy()
@@ -2589,6 +2603,14 @@ class RunQueueExecute:
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
2.40.1


