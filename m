Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S37aA-0007ri-2I
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 16:06:14 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 01 Mar 2012 06:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123711566"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.90])
	by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2012 06:57:42 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Mar 2012 14:57:37 +0000
Message-Id: <f5b6668030bf41a2c49de845dcda3bf91d66eae0.1330613733.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330613733.git.paul.eggleton@linux.intel.com>
References: <cover.1330613733.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1330613733.git.paul.eggleton@linux.intel.com>
References: <cover.1330613733.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] bitbake/build: report TaskFailedSilent events as "Failed"
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
X-List-Received-Date: Thu, 01 Mar 2012 15:06:14 -0000

The change for setscene events to fire a TaskFailedSilent event instead
of TaskFailed resulted in "FailedSilent" being reported in the task
finish note log entry, which is not really desirable, so change it back
to reporting "Failed" again.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/build.py |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index e390bec..a9b40e7 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -72,7 +72,7 @@ class TaskBase(event.Event):
         self._task = t
         self._package = d.getVar("PF", 1)
         event.Event.__init__(self)
-        self._message = "package %s: task %s: %s" % (d.getVar("PF", 1), t, bb.event.getName(self)[4:])
+        self._message = "package %s: task %s: %s" % (d.getVar("PF", 1), t, self.getDisplayName())
 
     def getTask(self):
         return self._task
@@ -80,6 +80,9 @@ class TaskBase(event.Event):
     def setTask(self, task):
         self._task = task
 
+    def getDisplayName(self):
+        return bb.event.getName(self)[4:]
+
     task = property(getTask, setTask, None, "task property")
 
 class TaskStarted(TaskBase):
@@ -102,6 +105,10 @@ class TaskFailedSilent(TaskBase):
         self.logfile = logfile
         super(TaskFailedSilent, self).__init__(task, metadata)
 
+    def getDisplayName(self):
+        # Don't need to tell the user it was silent
+        return "Failed"
+
 class TaskInvalid(TaskBase):
 
     def __init__(self, task, metadata):
-- 
1.7.5.4



