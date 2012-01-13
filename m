Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RlccD-0002PY-LF
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 09:36:01 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 13 Jan 2012 00:28:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="95425192"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by azsmga001.ch.intel.com with ESMTP; 13 Jan 2012 00:28:29 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 16:30:41 +0800
Message-Id: <44369e95249adee9818d8a79b723eb27f08cbdbc.1326442655.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1326442655.git.dongxiao.xu@intel.com>
References: <cover.1326442655.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1326442655.git.dongxiao.xu@intel.com>
References: <cover.1326442655.git.dongxiao.xu@intel.com>
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
X-List-Received-Date: Fri, 13 Jan 2012 08:36:02 -0000

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
1.7.0.4



