Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S37a8-0007re-UW
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 16:06:13 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 01 Mar 2012 06:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123711560"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.90])
	by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2012 06:57:42 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Mar 2012 14:57:36 +0000
Message-Id: <1b89555e3d22c80cf09753d4618f3014e28fe072.1330613733.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330613733.git.paul.eggleton@linux.intel.com>
References: <cover.1330613733.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1330613733.git.paul.eggleton@linux.intel.com>
References: <cover.1330613733.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] bitbake/uihelper: restore line to record failed normal tasks
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
X-List-Received-Date: Thu, 01 Mar 2012 15:06:13 -0000

Save failed real (non-setscene) tasks to uihelper's failed task list.
as before commit e8a3499c95a6d4f2b8fed002fb9504733c5be3c6. Currently
this list is only used by the ncurses UI.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/uihelper.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/uihelper.py b/bitbake/lib/bb/ui/uihelper.py
index 4116dab..03fac59 100644
--- a/bitbake/lib/bb/ui/uihelper.py
+++ b/bitbake/lib/bb/ui/uihelper.py
@@ -32,8 +32,13 @@ class BBUIHelper:
         if isinstance(event, bb.build.TaskSucceeded):
             del self.running_tasks[event.pid]
             self.needUpdate = True
-        if isinstance(event, bb.build.TaskFailed) or isinstance(event, bb.build.TaskFailedSilent):
+        if isinstance(event, bb.build.TaskFailedSilent):
             del self.running_tasks[event.pid]
+            # Don't add to the failed tasks list since this is e.g. a setscene task failure
+            self.needUpdate = True
+        if isinstance(event, bb.build.TaskFailed):
+            del self.running_tasks[event.pid]
+            self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
             self.needUpdate = True
 
     def getTasks(self):
-- 
1.7.5.4



