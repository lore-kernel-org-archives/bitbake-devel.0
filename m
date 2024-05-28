Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E250C41513
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 20:44:34 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.1928.1716929065426333887
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 May 2024 13:44:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cM7ENL4c;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4202ca70289so11139585e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716929063; x=1717533863; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=87X6tU6YjjWqVk4im2UM05esmJj8CzYGf5RQIk6U3mw=;
        b=cM7ENL4cYeYUTBbOmYAYbtmNb4v7pvHTD1nGgP+YLj0M2dzqmM61eW08WKgn2vrY8l
         a1iVnNmw7zOpiCCUGpQxgqFjUDyKj04mM9NjkU25ljVPU/OBo5d8Jo+/Gj0uW4mibmf4
         3CDR6XAItFIDGicxM/O4Scc892JnyQ80Q1jHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929063; x=1717533863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87X6tU6YjjWqVk4im2UM05esmJj8CzYGf5RQIk6U3mw=;
        b=HllQVUwyMJdY1zx5HxgAiT0IcR9SJK2CRnuVDkwv2yT3K2lEeiko+U0dOeLXqjL/56
         9FF0sd+3w0LZ6ODkJMKBmrg9D/Ve94ND3W5Wv3IItwgy2+l8u+W0KpKVGHtKbKT5R6iC
         aXRJDzcb+P2ug5Atw0YjXYLHT/09rscKgyYMqij6HeJkyjr5onXarShhHDkAN/qxYEaA
         DB3LcMj+n/LbbaiYhAbBfWRp29914w7uHdQc99dc2nVRuB7SYjTmFn1OxqP8aLr3Kles
         0A7oe811hXR7dbP/1ZkScNWHKjX/97ZUUnSvHfbRJl8YhO9LQ7Cqcl8kdpTp8eS4jblu
         xiSw==
X-Gm-Message-State: AOJu0YwHXgAldPJchPPM2iKaNhZ8vcIT3UdFJLXfRklSlerEmiwx37LR
	UeUYgEfT3n6TgxBpWEHefiP5MWUCBTv0C5dQ7CXeC063M7dtSO+pw8piNBsMuD8JcL4KOwsjW6e
	j
X-Google-Smtp-Source: AGHT+IHOxyPYCufuIBRmMeZ2tqeqpq2H5uE2vtQ52CDv3dOzaBGYcgKKqnfmueR94blvQh4V5LFJBQ==
X-Received: by 2002:a05:6000:400c:b0:356:4a73:af59 with SMTP id ffacd0b85a97d-3564a73b0a5mr10469023f8f.28.1716929062689;
        Tue, 28 May 2024 13:44:22 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b316:c62f:d434:bcd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f9649esm12635228f8f.29.2024.05.28.13.44.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:44:22 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] runqueue: Add timing warnings around slow loops
Date: Tue, 28 May 2024 21:44:17 +0100
Message-Id: <20240528204420.2845521-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 20:44:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16272

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
index 6b43f303d5..83e5273449 100644
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

