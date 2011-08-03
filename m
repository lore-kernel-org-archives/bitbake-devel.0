Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QoQA3-0006Dv-0Y
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 03:22:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 02 Aug 2011 18:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,307,1309762800"; d="scan'208";a="33627967"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by orsmga002.jf.intel.com with ESMTP; 02 Aug 2011 18:17:48 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Aug 2011 18:17:39 -0700
Message-Id: <25ec13075855f7e321a9763682a8cd4ca09203cd.1312334047.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312334047.git.josh@linux.intel.com>
References: <cover.1312334047.git.josh@linux.intel.com>
In-Reply-To: <cover.1312334047.git.josh@linux.intel.com>
References: <cover.1312334047.git.josh@linux.intel.com>
Subject: [PATCH 6/6] bb/ui/crumbs/runningbuild: emit signal when command fails with exit signal
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
X-List-Received-Date: Wed, 03 Aug 2011 01:22:15 -0000

Emit the generic build-complete signal when a command fails with an exit
signal enabling the UI to update itself accordingly.

Addresses [YOCTO #1265]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/runningbuild.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index 2399ff3..bf72e2a 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -239,6 +239,12 @@ class RunningBuild (gobject.GObject):
             else:
                 self.emit ("build-succeeded")
 
+        elif isinstance(event, bb.command.CommandFailed):
+            if event.error.startswith("Exited with"):
+                # If the command fails with an exit code we're done, emit the
+                # generic signal for the UI to notify the user
+                self.emit("build-complete")
+
         elif isinstance(event, bb.event.CacheLoadStarted) and pbar:
             pbar.set_title("Loading cache")
             self.progress_total = event.total
-- 
1.7.6



