Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SX0l4-0000qc-NT
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 03:53:03 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4N1grX0022303
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 May 2012 18:42:53 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Tue, 22 May 2012 18:42:52 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 22 May 2012 20:46:32 -0500
Message-ID: <1337737597-5964-3-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1337714416.git.mark.hatle@windriver.com>
References: <cover.1337714416.git.mark.hatle@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 3/3] build.py: Add support for log and run filename changes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 23 May 2012 01:53:03 -0000
Content-Type: text/plain

The format of the log file and run file are now selectable
using BB_LOGFMT and BB_RUNFMT, respectively.

The following values may be used:

{task} - task name
{taskfunc} - task.func or func, if task==func
{func} - function name, only available in BB_RUNFMT
{pid} - pid

The log/run files may be placed into a subdirectory that
is relative to T.

Default BB_LOGFMT is: log.{task}.{pid}
Default BB_RUNFMT is: run.{func}.{pid}

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/build.py |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 2fbe120..e867894 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -174,8 +174,19 @@ def exec_func(func, d, dirs = None):
         lockfiles = None
 
     tempdir = data.getVar('T', d, 1)
-    bb.utils.mkdirhier(tempdir)
-    runfile = os.path.join(tempdir, 'run.{0}.{1}'.format(func, os.getpid()))
+
+    # or func allows items to be executed outside of the normal
+    # task set, such as buildhistory
+    task = data.getVar('BB_RUNTASK', d, 1) or func
+    if task == func:
+        taskfunc = task
+    else:
+        taskfunc = "%s.%s" % (task, func)
+
+    runfmt = data.getVar('BB_RUNFMT', d, 1) or "run.{func}.{pid}"
+    runfn = runfmt.format(taskfunc=taskfunc, task=task, func=func, pid=os.getpid())
+    runfile = os.path.join(tempdir, runfn)
+    bb.utils.mkdirhier(os.path.dirname(runfile))
 
     with bb.utils.fileslocked(lockfiles):
         if ispython:
@@ -302,7 +313,8 @@ def _exec_task(fn, task, d, quieterr):
     bb.utils.mkdirhier(tempdir)
 
     # Determine the logfile to generate
-    logbase = 'log.{0}.{1}'.format(task, os.getpid())
+    logfmt = localdata.getVar('BB_LOGFMT', True) or 'log.{task}.{pid}'
+    logbase = logfmt.format(task=task, pid=os.getpid())
 
     # Document the order of the tasks...
     logorder = os.path.join(tempdir, 'log.task_order')
@@ -338,6 +350,7 @@ def _exec_task(fn, task, d, quieterr):
     # Handle logfiles
     si = file('/dev/null', 'r')
     try:
+        bb.utils.mkdirhier(os.path.dirname(logfn))
         logfile = file(logfn, 'w')
     except OSError:
         logger.exception("Opening log file '%s'", logfn)
@@ -364,6 +377,7 @@ def _exec_task(fn, task, d, quieterr):
     bblogger.addHandler(errchk)
 
     localdata.setVar('BB_LOGFILE', logfn)
+    localdata.setVar('BB_RUNTASK', task)
 
     event.fire(TaskStarted(task, localdata), localdata)
     try:
-- 
1.7.3.4



