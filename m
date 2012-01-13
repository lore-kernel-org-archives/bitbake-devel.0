Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RlccE-0002PY-Gt
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 09:36:02 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 13 Jan 2012 00:28:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="95425197"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by azsmga001.ch.intel.com with ESMTP; 13 Jan 2012 00:28:31 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 16:30:42 +0800
Message-Id: <344db22aba86cb665c3318d32655047c00eb6c6c.1326442655.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1326442655.git.dongxiao.xu@intel.com>
References: <cover.1326442655.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1326442655.git.dongxiao.xu@intel.com>
References: <cover.1326442655.git.dongxiao.xu@intel.com>
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
X-List-Received-Date: Fri, 13 Jan 2012 08:36:03 -0000

This functions enables the client to request triggering specific event
from bitbake server.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 43875f7..a2c464f 100644
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
+        bb.event.fire(event, command.cooker.configuration.data)
 
 class CommandsAsync:
     """
-- 
1.7.0.4



