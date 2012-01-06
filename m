Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj5mT-0007Rb-Mb
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:08:09 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 06 Jan 2012 01:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="93020199"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by azsmga001.ch.intel.com with ESMTP; 06 Jan 2012 01:00:45 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2012 17:02:27 +0800
Message-Id: <3f6925a1c29b8ecc2af1568b35631840fcd1d787.1325840050.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
Subject: [PATCH 09/16] xmlrpc: Change BitbakeServerInfo init function
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
X-List-Received-Date: Fri, 06 Jan 2012 09:08:09 -0000

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



