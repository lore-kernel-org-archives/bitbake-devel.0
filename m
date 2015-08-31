Return-Path: <alejandro.franco@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 22DA074197
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Aug 2015 20:00:03 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 31 Aug 2015 13:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,443,1437462000"; d="scan'208";a="794845036"
Received: from afshjern.zpn.intel.com ([10.219.128.45])
	by orsmga002.jf.intel.com with ESMTP; 31 Aug 2015 13:00:03 -0700
From: Alex Franco <alejandro.franco@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Aug 2015 15:00:32 -0500
Message-Id: <1441051232-30028-1-git-send-email-alejandro.franco@linux.intel.com>
X-Mailer: git-send-email 2.5.1
Cc: david.nystrom@enea.com, clarson@kergoth.com
Subject: [PATCH] Allow bitbake commands starting with do_ v2
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
X-List-Received-Date: Mon, 31 Aug 2015 20:00:07 -0000

The output of "bitbake, -c listtasks pkg" lists tasks with their real names
(starting with "do_"), but then "bitbake -c do_task" fails, as "do_" always
gets unconditionally prepended to task names. This patch handles this error
by always removing "do_" from the beginning of task names when the runqueue
is being constructed.

[YOCTO #7818]

Signed-off-by: Alex Franco <alejandro.franco@linux.intel.com>
---
 bitbake/lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0f99e5a..834992f 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -634,6 +634,10 @@ class RunQueueData:
 
             fnid = taskData.build_targets[targetid][0]
             fn = taskData.fn_index[fnid]
+
+            if target[1].startswith("do_"):
+                target[1] = target[1].replace("do_", "", 1)
+
             self.target_pairs.append((fn, target[1]))
 
             if fnid in taskData.failed_fnids:
-- 
2.5.1


