Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RgHBk-0003pu-8K
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Dec 2011 15:42:36 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 29 Dec 2011 06:34:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="92602243"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.61])
	by orsmga002.jf.intel.com with ESMTP; 29 Dec 2011 06:34:14 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Dec 2011 14:34:12 +0000
Message-Id: <1325169252-7588-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH] bitbake-layers: fix Python error during parse
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
X-List-Received-Date: Thu, 29 Dec 2011 14:42:36 -0000

If "bitbake-layers show_layers" was run when the cache was dirty forcing
a parse, it failed with the following error:

ERROR: Failure expanding variable SRCPV, expression was
${@bb.fetch2.get_srcrev(d)} which triggered exception AttributeError:
'module' object has no attribute 'fetch2'

A simple import of bb.fetch2 in bitbake-layers fixes this.

Fixes [YOCTO #1855].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 119b15c..b2781bb 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -18,6 +18,7 @@ import bb.cooker
 import bb.providers
 import bb.utils
 from bb.cooker import state
+import bb.fetch2
 
 
 logger = logging.getLogger('BitBake')
-- 
1.7.5.4



