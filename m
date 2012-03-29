Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDi-0007Ob-2E
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:12:50 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Mar 2012 05:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="135068896"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2012 05:03:45 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:08 +0800
Message-Id: <dd1fb02836ff85baba8a4a5db4c70ba547f7fc16.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 02/14] Hob: Fix adding duplicated meta-hob layer
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
X-List-Received-Date: Thu, 29 Mar 2012 12:12:50 -0000

While adding meta-hob layer, we need to detect whether it already
exists in current layers.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index f189553..1cbb027 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -383,7 +383,9 @@ class HobHandler(gobject.GObject):
         params = {}
         params["core_base"] = self.server.runCommand(["getVariable", "COREBASE"]) or ""
         hob_layer = params["core_base"] + "/meta-hob"
-        params["layer"] = (self.server.runCommand(["getVariable", "BBLAYERS"]) or "") + " " + hob_layer
+        params["layer"] = self.server.runCommand(["getVariable", "BBLAYERS"]) or ""
+        if hob_layer not in params["layer"].split():
+            params["layer"] += (" " + hob_layer)
         params["dldir"] = self.server.runCommand(["getVariable", "DL_DIR"]) or ""
         params["machine"] = self.server.runCommand(["getVariable", "MACHINE"]) or ""
         params["distro"] = self.server.runCommand(["getVariable", "DISTRO"]) or "defaultsetup"
-- 
1.7.4.1



