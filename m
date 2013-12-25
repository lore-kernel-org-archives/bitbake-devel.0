Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3EB7060DFC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Dec 2013 02:19:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rBP2JXAn013093
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 18:19:33 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 24 Dec 2013 18:19:32 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 24 Dec 2013 21:19:26 -0500
Message-ID: <55abf9fe8702c022324af649630bae0dd6070645.1387937195.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1387937195.git.liezhi.yang@windriver.com>
References: <cover.1387937195.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/4] bitbake: runqueue/bitbake-worker: Fix dry run fakeroot issues
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 25 Dec 2013 02:19:35 -0000
Content-Type: text/plain

From: Richard Purdie <richard.purdie@linuxfoundation.org>

When using the dry run option (-n), bitbake would still try and fire
a specific fakeroot worker. This is doomed to failure since it might
well not have been built.

Add in some checks to prevent the failures.

[YOCTO #5367]

(Bitbake master rev: f34d0606f87ce9dacadeb78bac35879b74f10559)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-worker |    3 ++-
 bitbake/lib/bb/runqueue.py |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 66b6aab..ff20c1c 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -97,7 +97,8 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, quieterror
         except TypeError:
              umask = taskdep['umask'][taskname]
 
-    if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
+    # We can't use the fakeroot environment in a dry run as it possibly hasn't been built
+    if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not cfg.dry_run:
         envvars = (workerdata["fakerootenv"][fn] or "").split()
         for key, value in (var.split('=') for var in envvars):
             envbackup[key] = os.environ.get(key)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 72c0208..a320a64 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1408,7 +1408,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 bb.event.fire(startevent, self.cfgData)
 
             taskdep = self.rqdata.dataCache.task_deps[fn]
-            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
+            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not self.rq.fakeworker:
                     self.rq.start_fakeworker(self)
                 self.rq.fakeworker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
-- 
1.7.10.4


