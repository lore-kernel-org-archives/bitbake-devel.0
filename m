Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RZvyw-0002e0-Mf
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Dec 2011 03:51:11 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 11 Dec 2011 18:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="101102167"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.46])
	by fmsmga002.fm.intel.com with ESMTP; 11 Dec 2011 18:43:10 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Dec 2011 10:20:22 +0800
Message-Id: <c964cfa4b7bcde985223d41f7bd00937544bc791.1323656120.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
Subject: [PATCH 03/10] cooker: user bb.configuration.data to inject events
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
X-List-Received-Date: Mon, 12 Dec 2011 02:51:11 -0000

For buildTargets function, we use bb.configuration.data as parameter
to inject events, since in hob environment, some variables are
modified dynamically and bb.configuration.event_data may out of date.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/cooker.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2c02e28..6ddb38e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1085,7 +1085,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(buildname, targets, failures), self.configuration.event_data)
+                bb.event.fire(bb.event.BuildCompleted(buildname, targets, failures), self.configuration.data)
                 self.command.finishAsyncCommand()
                 return False
             if retval is True:
@@ -1095,7 +1095,7 @@ class BBCooker:
         self.buildSetVars()
 
         buildname = self.configuration.data.getVar("BUILDNAME")
-        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.event_data)
+        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.data)
 
         localdata = data.createCopy(self.configuration.data)
         bb.data.update_data(localdata)
-- 
1.7.0.4



