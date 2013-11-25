Return-Path: <jason.wessel@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id EC9B56DD16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 21:21:33 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rAPLLX07013092
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 13:21:33 -0800 (PST)
Received: from ord-jrw.corp.ad.wrs.com (172.25.32.36) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.2.347.0; Mon, 25 Nov 2013 13:21:33 -0800
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 15:21:26 -0600
Message-ID: <1385414489-2901-3-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
References: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/5] bitbake.lock: Add host:port to bitbake.lock for memres server
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
X-List-Received-Date: Mon, 25 Nov 2013 21:21:35 -0000
Content-Type: text/plain

The idea is to build on the --status-only option for bitbake and
expose a mechanism where the oe init scripts can easily switch between
memres server and the non-memres server.

In the case of the standard oe init script the following
can shut down the server:

if [ -z "$BBSERVER" ] && [ -f bitbake.lock ] ; then
    grep ":" bitbake.lock > /dev/null && BBSERVER=`cat bitbake.lock` bitbake --status-only
    if [ $? = 0 ] ; then
       echo "Shutting down bitbake memory resident server with bitbake -m"
       BBSERVER=`cat bitbake.lock` bitbake -m
    fi
fi

A similar function can be used to automatically detect if the server
is already running for the oe memres init script.  This new
functionality allows for the memres init script to be started in a new
shell and connect up to an alaready running server without seeing the
error of trying to start the server multiple times.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 bin/bitbake             |    2 ++
 lib/bb/cooker.py        |    8 ++++++++
 lib/bb/cookerdata.py    |    1 +
 lib/bb/server/xmlrpc.py |    7 +++++--
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index cca2b8d..21fe3ab 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -208,8 +208,10 @@ def start_server(servermodule, configParams, configuration):
     if configParams.bind:
         (host, port) = configParams.bind.split(':')
         server.initServer((host, int(port)))
+        configuration.interface = [ server.serverImpl.host, server.serverImpl.port ]
     else:
         server.initServer()
+        configuration.interface = []
 
     try:
         configuration.setServerRegIdleCallback(server.getServerIdleCB())
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1f494ee..ae77f6f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -125,6 +125,14 @@ class BBCooker:
         self.lock = bb.utils.lockfile(lockfile, False, False)
         if not self.lock:
             bb.fatal("Only one copy of bitbake should be run against a build directory")
+        try:
+            self.lock.seek(0)
+            self.lock.truncate()
+            if len(configuration.interface) >= 2:
+                self.lock.write("%s:%s\n" % (configuration.interface[0], configuration.interface[1]));
+            self.lock.flush()
+        except:
+            pass
 
         # TOSTOP must not be set or our children will hang when they output
         fd = sys.stdout.fileno()
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index e640ed0..6200b0e 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -127,6 +127,7 @@ class CookerConfiguration(object):
         self.dump_signatures = False
         self.dry_run = False
         self.tracking = False
+        self.interface = []
 
         self.env = {}
 
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 82c0e8d..54b0f88 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -198,6 +198,11 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         Constructor
         """
         BaseImplServer.__init__(self)
+        if (interface[1] == 0):     # anonymous port, not getting reused
+            self.single_use = True
+        # Use auto port configuration
+        if (interface[1] == -1):
+            interface = (interface[0], 0)
         SimpleXMLRPCServer.__init__(self, interface,
                                     requestHandler=BitBakeXMLRPCRequestHandler,
                                     logRequests=False, allow_none=True)
@@ -208,8 +213,6 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         self.autoregister_all_functions(self.commands, "")
         self.interface = interface
         self.single_use = False
-        if (interface[1] == 0):     # anonymous port, not getting reused
-            self.single_use = True
 
     def addcooker(self, cooker):
         BaseImplServer.addcooker(self, cooker)
-- 
1.7.9.5


