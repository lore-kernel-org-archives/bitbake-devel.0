Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 62E9A6FF30
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 10:27:33 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP; 09 Mar 2016 02:27:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,311,1455004800"; d="scan'208";a="905886186"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 09 Mar 2016 02:27:34 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 287B72C8001;
	Wed,  9 Mar 2016 03:15:19 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Mar 2016 10:07:40 +0200
Message-Id: <1457510860-25465-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH v2] xmlrpc: fix bug in setting XMLRPCServer.single_use
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
X-List-Received-Date: Wed, 09 Mar 2016 10:27:34 -0000

XMLRPCServer.single_use attribute was always set to False.
This caused xmlrpc server to keep running after build is done as
BitBakeServerCommands.removeClient only shuts down server if its
single_use attribute is set to True.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/server/xmlrpc.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 1ceca51..7528138 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -191,8 +191,7 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         Constructor
         """
         BaseImplServer.__init__(self)
-        if (interface[1] == 0):     # anonymous port, not getting reused
-            self.single_use = True
+        self.single_use = interface[1] == 0 # anonymous port, not getting reused
         # Use auto port configuration
         if (interface[1] == -1):
             interface = (interface[0], 0)
@@ -205,7 +204,6 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         self.commands = BitBakeServerCommands(self)
         self.autoregister_all_functions(self.commands, "")
         self.interface = interface
-        self.single_use = False
 
     def addcooker(self, cooker):
         BaseImplServer.addcooker(self, cooker)
-- 
2.1.4


