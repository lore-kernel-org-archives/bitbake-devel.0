Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RZvyy-0002e0-F3
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Dec 2011 03:51:14 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 11 Dec 2011 18:43:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="95039276"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.46])
	by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2011 18:43:16 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Dec 2011 10:20:26 +0800
Message-Id: <f68d9f3cfcfa4836897d808448d8de27512d57c3.1323656120.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
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
X-List-Received-Date: Mon, 12 Dec 2011 02:51:15 -0000

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



