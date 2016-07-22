Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 2B92A6067D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 12:19:11 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 22 Jul 2016 05:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,404,1464678000"; d="scan'208";a="1000482215"
Received: from lwong9-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.13])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2016 05:19:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Jul 2016 00:18:39 +1200
Message-Id: <44b3abaa4faae523625ba8602342eeafaaeb005a.1469189882.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1469189882.git.paul.eggleton@linux.intel.com>
References: <cover.1469189882.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1469189882.git.paul.eggleton@linux.intel.com>
References: <cover.1469189882.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] lib/bb/progress: avoid possibility of start event being reported twice
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
X-List-Received-Date: Fri, 22 Jul 2016 12:19:11 -0000

In MultiStageProgressReporter, set a guard when we start the progress
so that it can't happen more than once. This fixes "Initialising
tasks.." being shown twice in succession when running bitbake in
non-interactive terminal mode.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/progress.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 343b18f..f54d1c7 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -234,10 +234,13 @@ class MultiStageProcessProgressReporter(MultiStageProgressReporter):
     """
     def __init__(self, d, processname, stage_weights, debug=False):
         self._processname = processname
+        self._started = False
         MultiStageProgressReporter.__init__(self, d, stage_weights, debug)
 
     def start(self):
-        bb.event.fire(bb.event.ProcessStarted(self._processname, 100), self._data)
+        if not self._started:
+            bb.event.fire(bb.event.ProcessStarted(self._processname, 100), self._data)
+            self._started = True
 
     def _fire_progress(self, taskprogress):
         if taskprogress == 0:
-- 
2.5.5


