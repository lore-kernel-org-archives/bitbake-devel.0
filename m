Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TdMWx-00023U-Sz
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Nov 2012 15:53:00 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 27 Nov 2012 06:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,328,1352102400"; d="scan'208";a="253406291"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2012 06:38:44 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Nov 2012 16:41:31 +0200
Message-Id: <1354027291-9341-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: when BBLAYERS_NON_REMOVABLE is not set hob shows an error
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
X-List-Received-Date: Tue, 27 Nov 2012 14:53:00 -0000

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index ae1cefc..8a2ac5f 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -435,7 +435,7 @@ class HobHandler(gobject.GObject):
         params["core_base"] = self.runCommand(["getVariable", "COREBASE"]) or ""
         hob_layer = params["core_base"] + "/meta-hob"
         params["layer"] = self.runCommand(["getVariable", "BBLAYERS"]) or ""
-        params["layers_non_removable"] = self.runCommand(["getVariable", "BBLAYERS_NON_REMOVABLE"])
+        params["layers_non_removable"] = self.runCommand(["getVariable", "BBLAYERS_NON_REMOVABLE"]) or ""
         if hob_layer not in params["layer"].split():
             params["layer"] += (" " + hob_layer)
         if hob_layer not in params["layers_non_removable"].split():
-- 
1.7.9.5



