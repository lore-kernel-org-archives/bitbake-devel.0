Return-Path: <brian.avery@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 2D3C671A9C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Oct 2016 00:07:26 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 05 Oct 2016 17:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,451,1473145200"; d="scan'208";a="1040898348"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2016 17:07:27 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Oct 2016 17:08:50 -0700
Message-Id: <00a1388bcb4c2ae9f7d1fdc57a8c532e241a8c00.1475712223.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9be76de394b4a43c7dc6326545b33e2ee25b50e2.1475712223.git.brian.avery@intel.com>
References: <9be76de394b4a43c7dc6326545b33e2ee25b50e2.1475712223.git.brian.avery@intel.com>
In-Reply-To: <cover.1475712223.git.brian.avery@intel.com>
References: <cover.1475712223.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 2/6] toaster: buildinfohelper: Use correct way to get message from LogMessage
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
X-List-Received-Date: Thu, 06 Oct 2016 00:07:26 -0000

From: Michael Wood <michael.g.wood@intel.com>

Use the correct method to get a message value from the LogMessage object
rather than constructing it ourselves which is not recommended. This
causes an exception when the msg contains a '%' such as when there are
wildcards in file names (something2.%.bbappends)

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 970a941..5b69660 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1565,16 +1565,12 @@ class BuildInfoHelper(object):
         mockevent.lineno = -1
         self.store_log_event(mockevent)
 
-
     def store_log_event(self, event):
         self._ensure_build()
 
         if event.levelno < formatter.WARNING:
             return
 
-        if 'args' in vars(event):
-            event.msg = event.msg % event.args
-
         # early return for CLI builds
         if self.brbe is None:
             if not 'backlog' in self.internal_state:
@@ -1586,7 +1582,8 @@ class BuildInfoHelper(object):
             # if we have a backlog of events, do our best to save them here
             if len(self.internal_state['backlog']):
                 tempevent = self.internal_state['backlog'].pop()
-                logger.debug(1, "buildinfohelper: Saving stored event %s " % tempevent)
+                logger.debug(1, "buildinfohelper: Saving stored event %s "
+                             % tempevent)
                 self.store_log_event(tempevent)
             else:
                 logger.info("buildinfohelper: All events saved")
@@ -1605,7 +1602,7 @@ class BuildInfoHelper(object):
         else:
             log_information['level'] = LogMessage.INFO
 
-        log_information['message'] = event.msg
+        log_information['message'] = event.getMessage()
         log_information['pathname'] = event.pathname
         log_information['lineno'] = event.lineno
         logger.info("Logging error 2: %s", log_information)
-- 
1.9.1


