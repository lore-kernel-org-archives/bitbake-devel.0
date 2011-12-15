Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rb5d3-0001FS-RA
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Dec 2011 08:21:22 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 14 Dec 2011 23:14:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="87545461"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by orsmga002.jf.intel.com with ESMTP; 14 Dec 2011 23:14:25 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Dec 2011 15:14:58 +0800
Message-Id: <8777803468ca20a18696e9605fc08ed32d068bd7.1323933009.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
Subject: [PATCH 07/10] event.py: Add a new event PackageInfo
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
X-List-Received-Date: Thu, 15 Dec 2011 07:21:22 -0000

This event is to pass package information.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/event.py |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 088cd7c..67543e7 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -459,3 +459,12 @@ class LogHandler(logging.Handler):
     def filter(self, record):
         record.taskpid = worker_pid
         return True
+
+class PackageInfo(Event):
+    """
+    Package information for GUI
+    """
+    def __init__(self, recipe, pkginfolist):
+        Event.__init__(self)
+        self._recipe = recipe
+        self._pkginfolist = pkginfolist
-- 
1.7.0.4



