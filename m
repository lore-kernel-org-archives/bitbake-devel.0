Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RQHfJ-0003pS-Lx
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 Nov 2011 12:59:01 +0100
Received: by opal (Postfix, from userid 111)
	id 4FACD1032E; Tue, 15 Nov 2011 11:53:59 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111115115359.4FACD1032E@opal>
Date: Tue, 15 Nov 2011 11:53:59 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : lib/bb/runqueue: avoid marking runtime dependencies as covered
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
X-List-Received-Date: Tue, 15 Nov 2011 11:59:01 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: e492eb4dc9016cd0bed194377c6f2b85cf0ad113
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=e492eb4dc9016cd0bed194377c6f2b85cf0ad113

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Fri Nov 11 18:38:15 2011 +0000

lib/bb/runqueue: avoid marking runtime dependencies as covered

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

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



