Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RlkeB-0006Wx-BV
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 18:10:35 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jan 2012 09:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="98177335"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.110])
	by orsmga002.jf.intel.com with ESMTP; 13 Jan 2012 09:01:57 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 17:01:47 +0000
Message-Id: <3e31e8e3c8f69ff60de8b2a73d84711493dbf284.1326473488.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326473488.git.paul.eggleton@linux.intel.com>
References: <cover.1326473488.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/8] bitbake/runqueue: avoid "failed" in task summary if nothing did
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
X-List-Received-Date: Fri, 13 Jan 2012 17:10:35 -0000

Seeing the word "failed" alone without reading the whole context has
occasionally triggered an automatic assumption on the part of some users
(myself included) that something has gone wrong, even when this message
is telling you that "0 [tasks] failed". To avoid this let's just say
"all succeeded" in this case instead.

As a bonus this means you can now search the output for "fail" and not
find anything if all went well.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/runqueue.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 86744fb..054d36c 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
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
-- 
1.7.5.4



