Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RabEO-00045Q-3P
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Dec 2011 23:53:52 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 13 Dec 2011 14:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="86232576"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.215])
	by orsmga001.jf.intel.com with ESMTP; 13 Dec 2011 14:45:43 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2011 14:45:41 -0800
Message-Id: <bcfc6d471e61b5dfe73a872e2e7864c8de84b2b6.1323815814.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.4
In-Reply-To: <cover.1323815814.git.josh@linux.intel.com>
References: <cover.1323815814.git.josh@linux.intel.com>
In-Reply-To: <cover.1323815814.git.josh@linux.intel.com>
References: <cover.1323815814.git.josh@linux.intel.com>
Subject: [PATCH 1/2] ui/crumbs/runningbuild: handle InvalidTask events
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
X-List-Received-Date: Tue, 13 Dec 2011 22:53:52 -0000

The knotty UI just ignores these and so should RunningBuild, if these events
aren't handled the UI appears to hang.

Fixes [YOCTO #1665]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/runningbuild.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index 509590a..4f609fc 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -179,6 +179,10 @@ class RunningBuild (gobject.GObject):
             # that we need to attach to a task.
             self.tasks_to_iter[(package, task)] = i
 
+        # If we don't handle these the GUI does not proceed
+        elif isinstance(event, bb.build.TaskInvalid):
+            return
+
         elif isinstance(event, bb.build.TaskBase):
             current = self.tasks_to_iter[(package, task)]
             parent = self.tasks_to_iter[(package, None)]
-- 
1.7.7.4



