Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8B2136BD80
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 22:46:21 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMx3T4008637 for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:59:03 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id c4SIz28rsdcj for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:59:03 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMwu8g008633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:58:58 +0100
Message-ID: <1377989166.1059.136.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 31 Aug 2013 23:46:06 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] server/xmlrpc: stop server on client exit
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
X-List-Received-Date: Sat, 31 Aug 2013 22:46:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From: Alexandru DAMIAN <alexandru.damian@intel.com>

If the server only expects a single client to connect (i.e.
no bind parameter set, so there is no way for the
clients to get the server port), stop the server after
the first client exits.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index cca569d..534f844 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -133,6 +133,8 @@ class BitBakeServerCommands():
         if self.has_client:
             self.server.set_connection_token(None)
             self.has_client = False
+            if self.server.single_use:
+                self.server.quit = True
 
 # This request handler checks if the request has a "Bitbake-token" header
 # field (this comes from the client side) and compares it with its internal
@@ -239,6 +241,9 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         self.commands = BitBakeServerCommands(self)
         self.autoregister_all_functions(self.commands, "")
         self.interface = interface
+        self.single_use = False
+        if (interface[1] == 0):     # anonymous port, not getting reused
+            self.single_use = True
 
     def addcooker(self, cooker):
         BaseImplServer.addcooker(self, cooker)



