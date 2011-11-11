Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1ROw5c-0003eo-2F
	for bitbake-devel@lists.openembedded.org;
	Fri, 11 Nov 2011 19:44:36 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 11 Nov 2011 10:38:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.69,496,1315206000"; d="scan'208";a="84113131"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.143])
	by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2011 10:38:16 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Nov 2011 18:38:15 +0000
Message-Id: <1321036695-937-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH] lib/bb/runqueue: avoid marking runtime dependencies as covered
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
X-List-Received-Date: Fri, 11 Nov 2011 18:44:36 -0000

The code which populates setscene_covered list was adding a task to the
covered list if all of the tasks that depend upon it were also covered;
however, this means that tasks that would have installed "runtime"
dependencies were being marked as covered also, e.g. gmp-native and
mpfr-native are needed by gcc-cross at runtime since they are shared
libraries that gcc links to, but their do_populate_sysroot tasks were
being marked as covered, resulting in failures later on if gcc-cross was
available from sstate but mpfr-native and gmp-native weren't.

Since we currently have no real way to handle runtime dependencies for
native packages, add a workaround which avoids marking tasks as covered
if one or more of their revdeps are from a different recipe.

Fixes [YOCTO #1536].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/runqueue.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7a39d89..a725388 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1208,8 +1208,13 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 if task in self.rq.scenequeue_covered:
                     continue
                 if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
-                    self.rq.scenequeue_covered.add(task)
                     found = True
+                    for revdep in self.rqdata.runq_revdeps[task]:
+                        if self.rqdata.runq_fnid[task] != self.rqdata.runq_fnid[revdep]:
+                            found = False
+                            break
+                    if found:
+                        self.rq.scenequeue_covered.add(task)
 
         # Detect when the real task needs to be run anyway by looking to see
         # if any of its dependencies within the same package are scheduled
-- 
1.7.5.4



