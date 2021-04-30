Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web09.11360.1619788130391692534
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Apr 2021 06:08:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=boXytBYo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id x7so70476822wrw.10
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Apr 2021 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFk9Xet2NbVznMoEJkV9gFgcEfGGiAysZurT3ZYP1kY=;
        b=boXytBYoAQlIzmlyofHpTB/7myfXTuU2ts7j4epxXLG/esiMgTPVVOFZrrN/IZIfhG
         aPssq9U6BeP5XdhfGgtNRQzLy21liQe1/ZSeaGUpzNUUJuThrqk+eRDEPrtCeHeZg72c
         +yFGM28IRYS7/Njr4bVrukH1CTSCeEvMKgZ1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFk9Xet2NbVznMoEJkV9gFgcEfGGiAysZurT3ZYP1kY=;
        b=kk7v+JTGfv76Y8MLBGmGLgphc38bbA7Yeo5/B73BeVasNCAqMRypipDsdTXEy8b2cM
         dOVtRrgu2JQwJxMUV0xhJr6QDUzPve6m1P4VYXsM49pMAS33sC+8kNP4W7mhFuxlwpCb
         Nm+NxNEjhlV6xTEjJcdDxB5HjWZTSLdz4KTMqoC+EvFDItHUAWm02iDLn5WnVy9APYeQ
         XtPDZUwggvf8UEkcqlM5Ypa/Odm+XhSCc+NxtQUs/eXNhTkY6ssSaVs6TQFUHl+UyV8T
         w16cweURuzFYFEopL+4j1nBnL8hwJ/dHDbFBTZHhPlabiNi7k5QleM3FNhuoncR1rtRv
         QmGQ==
X-Gm-Message-State: AOAM530vmg5suzOSfmZJdFk1E5o/ltXiZWyZ4LN6qJCe6/PWZuNqSSZ9
	srscoxHWODxWRqEb8VvNQJOXfIBDvJKgcg==
X-Google-Smtp-Source: ABdhPJyBVbx68SEXM+wbxov/ofBv8/8QLpxIezmcUtIkl6wcqVFCDVSv2Z8F5heoTtcUAUhB+GVn1g==
X-Received: by 2002:adf:f508:: with SMTP id q8mr6885413wro.109.1619788128870;
        Fri, 30 Apr 2021 06:08:48 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:38ed:4baa:ed1c:e489])
        by smtp.gmail.com with ESMTPSA id r13sm2418740wrn.2.2021.04.30.06.08.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 06:08:48 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] runqueue: Fix multiconfig deferred task sstate validity caching issue
Date: Fri, 30 Apr 2021 14:08:47 +0100
Message-Id: <20210430130848.1801762-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 lib/bb/runqueue.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index feb42d3e6b..78e576eb2c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2030,8 +2030,6 @@ class RunQueueExecute:
                             logger.debug("%s didn't become valid, skipping setscene" % nexttask)
                             self.sq_task_failoutright(nexttask)
                             return True
-                        else:
-                            self.sqdata.outrightfail.remove(nexttask)
                     if nexttask in self.sqdata.outrightfail:
                         logger.debug2('No package found, so skipping setscene task %s', nexttask)
                         self.sq_task_failoutright(nexttask)
@@ -2827,6 +2825,8 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
             sqdata.stamppresent.remove(tid)
         if tid in sqdata.valid:
             sqdata.valid.remove(tid)
+        if tid in sqdata.outrightfail:
+            sqdata.outrightfail.remove(tid)
 
         noexec, stamppresent = check_setscene_stamps(tid, rqdata, rq, stampcache, noexecstamp=True)
 
@@ -2861,10 +2861,10 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
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
2.30.2

