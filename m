Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id A7B5F7320F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Mar 2016 10:23:34 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 04 Mar 2016 02:23:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,535,1449561600"; d="scan'208";a="929497419"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 04 Mar 2016 02:23:29 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 091C46A4002;
	Fri,  4 Mar 2016 03:11:15 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Mar 2016 10:13:40 +0200
Message-Id: <1457079220-27980-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] xmlrpc: fix bug in setting XMLRPCServer.single_use
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
X-List-Received-Date: Fri, 04 Mar 2016 10:23:36 -0000

XMLRPCServer.single_use attribute was always set to False.
This caused xmlrpc server to keep running after build is done as
BitBakeServerCommands.removeClient only shuts down server if its
single_use attribute is set to True.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/server/xmlrpc.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 1ceca51..d627550 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -193,6 +193,8 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         BaseImplServer.__init__(self)
         if (interface[1] == 0):     # anonymous port, not getting reused
             self.single_use = True
+        else:
+            self.singe_use = False
         # Use auto port configuration
         if (interface[1] == -1):
             interface = (interface[0], 0)
@@ -205,7 +207,6 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         self.commands = BitBakeServerCommands(self)
         self.autoregister_all_functions(self.commands, "")
         self.interface = interface
-        self.single_use = False
 
     def addcooker(self, cooker):
         BaseImplServer.addcooker(self, cooker)
-- 
2.1.4


