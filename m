Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id B97676CC57
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 13:15:51 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DFmI9007694 for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 Oct 2013 14:15:48 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BQM6n1_jQxQy for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 14:15:47 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r94DFfrp007681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 Oct 2013 14:15:42 +0100
Message-ID: <1380892536.18603.602.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 04 Oct 2013 14:15:36 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] xmlrpc: Show a better error message for connection failures
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
X-List-Received-Date: Fri, 04 Oct 2013 13:15:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Showing a traceback when unable to connect to a bitbake server is
rather ugly. This change allows us to show a sensible error message.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 389327a..82c0e8d 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -354,9 +354,12 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
             s.close()
         except:
             return None
-        self.serverImpl = XMLRPCProxyServer(host, port)
-        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, featureset)
-        return self.connection.connect()
+        try:
+            self.serverImpl = XMLRPCProxyServer(host, port)
+            self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, featureset)
+            return self.connection.connect()
+        except Exception as e:
+            bb.fatal("Could not connect to server at %s:%s (%s)" % (host, port, str(e)))
 
     def endSession(self):
         self.connection.removeClient()



