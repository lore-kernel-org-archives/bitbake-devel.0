Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RZvz7-0002jO-34
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Dec 2011 03:51:21 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 11 Dec 2011 18:43:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="85275859"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.46])
	by orsmga001.jf.intel.com with ESMTP; 11 Dec 2011 18:43:18 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Dec 2011 10:20:27 +0800
Message-Id: <4173eb787712154fbaadf613b14144ea66060e1d.1323656120.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
Subject: [PATCH 08/10] xmlrpc: Change BitbakeServerInfo init function
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
X-List-Received-Date: Mon, 12 Dec 2011 02:51:21 -0000

Pass host and port to BitbakeServerInfo class instead of the "server"
instance. With this change, GUI can connect with server individually
by host address and port.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/server/xmlrpc.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index a7ac969..b5980c6 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -242,9 +242,9 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
         return
 
 class BitbakeServerInfo():
-    def __init__(self, server):
-        self.host = server.host
-        self.port = server.port
+    def __init__(self, host, port):
+        self.host = host
+        self.port = port
 
 class BitBakeServerConnection():
     def __init__(self, serverinfo):
@@ -278,7 +278,7 @@ class BitBakeServer(object):
         return self.server.register_idle_function
 
     def saveConnectionDetails(self): 
-        self.serverinfo = BitbakeServerInfo(self.server)
+        self.serverinfo = BitbakeServerInfo(self.server.host, self.server.port)
 
     def detach(self, cooker_logfile):
         daemonize.createDaemon(self.server.serve_forever, cooker_logfile)
-- 
1.7.0.4



