Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 923BA71999
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Feb 2017 20:08:55 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 06 Feb 2017 12:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,342,1477983600"; d="scan'208";a="222023476"
Received: from mmurr6x-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.252.199.82])
	by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2017 12:08:55 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Feb 2017 09:08:49 +1300
Message-Id: <c1d473f1c6a368e0109b962be9f472a1ba1e6bbb.1486411669.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486411669.git.paul.eggleton@linux.intel.com>
References: <cover.1486411669.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] lib/bb/build: add tasksbetween() function
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
X-List-Received-Date: Mon, 06 Feb 2017 20:08:55 -0000

Add a utility function that gives the list of dependent tasks between
two specified tasks (just within the same recipe). This is intended to
be able to be executed from recipe context so it uses the datastore
rather than having access to the runqueue.

This will be used in OpenEmbedded-Core's populate_sdk_ext.bbclass to
get the list of tasks between do_image_complete and do_build.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/build.py | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index c08ef89..0d0100a 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -878,3 +878,30 @@ def preceedtask(task, with_recrdeptasks, d):
         if recrdeptask:
             preceed.update(recrdeptask.split())
     return preceed
+
+def tasksbetween(task_start, task_end, d):
+    """
+    Return the list of tasks between two tasks in the current recipe,
+    where task_start is to start at and task_end is the task to end at
+    (and task_end has a dependency chain back to task_start).
+    """
+    outtasks = []
+    tasks = list(filter(lambda k: d.getVarFlag(k, "task"), d.keys()))
+    def follow_chain(task, endtask, chain=None):
+        if not chain:
+            chain = []
+        chain.append(task)
+        for othertask in tasks:
+            if othertask == task:
+                continue
+            if task == endtask:
+                for ctask in chain:
+                    if ctask not in outtasks:
+                        outtasks.append(ctask)
+            else:
+                deps = d.getVarFlag(othertask, 'deps', False)
+                if task in deps:
+                    follow_chain(othertask, endtask, chain)
+        chain.pop()
+    follow_chain(task_start, task_end)
+    return outtasks
-- 
2.9.3


