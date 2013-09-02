Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 4F8B86BF67
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Sep 2013 17:26:48 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 02 Sep 2013 10:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,1008,1367996400"; d="scan'208";a="372334554"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.85])
	by orsmga001.jf.intel.com with ESMTP; 02 Sep 2013 10:26:30 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Sep 2013 18:26:28 +0100
Message-Id: <1378142788-17001-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] bitbake-worker: ensure BUILDNAME is available during execution
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
X-List-Received-Date: Mon, 02 Sep 2013 17:26:49 -0000

BUILDNAME is set from cooker by default, so since the worker split it
will not be set when executing functions. In OpenEmbedded this results
in /etc/version (which is populated from BUILDNAME) not having any
content. Pass this variable value through to the worker explicitly to
fix the issue.

Fixes [YOCTO #4818].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-worker | 1 +
 lib/bb/runqueue.py | 1 +
 2 files changed, 2 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index b438d98..2f21e7c 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -147,6 +147,7 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, quieterror
                 os.umask(umask)
 
             data.setVar("BB_WORKERCONTEXT", "1")
+            data.setVar("BUILDNAME", workerdata["buildname"])
             bb.parse.siggen.set_taskdata(workerdata["hashes"], workerdata["hash_deps"], workerdata["sigchecksums"])
             ret = 0
             try:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 0700a5b..8d36f28 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -852,6 +852,7 @@ class RunQueue:
             "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
             "logdefaultdomain" : bb.msg.loggerDefaultDomains,
             "prhost" : self.cooker.prhost,
+            "buildname" : self.cfgData.getVar("BUILDNAME", True),
         }
 
         worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooker.configuration) + "</cookerconfig>")
-- 
1.8.1.2


