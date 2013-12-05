Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8FA1F6DBF6
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Dec 2013 14:04:06 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 05 Dec 2013 05:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,833,1378882800"; d="scan'208";a="447387337"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by orsmga002.jf.intel.com with ESMTP; 05 Dec 2013 06:03:11 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Dec 2013 16:09:15 +0200
Message-Id: <1386252555-6067-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: changes to INHERIT var should use "append" operation
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
X-List-Received-Date: Thu, 05 Dec 2013 14:04:06 -0000

Setting INHERIT var means to remove other operations made on INHERIT.
This is too intrusive, so we decided to use append for this case.

[YOCTO #5448]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index ce8584d..7014935 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -306,9 +306,7 @@ class HobHandler(gobject.GObject):
         self.runCommand(["createConfigFile", ".hob.conf"])
 
     def set_extra_inherit(self, bbclass):
-        inherits = self.runCommand(["getVariable", "INHERIT"]) or ""
-        inherits = inherits + " " + bbclass
-        self.set_var_in_file("INHERIT", inherits, ".hob.conf")
+        self.append_var_in_file("INHERIT", bbclass, ".hob.conf")
 
     def set_bblayers(self, bblayers):
         self.set_var_in_file("BBLAYERS", " ".join(bblayers), "bblayers.conf")
-- 
1.7.9.5


