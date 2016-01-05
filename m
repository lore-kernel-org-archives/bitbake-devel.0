Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 7BBB96E666
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Jan 2016 10:45:42 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 05 Jan 2016 02:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,524,1444719600"; d="scan'208";a="884067935"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 05 Jan 2016 02:45:43 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 3933D6A4004;
	Tue,  5 Jan 2016 03:33:41 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jan 2016 10:48:10 +0200
Message-Id: <1451983692-14842-2-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1451983692-14842-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1451983692-14842-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 1/2] bitbake: xmplrpc: split connect method
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
X-List-Received-Date: Tue, 05 Jan 2016 10:45:44 -0000

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


