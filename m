Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rb5d5-0001FS-Al
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Dec 2011 08:21:23 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 14 Dec 2011 23:14:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="87545465"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by orsmga002.jf.intel.com with ESMTP; 14 Dec 2011 23:14:26 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Dec 2011 15:14:59 +0800
Message-Id: <7d3ba924048ae3b8e2161230993b755b4e444002.1323933009.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
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
X-List-Received-Date: Thu, 15 Dec 2011 07:21:24 -0000

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



