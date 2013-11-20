Return-Path: <seebs@msp-lpggp2.wrs.com>
Received: from msp-lpggp2.wrs.com (unknown [206.144.70.9])
	by mail.openembedded.org (Postfix) with ESMTP id 329CD6D4FE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 00:30:20 +0000 (UTC)
Received: by msp-lpggp2.wrs.com (Postfix, from userid 508)
	id E1B9BA02E70; Tue, 19 Nov 2013 18:31:40 -0600 (CST)
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Nov 2013 18:31:40 -0600
Message-Id: <a85ab002cac4c7fe0881a8fd73fe6011dbddcff8.1384907121.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1384907121.git.peter.seebach@windriver.com>
References: <cover.1384907121.git.peter.seebach@windriver.com>
In-Reply-To: <cover.1384907121.git.peter.seebach@windriver.com>
References: <cover.1384907121.git.peter.seebach@windriver.com>
Subject: [PATCH 2/2] data_smart.py: Add isTracking() to datasmart
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
X-List-Received-Date: Wed, 20 Nov 2013 00:30:20 -0000

It would be awesome to have "bitbake -e" work even when sanity failures
occur. But you can't do that if you can't tell whether tracking is
enabled. We add a trivial accessor.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/data_smart.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index a1cbaba..4ff2717 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -309,6 +309,9 @@ class DataSmart(MutableMapping):
     def disableTracking(self):
         self._tracking = False
 
+    def isTracking(self):
+        return self._tracking
+
     def expandWithRefs(self, s, varname):
 
         if not isinstance(s, basestring): # sanity check
-- 
1.7.1


