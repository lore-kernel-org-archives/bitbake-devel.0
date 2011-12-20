Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rczee-0002YB-Kz
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Dec 2011 14:22:52 +0100
Received: by opal (Postfix, from userid 111)
	id 4520210333; Tue, 20 Dec 2011 13:21:28 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111220132128.4520210333@opal>
Date: Tue, 20 Dec 2011 13:21:28 +0000 (UTC)
From: git@git.openembedded.org
Subject: Joshua Lock : ui/crumbs/runningbuild: handle InvalidTask events
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
X-List-Received-Date: Tue, 20 Dec 2011 13:22:52 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 540ba78075bd525776aa23bf38bee66350c66534
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=540ba78075bd525776aa23bf38bee66350c66534

Author: Joshua Lock <josh@linux.intel.com>
Date:   Tue Dec 13 14:45:41 2011 -0800

ui/crumbs/runningbuild: handle InvalidTask events

The knotty UI just ignores these and so should RunningBuild, if these events
aren't handled the UI appears to hang.

Fixes [YOCTO #1665]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

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



