Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj5ma-0007Rb-66
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:08:16 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 06 Jan 2012 01:00:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="93020265"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by azsmga001.ch.intel.com with ESMTP; 06 Jan 2012 01:00:53 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2012 17:02:33 +0800
Message-Id: <2ce89adf04f57d34f90b5dcc4d14aa6eaa903121.1325840050.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
Subject: [PATCH 15/16] command.py: add new command to get the CPU info
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
X-List-Received-Date: Fri, 06 Jan 2012 09:08:16 -0000

Add new API in command.py to get the CPU core and threads information
in order to set the appropriate BB_NUMBER_THREADS and PARALLEL_MAKE
variables.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/helper.py |   39 +++++++++++++++++++++++++++++++++++++++
 lib/bb/command.py        |   12 ++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 bitbake/lib/bb/helper.py

diff --git a/bitbake/lib/bb/helper.py b/bitbake/lib/bb/helper.py
new file mode 100644
index 0000000..291158b
--- /dev/null
+++ b/bitbake/lib/bb/helper.py
@@ -0,0 +1,39 @@
+#
+# Helper for BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2011        Intel Corporation
+#
+# Authored by Shane Wang <shane.wang@intel.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import os
+
+class CpuInfo(object):
+
+    coefficient = 4
+
+    @classmethod
+    def getNumOfCpus(cls):
+        pfile = os.popen('cat /proc/cpuinfo | grep cpu\ cores')
+        num = len(pfile.readlines())
+        return num
+
+    @classmethod
+    def getNumOfCpuCores(cls):
+        pfile = os.popen('cat /proc/cpuinfo | grep cpu\ cores | cut -d: -f2')
+        contents = pfile.readlines()
+        num = int(contents[0])
+        return num
+
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 141b51e..ba7c753 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -30,6 +30,7 @@ Commands are queued in a CommandQueue
 
 import bb.event
 import bb.cooker
+import bb.helper
 
 class CommandCompleted(bb.event.Event):
     pass
@@ -170,6 +171,17 @@ class CommandsSync:
         """
         command.cooker.reset()
 
+    def getDefaultNumOfThreads(self, command, params):
+        """
+        Get the default number of threads on the server = number of CPUs
+        """
+        return bb.helper.CpuInfo.getNumOfCpus()
+
+    def getMaxNumOfThreads(self, command, params):
+        """
+        Get the max number of threads that the server can tolerate
+        """
+        return bb.helper.CpuInfo.getNumOfCpus() * bb.helper.CpuInfo.coefficient
 
 class CommandsAsync:
     """
-- 
1.7.0.4



