Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 0F8E277261
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 11:27:51 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga105.jf.intel.com with ESMTP; 05 Sep 2016 04:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,286,1470726000"; d="scan'208";a="1051583688"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2016 04:27:51 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 5AE796A4080;
	Mon,  5 Sep 2016 04:27:30 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 14:27:35 +0300
Message-Id: <1473074855-6503-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] cooker: record events on cooker exit
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
X-List-Received-Date: Mon, 05 Sep 2016 11:27:53 -0000

Bitbake collects all events in special event queue when called with
-w option. However, it starts to write events to the eventlog only
after BuildStarted event is received. In some cases this event is
not received at all, e.g. when bitbake is run with --parse-only
command line option.

It makes sense to write all collected events when CookerExit event
received to make sure all events are written into the eventlog even
if BuildStarted event is not fired.

[YOCTO #10145]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index b7d7a7e..0e78106 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -141,7 +141,7 @@ class EventWriter:
         else:
             # init on bb.event.BuildStarted
             name = "%s.%s" % (event.__module__, event.__class__.__name__)
-            if name == "bb.event.BuildStarted":
+            if name in ("bb.event.BuildStarted", "bb.cooker.CookerExit"):
                 with open(self.eventfile, "w") as f:
                     f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
 
-- 
2.1.4


