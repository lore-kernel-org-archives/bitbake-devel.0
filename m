Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4884360722
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jul 2016 08:55:17 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 15 Jul 2016 01:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,367,1464678000"; d="scan'208";a="995777821"
Received: from apbalanx-mobl.ccr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.177.79])
	by orsmga001.jf.intel.com with ESMTP; 15 Jul 2016 01:55:06 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jul 2016 20:54:30 +1200
Message-Id: <6a92138e0bd9674023389cffebf29a33a49211b2.1468572805.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1468572805.git.paul.eggleton@linux.intel.com>
References: <cover.1468572805.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1468572805.git.paul.eggleton@linux.intel.com>
References: <cover.1468572805.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] knotty: avoid errors when fetching outside of a task
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
X-List-Received-Date: Fri, 15 Jul 2016 08:55:17 -0000

In a few places we use the fetcher code to fetch files outside of a
task, for example uninative in OE. In that case the pid of the event is
0 and that was causing an error in BBUIHelper.eventHandler(). Check the
pid and do nothing if it's 0.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/uihelper.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 1915e47..f64fa18 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -54,9 +54,10 @@ class BBUIHelper:
             self.tasknumber_total = event.stats.total
             self.needUpdate = True
         if isinstance(event, bb.build.TaskProgress):
-            self.running_tasks[event.pid]['progress'] = event.progress
-            self.running_tasks[event.pid]['rate'] = event.rate
-            self.needUpdate = True
+            if event.pid > 0:
+                self.running_tasks[event.pid]['progress'] = event.progress
+                self.running_tasks[event.pid]['rate'] = event.rate
+                self.needUpdate = True
 
     def getTasks(self):
         self.needUpdate = False
-- 
2.5.5


