Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RmN5w-00084u-Rr
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 11:13:49 +0100
Received: by opal (Postfix, from userid 111)
	id D671C1033B; Sun, 15 Jan 2012 10:15:10 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120115101510.D671C1033B@opal>
Date: Sun, 15 Jan 2012 10:15:10 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/runqueue: avoid "failed" in task summary if nothing did
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
X-List-Received-Date: Sun, 15 Jan 2012 10:13:49 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: b6f067af12d4661758a78788f1db472684b9aba8
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=b6f067af12d4661758a78788f1db472684b9aba8

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Fri Jan 13 17:01:47 2012 +0000

bitbake/runqueue: avoid "failed" in task summary if nothing did

Seeing the word "failed" alone without reading the whole context has
occasionally triggered an automatic assumption on the part of some users
(myself included) that something has gone wrong, even when this message
is telling you that "0 [tasks] failed". To avoid this let's just say
"all succeeded" in this case instead.

As a bonus this means you can now search the output for "fail" and not
find anything if all went well.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 0e83d05..12ebdf9 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -968,7 +968,11 @@ class RunQueue:
 
         if self.state is runQueueComplete:
             # All done
-            logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
+            if self.rqexe.stats.failed:
+                logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
+            else:
+                # Let's avoid the word "failed" if nothing actually did
+                logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and all succeeded.", self.rqexe.stats.completed, self.rqexe.stats.skipped)
             return False
 
         if self.state is runQueueChildProcess:



