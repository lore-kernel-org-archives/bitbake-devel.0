Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3E2936E666
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Jan 2016 10:45:55 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 05 Jan 2016 02:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,524,1444719600"; d="scan'208";a="884067995"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 05 Jan 2016 02:45:55 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 3EA606A4004;
	Tue,  5 Jan 2016 03:33:53 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jan 2016 10:48:11 +0200
Message-Id: <1451983692-14842-3-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1451983692-14842-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1451983692-14842-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 2/2] bitbake: main: kill server without queue setup
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
X-List-Received-Date: Tue, 05 Jan 2016 10:45:55 -0000

Setup of event queue includes registering of UI handler.
This operation can fail when cooker is busy. However, there is
no need in registering UI handler for terminating the server.

Moved the call of connection.terminateServer before setting up
of the event queue. This should make terminating server to work
more reliably as it doesn't depend on setting up the event queue
and registering UI handler anymore.

This should also help Toaster backend to restart bitbake server
and observer without getting "Could not register UI event handler"
errors.

[YOCTO #8776]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index dd04393..c0ae38a 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -403,10 +403,16 @@ def bitbake_main(configParams, configuration):
     if not configParams.server_only:
         try:
             server_connection = server.establishConnection(featureset)
-            server_connection.setupEventQueue()
         except Exception as e:
             bb.fatal("Could not connect to server %s: %s" % (configParams.remote_server, str(e)))
 
+        if configParams.kill_server:
+            server_connection.connection.terminateServer()
+            bb.event.ui_queue = []
+            return 0
+
+        server_connection.setupEventQueue()
+
         # Restore the environment in case the UI needs it
         for k in cleanedvars:
             os.environ[k] = cleanedvars[k]
@@ -418,11 +424,6 @@ def bitbake_main(configParams, configuration):
             server_connection.terminate()
             return 0
 
-        if configParams.kill_server:
-            server_connection.connection.terminateServer()
-            bb.event.ui_queue = []
-            return 0
-
         try:
             return ui_module.main(server_connection.connection, server_connection.events, configParams)
         finally:
-- 
2.1.4


