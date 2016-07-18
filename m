Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 812D171951
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2016 16:32:09 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 18 Jul 2016 09:32:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,384,1464678000"; d="scan'208";a="997625915"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga001.jf.intel.com with ESMTP; 18 Jul 2016 09:32:12 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id C7CF56A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2016 09:32:00 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jul 2016 19:07:16 +0300
Message-Id: <e85cc6625078ba05a1aaf0f2d084d49d90f4642d.1468857803.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1468857803.git.ed.bartosh@linux.intel.com>
References: <cover.1468857803.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1468857803.git.ed.bartosh@linux.intel.com>
References: <cover.1468857803.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/3] bitbake: xmlrpc: implement check of connection to server
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
X-List-Received-Date: Mon, 18 Jul 2016 16:32:09 -0000

Implemented check_connection function. The purpose of this function
is to check if bitbake server is accessible and functional.
To check this this function tries to connect to bitbake server and
run getVariable command.

This API is going to be used to implement autoloading of bitbake
server.

[YOCTO #5534]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/server/xmlrpc.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 57c59a8..4131b52 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -85,6 +85,23 @@ def _create_server(host, port, timeout = 60):
     s = xmlrpc.client.ServerProxy("http://%s:%d/" % (host, port), transport=t, allow_none=True, use_builtin_types=True)
     return s, t
 
+def check_connection(remote, timeout):
+    try:
+        host, port = remote.split(":")
+        port = int(port)
+    except Exception as e:
+        bb.warn("Failed to read remote definition (%s)" % str(e))
+        raise e
+
+    server, _transport = _create_server(host, port, timeout)
+    try:
+        ret, err =  server.runCommand(['getVariable', 'TOPDIR'])
+        if err or not ret:
+            return False
+    except ConnectionError:
+        return False
+    return True
+
 class BitBakeServerCommands():
 
     def __init__(self, server):
-- 
2.1.4


