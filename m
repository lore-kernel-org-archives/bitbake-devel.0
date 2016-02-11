Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 3689C7321C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Feb 2016 12:46:43 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP; 11 Feb 2016 04:46:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,430,1449561600"; d="scan'208";a="882021198"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 11 Feb 2016 04:46:43 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 68FF46A4004;
	Thu, 11 Feb 2016 05:34:34 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Feb 2016 12:37:08 +0200
Message-Id: <1455187028-27370-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] cooker: gracefully shutdown parsers
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
X-List-Received-Date: Thu, 11 Feb 2016 12:46:44 -0000

CookerParser.shutdown code doesn't do all required work to shutdown
parser processes. As a result bitbake hangs if interrupted during
parsing. Putting None into the parser_quit queue should fix this issue
as it makes parsers to quit main loop.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index af3d77b..43e9f18 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -2058,6 +2058,7 @@ class CookerParser(object):
             self.feeder_quit.put(None)
             for process in self.processes:
                 self.jobs.put(None)
+                self.parser_quit.put(None)
         else:
             self.feeder_quit.put('cancel')
 
-- 
2.1.4


