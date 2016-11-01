Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id B6B4571BF8
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Nov 2016 15:05:14 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 01 Nov 2016 08:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,580,1473145200"; d="scan'208";a="186337522"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2016 08:05:15 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  1 Nov 2016 17:05:12 +0200
Message-Id: <1478012712-17287-3-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1478012712-17287-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1478012712-17287-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 2/2] bitbake-worker: print full traceback instead of message only
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
X-List-Received-Date: Tue, 01 Nov 2016 15:05:14 -0000

Print full traceback instead of just the exception message in the
child() function inside fork_off_task(). This makes debugging a lot
easier as the function catches a generic "Exception" and the exception
message alone might not give much information.

[YOCTO #10393]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 bin/bitbake-worker | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 500f2ad..af66ff0 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -11,6 +11,7 @@ import select
 import errno
 import signal
 import pickle
+import traceback
 from multiprocessing import Lock
 
 if sys.getfilesystemencoding() != "utf-8":
@@ -234,9 +235,9 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                 if quieterrors:
                     the_data.setVarFlag(taskname, "quieterrors", "1")
 
-            except Exception as exc:
+            except Exception:
                 if not quieterrors:
-                    logger.critical(str(exc))
+                    logger.critical(traceback.format_exc())
                 os._exit(1)
             try:
                 if cfg.dry_run:
-- 
2.6.6


