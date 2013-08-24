Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8815061013
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Aug 2013 12:08:25 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OCKR4r017024; Sat, 24 Aug 2013 13:20:27 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ciLcaJmD5Evi; Sat, 24 Aug 2013 13:20:26 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OCKOe7017016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sat, 24 Aug 2013 13:20:25 +0100
Message-ID: <1377346093.6762.187.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 24 Aug 2013 13:08:13 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] server/xmlrpc/prserv: Add sane timeout to default xmlrpc server
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
X-List-Received-Date: Sat, 24 Aug 2013 12:08:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The standard python socket connect has long timouts which make sense for remote
connections but not local things like the PR Service. This adds a timeout
parameter to the common xmlrpc server creation function and sets it to a more
reasonable 5 seconds.

Making the PR server instantly exit is a good way to test the effect of this
on bitbake.

We can remove the bodged timeout in the PRServer terminate function which
has the side effect of affecting global scope.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 026415e..d290550 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -47,15 +47,29 @@ except ImportError:
 DEBUG = False
 
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
-import inspect, select
+import inspect, select, httplib
 
 from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
 
 class BBTransport(xmlrpclib.Transport):
-    def __init__(self):
+    def __init__(self, timeout):
+        self.timeout = timeout
         self.connection_token = None
         xmlrpclib.Transport.__init__(self)
 
+    # Modified from default to pass timeout to HTTPConnection
+    def make_connection(self, host):
+        #return an existing connection if possible.  This allows
+        #HTTP/1.1 keep-alive.
+        if self._connection and host == self._connection[0]:
+            return self._connection[1]
+
+        # create a HTTP connection object from a host descriptor
+        chost, self._extra_headers, x509 = self.get_host_info(host)
+        #store the host argument along with the connection object
+        self._connection = host, httplib.HTTPConnection(chost, timeout=self.timeout)
+        return self._connection[1]
+
     def set_connection_token(self, token):
         self.connection_token = token
 
@@ -64,8 +78,8 @@ class BBTransport(xmlrpclib.Transport):
             h.putheader("Bitbake-token", self.connection_token)
         xmlrpclib.Transport.send_content(self, h, body)
 
-def _create_server(host, port):
-    t = BBTransport()
+def _create_server(host, port, timeout = 5):
+    t = BBTransport(timeout)
     s = xmlrpclib.Server("http://%s:%d/" % (host, port), transport=t, allow_none=True)
     return s, t
 
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index b854686..81b4f8d 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -186,9 +186,6 @@ class PRServerConnection():
         self.connection, self.transport = bb.server.xmlrpc._create_server(self.host, self.port)
 
     def terminate(self):
-        # Don't wait for server indefinitely
-        import socket
-        socket.setdefaulttimeout(2)
         try:
             logger.info("Terminating PRServer...")
             self.connection.quit()



