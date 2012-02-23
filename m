Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0ZBZ-0000qR-Mv
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 14:58:17 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 23 Feb 2012 05:48:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120527619"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2012 05:48:50 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 21:47:19 +0800
Message-Id: <e5a2915d9483dd4c8b103334380ffa88cbbbb6f7.1330003017.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1330003017.git.dongxiao.xu@intel.com>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1330003017.git.dongxiao.xu@intel.com>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
Subject: [PATCH 7/9] command.py: add new API to get the cpu count on the server
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
X-List-Received-Date: Thu, 23 Feb 2012 13:58:17 -0000

From: Shane Wang <shane.wang@intel.com>

Add a new API in command.py to get the cpu count in order to set the appropriate default BB_NUMBER_THREADS and PARALLEL_MAKE variables.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 lib/bb/command.py |    6 ++++++
 lib/bb/utils.py   |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 05555c5..43875f7 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -173,6 +173,12 @@ class CommandsSync:
         """
         command.cooker.reset()
 
+    def getCpuCount(self, command, params):
+        """
+        Get the CPU count on the bitbake server
+        """
+        return bb.utils.cpu_count()
+
 
 class CommandsAsync:
     """
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index a26635a..d7cefb2 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -25,6 +25,7 @@ import errno
 import logging
 import bb
 import bb.msg
+import multiprocessing
 from commands import getstatusoutput
 from contextlib import contextmanager
 
@@ -862,3 +863,6 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
     if checkvalues.issubset(val): 
         return truevalue
     return falsevalue
+
+def cpu_count():
+    return multiprocessing.cpu_count()
-- 
1.7.4.1



