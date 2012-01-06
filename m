Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj5mM-0007NG-Ia
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:08:02 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 06 Jan 2012 01:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="93581561"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by orsmga001.jf.intel.com with ESMTP; 06 Jan 2012 01:00:37 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2012 17:02:21 +0800
Message-Id: <7f993ecf6ca80c9b68d47d8c450772313159a394.1325840050.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
Subject: [PATCH 03/16] cooker: user bb.configuration.data to inject events
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
X-List-Received-Date: Fri, 06 Jan 2012 09:08:02 -0000

For buildTargets function, we use bb.configuration.data as parameter
to inject events, since in hob environment, some variables are
modified dynamically and bb.configuration.event_data may out of date.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/cooker.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b33e9ff..fe44839 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1089,7 +1089,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(buildname, targets, failures), self.configuration.event_data)
+                bb.event.fire(bb.event.BuildCompleted(buildname, targets, failures), self.configuration.data)
                 self.command.finishAsyncCommand()
                 return False
             if retval is True:
@@ -1099,7 +1099,7 @@ class BBCooker:
         self.buildSetVars()
 
         buildname = self.configuration.data.getVar("BUILDNAME")
-        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.event_data)
+        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.data)
 
         localdata = data.createCopy(self.configuration.data)
         bb.data.update_data(localdata)
-- 
1.7.0.4



