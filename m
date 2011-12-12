Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RZvz7-0002jO-QB
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Dec 2011 03:51:21 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 11 Dec 2011 18:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="86091130"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.46])
	by orsmga002.jf.intel.com with ESMTP; 11 Dec 2011 18:43:19 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Dec 2011 10:20:28 +0800
Message-Id: <532763584ebf309364cf79edba1429b25df12469.1323656120.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
Subject: [PATCH 09/10] cooker: remove command import in cooker.py
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
X-List-Received-Date: Mon, 12 Dec 2011 02:51:22 -0000

There is no direct use of command in cooker.py, and it is using
bb.command instead. Remove command in the import list.

This fixes a problem of embedded import between command.py and
cooker.py.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/cooker.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9f05d35..c9ea53a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -34,8 +34,8 @@ from cStringIO import StringIO
 from contextlib import closing
 from functools import wraps
 from collections import defaultdict
-import bb, bb.exceptions
-from bb import utils, data, parse, event, cache, providers, taskdata, command, runqueue
+import bb, bb.exceptions, bb.command
+from bb import utils, data, parse, event, cache, providers, taskdata, runqueue
 
 logger      = logging.getLogger("BitBake")
 collectlog  = logging.getLogger("BitBake.Collection")
-- 
1.7.0.4



