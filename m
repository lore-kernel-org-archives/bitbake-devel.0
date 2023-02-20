Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9760C677F1
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 22:25:42 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.28208.1676931939379517781
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 14:25:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=GBrXH6BL;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.172, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f172.google.com with SMTP id a26so1375014pfo.9
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 14:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GLRgrgwcku4N1eh9Zl9lZLRl/6qnueRenx8JfDME5U=;
        b=GBrXH6BLsk9efUEFtv+DFjtxdaBzwEBmZ/qUz2E2M+92mYvLa6S5GoiHI/j8hCeHmd
         WpwtuWrWdbm5T3Bu+A73DP272UrMqrxY53kxgERuV2Fg9bjchQL8Wsw5EfiHcv53Eeld
         TuYTp4FgkmV1G/Au1bGFcI7mW8uU+LUnctHjs0UJqsjDHZca2R/eR811bznEzzHSqh+4
         upBb52Ukz20QVOlHwp0ZkcHZwgyjg7WECILqgIGmYAkDH6G8yMkmgZXTPyFw3ZB1uQdx
         JS4neQDRDvo/4UeKaCphUg6CD+YdZQg4PoROhRHdRai8D4OmMsxoTUQf5nyVLTNhTqmX
         hcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GLRgrgwcku4N1eh9Zl9lZLRl/6qnueRenx8JfDME5U=;
        b=7B2zg6P8V7W0RdztA10U2kPe4lSJR+6XA1OBodcGJGGmoWguWx86YiBH32H9PweMki
         ACMDWBv0Ox16SXY1TuaGesT2CIyLHnWHsNasomm26UX+xGywuhKdrkjB3fz67bnq6MMa
         LRHGWJpQSARDBMcOHFqAn8DD+HPSjSMe+SrxDqfLAQryFoV9ZSbyiyyOui8GERImOUb2
         1w9Ass2EqBs43CRNbemIUGRuTAmH6m4ZYeEqDCoVMUjMQ7D9Z2Ip84ncBC4sy/DxyoKe
         bUWmi46gXZL9dDJ0B3TYgdt5gE3S8tWia58hSUcwz6avrU5QKjCe/DxRlixvmu1c6q5g
         sfyw==
X-Gm-Message-State: AO0yUKXb2LZJsqlnz7yOxPimA40++UUlkQD9ZH++P/Lg/hHkpapc8CnR
	QTYLfLPrLVwU8qzIP05V212bBzMfULUc4Dh4ZPg=
X-Google-Smtp-Source: AK7set/qnEPe34aYgQzOzUhUZBZR9K4zsMFkWCIZHuyumkkwlqYKe9VgpeVMwVKcEYm5Adk9Z1DuWg==
X-Received: by 2002:a62:19c5:0:b0:592:705a:5a5e with SMTP id 188-20020a6219c5000000b00592705a5a5emr3076313pfz.9.1676931938435;
        Mon, 20 Feb 2023 14:25:38 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b005a9131b6668sm8191447pff.2.2023.02.20.14.25.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:25:38 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/7] runqueue: Handle deferred task rehashing in multiconfig builds
Date: Mon, 20 Feb 2023 12:25:18 -1000
Message-Id: <01936b4dd8e680f1f8035ff2d6231673f61efeab.1676931822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676931822.git.steve@sakoman.com>
References: <cover.1676931822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 22:25:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14469

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the hash of a task changes and that hash is a deferred task (e.g. a multiconfig
build), we need to ensure that the hash change propagates through to all the tasks
else the build will run multiple copies of the task, sometimes with oddly differing
results as the outhashes of native tasks built in differing locations can confuse
things.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2db571324f755edc4981deecbcfdf0aaa5a97627)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f82bc413..a437aeef 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2348,10 +2348,16 @@ class RunQueueExecute:
             self.updated_taskhash_queue.remove((tid, unihash))
 
             if unihash != self.rqdata.runtaskentries[tid].unihash:
-                hashequiv_logger.verbose("Task %s unihash changed to %s" % (tid, unihash))
-                self.rqdata.runtaskentries[tid].unihash = unihash
-                bb.parse.siggen.set_unihash(tid, unihash)
-                toprocess.add(tid)
+                # Make sure we rehash any other tasks with the same task hash that we're deferred against.
+                torehash = [tid]
+                for deftid in self.sq_deferred:
+                    if self.sq_deferred[deftid] == tid:
+                        torehash.append(deftid)
+                for hashtid in torehash:
+                    hashequiv_logger.verbose("Task %s unihash changed to %s" % (hashtid, unihash))
+                    self.rqdata.runtaskentries[hashtid].unihash = unihash
+                    bb.parse.siggen.set_unihash(hashtid, unihash)
+                    toprocess.add(hashtid)
 
         # Work out all tasks which depend upon these
         total = set()
-- 
2.34.1


