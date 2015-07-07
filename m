Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id DDAED75D3E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 17:50:47 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 07 Jul 2015 10:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,425,1432623600"; d="scan'208";a="742336490"
Received: from yctb05.ostc.intel.com (HELO yctb05.otcr.jf.intel.com)
	([10.23.219.54])
	by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2015 10:50:47 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jul 2015 09:46:00 +0000
Message-Id: <d0a879dfb13ac7c52a39ef41ccaa51ae4b6c4957.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
References: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
In-Reply-To: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
References: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
Subject: [PATCH 2/3] command.py: Unlock function included into CommandsSync class
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
X-List-Received-Date: Tue, 07 Jul 2015 17:50:48 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

Function which calls cooker's unlock method, which in turn unlocks bitbake.lock
file.

Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
---
 bitbake/lib/bb/command.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 24ff341..2b02584 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -267,6 +267,12 @@ class CommandsSync:
         features = params[0]
         command.cooker.setFeatures(features)
 
+    def unlockBitbake(self, command, params):
+        """
+        Unlock bitbake.lock file
+        """
+        command.cooker.unlockBitbake()
+
     # although we change the internal state of the cooker, this is transparent since
     # we always take and leave the cooker in state.initial
     setFeatures.readonly = True
-- 
1.8.4.5


