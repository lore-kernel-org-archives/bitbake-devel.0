Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RkoYP-0005XF-Eu
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 04:08:45 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 10 Jan 2012 19:01:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="105789871"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2012 19:01:16 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jan 2012 11:03:22 +0800
Message-Id: <58f9f45f8bc0c2d20fd80a4b31747b073b5bf04e.1326249301.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1326249301.git.dongxiao.xu@intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1326249301.git.dongxiao.xu@intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
Subject: [PATCH 3/8] event.py: Add a new event PackageInfo
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
X-List-Received-Date: Wed, 11 Jan 2012 03:08:45 -0000

This event is to pass package information.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/event.py |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 8d7f941..57bcfb5 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -467,3 +467,11 @@ class LogHandler(logging.Handler):
     def filter(self, record):
         record.taskpid = worker_pid
         return True
+
+class PackageInfo(Event):
+    """
+    Package information for GUI
+    """
+    def __init__(self, pkginfolist):
+        Event.__init__(self)
+        self._pkginfolist = pkginfolist
-- 
1.7.0.4



