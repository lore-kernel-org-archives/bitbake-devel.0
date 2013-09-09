Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 3A7B66BFA0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:09 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Sep 2013 09:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="375589057"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 09 Sep 2013 09:41:10 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 7D7E55608B2; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:40:57 +0100
Message-Id: <4509f2ed87581c11ff26c10586f37516b4766503.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 06/13] bitbake: build: add link to logfile for Task events
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:09 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add a pointer to the logfile for Task events, so
that we can trace that in the Bitbake database

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/build.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 1265bdc..4abbe48 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -73,6 +73,7 @@ class TaskBase(event.Event):
         self._task = t
         self._package = d.getVar("PF", True)
         self._file = d.getVar("FILE", True)
+        self.logfile = d.getVar("BB_LOGFILE", True)
         self.taskfile = self._file
         self.taskname = self._task
         event.Event.__init__(self)
-- 
1.8.1.2


