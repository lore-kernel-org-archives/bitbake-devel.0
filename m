Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 0E61D6A9BA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Jun 2013 11:12:00 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 17 Jun 2013 04:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,880,1363158000"; d="scan'208";a="256085892"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by AZSMGA002.ch.intel.com with ESMTP; 17 Jun 2013 04:11:56 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 97C0F560373; Mon, 17 Jun 2013 12:11:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 17 Jun 2013 12:11:52 +0100
Message-Id: <1371467513-3746-3-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371467513-3746-1-git-send-email-alexandru.damian@intel.com>
References: <1371467513-3746-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/3] knotty, bitbake: add option to terminate a remote server
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
X-List-Received-Date: Mon, 17 Jun 2013 11:12:00 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

I add an option to terminate a remote server gracefully
as not to need a kill command.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake         | 3 +++
 lib/bb/ui/knotty.py | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/bin/bitbake b/bin/bitbake
index e77266b..0d6b3ae 100755
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
index c6a1d3f..2c8293d 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -250,6 +250,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
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


