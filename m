Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S0JoB-0008OV-JT
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Feb 2012 22:33:07 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 22 Feb 2012 13:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="69228255"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.16])
	by AZSMGA002.ch.intel.com with ESMTP; 22 Feb 2012 13:24:45 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Feb 2012 21:24:41 +0000
Message-Id: <a782708cb226bfcd8925833a94ba0a79e7301ad4.1329945681.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1329945681.git.paul.eggleton@linux.intel.com>
References: <cover.1329945681.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1329945681.git.paul.eggleton@linux.intel.com>
References: <cover.1329945681.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake/ui/knotty: fix incorrect exit code
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 Feb 2012 21:33:08 -0000

The recent Ctrl+C patch was not fully tested; the variable it was
relying upon is set to non-zero under other circumstances and thus
bitbake was reporting that it was interrupted and returning a non-zero
exit code when it was not. Track this status in a separate variable
in order to fix the issue.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/knotty.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 9881d82..158a132 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -110,6 +110,7 @@ def main(server, eventHandler):
     parseprogress = None
     cacheprogress = None
     shutdown = 0
+    interrupted = False
     return_value = 0
     errors = 0
     warnings = 0
@@ -276,6 +277,7 @@ def main(server, eventHandler):
                 print("\nSecond Keyboard Interrupt, stopping...\n")
                 server.runCommand(["stateStop"])
             if shutdown == 0:
+                interrupted = True
                 print("\nKeyboard Interrupt, closing down...\n")
                 server.runCommand(["stateShutdown"])
             shutdown = shutdown + 1
@@ -296,7 +298,7 @@ def main(server, eventHandler):
     if summary:
         print(summary)
 
-    if shutdown:
+    if interrupted:
         print("Execution was interrupted, returning a non-zero exit code.")
         if return_value == 0:
             return_value = 1
-- 
1.7.5.4



