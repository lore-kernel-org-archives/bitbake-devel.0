Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RjCFa-0001JM-Hl
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 17:02:39 +0100
Received: by opal (Postfix, from userid 111)
	id 4389E10335; Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120106160257.4389E10335@opal>
Date: Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
From: git@git.openembedded.org
Subject: Dongxiao Xu : xmlrpc: Change BitbakeServerInfo init function
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
X-List-Received-Date: Fri, 06 Jan 2012 16:02:39 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 5124351d6c287185723c98e6e4400c5402a5c8a8
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=5124351d6c287185723c98e6e4400c5402a5c8a8

Author: Dongxiao Xu <dongxiao.xu@intel.com>
Date:   Fri Jan  6 17:02:27 2012 +0800

xmlrpc: Change BitbakeServerInfo init function

Pass host and port to BitbakeServerInfo class instead of the "server"
instance. With this change, GUI can connect with server individually
by host address and port.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

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



