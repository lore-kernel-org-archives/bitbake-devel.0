Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 12E6E6B551
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Aug 2013 14:18:44 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 13 Aug 2013 07:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,869,1367996400"; d="scan'208";a="281373215"
Received: from timevans-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.122.187])
	by AZSMGA002.ch.intel.com with ESMTP; 13 Aug 2013 07:18:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Aug 2013 15:18:38 +0100
Message-Id: <3da24015e63e0ed7223d668790027ede24a5c02e.1376403450.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1376403450.git.paul.eggleton@linux.intel.com>
References: <cover.1376403450.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1376403450.git.paul.eggleton@linux.intel.com>
References: <cover.1376403450.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] runqueue: report close matches for an invalid task name
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
X-List-Received-Date: Tue, 13 Aug 2013 14:18:45 -0000

Help to pick up mistakes such as "bitbake -c cleanstate xyz" (instead
of "bitbake -c cleansstate xyz".)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/runqueue.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index b2c9703..b3374f1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -601,7 +601,11 @@ class RunQueueData:
                 continue
 
             if target[1] not in taskData.tasks_lookup[fnid]:
-                bb.msg.fatal("RunQueue", "Task %s does not exist for target %s" % (target[1], target[0]))
+                import difflib
+                close_matches = difflib.get_close_matches(target[1], taskData.tasks_lookup[fnid], cutoff=0.7)
+                if close_matches:
+                    extra = ". Close matches:\n  %s" % "\n  ".join(close_matches)
+                bb.msg.fatal("RunQueue", "Task %s does not exist for target %s%s" % (target[1], target[0], extra))
 
             listid = taskData.tasks_lookup[fnid][target[1]]
 
-- 
1.8.1.2


