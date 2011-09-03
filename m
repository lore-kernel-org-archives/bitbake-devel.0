Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qze0Z-0008Rq-2H
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Sep 2011 02:22:51 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Sep 2011 17:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,321,1312182000"; d="scan'208";a="47755009"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.9])
	by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2011 17:17:50 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Sep 2011 17:17:40 -0700
Message-Id: <f563355b43ffd64df3bf0f396945659c5f319d77.1315008498.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
Subject: [PATCH 5/6] ui/crumbs/runningbuild: mask run_buildstats failure
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
X-List-Received-Date: Sat, 03 Sep 2011 00:22:51 -0000

The buildstats handler causes an exception with: "'NoneType' object has no
attribute 'startswith'" early a build via hob, leaving a glaring red row
which means nothing to the user.
Mask this error until such a time as we have opportunity to correctly
diagnose and fix the root problem.

Workaround fix for [YOCTO #1433]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/runningbuild.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index 97d1ebd..247ed5d 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -91,6 +91,12 @@ class RunningBuild (gobject.GObject):
             parent = self.tasks_to_iter[(package, task)]
 
         if(isinstance(event, logging.LogRecord)):
+            # FIXME: this is a hack! More info in Yocto #1433
+            # http://bugzilla.pokylinux.org/show_bug.cgi?id=1433, temporarily
+            # mask the error message as it's not informative for the user.
+            if event.msg.startswith("Execution of event handler 'run_buildstats' failed"):
+                return
+
             if (event.levelno < logging.INFO or
                 event.msg.startswith("Running task")):
                 return # don't add these to the list
-- 
1.7.6



