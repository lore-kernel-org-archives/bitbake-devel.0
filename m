Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 737DF770A1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 09:43:36 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 05 Oct 2015 02:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,637,1437462000"; d="scan'208";a="784630550"
Received: from blynch-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.31])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2015 02:43:35 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Oct 2015 10:43:18 +0100
Message-Id: <7a7307e567cce5e4828b845dcdfe6e5867b2a985.1444038048.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
References: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444038048.git.elliot.smith@intel.com>
References: <cover.1444038048.git.elliot.smith@intel.com>
Subject: [PATCH 6/6] toaster: use meaningful logging levels
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
X-List-Received-Date: Mon, 05 Oct 2015 09:43:36 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Changed logging levels to more appropriate ones.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/toasterui.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 3891e63..dbe0d09 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -130,14 +130,14 @@ def main(server, eventHandler, params ):
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
-                logger.warn("Logfile for task %s", event.logfile)
+                logger.info("Logfile for task %s", event.logfile)
                 continue
 
             if isinstance(event, bb.build.TaskBase):
                 logger.info(event._message)
 
             if isinstance(event, bb.event.LogExecTTY):
-                logger.warn(event.msg)
+                logger.info(event.msg)
                 continue
 
             if isinstance(event, logging.LogRecord):
@@ -316,7 +316,7 @@ def main(server, eventHandler, params ):
                 buildinfohelper.store_dependency_information(event)
                 continue
 
-            logger.error("Unknown event: %s", event)
+            logger.warn("Unknown event: %s", event)
             return_value += 1
 
         except EnvironmentError as ioerror:
@@ -336,7 +336,7 @@ def main(server, eventHandler, params ):
             if tb is not None:
                 curr = tb
                 while curr is not None:
-                    logger.warn("Error data dump %s\n%s\n" , traceback.format_tb(curr,1), pformat(curr.tb_frame.f_locals))
+                    logger.error("Error data dump %s\n%s\n" , traceback.format_tb(curr,1), pformat(curr.tb_frame.f_locals))
                     curr = curr.tb_next
 
             # save them to database, if possible; if it fails, we already logged to console.
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


