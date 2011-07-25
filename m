Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlQJp-0005y1-S2
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 20:55:58 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,264,1309762800"; d="scan'208";a="29903199"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 11:56:10 -0700
Message-Id: <2ef4e2ace742eceab7b04062140c18ec6401f4cc.1311620081.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311620081.git.josh@linux.intel.com>
References: <cover.1311620081.git.josh@linux.intel.com>
In-Reply-To: <cover.1311620081.git.josh@linux.intel.com>
References: <cover.1311620081.git.josh@linux.intel.com>
Subject: [PATCH 2/4] bitbake-layers: adapt to cooker change for saved environment
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
X-List-Received-Date: Mon, 25 Jul 2011 18:55:58 -0000

The Cooker requires a copy of the environment mapping, modify
bitbake-layers to take one and pass it to the cooker.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 bin/bitbake-layers |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 3d563b5..d9f95d1 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -8,7 +8,7 @@
 
 import cmd
 import logging
-import os.path
+import os
 import sys
 
 bindir = os.path.dirname(__file__)
@@ -41,11 +41,12 @@ def main(args):
 class Commands(cmd.Cmd):
     def __init__(self):
         cmd.Cmd.__init__(self)
-
+        initialenv = os.environ.copy()
         self.returncode = 0
         self.config = Config(parse_only=True)
         self.cooker = bb.cooker.BBCooker(self.config,
-                                         self.register_idle_function)
+                                         self.register_idle_function,
+                                         initialenv)
         self.config_data = self.cooker.configuration.data
         bb.providers.logger.setLevel(logging.ERROR)
         self.cooker_data = None
-- 
1.7.6



