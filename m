Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 9B5086F159
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2014 13:22:43 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 25 Feb 2014 05:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,540,1389772800"; d="scan'208";a="481450529"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.62])
	by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2014 05:22:18 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Feb 2014 15:30:11 +0200
Message-Id: <1393335012-26237-3-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1393335012-26237-1-git-send-email-cristiana.voicu@intel.com>
References: <y> <1393335012-26237-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 2/3] hob: remove the code that adds hob layer to bblayers
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 25 Feb 2014 13:22:44 -0000

[YOCTO #5118]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index e848405..cdf1eb5 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -511,13 +511,8 @@ class HobHandler(gobject.GObject):
         # retrieve the parameters from bitbake
         params = {}
         params["core_base"] = self.runCommand(["getVariable", "COREBASE"]) or ""
-        hob_layer = params["core_base"] + "/meta-hob"
         params["layer"] = self.runCommand(["getVariable", "BBLAYERS"]) or ""
         params["layers_non_removable"] = self.runCommand(["getVariable", "BBLAYERS_NON_REMOVABLE"]) or ""
-        if hob_layer not in params["layer"].split():
-            params["layer"] += (" " + hob_layer)
-        if hob_layer not in params["layers_non_removable"].split():
-            params["layers_non_removable"] += (" " + hob_layer)
         params["dldir"] = self.runCommand(["getVariable", "DL_DIR"]) or ""
         params["machine"] = self.runCommand(["getVariable", "MACHINE"]) or ""
         params["distro"] = self.runCommand(["getVariable", "DISTRO"]) or "defaultsetup"
-- 
1.7.9.5


