Return-Path: <brian.avery@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 992BF606D0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jul 2016 16:42:44 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 15 Jul 2016 09:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,368,1464678000"; d="scan'208";a="996020618"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga001.jf.intel.com with ESMTP; 15 Jul 2016 09:42:45 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jul 2016 09:44:01 -0700
Message-Id: <1468601041-15423-1-git-send-email-brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
Subject: [PATCHV4 01/17] runqueue: improve exception logging
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
X-List-Received-Date: Fri, 15 Jul 2016 16:42:46 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Runqueue errors direct the user to view the "failure below",
but no additional error message is available.

Log the stacktrace so that the user can see what went wrong.

Also fix a typo in the log message.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c9b6b84..48c01c0 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1175,8 +1175,8 @@ class RunQueue:
                 pass
             self.state = runQueueComplete
             raise
-        except:
-            logger.error("An uncaught exception occured in runqueue, please see the failure below:")
+        except Exception as err:
+            logger.exception("An uncaught exception occurred in runqueue")
             try:
                 self.teardown_workers()
             except:
-- 
1.9.1


