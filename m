Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA9C6379F
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 22:25:42 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.27824.1676931937536060404
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 14:25:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=4CJUN95D;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.170, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f170.google.com with SMTP id n5so1497511pfv.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fjzvVWeAMUnjKW+J6nRaSXjDYfvhjvJjztLM6Z2bgY=;
        b=4CJUN95Du1Wrm/MriZqxI08rgm7GUtAECxEBXGp532Hj4iCxg4M9iKTa8h59hWyF8G
         Vm5csYU+aBGjYksw8hHpdSShPr+zRyCWSG2KJkxBs1YukYJptpbQes3dtntL+zswoAvD
         jtfO3kR7pLHsIOHIOjhinOCn+/0n86J8+svLeJ6+z3YgfP97hSXBpPC3Ntv9vAocpYcy
         +Yt1MhZByOC9WEjZO1g5XbFrHd5IS93hCR5kEnYVHGDRt1WEZ1zpapyHabIUCsGuI0rW
         cL14gNPJDscUaMqykqK0OBw3wvPVZoXMgQHP4MTCuXtsFhSFZ3poWqoyS6lvm8R/4qgx
         AdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fjzvVWeAMUnjKW+J6nRaSXjDYfvhjvJjztLM6Z2bgY=;
        b=hdjv9FJTGoR+77NNs/2ivo9h9e7McQnARt36h+fm/hQgBJmolLxb4TbtXcXwLk9SsZ
         C3ga7gOfu77bcR14ClI44Eczkw4kZgwkj3SGrWasxQ8TxpD5b9SgjFnf4KyltZQkMep6
         DCDNcfoltQ/Ib/8z8xzNRmycD/YIAZ6NNIxTiCcLrFZ4/RS1ccnEm8wfcmPvx41KWtEe
         IkVodBBJnP+lQS2V+8oKQOq1Q+Q2ac5fKfzbtgwI9fy78PKIVX90WCjXx7Gj8nHkKsQJ
         iqgYe5nCF6GS3kaQice7paNleoRrPdXtQlFatQvelIMgEW64L+mzDlrINbNn/dP2JMA1
         ti2g==
X-Gm-Message-State: AO0yUKVKRjFsMI5NXaaZ+lZQDWEv3cf/YY36o6V6tSpeHQZNRhJTPogF
	ZRR3G6gc7ZLWPlKQF14AniqXH5uAiqXojHdOa3s=
X-Google-Smtp-Source: AK7set/tamQwT0zV/dZkYGFiKXfkCuZzKfTVGRShL7hS/2O3XZgw6uGQwX0x0L2EaTjUeZwjMg9IRA==
X-Received: by 2002:a62:1ad1:0:b0:5a9:c772:85ab with SMTP id a200-20020a621ad1000000b005a9c77285abmr3685401pfa.22.1676931936582;
        Mon, 20 Feb 2023 14:25:36 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b005a9131b6668sm8191447pff.2.2023.02.20.14.25.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:25:36 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/7] runqueue: Fix multiconfig deferred task sstate validity caching issue
Date: Mon, 20 Feb 2023 12:25:17 -1000
Message-Id: <f95ed69e6c91ca6aa18d6fa9a6ac6319035c4661.1676931822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676931822.git.steve@sakoman.com>
References: <cover.1676931822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 22:25:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14468

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We were testing the validity of deferred tasks setscene status "up front" which
is very unlikely to succeed and leads to cache invalidation issues. With the
change to rebuild the deferred task list, this status becomes out of sync. The
result was tasks being executed when they should not have been leading to extra
work for the build unnecessarily.

Instead, don't process validity status for deferred tasks and assume their
data will become available. If it doesn't, this will now result in a build
error as the setscene task will fail and the main task will run instead.

In theory we could try and track the state changes in the deferred list and
re-test validity then but I'm not sure it is worth the effort when the other
code path and errors in setscene tasks will give a pretty good idea of what
is happening anyway.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit edcafac13b3b241b6687419e59018d21811507a1)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6cdc72a8..f82bc413 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2084,8 +2084,6 @@ class RunQueueExecute:
                             logger.debug(1, "%s didn't become valid, skipping setscene" % nexttask)
                             self.sq_task_failoutright(nexttask)
                             return True
-                        else:
-                            self.sqdata.outrightfail.remove(nexttask)
                     if nexttask in self.sqdata.outrightfail:
                         logger.debug(2, 'No package found, so skipping setscene task %s', nexttask)
                         self.sq_task_failoutright(nexttask)
@@ -2843,6 +2841,8 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
             sqdata.stamppresent.remove(tid)
         if tid in sqdata.valid:
             sqdata.valid.remove(tid)
+        if tid in sqdata.outrightfail:
+            sqdata.outrightfail.remove(tid)
 
         (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
 
@@ -2887,10 +2887,10 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
             if tid in sqrq.scenequeue_covered:
                 continue
 
-            sqdata.outrightfail.add(tid)
-
             h = pending_hash_index(tid, rqdata)
             if h not in sqdata.hashes:
+                if tid in tids:
+                    sqdata.outrightfail.add(tid)
                 sqdata.hashes[h] = tid
             else:
                 sqrq.sq_deferred[tid] = sqdata.hashes[h]
-- 
2.34.1


