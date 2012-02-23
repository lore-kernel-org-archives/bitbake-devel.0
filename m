Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0ZAY-0000dv-Iz
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 14:57:14 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Feb 2012 05:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="111194908"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 23 Feb 2012 05:48:51 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 21:47:20 +0800
Message-Id: <f12419b3cecd0e05b7df69709cb14dc23dd67a28.1330003017.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1330003017.git.dongxiao.xu@intel.com>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1330003017.git.dongxiao.xu@intel.com>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
Subject: [PATCH 8/9] command.py: Add a new API triggerEvent()
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
X-List-Received-Date: Thu, 23 Feb 2012 13:57:14 -0000

This functions enables the client to request triggering specific event
from bitbake server.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 43875f7..06e8869 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -179,6 +179,12 @@ class CommandsSync:
         """
         return bb.utils.cpu_count()
 
+    def triggerEvent(self, command, params):
+        """
+        Trigger a certain event
+        """
+        event = params[0]
+        bb.event.fire(eval(event), command.cooker.configuration.data)
 
 class CommandsAsync:
     """
-- 
1.7.4.1



