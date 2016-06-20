Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 7FD426FF78
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 11:01:50 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 20 Jun 2016 04:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,498,1459839600"; d="scan'208";a="991300624"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2016 04:01:51 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 4BA536A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 04:01:49 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2016 14:00:50 +0300
Message-Id: <39e7f6e72eae6b2019a202306c7df3b74a02705d.1466419987.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 3/5] cooker: don't remove event file
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 20 Jun 2016 11:01:51 -0000

There is no need to remove output file as it gets rewritten by
open(self.eventfile, 'w') anyway.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2de6b3e..ca53ff4 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -131,12 +131,6 @@ class EventLogWriteHandler:
             self.event_queue = []
 
         def init_file(self):
-            try:
-                # delete the old log
-                os.remove(self.eventfile)
-            except:
-                pass
-
             # write current configuration data
             with open(eventfile, "w") as f:
                 f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
-- 
2.1.4


