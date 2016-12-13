Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 2648D71B46
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:38 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961409"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:28 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:02 +1300
Message-Id: <57707076fecdee1926419ef22833e66670726ae4.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 03/15] knotty: fix --observe-only option
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:38 -0000

If we're in observe-only mode then we cannot run commands that would
affect the server's state, including getSetVariable, so prevent that
from being called in observe-only mode.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 3390eb7..521c262 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -312,7 +312,7 @@ class TerminalFilter(object):
             fd = sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
-def _log_settings_from_server(server):
+def _log_settings_from_server(server, observe_only):
     # Get values of variables which control our output
     includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
     if error:
@@ -322,7 +322,11 @@ def _log_settings_from_server(server):
     if error:
         logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
         raise BaseException(error)
-    consolelogfile, error = server.runCommand(["getSetVariable", "BB_CONSOLELOG"])
+    if observe_only:
+        cmd = 'getVariable'
+    else:
+        cmd = 'getSetVariable'
+    consolelogfile, error = server.runCommand([cmd, "BB_CONSOLELOG"])
     if error:
         logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
         raise BaseException(error)
@@ -340,7 +344,7 @@ _evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.Lo
 
 def main(server, eventHandler, params, tf = TerminalFilter):
 
-    includelogs, loglines, consolelogfile = _log_settings_from_server(server)
+    includelogs, loglines, consolelogfile = _log_settings_from_server(server, params.observe_only)
 
     if sys.stdin.isatty() and sys.stdout.isatty():
         log_exec_tty = True
-- 
2.5.5


