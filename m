Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDj-0007Ob-Ln
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:12:51 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 29 Mar 2012 05:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="147406942"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2012 05:03:48 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:11 +0800
Message-Id: <6f2d9f8a3e548dbf9ae34b6c53a85165d0d3ec99.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 05/14] command.py: Move triggerEvent to command async class
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
X-List-Received-Date: Thu, 29 Mar 2012 12:12:51 -0000

The parameters in triggerEvent function is an event object, and it may
cost some time to pass this object through pipe, causing the pipe's
poll() function timeout. Change it to async mode.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1799f1c..73aaca0 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -179,13 +179,6 @@ class CommandsSync:
         """
         return bb.utils.cpu_count()
 
-    def triggerEvent(self, command, params):
-        """
-        Trigger a certain event
-        """
-        event = params[0]
-        bb.event.fire(eval(event), command.cooker.configuration.data)
-
 class CommandsAsync:
     """
     A class of asynchronous commands
@@ -359,3 +352,13 @@ class CommandsAsync:
         command.cooker.parseConfigurationFiles(prefiles, postfiles)
         command.finishAsyncCommand()
     parseConfigurationFiles.needcache = False
+
+    def triggerEvent(self, command, params):
+        """
+        Trigger a certain event
+        """
+        event = params[0]
+        bb.event.fire(eval(event), command.cooker.configuration.data)
+        command.currentAsyncCommand = None
+    triggerEvent.needcache = False
+
-- 
1.7.4.1



