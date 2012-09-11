Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TBOPc-0002kR-1P
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Sep 2012 13:13:48 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 11 Sep 2012 04:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,404,1344236400"; d="scan'208";a="191332387"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.164])
	by azsmga001.ch.intel.com with ESMTP; 11 Sep 2012 04:00:11 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Sep 2012 12:00:05 +0100
Message-Id: <1347361205-9711-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: format error messages properly
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
X-List-Received-Date: Tue, 11 Sep 2012 11:13:48 -0000

Error messages that use arguments need to be formatted properly, or we
don't get the full message. Use a formatter to do this when an error
occurs.

Partial fix for [YOCTO #2983].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index dac2f74..35cbded 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -177,7 +177,9 @@ class HobHandler(gobject.GObject):
 
         elif isinstance(event, logging.LogRecord):
             if event.levelno >= logging.ERROR:
-                self.error_msg += event.msg + '\n'
+                formatter = bb.msg.BBLogFormatter()
+                formatter.format(event)
+                self.error_msg += event.message + '\n'
 
         elif isinstance(event, bb.event.TargetsTreeGenerated):
             self.current_phase = "data generation"
-- 
1.7.9.5



