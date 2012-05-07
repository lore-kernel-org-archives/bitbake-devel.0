Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SRHKd-00009N-NW
	for bitbake-devel@lists.openembedded.org;
	Mon, 07 May 2012 08:22:03 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 06 May 2012 23:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="140835861"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 06 May 2012 23:12:12 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 May 2012 14:08:35 +0800
Message-Id: <61752e5eaa9cd19b7432dba1d7b2d61e4d961118.1336370732.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1336370732.git.dongxiao.xu@intel.com>
References: <cover.1336370732.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1336370732.git.dongxiao.xu@intel.com>
References: <cover.1336370732.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/1] Hob: Clear the building status if command failed
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
X-List-Received-Date: Mon, 07 May 2012 06:22:04 -0000

We may meet certain command failure during build time, for example,
out of memory. In this case, we need to clear the "building" status.

This fixes [YOCTO #2371]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index a07afdd..624d7b5 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -199,6 +199,8 @@ class HobHandler(gobject.GObject):
             self.clear_busy()
             self.emit("command-failed", self.error_msg)
             self.error_msg = ""
+            if self.building:
+                self.building = False
         elif isinstance(event, (bb.event.ParseStarted,
                  bb.event.CacheLoadStarted,
                  bb.event.TreeDataPreparationStarted,
-- 
1.7.4.1



