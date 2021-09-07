Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web08.2678.1631047817375814727
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 13:50:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CNNW1MEy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so2812467wmn.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Sep 2021 13:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYf5+a0N8RZWeRK/+brUPUmUA0wukulwJy2Xbsm+jD4=;
        b=CNNW1MEyi1UV59ipx2PKL60mD+EHpJhGc+v7rdb2tvK+pyEDj+JF7Ggv48+TiW0kob
         rC0GhIlzCtCRF72mvnjhvOUBqHi4lhOwekyfxt2X6eRGeUhYt5Sgzle3lIpj9ffSldyz
         6lh5thx8X2ETeIDbb95Y2CAD/kAAI03mNVdK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYf5+a0N8RZWeRK/+brUPUmUA0wukulwJy2Xbsm+jD4=;
        b=pApg6GTBbUFA/qdfWnyrD2gFdqwZbyir8itzb1Oqt+p7rRQvfSQRoTxRU1S7Li0MRz
         X6OeijyAYUkU+ddoAQs9saZP+rBw7a1E6GlLsN79UtOJzZJH076Aeh6sUuci1nnR+03I
         Q05wiTBV+8ax7vGyaWvfeJWV8BBGaWYJaQ++rzkd/x49q3RRikZUSkH+P4VPjEQbWHE6
         Uz/g8i1tlWpDK6KZmJDW3cH1U8KOGtHGmkHS5FZD5cdYWw97vXVALRw0c+HRuRuBt3h9
         vhjWSzAxH+xLoinRnL/oiBL6pUDh2CC3ladQ+cYLLS020fgFgiglIQ0QWlMPNudY/00v
         FUhA==
X-Gm-Message-State: AOAM53016CxVjwLfF7m/Cz74I/2Xbw5wrkGaj7ulSIy6TqfOa9TYyH9i
	V72RSwtdbxOj9YHsjD7T5gCjMaS4k0CnKCwA
X-Google-Smtp-Source: ABdhPJzuVyD4Qfz2cLMZJv4CVZTv4KDOdChICTfAwFAQJdxiyuk73A3lZOI3/qcIyRmMTrJidbNDJw==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr179710wmb.5.1631047815546;
        Tue, 07 Sep 2021 13:50:15 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:2cf4:2068:e5af:caee])
        by smtp.gmail.com with ESMTPSA id m8sm86469wms.32.2021.09.07.13.50.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 13:50:15 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] runqueue: Fix issues with multiconfig deferred task deadlock messages
Date: Tue,  7 Sep 2021 21:50:14 +0100
Message-Id: <20210907205014.1154204-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In multiconfig builds with large numbers of identical tasks, builds were
deadlocking after recent runqueue changes upon rebuilds where there was
heavy sstate usage (i.e. on second builds after a first completed).

The issue was that deferred tasks were being left indefinitely on
the deferred list. The deadlock handler was then "breaking" things
by failing tasks that had already succeeded, leading to the task
being on both covered and not covered lists, giving a further error.

The fix is to clean up the deferred task list when each setscene task
completes. I'd previously been hoping to avoid iterating that list
but it appears unavoidable.

[YOCTO #14342]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f5f25c5b7d..5ccf755f1a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1904,6 +1904,12 @@ class RunQueueExecute:
                 self.setbuildable(revdep)
                 logger.debug("Marking task %s as buildable", revdep)
 
+        for t in self.sq_deferred.copy():
+            if self.sq_deferred[t] == task:
+                logger.debug2("Deferred task %s now buildable" % t)
+                del self.sq_deferred[t]
+                update_scenequeue_data([t], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+
     def task_complete(self, task):
         self.stats.taskCompleted()
         bb.event.fire(runQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
-- 
2.32.0

