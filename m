Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 790216014F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Mar 2016 12:54:13 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 30 Mar 2016 05:54:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,416,1455004800"; d="scan'208";a="677971546"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2016 05:54:03 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 Mar 2016 15:54:00 +0300
Message-Id: <1459342440-562-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.2
Subject: [PATCH] cooker: fix CookerParser.shutdown()
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
X-List-Received-Date: Wed, 30 Mar 2016 12:54:17 -0000

Prevent a hang when shutdown() is called during parsing (e.g. after
SIGINT). We must not append 'None' to the jobs queue. Otherwise the
worker loop inside Parser.realrun() may break out at the wrong point,
causing the results queue thread blocking bitbake indefinitely.

[YOCTO #9319]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/cooker.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 96cefc7..de395b3 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2063,7 +2063,6 @@ class CookerParser(object):
             bb.event.fire(event, self.cfgdata)
             self.feeder_quit.put(None)
             for process in self.processes:
-                self.jobs.put(None)
                 self.parser_quit.put(None)
         else:
             self.feeder_quit.put('cancel')
-- 
2.6.2


