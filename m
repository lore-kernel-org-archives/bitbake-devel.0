Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 709897704F
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 09:43:23 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 05 Oct 2015 02:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,637,1437462000"; d="scan'208";a="784630398"
Received: from blynch-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.31])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2015 02:43:23 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Oct 2015 10:43:13 +0100
Message-Id: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1444038048.git.elliot.smith@intel.com>
References: <cover.1444038048.git.elliot.smith@intel.com>
Subject: [PATCH 1/6] event: add new property to BuildBase class
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
X-List-Received-Date: Mon, 05 Oct 2015 09:43:24 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added 'task' property to the base class of BuildStarted and
BuildCompleted classes to store bitbake task if it's specified.

This is done as without task Build* events can't fully represent
bitbake build. Task information is needed by UI classes to properly
show or process Build* events.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/event.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 366bc41..68496e5 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -331,6 +331,7 @@ class BuildBase(Event):
     def __init__(self, n, p, failures = 0):
         self._name = n
         self._pkgs = p
+        self._task = None
         Event.__init__(self)
         self._failures = failures
 
@@ -352,6 +353,12 @@ class BuildBase(Event):
     def setCfg(self, cfg):
         self.data = cfg
 
+    def getTask(self):
+        return self._task
+
+    def setTask(self, task):
+        self._task = task
+
     def getFailures(self):
         """
         Return the number of failed packages
@@ -361,6 +368,7 @@ class BuildBase(Event):
     pkgs = property(getPkgs, setPkgs, None, "pkgs property")
     name = property(getName, setName, None, "name property")
     cfg = property(getCfg, setCfg, None, "cfg property")
+    task = property(getTask, setTask, None, "task property")
 
 
 
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


