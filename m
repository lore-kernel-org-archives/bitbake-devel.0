Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CE0C433EF
	for <webhook@archiver.kernel.org>; Sat, 25 Sep 2021 09:41:25 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.5173.1632562883970148606
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Sep 2021 02:41:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=a7QWntQQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id r23so9500473wra.6
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Sep 2021 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7IYoM2gs3A+UWAJcZ2Z8W0WpA2cCccY7dTJs2qman0=;
        b=a7QWntQQp5Nf94svD7oodk2GLQlgG7PAs9ulPA5e/PiN8Qg8H4T/B0YE6YAIuW9949
         pN806eKNt5CEHoWPtCHLIUOW6J9n1aogTW+/aLwdL4CpIKmGaA/Qsjko/9JLix9KJ5Xr
         cCJrgYa0csk++ibUozPQNTERZxxd1U1gkntHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e7IYoM2gs3A+UWAJcZ2Z8W0WpA2cCccY7dTJs2qman0=;
        b=4cThqTvNGdOSkQmNwx4vCwqY2yzsK2wwkXqAb4Bekk2miJ1AiRJq8MoMGoVR0Z7dI6
         YwU1UIXoYFGuS2BxWtawiPveoL9P/daxehtZNHREN2swmluuYa2DrLw1L3kRoDXOJ5gz
         x5juHQc0mqTwrKx1mc7y1mw9VRimBZGNX8OcU8kSTbWPcFfHc5hG5PPn+RW7ljVYJf3f
         Th1L5b/M0nwUrXVnhZh2q5njGsu6R3BQgYlXwS/XH3K0FqbOH723LOIjKyLkVtwBoVgC
         9GsDVCApLhAEDuVLp6qn9D/TULeChyQgLRD3R2SK/GcoGeLQy11xru2UTNWsHWYixsjh
         Pj5w==
X-Gm-Message-State: AOAM5324OGIDYyx598DhgcrR1+VKb9NBGd5+IF7cIJcyX28R0OEWkYIX
	gUO2d/jUl4XwBGCW1CgPdBjz3ZaQL1USFWRy
X-Google-Smtp-Source: 
 ABdhPJypAndrSDWxH8v5hiWROnNLEGnZRta2LBVBXLYRaawpQx9++xr+TK3+YwVnHmJF1Z5xs+0Pjg==
X-Received: by 2002:a05:600c:35c6:: with SMTP id
 r6mr6353497wmq.24.1632562882014;
        Sat, 25 Sep 2021 02:41:22 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:2185:dd9d:1e31:557d])
        by smtp.gmail.com with ESMTPSA id
 a77sm10786802wme.28.2021.09.25.02.41.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 02:41:21 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-worker: Allow shutdown/database flush of pseudo
 server at task exit
Date: Sat, 25 Sep 2021 10:41:21 +0100
Message-Id: <20210925094121.1780833-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Sep 2021 09:41:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12704

We have a problem where pseudo server processes exist ater bitbake exits
and hold the pseudo database in memory. In a docker container, the processes
wll be killed as the container is destroyed with no warning and no opportunity
to write the data to disk. This leads to permissions/inode corruptions and
data loss.

Send a shutdown message to pseudo which in new versions of pseudo will flush
the database, thereby fixing some of the issues people using docker containers
see.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 6ead2da6d1..24dadd997c 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -17,6 +17,8 @@ import signal
 import pickle
 import traceback
 import queue
+import shlex
+import subprocess
 from multiprocessing import Lock
 from threading import Thread
 
@@ -146,6 +148,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
     # a fork() or exec*() activates PSEUDO...
 
     envbackup = {}
+    fakeroot = False
     fakeenv = {}
     umask = None
 
@@ -165,6 +168,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
 
     # We can't use the fakeroot environment in a dry run as it possibly hasn't been built
     if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not dry_run:
+        fakeroot = True
         envvars = (workerdata["fakerootenv"][fn] or "").split()
         for key, value in (var.split('=') for var in envvars):
             envbackup[key] = os.environ.get(key)
@@ -283,7 +287,12 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
             try:
                 if dry_run:
                     return 0
-                return bb.build.exec_task(fn, taskname, the_data, cfg.profile)
+                ret = bb.build.exec_task(fn, taskname, the_data, cfg.profile)
+                if fakeroot:
+                    fakerootcmd = shlex.split(the_data.getVar("FAKEROOTCMD"))
+                    bb.warn("Shutting down pseudo")
+                    subprocess.run(fakerootcmd + ['-S'], capture_output=True, check=True)
+                return ret
             except:
                 os._exit(1)
         if not profiling:
-- 
2.32.0


