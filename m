Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SMb7L-00059n-0z
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Apr 2012 10:28:59 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Apr 2012 01:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="92428144"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Apr 2012 01:19:22 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Apr 2012 16:16:10 +0800
Message-Id: <2bbdbdf903d6c80f54058bcb5edd8a1e6aa89d15.1335254750.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1335254750.git.dongxiao.xu@intel.com>
References: <cover.1335254750.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1335254750.git.dongxiao.xu@intel.com>
References: <cover.1335254750.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/3] event.py: Add SanityCheck and SanityCheckPassed events
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
X-List-Received-Date: Tue, 24 Apr 2012 08:28:59 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/event.py |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index bbece58..f3fb521 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -517,3 +517,13 @@ class PackageInfo(Event):
     def __init__(self, pkginfolist):
         Event.__init__(self)
         self._pkginfolist = pkginfolist
+
+class SanityCheck(Event):
+    """
+    Event to issue sanity check
+    """
+
+class SanityCheckPassed(Event):
+    """
+    Event to indicate sanity check is passed
+    """
-- 
1.7.4.1



