Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF13C433F5
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 14:16:11 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web12.32718.1635171369772633063
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 07:16:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209759062"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="209759062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:09 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="634754777"
Received: from syong7-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.249.78.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:08 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 5/9] bitbake-worker: Allow shutdown/database flush of
 pseudo server at task exit
Date: Mon, 25 Oct 2021 22:15:52 +0800
Message-Id: 
 <97eb053f972461f234c1c81af11596c7e1ac7c1c.1635171215.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635171215.git.anuj.mittal@intel.com>
References: <cover.1635171215.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 14:16:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12822

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We have a problem where pseudo server processes exist after bitbake exits
and hold the pseudo database in memory. In a docker container, the processes
will be killed as the container is destroyed with no warning and no opportunity
to write the data to disk. This leads to permissions/inode corruptions and
data loss.

Send a shutdown message to pseudo which in new versions of pseudo will flush
the database, thereby fixing some of the issues people using docker containers
see.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a07a971b40acd3eee12e203d2cfa3e49f56109f6)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 bin/bitbake-worker | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 3ca8c1853..b3877b15c 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -16,6 +16,8 @@ import signal
 import pickle
 import traceback
 import queue
+import shlex
+import subprocess
 from multiprocessing import Lock
 from threading import Thread
 
@@ -145,6 +147,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
     # a fork() or exec*() activates PSEUDO...
 
     envbackup = {}
+    fakeroot = False
     fakeenv = {}
     umask = None
 
@@ -164,6 +167,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
 
     # We can't use the fakeroot environment in a dry run as it possibly hasn't been built
     if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not dry_run:
+        fakeroot = True
         envvars = (workerdata["fakerootenv"][fn] or "").split()
         for key, value in (var.split('=') for var in envvars):
             envbackup[key] = os.environ.get(key)
@@ -282,7 +286,11 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
             try:
                 if dry_run:
                     return 0
-                return bb.build.exec_task(fn, taskname, the_data, cfg.profile)
+                ret = bb.build.exec_task(fn, taskname, the_data, cfg.profile)
+                if fakeroot:
+                    fakerootcmd = shlex.split(the_data.getVar("FAKEROOTCMD"))
+                    subprocess.run(fakerootcmd + ['-S'], check=True, stdout=subprocess.PIPE)
+                return ret
             except:
                 os._exit(1)
         if not profiling:
-- 
2.31.1


