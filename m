Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB30CC433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Jan 2022 22:25:49 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.15348.1641939948577362424
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Jan 2022 14:25:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g1D5dUXT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id h10so884934wrb.1
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Jan 2022 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ylzChfXISkR6j4LSU0R9XZt5Inkc1dQomsMUy+TY9OQ=;
        b=g1D5dUXT1vQXpP7Kc3qFwLz1EXvXvL0raxF2LvugH3iAk5aLTwsQ6tZmhVEpOyMGwb
         zsR8j93Gbf2C+QiWRlqSdji9EJO6mwwBboAgU4Q/p13K8LPRjv5arVCxt9kODtamje/4
         Qf9KEM105OT9tEdsWTbXsikPNFTcYMvJ+gbYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ylzChfXISkR6j4LSU0R9XZt5Inkc1dQomsMUy+TY9OQ=;
        b=6ddsOLMy1r4uq90SglYZUJ5x/xw0Np/CQLyNGvLjNT5OegTA59gDnTlpoR0pzcF0eX
         xdB+5Ad4xdroVx6MhJKxvqC4b8vNg3vY4Ja3ViCnBWkIXsOxcz5A0GSDBuQaK3ibD+Zi
         JlDzqz9R41xE6MxgLtY89HHDRLjKaGkHC0N0s6jz9AxDzDNwKHactqkuz+27FKzc6Ywf
         FPhiEt5a5awep2r//fzvBCjioY4qMlZlS8FfkWoH+rqe2yf0sZFnh5q3wgX/lyAx924k
         g0Bvhh5v8cPkJKSa9GELOLsEeSxJh06s9rmXpLe5/JQA5ipCBKvwNDrkt3/GCGxTPDWO
         0hzA==
X-Gm-Message-State: AOAM532HDqTHiNtuGQDnq6k9XRWSio0wZp48hmu3cUTbfGWcamABtf30
	2cglR6K3r1XOG7IYQmGDZzxgx3WKZaiS1g==
X-Google-Smtp-Source: 
 ABdhPJxQIy+i23Zh1hDJBeF0NwNgXegW3GA2386IGwS0DJz2my0vBV5QcSph82M/Br9dwgxs/5pIQw==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr3947852wro.581.1641939946822;
        Tue, 11 Jan 2022 14:25:46 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:60d:9770:8e9b:817])
        by smtp.gmail.com with ESMTPSA id
 bi24sm2951160wmb.9.2022.01.11.14.25.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:25:46 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Drop BB_STAMP_POLICY/BB_STAMP_WHITELIST
Date: Tue, 11 Jan 2022 22:25:45 +0000
Message-Id: <20220111222545.1653406-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Jan 2022 22:25:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13228

The different stamp policies were poor versions of the siggen code and task
hashes, predating it and being used by packaged staging. They had many
limitations, hence their replacement. I'm not aware of any users of that
code any more so I believe it and the assoicated stamp whitelist variable
can simply be removed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 957c2d1806..8ae3fe85f1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -385,7 +385,6 @@ class RunQueueData:
         self.rq = rq
         self.warn_multi_bb = False
 
-        self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST") or ""
         self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST") or "").split()
         self.setscenewhitelist = get_setscene_enforce_whitelist(cfgData, targets)
         self.setscenewhitelist_checked = False
@@ -1128,17 +1127,6 @@ class RunQueueData:
                     logger.error("".join(msgs))
 
         self.init_progress_reporter.next_stage()
-
-        # Create a whitelist usable by the stamp checks
-        self.stampfnwhitelist = {}
-        for mc in self.taskData:
-            self.stampfnwhitelist[mc] = []
-            for entry in self.stampwhitelist.split():
-                if entry not in self.taskData[mc].build_targets:
-                    continue
-                fn = self.taskData.build_targets[entry][0]
-                self.stampfnwhitelist[mc].append(fn)
-
         self.init_progress_reporter.next_stage()
 
         # Iterate over the task list looking for tasks with a 'setscene' function
@@ -1227,7 +1215,6 @@ class RunQueue:
         self.cfgData = cfgData
         self.rqdata = RunQueueData(self, cooker, cfgData, dataCaches, taskData, targets)
 
-        self.stamppolicy = cfgData.getVar("BB_STAMP_POLICY") or "perfile"
         self.hashvalidate = cfgData.getVar("BB_HASHCHECK_FUNCTION") or None
         self.depvalidate = cfgData.getVar("BB_SETSCENE_DEPVALID") or None
 
@@ -1356,14 +1343,6 @@ class RunQueue:
         if taskname is None:
             taskname = tn
 
-        if self.stamppolicy == "perfile":
-            fulldeptree = False
-        else:
-            fulldeptree = True
-            stampwhitelist = []
-            if self.stamppolicy == "whitelist":
-                stampwhitelist = self.rqdata.stampfnwhitelist[mc]
-
         stampfile = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn)
 
         # If the stamp is missing, it's not current
@@ -1395,7 +1374,7 @@ class RunQueue:
                     continue
                 if t3 and t3 > t2:
                     continue
-                if fn == fn2 or (fulldeptree and fn2 not in stampwhitelist):
+                if fn == fn2:
                     if not t2:
                         logger.debug2('Stampfile %s does not exist', stampfile2)
                         iscurrent = False
-- 
2.32.0


