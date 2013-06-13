Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A97DA62195
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Jun 2013 15:23:38 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 13 Jun 2013 08:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,859,1363158000"; d="scan'208";a="328922989"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by orsmga001.jf.intel.com with ESMTP; 13 Jun 2013 08:23:38 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 6AD38560681; Thu, 13 Jun 2013 16:23:37 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Thu, 13 Jun 2013 16:23:34 +0100
Message-Id: <1371137015-4416-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/2] knotty, bitbake: add option to terminate a remote server
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 13 Jun 2013 15:23:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

I add an option to terminate a remote server gracefully
as not to need a kill command.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake         | 3 +++
 lib/bb/ui/knotty.py | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/bin/bitbake b/bin/bitbake
index ef0c5d8..e924eec 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -197,6 +197,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("", "--remote-server", help = "Connect to the specified server",
                    action = "store", dest = "remote_server", default = False)
 
+        parser.add_option("-m", "--kill-server", help = "Terminate the remote server",
+                    action = "store_true", dest = "kill_server", default = False)
+
         parser.add_option("", "--observe-only", help = "Connect to a server as an observing-only client",
                    action = "store_true", dest = "observe_only", default = False)
 
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 465203f..db73ddf 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -253,6 +253,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     console.setFormatter(format)
     logger.addHandler(console)
 
+    if params.options.remote_server and params.options.kill_server:
+        server.terminateServer()
+        return
+
     if consolelogfile and not params.options.show_environment:
         bb.utils.mkdirhier(os.path.dirname(consolelogfile))
         conlogformat = bb.msg.BBLogFormatter(format_str)
-- 
1.8.1.2


