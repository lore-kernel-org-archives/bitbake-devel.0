Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 647B8731D2
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Jan 2016 15:42:20 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 05 Jan 2016 07:42:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,525,1444719600"; d="scan'208";a="628388009"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 05 Jan 2016 07:42:21 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id A2AC56A4004;
	Tue,  5 Jan 2016 08:30:18 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jan 2016 15:45:37 +0200
Message-Id: <1452001538-25251-2-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1452001538-25251-1-git-send-email-ed.bartosh@linux.intel.com>
References: <CAJTo0LaxgVGcwkTL-3mzHeCtU+s42oMVwtm7Sbcb1YqErx2p=w@mail.gmail.com>
	<1452001538-25251-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH v2 1/2] bitbake: xmplrpc: split connect method
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
X-List-Received-Date: Tue, 05 Jan 2016 15:42:20 -0000

Current code in connect method sets up event queue, which requires
registering UI handler. This functionality may not be needed for
some operations, e.g. for server termination.

Moved functionality of setting up event queue in from 'connect'
method to 'setupEventQueue' in BitBakeXMLRPCServerConnection class.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index c8530fc..dd04393 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -403,6 +403,7 @@ def bitbake_main(configParams, configuration):
     if not configParams.server_only:
         try:
             server_connection = server.establishConnection(featureset)
+            server_connection.setupEventQueue()
         except Exception as e:
             bb.fatal("Could not connect to server %s: %s" % (configParams.remote_server, str(e)))
 
diff --git a/bitbake/lib/bb/server/__init__.py b/bitbake/lib/bb/server/__init__.py
index da5e480..538a633 100644
--- a/bitbake/lib/bb/server/__init__.py
+++ b/bitbake/lib/bb/server/__init__.py
@@ -63,6 +63,9 @@ class BitBakeBaseServerConnection():
     def terminate(self):
         pass
 
+    def setupEventQueue(self):
+        pass
+
 
 """ BitBakeBaseServer class is the common ancestor to all Bitbake servers
 
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 17eb28b..1ceca51 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -302,7 +302,9 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
             return None
 
         self.transport.set_connection_token(token)
+        return self
 
+    def setupEventQueue(self):
         self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo)
         for event in bb.event.ui_queue:
             self.events.queue_event(event)
@@ -314,8 +316,6 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
             # no need to log it here, the error shall be sent to the client
             raise BaseException(error)
 
-        return self
-
     def removeClient(self):
         if not self.observer_only:
             self.connection.removeClient()
-- 
2.1.4


